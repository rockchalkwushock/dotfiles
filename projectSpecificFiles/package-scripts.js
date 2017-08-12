const npsUtils = require('nps-utils')

const { concurrent, crossEnv, rimraf, series } = npsUtils

module.exports = {
  scripts: {
    build: {
      description: 'Building in production environment.',
      default: `${crossEnv('NODE_ENV=production')} rollup -c`,
      andTest: {
        description: 'Run production build & test the output bundles.',
        script: series.nps('build', 'test.build.coverage')
      },
      dev: {
        description: 'Building in development environment.',
        script: `${crossEnv('NODE_ENV=development')} rollup -c`
      }
    },
    clean: series(
      rimraf('.next'),
      rimraf('coverage'),
      rimraf('dist'),
      rimraf('es'),
      rimraf('lib'),
      rimraf('package'),
      rimraf('*.tgz')
    ),
    commit: 'git cz',
    contributors: {
      add: 'all-contributors add',
      generate: 'all-contributors generate'
    },
    default: 'nps',
    flow: 'flow check',
    lint: {
      // TODO: Add targets for eslint.
      default: 'eslint',
      fix: series.nps('lint --fix')
    },
    release: series(
      'semantic-release pre',
      'npm publish',
      'semantic-release post'
    ),
    reportCoverage: 'codecov',
    test: {
      default:
        'jest __tests__/pre-build/*.test.js --config jest.config.json --runInBand',
      build: {
        default:
          'jest __tests__/post-build/*.test.js --config jest.config.json --runInBand',
        coverage: series.nps('test.build --coverage --silent')
      },
      coverage: series.nps('test --coverage --silent'),
      watch: series.nps('test --watch')
    },
    validate: {
      default: concurrent.nps('lint', 'flow'),
      withCoverage: concurrent.nps('validate', 'test.coverage')
    }
  }
}

const npsUtils = require('nps-utils')

const { rimraf, series, concurrent } = npsUtils

module.exports = {
  scripts: {
    clean: {
      description: 'Clean repository of generated directories & files.',
      // TODO: Add directories or files for removing: rimraf('build')
      script: series(rimraf('.next'), rimraf('coverage'))
    },
    commit: {
      description: 'Run commitizen-cli for creating clean commit messages.',
      script: 'git cz'
    },
    lint: {
      description: 'Lint code base.',
      // TODO: Update directories to lint.
      default: 'eslint __tests__ components lib pages',
      fix: {
        description: 'Lint & fix errors.',
        script: series.nps('lint --fix')
      }
    },
    reportCoverage: {
      description: 'Send coverage data to third party.',
      // TODO: Update for third-party coverage reporter.
      script: 'codecov'
    },
    test: {
      description: 'Run Jest test suite on code base.',
      default: 'jest --config jest.config.json --runInBand',
      coverage: {
        description: 'Generate coverage data.',
        script: series.nps('test --coverage --silent')
      },
      watch: {
        description: 'Watch test suite.',
        script: series.nps('test --watch')
      }
    },
    validate: {
      description: 'Validate code base against linting & tests.',
      default: concurrent.nps('lint', 'test'),
      withCoverage: {
        description: 'Validate code & output coverage data.',
        script: concurrent.nps('lint', 'test.coverage')
      }
    }
  }
}


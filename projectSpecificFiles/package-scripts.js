const npsUtils = require('nps-utils')

const { concurrent, rimraf, series } = npsUtils

module.exports = {
  scripts: {
    // TODO: Add any other directories or files for cleaning.
    clean: series(rimraf('coverage')),
    commit: 'git cz',
    /**
     * TODO: Utilize this key for running 'yarn start' or 'npm start'
     * as normal scripts (i.e. nodemon index.js)
     * By doing this now running 'yarn start' clean will yield:
     * - nps clean
     * Where as 'yarn start' will yield:
     * - nodemon index.js
     */
    default: 'nps',
    lint: {
      // TODO: Add targets for eslint.
      default: 'eslint',
      fix: series.nps('lint --fix')
    },
    reportCoverage: 'codecov',
    test: {
      default: 'jest --config jest.config.json --runInBand',
      coverage: series.nps('test --coverage --silent'),
      watch: series.nps('test --watch')
    },
    validate: {
      default: concurrent.nps('lint', 'test'),
      withCoverage: concurrent.nps('lint', 'test.coverage')
    }
  }
}

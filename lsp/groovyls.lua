local PROJECT_HOME = vim.env.HOME .. '/Projects'

---@type vim.lsp.Config
return {
  cmd = { 'java', '-jar', PROJECT_HOME .. '/groovy-language-server/build/libs/groovy-language-server-all.jar' },
  filetypes = { 'groovy', 'Jenkinsfile' },
  root_dir = function(_, on_dir)
    on_dir(vim.fn.getcwd())
  end,
  settings = {
    groovy = {
      classpath = {
        '/Users/brian.shacklett/.gradle/caches/modules-2/files-2.1/junit/junit/4.13/e49ccba652b735c93bd6e6f59760d8254cf597dd/junit-4.13.jar',
        '/Users/brian.shacklett/.gradle/caches/modules-2/files-2.1/org.codehaus.groovy/groovy-all/2.4.12/760afc568cbd94c09d78f801ce51aed1326710af/groovy-all-2.4.12.jar',
        '/Users/brian.shacklett/.gradle/caches/modules-2/files-2.1/com.lesfurets/jenkins-pipeline-unit/1.1/afb0fd02143e5d5127ff6187b4403a3cf0b890a0/jenkins-pipeline-unit-1.1.jar',
        '/Users/brian.shacklett/.gradle/caches/modules-2/files-2.1/com.cyrusinnovation/mockito-groovy-support/1.3/f091c62bf29c03eed8577db01f137a5cf9cd255c/mockito-groovy-support-1.3.jar',
        '/Users/brian.shacklett/.gradle/caches/modules-2/files-2.1/org.junit.jupiter/junit-jupiter-api/5.7.0/b25f3815c4c1860a73041e733a14a0379d00c4d5/junit-jupiter-api-5.7.0.jar',
        '/Users/brian.shacklett/.gradle/caches/modules-2/files-2.1/org.hamcrest/hamcrest/2.2/1820c0968dba3a11a1b30669bb1f01978a91dedc/hamcrest-2.2.jar',
        '/Users/brian.shacklett/.gradle/caches/modules-2/files-2.1/org.reflections/reflections/0.9.12/1c9d44c563eebe9b8a3afebd29ed5c4646db800c/reflections-0.9.12.jar',
        '/Users/brian.shacklett/.gradle/caches/modules-2/files-2.1/org.slf4j/slf4j-api/1.7.30/b5a4b6d16ab13e34a88fae84c35cd5d68cac922c/slf4j-api-1.7.30.jar',
        '/Users/brian.shacklett/.gradle/caches/modules-2/files-2.1/com.cloudbees/groovy-cps/1.12/d766273a59e0b954c016e805779106bca22764b9/groovy-cps-1.12.jar',
        '/Users/brian.shacklett/.gradle/caches/modules-2/files-2.1/commons-io/commons-io/2.5/2852e6e05fbb95076fc091f6d1780f1f8fe35e0f/commons-io-2.5.jar',
        '/Users/brian.shacklett/.gradle/caches/modules-2/files-2.1/org.apache.ivy/ivy/2.4.0/5abe4c24bbe992a9ac07ca563d5bd3e8d569e9ed/ivy-2.4.0.jar',
        '/Users/brian.shacklett/.gradle/caches/modules-2/files-2.1/org.assertj/assertj-core/3.4.1/536893abdf1ce11f72c1e4483a88e94d6ba80005/assertj-core-3.4.1.jar',
        '/Users/brian.shacklett/.gradle/caches/modules-2/files-2.1/org.mockito/mockito-all/1.9.5/79a8984096fc6591c1e3690e07d41be506356fa5/mockito-all-1.9.5.jar',
        '/Users/brian.shacklett/.gradle/caches/modules-2/files-2.1/org.junit.platform/junit-platform-commons/1.7.0/84e309fbf21d857aac079a3c1fffd84284e1114d/junit-platform-commons-1.7.0.jar',
        '/Users/brian.shacklett/.gradle/caches/modules-2/files-2.1/org.apiguardian/apiguardian-api/1.1.0/fc9dff4bb36d627bdc553de77e1f17efd790876c/apiguardian-api-1.1.0.jar',
        '/Users/brian.shacklett/.gradle/caches/modules-2/files-2.1/org.opentest4j/opentest4j/1.2.0/28c11eb91f9b6d8e200631d46e20a7f407f2a046/opentest4j-1.2.0.jar',
        '/Users/brian.shacklett/.gradle/caches/modules-2/files-2.1/org.javassist/javassist/3.26.0-GA/bb2890849968d8d8311ffba8c37b0ce16ce284dc/javassist-3.26.0-GA.jar',
        '/Users/brian.shacklett/.gradle/caches/modules-2/files-2.1/com.google.guava/guava/11.0.1/57b40a943725d43610c898ac0169adf1b2d55742/guava-11.0.1.jar',
        '/Users/brian.shacklett/.gradle/caches/modules-2/files-2.1/com.google.code.findbugs/jsr305/1.3.9/40719ea6961c0cb6afaeb6a921eaa1f6afd4cfdf/jsr305-1.3.9.jar',
        '/Users/brian.shacklett/.gradle/caches/modules-2/files-2.1/org.junit.jupiter/junit-jupiter-engine/5.7.0/d9044d6b45e2232ddd53fa56c15333e43d1749fd/junit-jupiter-engine-5.7.0.jar',
        '/Users/brian.shacklett/.gradle/caches/modules-2/files-2.1/org.junit.platform/junit-platform-engine/1.7.0/eadb73c5074a4ac71061defd00fc176152a4d12c/junit-platform-engine-1.7.0.jar',
      },
    },
  },
}

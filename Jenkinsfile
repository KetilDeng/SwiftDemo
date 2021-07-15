Jenkinsfile (Declarative Pipeline)
pipeline {
    agent any

    stages {
        stage('编译') {
            steps {
                echo 'Building..'
            }
        }
        stage('测试') {
            steps {
                echo 'Testing..'
            }
        }
        stage('发布') {
            steps {
                echo 'Deploying....'
            }
        }
    }
}


// pipeline {
//     options {
//         buildDiscarder(logRotator(numToKeepStr: '7', artifactNumToKeepStr: '10', daysToKeepStr: '5'))
//         timeout(time: 12, unit: 'MINUTES')
//         disableConcurrentBuilds()
//     }
//     agent {
//         label 'master'
//     }
//     environment {
//         JOB_NAME = 'demo_pipeline'
//     }
//     stages {
//         stage('pipeline环境准备') {
//             steps {
//                 script {
//                     echo "开始构建"
//                     if(!env.BRANCH_NAME.startsWith('feature-') && !env.BRANCH_NAME.startsWith('release-')){
//                         error("自动构建分支名称必须以feature-或release-开头，当前分支名称为: ${env.BRANCH_NAME}")
//                     }
//                     if (env.BRANCH_NAME.startsWith('feature-') ) {
//                         env.env = "beta"
//                     }
//                     if (env.BRANCH_NAME.startsWith('release-')) {
//                         env.env = "stage"
//                     }
//                     sh "echo 当前分支 : ${env.BRANCH_NAME}"
//                     sh "echo 当前环境 : ${env.env}"
//                     sh "echo 当前提交 : ${env.commit}"
//                     sh "echo WORKSPACE : ${env.WORKSPACE}"
//                     sh "echo GIT_BRANCH : ${env.GIT_BRANCH}"
//                     sh "echo BUILD_NUMBER : ${env.BUILD_NUMBER}"
//                     sh "echo JOB_NAME : ${env.JOB_NAME}"
//                     sh "./mvnw -v"
//                     sh "java -version"
//                 }
//             }
//         }
//     }
// }


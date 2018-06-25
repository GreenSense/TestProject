pipeline {
    agent any
    stages {
        stage('Setup') {
            steps {
                cleanWs()
                sh "git config --add remote.origin.fetch +refs/heads/master:refs/remotes/origin/master"
                sh "git fetch --no-tags"
                sh 'git checkout $BRANCH_NAME'
                sh 'git pull origin $BRANCH_NAME'
                shHide( 'git remote set-url origin https://${GHTOKEN}@github.com/GreenSense/TestProject.git' )
                sh 'git config --global user.email "compulsivecoder@gmail.com"'
                sh 'git config --global user.name "CompulsiveCoder CI"'
            }
        }
        stage('Prepare') {
            when { expression { !shouldSkipBuild() } }
            steps {
                sh 'sh prepare.sh'
            }
        }
        stage('Init') {
            when { expression { !shouldSkipBuild() } }
            steps {
                sh 'sh init.sh'
            }
        }
        stage('Build') {
            when { expression { !shouldSkipBuild() } }
            steps {
                sh 'sh build.sh'
            }
        }
        stage('Test') {
            when { expression { !shouldSkipBuild() } }
            steps {
                sh 'sh test.sh'
            }
        }
        stage('Clean') {
            when { expression { !shouldSkipBuild() } }
            steps {
                sh 'sh clean.sh'
            }
        }
        stage('Graduate') {
            when { expression { !shouldSkipBuild() } }
            steps {
                sh 'sh graduate.sh'
            }
        }
        stage('Increment Version') {
            when { expression { !shouldSkipBuild() } }
            steps {
              sh 'sh increment-version.sh'
            }
        }
        stage('Push Version') {
            when { expression { !shouldSkipBuild() } }
            steps {
                sh 'sh push-version.sh'
            }
        }
    }
    post {
        success() {
          emailext (
              subject: "SUCCESSFUL: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]'",
              body: """<p>SUCCESSFUL: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]':</p>
                <p>Check console output at "<a href="${env.BUILD_URL}">${env.JOB_NAME} [${env.BUILD_NUMBER}]</a>"</p>""",
              recipientProviders: [[$class: 'DevelopersRecipientProvider']]
            )
          cleanWs()
        }
        failure() {
          sh 'sh rollback.sh'
          emailext (
              subject: "FAILED: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]'",
              body: """<p>FAILED: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]':</p>
                <p>Check console output at "<a href="${env.BUILD_URL}">${env.JOB_NAME} [${env.BUILD_NUMBER}]</a>"</p>""",
              recipientProviders: [[$class: 'DevelopersRecipientProvider']]
            )
          cleanWs()
        }
    }
}
Boolean shouldSkipBuild() {
    return sh( script: 'sh check-ci-skip.sh', returnStatus: true )
}
def shHide(cmd) {
    sh('#!/bin/sh -e\n' + cmd)
}
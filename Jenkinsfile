pipeline {
    agent { label 'master' }

    environment {
        SLACK_WEBHOOK = credentials('slack-decreebot-webhook')
    }

    stages {
        stage('Announce Decrees') {
            steps {
                sh 'bash scripts/post_decree.sh'
            }
        }
    }

    post {
        success {
            echo '✅ Decrees delivered to the Empire.'
        }
        failure {
            echo '⚠️ Decree delivery failed.'
        }
    }
}

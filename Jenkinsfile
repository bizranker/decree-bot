pipeline {
    agent {
        label 'master'
    }

    stages {
        stage('Send Decree') {
            steps {
                withCredentials([string(credentialsId: 'decreta_webhook', variable: 'DECREEBOT_WEBHOOK_URL')]) {
                    sh '''
                        chmod +x ./scripts/post_decree.sh
                        ./scripts/post_decree.sh
                    '''
                }
            }
        }
    }
}

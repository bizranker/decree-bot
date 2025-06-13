pipeline {
    agent {
        label 'master'
    }

    stages {
        stage('Send Decree') {
            steps {
                withCredentials([string(credentialsId: 'decree_webhook', variable: 'DECREEBOT_WEBHOOK_URL')]) {
                    sh '''
                        if [ -f .env ]; then
                            set -a
                            source .env
                            set +a
                        fi
                        chmod +x ./scripts/post_decree.sh
                        ./scripts/post_decree.sh
                    '''
                }
            }
        }
    }
}

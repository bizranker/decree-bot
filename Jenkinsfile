pipeline {
    agent {
        label 'master'
    }

    environment {
        // Priority: Jenkins credentials if set, otherwise .env will provide it
        WEBHOOK_URL = credentials('decree_webhook')
    }

    stages {
        stage('Send Decree') {
            steps {
                script {
                    // Load .env manually for local/dev compatibility
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

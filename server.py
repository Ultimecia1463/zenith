import os
import subprocess
from flask import Flask, render_template, Response

app = Flask(__name__)

@app.route('/')
def home():
    return render_template('index.html')  # Render the HTML page

def run_command(command):
    """ Run a shell command and stream the output in real-time """
    process = subprocess.Popen(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, bufsize=1, universal_newlines=True)
    
    # Stream the stdout and stderr
    for stdout_line in process.stdout:
        yield f"data: {stdout_line}\n\n"
    
    for stderr_line in process.stderr:
        yield f"data: {stderr_line}\n\n"
    
    process.stdout.close()
    process.stderr.close()
    process.wait()

@app.route('/build', methods=['POST'])
def build():
    # Stream the output of 'make' and 'run.sh'
    return Response(run_command(['make']), content_type='text/event-stream')

@app.route('/run', methods=['POST'])
def run():
    # Stream the output of 'run.sh'
    return Response(run_command(['./run.sh']), content_type='text/event-stream')

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)

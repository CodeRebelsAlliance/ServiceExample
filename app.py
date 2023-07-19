from flask import Flask, request
import pika

app = Flask(__name__)
connection = pika.BlockingConnection(pika.ConnectionParameters('localhost'))
channel = connection.channel()
channel.queue_declare(queue='my_queue')

@app.route('/add_item', methods=['POST'])
def add_item():
    item = request.json['item']
    channel.basic_publish(exchange='', routing_key='my_queue', body=item)
    return 'Item added to the queue'

if __name__ == '__main__':
    app.run()

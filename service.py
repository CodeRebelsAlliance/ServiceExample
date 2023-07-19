import pika

connection = pika.BlockingConnection(pika.ConnectionParameters('localhost'))
channel = connection.channel()
channel.queue_declare(queue='my_queue')

def process_item(ch, method, properties, body):
    # Führe hier die spezifische Aktion für den Eintrag aus
    print(f"Processing item: {body}")
    # Beispiel: Schreibe den Eintrag in eine Datei
    with open('output.txt', 'a') as f:
        f.write(body.decode() + '\n')

channel.basic_consume(queue='my_queue', on_message_callback=process_item, auto_ack=True)
channel.start_consuming()
FROM python:alpine AS trainreservationservices

RUN pip install cherrypy; \
    adduser -D -u 1000 pythonuser;
COPY . /home/pythonuser/
RUN chown -R 1000 /home/pythonuser/

FROM trainreservationservices AS bookingreferenceservice
EXPOSE 8082
USER pythonuser
WORKDIR /home/pythonuser/booking_reference_service/
CMD ["python", "booking_reference_service.py"]

FROM trainreservationservices AS traindataservice
EXPOSE 8081
USER pythonuser
WORKDIR /home/pythonuser/train_data_service/
CMD ["python", "start_service.py"]

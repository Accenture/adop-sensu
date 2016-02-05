FROM sstarcher/sensu 

# Enable Embedded Ruby
RUN sed -i -r 's/EMBEDDED_RUBY=false/EMBEDDED_RUBY=true/' /etc/default/sensu

# Install Mailer 2.5.4
RUN /opt/sensu/embedded/bin/gem install mail --version 2.5.4
RUN /opt/sensu/embedded/bin/gem install aws-ses

# Bake config & checks in
COPY resources/conf.d/* /etc/sensu/conf.d/
COPY resources/check.d/ /etc/sensu/check.d/
COPY resources/handlers/* /etc/sensu/handlers/
COPY resources/plugins /etc/sensu/plugins/

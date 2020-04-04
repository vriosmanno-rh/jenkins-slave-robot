DISABLE_REPOS=--disablerepo='rhel-*'
INSTALL_PKGS=" \
      yum-utils
      rh-python36 rh-python36-python-devel rh-python36-python-setuptools rh-python36-python-wheel \
      rh-python36-python-pip nss_wrapper \
      httpd24 httpd24-httpd-devel httpd24-mod_ssl httpd24-mod_auth_kerb httpd24-mod_ldap \
      httpd24-mod_session atlas-devel gcc-gfortran libffi-devel libtool-ltdl enchant"
TEST_PKGS="chromedriver google-chrome-stable firefox geckodriver-$GECKO_VERSION-linux64"

yum $DISABLE_REPOS install -y yum-utils
yum -y --setopt=tsflags=nodocs $DISABLE_REPOS install $INSTALL_PKGS
rpm -V $INSTALL_PKGS

# yum -y --setopt=tsflags=nodocs $DISABLE_REPOS install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
# yum -y install https://extras.getpagespeed.com/release-latest.rpm
# yum-config-manager --add-repo http://mirror.centos.org/centos/7.7.1908/os/x86_64/

yum -y --setopt=tsflags=nodocs $DISABLE_REPOS --nogpgcheck install $TEST_PKGS

# wget https://github.com/mozilla/geckodriver/releases/download/$GECKO_VERSION/geckodriver-$GECKO_VERSION-linux64.tar.gz
# tar -xf geckodriver-$GECKO_VERSION-linux64.tar.gz
# mv geckodriver /usr/local/bin
# rm -f geckodriver-$GECKO_VERSION-linux64.tar.gz

yum -y erase epel-release
rm -f /etc/yum.repos.d/mirror* /etc/yum.repos.d/getpagespeed*
yum -y clean all --enablerepo='*'
# source scl_source enable rh-python36

# Final Pip install
python3 -m pip install twine robotframework selenium robotframework-seleniumlibrary robotframework-selenium2library

scl enable rh-python36 bash
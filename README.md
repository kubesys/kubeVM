
------------------------------------------------------------
# Requirements

Supported OS.

- ubuntu22.04
- centos7.9

Python3 runtime.

- ubuntu22.04: python3.10.12
- centos7.9: python3.9.7

Go runtime.

- all: go 1.19.1

Other dependencies:

- Kubernetes/Docker: 1.23.6/20.10.15
- Libvirt/KVM: 4.5.0/2.12.0(centos7.9), 8.0.0/6.2.0(ubuntu22.04)
- Rook: v1.10.8  
- Kube-ovn: 1.12.2             

# Getting started
## Step1: Prepare

* (First time only) Install dependencies (rhel7):
    ```
    sudo yum install epel-release -y
    sudo yum install virt-manager python2-devel python2-pip libvirt-devel gcc gcc-c++ glib-devel glibc-devel libvirt virt-install -y
    sudo pip install --upgrade pip
    sudo pip install kubernetes libvirt-python xmljson xmltodict watchdog pyyaml pyinstaller
    ```
    
* Check out this repo. Seriously - check it out. Nice.
    ```
    cd $HOME
    git clone <this_repo_url>
    ```

## Step2: Release

* Release a new version and push new images to aliyun repository.
    ```
    bash $HOME/kubevmm/executor/release-version.sh <new version>
    ```

## Step3: Build

* Install `rpmdevtools`.
    ```
    sudo yum install rpmdevtools
    ```

* Install `pyinstaller`.
    ```
    sudo pip install pyinstaller
    ```

* Set up your `rpmbuild` directory tree.
    ```
    rpmdev-setuptree
    ```

* Execute `pyinstaller` to build `SOURCES`.
    ```
    cd $HOME/kubevmm/executor
    pyinstaller -F kubevmm_adm.py -n kubevmm-adm
    pyinstaller -F vmm.py
    ```

* Link the spec file and sources.
    ```
    ln -s $HOME/kubevmm/executor/SPECS/kubevmm.spec $HOME/rpmbuild/SPECS/
    find $HOME/kubevmm/executor/dist -type f -exec ln -s {} $HOME/rpmbuild/SOURCES/ \;
    ```
    
* Build the RPM.

    #### Normally
    

    ```
    rpmbuild -ba $HOME/rpmbuild/SPECS/kubevmm.spec
    ```

    #### Choose version to build
    
    The version number is hardcoded into the SPEC, however should you so choose, it can be set explicitly by passing an argument to `rpmbuild` directly:
    
    ```
    rpmbuild -ba $HOME/rpmbuild/SPECS/kubevmm.spec --define "_version v0.9.0"
    ```
    

## Step4: Result

RPMs:
- kubevmm

------------------------------------------------------------

# Users

Some steps to do to install and run kubevmm services.

## Step1: Install

* Install `kubevmm` rpm.
    ```
    rpm -Uvh --force <kubevmm-version.rpm>
    ```

* Verify `kubevmm` rpm.

  There are two commands: `kubevmm-adm` and `vmm`
    ```
    kubevmm-adm --version
    vmm
    ```
    
## Step2: Run

* Run services.
    ```
    kubevmm-adm service update --online
    ```
    
## Step3: Result

* Check services status.
    ```
    kubevmm-adm service status
    ```
------------------------------------------------------------

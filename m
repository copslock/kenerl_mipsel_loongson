Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id VAA50106 for <linux-archive@neteng.engr.sgi.com>; Sat, 13 Jun 1998 21:45:08 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id VAA64852
	for linux-list;
	Sat, 13 Jun 1998 21:44:31 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id VAA32683
	for <linux@cthulhu.engr.sgi.com>;
	Sat, 13 Jun 1998 21:44:28 -0700 (PDT)
	mail_from (adevries@engsoc.carleton.ca)
Received: from lager.engsoc.carleton.ca (lager.engsoc.carleton.ca [134.117.69.26]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam: SGI does not authorize the use of its proprietary systems or networks for unsolicited or bulk email from the Internet.) via ESMTP id VAA03659
	for <linux@cthulhu.engr.sgi.com>; Sat, 13 Jun 1998 21:44:26 -0700 (PDT)
	mail_from (adevries@engsoc.carleton.ca)
Received: from localhost (adevries@localhost)
	by lager.engsoc.carleton.ca (8.8.7/8.8.7) with SMTP id AAA29248;
	Sun, 14 Jun 1998 00:44:23 -0400
X-Authentication-Warning: lager.engsoc.carleton.ca: adevries owned process doing -bs
Date: Sun, 14 Jun 1998 00:44:23 -0400 (EDT)
From: Alex deVries <adevries@engsoc.carleton.ca>
To: SGI Linux <linux@cthulhu.engr.sgi.com>
cc: wanger@redhat.com, ewt@redhat.com
Subject: RedHat 5.1 (Manhattan) ALPHA 1 for SGI/Indys
Message-ID: <Pine.LNX.3.95.980614004054.27426A-100000@lager.engsoc.carleton.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


It's here!

Well, it is uploading.  There are definite problems, but it works
reasonably well for me.  Please let me know if you use this. You can get
everything from ftp.linux.sgi.com:/pub/redhat/redhat-5.1.

We need to sort out some issues with how to actually download it from the
'net...

Instructions are below.

Ugh, I'm glad this is out there.  I'm taking tomorrow off.


-- 
Alex deVries, puffin on LinuxNet.
http://www.engsoc.carleton.ca/~adevries/ .

Red Hat 5.1 (Manhattan) for SGI Indy's version 5.1 ALPHA 1
----------------------------------------------------------

This is neither a product of Red Hat nor of SGI.

These are instructions on how to get the unofficial port of Red Hat
version 5.1 running on your Indy.

Stuff you'll need:

- an SGI Indy.  At this point, I'd STRONGLY recommend having a seperate
  disk for Linux.

- You need to have your Linux disk partitioned from within Irix.

- You need Irix on the machine in order to install the boot image.  Yes,
  we're working on this.

- another host to bootp/tftp/NFS root from.  For this example I'll assume
  that you're using a Red Hat Linux i386 system, although other
  configurations will be possible.  

- a lot of patience.

You are strongly encouraged to report problems and feedback back to Alex
deVries <adevries@engsoc.carleton.ca>


Alright.  Here's what you need to do to get this all running:

1. Server side.

On your i386, setup the following:

a) Setup tftp 

You need to have the following lines configured in your /etc/inetd.conf:
tftp    dgram   udp     wait    root    /usr/sbin/tcpd  in.tftpd  \
  /usr/src/sgi/installfs/
bootps  dgram   udp     wait    root    /usr/sbin/bootpd /etc/bootptab

I'm using /usr/src/sgi/installfs for all my file placement.  You can
choose something else if youwant.   

After changing that, restart inetd with something like
/etc/rc.d/init.d/inetd restart.

b) Setup bootp

You need to setup your /etc/bootptab file to contain:
alex3:hd=/usr/src/sgi/installfs:\
               :rp=/usr/src/sgi/installfs:\
               :ht=ethernet:\
               :ha=080069088717:\
               :ip=140.244.9.208:\
               :bf=vmlinux:\
               :sm=255.255.255.0:\
               :to=7200:

Here, alex3 is the name of the SGI host, 080069088717 is the mac address
of the SGI which you'll have to get from Irix, and 140.244.9.208 is the
address of the SGI/Linux box.  Modify to taste.

c) Setup root NFS permissions

Ensure that in your /etc/exports you have something like:
/usr/src/sgi/installfs 140.244.9.208(no_root_squash,rw)

d) copy all the files

Take all the installation files from
ftp.linux.sgi.com:/pub/redhat/redhat-5.1 and put them in
/usr/src/sgi/installfs.  Yes, you'll need to preserve permissions.

2. Configure your disks

With Irix tools, create an EFS partition on your Linux disk.  At this
point, a swap partition won't be recognized.  Yes, we're working on it.

3. Start the install

Alright.  This is the fun part.  Assuming all your bootp/tftp/nfs root
stuff is working properly, you should be able to just go into the command
monitor (boot manager) and go: 

boot bootp():/vmlinux

You should see the kernel load, and install should run.

4. The actual install

Just go through the dialog boxes. A few notes:

- any references to partitioning don't actually work
- you will see funny partitions when it asks you to set a mount point.  Do
actually set a mount point, though.  Remember that Irix has the concept of
volume headers, so you typically want to take the *first* and slightly
smaller partition for your / filesystem.
- ignore the dependancies errors, yes, we'll get to it too.
- you'll get a lot of warnings once the install starts saying:
"RPM install of diffutils failed: execution of script failed".  We're
working on it.  Just hit Ok.

5. Configure your kernel

Boot in Irix, then copy over vmlinux which is in
/usr/src/sgi/installfs/vmlinux to the / of your Irix filesystem.  Then,
from within the boot manager, you should be able to boot with:

boot vmlinux root=/dev/sdb1

Presto!

6. Last, but not least

Let us know if it worked!


Stuff that we're working on:

- Sorting out the problems with the installer not running the scripts.
  It's bloody annoying hitting return 50 times in the install.  rpm-devel
  is suspect so far.

- filling in the missing packages, including XFree86

- disk partitioning

- being able to install a kernel without having to have Irix around.

- swap partition support in the setup

- trim down the install filesystem, it is enormous

- creating a CREDITS file

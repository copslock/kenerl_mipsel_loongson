Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id WAA89232 for <linux-archive@neteng.engr.sgi.com>; Fri, 17 Jul 1998 22:41:00 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id WAA67895
	for linux-list;
	Fri, 17 Jul 1998 22:40:12 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id WAA33456
	for <linux@cthulhu.engr.sgi.com>;
	Fri, 17 Jul 1998 22:40:10 -0700 (PDT)
	mail_from (adevries@engsoc.carleton.ca)
Received: from lager.engsoc.carleton.ca (lager.engsoc.carleton.ca [134.117.69.26]) 
	by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id WAA24004
	for <linux@cthulhu.engr.sgi.com>; Fri, 17 Jul 1998 22:40:09 -0700 (PDT)
	mail_from (adevries@engsoc.carleton.ca)
Received: from localhost (adevries@localhost)
	by lager.engsoc.carleton.ca (8.8.7/8.8.7) with SMTP id BAA31063
	for <linux@cthulhu.engr.sgi.com>; Sat, 18 Jul 1998 01:40:08 -0400
X-Authentication-Warning: lager.engsoc.carleton.ca: adevries owned process doing -bs
Date: Sat, 18 Jul 1998 01:40:07 -0400 (EDT)
From: Alex deVries <adevries@engsoc.carleton.ca>
To: SGI Linux <linux@cthulhu.engr.sgi.com>
Subject: ERRATA: rpm and portmap
Message-ID: <Pine.LNX.3.95.980718013140.21796E-100000@lager.engsoc.carleton.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


Here's the errata that fixes some problems with the distributed Hard Hat
5.1 for SGI distribution:

RPM has been updated to have a correct rpmrc so it will install
.noarch.rpm files without having to use the --ignorearch flag.

portmap has been installed in order to run at an earlier stage on bootup
so that NFS server loads properly.

You can update your system by doing:
rpm -Uvh \
ftp://ftp.linux.sgi.com/pub/redhat/updates/hardhat-5.1/portmap-4.0-12.mipseb.rpm
rpm -Uvh \
ftp://ftp.linux.sgi.com/pub/redhat/updates/hardhat-5.1/rpm-2.5.2-3.mipseb.rpm
rpm -Uvh \
ftp://ftp.linux.sgi.com/pub/redhat/updates/hardhat-5.1/rpm-devel-2.5.2-3.mipseb.rpm

(Honza, could you maybe update the WWW pages to reflect mention of this?
Thanks)

- Alex

-- 
Alex deVries, puffin on LinuxNet.
http://www.engsoc.carleton.ca/~adevries/ .

Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id QAA61509 for <linux-archive@neteng.engr.sgi.com>; Fri, 21 Aug 1998 16:59:42 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id QAA26945
	for linux-list;
	Fri, 21 Aug 1998 16:58:53 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id QAA97332
	for <linux@cthulhu.engr.sgi.com>;
	Fri, 21 Aug 1998 16:58:51 -0700 (PDT)
	mail_from (ehlert@anatu.uni-tuebingen.de)
Received: from mx03.uni-tuebingen.de (mx03.uni-tuebingen.de [134.2.3.13]) 
	by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id QAA02156
	for <linux@cthulhu.engr.sgi.com>; Fri, 21 Aug 1998 16:58:50 -0700 (PDT)
	mail_from (ehlert@anatu.uni-tuebingen.de)
Received: from mail.anatom.uni-tuebingen.de (root@mail.anatom.uni-tuebingen.de [134.2.135.146])
	by mx03.uni-tuebingen.de (8.8.8/8.8.8) with ESMTP id BAA09399;
	Sat, 22 Aug 1998 01:58:48 +0200
Received: from localhost by mail.anatom.uni-tuebingen.de
	 with smtp id m0zA15L-00077WC
	(Debian Smail-3.2 1996-Jul-4 #2); Sat, 22 Aug 1998 01:59:11 +0200 (MET DST)
Date: Sat, 22 Aug 1998 01:59:11 +0200 (MET DST)
From: Alexander Ehlert <ehlert@anatu.uni-tuebingen.de>
X-Sender: ehlert@mail.anatom.uni-tuebingen.de
To: Alex deVries <adevries@engsoc.carleton.ca>
cc: linux@cthulhu.engr.sgi.com
Subject: Re: Installed Hardhat alpha 2!
In-Reply-To: <Pine.LNX.3.96.980821192216.32181O-100000@lager.engsoc.carleton.ca>
Message-ID: <Pine.LNX.3.95.980822013915.787b-100000@mail.anatom.uni-tuebingen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Hi,

> Can you let us know what the problems with the installer were, and how you
> got around them?

At first I got the hardhat-5.1 alpha1 archive. Booting with tftp was no
problem. After the package selection the installer was not able to
open the rpm database. The programm received a signal 11 and terminated.
The kernel output was not helpful. So I initialized the rpm database
in the nfsroot environment and the next time the installer started
extracting the packages. But a lot of packages failed with "execution of
script failed". The kernel reported excepions from ldconfig and afterwards
every program I wanted to start on the second tty terminated with
segmentation fault. I found no way to get around that. Then I got
the testinstall-tree from the devel directory and the packages from
redhat5.1alpha2. After that I installed a few packages in this tree
like fileutils, mount and so on. During the manual install I experienced
that after the installation of the bash and the glibc package in the
installation directory all installation scripts worked fine. I think
the installer should at first install this packages in the install
directory, because rpm chroots to this dir. In the meantime I have
a lot of packages installed, but without the use of installer.
So I still lack some important packages, but it's going on...

A few questions:
  - can I use the mouse with gpm, which device ?
  - which one is the newest kernel version, and where can I get it ?
  - I installed egcs, should I better use gcc ?
  - does the XFree86-FB work, where can I get developer versions ?
  
Alex.

**********************************************************
* Alexander Ehlert                                       *
* Anatomisches Institut Uni Tuebingen                    *
*                       - Arbeitsgruppe Prof. Dr. Wagner *
* Systemadministrator, Webmaster                         *
* E-Mail : ehlert@anatu.uni-tuebingen.de                 *
* Tel.   : 07071-2973022                                 *
**********************************************************

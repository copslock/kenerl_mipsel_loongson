Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id RAA08170 for <linux-archive@neteng.engr.sgi.com>; Fri, 25 Sep 1998 17:39:15 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id RAA12865
	for linux-list;
	Fri, 25 Sep 1998 17:37:38 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id RAA58163
	for <linux@cthulhu.engr.sgi.com>;
	Fri, 25 Sep 1998 17:37:35 -0700 (PDT)
	mail_from (richardh@infopact.nl)
Received: from bronx.bizarre.nl (9dyn101.breda.casema.net [195.96.116.101]) 
	by sgi.sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id RAA03144
	for <linux@cthulhu.engr.sgi.com>; Fri, 25 Sep 1998 17:37:33 -0700 (PDT)
	mail_from (richardh@infopact.nl)
Received: from infopact.nl (root@localhost [127.0.0.1])
	by bronx.bizarre.nl (8.9.0/8.9.0) with ESMTP id CAA04836
	for <linux@cthulhu.engr.sgi.com>; Sat, 26 Sep 1998 02:43:02 +0200
Message-ID: <360C3895.1EE98467@infopact.nl>
Date: Sat, 26 Sep 1998 02:43:01 +0200
From: Richard Hartensveld <richardh@infopact.nl>
X-Mailer: Mozilla 4.05 [en] (X11; I; Linux 2.0.35 i686)
MIME-Version: 1.0
To: "linux@cthulhu.engr.sgi.com" <linux@cthulhu.engr.sgi.com>
Subject: problems with cvs 
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Hi,


I keep getting  this error while trying to get the latest cvs-updates
from linux.sgi.com, does anyone know
what i'm doing wrong, i've never had this with vgers-cvs tree.

bronx:~# cvs -d :pserver:anonymous@ftp.linux.sgi.com:/cvs/CVSROOT login
(Logging in to anonymous@ftp.linux.sgi.com)
CVS password:
cvs [login aborted]: unrecognized auth response from ftp.linux.sgi.com:
E Fatal error, aborting.


Richard

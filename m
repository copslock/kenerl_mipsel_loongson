Received: from sgi.com (sgi.SGI.COM [192.48.153.1])
	by lara.stud.fh-heilbronn.de (8.9.1a/8.9.1) with ESMTP id KAA08640
	for <pstadt@stud.fh-heilbronn.de>; Thu, 1 Jul 1999 10:58:32 +0200
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id BAA03193; Thu, 1 Jul 1999 01:55:08 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id BAA10162
	for linux-list;
	Thu, 1 Jul 1999 01:48:16 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id BAA53359
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 1 Jul 1999 01:48:14 -0700 (PDT)
	mail_from (wa0191@stud.uni-wuppertal.de)
Received: from mail.urz.uni-wuppertal.de (mail.urz.uni-wuppertal.de [132.195.64.1]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id BAA03203
	for <linux@cthulhu.engr.sgi.com>; Thu, 1 Jul 1999 01:48:01 -0700 (PDT)
	mail_from (wa0191@stud.uni-wuppertal.de)
Received: from nachtfalke.dhis.org (root@isdn40.dialin.uni-wuppertal.de [132.195.23.40])
	by mail.urz.uni-wuppertal.de (8.9.2/8.9.2) with ESMTP id KAA76577359
	for <linux@cthulhu.engr.sgi.com>; Thu, 1 Jul 1999 10:47:26 +0200 (MDT)
Received: (from nachtfalke@localhost)
	by nachtfalke.dhis.org (8.8.8/8.8.8) id KAA00725
	for linux@cthulhu.engr.sgi.com; Thu, 1 Jul 1999 10:37:33 +0200
From: Alexander Graefe <wa0191@stud.uni-wuppertal.de>
Date: Thu, 1 Jul 1999 10:37:32 +0200
To: linux@cthulhu.engr.sgi.com
Subject: Linux on my INDY, now what ?
Message-ID: <19990701103732.A393@ganymede>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.6i
X-Goddess: Willow
X-Farbe: Gelb
X-Geschmack: siehe X-Farbe
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Hi all.

I recently managed to install Linux on my Indy by just installing over
the whole IRIX partition. I never thought that would work, but it did.
:)
The only thing that bugs me now is that I have to netboot it, but I
can live with that.
I was able to compile a few things, like Apache 1.3.6 and Roxen
1.3.111 without problems, and they seem to run just fine.
Now I am wondering, did anyone get MySQL to compile on HardHat ?
My version (3.22.23b) complains that my egcs should be at least 1.0.3,
but I haven't found anything on ftp.linux.sgi.com newer than 1.0.2,
and the latest egcs-release doesn't work out of the box.

And what is the latest kernel ? I am using the 2.2.1-sound kernel, but
I wanted to compile my own kernel, but I couldn't find sources for 2.2
on ftp.linux.sgi.com, only for 2.1.

Otherwise, great work, now I finally can really put that Indy to use.

Bye,
	LeX

-- 
Today's excuse:
Smell from unhygenic janitorial staff wrecked the tape heads

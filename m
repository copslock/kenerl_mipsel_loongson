Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id NAA56761 for <linux-archive@neteng.engr.sgi.com>; Wed, 17 Jun 1998 13:01:57 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id NAA29959
	for linux-list;
	Wed, 17 Jun 1998 13:01:27 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id NAA43128
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 17 Jun 1998 13:01:25 -0700 (PDT)
	mail_from (stuart@gnqs.org)
Received: from post.mail.demon.net (post-11.mail.demon.net [194.217.242.40]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam: SGI does not authorize the use of its proprietary systems or networks for unsolicited or bulk email from the Internet.) via SMTP id MAA16096
	for <linux@cthulhu.engr.sgi.com>; Wed, 17 Jun 1998 12:58:46 -0700 (PDT)
	mail_from (stuart@gnqs.org)
Received: from (askone.demon.co.uk) [194.222.7.179] 
	by post.mail.demon.net with esmtp (Exim 1.82 #2)
	id 0ymOLu-000722-00; Wed, 17 Jun 1998 19:58:39 +0000
Received: from myrddraal.octopus.com (myrddraal.octopus-technologies.com [172.16.1.2])
	by askone.demon.co.uk (8.8.5/8.8.5) with SMTP id TAA04957
	for <linux@cthulhu.engr.sgi.com>; Wed, 17 Jun 1998 19:57:37 GMT
From: "Stuart Herbert, GNQS Maintainer" <stuart@gnqs.org>
To: "Linux/SGI List" <linux@cthulhu.engr.sgi.com>
Subject: Linux/SGI and processor sets
Date: Wed, 17 Jun 1998 20:57:17 +0100
Message-ID: <000901bd9a2a$21972760$020110ac@myrddraal.octopus.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook 8.5, Build 4.71.2173.0
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V4.72.2106.4
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Hi everyone,

I've joined the Linux/SGI mailing list looking for (at first)
information about a specific feature-set ... my apologies if I've come
to the wrong place.

IRIX 5.x, and IRIX 6.0-6.3 provides support for 'processor sets'
through the sysmp(2) system call, and the pset(1) binary.  This
particular feature-set is popular amongst users of Generic NQS, a
batch processing system I maintain.

It's so popular, in fact, that there's been a lot of interest amongst
my users in adding this feature-set to Linux.  It occurred to me that
the Linux/SGI port *might* include adding this support to Linux.

Is sysmp(2) and pset(1) on your TODO list?

If not, then I wrote a (crude - I'm not much of a kernel hacker) patch
which implemented all the pset stuff for sysmp(2), and a basic pset(1)
binary which may be of interest.  The patch is against an old 2.0
kernel, and needs a small fix to actually work (I don't actually have
a SMP box of my own).

Best regards,
Stu
--
Stuart Herbert                               s.herbert@sheffield.ac.uk
Generic NQS Maintainer                      http://www.shef.ac.uk/~nqs
--

Received: from pneumatic-tube.sgi.com (pneumatic-tube.sgi.com [204.94.214.22])
	by lara.stud.fh-heilbronn.de (8.9.1a/8.9.1) with ESMTP id WAA25239
	for <pstadt@stud.fh-heilbronn.de>; Tue, 28 Sep 1999 22:22:47 +0200
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id NAA04367; Tue, 28 Sep 1999 13:18:50 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id NAA61533
	for linux-list;
	Tue, 28 Sep 1999 13:03:54 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id NAA26323
	for <linux@cthulhu.engr.sgi.com>;
	Tue, 28 Sep 1999 13:03:50 -0700 (PDT)
	mail_from (neuroinc@unidial.com)
Received: from mail.unidial.com (unidial.com [206.112.0.9]) 
	by sgi.com (980305.SGI.8.8.8-aspam-6.2/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id NAA3433064
	for <linux@cthulhu.engr.sgi.com>; Tue, 28 Sep 1999 13:03:49 -0700 (PDT)
	mail_from (neuroinc@unidial.com)
Received: from unidial.com (root@pool-209-138-12-40.ipls.grid.net [209.138.12.40])
	by mail.unidial.com (8.8.7/ntr.net 3.0.0) with ESMTP id UAA18197;
	Tue, 28 Sep 1999 20:01:55 GMT
Message-ID: <37F1169E.B816C35E@unidial.com>
Date: Tue, 28 Sep 1999 19:27:26 +0000
From: Alan Hoyt <neuroinc@unidial.com>
X-Mailer: Mozilla 4.5 [en] (X11; I; Linux 2.0.36 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Gavin Kistner <gavin@refinery.com>
CC: linux@cthulhu.engr.sgi.com
Subject: Re: Linux->Indy->O2
References: <v04220602b415257a1e03@[216.63.49.245]>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk
Content-Transfer-Encoding: 7bit

Gavin Kistner wrote:

> I noticed the previous poster mentioning that the Indy2 doesn't have X support yet under Linux. I'm wondering: does linux support for

I believe Ulf Carlsson is working on REX3 support - that's Indy and Indigo2

> one machine get fully implemented and then tweaked to go to others, or is it a ground-up approach for each new machine in the port list?

Two issues: X is huge and the architectures are quite different - your talking a *major* serious effort.


 - Alan Hoyt -

Received: from sgi.com (sgi.SGI.COM [192.48.153.1])
	by lara.stud.fh-heilbronn.de (8.9.1a/8.9.1) with ESMTP id DAA11436
	for <pstadt@stud.fh-heilbronn.de>; Fri, 16 Jul 1999 03:40:18 +0200
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id SAA02257; Thu, 15 Jul 1999 18:39:15 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id SAA02371
	for linux-list;
	Thu, 15 Jul 1999 18:36:24 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id SAA83194
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 15 Jul 1999 18:36:21 -0700 (PDT)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id SAA04193
	for <linux@cthulhu.engr.sgi.com>; Thu, 15 Jul 1999 18:36:19 -0700 (PDT)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from lappi.waldorf-gmbh.de (cacc-30.uni-koblenz.de [141.26.131.30])
	by mailhost.uni-koblenz.de (8.9.1/8.9.1) with ESMTP id DAA22160
	for <linux@cthulhu.engr.sgi.com>; Fri, 16 Jul 1999 03:36:17 +0200 (MET DST)
Received: (from ralf@localhost)
	by lappi.waldorf-gmbh.de (8.9.3/8.9.3) id DAA04810;
	Fri, 16 Jul 1999 03:35:36 +0200
Date: Fri, 16 Jul 1999 03:35:36 +0200
From: Ralf Baechle <ralf@uni-koblenz.de>
To: Tim Hockin <thockin@cobaltnet.com>
Cc: linux@cthulhu.engr.sgi.com
Subject: Re: gp
Message-ID: <19990716033536.A4133@uni-koblenz.de>
References: <378E2FEF.6E82871A@cobaltnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4us
In-Reply-To: <378E2FEF.6E82871A@cobaltnet.com>; from Tim Hockin on Thu, Jul 15, 1999 at 12:01:03PM -0700
X-Accept-Language: de,en,fr
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Thu, Jul 15, 1999 at 12:01:03PM -0700, Tim Hockin wrote:

> just playing around with kernel, and wondering what (if any) work has
> been done to use gp within the kernel.  I know it is built with -G 0
> now.
> 
> I looked into it, and made sure that gp got saved and restored correctly
> (I think), but when I compile with -G > 0 gcc (or egcs) gets signal 11 -
> ideas?

In Linux 2.1 / 2.2 we have an other use of the gp; it contains the
current variable.  See include/asm-mips/current.h.  It's been on my to do
list for a long time to check if -G > 0 will be a better use of $28 than
putting the current variable there.

  Ralf

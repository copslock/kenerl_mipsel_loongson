Received: from sgi.com (sgi.SGI.COM [192.48.153.1])
	by lara.stud.fh-heilbronn.de (8.9.1a/8.9.1) with ESMTP id XAA20136
	for <pstadt@stud.fh-heilbronn.de>; Wed, 7 Jul 1999 23:35:29 +0200
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id OAA07212; Wed, 7 Jul 1999 14:12:46 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id OAA76494
	for linux-list;
	Wed, 7 Jul 1999 14:07:39 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id OAA63533;
	Wed, 7 Jul 1999 14:07:08 -0700 (PDT)
	mail_from (Harald.Koerfgen@home.ivm.de)
Received: from mail.ivm.net (mail.ivm.net [62.204.1.4]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id OAA06452; Wed, 7 Jul 1999 14:07:06 -0700 (PDT)
	mail_from (Harald.Koerfgen@home.ivm.de)
Received: from franz.no.dom (port4.koeln.ivm.de [195.247.239.4])
	by mail.ivm.net (8.8.8/8.8.8) with ESMTP id XAA30233;
	Wed, 7 Jul 1999 23:05:51 +0200
X-To: wje@fir.engr.sgi.com
Message-ID: <XFMail.990707230857.Harald.Koerfgen@home.ivm.de>
X-Mailer: XFMail 1.3 [p0] on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <19990706150549.A28849@uni-koblenz.de>
Date: Wed, 07 Jul 1999 23:08:57 +0200 (MEST)
Reply-To: "Harald Koerfgen" <Harald.Koerfgen@home.ivm.de>
Organization: none
From: Harald Koerfgen <Harald.Koerfgen@home.ivm.de>
To: Ralf Baechle <ralf@uni-koblenz.de>
Subject: Re: Memory corruption
Cc: linux-mips@vger.rutgers.edu, linux-mips@fnet.fr,
        linux@cthulhu.engr.sgi.com, Ulf Carlsson <ulfc@thepuffingroup.com>,
        "William J. Earl" <wje@fir.engr.sgi.com>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk
Content-Transfer-Encoding: 8bit


On 06-Jul-99 Ralf Baechle wrote:
> I've received a report from some person who is working on his own R3081
> port.  He also observes data corruption and suspects reading of swapped
> pages is causing that.

That's definitely true for R3k DECstations, and no, flushing the icache in
flush_tlb_page() does not help. I have added cacheflushing to all tlb routines,
copy_page and even rw_swap_page_base() and swap_after_unlock_page() without
success.

Any ideas?
---
Regards,
Harald

P.S.: I'll be on vacation until July 18th so this has twait a little bit :-)

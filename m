Received: from pneumatic-tube.sgi.com (pneumatic-tube.sgi.com [204.94.214.22])
	by lara.stud.fh-heilbronn.de (8.9.1a/8.9.1) with ESMTP id TAA16786
	for <pstadt@stud.fh-heilbronn.de>; Mon, 19 Jul 1999 19:46:35 +0200
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by pneumatic-tube.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id KAA6343068; Mon, 19 Jul 1999 10:43:33 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id KAA22480
	for linux-list;
	Mon, 19 Jul 1999 10:38:59 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id KAA67066
	for <linux@cthulhu.engr.sgi.com>;
	Mon, 19 Jul 1999 10:38:52 -0700 (PDT)
	mail_from (Harald.Koerfgen@home.ivm.de)
Received: from mail.ivm.net (mail.ivm.net [62.204.1.4]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id KAA08868
	for <linux@cthulhu.engr.sgi.com>; Mon, 19 Jul 1999 10:38:51 -0700 (PDT)
	mail_from (Harald.Koerfgen@home.ivm.de)
Received: from franz.no.dom (port22.koeln.ivm.de [195.247.239.22])
	by mail.ivm.net (8.8.8/8.8.8) with ESMTP id TAA14684;
	Mon, 19 Jul 1999 19:38:34 +0200
X-To: linux@cthulhu.engr.sgi.com
Message-ID: <XFMail.990719194145.Harald.Koerfgen@home.ivm.de>
X-Mailer: XFMail 1.3 [p0] on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
Date: Mon, 19 Jul 1999 19:41:45 +0200 (MEST)
Reply-To: "Harald Koerfgen" <Harald.Koerfgen@home.ivm.de>
Organization: none
From: Harald Koerfgen <Harald.Koerfgen@home.ivm.de>
To: linux-mips@fnet.fr, SGI Linux <linux@cthulhu.engr.sgi.com>,
        linuxce-devel@linuxce.org
Subject: Bye, bye, "generic kernels"
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk
Content-Transfer-Encoding: 8bit

Hi gang,

I am planning to commit the R3000 changes to the CVS this week. In preparation
for that I have cleaned up some things and made the CPU configuration finer
granulated (if you want it) so that it will be possible to configure Linux for
CPUs with, for example, an R4000 core but without ll/sc instructions.

As a side effect it will be no longer possible to build "generic" kernels, i.e.
kernels that are able to work on R3xxx and R4xxx machines and you'll have to
choose at least the right CPU core.

Wanting to have "generic" kernels leads to major uglinesses like avoidable
indirect function calls and self-modifying code and I don't like that.

AFAIK only the DECstations will be affected and I can happily live with that
when it leads to cleaner, leaner and faster code.

Comments?
---
Regards,
Harald

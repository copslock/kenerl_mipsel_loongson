Received: from sgi.com (sgi.SGI.COM [192.48.153.1])
	by lara.stud.fh-heilbronn.de (8.9.1a/8.9.1) with ESMTP id VAA07604
	for <pstadt@stud.fh-heilbronn.de>; Mon, 19 Jul 1999 21:58:07 +0200
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id MAA05201; Mon, 19 Jul 1999 12:56:42 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id MAA00777
	for linux-list;
	Mon, 19 Jul 1999 12:51:55 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id MAA68411
	for <linux@cthulhu.engr.sgi.com>;
	Mon, 19 Jul 1999 12:51:52 -0700 (PDT)
	mail_from (Harald.Koerfgen@home.ivm.de)
Received: from mail.ivm.net (mail.ivm.net [62.204.1.4]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id MAA05303
	for <linux@cthulhu.engr.sgi.com>; Mon, 19 Jul 1999 12:51:50 -0700 (PDT)
	mail_from (Harald.Koerfgen@home.ivm.de)
Received: from franz.no.dom (port53.koeln.ivm.de [195.247.239.53])
	by mail.ivm.net (8.8.8/8.8.8) with ESMTP id VAA19933;
	Mon, 19 Jul 1999 21:51:29 +0200
X-To: linux@cthulhu.engr.sgi.com
Message-ID: <XFMail.990719215440.Harald.Koerfgen@home.ivm.de>
X-Mailer: XFMail 1.3 [p0] on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <006401bed20f$37ebdf60$b1119526@tecra.ltc.com>
Date: Mon, 19 Jul 1999 21:54:41 +0200 (MEST)
Reply-To: "Harald Koerfgen" <Harald.Koerfgen@home.ivm.de>
Organization: none
From: Harald Koerfgen <Harald.Koerfgen@home.ivm.de>
To: "Bradley D. LaRonde" <brad@ltc.com>
Subject: Re: Bye, bye, "generic kernels"
Cc: linuxce-devel@linuxce.org, SGI Linux <linux@cthulhu.engr.sgi.com>,
        linux-mips@fnet.fr
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk
Content-Transfer-Encoding: 8bit


On 19-Jul-99 Bradley D. LaRonde wrote:
> Off topic:  I'm wondering - why did I need to apply the R3000 patch for my
> R4000 processor build?  Is it just called the R3000 patch but really it's
> more than that?

Well, the VR4111 doesn't support ll/sc instructions and without the R3000 patch 
you will have no chance to get a working kernel.

> On topic:  I like the fine-grained CPU configuration.  By any chance did you
> include Vr4111 in there?

Not exactly. I was more thinking along the lines of:

"Hey, I have this wonderful CPU with an R4000 core (i.e. R4000 exception
handling) but it doesn't support ll/sc instructions so use the R3000 variant
for atomic operations"

or

"My CPU is based on an R3000 but it does have ll/sc instructions so use them"

or even

"Yes, my box has an R3000 variant but linux doesn't have to care about the
writeback buffer, some magical hardware does this".

That is already implemented (No big deal, to be honest. Just some config.in
hacking and replacing some "#if (_MIPS_ISA == _MIPS_ISA_MIPS1)" with "#if
!defined (CONFIG_CPU_HAS_LLSC)").

This concept can easily be expanded to, let's say, DMA snooping or "cache
coherent I/O", if needed.

An additional idea is to hide all these details from Joe Average, based on
assumptions from the machine and CPU type, but to make them available to
developers.

---
Regards,
Harald

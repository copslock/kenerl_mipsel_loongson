Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 25 Apr 2003 02:46:32 +0100 (BST)
Received: from h0000c06cf87e.ne.client2.attbi.com ([IPv6:::ffff:24.147.212.21]:54034
	"EHLO compaq.parker.boston.ma.us") by linux-mips.org with ESMTP
	id <S8225208AbTDYBq1>; Fri, 25 Apr 2003 02:46:27 +0100
Received: from p2.parker.boston.ma.us (p2 [192.245.5.16])
	by compaq.parker.boston.ma.us (8.11.6/8.11.6) with ESMTP id h3P1kNH10274;
	Thu, 24 Apr 2003 21:46:24 -0400
Received: from p2 (brad@localhost)
	by p2.parker.boston.ma.us (8.11.2/8.11.2) with ESMTP id h3P1kNk24851;
	Thu, 24 Apr 2003 21:46:23 -0400
Message-Id: <200304250146.h3P1kNk24851@p2.parker.boston.ma.us>
From: Brad Parker <brad@parker.boston.ma.us>
To: "Kevin D. Kissell" <kevink@mips.com>
cc: "Chip Coldwell" <coldwell@frank.harvard.edu>,
	linux-mips@linux-mips.org
Subject: Re: NCD900 port? 
In-Reply-To: Message from "Kevin D. Kissell" <kevink@mips.com> 
   of "Thu, 24 Apr 2003 23:51:41 +0200." <011a01c30aab$b7748ce0$10eca8c0@grendel> 
X-Mailer: MH-E 7.2; nmh 1.0.4; GNU Emacs 20.7.1
Date: Thu, 24 Apr 2003 21:46:23 -0400
Return-Path: <brad@parker.boston.ma.us>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2186
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: brad@parker.boston.ma.us
Precedence: bulk
X-list: linux-mips


"Kevin D. Kissell" wrote:
>> I'm facing a ~$1K site license charge for NCD's NCBridge software for
>> their NC948 X Terminals, and since my site consists of exactly three
>> of these things that I bought for less than $250 each I'm balking a
>> bit.
>> 
>> The NC948 consists of a 165 MHz QED RM5231, S3 Savage4 graphics
>> controller, and an AMD PCnet NIC of some sort.  It doesn't seem like
>> there's anything in that set that Linux or XFree86 wouldn't be happy
>> to run.
>
>What PCI bridge is being used?  Galileo?

It it's anything like the explora 450 you should be able to get it going.
(oh my, did *I* say that?)

The 450 has those same two chips with a ppc403.  I managed to hack my
way into their undocumented pci bridge enough to get linux booted and
the ethernet working.  I have yet to get the s3 working but that's only
because I can find a pdf for the chip anywhere.  I can certainly talk to
the s3 (as well as the pcmcia space).

why ncd refuses to give out some info on these platforms eludes me.  these
days they'd probably sell more if they ran linux.
 
-brad

Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id MAA43033 for <linux-archive@neteng.engr.sgi.com>; Sun, 18 Oct 1998 12:53:02 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id MAA25139
	for linux-list;
	Sun, 18 Oct 1998 12:52:27 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id MAA86560
	for <linux@engr.sgi.com>;
	Sun, 18 Oct 1998 12:52:14 -0700 (PDT)
	mail_from (harald.koerfgen@netcologne.de)
Received: from mail2.netcologne.de (mail2.netcologne.de [194.8.194.103]) 
	by sgi.sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id MAA02011
	for <linux@engr.sgi.com>; Sun, 18 Oct 1998 12:52:09 -0700 (PDT)
	mail_from (harald.koerfgen@netcologne.de)
Received: from franz.no.dom (dial9-197.netcologne.de [194.8.195.197])
	by mail2.netcologne.de (8.8.8/8.8.8) with ESMTP id VAA16055;
	Sun, 18 Oct 1998 21:51:51 +0200 (MET DST)
X-Ncc-Regid: de.netcologne
Message-ID: <XFMail.981018215318.harald.koerfgen@netcologne.de>
X-Mailer: XFMail 1.2 [p0] on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <Pine.SV4.3.91.981016185136.876A-100000@mech.math.msu.su>
Date: Sun, 18 Oct 1998 21:53:18 +0200 (MEST)
Reply-To: "Harald Koerfgen" <harald.koerfgen@netcologne.de>
Organization: none
From: Harald Koerfgen <harald.koerfgen@netcologne.de>
To: linux-mips@fnet.fr
Subject: Re: get_mmu_context()
Cc: linux@cthulhu.engr.sgi.com, Vladimir Roganov <roganov@niisi.msk.ru>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


On 16-Oct-98 Gleb O. Rajko wrote:

> On Thu, 15 Oct 1998 ralf@uni-koblenz.de wrote:
> 
>> 
>> The performance hit will come into the game as soon as one tries to
>> build a generic kernel for both R3000 and R4000.  The R3000 PID and the
>> R4000 ASID mechanism are slightly different and the simple approach
>> to fix that is to use global variables.  Which affects both your version
>> and the current version.
> We are going to provide support for building generic kernels in the near 
> future if somebody who holds r4k will help us and will try our patches 
> on a r4k box. I think the best time to start is when r3k will be synced 
> with the main branch. Perhaps, Harald may answer when it might occur.

Hmmm, I'm not shure about this. If we really want to support generic kernels,
that'll shurely needs some more work than a little patching in get_mmu_context.
Remember, Vladimir, we needed to make changes in extremely performance critical
parts of the kernel which Ralf propably won't like to have for the R4000 case. Most
of them are actually compiled conditionally.

To make those changes generic needs either a reasonable amount of hacking or
avoidable code duplication. In fact, if we really don't care about self modifying
code we should be able to remove some code duplication, for example in the fpu
stuff.

I'd personally prefer to have a few things sorted out before I check the R3000 stuff
in. What's common opinion on this?

---
Regards,
Harald

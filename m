Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id MAA65990 for <linux-archive@neteng.engr.sgi.com>; Wed, 21 Oct 1998 12:31:27 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id MAA22506
	for linux-list;
	Wed, 21 Oct 1998 12:30:47 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id MAA62334
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 21 Oct 1998 12:30:44 -0700 (PDT)
	mail_from (harald.koerfgen@netcologne.de)
Received: from mail2.netcologne.de (mail2.netcologne.de [194.8.194.103]) 
	by sgi.sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id MAA06740
	for <linux@cthulhu.engr.sgi.com>; Wed, 21 Oct 1998 12:30:37 -0700 (PDT)
	mail_from (harald.koerfgen@netcologne.de)
Received: from franz.no.dom (dial1-22.netcologne.de [194.8.196.22])
	by mail2.netcologne.de (8.8.8/8.8.8) with ESMTP id VAA09382;
	Wed, 21 Oct 1998 21:30:05 +0200 (MET DST)
X-Ncc-Regid: de.netcologne
Message-ID: <XFMail.981021213140.harald.koerfgen@netcologne.de>
X-Mailer: XFMail 1.2 [p0] on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <19981019121804.F387@uni-koblenz.de>
Date: Wed, 21 Oct 1998 21:31:40 +0200 (MEST)
Reply-To: "Harald Koerfgen" <harald.koerfgen@netcologne.de>
Organization: none
From: Harald Koerfgen <harald.koerfgen@netcologne.de>
To: linux-mips@fnet.fr
Subject: Re: get_mmu_context()
Cc: Vladimir Roganov <roganov@niisi.msk.ru>, linux@cthulhu.engr.sgi.com
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On 19-Oct-98 ralf@uni-koblenz.de wrote:
> On Sun, Oct 18, 1998 at 09:53:18PM +0200, Harald Koerfgen wrote:

[...]
> There is a number of machines, most popular some DECstation, which are
> available with both CPU architectures.

Yup.
 
> The other location for which patching might be useful are primarily the
> differences between the R3000 and R4000 status register, especially the
> KU rsp. KSU bits.  What other places do you have in mind?

Agreed. There are indeed other places where code could be reintegrated,
r2300_switch.S and r4k_switch.S come to mind.

On the other hand, there is code which should be seperated for performance reasons,
mainly the RESTORE_ALL macros thus affecting entry.S and scall_o32.S. Actually these
problems are solved by conditional compiling.
 
>> To make those changes generic needs either a reasonable amount of hacking or
>> avoidable code duplication. In fact, if we really don't care about self
>> modifying code we should be able to remove some code duplication, for
>> example in the fpu stuff.
> 
> People should consider that we'll be able to hide the self modifications
> in C code very nicely.  I would not go for anything which I consider a
> maintenance problem or major uglyness.

Good.
 
> Let me explain how the approach from my recent patch works:

[explanation snipped]
 
> Todo: we don't want a separate section per patched instruction.  Easy to
> fix.  We also want to get rid of the special section just like other
> initfunc stuff.

That sounds great. We could even put all ISA dependant code into seperate
sections and get rid of all the ISA sections, which aren't needed.
 
> The next class of things to patch are the zillion of function calls using
> function pointers.  We can insert a jal instruction and patch it's
> destination address.  Candidates for that include calls to flush_cache_all,
> flush_cache_mm, flush_cache_range, flush_cache_page, flush_cache_sigtramp,
> flush_tlb_all, flush_tlb_mm, flush_tlb_range, flush_tlb_page, add_wired_entry,
> clear_page, copy_page.
> 
> Both parts, patching immediate opperands and function calls can be dealt
> with similar to the approach in the userland dynamic linker, that initially
> the function called is the dynamic linker's kernel equivalent which will
> choose the right thing to do.
> 
> Extra goodie for the R3000 fraction: Many functions called via above
> mentioned pointers are empty, calls to them may be eleminated by overwriting
> the calling jal with nops.  Say goodbye to another hand full of cycles.

That sounds even better :-).
---
Regards,
Harald

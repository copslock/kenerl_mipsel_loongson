Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Sep 2017 13:51:07 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:61630 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23990505AbdIZLvAwveQm (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 26 Sep 2017 13:51:00 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id B8E48EC42A75D;
        Tue, 26 Sep 2017 12:50:50 +0100 (IST)
Received: from [10.20.78.109] (10.20.78.109) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server id 14.3.361.1; Tue, 26 Sep 2017
 12:50:52 +0100
Date:   Tue, 26 Sep 2017 12:50:40 +0100
From:   "Maciej W. Rozycki" <macro@imgtec.com>
To:     Fredrik Noring <noring@nocrew.org>
CC:     <linux-mips@linux-mips.org>
Subject: Re: [PATCH v2] MIPS: Add basic R5900 support
In-Reply-To: <20170920145440.GB9255@localhost.localdomain>
Message-ID: <alpine.DEB.2.00.1709201705070.16752@tp.orcam.me.uk>
References: <20170911151737.GA2265@localhost.localdomain> <alpine.DEB.2.00.1709141423180.16752@tp.orcam.me.uk> <20170916133423.GB32582@localhost.localdomain> <alpine.DEB.2.00.1709171001160.16752@tp.orcam.me.uk> <20170918192428.GA391@localhost.localdomain>
 <alpine.DEB.2.00.1709182055090.16752@tp.orcam.me.uk> <20170920145440.GB9255@localhost.localdomain>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.20.78.109]
Return-Path: <Maciej.Rozycki@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60152
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@imgtec.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

Hi Fredrik,

> > > The transition from 128-bit registers to 64-bit registers was easy (in a
> > > 32-bit kernel) by changing the LONGD_{L,S} macros in asm.h from quadword
> > > {L,S}Q to doubleword {L,S}D instructions, and changing pt_regs::regs[32]
> > > from r5900_reg_t to unsigned long long.
> > 
> >  But why did you have to change anything there in the first place?  All 
> > that's there is generic stuff.
> 
> The 128-bit register save/restore infrastructure is part of the original
> 2.6.35 patch for R5900 support, that I ported to 4.12 and we're about to
> disentangle. The original patch crashes similarly unless full 128-bit GPRs
> are handled in 32-bit or 64-bit kernels, so this particular issue appears
> to remain intact. Hopefully we will be able to figure out cause and fix.

 Ack.

 BTW I think that when we get to supporting 128-bit registers we want to 
avoid changing the definition of LONG_{L,S} macros, because these are used 
for purposes beyond context access.

 Instead I think these macros as well all the ones in <asm/stackframe.h> 
should remain unchanged and the save and restoration of the 64-bit upper 
halves done separately, most likely in `switch_to', which is where all the 
user context registers which like these upper halves are not touched by 
the kernel (and which are not handled lazily by other means) are switched.

 Having come to this conclusion I think the clearing of upper halves I 
have previously suggested for the initial stage will best be done in 
`switch_to' as well.

> >  But all that is something for a later stage; right now I suggest that you 
> > figure out what's causing registers to become clobbered and fix it there.
> 
> My thinking was simply that we could try to use the (already patched up)
> 128-bit infrastructure, that seems to work quite well, as a debug tool in
> this particular case. I understand that merging it is another matter.

 Sure, use whatever tools you have available at hand to debug.

> >  Use `file' or `readelf -h' on the BusyBox binary to double-check the ABI 
> > it has been built for.  Although I doubt there will be issues with the 
> > executable, as it would crash on any of the other MIPS processors which 
> > implement the 32-bit mode correctly.
> 
> As previously mentioned all binaries I've tested so far declare "ELF 32-bit
> LSB, MIPS, MIPS-III version 1" with file. mipsel-linux-readelf says
> 
> ELF Header:
>   Magic:   7f 45 4c 46 01 01 01 00 00 00 00 00 00 00 00 00
>   Class:                             ELF32
>   Data:                              2's complement, little endian
>   Version:                           1 (current)
>   OS/ABI:                            UNIX - System V
>   ABI Version:                       0
>   Type:                              EXEC (Executable file)
>   Machine:                           MIPS R3000
>   Version:                           0x1
>   Entry point address:               0x402d90
>   Start of program headers:          52 (bytes into file)
>   Start of section headers:          276156 (bytes into file)
>   Flags:                             0x20920003, noreorder, pic, unknown CPU, mips3
>   Size of this header:               52 (bytes)
>   Size of program headers:           32 (bytes)
>   Number of program headers:         7
>   Size of section headers:           40 (bytes)
>   Number of section headers:         25
>   Section header string table index: 24
> 
> but it's unclear to me whether it's generic or somehow tailored for R5900.

 Thanks for this dump.  The binary is indeed for the R5900, according to 
`Flags' having 0x92 in bits 23:16:

#define E_MIPS_MACH_5900	0x00920000

[which shows up as `unknown CPU' because the port submitter forgot to add 
decoding of this value to `readelf'; I've now fixed that upstream].  So it 
could be doing something odd if there was a bug somewhere in the toolchain 
used.

 Can you try a regular 32-bit MIPS Debian distribution instead?

 BTW, I have just noticed that DMULT, DMULTU, DDIV and DDIVU instructions 
are not implemented.  Which means that a 64-bit kernel will only work if 
compiled with `-march=r5900' and emulation is required for 64-bit user 
programs.

  Maciej

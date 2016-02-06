Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 06 Feb 2016 18:17:00 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:61063 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27007227AbcBFRQ6g0KLC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 6 Feb 2016 18:16:58 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email Security Gateway with ESMTPS id 9FFE8C92E6B17;
        Sat,  6 Feb 2016 17:16:49 +0000 (GMT)
Received: from [10.100.200.149] (10.100.200.149) by hhmail02.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server id 14.3.266.1; Sat, 6 Feb 2016
 17:16:50 +0000
Date:   Sat, 6 Feb 2016 17:16:33 +0000
From:   "Maciej W. Rozycki" <macro@imgtec.com>
To:     Daniel Wagner <daniel.wagner@bmw-carit.de>
CC:     <linux-mips@linux-mips.org>, <linux-kernel@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH] MIPS: Differentiate between 32 and 64 bit ELF header
In-Reply-To: <56AF82AB.5010502@bmw-carit.de>
Message-ID: <alpine.DEB.2.00.1602061624460.15885@tp.orcam.me.uk>
References: <1453992270-4688-1-git-send-email-daniel.wagner@bmw-carit.de> <1454074137-16334-1-git-send-email-daniel.wagner@bmw-carit.de> <alpine.DEB.2.00.1602010038230.5958@tp.orcam.me.uk> <56AF82AB.5010502@bmw-carit.de>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.100.200.149]
Return-Path: <Maciej.Rozycki@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51816
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

On Mon, 1 Feb 2016, Daniel Wagner wrote:

> >> Depending on the configuration either the 32 or 64 bit version of
> >> elf_check_arch() is defined. parse_crash_elf32_headers() does
> >> some basic verification of the ELF header via elf_check_arch().
> >> parse_crash_elf64_headers() does it via vmcore_elf64_check_arch()
> >> which expands to the same elf_check_check().
> >>
> >>    In file included from include/linux/elf.h:4:0,
> >>                     from fs/proc/vmcore.c:13:
> >>    fs/proc/vmcore.c: In function 'parse_crash_elf64_headers':
> >>>> arch/mips/include/asm/elf.h:228:23: error: initialization from incompatible pointer type [-Werror=incompatible-pointer-types]
> >>      struct elfhdr *__h = (hdr);     \
> >>                           ^
> >>    include/linux/crash_dump.h:41:37: note: in expansion of macro 'elf_check_arch'
> >>     #define vmcore_elf64_check_arch(x) (elf_check_arch(x) || vmcore_elf_check_arch_cross(x))
> >>                                         ^
> >>    fs/proc/vmcore.c:1015:4: note: in expansion of macro 'vmcore_elf64_check_arch'
> >>       !vmcore_elf64_check_arch(&ehdr) ||
> >>        ^
> >>
> >> Since the MIPS ELF header for 32 bit and 64 bit differ we need
> >> to check accordingly.
> > 
> >  I fail to see how it can work as it stands given that `elf_check_arch' is 
> > called from the same source file both on a pointer to `Elf32_Ehdr' and one 
> > to `Elf64_Ehdr'.  However the MIPS implementations of `elf_check_arch' 
> > only use an auxiliary variable to avoid multiple evaluation of a macro 
> > argument and therefore instead I recommend the use of the usual approach
> > taken in such a situation within a statement expression, that is to 
> > declare the variable with `typeof' rather than an explicit type.  As an
> > upside this will minimise code disruption as well.
> 
> Good point on the type for hdr. Thought elf_check_arch() implementation
> differ on 32 bit and 64 bit implementation. I played a bit around and the
> simplest version I found was this here:

 Umm, somehow I didn't really realise this code wants ELF32 and ELF64 
checks both at once -- does it actually make sense?  Is a core file from a 
kernel crash dump ever going to be the opposite kind to the newly booted 
kernel?

 Anyway sorry about my confusion and the point above aside I don't really 
like the idea of merging both `elf_check_arch' variations into one, it 
just looks messy to me.  So your original patch was somewhat better after 
all, but I think it wasn't enough; for one it didn't handle the 32-bit 
case in a 64-bit kernel.

 What I think we want to do here is to draw a clear line between ELF32 and 
ELF64.  So first in include/linux/crash_dump.h:

#ifndef vmcore_elf32_check_arch
#define vmcore_elf32_check_arch elf_check_arch
#endif

and use `vmcore_elf32_check_arch' rather than `elf_check_arch' in 
`parse_crash_elf32_headers' in fs/proc/vmcore.c (I think the checks for 
ELFCLASS32/ELFCLASS64 ought to go first too, although that'd have to be a 
separate patch).

 Then we can redefine `vmcore_elf32_check_arch' and 
`vmcore_elf64_check_arch' along your first proposal (although we don't 
need to refer to `vmcore_elf_check_arch_cross' as we don't define it 
anyway).  However given that IIUC we're dealing with kernel rather than 
userland images here I think we want to skip all the ABI peculiarities and 
just accept anything that is compatible with the architecture.  It'll then 
be the business of whatever tool is going to handle this image to sort out 
the details.

 So to make things plain we just need:

#define mips_elf_check_machine(x) ((x)->e_machine == EM_MIPS)

#define vmcore_elf32_check_arch mips_elf_check_machine
#define vmcore_elf64_check_arch mips_elf_check_machine

in arch/mips/include/asm/elf.h (and then our definitions of 
`elf_check_arch' can be rewritten to use `mips_elf_check_machine' too, 
also in arch/mips/kernel/binfmt_elf?32.c).

 Questions or comments?

  Maciej

Received:  by oss.sgi.com id <S553742AbQKGC2Y>;
	Mon, 6 Nov 2000 18:28:24 -0800
Received: from u-245.karlsruhe.ipdial.viaginterkom.de ([62.180.10.245]:64263
        "EHLO u-245.karlsruhe.ipdial.viaginterkom.de") by oss.sgi.com
	with ESMTP id <S553711AbQKGC2U>; Mon, 6 Nov 2000 18:28:20 -0800
Received: (ralf@lappi) by lappi.waldorf-gmbh.de id <S868617AbQKGC2C>;
        Tue, 7 Nov 2000 03:28:02 +0100
Date:   Tue, 7 Nov 2000 03:28:02 +0100
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Jay Carlson <nop@nop.com>
Cc:     linux-mips@oss.sgi.com, linux-mips@fnet.fr
Subject: Re: kernel should not reject -mips2 ELF binaries
Message-ID: <20001107032802.D28567@bacchus.dhis.org>
References: <KEEOIBGCMINLAHMMNDJNEEDHCAAA.nop@nop.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <KEEOIBGCMINLAHMMNDJNEEDHCAAA.nop@nop.com>; from nop@nop.com on Mon, Nov 06, 2000 at 09:20:00PM -0500
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Mon, Nov 06, 2000 at 09:20:00PM -0500, Jay Carlson wrote:

> include/asm-mips/elf.h contains a macro, elf_check_arch, that decides if an
> executable is plausible to run under this kernel.  It currently accepts
> binaries flagged as MIPS1 ISA, and rejects all other ISAs.
> 
> #define elf_check_arch(hdr)						\
> ({									\
> 	int __res = 1;							\
> 	struct elfhdr *__h = (hdr);					\
> 									\
> 	if ((__h->e_machine != EM_MIPS) &&				\
> 	    (__h->e_machine != EM_MIPS_RS4_BE))				\
> 		__res = 0;						\
> 	if (__h->e_flags & EF_MIPS_ARCH)				\
> 		__res = 0;						\
> 									\
> 	__res;								\
> })
> 
> I think we should make an exception for MIPS2.  Turns out that the two Linux
> VR processor families benefit from some of the MIPS II features; most
> notably, code density is improved by eliminating load delay slots.  If I
> build executables that take advantage of this, they legitimately should be
> flagged with E_MIPS_ARCH_2 (since they won't run on my decstation).
> 
> So what's the right way to fix this?  Three things come to mind:
> 
> 1) rip out the EF_MIPS_ARCH check from elf_check_arch.

Take 1).  The problem we have is distiguishing Linux binaries from IRIX
binaries.  The code causing problems for you is a heuristic that no
longer works these days so I'll have to come up with something new.

  Ralf

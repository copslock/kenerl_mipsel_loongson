Received:  by oss.sgi.com id <S553692AbQKGCSP>;
	Mon, 6 Nov 2000 18:18:15 -0800
Received: from chmls20.mediaone.net ([24.147.1.156]:49886 "EHLO
        chmls20.mediaone.net") by oss.sgi.com with ESMTP id <S553657AbQKGCSC>;
	Mon, 6 Nov 2000 18:18:02 -0800
Received: from decoy (h00a0cc39f081.ne.mediaone.net [24.218.248.129])
	by chmls20.mediaone.net (8.8.7/8.8.7) with SMTP id VAA18468;
	Mon, 6 Nov 2000 21:18:00 -0500 (EST)
From:   "Jay Carlson" <nop@nop.com>
To:     <linux-mips@oss.sgi.com>, <linux-mips@fnet.fr>
Subject: kernel should not reject -mips2 ELF binaries
Date:   Mon, 6 Nov 2000 21:20:00 -0500
Message-ID: <KEEOIBGCMINLAHMMNDJNEEDHCAAA.nop@nop.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Importance: Normal
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

include/asm-mips/elf.h contains a macro, elf_check_arch, that decides if an
executable is plausible to run under this kernel.  It currently accepts
binaries flagged as MIPS1 ISA, and rejects all other ISAs.

#define elf_check_arch(hdr)						\
({									\
	int __res = 1;							\
	struct elfhdr *__h = (hdr);					\
									\
	if ((__h->e_machine != EM_MIPS) &&				\
	    (__h->e_machine != EM_MIPS_RS4_BE))				\
		__res = 0;						\
	if (__h->e_flags & EF_MIPS_ARCH)				\
		__res = 0;						\
									\
	__res;								\
})

I think we should make an exception for MIPS2.  Turns out that the two Linux
VR processor families benefit from some of the MIPS II features; most
notably, code density is improved by eliminating load delay slots.  If I
build executables that take advantage of this, they legitimately should be
flagged with E_MIPS_ARCH_2 (since they won't run on my decstation).

So what's the right way to fix this?  Three things come to mind:

1) rip out the EF_MIPS_ARCH check from elf_check_arch.
2) compare the value with E_MIPS_ARCH_1 and E_MIPS_ARCH_2
3) figure out what the capabilities of the current processor are and reject
E_MIPS_ARCH2 on R2/3000s.

I'd just go do #3 except it looks like a bigger pain than it's worth.  No
other linux kernel port goes to that amount of trouble, of course.

(I may do #1 or #2 in the Linux VR CVS as a stopgap.)

Jay

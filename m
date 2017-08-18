Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 19 Aug 2017 00:14:09 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:49041 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23994939AbdHRWNyXde7T (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 19 Aug 2017 00:13:54 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 27A9BFE6B6873;
        Fri, 18 Aug 2017 23:13:43 +0100 (IST)
Received: from [10.20.78.87] (10.20.78.87) by hhmail02.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server id 14.3.294.0; Fri, 18 Aug 2017
 23:13:46 +0100
Date:   Fri, 18 Aug 2017 23:13:39 +0100
From:   "Maciej W. Rozycki" <macro@imgtec.com>
To:     Paul Burton <paul.burton@imgtec.com>
CC:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH] MIPS: Set ISA bit in entry-y for microMIPS kernels
In-Reply-To: <8259872.Nrvp2QXiRE@np-p-burton>
Message-ID: <alpine.DEB.2.00.1708181944260.17596@tp.orcam.me.uk>
References: <20170807231647.19551-1-paul.burton@imgtec.com> <alpine.DEB.2.00.1708181302480.17596@tp.orcam.me.uk> <alpine.DEB.2.00.1708181731080.17596@tp.orcam.me.uk> <8259872.Nrvp2QXiRE@np-p-burton>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.20.78.87]
Return-Path: <Maciej.Rozycki@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59692
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

Hi Paul,

> I originally did this [1], and wrote about it in the post-three-dashes notes 
> for this patch. To quote myself:
> 
> > I originally tried using "objdump -f" to obtain the entry address, which
> > works for microMIPS but it always outputs a 32 bit address for a 32 bit
> > ELF whilst nm will sign extend to 64 bit. That matters for systems where
> > we might want to run a MIPS32 kernel on a MIPS64 CPU & load it with a
> > MIPS64 bootloader, which would then jump to a non-canonical
> > (non-sign-extended) address.
> > 
> > This works in all cases as it only changes the behaviour for microMIPS
> > kernels, but isn't the prettiest solution. A possible alternative would
> > be to write a custom tool to just extract, sign extend & print the entry
> > point of an ELF executable. I'm open to feedback if that would be
> > preferred.
> 
> So if we were to use objdump we'd need to handle sign extending 32 bit 
> addresses to form a canonical address. Perhaps that'd be cleaner though.

 Hmm, your reasoning sounds right (and I was blind to miss it entirely, 
sorry), however reality seems to disagree.  As at 5fc9484f5e41^ I get:

make -f ./scripts/Makefile.build obj=arch/mips/boot VMLINUX=vmlinux \
		VMLINUX_LOAD_ADDRESS=0xffffffff80100000 VMLINUX_ENTRY_ADDRESS=0x804fca20 PLATFORM="generic/" ADDR_BITS=32 arch/mips/boot/vmlinux.srec

whereas at 5fc9484f5e41^ I get:

make -f ./scripts/Makefile.build obj=arch/mips/boot VMLINUX=vmlinux \
		VMLINUX_LOAD_ADDRESS=0xffffffff80100000 VMLINUX_ENTRY_ADDRESS=0x804fca21 PLATFORM="generic/" ADDR_BITS=32 arch/mips/boot/vmlinux.srec

so in both cases the entry address is 32-bit, which is why I didn't see 
any disadvantage from using `objdump -f'.  Indeed:

$ mips-linux-gnu-nm vmlinux | grep kernel_entry
80100000 T __kernel_entry
804fca20 T kernel_entry
$ mips-mti-linux-gnu-nm vmlinux | grep kernel_entry
ffffffff80100000 T __kernel_entry
ffffffff804fca20 T kernel_entry
$ 

which means you can't rely on `nm' sign-extending addresses to 64 bits 
with 32-bit binaries.  And it looks like a bug to me indeed that some 
versions of `nm' do such sign-extension, unlike `objdump' and `readelf'.  
I'll have to bisect it to see when it started happening and take it with 
upstream binutils.

 How about this version then?  It does the right thing for me:

make -f ./scripts/Makefile.build obj=arch/mips/boot VMLINUX=vmlinux \
		VMLINUX_LOAD_ADDRESS=0xffffffff80100000 VMLINUX_ENTRY_ADDRESS=0xffffffff804fca21 PLATFORM="generic/" ADDR_BITS=32 arch/mips/boot/vmlinux.srec

and given than we need to sign-extend in either case I think retrieving 
the canonical entry point rather than transforming the entry symbol is 
simpler and more reliable.

  Maciej

---
 arch/mips/Makefile |   19 +++++--------------
 1 file changed, 5 insertions(+), 14 deletions(-)

linux-mips-start-address.diff
Index: linux-sfr-usead/arch/mips/Makefile
===================================================================
--- linux-sfr-usead.orig/arch/mips/Makefile	2017-08-18 22:17:42.962681000 +0100
+++ linux-sfr-usead/arch/mips/Makefile	2017-08-18 23:01:00.997846000 +0100
@@ -244,20 +244,11 @@ ifdef CONFIG_PHYSICAL_START
 load-y					= $(CONFIG_PHYSICAL_START)
 endif
 
-entry-noisa-y				= 0x$(shell $(NM) vmlinux 2>/dev/null \
-					| grep "\bkernel_entry\b" | cut -f1 -d \ )
-ifdef CONFIG_CPU_MICROMIPS
-  #
-  # Set the ISA bit, since the kernel_entry symbol in the ELF will have it
-  # clear which would lead to images containing addresses which bootloaders may
-  # jump to as MIPS32 code.
-  #
-  entry-y = $(patsubst %0,%1,$(patsubst %2,%3,$(patsubst %4,%5, \
-              $(patsubst %6,%7,$(patsubst %8,%9,$(patsubst %a,%b, \
-              $(patsubst %c,%d,$(patsubst %e,%f,$(entry-noisa-y)))))))))
-else
-  entry-y = $(entry-noisa-y)
-endif
+# Knowing that a 32-bit kernel will be linked at a KSEG address
+# sign-extend the entry point to 64 bits if retrieved as a 32-bit
+# number by stuffing `ffffffff' after the leading `0x'.
+entry-y	= $(shell $(OBJDUMP) -f vmlinux 2>/dev/null \
+	| sed -n 's/0x\(........\)$$/0xffffffff\1/;s/start address //p')
 
 cflags-y			+= -I$(srctree)/arch/mips/include/asm/mach-generic
 drivers-$(CONFIG_PCI)		+= arch/mips/pci/

Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 21 Aug 2017 20:18:45 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:49700 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23995041AbdHUSSi3sgiW (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 21 Aug 2017 20:18:38 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id C97ACD06917A1;
        Mon, 21 Aug 2017 19:18:26 +0100 (IST)
Received: from [10.20.78.104] (10.20.78.104) by hhmail02.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server id 14.3.294.0; Mon, 21 Aug 2017
 19:18:29 +0100
Date:   Mon, 21 Aug 2017 19:18:19 +0100
From:   "Maciej W. Rozycki" <macro@imgtec.com>
To:     James Hogan <james.hogan@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>
CC:     <linux-mips@linux-mips.org>, Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH] MIPS: Use `objdump -f' to get the kernel's entry point for
 the boot loader
In-Reply-To: <A75389BC-A9E2-4E30-AD90-49F4F7B9EC83@imgtec.com>
Message-ID: <alpine.DEB.2.00.1708211905010.17596@tp.orcam.me.uk>
References: <20170807231647.19551-1-paul.burton@imgtec.com> <alpine.DEB.2.00.1708181302480.17596@tp.orcam.me.uk> <alpine.DEB.2.00.1708181731080.17596@tp.orcam.me.uk> <8259872.Nrvp2QXiRE@np-p-burton> <alpine.DEB.2.00.1708181944260.17596@tp.orcam.me.uk>
 <A75389BC-A9E2-4E30-AD90-49F4F7B9EC83@imgtec.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.20.78.104]
Return-Path: <Maciej.Rozycki@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59739
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

Rather than trying to reconstruct the ISA bit by hand use the ELF entry 
point recorded in the kernel executable itself, by parsing the output of 
`objdump -f' and sign-extending the address retrieved if 32-bit.  The 
tool always prints the entry point using either 8 or 16 hexadecimal 
digits even in the presence of leading zeros, matching the address width 
(class) of the ELF file.

Signed-off-by: Maciej W. Rozycki <macro@imgtec.com>
---
On Sat, 19 Aug 2017, James Hogan wrote:

> >+# Knowing that a 32-bit kernel will be linked at a KSEG address
> 
> thats not true with CONFIG_KVM_GUEST kernels, which use a separate set 
> of emulated guest kernel segments in useg, i.e. at 0x40000000. I've also 
> seen EVA kernels linked at low addresses like around 0x20000000, though 
> entry gets a bit fiddly for EVA depending on whether bootloader already 
> has the chosen segment configuration set up.

 I wasn't aware of that.  So we need a slightly more robust `sed' program, 
like the below.  It handles any 32-bit address now.  I hope the formatting
is fine.

 Please apply.

  Maciej

---
 arch/mips/Makefile |   19 +++++--------------
 1 file changed, 5 insertions(+), 14 deletions(-)

linux-mips-start-address.diff
Index: linux-sfr-usead/arch/mips/Makefile
===================================================================
--- linux-sfr-usead.orig/arch/mips/Makefile	2017-08-18 22:17:42.962681000 +0100
+++ linux-sfr-usead/arch/mips/Makefile	2017-08-21 17:47:16.802753000 +0100
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
+# Sign-extend the entry point to 64 bits if retrieved as a 32-bit number.
+entry-y		= $(shell $(OBJDUMP) -f vmlinux 2>/dev/null \
+			| sed -n '/^start address / { \
+				s/^.*0x\([0-7].......\)$$/0x00000000\1/; \
+				s/^.*0x\(........\)$$/0xffffffff\1/; p }')
 
 cflags-y			+= -I$(srctree)/arch/mips/include/asm/mach-generic
 drivers-$(CONFIG_PCI)		+= arch/mips/pci/

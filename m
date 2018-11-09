Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Nov 2018 20:04:27 +0100 (CET)
Received: from tartarus.angband.pl ([IPv6:2001:41d0:602:dbe::8]:49374 "EHLO
        tartarus.angband.pl" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993041AbeKITDpEe1RW (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 9 Nov 2018 20:03:45 +0100
Received: from 89-64-163-218.dynamic.chello.pl ([89.64.163.218] helo=barad-dur.angband.pl)
        by tartarus.angband.pl with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <kilobyte@angband.pl>)
        id 1gLC3x-00053r-Sg; Fri, 09 Nov 2018 20:03:27 +0100
Received: from kholdan.angband.pl ([2001:470:64f4::5])
        by barad-dur.angband.pl with smtp (Exim 4.89)
        (envelope-from <kilobyte@angband.pl>)
        id 1gLC3w-0005A4-Bc; Fri, 09 Nov 2018 20:03:25 +0100
Received: by kholdan.angband.pl (sSMTP sendmail emulation); Fri, 09 Nov 2018 20:03:24 +0100
From:   Adam Borowski <kilobyte@angband.pl>
To:     linux-kernel@vger.kernel.org, Nick Terrell <terrelln@fb.com>,
        Russell King <linux@armlinux.org.uk>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Stafford Horne <shorne@gmail.com>,
        openrisc@lists.librecores.org,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        linux-s390@vger.kernel.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        linux-xtensa@linux-xtensa.org
Cc:     Adam Borowski <kilobyte@angband.pl>
Date:   Fri,  9 Nov 2018 20:02:56 +0100
Message-Id: <20181109190304.8573-9-kilobyte@angband.pl>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181109190304.8573-1-kilobyte@angband.pl>
References: <20181109185953.xwyelyqnygbskkxk@angband.pl>
 <20181109190304.8573-1-kilobyte@angband.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 89.64.163.218
X-SA-Exim-Mail-From: kilobyte@angband.pl
Subject: [PATCH 09/17] unicore32: Remove support for BZIP2 and LZMA compressed kernel
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on tartarus.angband.pl)
Return-Path: <kilobyte@angband.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67209
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kilobyte@angband.pl
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

Made redundant by newer choices -- sort of, as no one enabled support
for XZ nor ZSTD for unicore yet...

Signed-off-by: Adam Borowski <kilobyte@angband.pl>
---
 arch/unicore32/Kconfig                  | 2 --
 arch/unicore32/boot/compressed/Makefile | 4 +---
 arch/unicore32/boot/compressed/misc.c   | 8 --------
 3 files changed, 1 insertion(+), 13 deletions(-)

diff --git a/arch/unicore32/Kconfig b/arch/unicore32/Kconfig
index a4c05159dca5..b7eb7e9fb0d2 100644
--- a/arch/unicore32/Kconfig
+++ b/arch/unicore32/Kconfig
@@ -7,10 +7,8 @@ config UNICORE32
 	select DMA_DIRECT_OPS
 	select HAVE_GENERIC_DMA_COHERENT
 	select HAVE_KERNEL_GZIP
-	select HAVE_KERNEL_BZIP2
 	select GENERIC_ATOMIC64
 	select HAVE_KERNEL_LZO
-	select HAVE_KERNEL_LZMA
 	select VIRT_TO_BUS
 	select ARCH_HAVE_CUSTOM_GPIO_H
 	select GENERIC_FIND_FIRST_BIT
diff --git a/arch/unicore32/boot/compressed/Makefile b/arch/unicore32/boot/compressed/Makefile
index 9aecdd3ddc48..79ff908ad78c 100644
--- a/arch/unicore32/boot/compressed/Makefile
+++ b/arch/unicore32/boot/compressed/Makefile
@@ -22,9 +22,7 @@ $(obj)/font.c: $(srctree)/lib/fonts/font_8x8.c
 
 # piggy.S and piggy.o
 suffix_$(CONFIG_KERNEL_GZIP)	:= gzip
-suffix_$(CONFIG_KERNEL_BZIP2)	:= bz2
 suffix_$(CONFIG_KERNEL_LZO)	:= lzo
-suffix_$(CONFIG_KERNEL_LZMA)	:= lzma
 
 $(obj)/piggy.$(suffix_y): $(obj)/../Image FORCE
 	$(call if_changed,$(suffix_y))
@@ -39,7 +37,7 @@ targets		:= vmlinux vmlinux.lds font.o font.c head.o misc.o \
 			piggy.$(suffix_y) piggy.o piggy.S \
 
 # Make sure files are removed during clean
-extra-y		+= piggy.gzip piggy.bz2 piggy.lzo piggy.lzma
+extra-y		+= piggy.gzip piggy.lzo
 
 # ?
 LDFLAGS_vmlinux += -p
diff --git a/arch/unicore32/boot/compressed/misc.c b/arch/unicore32/boot/compressed/misc.c
index 5c65dfee278c..ab9b56cf6907 100644
--- a/arch/unicore32/boot/compressed/misc.c
+++ b/arch/unicore32/boot/compressed/misc.c
@@ -91,18 +91,10 @@ void error(char *x)
 #include "../../../../lib/decompress_inflate.c"
 #endif
 
-#ifdef CONFIG_KERNEL_BZIP2
-#include "../../../../lib/decompress_bunzip2.c"
-#endif
-
 #ifdef CONFIG_KERNEL_LZO
 #include "../../../../lib/decompress_unlzo.c"
 #endif
 
-#ifdef CONFIG_KERNEL_LZMA
-#include "../../../../lib/decompress_unlzma.c"
-#endif
-
 unsigned long decompress_kernel(unsigned long output_start,
 		unsigned long free_mem_ptr_p,
 		unsigned long free_mem_ptr_end_p)
-- 
2.19.1

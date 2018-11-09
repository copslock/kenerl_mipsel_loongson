Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Nov 2018 20:03:45 +0100 (CET)
Received: from tartarus.angband.pl ([IPv6:2001:41d0:602:dbe::8]:48846 "EHLO
        tartarus.angband.pl" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992918AbeKITD3bAJpW (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 9 Nov 2018 20:03:29 +0100
Received: from 89-64-163-218.dynamic.chello.pl ([89.64.163.218] helo=barad-dur.angband.pl)
        by tartarus.angband.pl with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <kilobyte@angband.pl>)
        id 1gLC3t-00052m-Rv; Fri, 09 Nov 2018 20:03:23 +0100
Received: from kholdan.angband.pl ([2001:470:64f4::5])
        by barad-dur.angband.pl with smtp (Exim 4.89)
        (envelope-from <kilobyte@angband.pl>)
        id 1gLC3s-00059v-BH; Fri, 09 Nov 2018 20:03:21 +0100
Received: by kholdan.angband.pl (sSMTP sendmail emulation); Fri, 09 Nov 2018 20:03:20 +0100
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
Date:   Fri,  9 Nov 2018 20:02:53 +0100
Message-Id: <20181109190304.8573-6-kilobyte@angband.pl>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181109190304.8573-1-kilobyte@angband.pl>
References: <20181109185953.xwyelyqnygbskkxk@angband.pl>
 <20181109190304.8573-1-kilobyte@angband.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 89.64.163.218
X-SA-Exim-Mail-From: kilobyte@angband.pl
Subject: [PATCH 06/17] parisc: Remove support for BZIP2 and LZMA compressed kernel
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on tartarus.angband.pl)
Return-Path: <kilobyte@angband.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67198
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

Made redundant by newer choices.

Signed-off-by: Adam Borowski <kilobyte@angband.pl>
---
 arch/parisc/Kconfig                  |  2 --
 arch/parisc/boot/compressed/Makefile | 10 ++--------
 arch/parisc/boot/compressed/misc.c   |  8 --------
 3 files changed, 2 insertions(+), 18 deletions(-)

diff --git a/arch/parisc/Kconfig b/arch/parisc/Kconfig
index 92a339ee28b3..a9cca7d1a8d8 100644
--- a/arch/parisc/Kconfig
+++ b/arch/parisc/Kconfig
@@ -18,10 +18,8 @@ config PARISC
 	select BUG
 	select BUILDTIME_EXTABLE_SORT
 	select HAVE_PERF_EVENTS
-	select HAVE_KERNEL_BZIP2
 	select HAVE_KERNEL_GZIP
 	select HAVE_KERNEL_LZ4
-	select HAVE_KERNEL_LZMA
 	select HAVE_KERNEL_LZO
 	select HAVE_KERNEL_XZ
 	select GENERIC_ATOMIC64 if !64BIT
diff --git a/arch/parisc/boot/compressed/Makefile b/arch/parisc/boot/compressed/Makefile
index 777533cdea31..a05f36f9279b 100644
--- a/arch/parisc/boot/compressed/Makefile
+++ b/arch/parisc/boot/compressed/Makefile
@@ -8,8 +8,8 @@ KCOV_INSTRUMENT := n
 GCOV_PROFILE := n
 UBSAN_SANITIZE := n
 
-targets := vmlinux.lds vmlinux vmlinux.bin vmlinux.bin.gz vmlinux.bin.bz2
-targets += vmlinux.bin.xz vmlinux.bin.lzma vmlinux.bin.lzo vmlinux.bin.lz4
+targets := vmlinux.lds vmlinux vmlinux.bin vmlinux.bin.gz
+targets += vmlinux.bin.xz vmlinux.bin.lzo vmlinux.bin.lz4
 targets += misc.o piggy.o sizes.h head.o real2.o firmware.o
 
 KBUILD_CFLAGS := -D__KERNEL__ -O2 -DBOOTLOADER
@@ -60,20 +60,14 @@ $(obj)/vmlinux.bin: vmlinux
 vmlinux.bin.all-y := $(obj)/vmlinux.bin
 
 suffix-$(CONFIG_KERNEL_GZIP)  := gz
-suffix-$(CONFIG_KERNEL_BZIP2) := bz2
 suffix-$(CONFIG_KERNEL_LZ4)  := lz4
-suffix-$(CONFIG_KERNEL_LZMA)  := lzma
 suffix-$(CONFIG_KERNEL_LZO)  := lzo
 suffix-$(CONFIG_KERNEL_XZ)  := xz
 
 $(obj)/vmlinux.bin.gz: $(vmlinux.bin.all-y)
 	$(call if_changed,gzip)
-$(obj)/vmlinux.bin.bz2: $(vmlinux.bin.all-y)
-	$(call if_changed,bzip2)
 $(obj)/vmlinux.bin.lz4: $(vmlinux.bin.all-y)
 	$(call if_changed,lz4)
-$(obj)/vmlinux.bin.lzma: $(vmlinux.bin.all-y)
-	$(call if_changed,lzma)
 $(obj)/vmlinux.bin.lzo: $(vmlinux.bin.all-y)
 	$(call if_changed,lzo)
 $(obj)/vmlinux.bin.xz: $(vmlinux.bin.all-y)
diff --git a/arch/parisc/boot/compressed/misc.c b/arch/parisc/boot/compressed/misc.c
index 2556bb181813..1ca59916071e 100644
--- a/arch/parisc/boot/compressed/misc.c
+++ b/arch/parisc/boot/compressed/misc.c
@@ -42,18 +42,10 @@ static unsigned long free_mem_end_ptr;
 #include "../../../../lib/decompress_inflate.c"
 #endif
 
-#ifdef CONFIG_KERNEL_BZIP2
-#include "../../../../lib/decompress_bunzip2.c"
-#endif
-
 #ifdef CONFIG_KERNEL_LZ4
 #include "../../../../lib/decompress_unlz4.c"
 #endif
 
-#ifdef CONFIG_KERNEL_LZMA
-#include "../../../../lib/decompress_unlzma.c"
-#endif
-
 #ifdef CONFIG_KERNEL_LZO
 #include "../../../../lib/decompress_unlzo.c"
 #endif
-- 
2.19.1

Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Apr 2016 10:58:59 +0200 (CEST)
Received: from mail-lf0-f50.google.com ([209.85.215.50]:35764 "EHLO
        mail-lf0-f50.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27027118AbcDTI65yntP7 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 20 Apr 2016 10:58:57 +0200
Received: by mail-lf0-f50.google.com with SMTP id c126so36744422lfb.2
        for <linux-mips@linux-mips.org>; Wed, 20 Apr 2016 01:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cUdJ/nDlq9vhDL9Fb4tQ6VFL04ZuO6YU5IRPRPKtTNs=;
        b=gye5uiRwv3o1rpQdkiEGQLOumICXSxboB/LkV1YBCs4n+Og9R/KwMihaLJ7eeQvgS1
         KhYrTQ2OpO8QNT05nsj58tp5j04gUJ3lNhpD/BgDcS3usD7w5ziQ7bFVRthvgYEwBsZB
         EhpMuVzzPPNiL4qbjBbQzDFT/zTEgjvqF2P9E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cUdJ/nDlq9vhDL9Fb4tQ6VFL04ZuO6YU5IRPRPKtTNs=;
        b=giFge4v4wYU/ilHVNr3p6MDpf9kTI5+nSOOFalU0qe4CXU41g4Zz614+QcDM07dqNa
         I0goMwZnD45iz1jv79iVyoO3wCKRpoKEJXli/B4/RM8xakHlYHVfGweK5IzhXkQBUyOf
         xUiwOeLFtS7Cey2X+nqyd2pt/7VAisB8FWj9nsLEv5KU846EMe/YIkxOE/IMCmLfehyu
         G9x7TJh+xtYPMj9MGu550pzCeN8l7Asc0a+8VrqJK7JVPXe9+UvuDW8DrXMVyMXpsxK3
         7qXoqeaPsiT8Tv186TNYx8pg9WCqwpN5lq4KHzHYRyJmmGdeKIHvME5+XDR1JYqvXZNf
         uong==
X-Gm-Message-State: AOPr4FW/gHsOQsTw20i1tbAfI/PoZmkGSnXEh2LLqZeLx1X1VwjmR3GMluBGvkJmsufMFYHy
X-Received: by 10.25.18.152 with SMTP id 24mr3186653lfs.154.1461142732355;
        Wed, 20 Apr 2016 01:58:52 -0700 (PDT)
Received: from localhost.localdomain ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id z8sm849934lbv.42.2016.04.20.01.58.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Apr 2016 01:58:51 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     linux-gpio@vger.kernel.org, Alexandre Courbot <acourbot@nvidia.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        =?UTF-8?q?Michael=20B=C3=BCsch?= <m@bues.ch>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: [PATCH 10/23] MIPS: do away with ARCH_[WANT_OPTIONAL|REQUIRE]_GPIOLIB
Date:   Wed, 20 Apr 2016 10:58:08 +0200
Message-Id: <1461142701-21096-11-git-send-email-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.4.11
In-Reply-To: <1461142701-21096-1-git-send-email-linus.walleij@linaro.org>
References: <1461142701-21096-1-git-send-email-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <linus.walleij@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53119
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linus.walleij@linaro.org
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

This replaces:

- "select ARCH_REQUIRE_GPIOLIB" with "select GPIOLIB" as this can
  now be selected directly.

- "select ARCH_WANT_OPTIONAL_GPIOLIB" with no dependency: GPIOLIB
  is now selectable by everyone, so we need not declare our
  intent to select it.

When ordering the symbols the following rationale was used:
if the selects were in alphabetical order, I moved select GPIOLIB
to be in alphabetical order, but if the selects were not
maintained in alphabetical order, I just replaced
"select ARCH_REQUIRE_GPIOLIB" with "select GPIOLIB".

Cc: Michael Büsch <m@bues.ch>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Various arch maintainers:

either ACK this and I will merge it into the GPIO tree for v4.7
anticipating no clashes, or you wait until I have the enabling patch
upstream (patch 1 in this series, removing deps on
ARCH_[WANTS_OPTIONAL|REQUIRES]_GPIOLIB), and you will be able to
merge it to your arch trees yourselves for late v4.7
(post GPIO tree merge) or for v4.8.

You can also ask me for an immutable branch if you prefer that, I
will put the enabling patch on a branch and the patch for your arch
on top and ask you to pull it.

Select your option from the menu, silence probably means I will
merge it to the GPIO tree. Unless you are X86 or ARM in which case
I will be cautious.
---
 arch/mips/Kconfig         | 32 +++++++++++++++-----------------
 arch/mips/alchemy/Kconfig |  2 +-
 arch/mips/pic32/Kconfig   |  2 +-
 3 files changed, 17 insertions(+), 19 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 2018c2b0e078..512b5def854d 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -79,7 +79,7 @@ config MIPS_ALCHEMY
 	select SYS_HAS_CPU_MIPS32_R1
 	select SYS_SUPPORTS_32BIT_KERNEL
 	select SYS_SUPPORTS_APM_EMULATION
-	select ARCH_REQUIRE_GPIOLIB
+	select GPIOLIB
 	select SYS_SUPPORTS_ZBOOT
 	select COMMON_CLK
 
@@ -98,7 +98,7 @@ config AR7
 	select SYS_SUPPORTS_LITTLE_ENDIAN
 	select SYS_SUPPORTS_MIPS16
 	select SYS_SUPPORTS_ZBOOT_UART16550
-	select ARCH_REQUIRE_GPIOLIB
+	select GPIOLIB
 	select VLYNQ
 	select HAVE_CLK
 	help
@@ -122,11 +122,11 @@ config ATH25
 config ATH79
 	bool "Atheros AR71XX/AR724X/AR913X based boards"
 	select ARCH_HAS_RESET_CONTROLLER
-	select ARCH_REQUIRE_GPIOLIB
 	select BOOT_RAW
 	select CEVT_R4K
 	select CSRC_R4K
 	select DMA_NONCOHERENT
+	select GPIOLIB
 	select HAVE_CLK
 	select COMMON_CLK
 	select CLKDEV_LOOKUP
@@ -170,7 +170,6 @@ config BMIPS_GENERIC
 	select USB_EHCI_BIG_ENDIAN_MMIO if CPU_BIG_ENDIAN
 	select USB_OHCI_BIG_ENDIAN_DESC if CPU_BIG_ENDIAN
 	select USB_OHCI_BIG_ENDIAN_MMIO if CPU_BIG_ENDIAN
-	select ARCH_WANT_OPTIONAL_GPIOLIB
 	help
 	  Build a generic DT-based kernel image that boots on select
 	  BCM33xx cable modem chips, BCM63xx DSL chips, and BCM7xxx set-top
@@ -179,7 +178,6 @@ config BMIPS_GENERIC
 
 config BCM47XX
 	bool "Broadcom BCM47XX based boards"
-	select ARCH_WANT_OPTIONAL_GPIOLIB
 	select BOOT_RAW
 	select CEVT_R4K
 	select CSRC_R4K
@@ -211,7 +209,7 @@ config BCM63XX
 	select SYS_SUPPORTS_BIG_ENDIAN
 	select SYS_HAS_EARLY_PRINTK
 	select SWAP_IO_SPACE
-	select ARCH_REQUIRE_GPIOLIB
+	select GPIOLIB
 	select HAVE_CLK
 	select MIPS_L1_CACHE_SHIFT_4
 	help
@@ -305,7 +303,7 @@ config MACH_INGENIC
 	select SYS_SUPPORTS_ZBOOT_UART16550
 	select DMA_NONCOHERENT
 	select IRQ_MIPS_CPU
-	select ARCH_REQUIRE_GPIOLIB
+	select GPIOLIB
 	select COMMON_CLK
 	select GENERIC_IRQ_CHIP
 	select BUILTIN_DTB
@@ -325,7 +323,7 @@ config LANTIQ
 	select SYS_SUPPORTS_MIPS16
 	select SYS_SUPPORTS_MULTITHREADING
 	select SYS_HAS_EARLY_PRINTK
-	select ARCH_REQUIRE_GPIOLIB
+	select GPIOLIB
 	select SWAP_IO_SPACE
 	select BOOT_RAW
 	select CLKDEV_LOOKUP
@@ -377,7 +375,6 @@ config MACH_LOONGSON64
 
 config MACH_PISTACHIO
 	bool "IMG Pistachio SoC based boards"
-	select ARCH_REQUIRE_GPIOLIB
 	select BOOT_ELF32
 	select BOOT_RAW
 	select CEVT_R4K
@@ -385,6 +382,7 @@ config MACH_PISTACHIO
 	select COMMON_CLK
 	select CSRC_R4K
 	select DMA_MAYBE_COHERENT
+	select GPIOLIB
 	select IRQ_MIPS_CPU
 	select LIBFDT
 	select MFD_SYSCON
@@ -406,13 +404,13 @@ config MACH_PISTACHIO
 
 config MACH_XILFPGA
 	bool "MIPSfpga Xilinx based boards"
-	select ARCH_REQUIRE_GPIOLIB
 	select BOOT_ELF32
 	select BOOT_RAW
 	select BUILTIN_DTB
 	select CEVT_R4K
 	select COMMON_CLK
 	select CSRC_R4K
+	select GPIOLIB
 	select IRQ_MIPS_CPU
 	select LIBFDT
 	select MIPS_CPU_SCACHE
@@ -536,7 +534,7 @@ config MACH_VR41XX
 	select CSRC_R4K
 	select SYS_HAS_CPU_VR41XX
 	select SYS_SUPPORTS_MIPS16
-	select ARCH_REQUIRE_GPIOLIB
+	select GPIOLIB
 
 config NXP_STB220
 	bool "NXP STB220 board"
@@ -856,7 +854,7 @@ config MIKROTIK_RB532
 	select SYS_SUPPORTS_LITTLE_ENDIAN
 	select SWAP_IO_SPACE
 	select BOOT_RAW
-	select ARCH_REQUIRE_GPIOLIB
+	select GPIOLIB
 	select MIPS_L1_CACHE_SHIFT_4
 	help
 	  Support the Mikrotik(tm) RouterBoard 532 series,
@@ -879,7 +877,7 @@ config CAVIUM_OCTEON_SOC
 	select HW_HAS_PCI
 	select ZONE_DMA32
 	select HOLES_IN_ZONE
-	select ARCH_REQUIRE_GPIOLIB
+	select GPIOLIB
 	select LIBFDT
 	select USE_OF
 	select ARCH_SPARSEMEM_ENABLE
@@ -937,7 +935,7 @@ config NLM_XLP_BOARD
 	select SYS_SUPPORTS_32BIT_KERNEL
 	select SYS_SUPPORTS_64BIT_KERNEL
 	select ARCH_PHYS_ADDR_T_64BIT
-	select ARCH_REQUIRE_GPIOLIB
+	select GPIOLIB
 	select SYS_SUPPORTS_BIG_ENDIAN
 	select SYS_SUPPORTS_LITTLE_ENDIAN
 	select SYS_SUPPORTS_HIGHMEM
@@ -1077,7 +1075,7 @@ config MIPS_CLOCK_VSYSCALL
 	def_bool CSRC_R4K || CLKSRC_MIPS_GIC
 
 config GPIO_TXX9
-	select ARCH_REQUIRE_GPIOLIB
+	select GPIOLIB
 	bool
 
 config FW_CFE
@@ -1342,7 +1340,7 @@ config CPU_LOONGSON3
 	select CPU_SUPPORTS_HUGEPAGES
 	select WEAK_ORDERING
 	select WEAK_REORDERING_BEYOND_LLSC
-	select ARCH_REQUIRE_GPIOLIB
+	select GPIOLIB
 	help
 		The Loongson 3 processor implements the MIPS64R2 instruction
 		set with many extensions.
@@ -1362,7 +1360,7 @@ config CPU_LOONGSON2F
 	bool "Loongson 2F"
 	depends on SYS_HAS_CPU_LOONGSON2F
 	select CPU_LOONGSON2
-	select ARCH_REQUIRE_GPIOLIB
+	select GPIOLIB
 	help
 	  The Loongson 2F processor implements the MIPS III instruction set
 	  with many extensions.
diff --git a/arch/mips/alchemy/Kconfig b/arch/mips/alchemy/Kconfig
index 7fa24881b708..88b4d6a792c1 100644
--- a/arch/mips/alchemy/Kconfig
+++ b/arch/mips/alchemy/Kconfig
@@ -20,7 +20,7 @@ config MIPS_MTX1
 
 config MIPS_DB1XXX
 	bool "Alchemy DB1XXX / PB1XXX boards"
-	select ARCH_REQUIRE_GPIOLIB
+	select GPIOLIB
 	select HW_HAS_PCI
 	select SYS_SUPPORTS_LITTLE_ENDIAN
 	select SYS_HAS_EARLY_PRINTK
diff --git a/arch/mips/pic32/Kconfig b/arch/mips/pic32/Kconfig
index 1985971b9890..527d37da05ac 100644
--- a/arch/mips/pic32/Kconfig
+++ b/arch/mips/pic32/Kconfig
@@ -14,7 +14,7 @@ config PIC32MZDA
 	select SYS_HAS_EARLY_PRINTK
 	select SYS_SUPPORTS_32BIT_KERNEL
 	select SYS_SUPPORTS_LITTLE_ENDIAN
-	select ARCH_REQUIRE_GPIOLIB
+	select GPIOLIB
 	select COMMON_CLK
 	select CLKDEV_LOOKUP
 	select LIBFDT
-- 
2.4.11

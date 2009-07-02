Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Jul 2009 17:33:54 +0200 (CEST)
Received: from mail-ew0-f214.google.com ([209.85.219.214]:36186 "EHLO
	mail-ew0-f214.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492214AbZGBPdr (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 2 Jul 2009 17:33:47 +0200
Received: by ewy10 with SMTP id 10so2102239ewy.0
        for <multiple recipients>; Thu, 02 Jul 2009 08:27:56 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=c3vhbPvHysBLuDCzyKJDYhRqoY7N3vcTbhyInkiDtVA=;
        b=H8Yqb3yjbe2cWtYpiU2LM6rzqj8+8bCea/96fnPwqG4rVgqyhepyRRvAYz+vh3E2Vd
         0bHFM6LTbX4LZKmb8n/BV8Vcp0Lz7qg2Y8pyo9hlAlq1psPaFT+B4KFKzwoCgAA2dH/m
         6tyueAp2ZvukAWDXzdmqDHYKxop+H0QjStLNM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Hvu/Ud5rTebMHzmywB/ylhM+TdxhkUcJiiVAg5TTlockesb14hKy9ivnmtMIphOHty
         lWwKK+/DOx5ZVS3Uh+KEaBOBAGLrE9AkTFVeXXcGmwlBiWUMoqMzP2MK7HjJHKFrg9Zx
         bhQnMlnciOowRpRNjaP8m/WncriCVYIdLjRt0=
Received: by 10.210.126.18 with SMTP id y18mr1077447ebc.87.1246548476738;
        Thu, 02 Jul 2009 08:27:56 -0700 (PDT)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id 23sm2131239eya.59.2009.07.02.08.27.49
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 02 Jul 2009 08:27:55 -0700 (PDT)
From:	Wu Zhangjin <wuzhangjin@gmail.com>
To:	linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
	ralf@linux-mips.org
Cc:	Wu Zhangjin <wuzhangjin@gmail.com>, Yan Hua <yanh@lemote.com>,
	Philippe Vachon <philippe@cowpig.ca>,
	Zhang Le <r0bertz@gentoo.org>,
	Zhang Fuxin <zhangfx@lemote.com>,
	loongson-dev <loongson-dev@googlegroups.com>,
	Liu Junliang <liujl@lemote.com>,
	Erwan Lerale <erwan@thiscow.com>,
	Arnaud Patard <apatard@mandriva.com>
Subject: [PATCH v4 15/16] [loongson] add gcc 4.4 support for Loongson2E
Date:	Thu,  2 Jul 2009 23:27:41 +0800
Message-Id: <c99f466b537534606e679fd21e06f19838dfd79d.1246546684.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.2.1
In-Reply-To: <cover.1246546684.git.wuzhangjin@gmail.com>
References: <cover.1246546684.git.wuzhangjin@gmail.com>
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23627
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

because only gcc >=4.4 have loongson-specific support, we need to choose
the suitable -march argument for gcc <= 4.3 and gcc >= 4.4, and here, we
use -march=loongson2e for loongson2e.

thanks goes to Arnaud Patard <apatard@mandriva.com> for suggestion of
using cc-options(Documentation/kbuild/makefiles.txt). and thanks Zhang
Le for introducing the new CPU_LOONGSON2E kernel option.

NOTE: -mtune option is not need if -march and -mtune use the same value.

Signed-off-by: Zhang Le <r0bertz@gentoo.org>
Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 arch/mips/Kconfig          |   18 +++++++++++-------
 arch/mips/Makefile         |    6 +++++-
 arch/mips/loongson/Kconfig |    2 +-
 3 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 482dcc3..466920a 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1030,12 +1030,10 @@ choice
 	prompt "CPU type"
 	default CPU_R4X00
 
-config CPU_LOONGSON2
-	bool "Loongson 2"
-	depends on SYS_HAS_CPU_LOONGSON2
-	select CPU_SUPPORTS_32BIT_KERNEL
-	select CPU_SUPPORTS_64BIT_KERNEL
-	select CPU_SUPPORTS_HIGHMEM
+config CPU_LOONGSON2E
+	bool "Loongson 2E"
+	depends on SYS_HAS_CPU_LOONGSON2E
+	select CPU_LOONGSON2
 	help
 	  The Loongson 2E processor implements the MIPS III instruction set
 	  with many extensions.
@@ -1282,7 +1280,13 @@ config CPU_CAVIUM_OCTEON
 
 endchoice
 
-config SYS_HAS_CPU_LOONGSON2
+config CPU_LOONGSON2
+	bool
+	select CPU_SUPPORTS_32BIT_KERNEL
+	select CPU_SUPPORTS_64BIT_KERNEL
+	select CPU_SUPPORTS_HIGHMEM
+
+config SYS_HAS_CPU_LOONGSON2E
 	bool
 
 config SYS_HAS_CPU_MIPS32_R1
diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index 94d6f58..1efa9aa 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -120,7 +120,11 @@ cflags-$(CONFIG_CPU_R4300)	+= -march=r4300 -Wa,--trap
 cflags-$(CONFIG_CPU_VR41XX)	+= -march=r4100 -Wa,--trap
 cflags-$(CONFIG_CPU_R4X00)	+= -march=r4600 -Wa,--trap
 cflags-$(CONFIG_CPU_TX49XX)	+= -march=r4600 -Wa,--trap
-cflags-$(CONFIG_CPU_LOONGSON2)	+= -march=r4600 -Wa,--trap
+# only gcc >= 4.4 have the loongson-specific support
+cflags-$(CONFIG_CPU_LOONGSON2)	+= -Wa,--trap
+cflags-$(CONFIG_CPU_LOONGSON2E) += \
+	$(call cc-option,-march=loongson2e,-march=r4600)
+
 cflags-$(CONFIG_CPU_MIPS32_R1)	+= $(call cc-option,-march=mips32,-mips32 -U_MIPS_ISA -D_MIPS_ISA=_MIPS_ISA_MIPS32) \
 			-Wa,-mips32 -Wa,--trap
 cflags-$(CONFIG_CPU_MIPS32_R2)	+= $(call cc-option,-march=mips32r2,-mips32r2 -U_MIPS_ISA -D_MIPS_ISA=_MIPS_ISA_MIPS32) \
diff --git a/arch/mips/loongson/Kconfig b/arch/mips/loongson/Kconfig
index 376712a..d450925 100644
--- a/arch/mips/loongson/Kconfig
+++ b/arch/mips/loongson/Kconfig
@@ -7,7 +7,7 @@ config LEMOTE_FULOONG2E
     select ARCH_SPARSEMEM_ENABLE
     select CEVT_R4K
     select CSRC_R4K
-    select SYS_HAS_CPU_LOONGSON2
+    select SYS_HAS_CPU_LOONGSON2E
     select DMA_NONCOHERENT
     select BOOT_ELF32
     select BOARD_SCACHE
-- 
1.6.2.1

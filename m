Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Oct 2015 08:07:27 +0200 (CEST)
Received: from smtpbg322.qq.com ([14.17.32.31]:37211 "EHLO smtpbg322.qq.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27009111AbbJGGHBxzLBj (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 7 Oct 2015 08:07:01 +0200
X-QQ-mid: bizesmtp11t1444197967t171t21
Received: from software.domain.org (unknown [222.92.8.142])
        by esmtp4.qq.com (ESMTP) with 
        id ; Wed, 07 Oct 2015 14:06:06 +0800 (CST)
X-QQ-SSF: 01100000000000F0FK62B00A0000000
X-QQ-FEAT: Tp2hW+Mew+cw+wF+QGYwjadIsGfIFrpEC8wQyeAtE958N5Nk7cFwDhMK+HoSi
        fSO3r1yRitXpqF8FxJb4i08uUXXDqF68wYXU5aK5jeb6sYB+u4CLn0kL8Y1gXOf7aAYqfgl
        y3AEoWmyVYQ3IbkwD9U06rQ9+z9wIuwSA1FyFnoAJiCznDluc+PEzij2hqLumapvovo1a9C
        lpEAfGRqbXwJiNr8Gemp1tL/aM599zO8Zx3c8ynRF/SZgeNqgSL/iOY9gBQEdvcN2CjIj8C
        TwofsdRAcWuAee
X-QQ-GoodBg: 0
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <john@phrozen.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>
Subject: [PATCH V2 2/4] MIPS: Loongson-3: Move chipset ACPI code from drivers to arch
Date:   Wed,  7 Oct 2015 14:08:00 +0800
Message-Id: <1444198082-24128-3-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.4.6
In-Reply-To: <1444198082-24128-1-git-send-email-chenhc@lemote.com>
References: <1444198082-24128-1-git-send-email-chenhc@lemote.com>
X-QQ-SENDSIZE: 520
X-QQ-Bgrelay: 1
Return-Path: <chenhc@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49463
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chenhc@lemote.com
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

SB700/SB710/SB800 chipset ACPI code is mostly Loongson-3 specific
routines rather than a "platform driver".

Signed-off-by: Huacai Chen <chenhc@lemote.com>
---
 arch/mips/loongson64/loongson-3/Makefile                              | 2 +-
 .../platform/mips => arch/mips/loongson64/loongson-3}/acpi_init.c     | 0
 drivers/platform/mips/Kconfig                                         | 4 ----
 drivers/platform/mips/Makefile                                        | 1 -
 4 files changed, 1 insertion(+), 6 deletions(-)
 rename {drivers/platform/mips => arch/mips/loongson64/loongson-3}/acpi_init.c (100%)

diff --git a/arch/mips/loongson64/loongson-3/Makefile b/arch/mips/loongson64/loongson-3/Makefile
index 622fead..44bc148 100644
--- a/arch/mips/loongson64/loongson-3/Makefile
+++ b/arch/mips/loongson64/loongson-3/Makefile
@@ -1,7 +1,7 @@
 #
 # Makefile for Loongson-3 family machines
 #
-obj-y			+= irq.o cop2-ex.o platform.o
+obj-y			+= irq.o cop2-ex.o platform.o acpi_init.o
 
 obj-$(CONFIG_SMP)	+= smp.o
 
diff --git a/drivers/platform/mips/acpi_init.c b/arch/mips/loongson64/loongson-3/acpi_init.c
similarity index 100%
rename from drivers/platform/mips/acpi_init.c
rename to arch/mips/loongson64/loongson-3/acpi_init.c
diff --git a/drivers/platform/mips/Kconfig b/drivers/platform/mips/Kconfig
index 125e569..b3ae30a 100644
--- a/drivers/platform/mips/Kconfig
+++ b/drivers/platform/mips/Kconfig
@@ -15,10 +15,6 @@ menuconfig MIPS_PLATFORM_DEVICES
 
 if MIPS_PLATFORM_DEVICES
 
-config MIPS_ACPI
-	bool
-	default y if LOONGSON_MACH3X
-
 config CPU_HWMON
 	tristate "Loongson CPU HWMon Driver"
 	depends on LOONGSON_MACH3X
diff --git a/drivers/platform/mips/Makefile b/drivers/platform/mips/Makefile
index 4341284..8dfd039 100644
--- a/drivers/platform/mips/Makefile
+++ b/drivers/platform/mips/Makefile
@@ -1,2 +1 @@
-obj-$(CONFIG_MIPS_ACPI) += acpi_init.o
 obj-$(CONFIG_CPU_HWMON) += cpu_hwmon.o
-- 
2.4.6

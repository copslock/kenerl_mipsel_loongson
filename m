Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 May 2015 11:21:22 +0200 (CEST)
Received: from smtpbg123.qq.com ([183.60.2.34]:50271 "EHLO smtpbg123.qq.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27009397AbbEDJVUZ2JF5 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 4 May 2015 11:21:20 +0200
X-QQ-mid: bizesmtp3t1430731187t616t171
Received: from localhost.localdomain (unknown [222.92.8.142])
        by esmtp4.qq.com (ESMTP) with 
        id ; Mon, 04 May 2015 17:19:46 +0800 (CST)
X-QQ-SSF: 01100000002000F0FJ52000A0000000
X-QQ-FEAT: 92FxZ2TPvndUyY8uRCuQIkxLRn18q6KQVEnlKVvqRXSsoBaKT0NsJR2pJCsgb
        4G/23Khiio7/M8Mjc/nFH8AuZLeXWV+itcdN+9qhQZyb4vKwe06gdBXCV7ojOLvocaPGfdP
        4/eQSbkOFxWCP+sv31Re1jan9h5fHE/Jge+yCfOv6CQFixyV9gvgRbObwgm61Y0ClJQ3IDJ
        VCBvuYNhMP5hzLPKKSt4knR8ylJviK4Xwgxpts1rHZw==
X-QQ-GoodBg: 0
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <john@phrozen.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>
Subject: [PATCH 2/4] MIPS: Loongson-3: Move chipset ACPI code from drivers to arch
Date:   Mon,  4 May 2015 17:19:09 +0800
Message-Id: <1430731151-4808-3-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 1.7.7.3
In-Reply-To: <1430731151-4808-1-git-send-email-chenhc@lemote.com>
References: <1430731151-4808-1-git-send-email-chenhc@lemote.com>
X-QQ-SENDSIZE: 520
X-QQ-Bgrelay: 1
Return-Path: <chenhc@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47227
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
 arch/mips/loongson64/loongson-3/Makefile           |    2 +-
 .../mips/loongson64/loongson-3}/acpi_init.c        |    0
 drivers/platform/mips/Kconfig                      |    4 ----
 drivers/platform/mips/Makefile                     |    1 -
 4 files changed, 1 insertions(+), 6 deletions(-)
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
1.7.7.3



	

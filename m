Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Oct 2015 08:08:02 +0200 (CEST)
Received: from smtpbgsg2.qq.com ([54.254.200.128]:34583 "EHLO smtpbgsg2.qq.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27009113AbbJGGHWF-0Gj (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 7 Oct 2015 08:07:22 +0200
X-QQ-mid: bizesmtp11t1444197964t819t10
Received: from software.domain.org (unknown [222.92.8.142])
        by esmtp4.qq.com (ESMTP) with 
        id ; Wed, 07 Oct 2015 14:06:04 +0800 (CST)
X-QQ-SSF: 01100000000000F0FK62B00A0000000
X-QQ-FEAT: 3GtnPQ8BMmbnKa6tCg6FlQW8geTUJT92Y2W4qqtRMIrxWgK47HAOwamxOOmBE
        SV5vVw6xGSGeyzFWuiCtUXigE5MntNOOoc0G5/4w3rzR59Q0LqKXAJ6P1G9WzgJgj1VNK2t
        M7wHARM0yzZpvmxU/RdM6TeB2w+LQl+6IRjjfxWsu7LJUwxRv+tvUvg8mDL5/7/AE82Z/dy
        wwXa3h84whhZ2FerLZnBDgFkiI8IsyymAAVn9A5KU1a3dbr8Iq0qWbP1kW5qrdJEnmMs+L8
        JI8oJtf0BoHBBt
X-QQ-GoodBg: 0
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <john@phrozen.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>
Subject: [PATCH V2 1/4] MIPS: Loongson: Cleanup CONFIG_LOONGSON_SUSPEND.
Date:   Wed,  7 Oct 2015 14:07:59 +0800
Message-Id: <1444198082-24128-2-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.4.6
In-Reply-To: <1444198082-24128-1-git-send-email-chenhc@lemote.com>
References: <1444198082-24128-1-git-send-email-chenhc@lemote.com>
X-QQ-SENDSIZE: 520
X-QQ-Bgrelay: 1
Return-Path: <chenhc@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49465
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

Now LOONGSON_CHIPCFG register definition doesn't depend on CPUFREQ any
more, so CPU_SUPPORTS_CPUFREQ is no longer needed for suspend/resume.
Remove CONFIG_LOONGSON_SUSPEND and use CONFIG_SUSPEND instead.

Signed-off-by: Huacai Chen <chenhc@lemote.com>
---
 arch/mips/loongson64/Kconfig            | 5 -----
 arch/mips/loongson64/common/Makefile    | 2 +-
 arch/mips/loongson64/lemote-2f/Makefile | 2 +-
 3 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/arch/mips/loongson64/Kconfig b/arch/mips/loongson64/Kconfig
index 497912b..8e6e292 100644
--- a/arch/mips/loongson64/Kconfig
+++ b/arch/mips/loongson64/Kconfig
@@ -120,11 +120,6 @@ config RS780_HPET
 
 	  If unsure, say Yes.
 
-config LOONGSON_SUSPEND
-	bool
-	default y
-	depends on CPU_SUPPORTS_CPUFREQ && SUSPEND
-
 config LOONGSON_UART_BASE
 	bool
 	default y
diff --git a/arch/mips/loongson64/common/Makefile b/arch/mips/loongson64/common/Makefile
index f2e8153..074d9cb 100644
--- a/arch/mips/loongson64/common/Makefile
+++ b/arch/mips/loongson64/common/Makefile
@@ -23,7 +23,7 @@ obj-$(CONFIG_CS5536) += cs5536/
 # Suspend Support
 #
 
-obj-$(CONFIG_LOONGSON_SUSPEND) += pm.o
+obj-$(CONFIG_SUSPEND) += pm.o
 
 #
 # Big Memory (SWIOTLB) Support
diff --git a/arch/mips/loongson64/lemote-2f/Makefile b/arch/mips/loongson64/lemote-2f/Makefile
index 4f9eaa3..08b8abc 100644
--- a/arch/mips/loongson64/lemote-2f/Makefile
+++ b/arch/mips/loongson64/lemote-2f/Makefile
@@ -8,4 +8,4 @@ obj-y += clock.o machtype.o irq.o reset.o ec_kb3310b.o
 # Suspend Support
 #
 
-obj-$(CONFIG_LOONGSON_SUSPEND) += pm.o
+obj-$(CONFIG_SUSPEND) += pm.o
-- 
2.4.6

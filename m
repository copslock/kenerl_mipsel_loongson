Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Feb 2016 11:06:28 +0100 (CET)
Received: from torg.zytor.com ([198.137.202.12]:44576 "EHLO terminus.zytor.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27012712AbcBYKG0LkTtm (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 25 Feb 2016 11:06:26 +0100
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTP id u1PA5ugl003301;
        Thu, 25 Feb 2016 02:06:01 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.14.8/Submit) id u1PA5tkC003298;
        Thu, 25 Feb 2016 02:05:55 -0800
Date:   Thu, 25 Feb 2016 02:05:55 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Qais Yousef <tipbot@zytor.com>
Message-ID: <tip-7eb8c99db26cc6499bfb1eba72dffc4730570752@git.kernel.org>
Cc:     ralf@linux-mips.org, qsyousef@gmail.com, hpa@zytor.com,
        mingo@kernel.org, linux-mips@linux-mips.org, tglx@linutronix.de,
        jason@lakedaemon.net, marc.zyngier@arm.com,
        jiang.liu@linux.intel.com, lisa.parratt@imgtec.com,
        linux-kernel@vger.kernel.org, qais.yousef@imgtec.com
Reply-To: linux-kernel@vger.kernel.org, qais.yousef@imgtec.com,
          jason@lakedaemon.net, tglx@linutronix.de,
          jiang.liu@linux.intel.com, marc.zyngier@arm.com,
          lisa.parratt@imgtec.com, linux-mips@linux-mips.org,
          ralf@linux-mips.org, hpa@zytor.com, qsyousef@gmail.com,
          mingo@kernel.org
In-Reply-To: <1449580830-23652-19-git-send-email-qais.yousef@imgtec.com>
References: <1449580830-23652-19-git-send-email-qais.yousef@imgtec.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:irq/core] MIPS: Delete smp-gic.c
Git-Commit-ID: 7eb8c99db26cc6499bfb1eba72dffc4730570752
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Precedence: bulk
Return-Path: <tipbot@zytor.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52253
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tipbot@zytor.com
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

Commit-ID:  7eb8c99db26cc6499bfb1eba72dffc4730570752
Gitweb:     http://git.kernel.org/tip/7eb8c99db26cc6499bfb1eba72dffc4730570752
Author:     Qais Yousef <qais.yousef@imgtec.com>
AuthorDate: Tue, 8 Dec 2015 13:20:29 +0000
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 25 Feb 2016 10:56:58 +0100

MIPS: Delete smp-gic.c

We now have a generic IPI layer that will use GIC automatically
if it's compiled in.

Signed-off-by: Qais Yousef <qais.yousef@imgtec.com>
Acked-by: Ralf Baechle <ralf@linux-mips.org>
Cc: <jason@lakedaemon.net>
Cc: <marc.zyngier@arm.com>
Cc: <jiang.liu@linux.intel.com>
Cc: <linux-mips@linux-mips.org>
Cc: <lisa.parratt@imgtec.com>
Cc: Qais Yousef <qsyousef@gmail.com>
Link: http://lkml.kernel.org/r/1449580830-23652-19-git-send-email-qais.yousef@imgtec.com
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/mips/Kconfig         | 6 ------
 arch/mips/kernel/Makefile | 1 -
 2 files changed, 7 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index eb079ac..ddcbeda 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -2170,7 +2170,6 @@ config MIPS_MT_SMP
 	select CPU_MIPSR2_IRQ_VI
 	select CPU_MIPSR2_IRQ_EI
 	select SYNC_R4K
-	select MIPS_GIC_IPI
 	select MIPS_MT
 	select SMP
 	select SMP_UP
@@ -2268,7 +2267,6 @@ config MIPS_VPE_APSP_API_MT
 config MIPS_CMP
 	bool "MIPS CMP framework support (DEPRECATED)"
 	depends on SYS_SUPPORTS_MIPS_CMP && !CPU_MIPSR6
-	select MIPS_GIC_IPI
 	select SMP
 	select SYNC_R4K
 	select SYS_SUPPORTS_SMP
@@ -2288,7 +2286,6 @@ config MIPS_CPS
 	select MIPS_CM
 	select MIPS_CPC
 	select MIPS_CPS_PM if HOTPLUG_CPU
-	select MIPS_GIC_IPI
 	select SMP
 	select SYNC_R4K if (CEVT_R4K || CSRC_R4K)
 	select SYS_SUPPORTS_HOTPLUG_CPU
@@ -2306,9 +2303,6 @@ config MIPS_CPS_PM
 	select MIPS_CPC
 	bool
 
-config MIPS_GIC_IPI
-	bool
-
 config MIPS_CM
 	bool
 
diff --git a/arch/mips/kernel/Makefile b/arch/mips/kernel/Makefile
index 68e2b7d..b0988fd 100644
--- a/arch/mips/kernel/Makefile
+++ b/arch/mips/kernel/Makefile
@@ -52,7 +52,6 @@ obj-$(CONFIG_MIPS_MT_SMP)	+= smp-mt.o
 obj-$(CONFIG_MIPS_CMP)		+= smp-cmp.o
 obj-$(CONFIG_MIPS_CPS)		+= smp-cps.o cps-vec.o
 obj-$(CONFIG_MIPS_CPS_NS16550)	+= cps-vec-ns16550.o
-obj-$(CONFIG_MIPS_GIC_IPI)	+= smp-gic.o
 obj-$(CONFIG_MIPS_SPRAM)	+= spram.o
 
 obj-$(CONFIG_MIPS_VPE_LOADER)	+= vpe.o

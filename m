Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Feb 2016 11:01:48 +0100 (CET)
Received: from torg.zytor.com ([198.137.202.12]:44160 "EHLO terminus.zytor.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27012712AbcBYKBqcIgJm (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 25 Feb 2016 11:01:46 +0100
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTP id u1PA1FDJ000519;
        Thu, 25 Feb 2016 02:01:20 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.14.8/Submit) id u1PA1FNr000508;
        Thu, 25 Feb 2016 02:01:15 -0800
Date:   Thu, 25 Feb 2016 02:01:15 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Qais Yousef <tipbot@zytor.com>
Message-ID: <tip-379b656446a36c7a80b27cbdc34eec8e57b5f290@git.kernel.org>
Cc:     jason@lakedaemon.net, lisa.parratt@imgtec.com, ralf@linux-mips.org,
        hpa@zytor.com, tglx@linutronix.de, mingo@kernel.org,
        jiang.liu@linux.intel.com, marc.zyngier@arm.com,
        qais.yousef@imgtec.com, linux-mips@linux-mips.org,
        qsyousef@gmail.com, linux-kernel@vger.kernel.org
Reply-To: linux-mips@linux-mips.org, qais.yousef@imgtec.com,
          marc.zyngier@arm.com, linux-kernel@vger.kernel.org,
          qsyousef@gmail.com, ralf@linux-mips.org, hpa@zytor.com,
          lisa.parratt@imgtec.com, jason@lakedaemon.net,
          jiang.liu@linux.intel.com, mingo@kernel.org, tglx@linutronix.de
In-Reply-To: <1449580830-23652-4-git-send-email-qais.yousef@imgtec.com>
References: <1449580830-23652-4-git-send-email-qais.yousef@imgtec.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:irq/core] genirq: Add GENERIC_IRQ_IPI Kconfig symbol
Git-Commit-ID: 379b656446a36c7a80b27cbdc34eec8e57b5f290
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
X-archive-position: 52239
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

Commit-ID:  379b656446a36c7a80b27cbdc34eec8e57b5f290
Gitweb:     http://git.kernel.org/tip/379b656446a36c7a80b27cbdc34eec8e57b5f290
Author:     Qais Yousef <qais.yousef@imgtec.com>
AuthorDate: Tue, 8 Dec 2015 13:20:14 +0000
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 25 Feb 2016 10:56:55 +0100

genirq: Add GENERIC_IRQ_IPI Kconfig symbol

Select this to enable the generic IPI domain support

Signed-off-by: Qais Yousef <qais.yousef@imgtec.com>
Cc: <jason@lakedaemon.net>
Cc: <marc.zyngier@arm.com>
Cc: <jiang.liu@linux.intel.com>
Cc: <ralf@linux-mips.org>
Cc: <linux-mips@linux-mips.org>
Cc: <lisa.parratt@imgtec.com>
Cc: Qais Yousef <qsyousef@gmail.com>
Link: http://lkml.kernel.org/r/1449580830-23652-4-git-send-email-qais.yousef@imgtec.com
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/irq/Kconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/irq/Kconfig b/kernel/irq/Kconfig
index 3b48dab..3bbfd6a 100644
--- a/kernel/irq/Kconfig
+++ b/kernel/irq/Kconfig
@@ -64,6 +64,10 @@ config IRQ_DOMAIN_HIERARCHY
 	bool
 	select IRQ_DOMAIN
 
+# Generic IRQ IPI support
+config GENERIC_IRQ_IPI
+	bool
+
 # Generic MSI interrupt support
 config GENERIC_MSI_IRQ
 	bool

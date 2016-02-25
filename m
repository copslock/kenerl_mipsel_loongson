Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Feb 2016 11:02:06 +0100 (CET)
Received: from torg.zytor.com ([198.137.202.12]:44180 "EHLO terminus.zytor.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27012881AbcBYKB7U-Nym (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 25 Feb 2016 11:01:59 +0100
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTP id u1PA1ZcC000592;
        Thu, 25 Feb 2016 02:01:40 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.14.8/Submit) id u1PA1ZJ2000589;
        Thu, 25 Feb 2016 02:01:35 -0800
Date:   Thu, 25 Feb 2016 02:01:35 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Qais Yousef <tipbot@zytor.com>
Message-ID: <tip-955bfe5912e7839abcc83694f06867535487404b@git.kernel.org>
Cc:     linux-mips@linux-mips.org, marc.zyngier@arm.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org, ralf@linux-mips.org,
        jiang.liu@linux.intel.com, jason@lakedaemon.net,
        tglx@linutronix.de, qais.yousef@imgtec.com,
        lisa.parratt@imgtec.com, qsyousef@gmail.com, mingo@kernel.org
Reply-To: qsyousef@gmail.com, mingo@kernel.org, lisa.parratt@imgtec.com,
          tglx@linutronix.de, qais.yousef@imgtec.com, marc.zyngier@arm.com,
          linux-mips@linux-mips.org, hpa@zytor.com,
          linux-kernel@vger.kernel.org, jiang.liu@linux.intel.com,
          ralf@linux-mips.org, jason@lakedaemon.net
In-Reply-To: <1449580830-23652-7-git-send-email-qais.yousef@imgtec.com>
References: <1449580830-23652-7-git-send-email-qais.yousef@imgtec.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:irq/core] genirq: Add an extra comment about the use of
 affinity in irq_common_data
Git-Commit-ID: 955bfe5912e7839abcc83694f06867535487404b
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
X-archive-position: 52240
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

Commit-ID:  955bfe5912e7839abcc83694f06867535487404b
Gitweb:     http://git.kernel.org/tip/955bfe5912e7839abcc83694f06867535487404b
Author:     Qais Yousef <qais.yousef@imgtec.com>
AuthorDate: Tue, 8 Dec 2015 13:20:17 +0000
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 25 Feb 2016 10:56:55 +0100

genirq: Add an extra comment about the use of affinity in irq_common_data

Affinity will have dual meaning depends on the type of the irq. If it is
a normal irq, it'll have the standard affinity meaning.

If it is an IPI, it will hold the mask of the cpus to which an IPI can be
sent.

Signed-off-by: Qais Yousef <qais.yousef@imgtec.com>
Cc: <jason@lakedaemon.net>
Cc: <marc.zyngier@arm.com>
Cc: <jiang.liu@linux.intel.com>
Cc: <ralf@linux-mips.org>
Cc: <linux-mips@linux-mips.org>
Cc: <lisa.parratt@imgtec.com>
Cc: Qais Yousef <qsyousef@gmail.com>
Link: http://lkml.kernel.org/r/1449580830-23652-7-git-send-email-qais.yousef@imgtec.com
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/irq.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/irq.h b/include/linux/irq.h
index 3c1c967..0817afd 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -133,7 +133,9 @@ struct irq_domain;
  *			Use accessor functions to deal with it
  * @node:		node index useful for balancing
  * @handler_data:	per-IRQ data for the irq_chip methods
- * @affinity:		IRQ affinity on SMP
+ * @affinity:		IRQ affinity on SMP. If this is an IPI
+ *			related irq, then this is the mask of the
+ *			CPUs to which an IPI can be sent.
  * @msi_desc:		MSI descriptor
  */
 struct irq_common_data {

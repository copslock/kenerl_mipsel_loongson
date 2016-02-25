Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Feb 2016 11:02:24 +0100 (CET)
Received: from torg.zytor.com ([198.137.202.12]:44208 "EHLO terminus.zytor.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27006751AbcBYKCWkD6ym (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 25 Feb 2016 11:02:22 +0100
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTP id u1PA1tLO000679;
        Thu, 25 Feb 2016 02:02:00 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.14.8/Submit) id u1PA1sUl000676;
        Thu, 25 Feb 2016 02:01:54 -0800
Date:   Thu, 25 Feb 2016 02:01:54 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Qais Yousef <tipbot@zytor.com>
Message-ID: <tip-f256c9a0c54820ffef21b126f8226be2bece3dd7@git.kernel.org>
Cc:     hpa@zytor.com, linux-mips@linux-mips.org, qais.yousef@imgtec.com,
        qsyousef@gmail.com, marc.zyngier@arm.com, mingo@kernel.org,
        jason@lakedaemon.net, lisa.parratt@imgtec.com, ralf@linux-mips.org,
        linux-kernel@vger.kernel.org, jiang.liu@linux.intel.com,
        tglx@linutronix.de
Reply-To: tglx@linutronix.de, linux-kernel@vger.kernel.org,
          jiang.liu@linux.intel.com, ralf@linux-mips.org,
          lisa.parratt@imgtec.com, jason@lakedaemon.net, mingo@kernel.org,
          marc.zyngier@arm.com, qsyousef@gmail.com, qais.yousef@imgtec.com,
          linux-mips@linux-mips.org, hpa@zytor.com
In-Reply-To: <1449580830-23652-6-git-send-email-qais.yousef@imgtec.com>
References: <1449580830-23652-6-git-send-email-qais.yousef@imgtec.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:irq/core] genirq: Add ipi_offset to irq_common_data
Git-Commit-ID: f256c9a0c54820ffef21b126f8226be2bece3dd7
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
X-archive-position: 52241
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

Commit-ID:  f256c9a0c54820ffef21b126f8226be2bece3dd7
Gitweb:     http://git.kernel.org/tip/f256c9a0c54820ffef21b126f8226be2bece3dd7
Author:     Qais Yousef <qais.yousef@imgtec.com>
AuthorDate: Tue, 8 Dec 2015 13:20:16 +0000
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 25 Feb 2016 10:56:55 +0100

genirq: Add ipi_offset to irq_common_data

IPIs are always assumed to be consecutively allocated, hence virqs and hwirqs
can be inferred by using CPU id as an offset. But the first cpu doesn't always
have to start at offset 0. ipi_offset stores the position of the first cpu so
that we can easily calculate the virq or hwirq of an IPI associated with a
specific cpu.

Signed-off-by: Qais Yousef <qais.yousef@imgtec.com>
Cc: <jason@lakedaemon.net>
Cc: <marc.zyngier@arm.com>
Cc: <jiang.liu@linux.intel.com>
Cc: <ralf@linux-mips.org>
Cc: <linux-mips@linux-mips.org>
Cc: <lisa.parratt@imgtec.com>
Cc: Qais Yousef <qsyousef@gmail.com>
Link: http://lkml.kernel.org/r/1449580830-23652-6-git-send-email-qais.yousef@imgtec.com
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/irq.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/irq.h b/include/linux/irq.h
index 0817afd..a32b47f 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -137,6 +137,7 @@ struct irq_domain;
  *			related irq, then this is the mask of the
  *			CPUs to which an IPI can be sent.
  * @msi_desc:		MSI descriptor
+ * @ipi_offset:		Offset of first IPI target cpu in @affinity. Optional.
  */
 struct irq_common_data {
 	unsigned int		state_use_accessors;
@@ -146,6 +147,9 @@ struct irq_common_data {
 	void			*handler_data;
 	struct msi_desc		*msi_desc;
 	cpumask_var_t		affinity;
+#ifdef CONFIG_GENERIC_IRQ_IPI
+	unsigned int		ipi_offset;
+#endif
 };
 
 /**

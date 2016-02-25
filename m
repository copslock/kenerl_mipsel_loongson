Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Feb 2016 11:01:13 +0100 (CET)
Received: from torg.zytor.com ([198.137.202.12]:44102 "EHLO terminus.zytor.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27012690AbcBYKBLdYnGm (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 25 Feb 2016 11:01:11 +0100
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTP id u1PA0ar7000300;
        Thu, 25 Feb 2016 02:00:41 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.14.8/Submit) id u1PA0YH6032763;
        Thu, 25 Feb 2016 02:00:34 -0800
Date:   Thu, 25 Feb 2016 02:00:34 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Qais Yousef <tipbot@zytor.com>
Message-ID: <tip-0abefbaab4edbcec637e00fefcdeccb52797fe4f@git.kernel.org>
Cc:     linux-mips@linux-mips.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, jason@lakedaemon.net, hpa@zytor.com,
        mingo@kernel.org, ralf@linux-mips.org, lisa.parratt@imgtec.com,
        jiang.liu@linux.intel.com, marc.zyngier@arm.com,
        qais.yousef@imgtec.com, qsyousef@gmail.com
Reply-To: qsyousef@gmail.com, qais.yousef@imgtec.com, marc.zyngier@arm.com,
          jiang.liu@linux.intel.com, lisa.parratt@imgtec.com,
          ralf@linux-mips.org, mingo@kernel.org, jason@lakedaemon.net,
          linux-kernel@vger.kernel.org, hpa@zytor.com, tglx@linutronix.de,
          linux-mips@linux-mips.org
In-Reply-To: <1449580830-23652-2-git-send-email-qais.yousef@imgtec.com>
References: <1449580830-23652-2-git-send-email-qais.yousef@imgtec.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:irq/core] genirq: Add new IPI irqdomain flags
Git-Commit-ID: 0abefbaab4edbcec637e00fefcdeccb52797fe4f
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
X-archive-position: 52237
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

Commit-ID:  0abefbaab4edbcec637e00fefcdeccb52797fe4f
Gitweb:     http://git.kernel.org/tip/0abefbaab4edbcec637e00fefcdeccb52797fe4f
Author:     Qais Yousef <qais.yousef@imgtec.com>
AuthorDate: Tue, 8 Dec 2015 13:20:12 +0000
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 25 Feb 2016 10:56:55 +0100

genirq: Add new IPI irqdomain flags

These flags will be used to identify an IPI domain. We have two flavours of
IPI implementations:

IRQ_DOMAIN_FLAG_IPI_PER_CPU: Each CPU has its own virq and hwirq
IRQ_DOMAIN_FLAG_IPI_SINGLE : A single virq and hwirq for all CPUs

Signed-off-by: Qais Yousef <qais.yousef@imgtec.com>
Cc: <jason@lakedaemon.net>
Cc: <marc.zyngier@arm.com>
Cc: <jiang.liu@linux.intel.com>
Cc: <ralf@linux-mips.org>
Cc: <linux-mips@linux-mips.org>
Cc: <lisa.parratt@imgtec.com>
Cc: Qais Yousef <qsyousef@gmail.com>
Link: http://lkml.kernel.org/r/1449580830-23652-2-git-send-email-qais.yousef@imgtec.com
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/irqdomain.h | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index 04579d9..9bb0a9c 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -172,6 +172,12 @@ enum {
 	/* Core calls alloc/free recursive through the domain hierarchy. */
 	IRQ_DOMAIN_FLAG_AUTO_RECURSIVE	= (1 << 1),
 
+	/* Irq domain is an IPI domain with virq per cpu */
+	IRQ_DOMAIN_FLAG_IPI_PER_CPU	= (1 << 2),
+
+	/* Irq domain is an IPI domain with single virq */
+	IRQ_DOMAIN_FLAG_IPI_SINGLE	= (1 << 3),
+
 	/*
 	 * Flags starting from IRQ_DOMAIN_FLAG_NONCORE are reserved
 	 * for implementation specific purposes and ignored by the
@@ -400,6 +406,22 @@ static inline bool irq_domain_is_hierarchy(struct irq_domain *domain)
 {
 	return domain->flags & IRQ_DOMAIN_FLAG_HIERARCHY;
 }
+
+static inline bool irq_domain_is_ipi(struct irq_domain *domain)
+{
+	return domain->flags &
+		(IRQ_DOMAIN_FLAG_IPI_PER_CPU | IRQ_DOMAIN_FLAG_IPI_SINGLE);
+}
+
+static inline bool irq_domain_is_ipi_per_cpu(struct irq_domain *domain)
+{
+	return domain->flags & IRQ_DOMAIN_FLAG_IPI_PER_CPU;
+}
+
+static inline bool irq_domain_is_ipi_single(struct irq_domain *domain)
+{
+	return domain->flags & IRQ_DOMAIN_FLAG_IPI_SINGLE;
+}
 #else	/* CONFIG_IRQ_DOMAIN_HIERARCHY */
 static inline void irq_domain_activate_irq(struct irq_data *data) { }
 static inline void irq_domain_deactivate_irq(struct irq_data *data) { }
@@ -413,6 +435,21 @@ static inline bool irq_domain_is_hierarchy(struct irq_domain *domain)
 {
 	return false;
 }
+
+static inline bool irq_domain_is_ipi(struct irq_domain *domain)
+{
+	return false;
+}
+
+static inline bool irq_domain_is_ipi_per_cpu(struct irq_domain *domain)
+{
+	return false;
+}
+
+static inline bool irq_domain_is_ipi_single(struct irq_domain *domain)
+{
+	return false;
+}
 #endif	/* CONFIG_IRQ_DOMAIN_HIERARCHY */
 
 #else /* CONFIG_IRQ_DOMAIN */

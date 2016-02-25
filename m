Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Feb 2016 11:03:51 +0100 (CET)
Received: from torg.zytor.com ([198.137.202.12]:44328 "EHLO terminus.zytor.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27010007AbcBYKDty1Qrm (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 25 Feb 2016 11:03:49 +0100
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTP id u1PA3H7F001255;
        Thu, 25 Feb 2016 02:03:22 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.14.8/Submit) id u1PA3Hkl001250;
        Thu, 25 Feb 2016 02:03:17 -0800
Date:   Thu, 25 Feb 2016 02:03:17 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Qais Yousef <tipbot@zytor.com>
Message-ID: <tip-34dc1ae101018dbb50e1d04e88aa89052802a7db@git.kernel.org>
Cc:     lisa.parratt@imgtec.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, qais.yousef@imgtec.com,
        marc.zyngier@arm.com, ralf@linux-mips.org,
        jiang.liu@linux.intel.com, hpa@zytor.com,
        linux-mips@linux-mips.org, jason@lakedaemon.net,
        qsyousef@gmail.com, mingo@kernel.org
Reply-To: linux-mips@linux-mips.org, jason@lakedaemon.net,
          ralf@linux-mips.org, hpa@zytor.com, jiang.liu@linux.intel.com,
          mingo@kernel.org, qsyousef@gmail.com, tglx@linutronix.de,
          lisa.parratt@imgtec.com, marc.zyngier@arm.com,
          qais.yousef@imgtec.com, linux-kernel@vger.kernel.org
In-Reply-To: <1449580830-23652-11-git-send-email-qais.yousef@imgtec.com>
References: <1449580830-23652-11-git-send-email-qais.yousef@imgtec.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:irq/core] genirq: Add send_ipi callbacks to irq_chip
Git-Commit-ID: 34dc1ae101018dbb50e1d04e88aa89052802a7db
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
X-archive-position: 52245
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

Commit-ID:  34dc1ae101018dbb50e1d04e88aa89052802a7db
Gitweb:     http://git.kernel.org/tip/34dc1ae101018dbb50e1d04e88aa89052802a7db
Author:     Qais Yousef <qais.yousef@imgtec.com>
AuthorDate: Tue, 8 Dec 2015 13:20:21 +0000
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 25 Feb 2016 10:56:57 +0100

genirq: Add send_ipi callbacks to irq_chip

Introduce the new callbacks which can be used by the core code to implement a
generic IPI send mechanism.

Signed-off-by: Qais Yousef <qais.yousef@imgtec.com>
Cc: <jason@lakedaemon.net>
Cc: <marc.zyngier@arm.com>
Cc: <jiang.liu@linux.intel.com>
Cc: <ralf@linux-mips.org>
Cc: <linux-mips@linux-mips.org>
Cc: <lisa.parratt@imgtec.com>
Cc: Qais Yousef <qsyousef@gmail.com>
Link: http://lkml.kernel.org/r/1449580830-23652-11-git-send-email-qais.yousef@imgtec.com
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/irq.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/irq.h b/include/linux/irq.h
index 10273dc..3b3a5b8 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -347,6 +347,8 @@ static inline irq_hw_number_t irqd_to_hwirq(struct irq_data *d)
  * @irq_get_irqchip_state:	return the internal state of an interrupt
  * @irq_set_irqchip_state:	set the internal state of a interrupt
  * @irq_set_vcpu_affinity:	optional to target a vCPU in a virtual machine
+ * @ipi_send_single:	send a single IPI to destination cpus
+ * @ipi_send_mask:	send an IPI to destination cpus in cpumask
  * @flags:		chip specific flags
  */
 struct irq_chip {
@@ -391,6 +393,9 @@ struct irq_chip {
 
 	int		(*irq_set_vcpu_affinity)(struct irq_data *data, void *vcpu_info);
 
+	void		(*ipi_send_single)(struct irq_data *data, unsigned int cpu);
+	void		(*ipi_send_mask)(struct irq_data *data, const struct cpumask *dest);
+
 	unsigned long	flags;
 };
 

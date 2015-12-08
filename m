Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Dec 2015 14:24:13 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:24122 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27013361AbbLHNVhP7I7Z (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 8 Dec 2015 14:21:37 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email Security Gateway with ESMTPS id 415D288104894;
        Tue,  8 Dec 2015 13:21:29 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.235.1; Tue, 8 Dec 2015 13:21:31 +0000
Received: from qyousef-linux.le.imgtec.org (192.168.154.94) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Tue, 8 Dec 2015 13:21:31 +0000
From:   Qais Yousef <qais.yousef@imgtec.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <tglx@linutronix.de>, <jason@lakedaemon.net>,
        <marc.zyngier@arm.com>, <jiang.liu@linux.intel.com>,
        <ralf@linux-mips.org>, <linux-mips@linux-mips.org>,
        <lisa.parratt@imgtec.com>, Qais Yousef <qais.yousef@imgtec.com>
Subject: [PATCH v4 10/19] genirq: Add a new irq_send_ipi() to irq_chip
Date:   Tue, 8 Dec 2015 13:20:21 +0000
Message-ID: <1449580830-23652-11-git-send-email-qais.yousef@imgtec.com>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1449580830-23652-1-git-send-email-qais.yousef@imgtec.com>
References: <1449580830-23652-1-git-send-email-qais.yousef@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.94]
Return-Path: <Qais.Yousef@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50434
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: qais.yousef@imgtec.com
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

Introduce the new functions to allow generic IPI send mechanism to be
used from arch and drivers code.

Signed-off-by: Qais Yousef <qais.yousef@imgtec.com>
---
 include/linux/irq.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/irq.h b/include/linux/irq.h
index 1808ee4d42ec..b0556c5787d7 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -363,6 +363,8 @@ static inline irq_hw_number_t irqd_to_hwirq(struct irq_data *d)
  * @irq_get_irqchip_state:	return the internal state of an interrupt
  * @irq_set_irqchip_state:	set the internal state of a interrupt
  * @irq_set_vcpu_affinity:	optional to target a vCPU in a virtual machine
+ * @ipi_send_single:	send a single IPI to destination cpus
+ * @ipi_send_mask:	send an IPI to destination cpus in cpumask
  * @flags:		chip specific flags
  */
 struct irq_chip {
@@ -407,6 +409,9 @@ struct irq_chip {
 
 	int		(*irq_set_vcpu_affinity)(struct irq_data *data, void *vcpu_info);
 
+	void		(*ipi_send_single)(struct irq_data *data, unsigned int cpu);
+	void		(*ipi_send_mask)(struct irq_data *data, const struct cpumask *dest);
+
 	unsigned long	flags;
 };
 
-- 
2.1.0

Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Dec 2015 14:22:56 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:36592 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27007016AbbLHNVPu0LjZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 8 Dec 2015 14:21:15 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Websense Email Security Gateway with ESMTPS id BDEA298994245;
        Tue,  8 Dec 2015 13:18:03 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 HHMAIL01.hh.imgtec.org (10.100.10.19) with Microsoft SMTP Server (TLS) id
 14.3.235.1; Tue, 8 Dec 2015 13:21:06 +0000
Received: from qyousef-linux.le.imgtec.org (192.168.154.94) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Tue, 8 Dec 2015 13:21:06 +0000
From:   Qais Yousef <qais.yousef@imgtec.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <tglx@linutronix.de>, <jason@lakedaemon.net>,
        <marc.zyngier@arm.com>, <jiang.liu@linux.intel.com>,
        <ralf@linux-mips.org>, <linux-mips@linux-mips.org>,
        <lisa.parratt@imgtec.com>, Qais Yousef <qais.yousef@imgtec.com>
Subject: [PATCH v4 05/19] genirq: Add ipi_offset to irq_common_data
Date:   Tue, 8 Dec 2015 13:20:16 +0000
Message-ID: <1449580830-23652-6-git-send-email-qais.yousef@imgtec.com>
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
X-archive-position: 50430
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

IPIs are always assumed to be consecutively allocated, hence virqs and hwirqs
can be inferred by using CPU id as an offset. But the first cpu doesn't always
have to start at position 0. ipi_offset stores the position of the first cpu so
that we can easily calculate the virq or hwirq of an IPI associated with a
specific cpu.

Signed-off-by: Qais Yousef <qais.yousef@imgtec.com>
---
 include/linux/irq.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/irq.h b/include/linux/irq.h
index 14f1c036119c..6bcbd11207ea 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -150,6 +150,7 @@ struct ipi_mapping {
  * @ipi_mapping:	Contains the hwirq mapping of IPIs.
  *			The use of this struct is optional and not all irqchips
  *			will use it.
+ * @ipi_offset:		offset of first IPI in the mask
  */
 struct irq_common_data {
 	unsigned int		state_use_accessors;
@@ -161,6 +162,7 @@ struct irq_common_data {
 	cpumask_var_t		affinity;
 #ifdef CONFIG_GENERIC_IRQ_IPI
 	struct ipi_mapping	*ipi_map;
+	unsigned int		ipi_offset;
 #endif
 };
 
-- 
2.1.0

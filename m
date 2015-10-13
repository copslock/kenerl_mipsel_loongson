Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Oct 2015 12:17:37 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:60133 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27009461AbbJMKQv5ivSs (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 13 Oct 2015 12:16:51 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 7A8D2FD8DB8B;
        Tue, 13 Oct 2015 11:16:44 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Tue, 13 Oct 2015 11:16:46 +0100
Received: from qyousef-linux.le.imgtec.org (192.168.154.94) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Tue, 13 Oct 2015 11:16:45 +0100
From:   Qais Yousef <qais.yousef@imgtec.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <tglx@linutronix.de>, <jason@lakedaemon.net>,
        <marc.zyngier@arm.com>, <jiang.liu@linux.intel.com>,
        <ralf@linux-mips.org>, <linux-mips@linux-mips.org>,
        Qais Yousef <qais.yousef@imgtec.com>
Subject: [RFC v2 PATCH 03/14] irq: add new struct ipi_mask
Date:   Tue, 13 Oct 2015 11:16:11 +0100
Message-ID: <1444731382-19313-4-git-send-email-qais.yousef@imgtec.com>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1444731382-19313-1-git-send-email-qais.yousef@imgtec.com>
References: <1444731382-19313-1-git-send-email-qais.yousef@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.94]
Return-Path: <Qais.Yousef@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49499
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

cpumask is limited to NR_CPUS. introduce ipi_mask which allows us to address
cpu range that is higher than NR_CPUS which is required for drivers to send
IPIs for coprocessor that are outside Linux CPU range.

Signed-off-by: Qais Yousef <qais.yousef@imgtec.com>
---
 include/linux/irq.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/include/linux/irq.h b/include/linux/irq.h
index 11bf09288ddb..4b537e4d393b 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -125,6 +125,21 @@ enum {
 struct msi_desc;
 struct irq_domain;
 
+ /**
+ * struct ipi_mask - IPI mask information
+ * @cpumask: bitmap of cpumasks
+ * @nbits: number of bits in cpumask
+ * @global: whether the mask is SMP IPI ie: subset of cpu_possible_mask or not
+ *
+ * ipi_mask is similar to cpumask, but it provides nbits that's configurable
+ * rather than fixed to NR_CPUS.
+ */
+struct ipi_mask {
+	unsigned long	*cpumask;
+	unsigned int	nbits;
+	bool		global;
+};
+
 /**
  * struct irq_common_data - per irq data shared by all irqchips
  * @state_use_accessors: status information for irq chip functions.
-- 
2.1.0

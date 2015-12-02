Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Dec 2015 13:24:21 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:31461 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011915AbbLBMWY6IEiA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 2 Dec 2015 13:22:24 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email Security Gateway with ESMTPS id 2283CFF22761F;
        Wed,  2 Dec 2015 12:22:17 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.235.1; Wed, 2 Dec 2015 12:22:19 +0000
Received: from qyousef-linux.le.imgtec.org (192.168.154.94) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Wed, 2 Dec 2015 12:22:18 +0000
From:   Qais Yousef <qais.yousef@imgtec.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <tglx@linutronix.de>, <jason@lakedaemon.net>,
        <marc.zyngier@arm.com>, <jiang.liu@linux.intel.com>,
        <ralf@linux-mips.org>, <linux-mips@linux-mips.org>,
        Qais Yousef <qais.yousef@imgtec.com>
Subject: [PATCH v3 06/19] genirq: Add an extra comment about the use of affinity in irq_common_data
Date:   Wed, 2 Dec 2015 12:21:47 +0000
Message-ID: <1449058920-21011-7-git-send-email-qais.yousef@imgtec.com>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1449058920-21011-1-git-send-email-qais.yousef@imgtec.com>
References: <1449058920-21011-1-git-send-email-qais.yousef@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.94]
Return-Path: <Qais.Yousef@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50276
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

Affinity will have dual meaning depends on the type of the irq. If it is
a normal irq, it'll have the standard affinity meaning.

If it is an IPI, it will hold the IPI mask of the cpus it can talk to.

Signed-off-by: Qais Yousef <qais.yousef@imgtec.com>
---
 include/linux/irq.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/irq.h b/include/linux/irq.h
index 6bcbd11207ea..7f6dd4eec207 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -145,7 +145,9 @@ struct ipi_mapping {
  *			Use accessor functions to deal with it
  * @node:		node index useful for balancing
  * @handler_data:	per-IRQ data for the irq_chip methods
- * @affinity:		IRQ affinity on SMP
+ * @affinity:		IRQ affinity on SMP.
+ *			If this is an IPI irq data, this will be the IPI mask
+ *			of the cpus it can talk to.
  * @msi_desc:		MSI descriptor
  * @ipi_mapping:	Contains the hwirq mapping of IPIs.
  *			The use of this struct is optional and not all irqchips
-- 
2.1.0

Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Nov 2015 12:16:41 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:27036 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012422AbbKCLNpVIGd1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 3 Nov 2015 12:13:45 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email Security Gateway with ESMTPS id 2C10ACD8D6972;
        Tue,  3 Nov 2015 11:13:42 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.235.1; Tue, 3 Nov 2015 11:13:44 +0000
Received: from qyousef-linux.le.imgtec.org (192.168.154.94) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Tue, 3 Nov 2015 11:13:43 +0000
From:   Qais Yousef <qais.yousef@imgtec.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <tglx@linutronix.de>, <jason@lakedaemon.net>,
        <marc.zyngier@arm.com>, <jiang.liu@linux.intel.com>,
        <ralf@linux-mips.org>, <linux-mips@linux-mips.org>,
        Qais Yousef <qais.yousef@imgtec.com>,
        "Jonathan Corbet" <corbet@lwn.net>, <linux-doc@vger.kernel.org>
Subject: [PATCH 14/14] Docs: IRQ: Add new IRQ-ipi.txt
Date:   Tue, 3 Nov 2015 11:13:01 +0000
Message-ID: <1446549181-31788-15-git-send-email-qais.yousef@imgtec.com>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1446549181-31788-1-git-send-email-qais.yousef@imgtec.com>
References: <1446549181-31788-1-git-send-email-qais.yousef@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.94]
Return-Path: <Qais.Yousef@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49814
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

The new file describes how to use the new generic IPI support API and implement
the support in the irqchip driver.

Signed-off-by: Qais Yousef <qais.yousef@imgtec.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
---
 Documentation/IRQ-ipi.txt | 81 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 81 insertions(+)
 create mode 100644 Documentation/IRQ-ipi.txt

diff --git a/Documentation/IRQ-ipi.txt b/Documentation/IRQ-ipi.txt
new file mode 100644
index 000000000000..07e5d9abdf38
--- /dev/null
+++ b/Documentation/IRQ-ipi.txt
@@ -0,0 +1,81 @@
+Generic IPI allocation and sending
+
+
+We now have a generic IPI mechanism to allocate and send IPIs which can be used
+to implement ARCH's SMP IPIs or by the driver to exchange IPIs with a coprocessor
+it's talking to.
+
+
+=====
+ API
+=====
+
+Structs:
+
+	-- struct ipi_mask --
+
+	Similar to cpumask but can handle CPUs outside NR_CPU range.
+
+Functions:
+
+	-- irq_reserve_ipi() --
+
+	Dynamically allocate an IPI from an IPI irq_domain registered by the
+	system. An IPI mask must be passed specifying the destination CPUs this
+	IPI will target.
+
+	On success it will return a virq that can be used to send an IPI to one
+	subset of CPUs in the passed IPI mask.
+
+	This function is not exported. Ideally the IPI should be requested from
+	device tree which will use this function indirectly.
+
+	-- irq_send_ipi() --
+
+	To be used by drivers to send an IPI. It takesthe  virq that was
+	returned by irq_reserve_ipi() and an IPI mask containing a subset of the
+	IPI mask used to allocate the IPI.
+
+	This function is exported to allow drivers to use it.
+
+	-- __irq_desc_send_ipi() --
+
+	To be used by ARCH code to send SMP IPIs. It takes a desc instead of virq
+	to save having to do desc lookup on this common case.
+
+	This function is not exported as it's meant for ARCH code use only.
+
+
+=========================================
+ Adding support into your irqchip driver
+=========================================
+
+For this new feature to be used, you need to have an irqchip driver that provides
+an IPI domain.
+
+The IPI domain must be a Hierarchy Domain with IRQ_DOMAIN_FLAG_IPI set and
+domain bust set to DOMAIN_BUS_IPI to allow the system to identify it.
+
+structs:
+
+	-- struct ipi_mapping --
+
+	This struct is provided to aid in creating a CPU to HWIRQ mapping when
+	allocating an IPI and perform the lookup when sending one.
+
+functions:
+
+	-- irq_domain_ops->alloc() --
+
+	This function should be used to implement the hardware specific mechanism
+	to reserve an IPI.
+
+	The generic layer will allocate a virq for each CPU in the IPI mask
+	passed in the call to irq_reserve_ipi() which the driver can freely
+	choose to use or ignore depends if it needs to have a one to one mapping
+	between virq and hwirq or one virq is enough to identify multiple hwirqs.
+
+	-- irqchip->irq_send_ipi() --
+
+	The generic layer will call this irqchip function after doing some sanity
+	checking for the driver to perform the actual IPI kick.
-- 
2.1.0

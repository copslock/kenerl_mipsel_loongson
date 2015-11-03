Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Nov 2015 12:14:41 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:32110 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012389AbbKCLNlZmBN1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 3 Nov 2015 12:13:41 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email Security Gateway with ESMTPS id B7A11DCF52A42;
        Tue,  3 Nov 2015 11:13:32 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.235.1; Tue, 3 Nov 2015 11:13:34 +0000
Received: from qyousef-linux.le.imgtec.org (192.168.154.94) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Tue, 3 Nov 2015 11:13:33 +0000
From:   Qais Yousef <qais.yousef@imgtec.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <tglx@linutronix.de>, <jason@lakedaemon.net>,
        <marc.zyngier@arm.com>, <jiang.liu@linux.intel.com>,
        <ralf@linux-mips.org>, <linux-mips@linux-mips.org>,
        Qais Yousef <qais.yousef@imgtec.com>
Subject: [PATCH 03/14] genirq: Add GENERIC_IRQ_IPI Kconfig symbol
Date:   Tue, 3 Nov 2015 11:12:50 +0000
Message-ID: <1446549181-31788-4-git-send-email-qais.yousef@imgtec.com>
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
X-archive-position: 49807
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

irqchip should select this config to denote it supports generic IPI.

This will aid generic arch code to know when it can use generic IPI layer.

Signed-off-by: Qais Yousef <qais.yousef@imgtec.com>
---
 kernel/irq/Kconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/irq/Kconfig b/kernel/irq/Kconfig
index 3b48dab80164..3bbfd6a9c475 100644
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
-- 
2.1.0

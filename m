Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Sep 2015 16:50:25 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:61806 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27008656AbbIWOtxp2bSn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 23 Sep 2015 16:49:53 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 45B54340A90AF;
        Wed, 23 Sep 2015 15:49:45 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Wed, 23 Sep 2015 15:49:48 +0100
Received: from qyousef-linux.le.imgtec.org (192.168.154.94) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Wed, 23 Sep 2015 15:49:47 +0100
From:   Qais Yousef <qais.yousef@imgtec.com>
To:     <linux-kernel@vger.kernel.org>, <tglx@linutronix.de>
CC:     <marc.zyngier@arm.com>, <jason@lakedaemon.net>,
        <jiang.liu@linux.intel.com>, <linux-mips@linux-mips.org>,
        Qais Yousef <qais.yousef@imgtec.com>
Subject: [PATCH 2/6] irqdomain: add a new send_ipi() to irq_domain_ops
Date:   Wed, 23 Sep 2015 15:49:14 +0100
Message-ID: <1443019758-20620-3-git-send-email-qais.yousef@imgtec.com>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1443019758-20620-1-git-send-email-qais.yousef@imgtec.com>
References: <1443019758-20620-1-git-send-email-qais.yousef@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.94]
Return-Path: <Qais.Yousef@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49340
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

For generic ipi core to use. It takes hwirq as its sole argument.
Hopefully this is generic enough? Should we pass something more abstract?

Signed-off-by: Qais Yousef <qais.yousef@imgtec.com>
---
 include/linux/irqdomain.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index 9b3dc6c2a3cc..cef9e6158be0 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -92,6 +92,7 @@ struct irq_domain_ops {
 	void (*activate)(struct irq_domain *d, struct irq_data *irq_data);
 	void (*deactivate)(struct irq_domain *d, struct irq_data *irq_data);
 #endif
+	void (*send_ipi)(irq_hw_number_t hwirq);
 };
 
 extern struct irq_domain_ops irq_generic_chip_ops;
-- 
2.1.0

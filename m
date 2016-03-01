Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Mar 2016 01:49:56 +0100 (CET)
Received: from mail-pf0-f195.google.com ([209.85.192.195]:33901 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007995AbcCAAsb20eg8 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 1 Mar 2016 01:48:31 +0100
Received: by mail-pf0-f195.google.com with SMTP id 184so4087231pff.1;
        Mon, 29 Feb 2016 16:48:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WhD3Kvk+EAlKFRfQULqLIhrlizIDxSh+yxm2Amfzh50=;
        b=YU3Y+m0yfSg2v23n7NbAK9ayNq9mYF6Z+VJnyLyslE7qv9nqkMEawcKsiJ5Q02HqYk
         X16mSw/sbuc3DJOlDF0vb+2m15hZ5Gc/U9qDlGEQ/28/j6g8350V0Sfu9OA7wzlHeUkH
         3PgaiO97UnhVxyFAIAVFTiTAxUXKGY2LDANvvyCp00y4dpm2okCSS/ENIyBtu+lRn1O+
         cjXLPS/18Fpv7GPjTSV2wnWifch9YCZBvPMkX+c++y/3+oCz4xYaeD5l8QMufZe0Fr4R
         BmoAFgo07WLk5zorG4gMYIRBqGueYVd+ObjReUnsrFlK2a4SOfLAx7sIYP64pdN78Okq
         Sv6w==
X-Gm-Message-State: AD7BkJKW7MohAq/vdAeCrJN0jTbjiTlW8lCVFbpqQakT+ClZnhK+Z5evdM/lmIzk90pqCg==
X-Received: by 10.98.66.75 with SMTP id p72mr26590641pfa.50.1456793305831;
        Mon, 29 Feb 2016 16:48:25 -0800 (PST)
Received: from software.domain.org ([222.92.8.142])
        by smtp.gmail.com with ESMTPSA id s197sm40683975pfs.62.2016.02.29.16.48.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 29 Feb 2016 16:48:25 -0800 (PST)
From:   Binbin Zhou <zhoubb@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <john@phrozen.org>,
        "Steven J . Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Kelvin Cheung <keguang.zhang@gmail.com>,
        Binbin Zhou <zhoubb@lemote.com>, Chunbo Cui <cuicb@lemote.com>,
        Huacai Chen <chenhc@lemote.com>
Subject: [PATCH v3 6/8] MIPS: Loongson-1A: Add IRQ type setting support
Date:   Tue,  1 Mar 2016 08:48:14 +0800
Message-Id: <1456793296-17120-7-git-send-email-zhoubb@lemote.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1456793296-17120-1-git-send-email-zhoubb@lemote.com>
References: <1456793296-17120-1-git-send-email-zhoubb@lemote.com>
Return-Path: <zhoubb.aaron@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52369
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zhoubb@lemote.com
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

Loongson 1A's INT controller support two different interrupt trigger mode:
level trigger and edge trigger.

Whether the INT controller stores the external interrupts is
the difference between them.
The edge trigger should do this, and operate INT_CLR register
to clear the CPU interrupt state.

Signed-off-by: Chunbo Cui <cuicb@lemote.com>
Signed-off-by: Binbin Zhou <zhoubb@lemote.com>
Signed-off-by: Huacai Chen <chenhc@lemote.com>
---
 arch/mips/loongson32/common/irq.c | 46 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/arch/mips/loongson32/common/irq.c b/arch/mips/loongson32/common/irq.c
index 455a770..01e8cb9 100644
--- a/arch/mips/loongson32/common/irq.c
+++ b/arch/mips/loongson32/common/irq.c
@@ -62,12 +62,57 @@ static void ls1x_irq_unmask(struct irq_data *d)
 			| (1 << bit), LS1X_INTC_INTIEN(n));
 }
 
+static int ls1x_irq_set_type(struct irq_data *data, unsigned int flow_type)
+{
+	unsigned int bit = (data->irq - LS1X_IRQ_BASE) & 0x1f;
+	unsigned int n = (data->irq - LS1X_IRQ_BASE) >> 5;
+
+	if (flow_type & IRQ_TYPE_EDGE_BOTH) {
+		if ((flow_type & IRQ_TYPE_EDGE_BOTH) == IRQ_TYPE_EDGE_BOTH) {
+			pr_info("ls1x irq don't support both rising and falling\n");
+			return -1;
+		}
+		ls1x_writel(ls1x_readl(LS1X_INTC_INTCLR(n))
+				| (1 << bit), LS1X_INTC_INTCLR(n));
+		if (flow_type & IRQ_TYPE_EDGE_RISING)
+			ls1x_writel(ls1x_readl(LS1X_INTC_INTPOL(n))
+					| (1 << bit), LS1X_INTC_INTPOL(n));
+		else
+			ls1x_writel(ls1x_readl(LS1X_INTC_INTPOL(n))
+					& ~(1 << bit), LS1X_INTC_INTPOL(n));
+
+		ls1x_writel(ls1x_readl(LS1X_INTC_INTEDGE(n))
+				| (1 << bit), LS1X_INTC_INTEDGE(n));
+		ls1x_writel(ls1x_readl(LS1X_INTC_INTIEN(n))
+				| (1 << bit), LS1X_INTC_INTIEN(n));
+		irq_set_handler_locked(data, handle_edge_irq);
+	} else if (flow_type && IRQ_TYPE_LEVEL_MASK) {
+		ls1x_writel(ls1x_readl(LS1X_INTC_INTCLR(n))
+				| (1 << bit), LS1X_INTC_INTCLR(n));
+		if (flow_type & IRQ_TYPE_LEVEL_HIGH)
+			ls1x_writel(ls1x_readl(LS1X_INTC_INTPOL(n))
+					| (1 << bit), LS1X_INTC_INTPOL(n));
+		else if (flow_type & IRQ_TYPE_LEVEL_LOW)
+			ls1x_writel(ls1x_readl(LS1X_INTC_INTPOL(n))
+					& ~(1 << bit), LS1X_INTC_INTPOL(n));
+
+		ls1x_writel(ls1x_readl(LS1X_INTC_INTEDGE(n))
+				& ~(1 << bit), LS1X_INTC_INTEDGE(n));
+		ls1x_writel(ls1x_readl(LS1X_INTC_INTIEN(n))
+				| (1 << bit), LS1X_INTC_INTIEN(n));
+		irq_set_handler_locked(data, handle_level_irq);
+	}
+
+	return IRQ_SET_MASK_OK;
+}
+
 static struct irq_chip ls1x_irq_chip = {
 	.name		= "LS1X-INTC",
 	.irq_ack	= ls1x_irq_ack,
 	.irq_mask	= ls1x_irq_mask,
 	.irq_mask_ack	= ls1x_irq_mask_ack,
 	.irq_unmask	= ls1x_irq_unmask,
+	.irq_set_type	= ls1x_irq_set_type,
 };
 
 static void ls1x_irq_dispatch(int n)
@@ -138,6 +183,7 @@ static void __init ls1x_irq_init(int base)
 	setup_irq(INT1_IRQ, &cascade_irqaction);
 	setup_irq(INT2_IRQ, &cascade_irqaction);
 	setup_irq(INT3_IRQ, &cascade_irqaction);
+	setup_irq(INT4_IRQ, &cascade_irqaction);
 }
 
 void __init arch_init_irq(void)
-- 
1.9.1

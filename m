Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Sep 2012 14:06:09 +0200 (CEST)
Received: from moutng.kundenserver.de ([212.227.126.171]:56762 "EHLO
        moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903463Ab2IJMFh (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 10 Sep 2012 14:05:37 +0200
Received: from mailbox.adnet.avionic-design.de (mailbox.avionic-design.de [109.75.18.3])
        by mrelayeu.kundenserver.de (node=mrbap3) with ESMTP (Nemesis)
        id 0M7Jry-1TWGI62NMs-00x4G0; Mon, 10 Sep 2012 14:05:25 +0200
Received: from localhost (localhost [127.0.0.1])
        by mailbox.adnet.avionic-design.de (Postfix) with ESMTP id E27752A282E6;
        Mon, 10 Sep 2012 14:05:23 +0200 (CEST)
X-Virus-Scanned: amavisd-new at avionic-design.de
Received: from mailbox.adnet.avionic-design.de ([127.0.0.1])
        by localhost (mailbox.avionic-design.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Qvw6QJoCXljX; Mon, 10 Sep 2012 14:05:22 +0200 (CEST)
Received: from localhost (avionic-0098.adnet.avionic-design.de [172.20.31.233])
        (Authenticated sender: thierry.reding)
        by mailbox.adnet.avionic-design.de (Postfix) with ESMTPA id A32242A282DF;
        Mon, 10 Sep 2012 14:05:22 +0200 (CEST)
From:   Thierry Reding <thierry.reding@avionic-design.de>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Antony Pavlov <antonynpavlov@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Maarten ter Huurne <maarten@treewalker.org>
Subject: [PATCH v2 1/3] MIPS: JZ4740: Break circular header dependency
Date:   Mon, 10 Sep 2012 14:05:17 +0200
Message-Id: <1347278719-15276-2-git-send-email-thierry.reding@avionic-design.de>
X-Mailer: git-send-email 1.7.12
In-Reply-To: <1347278719-15276-1-git-send-email-thierry.reding@avionic-design.de>
References: <1347278719-15276-1-git-send-email-thierry.reding@avionic-design.de>
X-Provags-ID: V02:K0:P1KBcgsyvYL/mcNyro9+r0jLVESETgYND9K42T3JfZi
 rG+CQtCz7KRGoqQBjlIDfQLgm23QPqrphcRIdRaYdzKF81xd5r
 KUTJ6SRtsHvWzG8SJ1nlZtRgMR+gbwXZ/U9F+9GLiUh7cQa2XA
 1d1lUNhGk6uxuIw3qFU/wnNwTtaOEbHYlCUwGHty2lfNmhaceh
 CwOLEU1KunxjKJ3mKE0sSBgmnRvLzWlbV1zdpmeHdAE6TWBWqB
 m7RSYON7Qlhr/XNLcEiZBuOv0Z4NDHJY8V7QjqI3M44vRHWEsG
 pKWpjAHddgQrVnmROz0E/AXLoQnDR59bl4i5DdBgE3kM56EXkl
 cBBBGSVym7fVXVPFoCtMRzbjapHoq/LMHBSF242p5WdGu25mED
 nleqXJ/B2BpK8s2rSyS+RDqZHhDWqYR+zwhZo/P/511Os1hX8f
 m9ws0
X-archive-position: 34448
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: thierry.reding@avionic-design.de
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
Return-Path: <linux-mips-bounce@linux-mips.org>

When including irq.h, arch/mips/jz4740/irq.h will be selected as the
first candidate. This header does not include the proper definitions
(most notably NR_IRQS) required by subsequent headers. To solve this
arch/mips/jz4740/irq.h can be deleted and its contents can be moved
into arch/mips/include/asm/mach-jz4740/irq.h, which will then be
correctly included.

Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
---
 arch/mips/include/asm/mach-jz4740/irq.h |  5 +++++
 arch/mips/jz4740/irq.h                  | 23 -----------------------
 2 files changed, 5 insertions(+), 23 deletions(-)
 delete mode 100644 arch/mips/jz4740/irq.h

diff --git a/arch/mips/include/asm/mach-jz4740/irq.h b/arch/mips/include/asm/mach-jz4740/irq.h
index 5ad1a9c..aa6fd90 100644
--- a/arch/mips/include/asm/mach-jz4740/irq.h
+++ b/arch/mips/include/asm/mach-jz4740/irq.h
@@ -54,4 +54,9 @@
 
 #define NR_IRQS (JZ4740_IRQ_ADC_BASE + 6)
 
+struct irq_data;
+
+extern void jz4740_irq_suspend(struct irq_data *data);
+extern void jz4740_irq_resume(struct irq_data *data);
+
 #endif
diff --git a/arch/mips/jz4740/irq.h b/arch/mips/jz4740/irq.h
deleted file mode 100644
index f75e39d..0000000
--- a/arch/mips/jz4740/irq.h
+++ /dev/null
@@ -1,23 +0,0 @@
-/*
- *  Copyright (C) 2010, Lars-Peter Clausen <lars@metafoo.de>
- *
- *  This program is free software; you can redistribute it and/or modify it
- *  under  the terms of the GNU General  Public License as published by the
- *  Free Software Foundation;  either version 2 of the License, or (at your
- *  option) any later version.
- *
- *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  675 Mass Ave, Cambridge, MA 02139, USA.
- *
- */
-
-#ifndef __MIPS_JZ4740_IRQ_H__
-#define __MIPS_JZ4740_IRQ_H__
-
-#include <linux/irq.h>
-
-extern void jz4740_irq_suspend(struct irq_data *data);
-extern void jz4740_irq_resume(struct irq_data *data);
-
-#endif
-- 
1.7.12

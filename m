Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 18 Mar 2018 00:29:51 +0100 (CET)
Received: from outils.crapouillou.net ([89.234.176.41]:59150 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23994666AbeCQX32xdn-h (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 18 Mar 2018 00:29:28 +0100
From:   Paul Cercueil <paul@crapouillou.net>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     James Hogan <jhogan@kernel.org>,
        Maarten ter Huurne <maarten@treewalker.org>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        linux-doc@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v4 2/8] dt-bindings: ingenic: Add DT bindings for TCU clocks
Date:   Sun, 18 Mar 2018 00:28:55 +0100
Message-Id: <20180317232901.14129-3-paul@crapouillou.net>
In-Reply-To: <20180317232901.14129-1-paul@crapouillou.net>
References: <20180110224838.16711-2-paul@crapouillou.net>
 <20180317232901.14129-1-paul@crapouillou.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1521329368; bh=qXC78VoewIDb7UcrmQGHCB8u/EjVj/0CD8cCShPDsf8=; h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=ATnNaZIAiBjPJE2C8rddZT2p8UdI0qxd7TezO/+u6cNYSlqzYBxaf7GxXFp2LQuNKr/vf7qxWMDXC44C7Rlb1iyimLfyhNngW6rmyqbK9Yxleo+KJoPT9HZyiTaSZqVCikf3U3gzkCL62LLN77Mw1b5K7/fkovQeBEDSFTF0YTs=
Return-Path: <paul@crapouillou.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63017
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul@crapouillou.net
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

This header provides clock numbers for the ingenic,tcu
DT binding.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 include/dt-bindings/clock/ingenic,tcu.h | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)
 create mode 100644 include/dt-bindings/clock/ingenic,tcu.h

 v2: Use SPDX identifier for the license
 v3: No change
 v4: No change

diff --git a/include/dt-bindings/clock/ingenic,tcu.h b/include/dt-bindings/clock/ingenic,tcu.h
new file mode 100644
index 000000000000..179815d7b3bb
--- /dev/null
+++ b/include/dt-bindings/clock/ingenic,tcu.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * This header provides clock numbers for the ingenic,tcu DT binding.
+ */
+
+#ifndef __DT_BINDINGS_CLOCK_INGENIC_TCU_H__
+#define __DT_BINDINGS_CLOCK_INGENIC_TCU_H__
+
+#define JZ4740_CLK_TIMER0	0
+#define JZ4740_CLK_TIMER1	1
+#define JZ4740_CLK_TIMER2	2
+#define JZ4740_CLK_TIMER3	3
+#define JZ4740_CLK_TIMER4	4
+#define JZ4740_CLK_TIMER5	5
+#define JZ4740_CLK_TIMER6	6
+#define JZ4740_CLK_TIMER7	7
+#define JZ4740_CLK_WDT		8
+#define JZ4740_CLK_LAST		JZ4740_CLK_WDT
+
+#define JZ4770_CLK_OST		9
+#define JZ4770_CLK_LAST		JZ4770_CLK_OST
+
+#endif /* __DT_BINDINGS_CLOCK_INGENIC_TCU_H__ */
-- 
2.11.0

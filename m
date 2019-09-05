Return-Path: <SRS0=Lyod=XA=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33056C43331
	for <linux-mips@archiver.kernel.org>; Thu,  5 Sep 2019 14:45:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67E1E206CD
	for <linux-mips@archiver.kernel.org>; Thu,  5 Sep 2019 14:45:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="LRTXpe59"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731715AbfIEOpt (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Thu, 5 Sep 2019 10:45:49 -0400
Received: from forward103p.mail.yandex.net ([77.88.28.106]:37282 "EHLO
        forward103p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728918AbfIEOpt (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Thu, 5 Sep 2019 10:45:49 -0400
Received: from mxback25j.mail.yandex.net (mxback25j.mail.yandex.net [IPv6:2a02:6b8:0:1619::225])
        by forward103p.mail.yandex.net (Yandex) with ESMTP id 1FBC818C0DE1;
        Thu,  5 Sep 2019 17:45:46 +0300 (MSK)
Received: from smtp2o.mail.yandex.net (smtp2o.mail.yandex.net [2a02:6b8:0:1a2d::26])
        by mxback25j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id mPVYa6OIO5-jjJ4arOt;
        Thu, 05 Sep 2019 17:45:46 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; s=mail; t=1567694746;
        bh=SYUsU3A6DANeNap3vpGKSbFb8T19SYF+OCm5875euJU=;
        h=In-Reply-To:Subject:To:From:Cc:References:Date:Message-Id;
        b=LRTXpe59c2XXW10E/GRjYLxQBczkPI7aerOE6E4ZF4ZlujYm4l2j+JCz6wN+9oqe4
         SlqC7e8c76cricRRNZSgDiDgm85KunuuJujDL1JF1Pd+SuXJuXnwnr+JfwqhdJbVL5
         4Z1bOuGN5p0HpiXPc7HRczpOGW+u4YtB5o36/5gs=
Authentication-Results: mxback25j.mail.yandex.net; dkim=pass header.i=@flygoat.com
Received: by smtp2o.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id zkoybIaMjG-jWxWOA4N;
        Thu, 05 Sep 2019 17:45:44 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     linux-mips@vger.kernel.org
Cc:     chenhc@lemote.com, paul.burton@mips.com, tglx@linutronix.de,
        jason@lakedaemon.net, maz@kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.co,
        devicetree@vger.kernel.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v2 08/19] dt-bindings: interrupt-controller: Add Loongson-3 HTINTC
Date:   Thu,  5 Sep 2019 22:43:05 +0800
Message-Id: <20190905144316.12527-9-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190905144316.12527-1-jiaxun.yang@flygoat.com>
References: <20190905144316.12527-1-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

Document Loongson-3 HyperTransport Interrupt controller.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../loongson,ls3-htintc.yaml                  | 55 +++++++++++++++++++
 1 file changed, 55 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/loongson,ls3-htintc.yaml

diff --git a/Documentation/devicetree/bindings/interrupt-controller/loongson,ls3-htintc.yaml b/Documentation/devicetree/bindings/interrupt-controller/loongson,ls3-htintc.yaml
new file mode 100644
index 000000000000..51fee46ab060
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/loongson,ls3-htintc.yaml
@@ -0,0 +1,55 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/interrupt-controller/loongson,ls3-htintc.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Loongson-3 HyperTransport Interrupt Controller
+
+maintainers:
+  - Jiaxun Yang <jiaxun.yang@flygoat.com>
+
+description: |
+  This interrupt controller is found in the Loongson-3 family of chips to transfer
+  interrupts from PCH connected on HyperTransport bus.
+
+properties:
+  compatible:
+    const: loongson,ls3-htintc
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 4
+    description: |
+      Four parent interrupts that recieve chained interrupt randomly.
+
+  interrupt-controller: true
+
+  '#interrupt-cells':
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - interrupt-controller
+  - '#interrupt-cells'
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    htintc: interrupt-controller@fb000080 {
+      compatible = "loongson,ls3-htintc";
+      reg = <0xfb000080 0x100>;
+      interrupt-controller;
+      #interrupt-cells = <1>;
+
+      interrupt-parent = <&iointc>;
+      interrupts = <24 IRQ_TYPE_LEVEL_HIGH>,
+            <25 IRQ_TYPE_LEVEL_HIGH>,
+            <26 IRQ_TYPE_LEVEL_HIGH>,
+            <27 IRQ_TYPE_LEVEL_HIGH>;
+    };
+...
-- 
2.22.0


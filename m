Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 30 Sep 2018 16:16:21 +0200 (CEST)
Received: from mail-wm1-x343.google.com ([IPv6:2a00:1450:4864:20::343]:34188
        "EHLO mail-wm1-x343.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990697AbeI3OPl0lKfu (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 30 Sep 2018 16:15:41 +0200
Received: by mail-wm1-x343.google.com with SMTP id z25-v6so1214702wmf.1;
        Sun, 30 Sep 2018 07:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eE/ETHLbMl3NJJvo+UMJ+v7fpw1vrx7CW0hC0Ws6guA=;
        b=Dsb/209yFJkMl8ZV5UZSq9ybQeVs91BiJx8Vi3h6NTnKWiN+nb9OMLk5YcB+XElPuy
         Lh+q9vryyAhLbCx4qqdvTYv23H4jqhCaSGeKPe7/OSmpagkCZSqMNZ55OM+nyzWXo7r9
         Lgsch/OuS9dDOB09v/R2RIzzcW5JwBj8ig3vcWy2qEzpy4hEyUI4gWwqrqXDonKmhuHS
         yJXiYka2UYhLqFraRx4HwMLjKOaDojf4oseXjRzZPg9j05veSB9HYfPCZiQm9F84QMW2
         cTUHpqJze7YcCFacVlZCTGXXvJJNME2StPiQ4omfq/zjRpESLbNdQqTOrjrDiU6s9Vi4
         ahYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eE/ETHLbMl3NJJvo+UMJ+v7fpw1vrx7CW0hC0Ws6guA=;
        b=VfgyqAqaQ3BetnISfmVPS8+lSkvDAKC3OW5wlxMaTlZwwGa66aUF4V5uiUBLQIm7Ke
         YwqR+OBlZ7v866/goPTDK5DEELtAMchp4O+MSsuAYizui5JUi8wsHEo5ML8PcCJi1oBh
         fB4qPLKTwlCnRFkDc+xF/mdOO5ivhnxdD2yTAjqBsz1mwLiKRb+K52zgpsOeY05OABDz
         ERPQMOfmduF5bckD+9C+o1Pq9l4ww1Ofwv4ac/Cq5T6rRfHP9ijPblr8XDpTFJrF7Uh2
         P6vCobbvqQXUVowT9NvcdSi7B6SbdNBP0ZbHNTBt09zYyKUiOGASjupH5Td0LoQ7zqKB
         lg1A==
X-Gm-Message-State: ABuFfoiXm2Ng0ktT05Hxhcn15mM+aWjjIPLovvmn/8cwR5uM3awxOvAf
        m77n/AxDB5wZgCAoyTFY2z0c9nyAKfk=
X-Google-Smtp-Source: ACcGV62N6K0XMIPKLVAVpfE0r+VkRZLP3ypLiMVB7nLQQfraMrAEq1uZV1+kzLczmz5JCmsJ1idHCQ==
X-Received: by 2002:a1c:e0d7:: with SMTP id x206-v6mr6276008wmg.93.1538316935860;
        Sun, 30 Sep 2018 07:15:35 -0700 (PDT)
Received: from laptop.localdomain ([37.122.159.87])
        by smtp.gmail.com with ESMTPSA id v21-v6sm19415738wrd.4.2018.09.30.07.15.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Sep 2018 07:15:35 -0700 (PDT)
From:   Yasha Cherikovsky <yasha.che3@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org
Cc:     Yasha Cherikovsky <yasha.che3@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC 3/5] dt-binding: interrupt-controller: Document RTL8186 SoC DT bindings
Date:   Sun, 30 Sep 2018 17:15:08 +0300
Message-Id: <20180930141510.2690-4-yasha.che3@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180930141510.2690-1-yasha.che3@gmail.com>
References: <20180930141510.2690-1-yasha.che3@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-Path: <yasha.che3@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66620
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yasha.che3@gmail.com
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

This patch adds device tree binding doc for the
Realtek RTL8186 SoC interrupt controller.

Signed-off-by: Yasha Cherikovsky <yasha.che3@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Paul Burton <paul.burton@mips.com>
Cc: James Hogan <jhogan@kernel.org>
Cc: devicetree@vger.kernel.org
Cc: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org
---
 .../interrupt-controller/realtek,rtl8186-intc  | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/realtek,rtl8186-intc

diff --git a/Documentation/devicetree/bindings/interrupt-controller/realtek,rtl8186-intc b/Documentation/devicetree/bindings/interrupt-controller/realtek,rtl8186-intc
new file mode 100644
index 000000000000..21956d210021
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/realtek,rtl8186-intc
@@ -0,0 +1,18 @@
+Realtek RTL8186 SoC interrupt controller
+
+Required properties:
+
+- compatible : should be "realtek,rtl8186-intc"
+- interrupt-controller : Identifies the node as an interrupt controller.
+- #interrupt-cells : Specifies the number of cells needed to encode an
+  interrupt source. The value shall be 1.
+- reg : Specifies base physical address and size of the registers.
+
+Example:
+
+intc: interrupt-controller@1d010000 {
+	compatible = "realtek,rtl8186-intc";
+	interrupt-controller;
+	#interrupt-cells = <1>;
+	reg = <0x1d010000 0x8>;
+};
-- 
2.19.0

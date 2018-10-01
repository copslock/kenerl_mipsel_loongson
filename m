Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Oct 2018 12:31:13 +0200 (CEST)
Received: from mail-wm1-x342.google.com ([IPv6:2a00:1450:4864:20::342]:39335
        "EHLO mail-wm1-x342.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994553AbeJAKa1vgZJd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 1 Oct 2018 12:30:27 +0200
Received: by mail-wm1-x342.google.com with SMTP id q8-v6so8184967wmq.4;
        Mon, 01 Oct 2018 03:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=14qXf8FTfStXCuMfxFD5sUAc0+iyBkt3QVppyXlAkhE=;
        b=G0cIh0RgoWvbr7VEiXBcXTo2HNRCvggCODA8/cPWZkAlyi9EDFqfjBOZouo2FTpVjA
         Qcud7gtQ5nMy//Ax9V2ggdRQBT+gA3Ai7R1uZZeHoR3p9fL2M50tUD1smE3F2QUJZ4qI
         3DOg97nhjF7PRzQvTO6NFdj9YBzOKgOt9cC6qsIrdRFkNl2w6zjrLzlbTbh5knF3BuyE
         8E3CYNK0OO+5FxuTMUfphMEjm0KhuCIIu7ivCADBQDQeEULKg7QAW+FK8H1MyUrvMm87
         KlBCivkAROx5EC2tg/vjv+4Z8lj8X2QfFLj5LPjnM3OWH/kcRF1On5f2yptpqGI35ZjC
         E5qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=14qXf8FTfStXCuMfxFD5sUAc0+iyBkt3QVppyXlAkhE=;
        b=YhrQruQcY/qJDwdFkA68YC78ri7w+9pH0QfB8rvczBkNgxTTiflVZlr3FI02gE+FRV
         lntBkrK2IHSml0PyvgYzQ4fWbmfM+6punV/md8ouOYPi223cAOZBZ4WjIV5RuZud+Fkr
         tqaVeOMU9HSzDnWBt1/I0THOzpO6X6/IU77+kTtLUphIFl+eWEv8L9nMBxahv5ypghPr
         PA+cz9iDYhutzoAHr+Pn0U/aRLUspmP6Sxz4o2gNE2dbC5e/tNvUIjXg/3jIj+xY5KAy
         zofKdLY26SmEYBNzMT7qYpgzxsuMvFI6M5AGsHkzaW4enVfGmFwMCf000LwVw2CCkqYN
         O5+w==
X-Gm-Message-State: ABuFfoj+SZyPcG+L1xbEi/R9sHArPRPAgNwRJEO0+64L/BE0WTo9a0GV
        iMMk+HaEI09GPl28wFwkCgH+QuDIRTU=
X-Google-Smtp-Source: ACcGV6351YfS9QoSsDHUiOobVuh0U60BefEsiS7Y7IjD2T3QfYR1rex/Fn2+DvOQtAuilYEPyBk2ew==
X-Received: by 2002:a1c:1e8e:: with SMTP id e136-v6mr3177051wme.100.1538389822335;
        Mon, 01 Oct 2018 03:30:22 -0700 (PDT)
Received: from laptop.localdomain ([37.122.159.87])
        by smtp.gmail.com with ESMTPSA id g8-v6sm2461169wmf.45.2018.10.01.03.30.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Oct 2018 03:30:22 -0700 (PDT)
From:   Yasha Cherikovsky <yasha.che3@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org
Cc:     Yasha Cherikovsky <yasha.che3@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [RFC v2 4/7] dt-binding: timer: Document RTL8186 SoC DT bindings
Date:   Mon,  1 Oct 2018 13:29:49 +0300
Message-Id: <20181001102952.7913-5-yasha.che3@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181001102952.7913-1-yasha.che3@gmail.com>
References: <20181001102952.7913-1-yasha.che3@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-Path: <yasha.che3@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66642
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
Realtek RTL8186 SoC timer controller.

Signed-off-by: Yasha Cherikovsky <yasha.che3@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Paul Burton <paul.burton@mips.com>
Cc: James Hogan <jhogan@kernel.org>
Cc: devicetree@vger.kernel.org
Cc: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org
---
 .../bindings/timer/realtek,rtl8186-timer.txt    | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/timer/realtek,rtl8186-timer.txt

diff --git a/Documentation/devicetree/bindings/timer/realtek,rtl8186-timer.txt b/Documentation/devicetree/bindings/timer/realtek,rtl8186-timer.txt
new file mode 100644
index 000000000000..eaa6292c16e0
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/realtek,rtl8186-timer.txt
@@ -0,0 +1,17 @@
+Realtek RTL8186 SoC timer
+
+Required properties:
+
+- compatible : Should be "realtek,rtl8186-timer".
+- reg : Specifies base physical address and size of the registers.
+- interrupts : The interrupt number of the timer.
+- clocks: phandle to the source clock (usually a 22 MHz fixed clock)
+
+Example:
+
+timer {
+	compatible = "realtek,rtl8186-timer";
+	reg = <0x1d010050 0x30>;
+	interrupts = <0>;
+	clocks = <&sysclk>;
+};
-- 
2.19.0

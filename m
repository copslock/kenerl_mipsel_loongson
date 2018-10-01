Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Oct 2018 12:30:50 +0200 (CEST)
Received: from mail-wr1-x442.google.com ([IPv6:2a00:1450:4864:20::442]:42972
        "EHLO mail-wr1-x442.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994540AbeJAKaXxDsmd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 1 Oct 2018 12:30:23 +0200
Received: by mail-wr1-x442.google.com with SMTP id b11-v6so13282951wru.9;
        Mon, 01 Oct 2018 03:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eE/ETHLbMl3NJJvo+UMJ+v7fpw1vrx7CW0hC0Ws6guA=;
        b=nMwW5LBA8WrGgwePmDgiisPk20YadWq/BoIoR2xiCHcd3dVahu1j7gm3Ptj8UyG2Kk
         aDbVRCXsGw/K14OOcrI9onnJGTXQAoe97X2vusHOz91XlO9HQkWfo1wKWD9QH5b17cUv
         ioiA9JMAndcT3I8yORBY8Maf+3y/sk5lmJV0D/3DX9rS7Q5zS8FAyFUIfvWu7a9lNKex
         hUOMfoBrrKbYu/PWqVs+EUfFLj1+MxaidtMCaifeqZdvM6wWnA41RjTd933NYI9rwVW/
         7Cos9wND2zaFb0D1rDVqYRGq8xgJKk0nlTSXL8RoIeoRTYqhjysxGSpLStgr3DUpCsQi
         OzMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eE/ETHLbMl3NJJvo+UMJ+v7fpw1vrx7CW0hC0Ws6guA=;
        b=l/3Za6c0yjLvEm7gd6EGxMSmheKKvXa58rhBACV6Fwb155IcgzJa5S+9gPSiTDtMV2
         GzbXQegZbJ0pnub3bjss3kqAi8EdcsuG0zuem2SyD0AI1JE/TLXkkiMSlj8aQ2i4I2NS
         zvLYT4A70GZ9eCI/3isxCmV471xq9I34RO8VmFEwEkgFJBNzrQg4vEHJWJzRbjCmyf1Y
         LcTzPFfKG/kbTH1ClDtTYh2zCFxMryic8MACvSOAinumcqZmAKr9mtdhoQGhjlZMde74
         q98RsPNQVgYgcob3x824oKtFASIw71sGIJ4ugiCNn1lXzP+xzCRTtobFcgn06cDKd1cv
         u1Pw==
X-Gm-Message-State: ABuFfojrTMb8vOJkjnfCyfEXleo4GtNKq51cJ+mOPQm/iFYhc/BfiDrP
        oYVYLqhO1nmRWo3PsTe66cmy0L5rqZ4=
X-Google-Smtp-Source: ACcGV63/RMHbOik+vGmGQqIGsQNnD0Fe03xJoZK71lbaIqBrkaoXo3pXhiUsog7bMr2UAR3HymSzLQ==
X-Received: by 2002:a5d:5342:: with SMTP id t2-v6mr6469966wrv.257.1538389818383;
        Mon, 01 Oct 2018 03:30:18 -0700 (PDT)
Received: from laptop.localdomain ([37.122.159.87])
        by smtp.gmail.com with ESMTPSA id g8-v6sm2461169wmf.45.2018.10.01.03.30.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Oct 2018 03:30:18 -0700 (PDT)
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
Subject: [RFC v2 2/7] dt-binding: interrupt-controller: Document RTL8186 SoC DT bindings
Date:   Mon,  1 Oct 2018 13:29:47 +0300
Message-Id: <20181001102952.7913-3-yasha.che3@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181001102952.7913-1-yasha.che3@gmail.com>
References: <20181001102952.7913-1-yasha.che3@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-Path: <yasha.che3@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66640
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

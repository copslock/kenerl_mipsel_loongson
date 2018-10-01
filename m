Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Oct 2018 12:31:39 +0200 (CEST)
Received: from mail-wr1-x444.google.com ([IPv6:2a00:1450:4864:20::444]:42975
        "EHLO mail-wr1-x444.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994560AbeJAKacEPdbd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 1 Oct 2018 12:30:32 +0200
Received: by mail-wr1-x444.google.com with SMTP id b11-v6so13283466wru.9;
        Mon, 01 Oct 2018 03:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wP8gGwUDrSL9keWQMyoyyvbPjeufR/446T1xMXR37Co=;
        b=jQzRo2KHWcNRoA+X+HVmuECNfdRYfVugr0gKcwkMPpGEA5uoJUREszXZLnu1aaUZCn
         LIbsSkW4WJDFRtAY5abf4ypyxMBPQgl1vyK6U8+xxhBrtBxlgMzEd5PHbaChC8WGuEdY
         mIqr9JT5ibMB43CGx1jwgkAdM3a4Aepz2liJn/bAmH8VZ2ks/O+0sTTsUNMwfxS5/SDG
         sM0ENDb4FmnQUMa5XMqDdLnXQlK53rgL+z2tyTLPR7HWbL2qodAhQq7NbHsOnw+mgb79
         WZJUHN8+LHgyVKKFwpo89g5c7q81tZT33qjdX2TktQ2Xd4h2Kf3jTt/6jTZkeXeAG+RU
         xxHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wP8gGwUDrSL9keWQMyoyyvbPjeufR/446T1xMXR37Co=;
        b=ChFzFJMNs7QS/W+rA3RCGiqbbL7pOEinlmuOXtOEBc6Ubqrn+iE1ymAZD406T1Y/3c
         GeRLKq6YsJdG4u09QIim1FZSKXY2dlIxISKz/Kq+/qbNJd1Qn3kciThcRKrluNi7KM63
         kUUxwmN9CRnAYrdREveEqi6jzFmJBisNQ0qDEctOvXOgeLb1yF/eKyHv4jTFy7DAzBuk
         ARjqQjAg8dU2Y347VLBFCZJZ29vI2g9mrOdGwc2V2RRbF6uLQ4VA7jULeS70ontG6CHH
         FXgl5jGZPBCiB9/w62rJAB759cLO1rWVTa/hU51oja8LUGbsROuqGY1Mbaqw1UtTenDn
         9O6w==
X-Gm-Message-State: ABuFfohNY8wM5sCjdzK67EA2r69gjf7phyEYlVi+MA4kq1iTuAPO+Q79
        teozAgROjWOjJmR9X2Dj7J9EEfzgVFY=
X-Google-Smtp-Source: ACcGV61tQRjXUoTkVVUVGK+YsNanbdFoGlaxVtvZnH5YsbZnDvMqVAf3xqv/XD0AClgnGgipzOmobQ==
X-Received: by 2002:adf:a969:: with SMTP id u96-v6mr6369707wrc.222.1538389826589;
        Mon, 01 Oct 2018 03:30:26 -0700 (PDT)
Received: from laptop.localdomain ([37.122.159.87])
        by smtp.gmail.com with ESMTPSA id g8-v6sm2461169wmf.45.2018.10.01.03.30.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Oct 2018 03:30:26 -0700 (PDT)
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
Subject: [RFC v2 6/7] dt-binding: mips: Document Realtek SoC DT bindings
Date:   Mon,  1 Oct 2018 13:29:51 +0300
Message-Id: <20181001102952.7913-7-yasha.che3@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181001102952.7913-1-yasha.che3@gmail.com>
References: <20181001102952.7913-1-yasha.che3@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-Path: <yasha.che3@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66644
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

This patch adds device tree binding doc for Realtek MIPS SoCs.

It includes a compatible string for the Realtek RTL8186 SoC.

Signed-off-by: Yasha Cherikovsky <yasha.che3@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Paul Burton <paul.burton@mips.com>
Cc: James Hogan <jhogan@kernel.org>
Cc: devicetree@vger.kernel.org
Cc: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org
---
 Documentation/devicetree/bindings/mips/realtek.txt | 9 +++++++++
 1 file changed, 9 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mips/realtek.txt

diff --git a/Documentation/devicetree/bindings/mips/realtek.txt b/Documentation/devicetree/bindings/mips/realtek.txt
new file mode 100644
index 000000000000..09d19758168a
--- /dev/null
+++ b/Documentation/devicetree/bindings/mips/realtek.txt
@@ -0,0 +1,9 @@
+Realtek MIPS SoC device tree bindings
+
+1. SoCs
+
+Each device tree must specify a compatible value for the Realtek SoC
+it uses in the compatible property of the root node. The compatible
+value must be one of the following values:
+
+  realtek,rtl8186-soc
-- 
2.19.0

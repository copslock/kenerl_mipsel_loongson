Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Aug 2017 20:26:22 +0200 (CEST)
Received: from mail-pg0-x241.google.com ([IPv6:2607:f8b0:400e:c05::241]:35053
        "EHLO mail-pg0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994888AbdHQS0PPPhd7 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 17 Aug 2017 20:26:15 +0200
Received: by mail-pg0-x241.google.com with SMTP id t80so4944921pgb.2;
        Thu, 17 Aug 2017 11:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=b0nBqjc7djLg4zUt5fd4yQ7V3GpR4f0lzmLgxOt5DkU=;
        b=DFLZMfTpvtycgsC6KrOLmesDWLUY8VfV3bDoNxM5XPkCN7Bs6gUMlAsvXVjdg3EWNy
         ud/5uEDYWcuOre0h+RpT1JQv31eWl9IFTOQuCW0RaN90eP8oaHhqUP/2Ntk08A6PuN7p
         qbi53X5On4a1CY6qxW8AkBzGQSkYD4cwOsBr4FqodypPzqXrjQw4oXF0HnURaBixdVR4
         BVRWZwHgGWevC30scBxD730hYLCxWmorea+KwISlQlwVrD97aomQMLaIye+zTvu3JYjI
         uDaONjYfMq9WD0N3xIMwvn4LjcrSWf6Ni9ZIZ4e9J3Mid1d1cz/pGp/q0e6l61mwjGAH
         t/Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=b0nBqjc7djLg4zUt5fd4yQ7V3GpR4f0lzmLgxOt5DkU=;
        b=sHRsX6RyvoshzO9G8W3ael2YiZe5ehj6RVL7c48rx/8WQz0+VqkB8/bSxZEnbo3t+M
         EPM4d2Ruqc4LCiOdOadElT2qSXoulP4iHCHiXtyNaQ2EL4KXUicdSwoK6ElAhFB83IKg
         /1v8dQ1ty9Pm3X/l1Dae8eYSoCs12PgMazIsxUnLcjE9vxpqK6KsOBkYB3XU2ZcJlXuU
         0q7ey8J3IzVNO2SnlqtMUtrjtAhFmeKDH/rXSHG9ByWB8BF5k585dJ4zkFNodLLx6+jm
         gGEJJk+PRJBJQfyHM2qL/CKCVjhvAqcqliLPOFSonHpuZU2UoHLHiipLqZ7MFLixdvO7
         MeGQ==
X-Gm-Message-State: AHYfb5gelq9RtE76PtGtjGNAGqCIQNBzwzwmV5b5Q8SSQi+K8R0YpMCX
        +a3vpMrOVW9+pQ==
X-Received: by 10.84.254.76 with SMTP id a12mr7079310pln.439.1502994369554;
        Thu, 17 Aug 2017 11:26:09 -0700 (PDT)
Received: from linux.local ([42.109.133.212])
        by smtp.gmail.com with ESMTPSA id a86sm8882565pfe.181.2017.08.17.11.25.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 17 Aug 2017 11:26:09 -0700 (PDT)
From:   PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
To:     herbert@gondor.apana.org.au, robh+dt@kernel.org,
        mark.rutland@arm.com, ralf@linux-mips.org, mturquette@baylibre.com,
        sboyd@codeaurora.org, davem@davemloft.net, paul@crapouillou.net,
        linux-crypto@vger.kernel.org, linux-mips@linux-mips.org
Cc:     PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
Subject: [PATCH 1/6] crypto: jz4780-rng: Add devicetree bindings for RNG in JZ4780 SoC
Date:   Thu, 17 Aug 2017 23:55:15 +0530
Message-Id: <20170817182520.20102-2-prasannatsmkumar@gmail.com>
X-Mailer: git-send-email 2.10.0
In-Reply-To: <20170817182520.20102-1-prasannatsmkumar@gmail.com>
References: <20170817182520.20102-1-prasannatsmkumar@gmail.com>
Return-Path: <prasannatsmkumar@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59629
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: prasannatsmkumar@gmail.com
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

Add devicetree bindings for hardware pseudo random number generator
present in Ingenic JZ4780 SoC.

Signed-off-by: PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
---
 .../devicetree/bindings/rng/ingenic,jz4780-rng.txt | 24 ++++++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rng/ingenic,jz4780-rng.txt

diff --git a/Documentation/devicetree/bindings/rng/ingenic,jz4780-rng.txt b/Documentation/devicetree/bindings/rng/ingenic,jz4780-rng.txt
new file mode 100644
index 0000000..88a0a92
--- /dev/null
+++ b/Documentation/devicetree/bindings/rng/ingenic,jz4780-rng.txt
@@ -0,0 +1,24 @@
+Ingenic jz4780 RNG driver
+
+Required properties:
+- compatible : Should be "ingenic,jz4780-rng"
+
+Example:
+
+cgu_registers {
+	compatible = "simple-mfd", "syscon";
+	reg = <0x10000000 0x100>;
+
+	cgu: jz4780-cgu@10000000 {
+		compatible = "ingenic,jz4780-cgu";
+
+		clocks = <&ext>, <&rtc>;
+		clock-names = "ext", "rtc";
+
+		#clock-cells = <1>;
+	};
+
+	rng: rng@d8 {
+		compatible = "ingenic,jz480-rng";
+	};
+};
-- 
2.10.0

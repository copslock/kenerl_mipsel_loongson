Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Aug 2017 04:58:06 +0200 (CEST)
Received: from mail-pg0-x242.google.com ([IPv6:2607:f8b0:400e:c05::242]:34914
        "EHLO mail-pg0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990511AbdHWC5mR0hys (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 23 Aug 2017 04:57:42 +0200
Received: by mail-pg0-x242.google.com with SMTP id m133so461704pga.2;
        Tue, 22 Aug 2017 19:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=phcFsdWDqG7TeGjBNoWJbV5xDY4Q14cQBDBGXmtJ42k=;
        b=V5Xf/+i+Z/haK2Q0wR3iHxmgJo+qhOPB3wLxkMSDpS8DbdI4YIBsh7eZihbAH/x/qY
         ITIt2BWxmtL8mL8rksO/9m/SI2C2cMCp9ikHDkzp6/iyoMFxSSvRwLvdSKkP78XfQdvH
         TIozVNn+t7xXXGGvFSfdqZ0emuNSYyRYlS0P3CT+KwSH1DIHwF+VTpUUTTfAmAWHsMEZ
         GhUA9mAl5gS6pFAiBK3dJHldog7zQaRQVFsBgyA3pgTexjE84BA6he4rM4rQyzI4gLmh
         H8m26QfV+aEcxqU+VKV9RfJSRLAFALu+oELwAHzW0VCNYdxDm0QXKfKlBop1QdmZuCpj
         hvAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=phcFsdWDqG7TeGjBNoWJbV5xDY4Q14cQBDBGXmtJ42k=;
        b=eCuMm/kV3lRBF6lRPV4QbOqRdeV1fPEoV/JcLCFmXrIhiWRTyt6GI3sAJeQX2vsh5K
         3aJ8u0dQf/S+gXneDejhgSytqAZx3WR8HQAHQBy0h31S/YwLBC/yxhczvbdXKf5rGVKq
         ZVcRbhTTDbahVsyaZKamrQxVNYwHwXlqqQCQ2gAZpgt+q/zkRqIdH8neBr7OWOFpyETX
         3UsptLc2D45Vvm3E7+vqM1Ac8JmlJmxWdV3WG6UrT1UZkAIZMX/ErH1zS1PEjPUTSu3s
         D3C5Adi8Wuy2ISHYdpefQ6fvZ7RMZUORB35QStDideM+1+p8RBg/J3iMc7wx/8oTk6Ls
         ogqQ==
X-Gm-Message-State: AHYfb5gHXIj9e86P8ADBVk/82Pb0t88xcndR507HhShHtyFiYmKAD7MZ
        W5eGYArfhKVb0A==
X-Received: by 10.84.174.193 with SMTP id r59mr1373113plb.266.1503457056551;
        Tue, 22 Aug 2017 19:57:36 -0700 (PDT)
Received: from linux.local ([42.109.139.20])
        by smtp.gmail.com with ESMTPSA id 10sm489771pfs.131.2017.08.22.19.57.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 22 Aug 2017 19:57:35 -0700 (PDT)
From:   PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        robh+dt@kernel.org, mark.rutland@arm.com, ralf@linux-mips.org,
        paul@crapouillou.net, linux-crypto@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mips@linux-mips.org,
        malat@debian.org, noloader@gmail.com
Cc:     PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
Subject: [PATCH v2 1/4] crypto: jz4780-rng: Add JZ4780 PRNG devicetree binding documentation
Date:   Wed, 23 Aug 2017 08:27:04 +0530
Message-Id: <20170823025707.27888-2-prasannatsmkumar@gmail.com>
X-Mailer: git-send-email 2.10.0
In-Reply-To: <20170823025707.27888-1-prasannatsmkumar@gmail.com>
References: <20170823025707.27888-1-prasannatsmkumar@gmail.com>
Return-Path: <prasannatsmkumar@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59765
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
Changes in v2:
* Add "syscon" in CGU node's compatible section
* Make RNG child node of CGU.

 .../bindings/crypto/ingenic,jz4780-rng.txt           | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/crypto/ingenic,jz4780-rng.txt

diff --git a/Documentation/devicetree/bindings/crypto/ingenic,jz4780-rng.txt b/Documentation/devicetree/bindings/crypto/ingenic,jz4780-rng.txt
new file mode 100644
index 0000000..a0c18e5
--- /dev/null
+++ b/Documentation/devicetree/bindings/crypto/ingenic,jz4780-rng.txt
@@ -0,0 +1,20 @@
+Ingenic jz4780 RNG driver
+
+Required properties:
+- compatible : Should be "ingenic,jz4780-rng"
+
+Example:
+
+cgu: jz4780-cgu@10000000 {
+	compatible = "ingenic,jz4780-cgu", "syscon";
+	reg = <0x10000000 0x100>;
+
+	clocks = <&ext>, <&rtc>;
+	clock-names = "ext", "rtc";
+
+	#clock-cells = <1>;
+
+	rng: rng@d8 {
+		compatible = "ingenic,jz480-rng";
+	};
+};
-- 
2.10.0

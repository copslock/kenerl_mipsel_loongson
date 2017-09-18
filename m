Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 Sep 2017 16:05:35 +0200 (CEST)
Received: from mail-pg0-x244.google.com ([IPv6:2607:f8b0:400e:c05::244]:35789
        "EHLO mail-pg0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992800AbdIROEXk1lDY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 18 Sep 2017 16:04:23 +0200
Received: by mail-pg0-x244.google.com with SMTP id j16so296774pga.2;
        Mon, 18 Sep 2017 07:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=i9VW3ROZjKNMHBBUDPGc83f+IqJjnk8vMG8hhdQS+RQ=;
        b=WHujJjEs6TQXKXN8dQeC67dg07ZFO05fkBUwGtM+qIJd2rWSYiTGsYZqeT5004vIUk
         taIwZJsaTSq8x3qRklHygQ5wAXNc2rnRGBfJcXYdI/ddGOoNGB5aU+VPu1h6hovhuEAH
         kGhKMmz046kaz/D/FNsx6SAkrjsknHrufXK/olpiIOaeuC4EIXi12HPtpImjhuR/YLNL
         QJyeeVBaelIOk9RfRfyn8+pcECyQaYdvLTmNbG8ZKjxGqYut2QcOYiqw7fNeR2EySx+g
         7EOxM2mejgKQpQjTR5z+DI/D2TGv/8BvmRNbF0q/7oeLjN8E1RfJ76eVaboOzoIc6UM7
         FVEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=i9VW3ROZjKNMHBBUDPGc83f+IqJjnk8vMG8hhdQS+RQ=;
        b=ApCIRB327QKe76q+5q6fa2SXFs/5eT1yFd073k2UnYVXQ/cybt6MVPjdjKs5t8lVnX
         h+mDJciLdeU9peJscGtIBPouqCl/zNmahjTHfYWKBzW1AiFDzQLrR+j9kEA8lL1xBFE2
         105GoIS+R6ZNYGR5s3dLzzh5xq6q7Sm+qvuv8XTRQJtlblvgHTD0bgZtiBbxZcBVpyWm
         1yhYXrrVLoITRZK+lmECcNeGtl515aM6CwQa5P+43hKliZ61NVOWMkM5/dyQxJTAspl7
         hXR05EUQ0aNLPfj/z261NcKEtpLcHfqAkn+5GfwpD4f5zrdaVBiwUVKtEfiCOqsvlAhX
         tiXw==
X-Gm-Message-State: AHPjjUgBIXfLgYn6pryjouz3yNzJBKbA0+XPFXRp2FBqN57RVFz+huih
        O7ikmXj6K+kbpw==
X-Google-Smtp-Source: AOwi7QAEf/gfC4BMjtI6/pgCDxGfL9ZlZhl0e0WTqeWwTf1btwgulM4D4PhbVuKv7IEeBBL6iAoi4g==
X-Received: by 10.84.171.132 with SMTP id l4mr10761919plb.369.1505743457621;
        Mon, 18 Sep 2017 07:04:17 -0700 (PDT)
Received: from linux.local ([43.224.131.38])
        by smtp.gmail.com with ESMTPSA id q77sm14683252pfa.173.2017.09.18.07.04.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 18 Sep 2017 07:04:17 -0700 (PDT)
From:   PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
To:     herbert@gondor.apana.org.au, robh+dt@kernel.org,
        ralf@linux-mips.org, davem@davemloft.net, paul@crapouillou.net,
        linux-crypto@vger.kernel.org, linux-mips@linux-mips.org,
        malat@debian.org, noloader@gmail.com
Cc:     PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
Subject: [PATCH v3 3/4] crypto: jz4780-rng: Add RNG node to jz4780.dtsi
Date:   Mon, 18 Sep 2017 19:32:40 +0530
Message-Id: <20170918140241.24003-4-prasannatsmkumar@gmail.com>
X-Mailer: git-send-email 2.10.0
In-Reply-To: <20170918140241.24003-1-prasannatsmkumar@gmail.com>
References: <20170918140241.24003-1-prasannatsmkumar@gmail.com>
Return-Path: <prasannatsmkumar@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60059
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

Add RNG node to jz4780 dtsi. This driver uses registers that are part of
the register set used by Ingenic CGU driver. Use regmap in RNG driver to
access its register. Create 'simple-bus' node, make CGU and RNG node as
child of it so that both the nodes are visible without changing CGU
driver code.

Signed-off-by: PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
---
Changes in v3:
* Create a cgublock node with "simple-bus" compatible
* Make CGU and RNG node as children of cgublock node.

Changes in v2:                                                                   
* Add "syscon" in CGU node's compatible section                                  
* Make RNG child node of CGU.                                                    

 arch/mips/boot/dts/ingenic/jz4780.dtsi | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/arch/mips/boot/dts/ingenic/jz4780.dtsi b/arch/mips/boot/dts/ingenic/jz4780.dtsi
index 4853ef6..5953b97 100644
--- a/arch/mips/boot/dts/ingenic/jz4780.dtsi
+++ b/arch/mips/boot/dts/ingenic/jz4780.dtsi
@@ -34,14 +34,29 @@
 		clock-frequency = <32768>;
 	};
 
-	cgu: jz4780-cgu@10000000 {
-		compatible = "ingenic,jz4780-cgu";
+	cgublock {
+		compatible = "simple-bus";
+
+		#address-cells = <1>;
+		#size-cells = <1>;
+
 		reg = <0x10000000 0x100>;
+		ranges;
 
-		clocks = <&ext>, <&rtc>;
-		clock-names = "ext", "rtc";
+		cgu: jz4780-cgu@0 {
+			compatible = "ingenic,jz4780-cgu";
+			reg = <0x10000000 0x100>;
 
-		#clock-cells = <1>;
+			clocks = <&ext>, <&rtc>;
+			clock-names = "ext", "rtc";
+
+			#clock-cells = <1>;
+		};
+
+		rng: rng@d8 {
+			compatible = "ingenic,jz4780-rng";
+			reg = <0x100000d8 0x8>;
+		};
 	};
 
 	pinctrl: pin-controller@10010000 {
-- 
2.10.0

Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 Sep 2017 16:04:43 +0200 (CEST)
Received: from mail-pf0-x244.google.com ([IPv6:2607:f8b0:400e:c00::244]:36575
        "EHLO mail-pf0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992936AbdIROEJb99FY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 18 Sep 2017 16:04:09 +0200
Received: by mail-pf0-x244.google.com with SMTP id f84so227823pfj.3;
        Mon, 18 Sep 2017 07:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=U1roZZ3gUZQbugUUHryRJR7hTG4X23hmF2f/hY25pjs=;
        b=hzldUYonBjjx+zT9Teu/TzP5rrd1fiVM1c1Nx8En6n93KvsFxZJYkUIUVIoU6pbQQR
         WkFmUCoV4nJRqw7Tqj4//UbhLXFfJbIAMv2gEeKcy6lfzVeUvhdx58C65yG5hFI+ofrK
         J+4pgVZE1Un0Aro1KgkDbxvdMcHOkXrcUz3Yr5w+ca+P/g2wo+q75VFEa7s712y4b91o
         GBj1zinbx8Mjhs/AqwGXv5byYXT2SDbW+Vf4dREpotPo6oAMgbShR1vTf2SIcZ4ErpPK
         hZe1jCj73Jw2FtsMO7oG97QUEwwXZdtSx/hnHakOIuB5xZL7wACYzFk7QateUUqmopU8
         FOXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=U1roZZ3gUZQbugUUHryRJR7hTG4X23hmF2f/hY25pjs=;
        b=N8QovqFfGfXZLyU07e/Bl5QBFtC+VOu7JNFWnaK7/DvrJbMYn1fK4HvJBNBb3OYpNb
         5eAuLYlMh992+EGn3XEN4ZKMHHTdAW0QRdqk94tp4+HdKKN6jSzOJCHUPubfok/omPjN
         T8gwYI00qg3Fu56n3OqMq1n3peky/sMp4ZkyyJehJtn3G5Rqz9WvADT8UPLHp15ShwMM
         ebbv38y3tRuPGrmYsDmIroDUXabY6DnHgnF19j20FSigR5uGNModwz5+/dLVs9mkuWwf
         H/mtEw4cyUCPy22P9wqbp/wNzlkSbM0sfscvtr8xZcQVw/UIJc5tUUQ4CmRaOjfEtQuc
         995Q==
X-Gm-Message-State: AHPjjUhodIzxhDV86o+3ruEBC7BgaaHsxt5hCw44wTAt/r855UIdpN4I
        IuaqYeKizTdY0Q==
X-Google-Smtp-Source: ADKCNb5Yx059HGx/t5vfXCCOfxnRqKunpGQiNA1268XMoPx63kBIP6/RleKI40WeMPbPr8KnByS9kQ==
X-Received: by 10.99.1.10 with SMTP id 10mr31775428pgb.377.1505743443284;
        Mon, 18 Sep 2017 07:04:03 -0700 (PDT)
Received: from linux.local ([43.224.131.38])
        by smtp.gmail.com with ESMTPSA id q77sm14683252pfa.173.2017.09.18.07.03.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 18 Sep 2017 07:04:02 -0700 (PDT)
From:   PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
To:     herbert@gondor.apana.org.au, robh+dt@kernel.org,
        ralf@linux-mips.org, davem@davemloft.net, paul@crapouillou.net,
        linux-crypto@vger.kernel.org, linux-mips@linux-mips.org,
        malat@debian.org, noloader@gmail.com
Cc:     PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
Subject: [PATCH v3 1/4] crypto: jz4780-rng: Add JZ4780 PRNG devicetree binding documentation
Date:   Mon, 18 Sep 2017 19:32:38 +0530
Message-Id: <20170918140241.24003-2-prasannatsmkumar@gmail.com>
X-Mailer: git-send-email 2.10.0
In-Reply-To: <20170918140241.24003-1-prasannatsmkumar@gmail.com>
References: <20170918140241.24003-1-prasannatsmkumar@gmail.com>
Return-Path: <prasannatsmkumar@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60057
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
Changes in v3:
* Create a cgublock node with "simple-bus" compatible
* Make CGU and RNG node as children of cgublock node.

Changes in v2:                                                                   
* Add "syscon" in CGU node's compatible section                                  
* Make RNG child node of CGU.                                                    

 .../devicetree/bindings/rng/ingenic,jz4780-rng.txt  | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rng/ingenic,jz4780-rng.txt

diff --git a/Documentation/devicetree/bindings/rng/ingenic,jz4780-rng.txt b/Documentation/devicetree/bindings/rng/ingenic,jz4780-rng.txt
new file mode 100644
index 0000000..765df9c
--- /dev/null
+++ b/Documentation/devicetree/bindings/rng/ingenic,jz4780-rng.txt
@@ -0,0 +1,21 @@
+Ingenic jz4780 RNG driver
+
+Required properties:
+- compatible : Should be "ingenic,jz4780-rng"
+
+Example:
+
+cgublock {
+	compatible = "simple-bus";
+
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	reg = <0x10000000 0x100>;
+	ranges;
+
+	rng: rng@d8 {
+		compatible = "ingenic,jz4780-rng";
+		reg = <0x100000d8 0x8>;
+	};
+};
-- 
2.10.0

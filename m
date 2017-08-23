Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Aug 2017 04:58:54 +0200 (CEST)
Received: from mail-pf0-x242.google.com ([IPv6:2607:f8b0:400e:c00::242]:34053
        "EHLO mail-pf0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991073AbdHWC55a6YXs (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 23 Aug 2017 04:57:57 +0200
Received: by mail-pf0-x242.google.com with SMTP id m6so441349pfm.1;
        Tue, 22 Aug 2017 19:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MdAi7Xz+Ke7XDXG1p6c+258PK1c/acyBvKP4xQyiiuM=;
        b=spFr16Ab+vKtStJdv/lKWAStr52XbmCfKpvmKqIi9gTZ5YlY3dnGK87fGXUS84WLSz
         j3r51hZuy3MQAg9RxLzTaaDAv0U56qsq6UL2o1gF6ZlfLEhntrHXYH8Otwhq0vdE0h/D
         9pm0hyJLvJPNZphHjhfB2vHLuuWnF5qUf3nY8GHjHr36eCR+BK+QlxJHNDEi5lPdAns+
         bpv74CgEsyIAMP5NosEt/L2ph/HCEE0BRYcnqnq6tGXL7mP/dM9jmK3NTZvodyvXu6W1
         WAe0yziaTmojQOi3IcnZjohVloAqQak2h7xAlgWpHpkOYbZ0kfOkMc0S6OJhOYYH16R6
         xTmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MdAi7Xz+Ke7XDXG1p6c+258PK1c/acyBvKP4xQyiiuM=;
        b=sSViyXSyVTbnf+e5IATnZCyXjFC1F9wYoZ04EJEHBvkDsEWE13eHieBaH9excqk0s6
         SUKye8Ld/w1abQfpbJEf9L/qCpJKUuGV5fvzbvzf6HOXehyIlceQp8i2vItuKHtzuMEP
         YzBj/d3ce5Zf904iNKV/A7L4z0wGY/3X2DJB28KmUb5+ktel+GNQSvJ5ynTC78lduO8l
         soSp4m9/7aaE3Fxh7XvxTEpyyFNZ8UDdq9dsiOmwDZexqPAybS/NwVjXVlSvwZks6Scs
         7GUtBzuCMHMF4B3OdB3FILw48fLA5TGWjDKiCaaSyg6eKJKW13KCcyY9xe0V92YCVF1B
         q7Jg==
X-Gm-Message-State: AHYfb5gFpQ5Sc6S5UPqecr6FUSzP/pB5jgIKQu61v0cwZMtZu9UZtUSO
        lc0vuAwKCr+UIYFvLPbelA==
X-Received: by 10.99.2.148 with SMTP id 142mr1270810pgc.164.1503457071551;
        Tue, 22 Aug 2017 19:57:51 -0700 (PDT)
Received: from linux.local ([42.109.139.20])
        by smtp.gmail.com with ESMTPSA id 10sm489771pfs.131.2017.08.22.19.57.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 22 Aug 2017 19:57:50 -0700 (PDT)
From:   PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        robh+dt@kernel.org, mark.rutland@arm.com, ralf@linux-mips.org,
        paul@crapouillou.net, linux-crypto@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mips@linux-mips.org,
        malat@debian.org, noloader@gmail.com
Cc:     PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
Subject: [PATCH v2 3/4] crypto: jz4780-rng: Add RNG node to jz4780.dtsi
Date:   Wed, 23 Aug 2017 08:27:06 +0530
Message-Id: <20170823025707.27888-4-prasannatsmkumar@gmail.com>
X-Mailer: git-send-email 2.10.0
In-Reply-To: <20170823025707.27888-1-prasannatsmkumar@gmail.com>
References: <20170823025707.27888-1-prasannatsmkumar@gmail.com>
Return-Path: <prasannatsmkumar@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59767
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
the register set used by Ingenic CGU driver. Make RNG node as child of
CGU node.

Signed-off-by: PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
---
Changes in v2:
* Add "syscon" in CGU node's compatible section
* Make RNG child node of CGU.

 arch/mips/boot/dts/ingenic/jz4780.dtsi | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/mips/boot/dts/ingenic/jz4780.dtsi b/arch/mips/boot/dts/ingenic/jz4780.dtsi
index 4853ef6..411e16c 100644
--- a/arch/mips/boot/dts/ingenic/jz4780.dtsi
+++ b/arch/mips/boot/dts/ingenic/jz4780.dtsi
@@ -35,13 +35,17 @@
 	};
 
 	cgu: jz4780-cgu@10000000 {
-		compatible = "ingenic,jz4780-cgu";
+		compatible = "ingenic,jz4780-cgu", "syscon";
 		reg = <0x10000000 0x100>;
 
 		clocks = <&ext>, <&rtc>;
 		clock-names = "ext", "rtc";
 
 		#clock-cells = <1>;
+
+		rng: rng@d8 {
+			compatible = "ingenic,jz480-rng";
+		};
 	};
 
 	pinctrl: pin-controller@10010000 {
-- 
2.10.0

Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Aug 2017 20:27:33 +0200 (CEST)
Received: from mail-pg0-x244.google.com ([IPv6:2607:f8b0:400e:c05::244]:38551
        "EHLO mail-pg0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994894AbdHQS0dK5HQ7 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 17 Aug 2017 20:26:33 +0200
Received: by mail-pg0-x244.google.com with SMTP id 123so11058039pga.5;
        Thu, 17 Aug 2017 11:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=X0TCe7lc0rZWTnYJWqEdwMoR5YFCW16zS93tPbVOsdk=;
        b=WCixEgsdwSGnlEpP0S7gEz9OrSrfTnXbE1yiG10JcwAQK54U3YTrM6QBxCXWBCV0LY
         EW6RpS7gSsBQ3SfhyTlzgUQoii7d88/kAeCY89eydWS5XHBg2SxdpNFTyokZbOwJ4yBv
         qOmHvDjVkm2FDGRXMgWrOZkzsNbjQ+UYa7G8GXiGD/7IiDj88HIy7hwo7a/r1D1FnL1h
         PrFi+4sd2/CzfLtQ6/1nophLOWu+ZugKhTHKcHoDMu58U8cPnTUV92jv7lLbgTVwRZxq
         qPbi4w282I7UIsf9NMgg/GNeTQQZPGiPpqD5F3Gg3hjNbIKJ41c99Kvo6lYDua3gt1hB
         elLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=X0TCe7lc0rZWTnYJWqEdwMoR5YFCW16zS93tPbVOsdk=;
        b=pf5n8XdqCVymWbL+zldILi+c98+jLnfAYu/joW8lpZYvoJerZ7ubM5s+K5eRLcxnFh
         sh9Z2+YnZxOyEqNOgenbll87jwy/Zq4+4aXMo3S5btcFH/OyjwWYFRtMGVEGxrR7HJv0
         2lOzPFAALpEDxxCbrdwBFfMhuKSitOdz5Vgx0G3F1IIAbG0s3tKD9vC0qr/d0Q0UmEL/
         UBF915ncFkvBrtpyCH/rjP27HnG8Qq66OqTXaWA1No6vGgybcfY3DEOa2ywkH2DxdjXA
         CmqATF1Ij5rqHNpm0yH6lRaGqX58U/E5jIyn9Q5CLme8+TxVqxpcJSkrMhM2aEyk6UH7
         oIwg==
X-Gm-Message-State: AHYfb5gUQyCgW5PeFafgq90YWX+VZJ0DM9ySEnXkglG5cJoA1Won3OTo
        l1zkqDIGl6n9yQ==
X-Received: by 10.98.178.213 with SMTP id z82mr6227686pfl.30.1502994385702;
        Thu, 17 Aug 2017 11:26:25 -0700 (PDT)
Received: from linux.local ([42.109.133.212])
        by smtp.gmail.com with ESMTPSA id a86sm8882565pfe.181.2017.08.17.11.26.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 17 Aug 2017 11:26:25 -0700 (PDT)
From:   PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
To:     herbert@gondor.apana.org.au, robh+dt@kernel.org,
        mark.rutland@arm.com, ralf@linux-mips.org, mturquette@baylibre.com,
        sboyd@codeaurora.org, davem@davemloft.net, paul@crapouillou.net,
        linux-crypto@vger.kernel.org, linux-mips@linux-mips.org
Cc:     PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
Subject: [PATCH 4/6] crypto: jz4780-rng: Add RNG node to jz4780.dtsi
Date:   Thu, 17 Aug 2017 23:55:18 +0530
Message-Id: <20170817182520.20102-5-prasannatsmkumar@gmail.com>
X-Mailer: git-send-email 2.10.0
In-Reply-To: <20170817182520.20102-1-prasannatsmkumar@gmail.com>
References: <20170817182520.20102-1-prasannatsmkumar@gmail.com>
Return-Path: <prasannatsmkumar@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59632
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

This patch adds RNG node to jz4780.dtsi.

Signed-off-by: PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
---
 arch/mips/boot/dts/ingenic/jz4780.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/mips/boot/dts/ingenic/jz4780.dtsi b/arch/mips/boot/dts/ingenic/jz4780.dtsi
index 1301694..865b9bf 100644
--- a/arch/mips/boot/dts/ingenic/jz4780.dtsi
+++ b/arch/mips/boot/dts/ingenic/jz4780.dtsi
@@ -46,6 +46,10 @@
 
 			#clock-cells = <1>;
 		};
+
+		rng: rng@d8 {
+			compatible = "ingenic,jz480-rng";
+		};
 	};
 
 	pinctrl: pin-controller@10010000 {
-- 
2.10.0

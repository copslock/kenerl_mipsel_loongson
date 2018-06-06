Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Jun 2018 21:38:54 +0200 (CEST)
Received: from mail-wm0-x242.google.com ([IPv6:2a00:1450:400c:c09::242]:40882
        "EHLO mail-wm0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994724AbeFFTiZprfo5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 6 Jun 2018 21:38:25 +0200
Received: by mail-wm0-x242.google.com with SMTP id n5-v6so14149077wmc.5;
        Wed, 06 Jun 2018 12:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iZtBVOWqAYziJ/NdJ7U6CZ/xJhq//WZIkEI3sVArBcE=;
        b=JacDx+SwS1JRLUJv6DyMFn7+7FcNTuVed3PvLd3spNSjsPaIDoup/ZE6uPH3wX5yZn
         z+3ehdclDtg8hEdP7G5FWns22Q7qHzeck2N+Q/rOBkEWZE3sAWAJ/9kIDaNeYGVl2Mwu
         6WWjPBmhgl4EX1I37RzR5+7gpFqdyEb3i3+dyLY1C3i7p33eb3iUZiZEHkjcrt9fwFzE
         PchcqMMQfkMjXvXC7sS+Iq2FC/okfGcXjLA2udY2+UKr+C9RXPYdMX4UMjlLUvYGnZ8+
         LiWOB6py4Jxey6hRJ6VxXVA6Itl55pd6CtVKmKRhGCWaPupcDSWj3cdNtZxoynUm0C96
         bgOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=iZtBVOWqAYziJ/NdJ7U6CZ/xJhq//WZIkEI3sVArBcE=;
        b=S6MZ6ibNAFX/Na0UmPXwtwpbYo0cdWghHr3B9T64EVg4TMThnDXuu6xXLMK3t84Zm7
         wvo4zpdEZyFQ3dRfLBV0zk9jYcMslO0KRjpy/bKNfGBQ/Ct046KZAqmWXY2z2WDmL+c3
         AgAhdaR0QQuf/YfoJUxDIgPnPKdmYx0h4JpvoM7vOtCsPjL05QD8Kqe62DjhmSfT0NFE
         2NXK6RgarJ10JLlUV9xzzJ334WGLRHurJ1aJF1ulsv90b3vJuLqgjQti6J0DSG5efp0F
         eV5kcrXdeX5Yd15mrz7drIsJugyKpADia8zpFvz0HWOmzHvXmrTddkssSWRQz5k8EVzm
         5Eog==
X-Gm-Message-State: APt69E3oX7uNiZ70NZeBO2sd2p5XemfVFqGjd0JFDD6GK5J401+RgZku
        MZInMf92CAFhtqDTkBLX19w=
X-Google-Smtp-Source: ADUXVKJioHcccl2ND0wTYMDWNRoGPt67a0qrvVfo4nZoX7FJWTiRP1/pwYEUEMo2Ten4uBjlIrOBGg==
X-Received: by 2002:a1c:688:: with SMTP id 130-v6mr2807867wmg.82.1528313900423;
        Wed, 06 Jun 2018 12:38:20 -0700 (PDT)
Received: from macbookpro.malat.net (bru31-1-78-225-226-121.fbx.proxad.net. [78.225.226.121])
        by smtp.gmail.com with ESMTPSA id l142-v6sm7111830wmd.16.2018.06.06.12.38.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Jun 2018 12:38:19 -0700 (PDT)
Received: by macbookpro.malat.net (Postfix, from userid 1000)
        id D1B0F10C2B81; Wed,  6 Jun 2018 21:38:18 +0200 (CEST)
From:   Mathieu Malaterre <malat@debian.org>
To:     James Hogan <jhogan@kernel.org>
Cc:     Mathieu Malaterre <malat@debian.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, devicetree@vger.kernel.org,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
Subject: [PATCH 3/3] MIPS: jz4780: DTS: Probe the jz4740-i2s driver from devicetree
Date:   Wed,  6 Jun 2018 21:38:10 +0200
Message-Id: <20180606193811.16007-3-malat@debian.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180606193811.16007-1-malat@debian.org>
References: <20180606193811.16007-1-malat@debian.org>
Return-Path: <mathieu.malaterre@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64202
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: malat@debian.org
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

Since commit 967beb2e8777 ("ASoC: jz4740: Add jz4780 support"), jz4740-i2s
driver supports jz4780 hardware. Use proper compatible string.

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 arch/mips/boot/dts/ingenic/jz4780.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/mips/boot/dts/ingenic/jz4780.dtsi b/arch/mips/boot/dts/ingenic/jz4780.dtsi
index ae57976bc016..308079ee8dd3 100644
--- a/arch/mips/boot/dts/ingenic/jz4780.dtsi
+++ b/arch/mips/boot/dts/ingenic/jz4780.dtsi
@@ -57,6 +57,18 @@
 		clock-names = "rtc";
 	};
 
+	i2s: i2s@10020000 {
+		compatible = "ingenic,jz4780-i2s";
+		reg = <0x10020000 0x94>;
+
+		clocks = <&cgu JZ4780_CLK_AIC>, <&cgu JZ4780_CLK_I2SPLL>;
+		clock-names = "aic", "i2s";
+
+		dmas = <&dma 0 JZ4780_DMA_I2S0_RX 0xffffffff>,
+		       <&dma JZ4780_DMA_I2S0_TX 0 0xffffffff>;
+		dma-names = "rx" , "tx";
+	};
+
 	pinctrl: pin-controller@10010000 {
 		compatible = "ingenic,jz4780-pinctrl";
 		reg = <0x10010000 0x600>;
-- 
2.11.0

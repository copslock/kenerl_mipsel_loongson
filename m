Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Jun 2018 21:38:00 +0200 (CEST)
Received: from mail-wm0-x244.google.com ([IPv6:2a00:1450:400c:c09::244]:32803
        "EHLO mail-wm0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994718AbeFFThmGo7h5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 6 Jun 2018 21:37:42 +0200
Received: by mail-wm0-x244.google.com with SMTP id z6-v6so234309wma.0;
        Wed, 06 Jun 2018 12:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gRlJKzsrjUkXCPkm9CJFc+arRqQTE6jVfz0e05peksA=;
        b=gBivzBmb45ws0QWzFjxXFetN6wna8NlU2zqDw1sI3akUmUapnCv2QP+LYi+jTtecFy
         3BiTJZOw4gcz0t/U+OZJm6NOVtjbcVZmZNDGVcJx8HuYoEzDijZw3CpQkrgmuIAvufqx
         YIW2vKNUeez3hAdFUEW91HLRCk1lXTprisCFTbPwrnYQKD4nI0gx4nt0b2KgIUf7Rjr7
         1VNzNPW4a+Q+Ja+0VwXaNH7hc4o92ztImkSF3zkXMn5OoYSWQiSbsggcrvxNUrcE4Ux9
         zUBbf4xDPe9EPboJczj4dV/RCG94S4p9JNN4g5djUlp86trF7S4bNQU6nsHurqRACPUW
         Zt7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=gRlJKzsrjUkXCPkm9CJFc+arRqQTE6jVfz0e05peksA=;
        b=YglUdTPwcY1f5/nRac+uQ8qJOxT1ByxHj12mhP9j9ewyqw55DtOv6/QZePVKiCZYHi
         Q/15lfOsfGgoMLxaz1WiiL/qRPorZALkNo5/ACkGM4Wm4jgS/UznlNJ5W5dcp0ZZCH3I
         WS3QM7qFVWn5wMYHtV1k/+aCR/MqKfiN6gu0CWvyzEUVe9QqdMN+Fl3Bo7PdSQOrUnuU
         4J9ghEI8MNGOl6atidzG06IpbI03VwNHjcMPzf3MOBWFfpM7xR9jLj7y2VsyIaiziRul
         Slo3rfzuFAPAD/lAigYohS7957e4YNCQBFjPo4GMeKnpAWci2uF4OxC68uI5iRwnQLmY
         e29Q==
X-Gm-Message-State: APt69E0fEe98iWuZaFI+hyt0zq8t9zxiq9K7LnzsiBqyCYbKcg1+uRiC
        iXbOp8vKA1VczRFpa+NOXkQ=
X-Google-Smtp-Source: ADUXVKKVbkLjVmzr2Sm6YmpvW2x0vGH9qfhYXAI97WqEb50UQVivpRBmcT/r7DxRGhCkQYh26btEmw==
X-Received: by 2002:a1c:2348:: with SMTP id j69-v6mr2716482wmj.112.1528313856725;
        Wed, 06 Jun 2018 12:37:36 -0700 (PDT)
Received: from macbookpro.malat.net (bru31-1-78-225-226-121.fbx.proxad.net. [78.225.226.121])
        by smtp.gmail.com with ESMTPSA id m134-v6sm5346161wmg.13.2018.06.06.12.37.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Jun 2018 12:37:36 -0700 (PDT)
Received: by macbookpro.malat.net (Postfix, from userid 1000)
        id 0E50510C2B81; Wed,  6 Jun 2018 21:37:35 +0200 (CEST)
From:   Mathieu Malaterre <malat@debian.org>
To:     James Hogan <jhogan@kernel.org>
Cc:     Mathieu Malaterre <malat@debian.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>, devicetree@vger.kernel.org,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] MIPS: jz4780: DTS: Probe the spi-gpio driver from devicetree
Date:   Wed,  6 Jun 2018 21:37:30 +0200
Message-Id: <20180606193730.15087-2-malat@debian.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180606193730.15087-1-malat@debian.org>
References: <20180606193730.15087-1-malat@debian.org>
Return-Path: <mathieu.malaterre@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64199
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

The spi-gpio driver supports jz4780.

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 arch/mips/boot/dts/ingenic/jz4780.dtsi | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/mips/boot/dts/ingenic/jz4780.dtsi b/arch/mips/boot/dts/ingenic/jz4780.dtsi
index 809f01a62955..308079ee8dd3 100644
--- a/arch/mips/boot/dts/ingenic/jz4780.dtsi
+++ b/arch/mips/boot/dts/ingenic/jz4780.dtsi
@@ -167,6 +167,25 @@
 		};
 	};
 
+	spi_gpio {
+		compatible = "spi-gpio";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		num-chipselects = <2>;
+
+		gpio-miso = <&gpe 14 0>;
+		gpio-sck = <&gpe 15 0>;
+		gpio-mosi = <&gpe 17 0>;
+		cs-gpios = <&gpe 16 0
+			    &gpe 18 0>;
+
+		spidev@0 {
+			compatible = "spidev";
+			reg = <0>;
+			spi-max-frequency = <1000000>;
+		};
+	};
+
 	uart0: serial@10030000 {
 		compatible = "ingenic,jz4780-uart";
 		reg = <0x10030000 0x100>;
-- 
2.11.0

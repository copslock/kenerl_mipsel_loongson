Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 17 Jan 2016 11:02:14 +0100 (CET)
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34109 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008349AbcAQKCMr7XQR (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 17 Jan 2016 11:02:12 +0100
Received: by mail-wm0-f68.google.com with SMTP id b14so10966971wmb.1;
        Sun, 17 Jan 2016 02:02:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=v4jACKQ4WesFx0q3T8Ov8bsm4ad4OeoQJQQh+GuwGZs=;
        b=Qrgw2WkBAWC1GrCZGtXcjl21ZWsfiZa8NBUMdjCykr6NmDlYY0GDFridIXBmNi7V8t
         2R9YOcmEpVXRDu7uPh1bb0uWI2TRNyr1lzRvdHM/4tBE0fMGRirKMmy4xeNuYF3X4FXH
         5h5mcg/TiJp5fwo15sUjQUmJgxgEF5gDZymf5uQDTr+753lGjWk/XSpOZaQFcqAyXuQ0
         jMpcPnSkbfUeLJwIDixNv8BHRCFBT8DlMatQ+LPnjZMm5vwv0ah+47aF0ix5UwL+Vekr
         css/m0xmehh+mMMaK/gHbFU6zcyNDhI7H+y6LvhTEb2+PoWOnedYa4P98l/B86MUhXaX
         edAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-type:content-transfer-encoding;
        bh=v4jACKQ4WesFx0q3T8Ov8bsm4ad4OeoQJQQh+GuwGZs=;
        b=Li4i3es3K9/jXgjjpdbSHo94dC1wwoeLWtOo+Y8xaoOakRvEgQuKpUNxQzDI0dU3yQ
         xbax+U32JTQ3LEwCv4Igy8G6e1yy9+h2nLAj/cdVzCbqdMyOP8A7gPx5HGbB5eRRu2T5
         nGfNDIqumApAL8OudoM86VxZEwJjZZaAaMdhmbQS1O1ayPrKIOIZq9BAlFN+S0gKjuKL
         yS5SBIcJ13wo4RzcUUhbr7zIaCVIQNt8wbUs4S7gbV43hsBUY5Kz8NTew5XHpbo4IL5W
         zI+ZrSU5X0uwa3iN5rBaNhwgWjOSLih9sme1vMfs5BNBrADvlLItBuQj9npE27Gu4sHx
         22fw==
X-Gm-Message-State: ALoCoQmR9xUf+JulgRgEhuMWJQb9V44DKuwrmce37NBr09IBa6AnXbs7pDLTTfuQz12QIUGPZiDxXAsFDvjr9WuU63mwaYEELQ==
X-Received: by 10.194.94.232 with SMTP id df8mr18254147wjb.25.1453024927522;
        Sun, 17 Jan 2016 02:02:07 -0800 (PST)
Received: from skynet.lan (140.Red-83-35-232.dynamicIP.rima-tde.net. [83.35.232.140])
        by smtp.gmail.com with ESMTPSA id j3sm10527556wmj.19.2016.01.17.02.02.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 17 Jan 2016 02:02:05 -0800 (PST)
From:   =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        f.fainelli@gmail.com, jogo@openwrt.org, cernekee@gmail.com
Cc:     =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
Subject: [PATCH 1/2] bmips: improve BCM6328 device tree
Date:   Sun, 17 Jan 2016 11:02:34 +0100
Message-Id: <1453024955-13570-1-git-send-email-noltari@gmail.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <noltari@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51174
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: noltari@gmail.com
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

Adds bcm6328-leds node to bcm6328.dtsi

Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
---
 arch/mips/boot/dts/brcm/bcm6328.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/mips/boot/dts/brcm/bcm6328.dtsi b/arch/mips/boot/dts/brcm/bcm6328.dtsi
index 41891c1..d61b161 100644
--- a/arch/mips/boot/dts/brcm/bcm6328.dtsi
+++ b/arch/mips/boot/dts/brcm/bcm6328.dtsi
@@ -31,6 +31,7 @@
 	};
 
 	aliases {
+		leds0 = &leds0;
 		uart0 = &uart0;
 	};
 
@@ -82,5 +83,13 @@
 			offset = <0x28>;
 			mask = <0x1>;
 		};
+
+		leds0: led-controller@10000800 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "brcm,bcm6328-leds";
+			reg = <0x10000800 0x24>;
+			status = "disabled";
+		};
 	};
 };
-- 
1.9.1

Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 31 Jan 2016 23:52:19 +0100 (CET)
Received: from mail-pf0-f179.google.com ([209.85.192.179]:35413 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011904AbcAaWwRd5ra- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 31 Jan 2016 23:52:17 +0100
Received: by mail-pf0-f179.google.com with SMTP id 65so72384787pfd.2;
        Sun, 31 Jan 2016 14:52:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=2Em5fpLmEhMVXya2Wt8UUGPNg2keDioANg2gLgnWmrk=;
        b=QX9OVkO1Itlv6D+/5dmNTupVOWADlPlluj4CM4uD1W0gsgysAcr11Hwtdr+4Fr8clY
         aoRVsBDEwWq1azlcCW5HwQ9LJfbuGAw/XFpx+eW7fym9d+vY/jDc7/nTMasQM6ietOW/
         hjp1+OQkNzsFjABFgIoEhC2FXemfQ+XD/lWhnOvvj75XcuxSW0Z01Mwb8Ygdw//mhyNq
         mi84bw8anDiluoItLKbCDkoMqwlLVToMCfmH7NNSlnA73xIALSmcj5+WVXDsiprQzWm1
         0LJhUTP2Xb70707fy3gogkD8O19aourq5v+z1DrstVVgXqK1Cz2xR1lc0SUShvSnAfEw
         e0xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=2Em5fpLmEhMVXya2Wt8UUGPNg2keDioANg2gLgnWmrk=;
        b=DtdkQYhbmjwL7/CXyfWfw8mPHad25TN7TjiJs2H7huAaSzSVHMap7HgiQH0mBDuzFC
         GVGP06fMZ0kyixboTVOG87z6gqLt9op2N/V9nJVO26KMQwht8ecbHNC/I5/57EoZZLKr
         L4BkypW+IPPZhTDRqaAr46CcIdr+rL+rMpLF7WW+luyenh4+e/nLOp3z62OrjQd4zSYO
         OfenQKeAeS2ZZhbbKOe5vDtrS8rUzNhiTqIHx7r9yOrEL2Lx95vqwYZ8aGOLTKMcc0vX
         V07u5Xrx/fbgLQ7Fy0I6szZbUaGKUW/Oh74LhfXlGfrdYq2Ex3vE4INMREipuOpm33lJ
         PmtA==
X-Gm-Message-State: AG10YOSs4iuzLPko87EwWS4LXoGzhmc0VPZ4xfdcRhYpaAMJQFXN5iHHPIjifFUpfkGnvg==
X-Received: by 10.98.8.14 with SMTP id c14mr33119775pfd.42.1454280731491;
        Sun, 31 Jan 2016 14:52:11 -0800 (PST)
Received: from localhost.localdomain (5520-maca-inet1-outside.broadcom.com. [216.31.211.11])
        by smtp.gmail.com with ESMTPSA id fa3sm38122258pab.45.2016.01.31.14.52.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 31 Jan 2016 14:52:10 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org, blogic@openwrt.org, cernekee@gmail.com,
        jogo@openwrt.org, jaedon.shin@gmail.com, pgynther@google.com,
        Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH] MIPS: BMIPS: Fix gisb-arb compatible string for 7435
Date:   Sun, 31 Jan 2016 14:52:05 -0800
Message-Id: <1454280725-21312-1-git-send-email-f.fainelli@gmail.com>
X-Mailer: git-send-email 1.7.1
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51558
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: f.fainelli@gmail.com
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

The SUN GISB arbiter was added with the wrong compatible string, leading to
using the wrong register layout, use the correct compatible string for this
chip: brcm,bcm7435-gisb-arb.

Fixes: 8394968be4c7 ("MIPS: BMIPS: Add BCM7435 dtsi")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/mips/boot/dts/brcm/bcm7435.dtsi |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/mips/boot/dts/brcm/bcm7435.dtsi b/arch/mips/boot/dts/brcm/bcm7435.dtsi
index 614ee21..7e2ea99 100644
--- a/arch/mips/boot/dts/brcm/bcm7435.dtsi
+++ b/arch/mips/boot/dts/brcm/bcm7435.dtsi
@@ -82,7 +82,7 @@
 		};
 
 		gisb-arb@400000 {
-			compatible = "brcm,bcm7400-gisb-arb";
+			compatible = "brcm,bcm7435-gisb-arb";
 			reg = <0x400000 0xdc>;
 			native-endian;
 			interrupt-parent = <&sun_l2_intc>;
-- 
1.7.1

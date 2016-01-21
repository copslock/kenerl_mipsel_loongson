Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 Jan 2016 10:59:53 +0100 (CET)
Received: from mail-lf0-f68.google.com ([209.85.215.68]:35031 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009408AbcAUJ7hBNa8s (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 21 Jan 2016 10:59:37 +0100
Received: by mail-lf0-f68.google.com with SMTP id c134so1961034lfb.2
        for <linux-mips@linux-mips.org>; Thu, 21 Jan 2016 01:59:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=aPomL8GtXQ6erOQVZhiFITMIFAgIgHJGrPIRMLZ3PPU=;
        b=kj8ZNZ2wA9/haSIXMqpQ2LR8vGrV3F/RyvFyB3WNSyjqaA9CR5qEOiEf9GV727TcT+
         s0uv4dEdfhP5cK86HG5T1xAiaLHq46+mRxuCoCNK8LE20HjwsHDZJsg3/WyPLf1fzjT4
         /BbJBxgV5OAkEeMIohz64H1xTW5lhF95Y9uNLCCgl2V+fyVDrkl+1JXIdKyMGOZ39jjd
         kvheTCw/KsyPIJe0ifUhtHnLJYSnGW0CIFlZCRZMxxmCdi085CMXnFbdJo7wcmxR7AJb
         N1W4M+9BxlNPnPVRWgjC/s04u+oduX8tJOGgzsIGLaeU0KUthmXKcGVouq8yRAVR8vV6
         n1ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=aPomL8GtXQ6erOQVZhiFITMIFAgIgHJGrPIRMLZ3PPU=;
        b=mqSvqLw3PciN7Lp3l6MznHXrHArcAMxvd+hiE0wWuuIkUS7v/SSPmmCi12CkLxsk+x
         fsc3vCAm7OFIZTniLz7uCpr4EhOaWwmE99H4XDZ8TigVHgN+t8MW9gwOxR9HnGogvvhJ
         WZ2O44+JrlA69tCNcXsGZUywJjA6Kj0WdQGjC6uNiCjzxwf4lNDtQ9K+EtZISq1IBXki
         NgeaIlY4acGrCk8xaNOB7z4CMxC2WDyj584ROit+YjYIoFiWBHLer8rjqCTHyThb+mRL
         AZttUginVWGr8I/65H4zP+wvhy0xWzjHatdJIPZvEhOL3JnCryfrlGu+ewLz0tZ0lFqH
         lMDw==
X-Gm-Message-State: ALoCoQnNihzbYoDjD0602zmDD4xo6RxpSoTzznulaI+E0sz4X4H5ZSJ4WUYpID6HHEmUWO2iBr6Esxg5dKU0XTuJka2hlhqbJQ==
X-Received: by 10.112.199.67 with SMTP id ji3mr15208644lbc.105.1453370371765;
        Thu, 21 Jan 2016 01:59:31 -0800 (PST)
Received: from localhost.localdomain (ppp109-252-26-184.pppoe.spdop.ru. [109.252.26.184])
        by smtp.gmail.com with ESMTPSA id i127sm86367lfd.3.2016.01.21.01.59.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 21 Jan 2016 01:59:31 -0800 (PST)
From:   Antony Pavlov <antonynpavlov@gmail.com>
To:     devicetree@vger.kernel.org
Cc:     Antony Pavlov <antonynpavlov@gmail.com>,
        Alban Bedel <albeu@free.fr>, linux-mips@linux-mips.org
Subject: [PATCH 2/3] MIPS: dts: qca: ar9132: drop unused extosc mentions
Date:   Thu, 21 Jan 2016 12:59:04 +0300
Message-Id: <1453370345-16688-3-git-send-email-antonynpavlov@gmail.com>
X-Mailer: git-send-email 2.6.2
In-Reply-To: <1453370345-16688-1-git-send-email-antonynpavlov@gmail.com>
References: <1453370345-16688-1-git-send-email-antonynpavlov@gmail.com>
Return-Path: <antonynpavlov@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51269
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: antonynpavlov@gmail.com
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

At the moment ar913x_clocks_init() does not use extosc node at all,
the reference clock rate is hardcoded inside arch/mips/ath79/clock.c

    #define AR913X_BASE_FREQ        5000000

    ...

    static void __init ar913x_clocks_init(void)
    {
            ref_rate = AR913X_BASE_FREQ;

    ...

            ath79_add_sys_clkdev("ref", ref_rate);

Also please see the commits 'MIPS: ath79: Fix the ar913x reference clock rate'
and 'MIPS: ath79: Fix the ar724x clock calculation' in Alban Bedel's
github ath79 branch https://github.com/AlbanBedel/linux/tree/ath79

Signed-off-by: Antony Pavlov <antonynpavlov@gmail.com>
Cc: Alban Bedel <albeu@free.fr>
Cc: linux-mips@linux-mips.org
Cc: devicetree@vger.kernel.org
---
 arch/mips/boot/dts/qca/ar9132.dtsi               |  3 ---
 arch/mips/boot/dts/qca/ar9132_tl_wr1043nd_v1.dts | 10 ----------
 2 files changed, 13 deletions(-)

diff --git a/arch/mips/boot/dts/qca/ar9132.dtsi b/arch/mips/boot/dts/qca/ar9132.dtsi
index 13d0439..84787e30 100644
--- a/arch/mips/boot/dts/qca/ar9132.dtsi
+++ b/arch/mips/boot/dts/qca/ar9132.dtsi
@@ -87,9 +87,6 @@
 						"qca,ar9130-pll";
 				reg = <0x18050000 0x20>;
 
-				clock-names = "ref";
-				/* The board must provides the ref clock */
-
 				#clock-cells = <1>;
 				clock-output-names = "cpu", "ddr", "ahb";
 			};
diff --git a/arch/mips/boot/dts/qca/ar9132_tl_wr1043nd_v1.dts b/arch/mips/boot/dts/qca/ar9132_tl_wr1043nd_v1.dts
index a6108f8..10905f6 100644
--- a/arch/mips/boot/dts/qca/ar9132_tl_wr1043nd_v1.dts
+++ b/arch/mips/boot/dts/qca/ar9132_tl_wr1043nd_v1.dts
@@ -14,21 +14,11 @@
 		reg = <0x0 0x2000000>;
 	};
 
-	extosc: oscillator {
-		compatible = "fixed-clock";
-		#clock-cells = <0>;
-		clock-frequency = <40000000>;
-	};
-
 	ahb {
 		apb {
 			uart@18020000 {
 				status = "okay";
 			};
-
-			pll-controller@18050000 {
-				clocks = <&extosc>;
-			};
 		};
 
 		spi@1f000000 {
-- 
2.6.2

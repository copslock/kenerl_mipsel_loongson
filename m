Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Feb 2016 06:27:11 +0100 (CET)
Received: from mout.gmx.net ([212.227.15.18]:64568 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27006568AbcBOF1K0rLj8 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 15 Feb 2016 06:27:10 +0100
Received: from ubnt.fritz.box ([37.24.8.189]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0Lymoh-1Zt1Ou11b5-016A6O; Mon, 15 Feb 2016 06:26:43
 +0100
From:   Heinrich Schuchardt <xypron.glpk@gmx.de>
To:     Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Andrew Bresticker <abrestic@chromium.org>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        devicetree@vger.kernel.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org,
        Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH 1/1] MIPS: DTS: cavium-octeon: provide model attribute
Date:   Mon, 15 Feb 2016 06:26:17 +0100
Message-Id: <1455513977-934-1-git-send-email-xypron.glpk@gmx.de>
X-Mailer: git-send-email 2.1.4
X-Provags-ID: V03:K0:AT5PNGJ6apyyrK3zg5dW1QVD0GepOuY2Rq2yCu/UNzj9mBDpHOZ
 Fbh+mdNcW65k/bgPp2ndZHcjApP7BNwUvFf5crZfbjvr3bmHmIHzZvz0PZLumPSAr1jE4Jr
 UWJN6A+BcKCHaVz431X4Jl2VGbh1E3BaE8NudHWQ281CoWWxn1uW5bHAzOVBTERgN8bXi86
 jgPxYm1WMFWlG5WbK/rRg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:7v/Bjx5VTB8=:R45w9OL5qE7cvlaY0BGoOv
 f/esIdkNLLCVn8J7GGyyBegg0HCdKN3VuJOorF6GnSh5T/9O+uZtdAMFxD0s8oIvLBfYh9Igu
 MA9xl1NEPcDnkwUeTRH22y2xk7pZd5I0CwyWUjqcGDoizwYbvwOjEEb4CLfF9j+FXG7SLxE6a
 HNMjuucJAQkxE7UanpzO3QZJRXFXJjoNhNJTCvfW6TDqk8g6Tjq9bByYRWIyX8EMAPfs4eXEf
 wiIeqgGzbQQkzOvJ6yYKECZsKgl3f4tnGqgOCAifxUU9xgNN/XEq5Fu1MYF9VSY4HZ2qEvIRc
 kotWYXCLrVO5LhE33TsMKlOim1YVrwEpP1rpIokPy/Qkx+aI31loUqxOS5O3WFQG/sYDyrIX7
 6kv+559pXCioGYoz8U+TIn9UQlfApwkUhf70uWDKEmchZsb6vAPGFIo7DWxHmYWFaVP16OyhY
 hYPgR21LoYkUVIP3/6K32uuG+t1fMA0727WcRszA4gRSBBn/jlmhXatYD++/ETv9RBBKmqZCU
 SzFxQCKMFQuttlCMkI01AS9Wgy8dMI31NDdKRX2+DfA8q34QA4IHIFEbLWdMuHR5NU0mtmPQq
 GDHbWw1QgdV+go2U4VcM2ftYTsf/xpLHX9y0axojl34WWMQfYwrk1hqU+wMGvncLwcId64mU2
 2aelcFLI6ChMTL+XdIkYDGBJBOkKS+wzx4ZEZnv+13Wrrc0ugaUOlyvoJToAM2nLA6H1CnKfu
 qNm+C+SuyJVSnpX9p6h2RnQm+jsF9Fzm1e+sJJLYiyBSnu8t20RoxqkTZOU=
Return-Path: <xypron.glpk@gmx.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52051
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: xypron.glpk@gmx.de
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

Downstream packages like Debian flash-kernel rely on
/proc/device-tree/model
to determine how to install an updated kernel image.

Most dts files provide this property.
It is suggested by IEEE Std 1275-1994.

This patch adds a model attribute for Octeon CPUs.

Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
---
 arch/mips/boot/dts/cavium-octeon/octeon_3xxx.dts | 1 +
 arch/mips/boot/dts/cavium-octeon/octeon_68xx.dts | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/mips/boot/dts/cavium-octeon/octeon_3xxx.dts b/arch/mips/boot/dts/cavium-octeon/octeon_3xxx.dts
index 9c48e05..a746678 100644
--- a/arch/mips/boot/dts/cavium-octeon/octeon_3xxx.dts
+++ b/arch/mips/boot/dts/cavium-octeon/octeon_3xxx.dts
@@ -8,6 +8,7 @@
  */
 / {
 	compatible = "cavium,octeon-3860";
+	model = "Cavium Octeon 3XXX";
 	#address-cells = <2>;
 	#size-cells = <2>;
 	interrupt-parent = <&ciu>;
diff --git a/arch/mips/boot/dts/cavium-octeon/octeon_68xx.dts b/arch/mips/boot/dts/cavium-octeon/octeon_68xx.dts
index 79b46fc..c8a292a 100644
--- a/arch/mips/boot/dts/cavium-octeon/octeon_68xx.dts
+++ b/arch/mips/boot/dts/cavium-octeon/octeon_68xx.dts
@@ -8,6 +8,7 @@
  */
 / {
 	compatible = "cavium,octeon-6880";
+	model = "Cavium Octeon 68XX";
 	#address-cells = <2>;
 	#size-cells = <2>;
 	interrupt-parent = <&ciu2>;
-- 
2.1.4

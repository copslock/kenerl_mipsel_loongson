Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Feb 2016 19:36:39 +0100 (CET)
Received: from mout.gmx.net ([212.227.15.19]:60609 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27012408AbcBOSgfpKanQ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 15 Feb 2016 19:36:35 +0100
Received: from ubnt.fritz.box ([37.24.8.189]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0Md3ZK-1aDIvC1Vic-00IF3k; Mon, 15 Feb 2016 19:36:08
 +0100
From:   Heinrich Schuchardt <xypron.glpk@gmx.de>
To:     Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>
Cc:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Andrew Bresticker <abrestic@chromium.org>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Arnd Bergmann <arnd@arndb.de>, devicetree@vger.kernel.org,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH 1/1 v2] MIPS: DTS: cavium-octeon: provide model attribute
Date:   Mon, 15 Feb 2016 19:35:41 +0100
Message-Id: <1455561341-2071-1-git-send-email-xypron.glpk@gmx.de>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <56C214EE.5050200@cogentembedded.com>
References: <56C214EE.5050200@cogentembedded.com>
X-Provags-ID: V03:K0:Pnw2tRqReOsfaFJj+GI36GZhkocxuPLQt2YdpqxzinSh9Z7XoUh
 dgZ+AO5aH1S77Rxsky8WdPuXXqkIN7+C5eZzPuPC/MecdtCPT0D/9XAxinbL64yDD5uBnik
 mHGmJchjoee1j1862gwDsUuy5FmRM3mPaibivgESvZHLWuJ5psxvm2/3gO5oNzMz2wg2Osq
 ApMPtArHokDAVvS/IROpg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:rKstSCOj7bI=:x+pyGikfFl3dEvhVom1xLo
 HATrsCc2hZlzy5DgoElWqM3tGdtecRNUfWS6WKzKk8/xUFMf+iqx9GHdaPAe/vOf7AP9n8G6D
 oHn3wldZbU6J2yCn/HwFweIPQq3MkaKGj54eIhZyKDH+OBtJ0FYazJUN/OhyUyGHGrjColG3d
 lOET7nnNDRIZEfC9cPtYdNoap3QZq6MQ7Z0RLok46itDGI84Brm2rZlq/PHAQl3jL2mLiYzw3
 yoR3XNomMHf055xztJGmrdIUNvt+hqe7Ht3BZG0frll3TBn/MSMUpJpNaPm3NDycR71tTZs1S
 SNluKKs195LUB52oSTjSZa5rbJCPb2oCgYpjQ26IGTZqendPpRw78m+YxjIUpdGunliHFIr00
 tVFq+x1DziMVVs8qmuECYnPzsxDjwyirHjtDdJZJ3dbgnwPRG253beN6xWnSxZpKQa2aU/jn6
 cGNMpujPXntLzsAcdhdhkAAayHNA8fVHlP5KmSYTjf8pCtCVBdGiMSf33mBIG0YDlY90gsn3V
 mTC0S2uAxUP6ElNBqUjzhOsI7TbumO198CN50Tkrdax6I5acKUmwpoEQ8NFAUtR6pgX3mif7D
 63H5yOxB8CBWTK7SW52/HybaKYoTp6fAL/UBH+tzW5MUuSyfgvFA675vrbYKboo6wv/y/jjEF
 nJD37l5kc8B0GasPuy0j/gUIZ/nLWlE3VqFgw9lIAvOJODN2oUV+PESulLyPNn8yY9D6hnd8r
 MqwrdyPhdnoWHXJQWNjmrS5zABlrGrG5XUMQmDVqQOXaRXIuCma0R/c0gLU=
Return-Path: <xypron.glpk@gmx.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52068
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

This patch adds a model attribute Octeon CPUs.

v2:
	Use vendor prefix defined in vendor-prefixes.txt.
	Separate model from vendor by comma.
	Avoid wildcards.

Cc: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
---
 arch/mips/boot/dts/cavium-octeon/octeon_3xxx.dts | 1 +
 arch/mips/boot/dts/cavium-octeon/octeon_68xx.dts | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/mips/boot/dts/cavium-octeon/octeon_3xxx.dts b/arch/mips/boot/dts/cavium-octeon/octeon_3xxx.dts
index 9c48e05..f70cd58 100644
--- a/arch/mips/boot/dts/cavium-octeon/octeon_3xxx.dts
+++ b/arch/mips/boot/dts/cavium-octeon/octeon_3xxx.dts
@@ -8,6 +8,7 @@
  */
 / {
 	compatible = "cavium,octeon-3860";
+	model = "cavium,Octeon 3860";
 	#address-cells = <2>;
 	#size-cells = <2>;
 	interrupt-parent = <&ciu>;
diff --git a/arch/mips/boot/dts/cavium-octeon/octeon_68xx.dts b/arch/mips/boot/dts/cavium-octeon/octeon_68xx.dts
index 79b46fc..0b40899 100644
--- a/arch/mips/boot/dts/cavium-octeon/octeon_68xx.dts
+++ b/arch/mips/boot/dts/cavium-octeon/octeon_68xx.dts
@@ -8,6 +8,7 @@
  */
 / {
 	compatible = "cavium,octeon-6880";
+	model = "cavium,Octeon 6880";
 	#address-cells = <2>;
 	#size-cells = <2>;
 	interrupt-parent = <&ciu2>;
-- 
2.1.4

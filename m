Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 Jan 2016 12:02:46 +0100 (CET)
Received: from mout.kundenserver.de ([212.227.17.10]:63936 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010687AbcA0LCovwAqM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 27 Jan 2016 12:02:44 +0100
Received: from wuerfel.localnet ([78.42.132.4]) by mrelayeu.kundenserver.de
 (mreue102) with ESMTPSA (Nemesis) id 0LqlQA-1Zu0ri3vaE-00eJO4; Wed, 27 Jan
 2016 12:02:25 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Mark Brown <broonie@kernel.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Kevin Cernekee <cernekee@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        Johannes Berg <johannes@sipsolutions.net>,
        Simon Arlott <simon@fire.lp0.eu>
Subject: Re: [PATCH 1/2] regmap: Add explict native endian flag to DT bindings
Date:   Wed, 27 Jan 2016 12:02:19 +0100
Message-ID: <1568100.dTeADjCOTa@wuerfel>
User-Agent: KMail/4.11.5 (Linux/3.16.0-10-generic; KDE/4.11.5; x86_64; ; )
In-Reply-To: <1453848410-24949-1-git-send-email-broonie@kernel.org>
References: <1453848410-24949-1-git-send-email-broonie@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Provags-ID: V03:K0:0KrCvjyDFh1R9OPB2y6a0a66/ZOC9QrMhaAmHLoom0MOCAOlOHz
 SvIsdVuG8ODf5WpdbYXEPyf86eqqr3pe9ChdJzgIhvMUqb8PgXIrg40nFVLgzZOSE9zHdMR
 ivNVZkMl8QedZ1H2bd5D+cYIk23EAjRlb9qRAMotzOOEc5vBKrG8u2RJ6XGGBkxl4DxrJtU
 wIfn/pBYx3z8pOwMxr/3A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:iQVUxTLE5HQ=:9wmeIOR9YaEkuRZUauFyco
 83sI86I115qx0I0fCKRvVJHIB67fjCw7QoXZAMHzqR4EbYAw3Z4fRsAE/37FF2DhkXUDQACml
 nTISfsxB1aMqAnuZTzHdqoJWq6O7Cg14+gAgAkZ3XsoLx2cuXHRK8TMDdarXUTfz++sxrrCYL
 uoNijLOV1R+fCpxKjCy96mLsLxNy+XcPjoyEhwqkuBdkPkZurtvmoAKUBwk9RNI9KVQfei72g
 EaivgDqzZG6u81ONes/81VrGqZ3ZXrQ1+VuZ193AcWwlF85SWkl0EC/eI2caiWMsqIK+KAyKm
 pSSwS2F+OyC0Qy1XKMJe7QhE49JhNYJhcQMYIo53uYZ7pmFNmihtSh9ArBc7j6VQo0lOb7TAX
 JmkSJj9TycNd28nqtmVhHPgdOG2Gq+hlHPvqk69mazlDCEHBmUFmnZoPLXxQ4Dmz9CqJHhtAq
 3behnkXm83Cf0g5UxrbPvLgJN4BHy7RBYu2bR+siK9gwAcRgYrTtPCBs34/0I4iIx3Wvn1c3N
 gA2/1/dyhznzRNGLlOokzCHMDyxNiMafbwpUTKcmY9I5fwbbjr/qCS5phqm4v+u+k6h9wsJrb
 mFUU9RCKt7rwJ76vOTXkJTXAlqe9RmUfz7vp5GNlQO3OtLaOcMLU2csiF6vTsagQpUa6lOAmn
 b7zZ1hdsCPoPRfvAUrDevIHuDgeXH6VB+099+77vq0QPTsqRfK63qVRJYgmIjs6GHNumaq7cs
 YNveXFp6CtMj4ELN
Return-Path: <arnd@arndb.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51471
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: arnd@arndb.de
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

On Tuesday 26 January 2016 22:46:49 Mark Brown wrote:
> -Required properties:
> -- {big,little}-endian: these are boolean properties, if absent
> -  meaning that the CPU and the Device are in the same endianness mode,
> -  these properties are for register values and all the buffers only.
> +Optional properties:
> +- {big,little,native}-endian: these are boolean properties, if absent
> +  then the implementation will choose a default based on the device
> +  being controlled.  These properties are for register values and all
> +  the buffers only.  Native endian means that the CPU and device have
> +  the same endianness.

I think the rest of the file also needs to be changed, and we need some
more explanation about native-endian, which people might think is the
right one for them when it rarely is in reality (Broadcom MIPS being
one notable exception).

How about this version below?

	Arnd


diff --git a/Documentation/devicetree/bindings/regmap/regmap.txt b/Documentation/devicetree/bindings/regmap/regmap.txt
dissimilarity index 91%
index b494f8b8ef72..0127be360fe8 100644
--- a/Documentation/devicetree/bindings/regmap/regmap.txt
+++ b/Documentation/devicetree/bindings/regmap/regmap.txt
@@ -1,47 +1,29 @@
-Device-Tree binding for regmap
-
-The endianness mode of CPU & Device scenarios:
-Index     Device     Endianness properties
----------------------------------------------------
-1         BE         'big-endian'
-2         LE         'little-endian'
-
-For one device driver, which will run in different scenarios above
-on different SoCs using the devicetree, we need one way to simplify
-this.
-
-Required properties:
-- {big,little}-endian: these are boolean properties, if absent
-  meaning that the CPU and the Device are in the same endianness mode,
-  these properties are for register values and all the buffers only.
-
-Examples:
-Scenario 1 : CPU in LE mode & device in LE mode.
-dev: dev@40031000 {
-	      compatible = "name";
-	      reg = <0x40031000 0x1000>;
-	      ...
-};
-
-Scenario 2 : CPU in LE mode & device in BE mode.
-dev: dev@40031000 {
-	      compatible = "name";
-	      reg = <0x40031000 0x1000>;
-	      ...
-	      big-endian;
-};
-
-Scenario 3 : CPU in BE mode & device in BE mode.
-dev: dev@40031000 {
-	      compatible = "name";
-	      reg = <0x40031000 0x1000>;
-	      ...
-};
-
-Scenario 4 : CPU in BE mode & device in LE mode.
-dev: dev@40031000 {
-	      compatible = "name";
-	      reg = <0x40031000 0x1000>;
-	      ...
-	      little-endian;
-};
+Devicetree binding for regmap
+
+Optional properties:
+
+   little-endian,
+   big-endian,
+   native-endian:	See common-properties.txt for a definition
+
+Note:
+Regmap defaults to little-endian register access on MMIO based
+devices, this is by far the most common setting. On CPU
+architectures that typically run big-endian operating systems
+(e.g. PowerPC), registers can be defined as big-endian and must
+be marked that way in the devicetree.
+
+On SoCs that can be operated in both big-endian and little-endian
+modes, with a single hardware switch controlling both the endianess
+of the CPU and a byteswap for MMIO registers (e.g. many Broadcom MIPS
+chips), "native-endian" is used to allow using the same device tree
+blob in both cases.
+
+Examples:
+Scenario 1 : a register set in big-endian mode.
+dev: dev@40031000 {
+	      compatible = "syscon";
+	      reg = <0x40031000 0x1000>;
+	      big-endian;
+	      ...
+};

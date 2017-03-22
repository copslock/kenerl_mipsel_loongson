Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Mar 2017 07:00:03 +0100 (CET)
Received: from mail-ve1eur01on0053.outbound.protection.outlook.com ([104.47.1.53]:53152
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23990507AbdCVF74nzaB1 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 22 Mar 2017 06:59:56 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=satixfy.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=OEDvURUXL6bNpGcFOyjxAipa4wNb5pWO8d0SkAUks3w=;
 b=AAndAr9KvpaAf6WqcOe4a+cIp2ttEs1ZP6VvZybwVz5p8fsHo3QmjX30hZcpV8xP4KcmLX7hX39EefT+fGMeWPXsAAKyVnM+73nbuimW1Y9jk3c9chIjgvsxmPF71FJB/DqX+e13nw1PIwvAO/3TC0x1caD4fQHXMC5xs0vlgIs=
Received: from AM4PR0201MB2179.eurprd02.prod.outlook.com (10.165.39.22) by
 AM4PR0201MB2177.eurprd02.prod.outlook.com (10.165.39.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.977.11; Wed, 22 Mar 2017 05:59:49 +0000
Received: from AM4PR0201MB2179.eurprd02.prod.outlook.com ([10.165.39.22]) by
 AM4PR0201MB2179.eurprd02.prod.outlook.com ([10.165.39.22]) with mapi id
 15.01.0977.010; Wed, 22 Mar 2017 05:59:49 +0000
From:   Amit Kama IL <Amit.Kama@satixfy.com>
To:     "corbet@lwn.net" <corbet@lwn.net>
CC:     "ralf@linux-mips.org" <ralf@linux-mips.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "jason@lakedaemon.net" <jason@lakedaemon.net>,
        "marc.zyngier@arm.com" <marc.zyngier@arm.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: [PATCH] Add initial SX3000b platform related documentation to
 document tree
Thread-Topic: [PATCH] Add initial SX3000b platform related documentation to
 document tree
Thread-Index: AdKi0SfaokLDEY4ERKWylojx8o5rjw==
Date:   Wed, 22 Mar 2017 05:59:49 +0000
Message-ID: <AM4PR0201MB21799759E18C64A7032A2C3EE43C0@AM4PR0201MB2179.eurprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lwn.net; dkim=none (message not signed)
 header.d=none;lwn.net; dmarc=none action=none header.from=satixfy.com;
x-originating-ip: [82.80.19.234]
x-microsoft-exchange-diagnostics: 1;AM4PR0201MB2177;7:z8YGtYO5dAT5LyMuqJCNJnQoYtlKVm12KsZjB145+qU2ASzpG3dELgkRSqXECh6U3fCJZZshkwq+9nzdbxC5j3WGnFE228cX+FdjEkjwfWS1Cj2NwsA4j2qfM3ZBewkfjm20xynCMSvs/DSIlsohiyQMLV7eXnJm/NU5NJMyJy41AQNqLMHOUSgGII0VNcOllWrX014Z6S+Uek8J2HMePcLFNG8RcwbPbTtsC31ZiIjfp23ieupjZ2hJQTrT/xGb+RbUkSzSxaTk8jCqf73KyJuZPrDByz0uSpMmN9uvGVv3uPNNXtvSkbb6vvMSdPsYACyDIRZyX2ghZ40ywWC8wg==
x-ms-office365-filtering-correlation-id: 45369716-8bd9-4a7d-ee3e-08d470e8a6b9
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001)(2017030254075);SRVR:AM4PR0201MB2177;
x-microsoft-antispam-prvs: <AM4PR0201MB2177CA48FD9A8A531B3357DDE43C0@AM4PR0201MB2177.eurprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040375)(601004)(2401047)(5005006)(8121501046)(3002001)(10201501046)(6041248)(20161123555025)(2016111802025)(20161123558025)(20161123560025)(20161123564025)(20161123562025)(6043046)(6072148);SRVR:AM4PR0201MB2177;BCL:0;PCL:0;RULEID:;SRVR:AM4PR0201MB2177;
x-forefront-prvs: 02543CD7CD
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(6009001)(39840400002)(39450400003)(39410400002)(2906002)(8676002)(3660700001)(1730700003)(66066001)(5640700003)(9686003)(38730400002)(81166006)(102836003)(2900100001)(3280700002)(74316002)(99286003)(6506006)(6116002)(189998001)(53936002)(2501003)(4326008)(6436002)(8936002)(5660300001)(7736002)(77096006)(7696004)(122556002)(305945005)(55016002)(54906002)(2351001)(33656002)(110136004)(575784001)(50986999)(3846002)(86362001)(6916009)(54356999)(25786009);DIR:OUT;SFP:1101;SCL:1;SRVR:AM4PR0201MB2177;H:AM4PR0201MB2179.eurprd02.prod.outlook.com;FPR:;SPF:None;MLV:sfv;LANG:en;
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: satixfy.com
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2017 05:59:49.4916
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b7ec8c62-61c4-41e4-9993-e34196916505
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0201MB2177
Return-Path: <Amit.Kama@satixfy.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57411
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Amit.Kama@satixfy.com
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

Add initial SX3000b platform related documentation to document tree:
 - Vendor prefix
 - Platform binding documentation
 - Interrupt Controller Unit binding documentation.

Signed-off-by: Amit Kama <amit.kama@staixfy.com>

diff --git a/Documentation/devicetree/bindings/interrupt-controller/satixfy-icu.txt b/Documentation/devicetree/bindings/interrupt-controller/satixfy-icu.txt
index 0000000..1893393
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/satixfy-icu.txt
@@ -0,0 +1,47 @@
+Satixfy SX3000B Interrupt Controller Unit (ICU)
+
+The ICU routes HW interrupts from the inter-module fabric to the
+processor. For the MIPS interaptive, all interrupts are then routed
+to the GIC.
+
+Required properties:
+- compatible : Should be "satixfy,icu".
+- reg - must be present and equal <0x1D4D0000 0x1C0>
+- interrupt-controller : Identifies the node as an interrupt controller
+- #interrupt-cells : Specifies the number of cells needed to encode an
+  interrupt specifier.  Should be 1 - the GIC interrupt number
+- interrupt-parent - Currently only the MIPS GIC is supported, so
+<&gic> must be specified as parent
+- interrupts : in interrupt parent form. For GIC it's
+<GIC_SHARED x IRQ_TYPE_EDGE_RISING> where x is the interrupt number
+allocated for ICU in GIC.
+
+
+
+
+
+Example:
+
+	icu: interrupt-controller@1d4d0000 {
+		compatible = "sx,icu";
+		reg = <0x1D4D0000 0x1C0>;
+
+		interrupt-controller;
+		#interrupt-cells = <1>;
+
+		interrupt-parent = <&gic>;
+		interrupts = <GIC_SHARED 25 IRQ_TYPE_EDGE_RISING>;
+	};
+
+	uart0: uart@1D4D09C0 {
+		compatible = "ns16550a";
+		reg = <0x1D4D09C0 0x100>;
+
+		interrupt-parent = <&icu>;
+		interrupts = <3>;
+
+		clock-frequency = <270000000>;
+
+		reg-shift = <2>;
+		reg-io-width = <4>;
+	};
diff --git a/Documentation/devicetree/bindings/mips/satixfy/sx3000b.txt b/Documentation/devicetree/bindings/mips/satixfy/sx3000b.txt
index 0000000..7cae67b
--- /dev/null
+++ b/Documentation/devicetree/bindings/mips/satixfy/sx3000b.txt
@@ -0,0 +1,37 @@
+Satixfy SX3000b SoC
+=========================
+
+Required properties:
+--------------------
+ - compatible: Must include "satixfy,sx3000".
+
+CPU nodes:
+----------
+A "cpus" node is required.  Required properties:
+ - #address-cells: Must be 1.
+ - #size-cells: Must be 0.
+A CPU sub-node is also required for at least CPU 0.  Since the topology may
+be probed via CPS, it is not necessary to specify secondary CPUs.  Required
+properties:
+ - device_type: Must be "cpu".
+ - compatible: Must be "mti,interaptiv".
+ - reg: CPU number.
+ - clocks: Must include the CPU clock.  See ../../clock/clock-bindings.txt for
+   details on clock bindings.
+Example:
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		cpu@0 {
+			device_type = "cpu";
+			compatible = "mti,interaptiv";
+			clocks	= <&ext>;
+			reg = <0>;
+		};
+	};
+
+Interrupt controllers:
+----------------------
+Two nodes are required:
+ - mips,gic - MIPS Global Interrupt Controller - see Documentation/devicetree/bindings/interrupt-controller/mips-gic.txt
+ - satixfy,icu - SX3000b SoC Interrupt Controller Unit - see Documentation/devicetree/bindings/interrupt-controller/satixfy-icu.txt
diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index ec0bfb9..76819dd
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -261,6 +261,7 @@ rockchip	Fuzhou Rockchip Electronics Co., Ltd
 samsung	Samsung Semiconductor
 samtec	Samtec/Softing company
 sandisk	Sandisk Corporation
+satixfy Satixfy Technologies Ltd
 sbs	Smart Battery System
 schindler	Schindler
 seagate	Seagate Technology PLC

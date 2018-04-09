Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Apr 2018 02:31:42 +0200 (CEST)
Received: from mail-by2nam03on0724.outbound.protection.outlook.com ([IPv6:2a01:111:f400:fe4a::724]:10945
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23994629AbeDIAbWpnlLV convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 9 Apr 2018 02:31:22 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=l/rLWabaPQAQROmq1MQ2KxqTn4PMlR51llqq+m+5IyE=;
 b=hIXwOkiSkUknATyNI/7IDq5wyEOCgrBfmXPxsxaWG3VO0TTDaBreYaJxdZz7nwkw2CNew33iTBDTbAJoewlEKOTc4+U7JuJlfUDKn8qMXkpfVvTTit14bNJJAt0bxQChFZGx9YeU0G2Oz62VweGAhB+qn1gvGrF3vUUCIKwzjNs=
Received: from DM5PR2101MB1032.namprd21.prod.outlook.com (52.132.128.13) by
 DM5PR2101MB0917.namprd21.prod.outlook.com (52.132.132.162) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.696.0; Mon, 9 Apr 2018 00:31:12 +0000
Received: from DM5PR2101MB1032.namprd21.prod.outlook.com
 ([fe80::8109:aef0:a777:7059]) by DM5PR2101MB1032.namprd21.prod.outlook.com
 ([fe80::8109:aef0:a777:7059%2]) with mapi id 15.20.0696.003; Mon, 9 Apr 2018
 00:31:12 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 161/293] MIPS: SEAD-3: Set interrupt-parent
 per-device, not at root node
Thread-Topic: [PATCH AUTOSEL for 4.9 161/293] MIPS: SEAD-3: Set
 interrupt-parent per-device, not at root node
Thread-Index: AQHTz5kx+9Uqt6hG/0CKAEO3JYTulQ==
Date:   Mon, 9 Apr 2018 00:24:58 +0000
Message-ID: <20180409002239.163177-161-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0917;7:ZpV6Kw21u/eeDbKdrIyWL7/OWc2Rc+Q8irZEO1RpLEvaFNT5KnsduHmRZA4QoNidSufpHn6EP2kSCLAL1zIEznvOaoKutVdaknHJSLoTuVUu5faV8Jd3+Orit0gXprxfxLFhIUAOcaT7LXrTDaNiwqo/yL69/tBDaVlMwOk4xHm1PdpwbUcXiS125W5jsbpwpY1tiWnAKIPm31iuRhQaB3PlMpORE9ruMApyvzqLLoJEtBtxGkQh7HphGaf5U45v;20:GmOm4uZJUSWGShZ6KzQGpt3yqxlk97aCP7RCG81vRMJrhYr8DeG6ZiUD9BMp+TGCY8iQOerpwrM++tZF7AP8hvuzXslPFl5B+0JBGCIOs1NBlQXW1CTRscGKRlnFjaePkfJCN7i22yB/hgwnyGpMTtrHm3HMKH34DkZFoftpMFQ=
X-MS-Office365-Filtering-Correlation-Id: 0f9df1e7-f415-4109-b26a-08d59db1325d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(48565401081)(2017052603328)(7193020);SRVR:DM5PR2101MB0917;
x-ms-traffictypediagnostic: DM5PR2101MB0917:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <DM5PR2101MB0917777ADA3EDFD6DE780033FBBF0@DM5PR2101MB0917.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0917;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0917;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(39860400002)(366004)(396003)(346002)(376002)(189003)(199004)(99286004)(22452003)(106356001)(26005)(110136005)(478600001)(54906003)(10290500003)(316002)(1076002)(72206003)(186003)(4326008)(97736004)(66066001)(11346002)(25786009)(86362001)(476003)(446003)(2906002)(6666003)(6486002)(105586002)(86612001)(3280700002)(3660700001)(551934003)(6512007)(3846002)(6306002)(6116002)(6436002)(2616005)(486006)(53936002)(7736002)(8676002)(81166006)(81156014)(8936002)(68736007)(305945005)(10090500001)(76176011)(6506007)(102836004)(36756003)(107886003)(59450400001)(2900100001)(2501003)(14454004)(966005)(5660300001)(5250100002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0917;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: JSvfZX4ZgslF464ur+kpE0yMCuGjGmdRMI91vFUvdDIUTwg2ZibtXNMW1YQAkYkDRTTczd3oWAj0rFbyE7DaAC1csjmav1IkQ3uoay8s03LMZy0OcFu7gOcQxVwAXDYF7xLj4oC4HCvcixK0EbVwxRb3JZ15BH6Jz1TIkkVVw0RrtzqRBfATwg7xRoWf8FtUQm/s4TghhIn7bTICz7B16TEXlynkYFyx8ySlVF0pceY530WdBO+sEy5Oo/X/EeCgBelKJIEAxyPSWgK1flkSfbxjqPFk/zDYqRm8mpuMzS3hvkGSQX+MUZ+/QzfAJoTNlPPT+qFW59TUwa12yah1KWGoRBKF7t0ws4bxR1QMTRcdQRkFzb7q04qOO8gCFiAB2sLxh1UFfxsBG1XQul+3H0wA4P/50uQm7JltC5H8ic8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f9df1e7-f415-4109-b26a-08d59db1325d
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:24:58.8938
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0917
Return-Path: <Alexander.Levin@microsoft.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63447
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Alexander.Levin@microsoft.com
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

From: Paul Burton <paul.burton@imgtec.com>

[ Upstream commit fbdc674ba33c3791b315a546019e570e3e94e599 ]

The SEAD-3 board may be configured with or without a MIPS Global
Interrupt Controller (GIC). Because of this we have a device tree with a
default case of a GIC present, and code to fixup the device tree based
upon a configuration register that indicates the presence of the GIC.

In order to keep this DT fixup code simple, the interrupt-parent
property was specified at the root node of the SEAD-3 DT, allowing the
fixup code to simply change this property to the phandle of the CPU
interrupt controller if a GIC is not present & affect all
interrupt-using devices at once. This however causes a problem if we do
have a GIC & the device tree is used as-is, because the interrupt-parent
property of the root node applies to the CPU interrupt controller node.
This causes a cycle when of_irq_init() attempts to probe interrupt
controllers in order and boots fail due to a lack of configured
interrupts, with this message printed on the kernel console:

[    0.000000] OF: of_irq_init: children remain, but no parents

Fix this by removing the interrupt-parent property from the DT root node
& instead setting it for each device which uses interrupts, ensuring
that the CPU interrupt controller node has no interrupt-parent &
allowing of_irq_init() to identify it as the root interrupt controller.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Reported-by: Keng Koh <keng.koh@imgtec.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/16187/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/mips/boot/dts/mti/sead3.dts |  5 ++++-
 arch/mips/generic/board-sead3.c  | 26 ++++++++++++++++++++------
 2 files changed, 24 insertions(+), 7 deletions(-)

diff --git a/arch/mips/boot/dts/mti/sead3.dts b/arch/mips/boot/dts/mti/sead3.dts
index b112879a5d9d..60bc5f080454 100644
--- a/arch/mips/boot/dts/mti/sead3.dts
+++ b/arch/mips/boot/dts/mti/sead3.dts
@@ -11,7 +11,6 @@
 	#size-cells = <1>;
 	compatible = "mti,sead-3";
 	model = "MIPS SEAD-3";
-	interrupt-parent = <&gic>;
 
 	chosen {
 		stdout-path = "uart1:115200";
@@ -65,6 +64,7 @@
 		compatible = "generic-ehci";
 		reg = <0x1b200000 0x1000>;
 
+		interrupt-parent = <&gic>;
 		interrupts = <0>; /* GIC 0 or CPU 6 */
 
 		has-transaction-translator;
@@ -227,6 +227,7 @@
 
 		clock-frequency = <14745600>;
 
+		interrupt-parent = <&gic>;
 		interrupts = <3>; /* GIC 3 or CPU 4 */
 
 		no-loopback-test;
@@ -241,6 +242,7 @@
 
 		clock-frequency = <14745600>;
 
+		interrupt-parent = <&gic>;
 		interrupts = <2>; /* GIC 2 or CPU 4 */
 
 		no-loopback-test;
@@ -251,6 +253,7 @@
 		reg = <0x1f010000 0x10000>;
 		reg-io-width = <4>;
 
+		interrupt-parent = <&gic>;
 		interrupts = <0>; /* GIC 0 or CPU 6 */
 
 		phy-mode = "mii";
diff --git a/arch/mips/generic/board-sead3.c b/arch/mips/generic/board-sead3.c
index f4ae0584a33b..5e2f260ce16a 100644
--- a/arch/mips/generic/board-sead3.c
+++ b/arch/mips/generic/board-sead3.c
@@ -163,14 +163,16 @@ static __init int remove_gic(void *fdt)
 		return -EINVAL;
 	}
 
-	err = fdt_setprop_u32(fdt, 0, "interrupt-parent", cpu_phandle);
-	if (err) {
-		pr_err("unable to set root interrupt-parent: %d\n", err);
-		return err;
-	}
-
 	uart_off = fdt_node_offset_by_compatible(fdt, -1, "ns16550a");
 	while (uart_off >= 0) {
+		err = fdt_setprop_u32(fdt, uart_off, "interrupt-parent",
+				      cpu_phandle);
+		if (err) {
+			pr_warn("unable to set UART interrupt-parent: %d\n",
+				err);
+			return err;
+		}
+
 		err = fdt_setprop_u32(fdt, uart_off, "interrupts",
 				      cpu_uart_int);
 		if (err) {
@@ -193,6 +195,12 @@ static __init int remove_gic(void *fdt)
 		return eth_off;
 	}
 
+	err = fdt_setprop_u32(fdt, eth_off, "interrupt-parent", cpu_phandle);
+	if (err) {
+		pr_err("unable to set ethernet interrupt-parent: %d\n", err);
+		return err;
+	}
+
 	err = fdt_setprop_u32(fdt, eth_off, "interrupts", cpu_eth_int);
 	if (err) {
 		pr_err("unable to set ethernet interrupts property: %d\n", err);
@@ -205,6 +213,12 @@ static __init int remove_gic(void *fdt)
 		return ehci_off;
 	}
 
+	err = fdt_setprop_u32(fdt, ehci_off, "interrupt-parent", cpu_phandle);
+	if (err) {
+		pr_err("unable to set EHCI interrupt-parent: %d\n", err);
+		return err;
+	}
+
 	err = fdt_setprop_u32(fdt, ehci_off, "interrupts", cpu_ehci_int);
 	if (err) {
 		pr_err("unable to set EHCI interrupts property: %d\n", err);
-- 
2.15.1

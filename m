Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Mar 2017 17:14:06 +0100 (CET)
Received: from mx0a-00010702.pphosted.com ([148.163.156.75]:55222 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23993201AbdCNQNjwYZje (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 14 Mar 2017 17:13:39 +0100
Received: from pps.filterd (m0098781.ppops.net [127.0.0.1])
        by mx0a-00010702.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id v2EGBJBY002124;
        Tue, 14 Mar 2017 11:13:32 -0500
Received: from ni.com (skprod3.natinst.com [130.164.80.24])
        by mx0a-00010702.pphosted.com with ESMTP id 29500d1ryu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Mar 2017 11:13:31 -0500
Received: from us-aus-exhub1.ni.corp.natinst.com (us-aus-exhub1.ni.corp.natinst.com [130.164.68.41])
        by us-aus-skprod3.natinst.com (8.16.0.17/8.16.0.17) with ESMTPS id v2EGDUUL026945
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 14 Mar 2017 11:13:31 -0500
Received: from us-aus-exhub1.ni.corp.natinst.com (130.164.68.41) by
 us-aus-exhub1.ni.corp.natinst.com (130.164.68.41) with Microsoft SMTP Server
 (TLS) id 15.0.1156.6; Tue, 14 Mar 2017 11:13:31 -0500
Received: from nathan3500-linux-VM.amer.corp.natinst.com (130.164.49.7) by
 us-aus-exhub1.ni.corp.natinst.com (130.164.68.41) with Microsoft SMTP Server
 id 15.0.1156.6 via Frontend Transport; Tue, 14 Mar 2017 11:13:30 -0500
From:   Nathan Sullivan <nathan.sullivan@ni.com>
To:     <linus.walleij@linaro.org>, <gnurou@gmail.com>,
        <mark.rutland@arm.com>, <devicetree@vger.kernel.org>,
        <robh+dt@kernel.org>, <ralf@linux-mips.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <linux-mips@linux-mips.org>,
        Nathan Sullivan <nathan.sullivan@ni.com>
Subject: [PATCH 1/2] gpio: mmio: add support for NI 169445 NAND GPIO
Date:   Tue, 14 Mar 2017 11:13:22 -0500
Message-ID: <1489508003-25288-2-git-send-email-nathan.sullivan@ni.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1489508003-25288-1-git-send-email-nathan.sullivan@ni.com>
References: <1489508003-25288-1-git-send-email-nathan.sullivan@ni.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2017-03-14_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 malwarescore=0 phishscore=0 adultscore=0 bulkscore=0 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.0.1-1702020001
 definitions=main-1703140126
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2017-03-14_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=30 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 impostorscore=0 adultscore=0 classifier=spam adjust=30
 reason=mlx scancount=1 engine=8.0.1-1702020001 definitions=main-1703140126
Return-Path: <nathan.sullivan@ni.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57253
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: nathan.sullivan@ni.com
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

The GPIO-based NAND controller on National Instruments 169445 hardware
exposes a set of simple lines for the control signals.

Signed-off-by: Nathan Sullivan <nathan.sullivan@ni.com>
---
 .../bindings/gpio/ni,169445-nand-gpio.txt          | 38 ++++++++++++++++++++++
 drivers/gpio/gpio-mmio.c                           |  1 +
 2 files changed, 39 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/ni,169445-nand-gpio.txt

diff --git a/Documentation/devicetree/bindings/gpio/ni,169445-nand-gpio.txt b/Documentation/devicetree/bindings/gpio/ni,169445-nand-gpio.txt
new file mode 100644
index 0000000..ca2f8c7
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/ni,169445-nand-gpio.txt
@@ -0,0 +1,38 @@
+Bindings for the National Instruments 169445 GPIO NAND controller
+
+The 169445 GPIO NAND controller has two memory mapped GPIO registers, one
+for input (the ready signal) and one for output (control signals).  It is
+intended to be used with the GPIO NAND driver.
+
+Required properties:
+	- compatible: should be "ni,169445-nand-gpio"
+	- reg-names: must contain
+		"dat" - data register
+	- reg: address + size pairs describing the GPIO register sets;
+		order must correspond with the order of entries in reg-names
+	- #gpio-cells: must be set to 2. The first cell is the pin number and
+			the second cell is used to specify the gpio polarity:
+			0 = active high
+			1 = active low
+	- gpio-controller: Marks the device node as a gpio controller.
+
+Optional properties:
+	- no-output: disables driving output on the pins
+
+Examples:
+	gpio1: nand-gpio-out@1f300010 {
+		compatible = "ni,169445-nand-gpio";
+		reg = <0x1f300010 0x4>;
+		reg-names = "dat";
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
+	gpio2: nand-gpio-in@1f300014 {
+		compatible = "ni,169445-nand-gpio";
+		reg = <0x1f300014 0x4>;
+		reg-names = "dat";
+		gpio-controller;
+		#gpio-cells = <2>;
+		no-output;
+	};
diff --git a/drivers/gpio/gpio-mmio.c b/drivers/gpio/gpio-mmio.c
index d7d03ad..f7da40e 100644
--- a/drivers/gpio/gpio-mmio.c
+++ b/drivers/gpio/gpio-mmio.c
@@ -575,6 +575,7 @@ static void __iomem *bgpio_map(struct platform_device *pdev,
 static const struct of_device_id bgpio_of_match[] = {
 	{ .compatible = "brcm,bcm6345-gpio" },
 	{ .compatible = "wd,mbl-gpio" },
+	{ .compatible = "ni,169445-nand-gpio" },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, bgpio_of_match);
-- 
2.1.4

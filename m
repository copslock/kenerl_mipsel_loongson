Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 02 Dec 2017 00:22:11 +0100 (CET)
Received: from mail-by2nam03on0058.outbound.protection.outlook.com ([104.47.42.58]:52096
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23994627AbdLAXTCG4Nvs (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 2 Dec 2017 00:19:02 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=8eNjE8Xdx5Za8tclWaHv9A7seJeti1iMrk97KCkNxCs=;
 b=ZTBldqCU1SgEQwdj4hDPsKU0GN3o6uyQ5slzgG0PTMsTyJuVeBtIXTL5C9SWd6jqOIVgggXVeaSxdiSsKWXtWaUG3YCZlqPOIY1guBlEeg8Oog8nrRcvxBTf724yNsb4pUdT1nPhBYl+DYZ/9NC6p4tPI0Q1DUbDZiFc+z2/4Vs=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=David.Daney@cavium.com; 
Received: from ddl.caveonetworks.com (50.233.148.156) by
 DM5PR07MB3499.namprd07.prod.outlook.com (10.164.153.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.260.4; Fri, 1 Dec 2017 23:18:51 +0000
From:   David Daney <david.daney@cavium.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        James Hogan <james.hogan@mips.com>, netdev@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org,
        "Steven J. Hill" <steven.hill@cavium.com>,
        devicetree@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Carlos Munoz <cmunoz@cavium.com>,
        "Steven J . Hill" <Steven.Hill@cavium.com>,
        David Daney <david.daney@cavium.com>
Subject: [PATCH v5 net-next,mips 6/7] netdev: octeon-ethernet: Add Cavium Octeon III support.
Date:   Fri,  1 Dec 2017 15:18:06 -0800
Message-Id: <20171201231807.25266-7-david.daney@cavium.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20171201231807.25266-1-david.daney@cavium.com>
References: <20171201231807.25266-1-david.daney@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: CO2PR07CA0064.namprd07.prod.outlook.com (10.174.192.32) To
 DM5PR07MB3499.namprd07.prod.outlook.com (10.164.153.30)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 31d6ddd4-2e05-4d7e-59c7-08d53911e603
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(4534020)(4602075)(4627115)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603286);SRVR:DM5PR07MB3499;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3499;3:7oRESTEJiKB0/6fHOb1MZPN7UcGclONpBZJ8nuR58X+1F5BnhrX7SNvYg//GvkVJASpyjWVuJMPnXx41nhZK8kxZm3W53Vwqfvq97xuupDHb7miwI6hv958rxkAoBhZAggm3TMvrr7rVPAphOhzRVNwWUai2W1zuaA8urTL+b0VVbLhCmU4IGR2kqCSC49oIB0pqX6slGS5c003JVNNbqLoi4D4vlSTx6ZmwD4fd+WBg56dR4prodUtV5J/20voj;25:zw+jhbUszn0Web2gKusbY6UvOBcFfqO+jcvmJ7SsdnCStjroPDpB1gsINeb3a+SC1CBJjGEcbc/6w0IKIuRNk5eaXEITt61lIVKPsUOpeBS51lXS+txl+oa6kPZ5q7XADP+zag6zob65pmNW1F+D59rjpmc5I8KMSNzpN2ZxuEfHLegstMdO0kUUN+pBPp7g3ScVbtLgm47N4edYC21Lhlql7HQrjqxkj520HVAFtc/TDCM12Z8t0S3uStdtDz9A24i9klQ9kbztFfq2uhVlKIpM4juQ3sKHGqai8sH7fXfLKJ21R/tm0RdWhYYam7yqPg3+4xOr/7r27Q37Tomhow==;31:Md88bcdifOsAsZgyCEo+znlpWxk1Uqa0WJ+wDfmMlpJSuY7iiXhLnJk52/machHEvhcc9KwLt/vVJySVkE6m0cXxSpQhy9vutD8siZWcLVX4vnOGoOs0xnjoCD5ZqmgJGtiiObC3Ex4aBP3jGydemSLrsZe7KUVgy6GUaBhUAv7HVJWlzUzZWsIDCDRc1m6jtuMXlIPBxxm1fnu1D2QYPv3JdYdgJHcIoaQjRT8kFA8=
X-MS-TrafficTypeDiagnostic: DM5PR07MB3499:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3499;20:c3zFuzUHP8XGfe54+43XlMlpVO+VOfvUKkhl9rTLe8rvBSjn/c0Suo7guWXDMWVeJfRpA6irpbitbjfKHqNI9PMVhTuLWrwJRkHaoWLA4hK34pat4SJwIwDFIww2ldTSdKNR+V/OxMjBVIcPbQg1Dg+/b3hvpxAT6xiGrLXx3SedhhBwUqhOQAPJdQIgPX1i7G2qxN7khWH/bmST/uE9ul5AgK8qW8/toosKJBV8HlHNlqz9UKKGlTYJI9+x3BpZyvuvHJ+LdLWNkFeRb4MQdHKH9Ff3h9j7JJav1XtIugKmsBmlvMZTg2yOLLVagv+J4m9rrcG/xZW6tnyOT+d63JXPPmr/bfFpYs7VFgC6tEjQys43qpDkEzQw4TTgYVCxd1PIbeK9QU9Eya2FBRlFOB8kupBsR7hfbljKE+TTWgwoIxNTxs5bPo9lHxkoUdfd6uXFY0FyyYjyExEF+58RY9PfVIy9vEsb49Tb7NOstl89l6KticzpCu6SfQ45cUF6;4:1hSkYE9bZyYixF/TTNjirESzU8TrbM2tlZsNUtMrZP4u+jJ3gEy7YKkQE/eynRvqJqBeehztXebLLXoOTckGPu+lsI+E2n9NOQbRDyXaL/Gcr7Bq49Dkjr+3Jfdsk4yUdVcWSZz5lIaGHMg/5uxAMRgsSNYSR5khZRodovRe5MYWy5RF7zxJoeOdzHi/nFNYOmS8sieiruHbsshVw+izY7VbkHRWhrS0mUvs3Pum3qb36B9o+7hVO2p+YDRGGZWIgMTu6hGwOv7TAsIO+IWql5Cu1GGfn4nPheE/QwRLyNmZyNnfn6pGVGPU9bjZEz7h6740G063nUu8TL1gU5UdisUOF6vIu7/4AdBk7wIZCuCgsYq949HZRlekPb6V7w0HzhmOKnTWcB8tRFhRRu/EQPrhov6DSqp1j61yakimkAw=
X-Microsoft-Antispam-PRVS: <DM5PR07MB3499FA5F9D03775CAC4005AA97390@DM5PR07MB3499.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(158342451672863)(131327999870524)(21532816269658)(17755550239193);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040450)(2401047)(8121501046)(5005006)(3231022)(93006095)(93001095)(10201501046)(3002001)(6041248)(20161123564025)(20161123555025)(20161123560025)(20161123558100)(20161123562025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR07MB3499;BCL:0;PCL:0;RULEID:(100000803101)(100110400095);SRVR:DM5PR07MB3499;
X-Forefront-PRVS: 05087F0C24
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6009001)(346002)(376002)(366004)(189002)(51234002)(199003)(551984002)(47776003)(72206003)(1076002)(7416002)(50466002)(5890100001)(4326008)(66066001)(16526018)(48376002)(33646002)(6666003)(76176011)(97736004)(86362001)(68736007)(25786009)(39060400002)(2950100002)(101416001)(478600001)(53416004)(6506006)(106356001)(5660300001)(3846002)(105586002)(36756003)(69596002)(8676002)(6512007)(2906002)(51416003)(53936002)(81156014)(110136005)(6116002)(81166006)(8936002)(7736002)(16200700003)(52116002)(16586007)(316002)(107886003)(189998001)(6486002)(305945005)(53946003)(50226002)(575784001)(54906003)(142933001)(559001)(569006);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR07MB3499;H:ddl.caveonetworks.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR07MB3499;23:XnEumuhytmhGJz1fKdKcaesn1Qfr58gQeRt7oDxhN?=
 =?us-ascii?Q?HixUbW4E4cq+PYEVQeKo/DtkdyO4anbjOH6hrC2hY+c5CG0wIaNe7wO8XaUB?=
 =?us-ascii?Q?+yq+IDTmBvIKJj7P9jnkOYzp4cXnp+/Bv0CBCJAN7SVcu0j1ysHwhnRLBTOP?=
 =?us-ascii?Q?NoW7BdgMn1tqUbXE4PtkacAnzjr80SgWGSZ49FcBXcYnXEh55okaSwtA+Gx3?=
 =?us-ascii?Q?UxCeC86/H1/6FiW91BpgwElaMUFPCmAEnIGzfOSTE91do56nzIs63jvz8GsN?=
 =?us-ascii?Q?R4/BTjtdA6w1MivdWsMySXafORHm2S8iVezE2OtLCoBNlNn/B4v27C31mdNt?=
 =?us-ascii?Q?bjaMgqY+N0NvGJ+0u1F+FQASYvmmuElzDuHDv0nG0medQJm7txBd5HcUCTRx?=
 =?us-ascii?Q?kT31T0eNcI1TGn5SSXgyNUhOBoVuh3zblR/YmJRFLq+45e00P85hKGBh6CFR?=
 =?us-ascii?Q?UG+kuDXlYDaMsixmbcPDGcfFmz+Pk86/O0aaDz552YLAJ187OYAVdSw/X6Fg?=
 =?us-ascii?Q?EpQRl14RV4Qbo5AZ9W0FtYxoblROJWgL18p7kJgvTvcSpDEsvL7zGZqn/ahx?=
 =?us-ascii?Q?5n/sP/k6T9udFhHYrmrDMjap1ToY1rxjJHQF2Kpi1GHVBwBhn5uilSsnxpCs?=
 =?us-ascii?Q?2xlfsb7DEqvKXiMgMEKrrTFqTA45EEvVDWgssF50kG8ch7NW4q5Vc3Y0JBQh?=
 =?us-ascii?Q?RrMdZZafLizTw+XX45uuywxDpIz8ZDPkFLcqzAUCMYr2L9n+m0J075vT/3MK?=
 =?us-ascii?Q?SEeQghfUhq8iLoNgGRcUsxDY8FHVWudhIh1tfJ+1NfasiktVLDGngjnOjpmI?=
 =?us-ascii?Q?w+aDCYUnEhKqsH/I3Yvja2R/cRA8ltnbIFeFEV/OAMzIuzNkQjSkA3tlNKm5?=
 =?us-ascii?Q?mrSZP3YzTmFYvvpslakAiLoa0YfBWo+sp5z8l0sDRIV7Kqn71yclKOZYo7FW?=
 =?us-ascii?Q?w86CtxZfaC3fCUBpl0k9/59CHUsp7LwdCcFjBSot5o1IBgKazfSEooDDLA9e?=
 =?us-ascii?Q?fYwWaz5I6a4XpElL/L4xWqhuA84fD1+gtiDX+sWKa5Igc3iTDRxoGrcIaCmd?=
 =?us-ascii?Q?SWYZ1NjlcsSNUDGN5oFcvooUYSDpQ5F/3yBtLnie98VkBS7kLaoMoo40CyON?=
 =?us-ascii?Q?FP4/9fz9mFEyPKG+52ABSsp6gknit6gLSdi2vHAAXOcbE1Bfz70OEPchqsZ+?=
 =?us-ascii?Q?g2RBktoLJWvTKKIMCokk6lD4vXPWOyp/R2KUNI6YxIfCYd11BquKG/sjzojt?=
 =?us-ascii?Q?a3PFSfdutkpgH6W5pFCbv81mwgSHSXjQxTYCcV6CM0oXNMb++0ELErOwVqpY?=
 =?us-ascii?Q?rAhn+MOpV4dmuSOjBcgiII6bPvicnksdNRTnD4w1g/kmku778/OxqkJRQSRO?=
 =?us-ascii?Q?EMLPh6cQa+UyxswWf5fwxIjkWqVwJAmNqpILCTEw6oS8jUosBlLv/wUX+rUR?=
 =?us-ascii?Q?raJM5gEkZlI4vNb4I/dMn7ONoXmsww=3D?=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3499;6:EeIALMaK51oN1MiAOPKTTVKJ8eYX+CJ3qJGX35TiJgyUX7EripnTvOOSPyY23yWed0mfnbyD2cRCnr04DxWEl6SBojNnOmi1tNHsBURQT2TlolN+ayvEdTw0bnz9L7trFKUUoA/nMjmFh94wMP25XdMfvSkZulmf986PZjrhhdPEaPT6judZ1fQuYjNsygEKgDUAmdzl+NkvHZ0eDZJkSVdOkU5sFJR6K9aLqrjwaGdjhlR2fcIBc58Tm7L6FbqvJpDh/eazcevTIlRlEsVjgrMJhPxWeVDPrfsqvFiMNJI3I7u0NtmIgy62/u1QR+FGNLeZ6BxueFRUdr5iYTx7v/+s3tf8AxGEx3FaYn4eFBw=;5:yU3pDgNY4adSVuCQQKTG+BlDWXdsEwqisFrnJAuEbyb0Vi6GIDYAlprM/WWL5mm3P4UW6IyFHor8M7HUPUKdEyhCclASD8PGIpB5tQ98nI3VVcRNT3VaVvg0pZKd52c7hbJ2Iib4wZAV6NoSVBs+furtbIasdII0dTZLz82GTh4=;24:hA1WkBieaynBHRDbpvhAqlpou5alvZ5bTCh4bCVANomY0Bvn+quaXh4QOO/LkDCdmiJNDveZOpPdpXYlTxXSsIyBetbXBHS2HyqCazT2dY0=;7:9DlAw6qlbK1bT3jy+kzdwz7mZbxYXyKMdFahOIs3zo6h7EN/KQd2PJq+KVGi3XrczujwI7vLf1+DxfQAeAOd5uq4cHfMYG1VLPvUdeG53FsaeaQ55IKvXKMSJi1Wr8L6IB0drxd0Ahe+u+IdVNGat2IwO+Czlil5rZdIewFftvpaxJC+0pTSFbwXDYKhcnEchRb94HdlJYB7qWZPripg9SxiAvPhuNC1r5hJlWNswaEMkryb1d9190uYPldWQCK/
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2017 23:18:51.4780 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 31d6ddd4-2e05-4d7e-59c7-08d53911e603
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR07MB3499
Return-Path: <David.Daney@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61276
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: david.daney@cavium.com
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

From: Carlos Munoz <cmunoz@cavium.com>

The Cavium OCTEON cn78xx and cn73xx SoCs have network packet I/O
hardware that is significantly different from previous generations of
the family.

Add a new driver for this hardware.  The Ethernet MAC is called BGX on
these devices.  Common code for the MAC is in octeon3-bgx-port.c.
Four of these BGX MACs are grouped together and managed as a group by
octeon3-bgx-nexus.c.  Ingress packet classification is done by the PKI
unit initialized in octeon3-pki.c.  Queue management is done in the
SSO, initialized by octeon3-sso.c.  Egress is handled by the PKO,
initialized in octeon3-pko.c.

Signed-off-by: Carlos Munoz <cmunoz@cavium.com>
Signed-off-by: Steven J. Hill <Steven.Hill@cavium.com>
Signed-off-by: David Daney <david.daney@cavium.com>
---
 drivers/net/ethernet/cavium/Kconfig                |   55 +-
 drivers/net/ethernet/cavium/octeon/Makefile        |    6 +
 .../net/ethernet/cavium/octeon/octeon3-bgx-nexus.c |  701 +++++++
 .../net/ethernet/cavium/octeon/octeon3-bgx-port.c  | 2015 +++++++++++++++++++
 drivers/net/ethernet/cavium/octeon/octeon3-core.c  | 2069 ++++++++++++++++++++
 drivers/net/ethernet/cavium/octeon/octeon3-pki.c   |  824 ++++++++
 drivers/net/ethernet/cavium/octeon/octeon3-pko.c   | 1688 ++++++++++++++++
 drivers/net/ethernet/cavium/octeon/octeon3-sso.c   |  301 +++
 drivers/net/ethernet/cavium/octeon/octeon3.h       |  418 ++++
 9 files changed, 8067 insertions(+), 10 deletions(-)
 create mode 100644 drivers/net/ethernet/cavium/octeon/octeon3-bgx-nexus.c
 create mode 100644 drivers/net/ethernet/cavium/octeon/octeon3-bgx-port.c
 create mode 100644 drivers/net/ethernet/cavium/octeon/octeon3-core.c
 create mode 100644 drivers/net/ethernet/cavium/octeon/octeon3-pki.c
 create mode 100644 drivers/net/ethernet/cavium/octeon/octeon3-pko.c
 create mode 100644 drivers/net/ethernet/cavium/octeon/octeon3-sso.c
 create mode 100644 drivers/net/ethernet/cavium/octeon/octeon3.h

diff --git a/drivers/net/ethernet/cavium/Kconfig b/drivers/net/ethernet/cavium/Kconfig
index 63be75eb34d2..decce5178a27 100644
--- a/drivers/net/ethernet/cavium/Kconfig
+++ b/drivers/net/ethernet/cavium/Kconfig
@@ -4,7 +4,7 @@
 
 config NET_VENDOR_CAVIUM
 	bool "Cavium ethernet drivers"
-	depends on PCI
+	depends on PCI || CAVIUM_OCTEON_SOC
 	default y
 	---help---
 	  Select this option if you want enable Cavium network support.
@@ -13,6 +13,12 @@ config NET_VENDOR_CAVIUM
 
 if NET_VENDOR_CAVIUM
 
+#
+# The Thunder* and LiquidIO drivers require PCI.
+#
+
+if PCI
+
 config THUNDER_NIC_PF
 	tristate "Thunder Physical function driver"
 	depends on 64BIT
@@ -64,6 +70,20 @@ config LIQUIDIO
 	  To compile this driver as a module, choose M here: the module
 	  will be called liquidio.  This is recommended.
 
+config LIQUIDIO_VF
+	tristate "Cavium LiquidIO VF support"
+	depends on 64BIT && PCI_MSI
+	imply PTP_1588_CLOCK
+	---help---
+	  This driver supports Cavium LiquidIO Intelligent Server Adapter
+	  based on CN23XX chips.
+
+	  To compile this driver as a module, choose M here: The module
+	  will be called liquidio_vf. MSI-X interrupt support is required
+	  for this driver to work correctly
+
+endif # PCI
+
 config OCTEON_MGMT_ETHERNET
 	tristate "Octeon Management port ethernet driver (CN5XXX, CN6XXX)"
 	depends on CAVIUM_OCTEON_SOC
@@ -75,16 +95,31 @@ config OCTEON_MGMT_ETHERNET
 	  port on Cavium Networks' Octeon CN57XX, CN56XX, CN55XX,
 	  CN54XX, CN52XX, and CN6XXX chips.
 
-config LIQUIDIO_VF
-	tristate "Cavium LiquidIO VF support"
-	depends on 64BIT && PCI_MSI
-	imply PTP_1588_CLOCK
+config OCTEON3_BGX_NEXUS
+	tristate
+	depends on CAVIUM_OCTEON_SOC
+
+config OCTEON3_BGX_PORT
+	tristate "Cavium OCTEON-III BGX port support"
+	depends on CAVIUM_OCTEON_SOC
+	select OCTEON3_BGX_NEXUS
 	---help---
-	  This driver supports Cavium LiquidIO Intelligent Server Adapter
-	  based on CN23XX chips.
+	  Enable the driver for Cavium Octeon III BGX ports. BGX ports
+	  support sgmii, rgmii, xaui, rxaui, xlaui, xfi, 10KR and 40KR modes.
 
-	  To compile this driver as a module, choose M here: The module
-	  will be called liquidio_vf. MSI-X interrupt support is required
-	  for this driver to work correctly
+	  Say Y for support of any Octeon III SoC Ethernet port.
+
+config OCTEON3_ETHERNET
+	tristate "Cavium OCTEON-III PKI/PKO Ethernet support"
+	depends on CAVIUM_OCTEON_SOC
+	select OCTEON_BGX_PORT
+	select OCTEON_FPA3
+	select FW_LOADER
+	---help---
+	  Enable the driver for Cavium Octeon III Ethernet via PKI/PKO
+	  units.  No support for cn70xx chips (use OCTEON_ETHERNET for
+	  cn70xx).
+
+	  Say Y for support of any Octeon III SoC Ethernet port.
 
 endif # NET_VENDOR_CAVIUM
diff --git a/drivers/net/ethernet/cavium/octeon/Makefile b/drivers/net/ethernet/cavium/octeon/Makefile
index efa41c1d91c5..1eacab1d8dad 100644
--- a/drivers/net/ethernet/cavium/octeon/Makefile
+++ b/drivers/net/ethernet/cavium/octeon/Makefile
@@ -3,3 +3,9 @@
 #
 
 obj-$(CONFIG_OCTEON_MGMT_ETHERNET)	+= octeon_mgmt.o
+obj-$(CONFIG_OCTEON3_BGX_PORT)		+= octeon3-bgx-port.o
+obj-$(CONFIG_OCTEON3_BGX_NEXUS)		+= octeon3-bgx-nexus.o
+obj-$(CONFIG_OCTEON3_ETHERNET)		+= octeon3-ethernet.o
+
+octeon3-ethernet-objs += octeon3-core.o octeon3-pki.o octeon3-sso.o \
+			 octeon3-pko.o
diff --git a/drivers/net/ethernet/cavium/octeon/octeon3-bgx-nexus.c b/drivers/net/ethernet/cavium/octeon/octeon3-bgx-nexus.c
new file mode 100644
index 000000000000..5477056147a0
--- /dev/null
+++ b/drivers/net/ethernet/cavium/octeon/octeon3-bgx-nexus.c
@@ -0,0 +1,701 @@
+// SPDX-License-Identifier: GPL-2.0
+/* The BGX nexus consists of a group of up to four Ethernet MACs (the
+ * LMACs).  This driver manages the LMACs and creates a child device
+ * for each of the configured LMACs.
+ *
+ * Copyright (c) 2017 Cavium, Inc.
+ */
+#include <linux/platform_device.h>
+#include <linux/of_platform.h>
+#include <linux/of_address.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/list.h>
+#include <linux/ctype.h>
+
+#include "octeon3.h"
+
+static atomic_t request_mgmt_once;
+static atomic_t load_driver_once;
+static atomic_t pki_id;
+
+static char *mix_port;
+module_param(mix_port, charp, 0444);
+MODULE_PARM_DESC(mix_port, "Specifies which ports connect to MIX interfaces.");
+
+static char *pki_port;
+module_param(pki_port, charp, 0444);
+MODULE_PARM_DESC(pki_port, "Specifies which ports connect to the PKI.");
+
+#define MAX_MIX_PER_NODE	2
+
+#define MAX_MIX			(MAX_NODES * MAX_MIX_PER_NODE)
+
+/**
+ * struct mix_port_lmac - Describes a lmac that connects to a mix
+ *			  port. The lmac must be on the same node as
+ *			  the mix.
+ * @node:	Node of the lmac.
+ * @bgx:	Bgx of the lmac.
+ * @lmac:	Lmac index.
+ */
+struct mix_port_lmac {
+	int	node;
+	int	bgx;
+	int	lmac;
+};
+
+/* mix_ports_lmacs contains all the lmacs connected to mix ports */
+static struct mix_port_lmac mix_port_lmacs[MAX_MIX];
+
+/* pki_ports keeps track of the lmacs connected to the pki */
+static bool pki_ports[MAX_NODES][MAX_BGX_PER_NODE][MAX_LMAC_PER_BGX];
+
+/* Created platform devices get added to this list */
+static struct list_head pdev_list;
+static struct mutex pdev_list_lock;
+
+/* Created platform device use this structure to add themselves to the list */
+struct pdev_list_item {
+	struct list_head	list;
+	struct platform_device	*pdev;
+};
+
+/**
+ * is_lmac_to_mix() - Search the list of lmacs connected to mix'es for a match.
+ * @node: Numa node of lmac to search for.
+ * @bgx: Bgx of lmac to search for.
+ * @lmac: Lmac index to search for.
+ *
+ * Returns true if the lmac is connected to a mix.
+ * Returns false if the lmac is not connected to a mix.
+ */
+static bool is_lmac_to_mix(int node, int bgx, int lmac)
+{
+	int	i;
+
+	for (i = 0; i < MAX_MIX; i++) {
+		if (mix_port_lmacs[i].node == node &&
+		    mix_port_lmacs[i].bgx == bgx &&
+		    mix_port_lmacs[i].lmac == lmac)
+			return true;
+	}
+
+	return false;
+}
+
+/**
+ * is_lmac_to_pki() - Search the list of lmacs connected to the pki for a match.
+ * @node: Numa node of lmac to search for.
+ * @bgx: Bgx of lmac to search for.
+ * @lmac: Lmac index to search for.
+ *
+ * Returns true if the lmac is connected to the pki.
+ * Returns false if the lmac is not connected to the pki.
+ */
+static bool is_lmac_to_pki(int node, int bgx, int lmac)
+{
+	return pki_ports[node][bgx][lmac];
+}
+
+/**
+ * is_lmac_to_xcv() - Check if this lmac is connected to the xcv block (rgmii).
+ * @of_node: Device node to check.
+ *
+ * Returns true if the lmac is connected to the xcv port.
+ * Returns false if the lmac is not connected to the xcv port.
+ */
+static bool is_lmac_to_xcv(struct device_node *of_node)
+{
+	return of_device_is_compatible(of_node, "cavium,octeon-7360-xcv");
+}
+
+static int bgx_probe(struct platform_device *pdev)
+{
+	struct mac_platform_data platform_data;
+	const __be32 *reg;
+	u32 port;
+	u64 addr;
+	struct device_node *child;
+	struct platform_device *new_dev;
+	struct platform_device *pki_dev;
+	int numa_node, interface;
+	int i;
+	int r = 0;
+	char id[64];
+	u64 data;
+
+	reg = of_get_property(pdev->dev.of_node, "reg", NULL);
+	addr = of_translate_address(pdev->dev.of_node, reg);
+	interface = bgx_addr_to_interface(addr);
+	numa_node = bgx_node_to_numa_node(pdev->dev.of_node);
+
+	/* Assign 8 CAM entries per LMAC */
+	for (i = 0; i < 32; i++) {
+		data = i >> 3;
+		oct_csr_write(data, BGX_CMR_RX_ADRX_CAM(numa_node, interface, i));
+	}
+
+	for_each_available_child_of_node(pdev->dev.of_node, child) {
+		bool is_mix = false;
+		bool is_pki = false;
+		bool is_xcv = false;
+		struct pdev_list_item *pdev_item;
+
+		if (!of_device_is_compatible(child, "cavium,octeon-7890-bgx-port") &&
+		    !of_device_is_compatible(child, "cavium,octeon-7360-xcv"))
+			continue;
+		r = of_property_read_u32(child, "reg", &port);
+		if (r)
+			return -ENODEV;
+
+		is_mix = is_lmac_to_mix(numa_node, interface, port);
+		is_pki = is_lmac_to_pki(numa_node, interface, port);
+		is_xcv = is_lmac_to_xcv(child);
+
+		/* Check if this port should be configured */
+		if (!is_mix && !is_pki)
+			continue;
+
+		/* Connect to PKI/PKO */
+		data = oct_csr_read(BGX_CMR_CONFIG(numa_node, interface, port));
+		if (is_mix)
+			data |= BIT(11);
+		else
+			data &= ~BIT(11);
+		oct_csr_write(data, BGX_CMR_CONFIG(numa_node, interface, port));
+
+		/* Unreset the mix bgx interface or it will interfare with the
+		 * other ports.
+		 */
+		if (is_mix) {
+			data = oct_csr_read(BGX_CMR_GLOBAL_CONFIG(numa_node, interface));
+			if (!port)
+				data &= ~BIT(3);
+			else if (port == 1)
+				data &= ~BIT(4);
+			oct_csr_write(data, BGX_CMR_GLOBAL_CONFIG(numa_node, interface));
+		}
+
+		snprintf(id, sizeof(id), "%llx.%u.ethernet-mac",
+			 (unsigned long long)addr, port);
+		new_dev = of_platform_device_create(child, id, &pdev->dev);
+		if (!new_dev) {
+			dev_err(&pdev->dev, "Error creating %s\n", id);
+			continue;
+		}
+		platform_data.mac_type = BGX_MAC;
+		platform_data.numa_node = numa_node;
+		platform_data.interface = interface;
+		platform_data.port = port;
+		if (is_xcv)
+			platform_data.src_type = XCV;
+		else
+			platform_data.src_type = QLM;
+
+		/* Add device to the list of created devices so we can remove it
+		 * on exit.
+		 */
+		pdev_item = kmalloc(sizeof(*pdev_item), GFP_KERNEL);
+		pdev_item->pdev = new_dev;
+		mutex_lock(&pdev_list_lock);
+		list_add(&pdev_item->list, &pdev_list);
+		mutex_unlock(&pdev_list_lock);
+
+		i = atomic_inc_return(&pki_id);
+		pki_dev = platform_device_register_data(&new_dev->dev,
+							is_mix ? "octeon_mgmt" : "ethernet-mac-pki",
+							i, &platform_data,
+							sizeof(platform_data));
+		dev_info(&pdev->dev, "Created %s %u\n",
+			 is_mix ? "MIX" : "PKI", pki_dev->id);
+
+		/* Add device to the list of created devices so we can
+		 * remove it on exit.
+		 */
+		pdev_item = kmalloc(sizeof(*pdev_item), GFP_KERNEL);
+		pdev_item->pdev = pki_dev;
+		mutex_lock(&pdev_list_lock);
+		list_add(&pdev_item->list, &pdev_list);
+		mutex_unlock(&pdev_list_lock);
+
+#ifdef CONFIG_NUMA
+		new_dev->dev.numa_node = pdev->dev.numa_node;
+		pki_dev->dev.numa_node = pdev->dev.numa_node;
+#endif
+		/* One time request driver module */
+		if (is_mix) {
+			if (atomic_cmpxchg(&request_mgmt_once, 0, 1) == 0)
+				request_module_nowait("octeon_mgmt");
+		}
+		if (is_pki) {
+			if (atomic_cmpxchg(&load_driver_once, 0, 1) == 0)
+				request_module_nowait("octeon3-ethernet");
+		}
+	}
+
+	dev_info(&pdev->dev, "Probed\n");
+	return 0;
+}
+
+/**
+ * bgx_mix_init_from_fdt() - Initialize the list of lmacs that connect to mix
+ *			     ports from information in the device tree.
+ *
+ * Returns 0 if successful.
+ * Returns < 0 for error codes.
+ */
+static int bgx_mix_init_from_fdt(void)
+{
+	struct device_node	*node;
+	struct device_node	*parent = NULL;
+	int			mix = 0;
+
+	for_each_compatible_node(node, NULL, "cavium,octeon-7890-mix") {
+		struct device_node	*lmac_fdt_node;
+		const __be32		*reg;
+		u64			addr;
+		u32			t;
+
+		/* Get the fdt node of the lmac connected to this mix */
+		lmac_fdt_node = of_parse_phandle(node, "cavium,mac-handle", 0);
+		if (!lmac_fdt_node)
+			goto err;
+
+		/* Get the numa node and bgx of the lmac */
+		parent = of_get_parent(lmac_fdt_node);
+		if (!parent)
+			goto err;
+		reg = of_get_property(parent, "reg", NULL);
+		if (!reg)
+			goto err;
+		addr = of_translate_address(parent, reg);
+		of_node_put(parent);
+		parent = NULL;
+
+		mix_port_lmacs[mix].node = bgx_node_to_numa_node(parent);
+		mix_port_lmacs[mix].bgx = bgx_addr_to_interface(addr);
+
+		/* Get the lmac index */
+		if (!of_property_read_u32(lmac_fdt_node, "reg", &t))
+			goto err;
+
+		mix_port_lmacs[mix].lmac = t;
+
+		mix++;
+		if (mix >= MAX_MIX)
+			break;
+	}
+
+	return 0;
+ err:
+	pr_warn("Invalid device tree mix port information\n");
+	for (mix = 0; mix < MAX_MIX; mix++) {
+		mix_port_lmacs[mix].node = -1;
+		mix_port_lmacs[mix].bgx = -1;
+		mix_port_lmacs[mix].lmac = -1;
+	}
+	if (parent)
+		of_node_put(parent);
+
+	return -EINVAL;
+}
+
+/**
+ * bgx_mix_init_from_param() - Initialize the list of lmacs that connect to mix
+ *			     ports from information in the "mix_port" parameter.
+ *			     The mix_port parameter format is as follows:
+ *			     mix_port=nbl
+ *			     where:
+ *				n = node
+ *				b = bgx
+ *				l = lmac
+ *			     There can be up to 4 lmacs defined separated by
+ *			     commas. For example to select node0, bgx0, lmac0
+ *			     and node0, bgx4, lamc0, the mix_port parameter
+ *			     would be: mix_port=000,040
+ *
+ * Returns 0 if successful.
+ * Returns < 0 for error codes.
+ */
+static int bgx_mix_init_from_param(void)
+{
+	char	*p = mix_port;
+	int	mix = 0;
+	int	i;
+
+	while (*p) {
+		int	node = -1;
+		int	bgx = -1;
+		int	lmac = -1;
+
+		if (strlen(p) < 3)
+			goto err;
+
+		/* Get the numa node */
+		if (!isdigit(*p))
+			goto err;
+		node = *p - '0';
+		if (node >= MAX_NODES)
+			goto err;
+
+		/* Get the bgx */
+		p++;
+		if (!isdigit(*p))
+			goto err;
+		bgx = *p - '0';
+		if (bgx >= MAX_BGX_PER_NODE)
+			goto err;
+
+		/* Get the lmac index */
+		p++;
+		if (!isdigit(*p))
+			goto err;
+		lmac = *p - '0';
+		if (lmac >= 2)
+			goto err;
+
+		/* Only one lmac0 and one lmac1 per node is supported */
+		for (i = 0; i < MAX_MIX; i++) {
+			if (mix_port_lmacs[i].node == node &&
+			    mix_port_lmacs[i].lmac == lmac)
+				goto err;
+		}
+
+		mix_port_lmacs[mix].node = node;
+		mix_port_lmacs[mix].bgx = bgx;
+		mix_port_lmacs[mix].lmac = lmac;
+
+		p++;
+		if (*p == ',')
+			p++;
+
+		mix++;
+		if (mix >= MAX_MIX)
+			break;
+	}
+
+	return 0;
+ err:
+	pr_warn("Invalid parameter mix_port=%s\n", mix_port);
+	for (mix = 0; mix < MAX_MIX; mix++) {
+		mix_port_lmacs[mix].node = -1;
+		mix_port_lmacs[mix].bgx = -1;
+		mix_port_lmacs[mix].lmac = -1;
+	}
+	return -EINVAL;
+}
+
+/**
+ * bgx_mix_port_lmacs_init() - Initialize the mix_port_lmacs variable with the
+ *			       lmacs that connect to mic ports.
+ *
+ * Returns 0 if successful.
+ * Returns < 0 for error codes.
+ */
+static int bgx_mix_port_lmacs_init(void)
+{
+	int	mix;
+
+	/* Start with no mix ports configured */
+	for (mix = 0; mix < MAX_MIX; mix++) {
+		mix_port_lmacs[mix].node = -1;
+		mix_port_lmacs[mix].bgx = -1;
+		mix_port_lmacs[mix].lmac = -1;
+	}
+
+	/* Check if no mix port should be configured */
+	if (mix_port && !strcmp(mix_port, "none"))
+		return 0;
+
+	/* Configure the mix ports using information from the device tree if no
+	 * parameter was passed. Otherwise, use the information in the module
+	 * parameter.
+	 */
+	if (!mix_port)
+		bgx_mix_init_from_fdt();
+	else
+		bgx_mix_init_from_param();
+
+	return 0;
+}
+
+/**
+ * bgx_parse_pki_elem() - Parse a single element (node, bgx, or lmac) out a
+ *			  pki lmac string and set its bitmap accordingly.
+ *
+ * @str: Pki lmac string to parse.
+ * @bitmap: Updated with the bits selected by str.
+ * @size: Maximum size of the bitmap.
+ *
+ * Returns number of characters processed from str.
+ * Returns < 0 for error codes.
+ */
+static int bgx_parse_pki_elem(const char *str, unsigned long *bitmap, int size)
+{
+	const char	*p = str;
+	int		len = -1;
+	int		bit;
+
+	if (*p == 0) {
+		/* If identifier is missing, the whole subset is allowed */
+		bitmap_set(bitmap, 0, size);
+		len = 0;
+	} else if (*p == '*') {
+		/* If identifier is an asterisk, the whole subset is allowed */
+		bitmap_set(bitmap, 0, size);
+		len = 1;
+	} else if (isdigit(*p)) {
+		/* If identifier is a digit, only the bit corresponding to the
+		 * digit is set.
+		 */
+		bit = *p - '0';
+		if (bit < size) {
+			bitmap_set(bitmap, bit, 1);
+			len = 1;
+		}
+	} else if (*p == '[') {
+		/* If identifier is a bracket, all the bits corresponding to
+		 * the digits inside the bracket are set.
+		 */
+		p++;
+		len = 1;
+		do {
+			if (isdigit(*p)) {
+				bit = *p - '0';
+				if (bit < size)
+					bitmap_set(bitmap, bit, 1);
+				else
+					return -1;
+			} else {
+				return -1;
+			}
+			p++;
+			len++;
+		} while (*p != ']');
+		len++;
+	} else {
+		len = -1;
+	}
+
+	return len;
+}
+
+/**
+ * bgx_pki_bitmap_set() - Set the bitmap bits for all elements (node, bgx, and
+ *			  lmac) selected by a pki lmac string.
+ * @str: Pki lmac string to process.
+ * @node: Updated with the nodes specified in the pki lmac string.
+ * @bgx: Updated with the bgx's specified in the pki lmac string.
+ * @lmac: Updated with the lmacs specified in the pki lmac string.
+ *
+ * Returns 0 if successful.
+ * Returns < 0 for error codes.
+ */
+static unsigned long bgx_pki_bitmap_set(const char *str, unsigned long *node,
+					unsigned long *bgx, unsigned long *lmac)
+{
+	const char	*p = str;
+	int		len;
+
+	/* Parse the node */
+	len = bgx_parse_pki_elem(p, node, MAX_NODES);
+	if (len < 0)
+		goto err;
+
+	/* Parse the bgx */
+	p += len;
+	len = bgx_parse_pki_elem(p, bgx, MAX_BGX_PER_NODE);
+	if (len < 0)
+		goto err;
+
+	/* Parse the lmac */
+	p += len;
+	len = bgx_parse_pki_elem(p, lmac, MAX_LMAC_PER_BGX);
+	if (len < 0)
+		goto err;
+
+	return 0;
+ err:
+	bitmap_zero(node, MAX_NODES);
+	bitmap_zero(bgx, MAX_BGX_PER_NODE);
+	bitmap_zero(lmac, MAX_LMAC_PER_BGX);
+	return len;
+}
+
+/**
+ * bgx_pki_init_from_param() - Initialize the list of lmacs that connect to the
+ *			     pki from information in the "pki_port" parameter.
+ *
+ *			     The pki_port parameter format is as follows:
+ *			     pki_port=nbl
+ *			     where:
+ *				n = node
+ *				b = bgx
+ *				l = lmac
+ *
+ *			     Commas must be used to separate multiple lmacs:
+ *			     pki_port=000,100,110
+ *
+ *			     Asterisks (*) specify all possible characters in
+ *			     the subset:
+ *			     pki_port=00* (all lmacs of node0 bgx0).
+ *
+ *			     Missing lmacs identifiers default to all
+ *			     possible characters in the subset:
+ *			     pki_port=00 (all lmacs on node0 bgx0)
+ *
+ *			     Brackets ('[' and ']') specify the valid
+ *			     characters in the subset:
+ *			     pki_port=00[01] (lmac0 and lmac1 of node0 bgx0).
+ *
+ * Returns 0 if successful.
+ * Returns < 0 for error codes.
+ */
+static int bgx_pki_init_from_param(void)
+{
+	char	*cur;
+	char	*next;
+	DECLARE_BITMAP(node_bitmap, MAX_NODES);
+	DECLARE_BITMAP(bgx_bitmap, MAX_BGX_PER_NODE);
+	DECLARE_BITMAP(lmac_bitmap, MAX_LMAC_PER_BGX);
+
+	/* Parse each comma separated lmac specifier */
+	cur = pki_port;
+	while (cur) {
+		unsigned long	node;
+		unsigned long	bgx;
+		unsigned long	lmac;
+
+		bitmap_zero(node_bitmap, BITS_PER_LONG);
+		bitmap_zero(bgx_bitmap, BITS_PER_LONG);
+		bitmap_zero(lmac_bitmap, BITS_PER_LONG);
+
+		next = strchr(cur, ',');
+		if (next)
+			*next++ = '\0';
+
+		/* Convert the specifier into a bitmap */
+		bgx_pki_bitmap_set(cur, node_bitmap, bgx_bitmap, lmac_bitmap);
+
+		/* Mark the lmacs to be connected to the pki */
+		for_each_set_bit(node, node_bitmap, MAX_NODES) {
+			for_each_set_bit(bgx, bgx_bitmap, MAX_BGX_PER_NODE) {
+				for_each_set_bit(lmac, lmac_bitmap,
+						 MAX_LMAC_PER_BGX)
+					pki_ports[node][bgx][lmac] = true;
+			}
+		}
+
+		cur = next;
+	}
+
+	return 0;
+}
+
+/**
+ * bgx_pki_ports_init() - Initialize the pki_ports variable with the lmacs that
+ *			  connect to the pki.
+ *
+ * Returns 0 if successful.
+ * Returns < 0 for error codes.
+ */
+static int bgx_pki_ports_init(void)
+{
+	int	i, j, k;
+	bool	def_val;
+
+	/* Whether all ports default to connect to the pki or not depend on the
+	 * passed module parameter (if any).
+	 */
+	if (pki_port)
+		def_val = false;
+	else
+		def_val = true;
+
+	for (i = 0; i < MAX_NODES; i++) {
+		for (j = 0; j < MAX_BGX_PER_NODE; j++) {
+			for (k = 0; k < MAX_LMAC_PER_BGX; k++)
+				pki_ports[i][j][k] = def_val;
+		}
+	}
+
+	/* Check if ports have to be individually configured */
+	if (pki_port && strcmp(pki_port, "none"))
+		bgx_pki_init_from_param();
+
+	return 0;
+}
+
+static int bgx_remove(struct platform_device *pdev)
+{
+	return 0;
+}
+
+static void bgx_shutdown(struct platform_device *pdev)
+{
+}
+
+static const struct of_device_id bgx_match[] = {
+	{
+		.compatible = "cavium,octeon-7890-bgx",
+	},
+	{},
+};
+MODULE_DEVICE_TABLE(of, bgx_match);
+
+static struct platform_driver bgx_driver = {
+	.probe		= bgx_probe,
+	.remove		= bgx_remove,
+	.shutdown       = bgx_shutdown,
+	.driver		= {
+		.owner	= THIS_MODULE,
+		.name	= KBUILD_MODNAME,
+		.of_match_table = bgx_match,
+	},
+};
+
+/* Allow bgx_port driver to force this driver to load */
+void bgx_nexus_load(void)
+{
+}
+EXPORT_SYMBOL(bgx_nexus_load);
+
+static int __init bgx_driver_init(void)
+{
+	int r;
+
+	INIT_LIST_HEAD(&pdev_list);
+	mutex_init(&pdev_list_lock);
+
+	bgx_mix_port_lmacs_init();
+	bgx_pki_ports_init();
+
+	r = platform_driver_register(&bgx_driver);
+
+	return r;
+}
+
+static void __exit bgx_driver_exit(void)
+{
+	struct pdev_list_item *pdev_item;
+
+	mutex_lock(&pdev_list_lock);
+	while (!list_empty(&pdev_list)) {
+		pdev_item = list_first_entry(&pdev_list,
+					     struct pdev_list_item, list);
+		list_del(&pdev_item->list);
+		platform_device_unregister(pdev_item->pdev);
+		kfree(pdev_item);
+	}
+	mutex_unlock(&pdev_list_lock);
+
+	platform_driver_unregister(&bgx_driver);
+}
+
+module_init(bgx_driver_init);
+module_exit(bgx_driver_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Cavium, Inc. <support@caviumnetworks.com>");
+MODULE_DESCRIPTION("Cavium, Inc. BGX MAC Nexus driver.");
diff --git a/drivers/net/ethernet/cavium/octeon/octeon3-bgx-port.c b/drivers/net/ethernet/cavium/octeon/octeon3-bgx-port.c
new file mode 100644
index 000000000000..94ead6812b93
--- /dev/null
+++ b/drivers/net/ethernet/cavium/octeon/octeon3-bgx-port.c
@@ -0,0 +1,2015 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2017 Cavium, Inc.
+ *
+ * The BGX port (LMAC) is a single Ethernet MAC that may be assigned
+ * to either the octeon3-ethernet packet processor or the octeon_mgmt
+ * packet processor.
+ */
+#include <linux/platform_device.h>
+#include <linux/netdevice.h>
+#include <linux/etherdevice.h>
+#include <linux/of_platform.h>
+#include <linux/of_address.h>
+#include <linux/of_mdio.h>
+#include <linux/of_net.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/list.h>
+
+#include <asm/octeon/octeon.h>
+
+#include "octeon3.h"
+
+struct bgx_port_priv {
+	int node;
+	int bgx;
+	int index; /* Port index on BGX block*/
+	enum port_mode mode;
+	int pknd;
+	int qlm;
+	const u8 *mac_addr;
+	struct phy_device *phydev;
+	struct device_node *phy_np;
+	int phy_mode;
+	bool mode_1000basex;
+	bool bgx_as_phy;
+	struct net_device *netdev;
+	struct mutex lock;	/* Serializes delayed work */
+	struct port_status (*get_link)(struct bgx_port_priv *priv);
+	int (*set_link)(struct bgx_port_priv *priv, struct port_status status);
+	struct port_status last_status;
+	struct delayed_work dwork;
+	bool work_queued;
+};
+
+/* lmac_pknd keeps track of the port kinds assigned to the lmacs */
+static int lmac_pknd[MAX_NODES][MAX_BGX_PER_NODE][MAX_LMAC_PER_BGX];
+
+static struct workqueue_struct *check_state_wq;
+static DEFINE_MUTEX(check_state_wq_mutex);
+
+int bgx_port_get_qlm(int node, int bgx, int index)
+{
+	u64	data;
+	int	qlm = -1;
+
+	if (OCTEON_IS_MODEL(OCTEON_CN78XX)) {
+		if (bgx < 2) {
+			data = oct_csr_read(BGX_CMR_GLOBAL_CONFIG(node, bgx));
+			if (data & 1)
+				qlm = bgx + 2;
+			else
+				qlm = bgx;
+		} else {
+			qlm = bgx + 2;
+		}
+	} else if (OCTEON_IS_MODEL(OCTEON_CN73XX)) {
+		if (bgx < 2) {
+			qlm = bgx + 2;
+		} else {
+			/* Ports on bgx2 can be connected to qlm5 or qlm6 */
+			if (index < 2)
+				qlm = 5;
+			else
+				qlm = 6;
+		}
+	} else if (OCTEON_IS_MODEL(OCTEON_CNF75XX)) {
+		/* Ports on bgx0 can be connected to qlm4 or qlm5 */
+		if (index < 2)
+			qlm = 4;
+		else
+			qlm = 5;
+	}
+
+	return qlm;
+}
+EXPORT_SYMBOL(bgx_port_get_qlm);
+
+/* Returns the mode of the bgx port */
+enum port_mode bgx_port_get_mode(int node, int bgx, int index)
+{
+	enum port_mode	mode;
+	u64		data;
+
+	data = oct_csr_read(BGX_CMR_CONFIG(node, bgx, index));
+
+	switch ((data >> 8) & 7) {
+	case 0:
+		mode = PORT_MODE_SGMII;
+		break;
+	case 1:
+		mode = PORT_MODE_XAUI;
+		break;
+	case 2:
+		mode = PORT_MODE_RXAUI;
+		break;
+	case 3:
+		data = oct_csr_read(BGX_SPU_BR_PMD_CONTROL(node, bgx, index));
+		/* The use of training differentiates 10G_KR from xfi */
+		if (data & BIT(1))
+			mode = PORT_MODE_10G_KR;
+		else
+			mode = PORT_MODE_XFI;
+		break;
+	case 4:
+		data = oct_csr_read(BGX_SPU_BR_PMD_CONTROL(node, bgx, index));
+		/* The use of training differentiates 40G_KR4 from xlaui */
+		if (data & BIT(1))
+			mode = PORT_MODE_40G_KR4;
+		else
+			mode = PORT_MODE_XLAUI;
+		break;
+	case 5:
+		mode = PORT_MODE_RGMII;
+		break;
+	default:
+		mode = PORT_MODE_DISABLED;
+		break;
+	}
+
+	return mode;
+}
+EXPORT_SYMBOL(bgx_port_get_mode);
+
+int bgx_port_allocate_pknd(int node)
+{
+	struct global_resource_tag	tag;
+	char				buf[16];
+	int				pknd;
+
+	strncpy((char *)&tag.lo, "cvm_pknd", 8);
+	snprintf(buf, 16, "_%d......", node);
+	memcpy(&tag.hi, buf, 8);
+
+	res_mgr_create_resource(tag, 64);
+	pknd = res_mgr_alloc(tag, -1, false);
+	if (pknd < 0) {
+		pr_err("bgx-port: Failed to allocate pknd\n");
+		return -ENODEV;
+	}
+
+	return pknd;
+}
+EXPORT_SYMBOL(bgx_port_allocate_pknd);
+
+int bgx_port_get_pknd(int node, int bgx, int index)
+{
+	return lmac_pknd[node][bgx][index];
+}
+EXPORT_SYMBOL(bgx_port_get_pknd);
+
+/* GSER-20075 */
+static void bgx_port_gser_20075(struct bgx_port_priv	*priv,
+				int			qlm,
+				int			lane)
+{
+	u64	data;
+	u64	addr;
+
+	if (OCTEON_IS_MODEL(OCTEON_CN78XX_PASS1_X) &&
+	    (lane == -1 || lane == 3)) {
+		/* Enable software control */
+		addr = GSER_BR_RX_CTL(priv->node, qlm, 3);
+		data = oct_csr_read(addr);
+		data |= BIT(2);
+		oct_csr_write(data, addr);
+
+		/* Clear the completion flag */
+		addr = GSER_BR_RX_EER(priv->node, qlm, 3);
+		data = oct_csr_read(addr);
+		data &= ~BIT(14);
+		oct_csr_write(data, addr);
+
+		/* Initiate a new request on lane 2 */
+		if (lane == 3) {
+			addr = GSER_BR_RX_EER(priv->node, qlm, 2);
+			data = oct_csr_read(addr);
+			data |= BIT(15);
+			oct_csr_write(data, addr);
+		}
+	}
+}
+
+static void bgx_common_init_pknd(struct bgx_port_priv *priv)
+{
+	u64	data;
+	int	num_ports;
+
+	/* Setup pkind */
+	priv->pknd = bgx_port_allocate_pknd(priv->node);
+	lmac_pknd[priv->node][priv->bgx][priv->index] = priv->pknd;
+	data = oct_csr_read(BGX_CMR_RX_ID_MAP(priv->node, priv->bgx, priv->index));
+	data &= ~GENMASK_ULL(7, 0);
+	data |= priv->pknd;
+	if (OCTEON_IS_MODEL(OCTEON_CN73XX)) {
+		/* Change the default reassembly id (max allowed is 14) */
+		data &= ~GENMASK_ULL(14, 8);
+		data |= ((4 * priv->bgx) + 2 + priv->index) << 8;
+	}
+	oct_csr_write(data, BGX_CMR_RX_ID_MAP(priv->node, priv->bgx, priv->index));
+
+	/* Set backpressure channel mask AND/OR registers */
+	data = oct_csr_read(BGX_CMR_CHAN_MSK_AND(priv->node, priv->bgx));
+	data |= 0xffff << (16 * priv->index);
+	oct_csr_write(data, BGX_CMR_CHAN_MSK_AND(priv->node, priv->bgx));
+
+	data = oct_csr_read(BGX_CMR_CHAN_MSK_OR(priv->node, priv->bgx));
+	data |= 0xffff << (16 * priv->index);
+	oct_csr_write(data, BGX_CMR_CHAN_MSK_OR(priv->node, priv->bgx));
+
+	/* Rx back pressure watermark:
+	 * Set to 1/4 of the available lmacs buffer (in multiple of 16 bytes)
+	 */
+	data = oct_csr_read(BGX_CMR_TX_LMACS(priv->node, priv->bgx));
+	num_ports = data & 7;
+	data = BGX_RX_FIFO_SIZE / (num_ports * 4 * 16);
+	oct_csr_write(data, BGX_CMR_RX_BP_ON(priv->node, priv->bgx, priv->index));
+}
+
+static int bgx_xgmii_hardware_init(struct bgx_port_priv *priv)
+{
+	u64	clock_mhz;
+	u64	data;
+	u64	ctl;
+
+	/* Set TX Threshold */
+	data = 0x20;
+	oct_csr_write(data, BGX_GMP_GMI_TX_THRESH(priv->node, priv->bgx, priv->index));
+
+	data = oct_csr_read(BGX_GMP_PCS_MISC_CTL(priv->node, priv->bgx, priv->index));
+	data &= ~(BIT(8) | BIT(9));
+	if (priv->mode_1000basex)
+		data |= BIT(8);
+	if (priv->bgx_as_phy)
+		data |= BIT(9);
+	oct_csr_write(data, BGX_GMP_PCS_MISC_CTL(priv->node, priv->bgx, priv->index));
+
+	data = oct_csr_read(BGX_GMP_PCS_LINK_TIMER(priv->node, priv->bgx, priv->index));
+	clock_mhz = octeon_get_io_clock_rate() / 1000000;
+	if (priv->mode_1000basex)
+		data = (10000ull * clock_mhz) >> 10;
+	else
+		data = (1600ull * clock_mhz) >> 10;
+	oct_csr_write(data, BGX_GMP_PCS_LINK_TIMER(priv->node, priv->bgx, priv->index));
+
+	if (priv->mode_1000basex) {
+		data = oct_csr_read(BGX_GMP_PCS_AN_ADV(priv->node, priv->bgx, priv->index));
+		data &= ~(GENMASK_ULL(13, 12) | GENMASK_ULL(8, 7));
+		data |= 3 << 7;
+		data |= BIT(6) | BIT(5);
+		oct_csr_write(data, BGX_GMP_PCS_AN_ADV(priv->node, priv->bgx, priv->index));
+	} else if (priv->bgx_as_phy) {
+		data = oct_csr_read(BGX_GMP_PCS_SGM_AN_ADV(priv->node, priv->bgx, priv->index));
+		data |= BIT(12);
+		data &= ~(GENMASK_ULL(11, 10));
+		data |= 2 << 10;
+		oct_csr_write(data, BGX_GMP_PCS_SGM_AN_ADV(priv->node, priv->bgx, priv->index));
+	}
+
+	data = oct_csr_read(BGX_GMP_GMI_TX_APPEND(priv->node, priv->bgx, priv->index));
+	ctl = oct_csr_read(BGX_GMP_GMI_TX_SGMII_CTL(priv->node, priv->bgx, priv->index));
+	ctl &= ~BIT(0);
+	ctl |= (data & BIT(0)) ? 0 : 1;
+	oct_csr_write(ctl, BGX_GMP_GMI_TX_SGMII_CTL(priv->node, priv->bgx, priv->index));
+
+	if (priv->mode == PORT_MODE_RGMII) {
+		/* Disable XCV interface when initialized */
+		data = oct_csr_read(XCV_RESET(priv->node));
+		data &= ~(BIT(63) | BIT(3) | BIT(1));
+		oct_csr_write(data, XCV_RESET(priv->node));
+	}
+
+	return 0;
+}
+
+int bgx_get_tx_fifo_size(struct bgx_port_priv *priv)
+{
+	u64	data;
+	int	num_ports;
+
+	data = oct_csr_read(BGX_CMR_TX_LMACS(priv->node, priv->bgx));
+	num_ports = data & 7;
+
+	switch (num_ports) {
+	case 1:
+		return BGX_TX_FIFO_SIZE;
+	case 2:
+		return BGX_TX_FIFO_SIZE / 2;
+	case 3:
+	case 4:
+		return BGX_TX_FIFO_SIZE / 4;
+	default:
+		return 0;
+	}
+}
+
+static int bgx_xaui_hardware_init(struct bgx_port_priv *priv)
+{
+	u64	data;
+	u64	clock_mhz;
+	u64	tx_fifo_size;
+
+	if (octeon_is_simulation()) {
+		/* Enable the port */
+		data = oct_csr_read(BGX_CMR_CONFIG(priv->node, priv->bgx, priv->index));
+		data |= BIT(15);
+		oct_csr_write(data, BGX_CMR_CONFIG(priv->node, priv->bgx, priv->index));
+	} else {
+		/* Reset the port */
+		data = oct_csr_read(BGX_SPU_CONTROL1(priv->node, priv->bgx, priv->index));
+		data |= BIT(15);
+		oct_csr_write(data, BGX_SPU_CONTROL1(priv->node, priv->bgx, priv->index));
+
+		/* Wait for reset to complete */
+		udelay(1);
+		data = oct_csr_read(BGX_SPU_CONTROL1(priv->node, priv->bgx, priv->index));
+		if (data & BIT(15)) {
+			netdev_err(priv->netdev,
+				   "BGX%d:%d: SPU stuck in reset\n", priv->bgx, priv->node);
+			return -1;
+		}
+
+		/* Reset the SerDes lanes */
+		data = oct_csr_read(BGX_SPU_CONTROL1(priv->node, priv->bgx, priv->index));
+		data |= BIT(11);
+		oct_csr_write(data, BGX_SPU_CONTROL1(priv->node, priv->bgx, priv->index));
+
+		/* Disable packet reception */
+		data = oct_csr_read(BGX_SPU_MISC_CONTROL(priv->node, priv->bgx, priv->index));
+		data |= BIT(12);
+		oct_csr_write(data, BGX_SPU_MISC_CONTROL(priv->node, priv->bgx, priv->index));
+
+		/* Clear/disable interrupts */
+		data = oct_csr_read(BGX_SMU_RX_INT(priv->node, priv->bgx, priv->index));
+		oct_csr_write(data, BGX_SMU_RX_INT(priv->node, priv->bgx, priv->index));
+		data = oct_csr_read(BGX_SMU_TX_INT(priv->node, priv->bgx, priv->index));
+		oct_csr_write(data, BGX_SMU_TX_INT(priv->node, priv->bgx, priv->index));
+		data = oct_csr_read(BGX_SPU_INT(priv->node, priv->bgx, priv->index));
+		oct_csr_write(data, BGX_SPU_INT(priv->node, priv->bgx, priv->index));
+
+		if ((priv->mode == PORT_MODE_10G_KR ||
+		     priv->mode == PORT_MODE_40G_KR4) &&
+		    !OCTEON_IS_MODEL(OCTEON_CN78XX_PASS1_X)) {
+			oct_csr_write(0, BGX_SPU_BR_PMD_LP_CUP(priv->node, priv->bgx, priv->index));
+			oct_csr_write(0, BGX_SPU_BR_PMD_LD_CUP(priv->node, priv->bgx, priv->index));
+			oct_csr_write(0, BGX_SPU_BR_PMD_LD_REP(priv->node, priv->bgx, priv->index));
+			data = oct_csr_read(BGX_SPU_BR_PMD_CONTROL(priv->node, priv->bgx, priv->index));
+			data |= BIT(1);
+			oct_csr_write(data, BGX_SPU_BR_PMD_CONTROL(priv->node, priv->bgx, priv->index));
+		}
+	}
+
+	data = oct_csr_read(BGX_SMU_TX_APPEND(priv->node, priv->bgx, priv->index));
+	data |= BIT(3);
+	oct_csr_write(data, BGX_SMU_TX_APPEND(priv->node, priv->bgx, priv->index));
+
+	if (!octeon_is_simulation()) {
+		/* Disable fec */
+		data = oct_csr_read(BGX_SPU_FEC_CONTROL(priv->node, priv->bgx, priv->index));
+		data &= ~BIT(0);
+		oct_csr_write(data, BGX_SPU_FEC_CONTROL(priv->node, priv->bgx, priv->index));
+
+		/* Disable/configure auto negotiation */
+		data = oct_csr_read(BGX_SPU_AN_CONTROL(priv->node, priv->bgx, priv->index));
+		data &= ~(BIT(13) | BIT(12));
+		oct_csr_write(data, BGX_SPU_AN_CONTROL(priv->node, priv->bgx, priv->index));
+
+		data = oct_csr_read(BGX_SPU_AN_ADV(priv->node, priv->bgx, priv->index));
+		data &= ~(BIT(47) | BIT(26) | BIT(25) | BIT(22) | BIT(21) |
+			  BIT(13) | BIT(12));
+		data |= BIT(46);
+		if (priv->mode == PORT_MODE_40G_KR4)
+			data |= BIT(24);
+		else
+			data &= ~BIT(24);
+		if (priv->mode == PORT_MODE_10G_KR)
+			data |= BIT(23);
+		else
+			data &= ~BIT(23);
+		oct_csr_write(data, BGX_SPU_AN_ADV(priv->node, priv->bgx, priv->index));
+
+		data = oct_csr_read(BGX_SPU_DBG_CONTROL(priv->node, priv->bgx));
+		data |= BIT(29);
+		if (priv->mode == PORT_MODE_10G_KR ||
+		    priv->mode == PORT_MODE_40G_KR4)
+			data |= BIT(18);
+		else
+			data &= ~BIT(18);
+		oct_csr_write(data, BGX_SPU_DBG_CONTROL(priv->node, priv->bgx));
+
+		/* Enable the port */
+		data = oct_csr_read(BGX_CMR_CONFIG(priv->node, priv->bgx, priv->index));
+		data |= BIT(15);
+		oct_csr_write(data, BGX_CMR_CONFIG(priv->node, priv->bgx, priv->index));
+
+		if (OCTEON_IS_MODEL(OCTEON_CN78XX_PASS1_X) && priv->index) {
+			/* BGX-22429 */
+			data = oct_csr_read(BGX_CMR_CONFIG(priv->node, priv->bgx, 0));
+			data |= BIT(15);
+			oct_csr_write(data, BGX_CMR_CONFIG(priv->node, priv->bgx, 0));
+		}
+	}
+
+	data = oct_csr_read(BGX_SPU_CONTROL1(priv->node, priv->bgx, priv->index));
+	data &= ~BIT(11);
+	oct_csr_write(data, BGX_SPU_CONTROL1(priv->node, priv->bgx, priv->index));
+
+	data = oct_csr_read(BGX_SMU_TX_CTL(priv->node, priv->bgx, priv->index));
+	data |= BIT(0);
+	data &= ~BIT(1);
+	oct_csr_write(data, BGX_SMU_TX_CTL(priv->node, priv->bgx, priv->index));
+
+	clock_mhz = octeon_get_io_clock_rate() / 1000000;
+	data = oct_csr_read(BGX_SPU_DBG_CONTROL(priv->node, priv->bgx));
+	data &= ~GENMASK_ULL(43, 32);
+	data |= (clock_mhz - 1) << 32;
+	oct_csr_write(data, BGX_SPU_DBG_CONTROL(priv->node, priv->bgx));
+
+	/* Fifo in 16-byte words */
+	tx_fifo_size = bgx_get_tx_fifo_size(priv);
+	tx_fifo_size >>= 4;
+	oct_csr_write(tx_fifo_size - 10, BGX_SMU_TX_THRESH(priv->node, priv->bgx, priv->index));
+
+	if (priv->mode == PORT_MODE_RXAUI && priv->phy_np) {
+		data = oct_csr_read(BGX_SPU_MISC_CONTROL(priv->node, priv->bgx, priv->index));
+		data |= BIT(10);
+		oct_csr_write(data, BGX_SPU_MISC_CONTROL(priv->node, priv->bgx, priv->index));
+	}
+
+	/* Some PHYs take up to 250ms to stabilize */
+	if (!octeon_is_simulation())
+		usleep_range(250000, 300000);
+
+	return 0;
+}
+
+/* Configure/initialize a bgx port. */
+static int bgx_port_init(struct bgx_port_priv *priv)
+{
+	u64	data;
+	int	rc = 0;
+
+	/* GSER-20956 */
+	if (OCTEON_IS_MODEL(OCTEON_CN78XX_PASS1_X) &&
+	    (priv->mode == PORT_MODE_10G_KR ||
+	     priv->mode == PORT_MODE_XFI ||
+	     priv->mode == PORT_MODE_40G_KR4 ||
+	     priv->mode == PORT_MODE_XLAUI)) {
+		/* Disable link training */
+		data = oct_csr_read(BGX_SPU_BR_PMD_CONTROL(priv->node, priv->bgx, priv->index));
+		data &= ~(1 << 1);
+		oct_csr_write(data, BGX_SPU_BR_PMD_CONTROL(priv->node, priv->bgx, priv->index));
+	}
+
+	bgx_common_init_pknd(priv);
+
+	if (priv->mode == PORT_MODE_SGMII ||
+	    priv->mode == PORT_MODE_RGMII)
+		rc = bgx_xgmii_hardware_init(priv);
+	else
+		rc = bgx_xaui_hardware_init(priv);
+
+	return rc;
+}
+
+static int bgx_port_get_qlm_speed(struct bgx_port_priv	*priv,
+				  int			qlm)
+{
+	enum lane_mode	lmode;
+	u64		data;
+
+	data = oct_csr_read(GSER_LANE_MODE(priv->node, qlm));
+	lmode = data & 0xf;
+
+	switch (lmode) {
+	case R_25G_REFCLK100:
+		return 2500;
+	case R_5G_REFCLK100:
+		return 5000;
+	case R_8G_REFCLK100:
+		return 8000;
+	case R_125G_REFCLK15625_KX:
+		return 1250;
+	case R_3125G_REFCLK15625_XAUI:
+		return 3125;
+	case R_103125G_REFCLK15625_KR:
+		return 10312;
+	case R_125G_REFCLK15625_SGMII:
+		return 1250;
+	case R_5G_REFCLK15625_QSGMII:
+		return 5000;
+	case R_625G_REFCLK15625_RXAUI:
+		return 6250;
+	case R_25G_REFCLK125:
+		return 2500;
+	case R_5G_REFCLK125:
+		return 5000;
+	case R_8G_REFCLK125:
+		return 8000;
+	default:
+		return 0;
+	}
+}
+
+static struct port_status bgx_port_get_sgmii_link(struct bgx_port_priv *priv)
+{
+	struct port_status	status;
+	int			speed;
+
+	/* The simulator always uses a 1Gbps full duplex port */
+	if (octeon_is_simulation()) {
+		status.link = 1;
+		status.duplex = DUPLEX_FULL;
+		status.speed = 1000;
+	} else {
+		/* Use the qlm speed */
+		speed = bgx_port_get_qlm_speed(priv, priv->qlm);
+		status.link = 1;
+		status.duplex = DUPLEX_FULL;
+		status.speed = speed * 8 / 10;
+	}
+
+	return status;
+}
+
+static int bgx_port_xgmii_set_link_up(struct bgx_port_priv *priv)
+{
+	u64	data;
+	int	timeout;
+
+	if (!octeon_is_simulation()) {
+		/* PCS reset sequence */
+		data = oct_csr_read(BGX_GMP_PCS_MR_CONTROL(priv->node, priv->bgx, priv->index));
+		data |= BIT(15);
+		oct_csr_write(data, BGX_GMP_PCS_MR_CONTROL(priv->node, priv->bgx, priv->index));
+
+		/* Wait for reset to complete */
+		udelay(1);
+		data = oct_csr_read(BGX_GMP_PCS_MR_CONTROL(priv->node, priv->bgx, priv->index));
+		if (data & BIT(15)) {
+			netdev_err(priv->netdev,
+				   "BGX%d:%d: PCS stuck in reset\n", priv->bgx, priv->node);
+			return -1;
+		}
+	}
+
+	/* Autonegotiation */
+	if (priv->phy_np) {
+		data = oct_csr_read(BGX_GMP_PCS_MR_CONTROL(priv->node, priv->bgx, priv->index));
+		data |= BIT(9);
+		if (priv->mode != PORT_MODE_RGMII)
+			data |= BIT(12);
+		else
+			data &= ~BIT(12);
+		data &= ~BIT(11);
+		oct_csr_write(data, BGX_GMP_PCS_MR_CONTROL(priv->node, priv->bgx, priv->index));
+	} else {
+		data = oct_csr_read(BGX_GMP_PCS_MR_CONTROL(priv->node, priv->bgx, priv->index));
+		data |= BIT(6);
+		data &= ~(BIT(13) | BIT(12) | BIT(11));
+		oct_csr_write(data, BGX_GMP_PCS_MR_CONTROL(priv->node, priv->bgx, priv->index));
+	}
+
+	data = oct_csr_read(BGX_GMP_PCS_MISC_CTL(priv->node, priv->bgx, priv->index));
+	data &= ~(BIT(9) | BIT(8));
+	if (priv->mode_1000basex)
+		data |= BIT(8);
+	if (priv->bgx_as_phy)
+		data |= BIT(9);
+	oct_csr_write(data, BGX_GMP_PCS_MISC_CTL(priv->node, priv->bgx, priv->index));
+
+	/* Wait for autonegotiation to complete */
+	if (!octeon_is_simulation() && !priv->bgx_as_phy &&
+	    priv->mode != PORT_MODE_RGMII) {
+		timeout = 10000;
+		do {
+			data = oct_csr_read(BGX_GMP_PCS_MR_STATUS(priv->node, priv->bgx, priv->index));
+			if (data & BIT(5))
+				break;
+			timeout--;
+			udelay(1);
+		} while (timeout);
+		if (!timeout) {
+			netdev_err(priv->netdev, "BGX%d:%d: AN timeout\n", priv->bgx, priv->node);
+			return -1;
+		}
+	}
+
+	return 0;
+}
+
+static void bgx_port_rgmii_set_link_down(struct bgx_port_priv *priv)
+{
+	u64	data;
+	int	rx_fifo_len;
+
+	data = oct_csr_read(XCV_RESET(priv->node));
+	data &= ~BIT(1);
+	oct_csr_write(data, XCV_RESET(priv->node));
+	/* Is this read really needed? TODO */
+	data = oct_csr_read(XCV_RESET(priv->node));
+
+	/* Wait for 2 MTUs */
+	mdelay(10);
+
+	data = oct_csr_read(BGX_CMR_CONFIG(priv->node, priv->bgx, priv->index));
+	data &= ~BIT(14);
+	oct_csr_write(data, BGX_CMR_CONFIG(priv->node, priv->bgx, priv->index));
+
+	/* Wait for the rx and tx fifos to drain */
+	do {
+		data = oct_csr_read(BGX_CMR_RX_FIFO_LEN(priv->node, priv->bgx, priv->index));
+		rx_fifo_len = data & 0x1fff;
+		data = oct_csr_read(BGX_CMR_TX_FIFO_LEN(priv->node, priv->bgx, priv->index));
+	} while (rx_fifo_len > 0 || !(data & BIT(13)));
+
+	data = oct_csr_read(BGX_CMR_CONFIG(priv->node, priv->bgx, priv->index));
+	data &= ~BIT(13);
+	oct_csr_write(data, BGX_CMR_CONFIG(priv->node, priv->bgx, priv->index));
+
+	data = oct_csr_read(XCV_RESET(priv->node));
+	data &= ~BIT(3);
+	oct_csr_write(data, XCV_RESET(priv->node));
+
+	data = oct_csr_read(BGX_GMP_PCS_MR_CONTROL(priv->node, priv->bgx, priv->index));
+	data |= BIT(11);
+	oct_csr_write(data, BGX_GMP_PCS_MR_CONTROL(priv->node, priv->bgx, priv->index));
+}
+
+static void bgx_port_sgmii_set_link_down(struct bgx_port_priv *priv)
+{
+	u64	data;
+
+	data = oct_csr_read(BGX_CMR_CONFIG(priv->node, priv->bgx, priv->index));
+	data &= ~(BIT(14) | BIT(13));
+	oct_csr_write(data, BGX_CMR_CONFIG(priv->node, priv->bgx, priv->index));
+
+	data = oct_csr_read(BGX_GMP_PCS_MR_CONTROL(priv->node, priv->bgx, priv->index));
+	data &= ~BIT(12);
+	oct_csr_write(data, BGX_GMP_PCS_MR_CONTROL(priv->node, priv->bgx, priv->index));
+
+	data = oct_csr_read(BGX_GMP_PCS_MISC_CTL(priv->node, priv->bgx, priv->index));
+	data |= BIT(11);
+	oct_csr_write(data, BGX_GMP_PCS_MISC_CTL(priv->node, priv->bgx, priv->index));
+	data = oct_csr_read(BGX_GMP_PCS_MISC_CTL(priv->node, priv->bgx, priv->index));
+}
+
+static int bgx_port_sgmii_set_link_speed(struct bgx_port_priv *priv, struct port_status status)
+{
+	u64	data;
+	u64	prtx;
+	u64	miscx;
+	int	timeout;
+
+	data = oct_csr_read(BGX_CMR_CONFIG(priv->node, priv->bgx, priv->index));
+	data &= ~(BIT(14) | BIT(13));
+	oct_csr_write(data, BGX_CMR_CONFIG(priv->node, priv->bgx, priv->index));
+
+	timeout = 10000;
+	do {
+		prtx = oct_csr_read(BGX_GMP_GMI_PRT_CFG(priv->node, priv->bgx, priv->index));
+		if (prtx & BIT(13) && prtx & BIT(12))
+			break;
+		timeout--;
+		udelay(1);
+	} while (timeout);
+	if (!timeout) {
+		netdev_err(priv->netdev, "BGX%d:%d: GMP idle timeout\n", priv->bgx, priv->node);
+		return -1;
+	}
+
+	prtx = oct_csr_read(BGX_GMP_GMI_PRT_CFG(priv->node, priv->bgx, priv->index));
+	miscx = oct_csr_read(BGX_GMP_PCS_MISC_CTL(priv->node, priv->bgx, priv->index));
+	if (status.link) {
+		miscx &= ~BIT(11);
+		if (status.duplex == DUPLEX_FULL)
+			prtx |= BIT(2);
+		else
+			prtx &= ~BIT(2);
+	} else {
+		miscx |= BIT(11);
+	}
+
+	switch (status.speed) {
+	case 10:
+		prtx &= ~(BIT(3) | BIT(1));
+		prtx |= BIT(8);
+		miscx &= ~GENMASK_ULL(6, 0);
+		miscx |= 25;
+		oct_csr_write(64, BGX_GMP_GMI_TX_SLOT(priv->node, priv->bgx, priv->index));
+		oct_csr_write(0, BGX_GMP_GMI_TX_BURST(priv->node, priv->bgx, priv->index));
+		break;
+	case 100:
+		prtx &= ~(BIT(8) | BIT(3) | BIT(1));
+		miscx &= ~GENMASK_ULL(6, 0);
+		miscx |= 5;
+		oct_csr_write(64, BGX_GMP_GMI_TX_SLOT(priv->node, priv->bgx, priv->index));
+		oct_csr_write(0, BGX_GMP_GMI_TX_BURST(priv->node, priv->bgx, priv->index));
+		break;
+	case 1000:
+		prtx |= (BIT(3) | BIT(1));
+		prtx &= ~BIT(8);
+		miscx &= ~GENMASK_ULL(6, 0);
+		miscx |= 1;
+		oct_csr_write(512, BGX_GMP_GMI_TX_SLOT(priv->node, priv->bgx, priv->index));
+		if (status.duplex == DUPLEX_FULL)
+			oct_csr_write(0, BGX_GMP_GMI_TX_BURST(priv->node, priv->bgx, priv->index));
+		else
+			oct_csr_write(8192, BGX_GMP_GMI_TX_BURST(priv->node, priv->bgx, priv->index));
+		break;
+	default:
+		break;
+	}
+
+	oct_csr_write(miscx, BGX_GMP_PCS_MISC_CTL(priv->node, priv->bgx, priv->index));
+	oct_csr_write(prtx, BGX_GMP_GMI_PRT_CFG(priv->node, priv->bgx, priv->index));
+	/* This read verifies the write completed */
+	prtx = oct_csr_read(BGX_GMP_GMI_PRT_CFG(priv->node, priv->bgx, priv->index));
+
+	data = oct_csr_read(BGX_CMR_CONFIG(priv->node, priv->bgx, priv->index));
+	data |= (BIT(14) | BIT(13));
+	oct_csr_write(data, BGX_CMR_CONFIG(priv->node, priv->bgx, priv->index));
+
+	return 0;
+}
+
+static int bgx_port_rgmii_set_link_speed(struct bgx_port_priv *priv, struct port_status status)
+{
+	u64	data;
+	int	speed;
+	bool	speed_changed = false;
+	bool	int_lpbk = false;
+	bool	do_credits;
+
+	switch (status.speed) {
+	case 10:
+		speed = 0;
+		break;
+	case 100:
+		speed = 1;
+		break;
+	case 1000:
+	default:
+		speed = 2;
+		break;
+	}
+
+	/* Do credits if link came up */
+	data = oct_csr_read(XCV_RESET(priv->node));
+	do_credits = status.link && !(data & BIT(63));
+
+	/* Was there a speed change */
+	data = oct_csr_read(XCV_CTL(priv->node));
+	if ((data & GENMASK_ULL(1, 0)) != speed)
+		speed_changed = true;
+
+	/* Clear clkrst when in internal loopback */
+	if (data & BIT(2)) {
+		int_lpbk = true;
+		data = oct_csr_read(XCV_RESET(priv->node));
+		data &= ~BIT(15);
+		oct_csr_write(data, XCV_RESET(priv->node));
+	}
+
+	/* Link came up or there was a speed change */
+	data = oct_csr_read(XCV_RESET(priv->node));
+	if (status.link && (!(data & BIT(63)) || speed_changed)) {
+		data |= BIT(63);
+		oct_csr_write(data, XCV_RESET(priv->node));
+
+		data = oct_csr_read(XCV_CTL(priv->node));
+		data &= ~GENMASK_ULL(1, 0);
+		data |= speed;
+		oct_csr_write(data, XCV_CTL(priv->node));
+
+		data = oct_csr_read(XCV_DLL_CTL(priv->node));
+		data |= BIT(23);
+		data &= ~GENMASK_ULL(22, 16);
+		data &= ~BIT(15);
+		oct_csr_write(data, XCV_DLL_CTL(priv->node));
+
+		data = oct_csr_read(XCV_DLL_CTL(priv->node));
+		data &= ~GENMASK_ULL(1, 0);
+		oct_csr_write(data, XCV_DLL_CTL(priv->node));
+
+		data = oct_csr_read(XCV_RESET(priv->node));
+		data &= ~BIT(11);
+		oct_csr_write(data, XCV_RESET(priv->node));
+
+		usleep_range(10, 100);
+
+		data = oct_csr_read(XCV_COMP_CTL(priv->node));
+		data &= ~BIT(63);
+		oct_csr_write(data, XCV_COMP_CTL(priv->node));
+
+		data = oct_csr_read(XCV_RESET(priv->node));
+		data |= BIT(7);
+		oct_csr_write(data, XCV_RESET(priv->node));
+
+		data = oct_csr_read(XCV_RESET(priv->node));
+		if (int_lpbk)
+			data &= ~BIT(15);
+		else
+			data |= BIT(15);
+		oct_csr_write(data, XCV_RESET(priv->node));
+
+		data = oct_csr_read(XCV_RESET(priv->node));
+		data |= BIT(2) | BIT(0);
+		oct_csr_write(data, XCV_RESET(priv->node));
+	}
+
+	data = oct_csr_read(XCV_RESET(priv->node));
+	if (status.link)
+		data |= BIT(3) | BIT(1);
+	else
+		data &= ~(BIT(3) | BIT(1));
+	oct_csr_write(data, XCV_RESET(priv->node));
+
+	if (!status.link) {
+		mdelay(10);
+		oct_csr_write(0, XCV_RESET(priv->node));
+	}
+
+	/* Grant pko tx credits */
+	if (do_credits) {
+		data = oct_csr_read(XCV_BATCH_CRD_RET(priv->node));
+		data |= BIT(0);
+		oct_csr_write(data, XCV_BATCH_CRD_RET(priv->node));
+	}
+
+	return 0;
+}
+
+static int bgx_port_set_xgmii_link(struct bgx_port_priv *priv,
+				   struct port_status status)
+{
+	u64	data;
+	int	rc = 0;
+
+	if (status.link) {
+		/* Link up */
+		data = oct_csr_read(BGX_CMR_CONFIG(priv->node, priv->bgx, priv->index));
+		data |= BIT(15);
+		oct_csr_write(data, BGX_CMR_CONFIG(priv->node, priv->bgx, priv->index));
+
+		/* BGX-22429 */
+		if (OCTEON_IS_MODEL(OCTEON_CN78XX_PASS1_X) && priv->index) {
+			data = oct_csr_read(BGX_CMR_CONFIG(priv->node, priv->bgx, 0));
+			data |= BIT(15);
+			oct_csr_write(data, BGX_CMR_CONFIG(priv->node, priv->bgx, 0));
+		}
+
+		rc = bgx_port_xgmii_set_link_up(priv);
+		if (rc)
+			return rc;
+		rc = bgx_port_sgmii_set_link_speed(priv, status);
+		if (rc)
+			return rc;
+		if (priv->mode == PORT_MODE_RGMII)
+			rc = bgx_port_rgmii_set_link_speed(priv, status);
+	} else {
+		/* Link down */
+		if (priv->mode == PORT_MODE_RGMII) {
+			bgx_port_rgmii_set_link_down(priv);
+			rc = bgx_port_sgmii_set_link_speed(priv, status);
+			if (rc)
+				return rc;
+			rc = bgx_port_rgmii_set_link_speed(priv, status);
+		} else {
+			bgx_port_sgmii_set_link_down(priv);
+		}
+	}
+
+	return rc;
+}
+
+static struct port_status bgx_port_get_xaui_link(struct bgx_port_priv *priv)
+{
+	struct port_status	status;
+	int			speed;
+	int			lanes;
+	u64			data;
+
+	status.link = 0;
+	status.duplex = DUPLEX_HALF;
+	status.speed = 0;
+
+	/* Get the link state */
+	data = oct_csr_read(BGX_SMU_TX_CTL(priv->node, priv->bgx, priv->index));
+	data &= GENMASK_ULL(5, 4);
+	if (!data) {
+		data = oct_csr_read(BGX_SMU_RX_CTL(priv->node, priv->bgx, priv->index));
+		data &= GENMASK_ULL(1, 0);
+		if (!data) {
+			data = oct_csr_read(BGX_SPU_STATUS1(priv->node, priv->bgx, priv->index));
+			if (data & BIT(2))
+				status.link = 1;
+		}
+	}
+
+	if (status.link) {
+		/* Always full duplex */
+		status.duplex = DUPLEX_FULL;
+
+		/* Speed */
+		speed = bgx_port_get_qlm_speed(priv, priv->qlm);
+		data = oct_csr_read(BGX_CMR_CONFIG(priv->node, priv->bgx, priv->index));
+		switch ((data >> 8) & 7) {
+		default:
+		case 1:
+			speed = (speed * 8 + 5) / 10;
+			lanes = 4;
+			break;
+		case 2:
+			speed = (speed * 8 + 5) / 10;
+			lanes = 2;
+			break;
+		case 3:
+			speed = (speed * 64 + 33) / 66;
+			lanes = 1;
+			break;
+		case 4:
+			if (speed == 6250)
+				speed = 6445;
+			speed = (speed * 64 + 33) / 66;
+			lanes = 4;
+			break;
+		}
+
+		speed *= lanes;
+		status.speed = speed;
+	}
+
+	return status;
+}
+
+static int bgx_port_init_xaui_an(struct bgx_port_priv *priv)
+{
+	u64	data;
+
+	if (OCTEON_IS_MODEL(OCTEON_CN78XX_PASS1_X)) {
+		data = oct_csr_read(BGX_SPU_INT(priv->node, priv->bgx, priv->index));
+		/* If autonegotiation is no good */
+		if (!(data & BIT(11))) {
+			data = BIT(12) | BIT(11) | BIT(10);
+			oct_csr_write(data, BGX_SPU_INT(priv->node, priv->bgx, priv->index));
+
+			data = oct_csr_read(BGX_SPU_AN_CONTROL(priv->node, priv->bgx, priv->index));
+			data |= BIT(9);
+			oct_csr_write(data, BGX_SPU_AN_CONTROL(priv->node, priv->bgx, priv->index));
+			return -1;
+		}
+	} else {
+		data = oct_csr_read(BGX_SPU_AN_STATUS(priv->node, priv->bgx, priv->index));
+		/* If autonegotiation hasn't completed */
+		if (!(data & BIT(5))) {
+			data = oct_csr_read(BGX_SPU_AN_CONTROL(priv->node, priv->bgx, priv->index));
+			data |= BIT(9);
+			oct_csr_write(data, BGX_SPU_AN_CONTROL(priv->node, priv->bgx, priv->index));
+			return -1;
+		}
+	}
+
+	return 0;
+}
+
+static void bgx_port_xaui_start_training(struct bgx_port_priv *priv)
+{
+	u64	data;
+
+	data = BIT(14) | BIT(13);
+	oct_csr_write(data, BGX_SPU_INT(priv->node, priv->bgx, priv->index));
+
+	/* BGX-20968 */
+	oct_csr_write(0, BGX_SPU_BR_PMD_LP_CUP(priv->node, priv->bgx, priv->index));
+	oct_csr_write(0, BGX_SPU_BR_PMD_LD_CUP(priv->node, priv->bgx, priv->index));
+	oct_csr_write(0, BGX_SPU_BR_PMD_LD_REP(priv->node, priv->bgx, priv->index));
+	data = oct_csr_read(BGX_SPU_AN_CONTROL(priv->node, priv->bgx, priv->index));
+	data &= ~BIT(12);
+	oct_csr_write(data, BGX_SPU_AN_CONTROL(priv->node, priv->bgx, priv->index));
+	udelay(1);
+
+	data = oct_csr_read(BGX_SPU_BR_PMD_CONTROL(priv->node, priv->bgx, priv->index));
+	data |= BIT(1);
+	oct_csr_write(data, BGX_SPU_BR_PMD_CONTROL(priv->node, priv->bgx, priv->index));
+	udelay(1);
+
+	data = oct_csr_read(BGX_SPU_BR_PMD_CONTROL(priv->node, priv->bgx, priv->index));
+	data |= BIT(0);
+	oct_csr_write(data, BGX_SPU_BR_PMD_CONTROL(priv->node, priv->bgx, priv->index));
+}
+
+static int bgx_port_gser_27882(struct bgx_port_priv *priv)
+{
+	u64	data;
+	u64	addr;
+	int	timeout;
+
+	timeout = 200;
+	do {
+		data = oct_csr_read(GSER_RX_EIE_DETSTS(priv->node, priv->qlm));
+		if (data & (1 << (priv->index + 8)))
+			break;
+		timeout--;
+		udelay(1);
+	} while (timeout);
+	if (!timeout)
+		return -1;
+
+	addr = GSER_LANE_PCS_CTLIFC_0(priv->node, priv->qlm, priv->index);
+	data = oct_csr_read(addr);
+	data |= BIT(12);
+	oct_csr_write(data, addr);
+
+	addr = GSER_LANE_PCS_CTLIFC_2(priv->node, priv->qlm, priv->index);
+	data = oct_csr_read(addr);
+	data |= BIT(7);
+	oct_csr_write(data, addr);
+
+	data = oct_csr_read(addr);
+	data |= BIT(15);
+	oct_csr_write(data, addr);
+
+	data = oct_csr_read(addr);
+	data &= ~BIT(7);
+	oct_csr_write(data, addr);
+
+	data = oct_csr_read(addr);
+	data |= BIT(15);
+	oct_csr_write(data, addr);
+
+	return 0;
+}
+
+static void bgx_port_xaui_restart_training(struct bgx_port_priv *priv)
+{
+	u64	data;
+
+	data = BIT(14) | BIT(13);
+	oct_csr_write(data, BGX_SPU_INT(priv->node, priv->bgx, priv->index));
+	usleep_range(1700, 2000);
+
+	/* BGX-20968 */
+	oct_csr_write(0, BGX_SPU_BR_PMD_LP_CUP(priv->node, priv->bgx, priv->index));
+	oct_csr_write(0, BGX_SPU_BR_PMD_LD_CUP(priv->node, priv->bgx, priv->index));
+	oct_csr_write(0, BGX_SPU_BR_PMD_LD_REP(priv->node, priv->bgx, priv->index));
+
+	/* Restart training */
+	data = oct_csr_read(BGX_SPU_BR_PMD_CONTROL(priv->node, priv->bgx, priv->index));
+	data |= BIT(0);
+	oct_csr_write(data, BGX_SPU_BR_PMD_CONTROL(priv->node, priv->bgx, priv->index));
+}
+
+static int bgx_port_get_max_qlm_lanes(int qlm)
+{
+	if (OCTEON_IS_MODEL(OCTEON_CN73XX))
+		return (qlm < 4) ? 4 : 2;
+	else if (OCTEON_IS_MODEL(OCTEON_CNF75XX))
+		return 2;
+	return 4;
+}
+
+static int bgx_port_qlm_rx_equalization(struct bgx_port_priv *priv, int qlm, int lane)
+{
+	u64	data;
+	u64	addr;
+	u64	lmode;
+	int	max_lanes = bgx_port_get_max_qlm_lanes(qlm);
+	int	lane_mask = lane == -1 ? ((1 << max_lanes) - 1) : (1 << lane);
+	int	timeout;
+	int	i;
+	int	rc = 0;
+
+	/* Nothing to do for qlms in reset */
+	data = oct_csr_read(GSER_PHY_CTL(priv->node, qlm));
+	if (data & (BIT(0) | BIT(1)))
+		return -1;
+
+	for (i = 0; i < max_lanes; i++) {
+		if (!(i & lane_mask))
+			continue;
+
+		addr = GSER_LANE_LBERT_CFG(priv->node, qlm, i);
+		data = oct_csr_read(addr);
+		/* Rx equalization can't be completed while pattern matcher is
+		 * enabled because it causes errors.
+		 */
+		if (data & BIT(6))
+			return -1;
+	}
+
+	lmode = oct_csr_read(GSER_LANE_MODE(priv->node, qlm));
+	lmode &= 0xf;
+	addr = GSER_LANE_P_MODE_1(priv->node, qlm, lmode);
+	data = oct_csr_read(addr);
+	/* Don't complete rx equalization if in VMA manual mode */
+	if (data & BIT(14))
+		return 0;
+
+	/* Apply rx equalization for speed > 6250 */
+	if (bgx_port_get_qlm_speed(priv, qlm) < 6250)
+		return 0;
+
+	/* Wait until rx data is valid (CDRLOCK) */
+	timeout = 500;
+	addr = GSER_RX_EIE_DETSTS(priv->node, qlm);
+	do {
+		data = oct_csr_read(addr);
+		data >>= 8;
+		data &= lane_mask;
+		if (data == lane_mask)
+			break;
+		timeout--;
+		udelay(1);
+	} while (timeout);
+	if (!timeout) {
+		pr_debug("QLM%d:%d: CDRLOCK timeout\n", qlm, priv->node);
+		return -1;
+	}
+
+	bgx_port_gser_20075(priv, qlm, lane);
+
+	for (i = 0; i < max_lanes; i++) {
+		if (!(i & lane_mask))
+			continue;
+		/* Skip lane 3 on 78p1.x due to gser-20075. Handled above */
+		if (OCTEON_IS_MODEL(OCTEON_CN78XX_PASS1_X) && i == 3)
+			continue;
+
+		/* Enable software control */
+		addr = GSER_BR_RX_CTL(priv->node, qlm, i);
+		data = oct_csr_read(addr);
+		data |= BIT(2);
+		oct_csr_write(data, addr);
+
+		/* Clear the completion flag */
+		addr = GSER_BR_RX_EER(priv->node, qlm, i);
+		data = oct_csr_read(addr);
+		data &= ~BIT(14);
+		data |= BIT(15);
+		oct_csr_write(data, addr);
+	}
+
+	/* Wait for rx equalization to complete */
+	for (i = 0; i < max_lanes; i++) {
+		if (!(i & lane_mask))
+			continue;
+
+		timeout = 250000;
+		addr = GSER_BR_RX_EER(priv->node, qlm, i);
+		do {
+			data = oct_csr_read(addr);
+			if (data & BIT(14))
+				break;
+			timeout--;
+			udelay(1);
+		} while (timeout);
+		if (!timeout) {
+			pr_debug("QLM%d:%d: RXT_ESV timeout\n",
+				 qlm, priv->node);
+			rc = -1;
+		}
+
+		/* Switch back to hardware control */
+		addr = GSER_BR_RX_CTL(priv->node, qlm, i);
+		data = oct_csr_read(addr);
+		data &= ~BIT(2);
+		oct_csr_write(data, addr);
+	}
+
+	return rc;
+}
+
+static int bgx_port_xaui_equalization(struct bgx_port_priv *priv)
+{
+	u64	data;
+	int	lane;
+
+	/* Nothing to do for loopback mode */
+	data = oct_csr_read(BGX_SPU_CONTROL1(priv->node, priv->bgx,
+					     priv->index));
+	if (data & BIT(14))
+		return 0;
+
+	if (priv->mode == PORT_MODE_XAUI || priv->mode == PORT_MODE_XLAUI) {
+		if (bgx_port_qlm_rx_equalization(priv, priv->qlm, -1))
+			return -1;
+
+		/* BGX2 of 73xx uses 2 dlms */
+		if (OCTEON_IS_MODEL(OCTEON_CN73XX) && priv->bgx == 2) {
+			if (bgx_port_qlm_rx_equalization(priv, priv->qlm + 1, -1))
+				return -1;
+		}
+	} else if (priv->mode == PORT_MODE_RXAUI) {
+		/* Rxaui always uses 2 lanes */
+		if (bgx_port_qlm_rx_equalization(priv, priv->qlm, -1))
+			return -1;
+	} else if (priv->mode == PORT_MODE_XFI) {
+		lane = priv->index;
+		if ((OCTEON_IS_MODEL(OCTEON_CN73XX) && priv->qlm == 6) ||
+		    (OCTEON_IS_MODEL(OCTEON_CNF75XX) && priv->qlm == 5))
+			lane -= 2;
+
+		if (bgx_port_qlm_rx_equalization(priv, priv->qlm, lane))
+			return -1;
+	}
+
+	return 0;
+}
+
+static int bgx_port_init_xaui_link(struct bgx_port_priv *priv)
+{
+	u64	data;
+	int	use_training = 0;
+	int	use_ber = 0;
+	int	timeout;
+	int	rc = 0;
+
+	if (priv->mode == PORT_MODE_10G_KR || priv->mode == PORT_MODE_40G_KR4)
+		use_training = 1;
+
+	if (!octeon_is_simulation() &&
+	    (priv->mode == PORT_MODE_XFI || priv->mode == PORT_MODE_XLAUI ||
+	     priv->mode == PORT_MODE_10G_KR || priv->mode == PORT_MODE_40G_KR4))
+		use_ber = 1;
+
+	data = oct_csr_read(BGX_CMR_CONFIG(priv->node, priv->bgx, priv->index));
+	data &= ~(BIT(14) | BIT(13));
+	oct_csr_write(data, BGX_CMR_CONFIG(priv->node, priv->bgx, priv->index));
+
+	data = oct_csr_read(BGX_SPU_MISC_CONTROL(priv->node, priv->bgx, priv->index));
+	data |= BIT(12);
+	oct_csr_write(data, BGX_SPU_MISC_CONTROL(priv->node, priv->bgx, priv->index));
+
+	if (!octeon_is_simulation()) {
+		data = oct_csr_read(BGX_SPU_AN_CONTROL(priv->node, priv->bgx, priv->index));
+		/* Restart autonegotiation */
+		if (data & BIT(12)) {
+			rc = bgx_port_init_xaui_an(priv);
+			if (rc)
+				return rc;
+		}
+
+		if (use_training) {
+			data = oct_csr_read(BGX_SPU_BR_PMD_CONTROL(priv->node, priv->bgx, priv->index));
+			/* Check if training is enabled */
+			if (OCTEON_IS_MODEL(OCTEON_CN78XX_PASS1_X) &&
+			    !(data & BIT(1))) {
+				bgx_port_xaui_start_training(priv);
+				return -1;
+			}
+
+			if (OCTEON_IS_MODEL(OCTEON_CN73XX) ||
+			    OCTEON_IS_MODEL(OCTEON_CNF75XX) ||
+			    OCTEON_IS_MODEL(OCTEON_CN78XX))
+				bgx_port_gser_27882(priv);
+
+			data = oct_csr_read(BGX_SPU_INT(priv->node, priv->bgx, priv->index));
+
+			/* Restart training if it failed */
+			if ((data & BIT(14)) &&
+			    !OCTEON_IS_MODEL(OCTEON_CN78XX_PASS1_X)) {
+				bgx_port_xaui_restart_training(priv);
+				return -1;
+			}
+
+			if (!(data & BIT(13))) {
+				pr_debug("Waiting for link training\n");
+				return -1;
+			}
+		} else {
+			bgx_port_xaui_equalization(priv);
+		}
+
+		/* Wait until the reset is complete */
+		timeout = 10000;
+		do {
+			data = oct_csr_read(BGX_SPU_CONTROL1(priv->node, priv->bgx, priv->index));
+			if (!(data & BIT(15)))
+				break;
+			timeout--;
+			udelay(1);
+		} while (timeout);
+		if (!timeout) {
+			pr_debug("BGX%d:%d:%d: Reset timeout\n", priv->bgx,
+				 priv->index, priv->node);
+			return -1;
+		}
+
+		if (use_ber) {
+			timeout = 10000;
+			do {
+				data =
+				oct_csr_read(BGX_SPU_BR_STATUS1(priv->node, priv->bgx, priv->index));
+				if (data & BIT(0))
+					break;
+				timeout--;
+				udelay(1);
+			} while (timeout);
+			if (!timeout) {
+				pr_debug("BGX%d:%d:%d: BLK_LOCK timeout\n",
+					 priv->bgx, priv->index, priv->node);
+				return -1;
+			}
+		} else {
+			timeout = 10000;
+			do {
+				data =
+				oct_csr_read(BGX_SPU_BX_STATUS(priv->node, priv->bgx, priv->index));
+				if (data & BIT(12))
+					break;
+				timeout--;
+				udelay(1);
+			} while (timeout);
+			if (!timeout) {
+				pr_debug("BGX%d:%d:%d: Lanes align timeout\n",
+					 priv->bgx, priv->index, priv->node);
+				return -1;
+			}
+		}
+
+		if (use_ber) {
+			data = oct_csr_read(BGX_SPU_BR_STATUS2(priv->node, priv->bgx, priv->index));
+			data |= BIT(15);
+			oct_csr_write(data, BGX_SPU_BR_STATUS2(priv->node, priv->bgx, priv->index));
+		}
+
+		data = oct_csr_read(BGX_SPU_STATUS2(priv->node, priv->bgx, priv->index));
+		data |= BIT(10);
+		oct_csr_write(data, BGX_SPU_STATUS2(priv->node, priv->bgx, priv->index));
+
+		data = oct_csr_read(BGX_SPU_STATUS2(priv->node, priv->bgx, priv->index));
+		if (data & BIT(10)) {
+			if (OCTEON_IS_MODEL(OCTEON_CN78XX_PASS1_X) &&
+			    use_training)
+				bgx_port_xaui_restart_training(priv);
+			return -1;
+		}
+
+		/* Wait for mac rx to be ready */
+		timeout = 10000;
+		do {
+			data = oct_csr_read(BGX_SMU_RX_CTL(priv->node, priv->bgx, priv->index));
+			data &= GENMASK_ULL(1, 0);
+			if (!data)
+				break;
+			timeout--;
+			udelay(1);
+		} while (timeout);
+		if (!timeout) {
+			pr_debug("BGX%d:%d:%d: mac ready timeout\n",
+				 priv->bgx, priv->index, priv->node);
+			return -1;
+		}
+
+		/* Wait for bgx rx to be idle */
+		timeout = 10000;
+		do {
+			data = oct_csr_read(BGX_SMU_CTRL(priv->node, priv->bgx, priv->index));
+			if (data & BIT(0))
+				break;
+			timeout--;
+			udelay(1);
+		} while (timeout);
+		if (!timeout) {
+			pr_debug("BGX%d:%d:%d: rx idle timeout\n",
+				 priv->bgx, priv->index, priv->node);
+			return -1;
+		}
+
+		/* Wait for gmx tx to be idle */
+		timeout = 10000;
+		do {
+			data = oct_csr_read(BGX_SMU_CTRL(priv->node, priv->bgx, priv->index));
+			if (data & BIT(1))
+				break;
+			timeout--;
+			udelay(1);
+		} while (timeout);
+		if (!timeout) {
+			pr_debug("BGX%d:%d:%d: tx idle timeout\n",
+				 priv->bgx, priv->index, priv->node);
+			return -1;
+		}
+
+		/* Check rcvflt is still be 0 */
+		data = oct_csr_read(BGX_SPU_STATUS2(priv->node, priv->bgx, priv->index));
+		if (data & BIT(10)) {
+			pr_debug("BGX%d:%d:%d: receive fault\n",
+				 priv->bgx, priv->index, priv->node);
+			return -1;
+		}
+
+		/* Receive link is latching low. Force it high and verify it */
+		data = oct_csr_read(BGX_SPU_STATUS1(priv->node, priv->bgx, priv->index));
+		data |= BIT(2);
+		oct_csr_write(data, BGX_SPU_STATUS1(priv->node, priv->bgx, priv->index));
+		timeout = 10000;
+		do {
+			data = oct_csr_read(BGX_SPU_STATUS1(priv->node, priv->bgx, priv->index));
+			if (data & BIT(2))
+				break;
+			timeout--;
+			udelay(1);
+		} while (timeout);
+		if (!timeout) {
+			pr_debug("BGX%d:%d:%d: rx link down\n",
+				 priv->bgx, priv->index, priv->node);
+			return -1;
+		}
+	}
+
+	if (use_ber) {
+		/* Read error counters to clear */
+		data = oct_csr_read(BGX_SPU_BR_BIP_ERR_CNT(priv->node, priv->bgx, priv->index));
+		data = oct_csr_read(BGX_SPU_BR_STATUS2(priv->node, priv->bgx, priv->index));
+
+		/* Verify latch lock is set */
+		if (!(data & BIT(15))) {
+			pr_debug("BGX%d:%d:%d: latch lock lost\n",
+				 priv->bgx, priv->index, priv->node);
+			return -1;
+		}
+
+		/* LATCHED_BER is cleared by writing 1 to it */
+		if (data & BIT(14))
+			oct_csr_write(data, BGX_SPU_BR_STATUS2(priv->node, priv->bgx, priv->index));
+
+		usleep_range(1500, 2000);
+		data = oct_csr_read(BGX_SPU_BR_STATUS2(priv->node, priv->bgx, priv->index));
+		if (data & BIT(14)) {
+			pr_debug("BGX%d:%d:%d: BER test failed\n",
+				 priv->bgx, priv->index, priv->node);
+			return -1;
+		}
+	}
+
+	/* Enable packet transmit and receive */
+	data = oct_csr_read(BGX_SPU_MISC_CONTROL(priv->node, priv->bgx, priv->index));
+	data &= ~BIT(12);
+	oct_csr_write(data, BGX_SPU_MISC_CONTROL(priv->node, priv->bgx, priv->index));
+	data = oct_csr_read(BGX_CMR_CONFIG(priv->node, priv->bgx, priv->index));
+	data |= BIT(14) | BIT(13);
+	oct_csr_write(data, BGX_CMR_CONFIG(priv->node, priv->bgx, priv->index));
+
+	return 0;
+}
+
+static int bgx_port_set_xaui_link(struct bgx_port_priv *priv,
+				  struct port_status status)
+{
+	u64	data;
+	bool	smu_tx_ok = false;
+	bool	smu_rx_ok = false;
+	bool	spu_link_ok = false;
+	int	rc = 0;
+
+	/* Initialize hardware if link is up but hardware is not happy */
+	if (status.link) {
+		data = oct_csr_read(BGX_SMU_TX_CTL(priv->node, priv->bgx, priv->index));
+		data &= GENMASK_ULL(5, 4);
+		smu_tx_ok = data == 0;
+
+		data = oct_csr_read(BGX_SMU_RX_CTL(priv->node, priv->bgx, priv->index));
+		data &= GENMASK_ULL(1, 0);
+		smu_rx_ok = data == 0;
+
+		data = oct_csr_read(BGX_SPU_STATUS1(priv->node, priv->bgx, priv->index));
+		data &= BIT(2);
+		spu_link_ok = data == BIT(2);
+
+		if (!smu_tx_ok || !smu_rx_ok || !spu_link_ok)
+			rc = bgx_port_init_xaui_link(priv);
+	}
+
+	return rc;
+}
+
+static struct bgx_port_priv *bgx_port_netdev2priv(struct net_device *netdev)
+{
+	struct bgx_port_netdev_priv *nd_priv = netdev_priv(netdev);
+
+	return nd_priv->bgx_priv;
+}
+
+void bgx_port_set_netdev(struct device *dev, struct net_device *netdev)
+{
+	struct bgx_port_priv *priv = dev_get_drvdata(dev);
+
+	if (netdev) {
+		struct bgx_port_netdev_priv *nd_priv = netdev_priv(netdev);
+
+		nd_priv->bgx_priv = priv;
+	}
+
+	priv->netdev = netdev;
+}
+EXPORT_SYMBOL(bgx_port_set_netdev);
+
+int bgx_port_ethtool_get_link_ksettings(struct net_device *netdev,
+					struct ethtool_link_ksettings *cmd)
+{
+	struct bgx_port_priv	*priv = bgx_port_netdev2priv(netdev);
+
+	if (priv->phydev) {
+		phy_ethtool_ksettings_get(priv->phydev, cmd);
+		return 0;
+	}
+	return -EINVAL;
+}
+EXPORT_SYMBOL(bgx_port_ethtool_get_link_ksettings);
+
+int bgx_port_ethtool_set_settings(struct net_device	*netdev,
+				  struct ethtool_cmd	*cmd)
+{
+	struct bgx_port_priv *p = bgx_port_netdev2priv(netdev);
+
+	if (p->phydev)
+		return phy_ethtool_sset(p->phydev, cmd);
+
+	return -EOPNOTSUPP;
+}
+EXPORT_SYMBOL(bgx_port_ethtool_set_settings);
+
+int bgx_port_ethtool_nway_reset(struct net_device *netdev)
+{
+	struct bgx_port_priv *p = bgx_port_netdev2priv(netdev);
+
+	if (p->phydev)
+		return phy_start_aneg(p->phydev);
+
+	return -EOPNOTSUPP;
+}
+EXPORT_SYMBOL(bgx_port_ethtool_nway_reset);
+
+const u8 *bgx_port_get_mac(struct net_device *netdev)
+{
+	struct bgx_port_priv *priv = bgx_port_netdev2priv(netdev);
+
+	return priv->mac_addr;
+}
+EXPORT_SYMBOL(bgx_port_get_mac);
+
+int bgx_port_do_ioctl(struct net_device *netdev, struct ifreq *ifr, int cmd)
+{
+	struct bgx_port_priv *p = bgx_port_netdev2priv(netdev);
+
+	if (p->phydev)
+		return phy_mii_ioctl(p->phydev, ifr, cmd);
+	return -EOPNOTSUPP;
+}
+EXPORT_SYMBOL(bgx_port_do_ioctl);
+
+static void bgx_port_write_cam(struct bgx_port_priv	*priv,
+			       int			cam,
+			       const u8			*mac)
+{
+	u64	m = 0;
+	int	i;
+
+	if (mac) {
+		for (i = 0; i < 6; i++)
+			m |= (((u64)mac[i]) << ((5 - i) * 8));
+		m |= BIT(48);
+	}
+
+	m |= (u64)priv->index << 52;
+	oct_csr_write(m, BGX_CMR_RX_ADRX_CAM(priv->node, priv->bgx, priv->index * 8 + cam));
+}
+
+/* Set MAC address for the net_device that is attached. */
+void bgx_port_set_rx_filtering(struct net_device *netdev)
+{
+	u64	data;
+	struct bgx_port_priv *priv = bgx_port_netdev2priv(netdev);
+	int available_cam_entries, current_cam_entry;
+	struct netdev_hw_addr *ha;
+
+	available_cam_entries = 8;
+	data = 0;
+	data |= BIT(0); /* Accept all Broadcast*/
+
+	if ((netdev->flags & IFF_PROMISC) || netdev->uc.count > 7) {
+		data &= ~BIT(3); /* Reject CAM match */
+		available_cam_entries = 0;
+	} else {
+		/* One CAM entry for the primary address, leaves seven
+		 * for the secondary addresses.
+		 */
+		data |= BIT(3); /* Accept CAM match */
+		available_cam_entries = 7 - netdev->uc.count;
+	}
+
+	if (netdev->flags & IFF_PROMISC) {
+		data |= 1 << 1; /* Accept all Multicast */
+	} else {
+		if (netdev->flags & IFF_MULTICAST) {
+			if ((netdev->flags & IFF_ALLMULTI) ||
+			    netdev_mc_count(netdev) > available_cam_entries)
+				data |= 1 << 1; /* Accept all Multicast */
+			else
+				data |= 2 << 1; /* Accept all Mcast via CAM */
+		}
+	}
+	current_cam_entry = 0;
+	if (data & BIT(3)) {
+		bgx_port_write_cam(priv, current_cam_entry, netdev->dev_addr);
+		current_cam_entry++;
+		netdev_for_each_uc_addr(ha, netdev) {
+			bgx_port_write_cam(priv, current_cam_entry, ha->addr);
+			current_cam_entry++;
+		}
+	}
+	if (((data & GENMASK_ULL(2, 1)) >> 1) == 2) {
+		/* Accept all Multicast via CAM */
+		netdev_for_each_mc_addr(ha, netdev) {
+			bgx_port_write_cam(priv, current_cam_entry, ha->addr);
+			current_cam_entry++;
+		}
+	}
+	while (current_cam_entry < 8) {
+		bgx_port_write_cam(priv, current_cam_entry, NULL);
+		current_cam_entry++;
+	}
+	oct_csr_write(data, BGX_CMR_RX_ADR_CTL(priv->node, priv->bgx,
+					       priv->index));
+}
+EXPORT_SYMBOL(bgx_port_set_rx_filtering);
+
+static void bgx_port_adjust_link(struct net_device *netdev)
+{
+	struct bgx_port_priv	*priv = bgx_port_netdev2priv(netdev);
+	bool			link_changed = false;
+	unsigned int		link;
+	unsigned int		speed;
+	unsigned int		duplex;
+
+	mutex_lock(&priv->lock);
+
+	if (!priv->phydev->link && priv->last_status.link)
+		link_changed = true;
+
+	if (priv->phydev->link &&
+	    (priv->last_status.link != priv->phydev->link ||
+	     priv->last_status.duplex != priv->phydev->duplex ||
+	     priv->last_status.speed != priv->phydev->speed))
+		link_changed = true;
+
+	link = priv->phydev->link;
+	priv->last_status.link = priv->phydev->link;
+
+	speed = priv->phydev->speed;
+	priv->last_status.speed = priv->phydev->speed;
+
+	duplex = priv->phydev->duplex;
+	priv->last_status.duplex = priv->phydev->duplex;
+
+	mutex_unlock(&priv->lock);
+
+	if (link_changed) {
+		struct port_status status;
+
+		phy_print_status(priv->phydev);
+
+		status.link = link ? 1 : 0;
+		status.duplex = duplex;
+		status.speed = speed;
+		if (!link)
+			/* Let TX drain. FIXME check that it is drained. */
+			mdelay(50);
+		priv->set_link(priv, status);
+	}
+}
+
+static void bgx_port_check_state(struct work_struct *work)
+{
+	struct bgx_port_priv	*priv;
+	struct port_status	status;
+
+	priv = container_of(work, struct bgx_port_priv, dwork.work);
+
+	status = priv->get_link(priv);
+
+	if (!status.link &&
+	    priv->mode != PORT_MODE_SGMII && priv->mode != PORT_MODE_RGMII)
+		bgx_port_init_xaui_link(priv);
+
+	/* Only used when there is no phy device, so we cannot use
+	 * phy_print_status() here.
+	 */
+	if (priv->last_status.link != status.link) {
+		priv->last_status.link = status.link;
+		if (status.link)
+			netdev_info(priv->netdev, "Link is up - %d/%s\n",
+				    status.speed,
+				    status.duplex == DUPLEX_FULL ? "Full" : "Half");
+		else
+			netdev_info(priv->netdev, "Link is down\n");
+	}
+
+	mutex_lock(&priv->lock);
+	if (priv->work_queued)
+		queue_delayed_work(check_state_wq, &priv->dwork, HZ);
+	mutex_unlock(&priv->lock);
+}
+
+int bgx_port_enable(struct net_device *netdev)
+{
+	struct bgx_port_priv	*priv = bgx_port_netdev2priv(netdev);
+	u64			data;
+	struct port_status	status;
+	bool			dont_use_phy;
+
+	if (priv->mode == PORT_MODE_SGMII || priv->mode == PORT_MODE_RGMII) {
+		/* 1G */
+		data = oct_csr_read(BGX_GMP_GMI_TX_APPEND(priv->node, priv->bgx, priv->index));
+		data |= BIT(2) | BIT(1);
+		oct_csr_write(data, BGX_GMP_GMI_TX_APPEND(priv->node, priv->bgx, priv->index));
+
+		/* Packets are padded (without FCS) to MIN_SIZE + 1 in SGMII */
+		data = 60 - 1;
+		oct_csr_write(data, BGX_GMP_GMI_TX_MIN_PKT(priv->node, priv->bgx, priv->index));
+	} else {
+		/* 10G or higher */
+		data = oct_csr_read(BGX_SMU_TX_APPEND(priv->node, priv->bgx, priv->index));
+		data |= BIT(2) | BIT(1);
+		oct_csr_write(data, BGX_SMU_TX_APPEND(priv->node, priv->bgx, priv->index));
+
+		/* Packets are padded(with FCS) to MIN_SIZE  in non-SGMII */
+		data = 60 + 4;
+		oct_csr_write(data, BGX_SMU_TX_MIN_PKT(priv->node, priv->bgx, priv->index));
+	}
+
+	switch (priv->mode) {
+	case PORT_MODE_XLAUI:
+	case PORT_MODE_XFI:
+	case PORT_MODE_10G_KR:
+	case PORT_MODE_40G_KR4:
+		dont_use_phy = true;
+		break;
+	default:
+		dont_use_phy = false;
+		break;
+	}
+
+	if (!priv->phy_np || dont_use_phy) {
+		status = priv->get_link(priv);
+		priv->set_link(priv, status);
+		netif_carrier_on(netdev);
+
+		mutex_lock(&check_state_wq_mutex);
+		if (!check_state_wq) {
+			check_state_wq =
+				alloc_workqueue("check_state_wq", WQ_UNBOUND | WQ_MEM_RECLAIM, 1);
+		}
+		mutex_unlock(&check_state_wq_mutex);
+		if (!check_state_wq)
+			return -ENOMEM;
+
+		mutex_lock(&priv->lock);
+		INIT_DELAYED_WORK(&priv->dwork, bgx_port_check_state);
+		queue_delayed_work(check_state_wq, &priv->dwork, 0);
+		priv->work_queued = true;
+		mutex_unlock(&priv->lock);
+
+		netdev_info(priv->netdev, "Link is not ready\n");
+
+	} else {
+		priv->phydev = of_phy_connect(netdev, priv->phy_np,
+					      bgx_port_adjust_link, 0, priv->phy_mode);
+		if (!priv->phydev)
+			return -ENODEV;
+
+		netif_carrier_off(netdev);
+		phy_start_aneg(priv->phydev);
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(bgx_port_enable);
+
+int bgx_port_disable(struct net_device *netdev)
+{
+	struct bgx_port_priv	*priv = bgx_port_netdev2priv(netdev);
+	struct port_status	status;
+
+	if (priv->phydev) {
+		phy_stop(priv->phydev);
+		phy_disconnect(priv->phydev);
+	}
+	priv->phydev = NULL;
+
+	netif_carrier_off(netdev);
+	memset(&status, 0, sizeof(status));
+	priv->last_status.link = 0;
+	priv->set_link(priv, status);
+
+	mutex_lock(&priv->lock);
+	if (priv->work_queued) {
+		cancel_delayed_work_sync(&priv->dwork);
+		priv->work_queued = false;
+	}
+	mutex_unlock(&priv->lock);
+
+	return 0;
+}
+EXPORT_SYMBOL(bgx_port_disable);
+
+int bgx_port_change_mtu(struct net_device *netdev, int new_mtu)
+{
+	struct bgx_port_priv *priv = bgx_port_netdev2priv(netdev);
+	int max_frame;
+
+	netdev->mtu = new_mtu;
+
+	max_frame = round_up(new_mtu + ETH_HLEN + ETH_FCS_LEN, 8);
+
+	if (priv->mode == PORT_MODE_SGMII || priv->mode == PORT_MODE_RGMII) {
+		/* 1G */
+		oct_csr_write(max_frame, BGX_GMP_GMI_RX_JABBER(priv->node, priv->bgx, priv->index));
+	} else {
+		/* 10G or higher */
+		oct_csr_write(max_frame, BGX_SMU_RX_JABBER(priv->node, priv->bgx, priv->index));
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(bgx_port_change_mtu);
+
+void bgx_port_mix_assert_reset(struct net_device *netdev, int mix, bool v)
+{
+	struct bgx_port_priv *priv = bgx_port_netdev2priv(netdev);
+	u64 mask = 1ull << (3 + (mix & 1));
+	u64 data;
+
+	if (OCTEON_IS_MODEL(OCTEON_CN78XX_PASS1_X) && v) {
+		/* Need to disable the mix before resetting the bgx-mix
+		 * interface as not doing so confuses the other already up
+		 * lmacs.
+		 */
+		data = oct_csr_read(BGX_CMR_CONFIG(priv->node, priv->bgx, priv->index));
+		data &= ~BIT(11);
+		oct_csr_write(data, BGX_CMR_CONFIG(priv->node, priv->bgx, priv->index));
+	}
+
+	data = oct_csr_read(BGX_CMR_GLOBAL_CONFIG(priv->node, priv->bgx));
+	if (v)
+		data |= mask;
+	else
+		data &= ~mask;
+	oct_csr_write(data, BGX_CMR_GLOBAL_CONFIG(priv->node, priv->bgx));
+
+	if (OCTEON_IS_MODEL(OCTEON_CN78XX_PASS1_X) && !v) {
+		data = oct_csr_read(BGX_CMR_CONFIG(priv->node, priv->bgx, priv->index));
+		data |= BIT(11);
+		oct_csr_write(data, BGX_CMR_CONFIG(priv->node, priv->bgx, priv->index));
+	}
+}
+EXPORT_SYMBOL(bgx_port_mix_assert_reset);
+
+static int bgx_port_probe(struct platform_device *pdev)
+{
+	u64 addr;
+	const u8 *mac;
+	const __be32 *reg;
+	u32 index;
+	int rc;
+	struct bgx_port_priv *priv;
+	int numa_node;
+
+	reg = of_get_property(pdev->dev.parent->of_node, "reg", NULL);
+	addr = of_translate_address(pdev->dev.parent->of_node, reg);
+	mac = of_get_mac_address(pdev->dev.of_node);
+
+	numa_node = bgx_node_to_numa_node(pdev->dev.parent->of_node);
+
+	rc = of_property_read_u32(pdev->dev.of_node, "reg", &index);
+	if (rc)
+		return -ENODEV;
+	priv = kzalloc_node(sizeof(*priv), GFP_KERNEL, numa_node);
+	if (!priv)
+		return -ENOMEM;
+	priv->phy_np = of_parse_phandle(pdev->dev.of_node, "phy-handle", 0);
+	priv->phy_mode = of_get_phy_mode(pdev->dev.of_node);
+	/* If phy-mode absent, default to SGMII. */
+	if (priv->phy_mode < 0)
+		priv->phy_mode = PHY_INTERFACE_MODE_SGMII;
+
+	if (priv->phy_mode == PHY_INTERFACE_MODE_1000BASEX)
+		priv->mode_1000basex = true;
+
+	if (of_phy_is_fixed_link(pdev->dev.of_node))
+		priv->bgx_as_phy = true;
+
+	mutex_init(&priv->lock);
+	priv->node = numa_node;
+	priv->bgx = bgx_addr_to_interface(addr);
+	priv->index = index;
+	if (mac)
+		priv->mac_addr = mac;
+
+	priv->qlm = bgx_port_get_qlm(priv->node, priv->bgx, priv->index);
+	priv->mode = bgx_port_get_mode(priv->node, priv->bgx, priv->index);
+
+	switch (priv->mode) {
+	case PORT_MODE_SGMII:
+		if (priv->phy_np &&
+		    priv->phy_mode != PHY_INTERFACE_MODE_SGMII)
+			dev_warn(&pdev->dev, "SGMII phy mode mismatch.\n");
+		goto set_link_functions;
+	case PORT_MODE_RGMII:
+		if (priv->phy_np && phy_interface_mode_is_rgmii(priv->phy_mode))
+			dev_warn(&pdev->dev, "RGMII phy mode mismatch.\n");
+set_link_functions:
+		priv->get_link = bgx_port_get_sgmii_link;
+		priv->set_link = bgx_port_set_xgmii_link;
+		break;
+	case PORT_MODE_XAUI:
+	case PORT_MODE_RXAUI:
+	case PORT_MODE_XLAUI:
+	case PORT_MODE_XFI:
+	case PORT_MODE_10G_KR:
+	case PORT_MODE_40G_KR4:
+		priv->get_link = bgx_port_get_xaui_link;
+		priv->set_link = bgx_port_set_xaui_link;
+		break;
+	default:
+		goto err;
+	}
+
+	dev_set_drvdata(&pdev->dev, priv);
+
+	bgx_port_init(priv);
+
+	dev_info(&pdev->dev, "Probed\n");
+	return 0;
+ err:
+	kfree(priv);
+	return rc;
+}
+
+static int bgx_port_remove(struct platform_device *pdev)
+{
+	struct bgx_port_priv *priv = dev_get_drvdata(&pdev->dev);
+
+	kfree(priv);
+	return 0;
+}
+
+static void bgx_port_shutdown(struct platform_device *pdev)
+{
+}
+
+static const struct of_device_id bgx_port_match[] = {
+	{
+		.compatible = "cavium,octeon-7890-bgx-port",
+	},
+	{
+		.compatible = "cavium,octeon-7360-xcv",
+	},
+	{},
+};
+MODULE_DEVICE_TABLE(of, bgx_port_match);
+
+static struct platform_driver bgx_port_driver = {
+	.probe		= bgx_port_probe,
+	.remove		= bgx_port_remove,
+	.shutdown       = bgx_port_shutdown,
+	.driver		= {
+		.owner	= THIS_MODULE,
+		.name	= KBUILD_MODNAME,
+		.of_match_table = bgx_port_match,
+	},
+};
+
+static int __init bgx_port_driver_init(void)
+{
+	int r;
+	int i;
+	int j;
+	int k;
+
+	for (i = 0; i < MAX_NODES; i++) {
+		for (j = 0; j < MAX_BGX_PER_NODE; j++) {
+			for (k = 0; k < MAX_LMAC_PER_BGX; k++)
+				lmac_pknd[i][j][k] = -1;
+		}
+	}
+
+	bgx_nexus_load();
+	r =  platform_driver_register(&bgx_port_driver);
+	return r;
+}
+module_init(bgx_port_driver_init);
+
+static void __exit bgx_port_driver_exit(void)
+{
+	platform_driver_unregister(&bgx_port_driver);
+	if (check_state_wq)
+		destroy_workqueue(check_state_wq);
+}
+module_exit(bgx_port_driver_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Cavium, Inc. <support@caviumnetworks.com>");
+MODULE_DESCRIPTION("Cavium, Inc. BGX Ethernet MAC driver.");
diff --git a/drivers/net/ethernet/cavium/octeon/octeon3-core.c b/drivers/net/ethernet/cavium/octeon/octeon3-core.c
new file mode 100644
index 000000000000..7b0df1cecd36
--- /dev/null
+++ b/drivers/net/ethernet/cavium/octeon/octeon3-core.c
@@ -0,0 +1,2069 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2017 Cavium, Inc.
+ *
+ * Core packet processing and initialization for the octeon3_ethernet
+ * packet processor.  The packets are received, classified and initial
+ * input checks done by the PKI unit.  Input queuing is done by the
+ * SSO.  All output processing and hardware queuing is done in the
+ * PKO.
+ */
+#include <linux/module.h>
+#include <linux/wait.h>
+#include <linux/rculist.h>
+#include <linux/atomic.h>
+#include <linux/kthread.h>
+#include <linux/interrupt.h>
+#include <linux/netdevice.h>
+#include <linux/etherdevice.h>
+#include <linux/platform_device.h>
+#include <linux/ip.h>
+#include <linux/ipv6.h>
+#include <linux/if_vlan.h>
+#include <linux/rio_drv.h>
+#include <linux/rio_ids.h>
+#include <linux/net_tstamp.h>
+#include <linux/timecounter.h>
+#include <linux/ptp_clock_kernel.h>
+
+#include <asm/octeon/octeon.h>
+
+#include "octeon3.h"
+
+/*  First buffer:
+ *
+ *                            +---SKB---------+
+ *                            |               |
+ *                            |               |
+ *                         +--+--*data        |
+ *                         |  |               |
+ *                         |  |               |
+ *                         |  +---------------+
+ *                         |       /|\
+ *                         |        |
+ *                         |        |
+ *                        \|/       |
+ * WQE - 128 -+-----> +-------------+-------+     -+-
+ *            |       |    *skb ----+       |      |
+ *            |       |                     |      |
+ *            |       |                     |      |
+ *  WQE_SKIP = 128    |                     |      |
+ *            |       |                     |      |
+ *            |       |                     |      |
+ *            |       |                     |      |
+ *            |       |                     |      First Skip
+ * WQE   -----+-----> +---------------------+      |
+ *                    |   word 0            |      |
+ *                    |   word 1            |      |
+ *                    |   word 2            |      |
+ *                    |   word 3            |      |
+ *                    |   word 4            |      |
+ *                    +---------------------+     -+-
+ *               +----+- packet link        |
+ *               |    |  packet data        |
+ *               |    |                     |
+ *               |    |                     |
+ *               |    |         .           |
+ *               |    |         .           |
+ *               |    |         .           |
+ *               |    +---------------------+
+ *               |
+ *               |
+ * Later buffers:|
+ *               |
+ *               |
+ *               |
+ *               |
+ *               |
+ *               |            +---SKB---------+
+ *               |            |               |
+ *               |            |               |
+ *               |         +--+--*data        |
+ *               |         |  |               |
+ *               |         |  |               |
+ *               |         |  +---------------+
+ *               |         |       /|\
+ *               |         |        |
+ *               |         |        |
+ *               |        \|/       |
+ * WQE - 128 ----+--> +-------------+-------+     -+-
+ *               |    |    *skb ----+       |      |
+ *               |    |                     |      |
+ *               |    |                     |      |
+ *               |    |                     |      |
+ *               |    |                     |      LATER_SKIP = 128
+ *               |    |                     |      |
+ *               |    |                     |      |
+ *               |    |                     |      |
+ *               |    +---------------------+     -+-
+ *               |    |  packet link        |
+ *               +--> |  packet data        |
+ *                    |                     |
+ *                    |                     |
+ *                    |         .           |
+ *                    |         .           |
+ *                    |         .           |
+ *                    +---------------------+
+ */
+
+#define MAX_TX_QUEUE_DEPTH 512
+#define SSO_INTSN_EXE 0x61
+#define MAX_RX_QUEUES 32
+
+#define SKB_PTR_OFFSET		0
+
+#define MAX_CORES		48
+#define FPA3_NUM_AURAS		1024
+
+#define USE_ASYNC_IOBDMA	1
+#define SCR_SCRATCH		0ull
+#define SSO_NO_WAIT		0ull
+#define DID_TAG_SWTAG		0x60ull
+#define IOBDMA_SENDSINGLE	0xffffffffffffa200ull
+
+/* Values for the value of wqe word2 [ERRLEV] */
+#define PKI_ERRLEV_LA		0x01
+
+/* Values for the value of wqe word2 [OPCODE] */
+#define PKI_OPCODE_NONE		0x00
+#define PKI_OPCODE_JABBER	0x02
+#define PKI_OPCODE_FCS		0x07
+
+/* Values for the layer type in the wqe */
+#define PKI_LTYPE_IP4		0x08
+#define PKI_LTYPE_IP6		0x0a
+#define PKI_LTYPE_TCP		0x10
+#define PKI_LTYPE_UDP		0x11
+#define PKI_LTYPE_SCTP		0x12
+
+/* Registers are accessed via xkphys */
+#define SSO_BASE			0x1670000000000ull
+#define SSO_ADDR(node)			(SET_XKPHYS + NODE_OFFSET(node) +      \
+					 SSO_BASE)
+#define GRP_OFFSET(grp)			((grp) << 16)
+#define GRP_ADDR(n, g)			(SSO_ADDR(n) + GRP_OFFSET(g))
+#define SSO_GRP_AQ_CNT(n, g)		(GRP_ADDR(n, g)		   + 0x20000700)
+
+#define MIO_PTP_BASE			0x1070000000000ull
+#define MIO_PTP_ADDR(node)		(SET_XKPHYS + NODE_OFFSET(node) +      \
+					 MIO_PTP_BASE)
+#define MIO_PTP_CLOCK_CFG(node)		(MIO_PTP_ADDR(node)		+ 0xf00)
+#define MIO_PTP_CLOCK_HI(node)		(MIO_PTP_ADDR(node)		+ 0xf10)
+#define MIO_PTP_CLOCK_COMP(node)	(MIO_PTP_ADDR(node)		+ 0xf18)
+
+struct octeon3_ethernet;
+
+struct octeon3_rx {
+	struct napi_struct	napi;
+	struct octeon3_ethernet *parent;
+	int rx_grp;
+	int rx_irq;
+	cpumask_t rx_affinity_hint;
+} ____cacheline_aligned_in_smp;
+
+struct octeon3_ethernet {
+	struct bgx_port_netdev_priv bgx_priv; /* Must be first element. */
+	struct list_head list;
+	struct net_device *netdev;
+	enum octeon3_mac_type mac_type;
+	struct octeon3_rx rx_cxt[MAX_RX_QUEUES];
+	struct ptp_clock_info ptp_info;
+	struct ptp_clock *ptp_clock;
+	struct cyclecounter cc;
+	struct timecounter tc;
+	spinlock_t ptp_lock;		/* Serialize ptp clock adjustments */
+	int num_rx_cxt;
+	int pki_aura;
+	int pknd;
+	int pko_queue;
+	int node;
+	int interface;
+	int index;
+	int rx_buf_count;
+	int tx_complete_grp;
+	unsigned int rx_timestamp_hw:1;
+	unsigned int tx_timestamp_hw:1;
+	struct delayed_work stat_work;
+	spinlock_t stat_lock;		/* Protects stats counters */
+	u64 last_packets;
+	u64 last_octets;
+	u64 last_dropped;
+	atomic64_t rx_packets;
+	atomic64_t rx_octets;
+	atomic64_t rx_dropped;
+	atomic64_t rx_errors;
+	atomic64_t rx_length_errors;
+	atomic64_t rx_crc_errors;
+	atomic64_t tx_packets;
+	atomic64_t tx_octets;
+	atomic64_t tx_dropped;
+	/* The following two fields need to be on a different cache line as
+	 * they are updated by pko which invalidates the cache every time it
+	 * updates them. The idea is to prevent other fields from being
+	 * invalidated unnecessarily.
+	 */
+	char cacheline_pad1[CVMX_CACHE_LINE_SIZE];
+	atomic64_t buffers_needed;
+	atomic64_t tx_backlog;
+	char cacheline_pad2[CVMX_CACHE_LINE_SIZE];
+};
+
+static DEFINE_MUTEX(octeon3_eth_init_mutex);
+
+struct octeon3_ethernet_node;
+
+struct octeon3_ethernet_worker {
+	wait_queue_head_t queue;
+	struct task_struct *task;
+	struct octeon3_ethernet_node *oen;
+	atomic_t kick;
+	int order;
+};
+
+struct octeon3_ethernet_node {
+	bool init_done;
+	int next_cpu_irq_affinity;
+	int node;
+	int pki_packet_pool;
+	int sso_pool;
+	int pko_pool;
+	void *sso_pool_stack;
+	void *pko_pool_stack;
+	void *pki_packet_pool_stack;
+	int sso_aura;
+	int pko_aura;
+	int tx_complete_grp;
+	int tx_irq;
+	cpumask_t tx_affinity_hint;
+	struct octeon3_ethernet_worker workers[8];
+	struct mutex device_list_lock;	/* Protects the device list */
+	struct list_head device_list;
+	spinlock_t napi_alloc_lock;	/* Protects napi allocations */
+};
+
+static int num_packet_buffers = 768;
+module_param(num_packet_buffers, int, 0444);
+MODULE_PARM_DESC(num_packet_buffers,
+		 "Number of packet buffers to allocate per port.");
+
+int ilk0_lanes = 1;
+module_param(ilk0_lanes, int, 0444);
+MODULE_PARM_DESC(ilk0_lanes, "Number of SerDes lanes used by ILK link 0.");
+
+int ilk1_lanes = 1;
+module_param(ilk1_lanes, int, 0444);
+MODULE_PARM_DESC(ilk1_lanes, "Number of SerDes lanes used by ILK link 1.");
+
+static int rx_queues = 1;
+static int packet_buffer_size = 2048;
+
+static struct octeon3_ethernet_node octeon3_eth_node[MAX_NODES];
+static struct kmem_cache *octeon3_eth_sso_pko_cache;
+
+/**
+ * scratch_read64() - Read a 64 bit value from the processor local
+ *		      scratchpad memory.
+ *
+ * @offset: Byte offset into scratch pad to read.
+ *
+ * Return: The value read.
+ */
+static inline u64 scratch_read64(u64 offset)
+{
+	/* Barriers never needed for this CPU-local memory. */
+	return *(u64 *)((long)SCRATCH_BASE + offset);
+}
+
+/**
+ * scratch_write64() - Write a 64 bit value to the processor local
+ *		       scratchpad memory.
+ *
+ * @offset: Byte offset into scratch pad to write
+ * @value: Value to write
+ */
+static inline void scratch_write64(u64 offset, u64 value)
+{
+	/* Barriers never needed for this CPU-local memory. */
+	*(u64 *)((long)SCRATCH_BASE + offset) = value;
+}
+
+static int get_pki_chan(int node, int interface, int index)
+{
+	int	pki_chan;
+
+	pki_chan = node << 12;
+
+	if (OCTEON_IS_MODEL(OCTEON_CNF75XX) &&
+	    (interface == 1 || interface == 2)) {
+		/* SRIO */
+		pki_chan |= 0x240 + (2 * (interface - 1)) + index;
+	} else {
+		/* BGX */
+		pki_chan |= 0x800 + (0x100 * interface) + (0x10 * index);
+	}
+
+	return pki_chan;
+}
+
+static int octeon3_eth_lgrp_to_ggrp(int node, int grp)
+{
+	return (node << 8) | grp;
+}
+
+static void octeon3_eth_gen_affinity(int node, cpumask_t *mask)
+{
+	int cpu;
+
+	do {
+		cpu = cpumask_next(octeon3_eth_node[node].next_cpu_irq_affinity, cpu_online_mask);
+		octeon3_eth_node[node].next_cpu_irq_affinity++;
+		if (cpu >= nr_cpu_ids) {
+			octeon3_eth_node[node].next_cpu_irq_affinity = -1;
+			continue;
+		}
+	} while (false);
+	cpumask_clear(mask);
+	cpumask_set_cpu(cpu, mask);
+}
+
+struct wr_ret {
+	void *work;
+	u16 grp;
+};
+
+static inline struct wr_ret octeon3_core_get_work_sync(int grp)
+{
+	u64		node = cvmx_get_node_num();
+	u64		addr;
+	u64		response;
+	struct wr_ret	r;
+
+	/* See SSO_GET_WORK_LD_S for the address to read */
+	addr = 1ull << 63;
+	addr |= BIT(48);
+	addr |= DID_TAG_SWTAG << 40;
+	addr |= node << 36;
+	addr |= BIT(30);
+	addr |= BIT(29);
+	addr |= octeon3_eth_lgrp_to_ggrp(node, grp) << 4;
+	addr |= SSO_NO_WAIT << 3;
+	response = __raw_readq((void __iomem *)addr);
+
+	/* See SSO_GET_WORK_RTN_S for the format of the response */
+	r.grp = (response & GENMASK_ULL(57, 48)) >> 48;
+	if (response & BIT(63))
+		r.work = NULL;
+	else
+		r.work = phys_to_virt(response & GENMASK_ULL(41, 0));
+
+	return r;
+}
+
+/**
+ * octeon3_core_get_work_async() - Request work via a iobdma command.
+ *				   Doesn't wait for the response.
+ *
+ * @grp: Group to request work for.
+ */
+static inline void octeon3_core_get_work_async(unsigned int grp)
+{
+	u64	data;
+	u64	node = cvmx_get_node_num();
+
+	/* See SSO_GET_WORK_DMA_S for the command structure */
+	data = SCR_SCRATCH << 56;
+	data |= 1ull << 48;
+	data |= DID_TAG_SWTAG << 40;
+	data |= node << 36;
+	data |= 1ull << 30;
+	data |= 1ull << 29;
+	data |= octeon3_eth_lgrp_to_ggrp(node, grp) << 4;
+	data |= SSO_NO_WAIT << 3;
+
+	__raw_writeq(data, (void __iomem *)IOBDMA_SENDSINGLE);
+}
+
+/**
+ * octeon3_core_get_response_async() - Read the request work response. Must be
+ *				       called after calling
+ *				       octeon3_core_get_work_async().
+ *
+ * Return: Work queue entry.
+ */
+static inline struct wr_ret octeon3_core_get_response_async(void)
+{
+	struct wr_ret	r;
+	u64		response;
+
+	CVMX_SYNCIOBDMA;
+	response = scratch_read64(SCR_SCRATCH);
+
+	/* See SSO_GET_WORK_RTN_S for the format of the response */
+	r.grp = (response & GENMASK_ULL(57, 48)) >> 48;
+	if (response & BIT(63))
+		r.work = NULL;
+	else
+		r.work = phys_to_virt(response & GENMASK_ULL(41, 0));
+
+	return r;
+}
+
+static void octeon3_eth_replenish_rx(struct octeon3_ethernet *priv, int count)
+{
+	struct sk_buff *skb;
+	int i;
+
+	for (i = 0; i < count; i++) {
+		void **buf;
+
+		skb = __alloc_skb(packet_buffer_size, GFP_ATOMIC, 0, priv->node);
+		if (!skb)
+			break;
+		buf = (void **)PTR_ALIGN(skb->head, 128);
+		buf[SKB_PTR_OFFSET] = skb;
+		octeon_fpa3_free(priv->node, priv->pki_aura, buf);
+	}
+}
+
+static bool octeon3_eth_tx_complete_runnable(struct octeon3_ethernet_worker *worker)
+{
+	return atomic_read(&worker->kick) != 0 || kthread_should_stop();
+}
+
+static int octeon3_eth_replenish_all(struct octeon3_ethernet_node *oen)
+{
+	int pending = 0;
+	int batch_size = 32;
+	struct octeon3_ethernet *priv;
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(priv, &oen->device_list, list) {
+		int amount = atomic64_sub_if_positive(batch_size, &priv->buffers_needed);
+
+		if (amount >= 0) {
+			octeon3_eth_replenish_rx(priv, batch_size);
+			pending += amount;
+		}
+	}
+	rcu_read_unlock();
+	return pending;
+}
+
+static int octeon3_eth_tx_complete_hwtstamp(struct octeon3_ethernet *priv,
+					    struct sk_buff *skb)
+{
+	struct skb_shared_hwtstamps	shts;
+	u64				hwts;
+	u64				ns;
+
+	hwts = *((u64 *)(skb->cb) + 1);
+	ns = timecounter_cyc2time(&priv->tc, hwts);
+	memset(&shts, 0, sizeof(shts));
+	shts.hwtstamp = ns_to_ktime(ns);
+	skb_tstamp_tx(skb, &shts);
+
+	return 0;
+}
+
+static int octeon3_eth_tx_complete_worker(void *data)
+{
+	struct octeon3_ethernet_worker *worker = data;
+	struct octeon3_ethernet_node *oen = worker->oen;
+	int backlog;
+	int order = worker->order;
+	int tx_complete_stop_thresh = order * 100;
+	int backlog_stop_thresh = order == 0 ? 31 : order * 80;
+	u64 aq_cnt;
+	int i;
+
+	while (!kthread_should_stop()) {
+		wait_event_interruptible(worker->queue, octeon3_eth_tx_complete_runnable(worker));
+		atomic_dec_if_positive(&worker->kick); /* clear the flag */
+
+		do {
+			backlog = octeon3_eth_replenish_all(oen);
+			for (i = 0; i < 100; i++) {
+				void **work;
+				struct net_device *tx_netdev;
+				struct octeon3_ethernet *tx_priv;
+				struct sk_buff *skb;
+				struct wr_ret r;
+
+				r = octeon3_core_get_work_sync(oen->tx_complete_grp);
+				work = r.work;
+				if (!work)
+					break;
+				tx_netdev = work[0];
+				tx_priv = netdev_priv(tx_netdev);
+				if (unlikely(netif_queue_stopped(tx_netdev)) &&
+				    atomic64_read(&tx_priv->tx_backlog) < MAX_TX_QUEUE_DEPTH)
+					netif_wake_queue(tx_netdev);
+				skb = container_of((void *)work, struct sk_buff, cb);
+				if (unlikely(tx_priv->tx_timestamp_hw) &&
+				    unlikely(skb_shinfo(skb)->tx_flags & SKBTX_IN_PROGRESS))
+					octeon3_eth_tx_complete_hwtstamp(tx_priv, skb);
+				consume_skb(skb);
+			}
+
+			aq_cnt = oct_csr_read(SSO_GRP_AQ_CNT(oen->node, oen->tx_complete_grp));
+			aq_cnt &= GENMASK_ULL(32, 0);
+			if ((backlog > backlog_stop_thresh || aq_cnt > tx_complete_stop_thresh) &&
+			    order < ARRAY_SIZE(oen->workers) - 1) {
+				atomic_set(&oen->workers[order + 1].kick, 1);
+				wake_up(&oen->workers[order + 1].queue);
+			}
+		} while (!need_resched() &&
+			 (backlog > backlog_stop_thresh ||
+			  aq_cnt > tx_complete_stop_thresh));
+
+		cond_resched();
+
+		if (!octeon3_eth_tx_complete_runnable(worker))
+			octeon3_sso_irq_set(oen->node, oen->tx_complete_grp, true);
+	}
+
+	return 0;
+}
+
+static irqreturn_t octeon3_eth_tx_handler(int irq, void *info)
+{
+	struct octeon3_ethernet_node *oen = info;
+	/* Disarm the irq. */
+	octeon3_sso_irq_set(oen->node, oen->tx_complete_grp, false);
+	atomic_set(&oen->workers[0].kick, 1);
+	wake_up(&oen->workers[0].queue);
+	return IRQ_HANDLED;
+}
+
+static int octeon3_eth_global_init(unsigned int node,
+				   struct platform_device *pdev)
+{
+	int i;
+	int rv = 0;
+	unsigned int sso_intsn;
+	struct octeon3_ethernet_node *oen;
+
+	mutex_lock(&octeon3_eth_init_mutex);
+
+	oen = octeon3_eth_node + node;
+
+	if (oen->init_done)
+		goto done;
+
+	/* CN78XX-P1.0 cannot un-initialize PKO, so get a module
+	 * reference to prevent it from being unloaded.
+	 */
+	if (OCTEON_IS_MODEL(OCTEON_CN78XX_PASS1_0))
+		if (!try_module_get(THIS_MODULE))
+			dev_err(&pdev->dev,
+				"ERROR: Could not obtain module reference for CN78XX-P1.0\n");
+
+	INIT_LIST_HEAD(&oen->device_list);
+	mutex_init(&oen->device_list_lock);
+	spin_lock_init(&oen->napi_alloc_lock);
+
+	oen->node = node;
+
+	octeon_fpa3_init(node);
+	rv = octeon_fpa3_pool_init(node, -1, &oen->sso_pool,
+				   &oen->sso_pool_stack, 40960);
+	if (rv)
+		goto done;
+
+	rv = octeon_fpa3_pool_init(node, -1, &oen->pko_pool,
+				   &oen->pko_pool_stack, 40960);
+	if (rv)
+		goto done;
+
+	rv = octeon_fpa3_pool_init(node, -1, &oen->pki_packet_pool,
+				   &oen->pki_packet_pool_stack, 64 * num_packet_buffers);
+	if (rv)
+		goto done;
+
+	rv = octeon_fpa3_aura_init(node, oen->sso_pool, -1,
+				   &oen->sso_aura, num_packet_buffers, 20480);
+	if (rv)
+		goto done;
+
+	rv = octeon_fpa3_aura_init(node, oen->pko_pool, -1,
+				   &oen->pko_aura, num_packet_buffers, 20480);
+	if (rv)
+		goto done;
+
+	dev_info(&pdev->dev, "SSO:%d:%d, PKO:%d:%d\n", oen->sso_pool,
+		 oen->sso_aura, oen->pko_pool, oen->pko_aura);
+
+	if (!octeon3_eth_sso_pko_cache) {
+		octeon3_eth_sso_pko_cache = kmem_cache_create("sso_pko", 4096, 128, 0, NULL);
+		if (!octeon3_eth_sso_pko_cache) {
+			rv = -ENOMEM;
+			goto done;
+		}
+	}
+
+	rv = octeon_fpa3_mem_fill(node, octeon3_eth_sso_pko_cache,
+				  oen->sso_aura, 1024);
+	if (rv)
+		goto done;
+
+	rv = octeon_fpa3_mem_fill(node, octeon3_eth_sso_pko_cache,
+				  oen->pko_aura, 1024);
+	if (rv)
+		goto done;
+
+	rv = octeon3_sso_init(node, oen->sso_aura);
+	if (rv)
+		goto done;
+
+	oen->tx_complete_grp = octeon3_sso_alloc_grp(node, -1);
+	if (oen->tx_complete_grp < 0)
+		goto done;
+
+	sso_intsn = SSO_INTSN_EXE << 12 | oen->tx_complete_grp;
+	oen->tx_irq = irq_create_mapping(NULL, sso_intsn);
+	if (!oen->tx_irq) {
+		rv = -ENODEV;
+		goto done;
+	}
+
+	rv = octeon3_pko_init_global(node, oen->pko_aura);
+	if (rv) {
+		rv = -ENODEV;
+		goto done;
+	}
+
+	octeon3_pki_vlan_init(node);
+	octeon3_pki_cluster_init(node, pdev);
+	octeon3_pki_ltype_init(node);
+	octeon3_pki_enable(node);
+
+	for (i = 0; i < ARRAY_SIZE(oen->workers); i++) {
+		oen->workers[i].oen = oen;
+		init_waitqueue_head(&oen->workers[i].queue);
+		oen->workers[i].order = i;
+	}
+	for (i = 0; i < ARRAY_SIZE(oen->workers); i++) {
+		oen->workers[i].task = kthread_create_on_node(octeon3_eth_tx_complete_worker,
+							      oen->workers + i, node,
+							      "oct3_eth/%d:%d", node, i);
+		if (IS_ERR(oen->workers[i].task)) {
+			rv = PTR_ERR(oen->workers[i].task);
+			goto done;
+		} else {
+#ifdef CONFIG_NUMA
+			set_cpus_allowed_ptr(oen->workers[i].task, cpumask_of_node(node));
+#endif
+			wake_up_process(oen->workers[i].task);
+		}
+	}
+
+	if (OCTEON_IS_MODEL(OCTEON_CN78XX_PASS1_X))
+		octeon3_sso_pass1_limit(node, oen->tx_complete_grp);
+
+	rv = request_irq(oen->tx_irq, octeon3_eth_tx_handler,
+			 IRQ_TYPE_EDGE_RISING, "oct3_eth_tx_done", oen);
+	if (rv)
+		goto done;
+	octeon3_eth_gen_affinity(node, &oen->tx_affinity_hint);
+	irq_set_affinity_hint(oen->tx_irq, &oen->tx_affinity_hint);
+
+	octeon3_sso_irq_set(node, oen->tx_complete_grp, true);
+
+	oen->init_done = true;
+done:
+	mutex_unlock(&octeon3_eth_init_mutex);
+	return rv;
+}
+
+static struct sk_buff *octeon3_eth_work_to_skb(void *w)
+{
+	struct sk_buff *skb;
+	void **f = w;
+
+	skb = f[-16];
+	return skb;
+}
+
+/* Receive one packet.
+ * returns the number of RX buffers consumed.
+ */
+static int octeon3_eth_rx_one(struct octeon3_rx *rx, bool is_async, bool req_next)
+{
+	int segments;
+	int ret;
+	unsigned int packet_len;
+	struct wqe *work;
+	u8 *data;
+	int len_remaining;
+	struct sk_buff *skb;
+	union buf_ptr packet_ptr;
+	struct wr_ret r;
+	struct octeon3_ethernet *priv = rx->parent;
+
+	if (is_async)
+		r = octeon3_core_get_response_async();
+	else
+		r = octeon3_core_get_work_sync(rx->rx_grp);
+	work = r.work;
+	if (!work)
+		return 0;
+
+	/* Request the next work so it'll be ready when we need it */
+	if (is_async && req_next)
+		octeon3_core_get_work_async(rx->rx_grp);
+
+	skb = octeon3_eth_work_to_skb(work);
+
+	segments = work->word0.bufs;
+	ret = segments;
+	packet_ptr = work->packet_ptr;
+	if (unlikely(work->word2.err_level <= PKI_ERRLEV_LA &&
+		     work->word2.err_code != PKI_OPCODE_NONE)) {
+		atomic64_inc(&priv->rx_errors);
+		switch (work->word2.err_code) {
+		case PKI_OPCODE_JABBER:
+			atomic64_inc(&priv->rx_length_errors);
+			break;
+		case PKI_OPCODE_FCS:
+			atomic64_inc(&priv->rx_crc_errors);
+			break;
+		}
+		data = phys_to_virt(packet_ptr.addr);
+		for (;;) {
+			dev_kfree_skb_any(skb);
+			segments--;
+			if (segments <= 0)
+				break;
+			packet_ptr.u64 = *(u64 *)(data - 8);
+#ifndef __LITTLE_ENDIAN
+			if (OCTEON_IS_MODEL(OCTEON_CN78XX_PASS1_X)) {
+				/* PKI_BUFLINK_S's are endian-swapped */
+				packet_ptr.u64 = swab64(packet_ptr.u64);
+			}
+#endif
+			data = phys_to_virt(packet_ptr.addr);
+			skb = octeon3_eth_work_to_skb((void *)round_down((unsigned long)data, 128ull));
+		}
+		goto out;
+	}
+
+	packet_len = work->word1.len;
+	data = phys_to_virt(packet_ptr.addr);
+	skb->data = data;
+	skb->len = packet_len;
+	len_remaining = packet_len;
+	if (segments == 1) {
+		/* Strip the ethernet fcs */
+		skb->len -= 4;
+		skb_set_tail_pointer(skb, skb->len);
+	} else {
+		bool first_frag = true;
+		struct sk_buff *current_skb = skb;
+		struct sk_buff *next_skb = NULL;
+		unsigned int segment_size;
+
+		skb_frag_list_init(skb);
+		for (;;) {
+			segment_size = (segments == 1) ? len_remaining : packet_ptr.size;
+			len_remaining -= segment_size;
+			if (!first_frag) {
+				current_skb->len = segment_size;
+				skb->data_len += segment_size;
+				skb->truesize += current_skb->truesize;
+			}
+			skb_set_tail_pointer(current_skb, segment_size);
+			segments--;
+			if (segments == 0)
+				break;
+			packet_ptr.u64 = *(u64 *)(data - 8);
+#ifndef __LITTLE_ENDIAN
+			if (OCTEON_IS_MODEL(OCTEON_CN78XX_PASS1_X)) {
+				/* PKI_BUFLINK_S's are endian-swapped */
+				packet_ptr.u64 = swab64(packet_ptr.u64);
+			}
+#endif
+			data = phys_to_virt(packet_ptr.addr);
+			next_skb = octeon3_eth_work_to_skb((void *)round_down((unsigned long)data, 128ull));
+			if (first_frag) {
+				next_skb->next = skb_shinfo(current_skb)->frag_list;
+				skb_shinfo(current_skb)->frag_list = next_skb;
+			} else {
+				current_skb->next = next_skb;
+				next_skb->next = NULL;
+			}
+			current_skb = next_skb;
+			first_frag = false;
+			current_skb->data = data;
+		}
+
+		/* Strip the ethernet fcs */
+		pskb_trim(skb, skb->len - 4);
+	}
+
+	skb_checksum_none_assert(skb);
+	if (unlikely(priv->rx_timestamp_hw)) {
+		/* The first 8 bytes are the timestamp */
+		u64 hwts = *(u64 *)skb->data;
+		u64 ns;
+		struct skb_shared_hwtstamps *shts;
+
+		ns = timecounter_cyc2time(&priv->tc, hwts);
+		shts = skb_hwtstamps(skb);
+		memset(shts, 0, sizeof(*shts));
+		shts->hwtstamp = ns_to_ktime(ns);
+		__skb_pull(skb, 8);
+	}
+
+	skb->protocol = eth_type_trans(skb, priv->netdev);
+	skb->dev = priv->netdev;
+	if (priv->netdev->features & NETIF_F_RXCSUM) {
+		if ((work->word2.lc_hdr_type == PKI_LTYPE_IP4 ||
+		     work->word2.lc_hdr_type == PKI_LTYPE_IP6) &&
+		    (work->word2.lf_hdr_type == PKI_LTYPE_TCP ||
+		     work->word2.lf_hdr_type == PKI_LTYPE_UDP ||
+		     work->word2.lf_hdr_type == PKI_LTYPE_SCTP))
+			if (work->word2.err_code == 0)
+				skb->ip_summed = CHECKSUM_UNNECESSARY;
+	}
+
+	napi_gro_receive(&rx->napi, skb);
+out:
+	return ret;
+}
+
+static int octeon3_eth_napi(struct napi_struct *napi, int budget)
+{
+	int rx_count = 0;
+	struct octeon3_rx *cxt;
+	struct octeon3_ethernet *priv;
+	u64 aq_cnt;
+	int n = 0;
+	int n_bufs = 0;
+	u64 old_scratch;
+
+	cxt = container_of(napi, struct octeon3_rx, napi);
+	priv = cxt->parent;
+
+	/* Get the amount of work pending */
+	aq_cnt = oct_csr_read(SSO_GRP_AQ_CNT(priv->node, cxt->rx_grp));
+	aq_cnt &= GENMASK_ULL(32, 0);
+
+	if (likely(USE_ASYNC_IOBDMA)) {
+		/* Save scratch in case userspace is using it */
+		CVMX_SYNCIOBDMA;
+		old_scratch = scratch_read64(SCR_SCRATCH);
+
+		octeon3_core_get_work_async(cxt->rx_grp);
+	}
+
+	while (rx_count < budget) {
+		n = 0;
+
+		if (likely(USE_ASYNC_IOBDMA)) {
+			bool req_next = rx_count < (budget - 1) ? true : false;
+
+			n = octeon3_eth_rx_one(cxt, true, req_next);
+		} else {
+			n = octeon3_eth_rx_one(cxt, false, false);
+		}
+
+		if (n == 0)
+			break;
+
+		n_bufs += n;
+		rx_count++;
+	}
+
+	/* Wake up worker threads */
+	n_bufs = atomic64_add_return(n_bufs, &priv->buffers_needed);
+	if (n_bufs >= 32) {
+		struct octeon3_ethernet_node *oen;
+
+		oen = octeon3_eth_node + priv->node;
+		atomic_set(&oen->workers[0].kick, 1);
+		wake_up(&oen->workers[0].queue);
+	}
+
+	/* Stop the thread when no work is pending */
+	if (rx_count < budget) {
+		napi_complete(napi);
+		octeon3_sso_irq_set(cxt->parent->node, cxt->rx_grp, true);
+	}
+
+	if (likely(USE_ASYNC_IOBDMA)) {
+		/* Restore the scratch area */
+		scratch_write64(SCR_SCRATCH, old_scratch);
+	}
+
+	return rx_count;
+}
+
+#undef BROKEN_SIMULATOR_CSUM
+
+static void ethtool_get_drvinfo(struct net_device *netdev,
+				struct ethtool_drvinfo *info)
+{
+	strlcpy(info->driver, "octeon3-ethernet", sizeof(info->driver));
+	strlcpy(info->version, "1.0", sizeof(info->version));
+	strlcpy(info->bus_info,
+		dev_name(netdev->dev.parent), sizeof(info->bus_info));
+}
+
+static int ethtool_get_ts_info(struct net_device *ndev,
+			       struct ethtool_ts_info *info)
+{
+	struct octeon3_ethernet *priv = netdev_priv(ndev);
+
+	info->so_timestamping =
+		SOF_TIMESTAMPING_TX_HARDWARE |
+		SOF_TIMESTAMPING_RX_HARDWARE |
+		SOF_TIMESTAMPING_RAW_HARDWARE;
+
+	if (priv->ptp_clock)
+		info->phc_index = ptp_clock_index(priv->ptp_clock);
+	else
+		info->phc_index = -1;
+
+	info->tx_types = (1 << HWTSTAMP_TX_OFF) | (1 << HWTSTAMP_TX_ON);
+
+	info->rx_filters = (1 << HWTSTAMP_FILTER_NONE) | (1 << HWTSTAMP_FILTER_ALL);
+
+	return 0;
+}
+
+static const struct ethtool_ops octeon3_ethtool_ops = {
+	.get_drvinfo = ethtool_get_drvinfo,
+	.get_link_ksettings = bgx_port_ethtool_get_link_ksettings,
+	.set_settings = bgx_port_ethtool_set_settings,
+	.nway_reset = bgx_port_ethtool_nway_reset,
+	.get_link = ethtool_op_get_link,
+	.get_ts_info = ethtool_get_ts_info,
+};
+
+static int octeon3_eth_common_ndo_init(struct net_device *netdev, int extra_skip)
+{
+	struct octeon3_ethernet *priv = netdev_priv(netdev);
+	struct octeon3_ethernet_node *oen = octeon3_eth_node + priv->node;
+	int pki_chan, dq;
+	int base_rx_grp[MAX_RX_QUEUES];
+	int r, i;
+	int aura;
+
+	netif_carrier_off(netdev);
+
+	netdev->features |=
+#ifndef BROKEN_SIMULATOR_CSUM
+		NETIF_F_IP_CSUM |
+		NETIF_F_IPV6_CSUM |
+#endif
+		NETIF_F_SG |
+		NETIF_F_FRAGLIST |
+		NETIF_F_RXCSUM |
+		NETIF_F_LLTX;
+
+	if (!OCTEON_IS_MODEL(OCTEON_CN78XX_PASS1_X))
+		netdev->features |= NETIF_F_SCTP_CRC;
+
+	netdev->features |= NETIF_F_TSO | NETIF_F_TSO6;
+
+	/* Set user changeable settings */
+	netdev->hw_features = netdev->features;
+
+	priv->rx_buf_count = num_packet_buffers;
+
+	pki_chan = get_pki_chan(priv->node, priv->interface, priv->index);
+
+	dq = octeon3_pko_interface_init(priv->node, priv->interface,
+					priv->index, priv->mac_type, pki_chan);
+	if (dq < 0) {
+		dev_err(netdev->dev.parent, "Failed to initialize pko\n");
+		return -ENODEV;
+	}
+
+	r = octeon3_pko_activate_dq(priv->node, dq, 1);
+	if (r < 0) {
+		dev_err(netdev->dev.parent, "Failed to activate dq\n");
+		return -ENODEV;
+	}
+
+	priv->pko_queue = dq;
+	octeon_fpa3_aura_init(priv->node, oen->pki_packet_pool, -1, &aura,
+			      num_packet_buffers, num_packet_buffers * 2);
+	priv->pki_aura = aura;
+
+	r = octeon3_sso_alloc_grp_range(priv->node,
+					-1, rx_queues, false, base_rx_grp);
+	if (r) {
+		dev_err(netdev->dev.parent, "Failed to allocated SSO group\n");
+		return -ENODEV;
+	}
+	for (i = 0; i < rx_queues; i++) {
+		priv->rx_cxt[i].rx_grp = base_rx_grp[i];
+		priv->rx_cxt[i].parent = priv;
+
+		if (OCTEON_IS_MODEL(OCTEON_CN78XX_PASS1_X))
+			octeon3_sso_pass1_limit(priv->node, priv->rx_cxt[i].rx_grp);
+	}
+	priv->num_rx_cxt = rx_queues;
+
+	priv->tx_complete_grp = oen->tx_complete_grp;
+	dev_info(netdev->dev.parent,
+		 "rx sso grp:%d..%d aura:%d pknd:%d pko_queue:%d\n",
+		 *base_rx_grp, *(base_rx_grp + priv->num_rx_cxt - 1),
+		 priv->pki_aura, priv->pknd, priv->pko_queue);
+
+	octeon3_pki_port_init(priv->node, priv->pki_aura, *base_rx_grp,
+			      extra_skip, (packet_buffer_size - 128),
+			      priv->pknd, priv->num_rx_cxt);
+
+	priv->last_packets = 0;
+	priv->last_octets = 0;
+	priv->last_dropped = 0;
+
+	/* Register ethtool methods */
+	netdev->ethtool_ops = &octeon3_ethtool_ops;
+
+	return 0;
+}
+
+static int octeon3_eth_bgx_ndo_init(struct net_device *netdev)
+{
+	struct octeon3_ethernet	*priv = netdev_priv(netdev);
+	const u8		*mac;
+	int			r;
+
+	priv->pknd = bgx_port_get_pknd(priv->node, priv->interface, priv->index);
+	octeon3_eth_common_ndo_init(netdev, 0);
+
+	/* Padding and FCS are done in BGX */
+	r = octeon3_pko_set_mac_options(priv->node, priv->interface, priv->index,
+					priv->mac_type, false, false, 0);
+	if (r)
+		return r;
+
+	mac = bgx_port_get_mac(netdev);
+	if (mac && is_valid_ether_addr(mac)) {
+		memcpy(netdev->dev_addr, mac, ETH_ALEN);
+		netdev->addr_assign_type &= ~NET_ADDR_RANDOM;
+	} else {
+		eth_hw_addr_random(netdev);
+	}
+
+	bgx_port_set_rx_filtering(netdev);
+	bgx_port_change_mtu(netdev, netdev->mtu);
+
+	return 0;
+}
+
+static void octeon3_eth_ndo_uninit(struct net_device *netdev)
+{
+	struct octeon3_ethernet	*priv = netdev_priv(netdev);
+	int			grp[MAX_RX_QUEUES];
+	int			i;
+
+	/* Shutdwon pki for this interface */
+	octeon3_pki_port_shutdown(priv->node, priv->pknd);
+	octeon_fpa3_release_aura(priv->node, priv->pki_aura);
+
+	/* Shutdown pko for this interface */
+	octeon3_pko_interface_uninit(priv->node, &priv->pko_queue, 1);
+
+	/* Free the receive contexts sso groups */
+	for (i = 0; i < rx_queues; i++)
+		grp[i] = priv->rx_cxt[i].rx_grp;
+	octeon3_sso_free_grp_range(priv->node, grp, rx_queues);
+}
+
+static void octeon3_eth_ndo_get_stats64(struct net_device *netdev,
+					struct rtnl_link_stats64 *s)
+{
+	struct octeon3_ethernet *priv = netdev_priv(netdev);
+	u64 packets, octets, dropped;
+	u64 delta_packets, delta_octets, delta_dropped;
+
+	/* The 48 bits counters may wrap around.  We need to call this
+	 * function periodically, to catch any wrap.  Locking is
+	 * needed to ensure consistency of the RMW operation on the
+	 * last_{packets, octets, dropped} variables if two or more
+	 * threads enter here at the same time.
+	 */
+	spin_lock(&priv->stat_lock);
+
+	octeon3_pki_get_stats(priv->node, priv->pknd, &packets, &octets, &dropped);
+
+	delta_packets = (packets - priv->last_packets) & ((1ull << 48) - 1);
+	delta_octets = (octets - priv->last_octets) & ((1ull << 48) - 1);
+	delta_dropped = (dropped - priv->last_dropped) & ((1ull << 48) - 1);
+
+	priv->last_packets = packets;
+	priv->last_octets = octets;
+	priv->last_dropped = dropped;
+
+	spin_unlock(&priv->stat_lock);
+
+	s->rx_packets = atomic64_add_return_relaxed(delta_packets, &priv->rx_packets);
+	s->rx_bytes = atomic64_add_return_relaxed(delta_octets, &priv->rx_octets);
+	s->rx_dropped = atomic64_add_return_relaxed(delta_dropped, &priv->rx_dropped);
+
+	s->rx_errors = atomic64_read(&priv->rx_errors);
+	s->rx_length_errors = atomic64_read(&priv->rx_length_errors);
+	s->rx_crc_errors = atomic64_read(&priv->rx_crc_errors);
+
+	s->tx_packets = atomic64_read(&priv->tx_packets);
+	s->tx_bytes = atomic64_read(&priv->tx_octets);
+	s->tx_dropped = atomic64_read(&priv->tx_dropped);
+}
+
+static void octeon3_eth_stat_poll(struct work_struct *work)
+{
+	struct octeon3_ethernet *priv;
+	struct rtnl_link_stats64 s;
+
+	priv = container_of(work, struct octeon3_ethernet, stat_work.work);
+	octeon3_eth_ndo_get_stats64(priv->netdev, &s);
+
+	/* Poll every 60s */
+	mod_delayed_work(system_unbound_wq,
+			 &priv->stat_work, msecs_to_jiffies(60000));
+}
+
+static irqreturn_t octeon3_eth_rx_handler(int irq, void *info)
+{
+	struct octeon3_rx *rx = info;
+
+	/* Disarm the irq. */
+	octeon3_sso_irq_set(rx->parent->node, rx->rx_grp, false);
+
+	napi_schedule(&rx->napi);
+	return IRQ_HANDLED;
+}
+
+static int octeon3_eth_common_ndo_open(struct net_device *netdev)
+{
+	struct octeon3_ethernet *priv = netdev_priv(netdev);
+	struct octeon3_rx *rx;
+	int i;
+	int r;
+
+	for (i = 0; i < priv->num_rx_cxt; i++) {
+		unsigned int	sso_intsn;
+
+		rx = priv->rx_cxt + i;
+		sso_intsn = SSO_INTSN_EXE << 12 | rx->rx_grp;
+
+		rx->rx_irq = irq_create_mapping(NULL, sso_intsn);
+		if (!rx->rx_irq) {
+			netdev_err(netdev,
+				   "ERROR: Couldn't map hwirq: %x\n", sso_intsn);
+			r = -EINVAL;
+			goto err1;
+		}
+		r = request_irq(rx->rx_irq, octeon3_eth_rx_handler,
+				IRQ_TYPE_EDGE_RISING, netdev_name(netdev), rx);
+		if (r) {
+			netdev_err(netdev, "ERROR: Couldn't request irq: %d\n",
+				   rx->rx_irq);
+			r = -ENOMEM;
+			goto err2;
+		}
+
+		octeon3_eth_gen_affinity(priv->node, &rx->rx_affinity_hint);
+		irq_set_affinity_hint(rx->rx_irq, &rx->rx_affinity_hint);
+
+		netif_napi_add(priv->netdev, &rx->napi,
+			       octeon3_eth_napi, NAPI_POLL_WEIGHT);
+		napi_enable(&rx->napi);
+
+		/* Arm the irq. */
+		octeon3_sso_irq_set(priv->node, rx->rx_grp, true);
+	}
+	octeon3_eth_replenish_rx(priv, priv->rx_buf_count);
+
+	/* Start stat polling */
+	octeon3_eth_stat_poll(&priv->stat_work.work);
+
+	return 0;
+
+err2:
+	irq_dispose_mapping(rx->rx_irq);
+err1:
+	for (i--; i >= 0; i--) {
+		rx = priv->rx_cxt + i;
+		free_irq(rx->rx_irq, rx);
+		irq_dispose_mapping(rx->rx_irq);
+		napi_disable(&rx->napi);
+		netif_napi_del(&rx->napi);
+	}
+
+	return r;
+}
+
+static int octeon3_eth_bgx_ndo_open(struct net_device *netdev)
+{
+	int	rc;
+
+	rc = octeon3_eth_common_ndo_open(netdev);
+	if (rc == 0)
+		rc = bgx_port_enable(netdev);
+
+	return rc;
+}
+
+static int octeon3_eth_common_ndo_stop(struct net_device *netdev)
+{
+	struct octeon3_ethernet *priv = netdev_priv(netdev);
+	void **w;
+	struct sk_buff *skb;
+	struct octeon3_rx *rx;
+	int i;
+
+	cancel_delayed_work_sync(&priv->stat_work);
+
+	/* Allow enough time for ingress in transit packets to be drained */
+	msleep(20);
+
+	/* Wait until sso has no more work for this interface */
+	for (i = 0; i < priv->num_rx_cxt; i++) {
+		rx = priv->rx_cxt + i;
+		while (oct_csr_read(SSO_GRP_AQ_CNT(priv->node, rx->rx_grp)))
+			msleep(20);
+	}
+
+	/* Free the irq and napi context for each rx context */
+	for (i = 0; i < priv->num_rx_cxt; i++) {
+		rx = priv->rx_cxt + i;
+		octeon3_sso_irq_set(priv->node, rx->rx_grp, false);
+		irq_set_affinity_hint(rx->rx_irq, NULL);
+		free_irq(rx->rx_irq, rx);
+		irq_dispose_mapping(rx->rx_irq);
+		rx->rx_irq = 0;
+		napi_disable(&rx->napi);
+		netif_napi_del(&rx->napi);
+	}
+
+	/* Free the packet buffers */
+	for (;;) {
+		w = octeon_fpa3_alloc(priv->node, priv->pki_aura);
+		if (!w)
+			break;
+		skb = w[0];
+		dev_kfree_skb(skb);
+	}
+
+	return 0;
+}
+
+static int octeon3_eth_bgx_ndo_stop(struct net_device *netdev)
+{
+	int r;
+
+	r = bgx_port_disable(netdev);
+	if (r)
+		return r;
+
+	return octeon3_eth_common_ndo_stop(netdev);
+}
+
+static inline u64 build_pko_send_hdr_desc(struct sk_buff *skb)
+{
+	u64	send_hdr = 0;
+	u8	l4_hdr = 0;
+	u64	checksum_alg;
+
+	/* See PKO_SEND_HDR_S in the HRM for the send header descriptor
+	 * format.
+	 */
+#ifdef __LITTLE_ENDIAN
+	send_hdr |= BIT(43);
+#endif
+
+	if (!OCTEON_IS_MODEL(OCTEON_CN78XX_PASS1_X)) {
+		/* Don't allocate to L2 */
+		send_hdr |= BIT(42);
+	}
+
+	/* Don't automatically free to FPA */
+	send_hdr |= BIT(40);
+
+	send_hdr |= skb->len;
+
+	if (skb->ip_summed != CHECKSUM_NONE &&
+	    skb->ip_summed != CHECKSUM_UNNECESSARY) {
+#ifndef BROKEN_SIMULATOR_CSUM
+		switch (skb->protocol) {
+		case htons(ETH_P_IP):
+			send_hdr |= ETH_HLEN << 16;
+			send_hdr |= BIT(45);
+			l4_hdr = ip_hdr(skb)->protocol;
+			send_hdr |= (ETH_HLEN + (4 * ip_hdr(skb)->ihl)) << 24;
+			break;
+
+		case htons(ETH_P_IPV6):
+			l4_hdr = ipv6_hdr(skb)->nexthdr;
+			send_hdr |= ETH_HLEN << 16;
+			break;
+
+		default:
+			break;
+		}
+#endif
+
+		checksum_alg = 1; /* UDP == 1 */
+		switch (l4_hdr) {
+		case IPPROTO_SCTP:
+			if (OCTEON_IS_MODEL(OCTEON_CN78XX_PASS1_X))
+				break;
+			checksum_alg++; /* SCTP == 3 */
+			/* Fall through */
+		case IPPROTO_TCP: /* TCP == 2 */
+			checksum_alg++;
+			/* Fall through */
+		case IPPROTO_UDP:
+			if (skb_transport_header_was_set(skb)) {
+				int l4ptr = skb_transport_header(skb) -
+					skb->data;
+				send_hdr &= ~GENMASK_ULL(31, 24);
+				send_hdr |= l4ptr << 24;
+				send_hdr |= checksum_alg << 46;
+			}
+			break;
+
+		default:
+			break;
+		}
+	}
+
+	return send_hdr;
+}
+
+static inline u64 build_pko_send_ext_desc(struct sk_buff *skb)
+{
+	u64	send_ext = 0;
+
+	/* See PKO_SEND_EXT_S in the HRM for the send extended descriptor
+	 * format.
+	 */
+	skb_shinfo(skb)->tx_flags |= SKBTX_IN_PROGRESS;
+	send_ext |= (u64)PKO_SENDSUBDC_EXT << 44;
+	send_ext |= 1ull << 40;
+	send_ext |= BIT(39);
+	send_ext |= ETH_HLEN << 16;
+
+	return send_ext;
+}
+
+static inline u64 build_pko_send_tso(struct sk_buff *skb, uint mtu)
+{
+	u64	send_tso = 0;
+
+	/* See PKO_SEND_TSO_S in the HRM for the send tso descriptor format */
+	send_tso |= 12ull << 56;
+	send_tso |= (u64)PKO_SENDSUBDC_TSO << 44;
+	send_tso |= (skb_transport_offset(skb) + tcp_hdrlen(skb)) << 24;
+	send_tso |= (mtu + ETH_HLEN) << 8;
+
+	return send_tso;
+}
+
+static inline u64 build_pko_send_mem_sub(u64 addr)
+{
+	u64	send_mem = 0;
+
+	/* See PKO_SEND_MEM_S in the HRM for the send mem descriptor format */
+	send_mem |= (u64)PKO_SENDSUBDC_MEM << 44;
+	send_mem |= (u64)MEMDSZ_B64 << 60;
+	send_mem |= (u64)MEMALG_SUB << 56;
+	send_mem |= 1ull << 48;
+	send_mem |= addr;
+
+	return send_mem;
+}
+
+static inline u64 build_pko_send_mem_ts(u64 addr)
+{
+	u64	send_mem = 0;
+
+	/* See PKO_SEND_MEM_S in the HRM for the send mem descriptor format */
+	send_mem |= 1ull << 62;
+	send_mem |= (u64)PKO_SENDSUBDC_MEM << 44;
+	send_mem |= (u64)MEMDSZ_B64 << 60;
+	send_mem |= (u64)MEMALG_SETTSTMP << 56;
+	send_mem |= addr;
+
+	return send_mem;
+}
+
+static inline u64 build_pko_send_free(u64 addr)
+{
+	u64	send_free = 0;
+
+	/* See PKO_SEND_FREE_S in the HRM for the send free descriptor format */
+	send_free |= (u64)PKO_SENDSUBDC_FREE << 44;
+	send_free |= addr;
+
+	return send_free;
+}
+
+static inline u64 build_pko_send_work(int grp, u64 addr)
+{
+	u64	send_work = 0;
+
+	/* See PKO_SEND_WORK_S in the HRM for the send work descriptor format */
+	send_work |= (u64)PKO_SENDSUBDC_WORK << 44;
+	send_work |= (u64)grp << 52;
+	send_work |= 2ull << 50;
+	send_work |= addr;
+
+	return send_work;
+}
+
+static int octeon3_eth_ndo_start_xmit(struct sk_buff *skb,
+				      struct net_device *netdev)
+{
+	struct sk_buff *skb_tmp;
+	struct octeon3_ethernet *priv = netdev_priv(netdev);
+	u64 scr_off = LMTDMA_SCR_OFFSET;
+	u64 pko_send_desc;
+	u64 lmtdma_data;
+	u64 aq_cnt = 0;
+	struct octeon3_ethernet_node *oen;
+	long backlog;
+	int frag_count;
+	u64 head_len;
+	int i;
+	u64 *lmtdma_addr;
+	void **work;
+	unsigned int mss;
+	int grp;
+
+	frag_count = 0;
+	if (skb_has_frag_list(skb))
+		skb_walk_frags(skb, skb_tmp)
+			frag_count++;
+
+	/* Stop the queue if pko or sso are not keeping up */
+	oen = octeon3_eth_node + priv->node;
+	aq_cnt = oct_csr_read(SSO_GRP_AQ_CNT(oen->node, oen->tx_complete_grp));
+	aq_cnt &= GENMASK_ULL(32, 0);
+	backlog = atomic64_inc_return(&priv->tx_backlog);
+	if (unlikely(backlog > MAX_TX_QUEUE_DEPTH || aq_cnt > 100000))
+		netif_stop_queue(netdev);
+
+	/* We have space for 11 segment pointers, If there will be
+	 * more than that, we must linearize.  The count is: 1 (base
+	 * SKB) + frag_count + nr_frags.
+	 */
+	if (unlikely(skb_shinfo(skb)->nr_frags + frag_count > 10)) {
+		if (unlikely(__skb_linearize(skb)))
+			goto skip_xmit;
+		frag_count = 0;
+	}
+
+	work = (void **)skb->cb;
+	work[0] = netdev;
+	work[1] = NULL;
+
+	/* Adjust the port statistics. */
+	atomic64_inc(&priv->tx_packets);
+	atomic64_add(skb->len, &priv->tx_octets);
+
+	/* Make sure packet data writes are committed before
+	 * submitting the command below
+	 */
+	wmb();
+
+	/* Build the pko command */
+	pko_send_desc = build_pko_send_hdr_desc(skb);
+	/* We don't save/restore state of CPU local memory for kernel
+	 * space access, so we must disable preemption while we build
+	 * and transmit the PKO command.
+	 */
+	preempt_disable();
+	scratch_write64(scr_off, pko_send_desc);
+	scr_off += sizeof(pko_send_desc);
+
+	/* Request packet to be ptp timestamped */
+	if ((unlikely(skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP)) &&
+	    unlikely(priv->tx_timestamp_hw)) {
+		pko_send_desc = build_pko_send_ext_desc(skb);
+		scratch_write64(scr_off, pko_send_desc);
+		scr_off += sizeof(pko_send_desc);
+	}
+
+	/* Add the tso descriptor if needed */
+	mss = skb_shinfo(skb)->gso_size;
+	if (unlikely(mss)) {
+		pko_send_desc = build_pko_send_tso(skb, netdev->mtu);
+		scratch_write64(scr_off, pko_send_desc);
+		scr_off += sizeof(pko_send_desc);
+	}
+
+	/* Add a gather descriptor for each segment. See PKO_SEND_GATHER_S for
+	 * the send gather descriptor format.
+	 */
+	pko_send_desc = 0;
+	pko_send_desc |= (u64)PKO_SENDSUBDC_GATHER << 45;
+	head_len = skb_headlen(skb);
+	if (head_len > 0) {
+		pko_send_desc |= head_len << 48;
+		pko_send_desc |= virt_to_phys(skb->data);
+		scratch_write64(scr_off, pko_send_desc);
+		scr_off += sizeof(pko_send_desc);
+	}
+	for (i = 1; i <= skb_shinfo(skb)->nr_frags; i++) {
+		struct skb_frag_struct *fs = skb_shinfo(skb)->frags + i - 1;
+
+		pko_send_desc &= ~(GENMASK_ULL(63, 48) | GENMASK_ULL(41, 0));
+		pko_send_desc |= (u64)fs->size << 48;
+		pko_send_desc |= virt_to_phys((u8 *)page_address(fs->page.p) + fs->page_offset);
+		scratch_write64(scr_off, pko_send_desc);
+		scr_off += sizeof(pko_send_desc);
+	}
+	skb_walk_frags(skb, skb_tmp) {
+		pko_send_desc &= ~(GENMASK_ULL(63, 48) | GENMASK_ULL(41, 0));
+		pko_send_desc |= (u64)skb_tmp->len << 48;
+		pko_send_desc |= virt_to_phys(skb_tmp->data);
+		scratch_write64(scr_off, pko_send_desc);
+		scr_off += sizeof(pko_send_desc);
+	}
+
+	/* Subtract 1 from the tx_backlog. */
+	pko_send_desc = build_pko_send_mem_sub(virt_to_phys(&priv->tx_backlog));
+	scratch_write64(scr_off, pko_send_desc);
+	scr_off += sizeof(pko_send_desc);
+
+	/* Write the ptp timestamp in the skb itself */
+	if ((unlikely(skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP)) &&
+	    unlikely(priv->tx_timestamp_hw)) {
+		pko_send_desc = build_pko_send_mem_ts(virt_to_phys(&work[1]));
+		scratch_write64(scr_off, pko_send_desc);
+		scr_off += sizeof(pko_send_desc);
+	}
+
+	/* Send work when finished with the packet. */
+	grp = octeon3_eth_lgrp_to_ggrp(priv->node, priv->tx_complete_grp);
+	pko_send_desc = build_pko_send_work(grp, virt_to_phys(work));
+	scratch_write64(scr_off, pko_send_desc);
+	scr_off += sizeof(pko_send_desc);
+
+	/* See PKO_SEND_DMA_S in the HRM for the lmtdam data format */
+	lmtdma_data = 0;
+	lmtdma_data |= (u64)(LMTDMA_SCR_OFFSET >> 3) << 56;
+	lmtdma_data |= 0x51ull << 40;
+	lmtdma_data |= (u64)priv->node << 36;
+	lmtdma_data |= priv->pko_queue << 16;
+
+	lmtdma_addr = (u64 *)(LMTDMA_ORDERED_IO_ADDR | ((scr_off & 0x78) - 8));
+	*lmtdma_addr = lmtdma_data;
+
+	preempt_enable();
+
+	return NETDEV_TX_OK;
+skip_xmit:
+	atomic64_inc(&priv->tx_dropped);
+	dev_consume_skb_any(skb);
+	return NETDEV_TX_OK;
+}
+
+static int octeon3_eth_set_mac_address(struct net_device *netdev, void *addr)
+{
+	int r = eth_mac_addr(netdev, addr);
+
+	if (r)
+		return r;
+
+	bgx_port_set_rx_filtering(netdev);
+
+	return 0;
+}
+
+static u64 octeon3_cyclecounter_read(const struct cyclecounter *cc)
+{
+	struct octeon3_ethernet	*priv;
+	u64			count;
+
+	priv = container_of(cc, struct octeon3_ethernet, cc);
+	count = oct_csr_read(MIO_PTP_CLOCK_HI(priv->node));
+	return count;
+}
+
+static int octeon3_bgx_hwtstamp(struct net_device *netdev, int en)
+{
+	struct octeon3_ethernet		*priv = netdev_priv(netdev);
+	u64				data;
+
+	switch (bgx_port_get_mode(priv->node, priv->interface, priv->index)) {
+	case PORT_MODE_RGMII:
+	case PORT_MODE_SGMII:
+		data = oct_csr_read(BGX_GMP_GMI_RX_FRM_CTL(priv->node, priv->interface, priv->index));
+		if (en)
+			data |= BIT(12);
+		else
+			data &= ~BIT(12);
+		oct_csr_write(data, BGX_GMP_GMI_RX_FRM_CTL(priv->node, priv->interface, priv->index));
+		break;
+
+	case PORT_MODE_XAUI:
+	case PORT_MODE_RXAUI:
+	case PORT_MODE_10G_KR:
+	case PORT_MODE_XLAUI:
+	case PORT_MODE_40G_KR4:
+	case PORT_MODE_XFI:
+		data = oct_csr_read(BGX_SMU_RX_FRM_CTL(priv->node, priv->interface, priv->index));
+		if (en)
+			data |= BIT(12);
+		else
+			data &= ~BIT(12);
+		oct_csr_write(data, BGX_SMU_RX_FRM_CTL(priv->node, priv->interface, priv->index));
+		break;
+
+	default:
+		/* No timestamp support*/
+		return -EOPNOTSUPP;
+	}
+
+	return 0;
+}
+
+static int octeon3_pki_hwtstamp(struct net_device *netdev, int en)
+{
+	struct octeon3_ethernet		*priv = netdev_priv(netdev);
+	int				skip = en ? 8 : 0;
+
+	octeon3_pki_set_ptp_skip(priv->node, priv->pknd, skip);
+
+	return 0;
+}
+
+static int octeon3_ioctl_hwtstamp(struct net_device *netdev,
+				  struct ifreq *rq, int cmd)
+{
+	struct octeon3_ethernet		*priv = netdev_priv(netdev);
+	u64				data;
+	struct hwtstamp_config		config;
+	int				en;
+
+	/* The PTP block should be enabled */
+	data = oct_csr_read(MIO_PTP_CLOCK_CFG(priv->node));
+	if (!(data & BIT(0))) {
+		netdev_err(netdev, "Error: PTP clock not enabled\n");
+		return -EOPNOTSUPP;
+	}
+
+	if (copy_from_user(&config, rq->ifr_data, sizeof(config)))
+		return -EFAULT;
+
+	if (config.flags) /* reserved for future extensions */
+		return -EINVAL;
+
+	switch (config.tx_type) {
+	case HWTSTAMP_TX_OFF:
+		priv->tx_timestamp_hw = 0;
+		break;
+	case HWTSTAMP_TX_ON:
+		priv->tx_timestamp_hw = 1;
+		break;
+	default:
+		return -ERANGE;
+	}
+
+	switch (config.rx_filter) {
+	case HWTSTAMP_FILTER_NONE:
+		priv->rx_timestamp_hw = 0;
+		en = 0;
+		break;
+	case HWTSTAMP_FILTER_ALL:
+	case HWTSTAMP_FILTER_SOME:
+	case HWTSTAMP_FILTER_PTP_V1_L4_EVENT:
+	case HWTSTAMP_FILTER_PTP_V1_L4_SYNC:
+	case HWTSTAMP_FILTER_PTP_V1_L4_DELAY_REQ:
+	case HWTSTAMP_FILTER_PTP_V2_L4_EVENT:
+	case HWTSTAMP_FILTER_PTP_V2_L4_SYNC:
+	case HWTSTAMP_FILTER_PTP_V2_L4_DELAY_REQ:
+	case HWTSTAMP_FILTER_PTP_V2_L2_EVENT:
+	case HWTSTAMP_FILTER_PTP_V2_L2_SYNC:
+	case HWTSTAMP_FILTER_PTP_V2_L2_DELAY_REQ:
+	case HWTSTAMP_FILTER_PTP_V2_EVENT:
+	case HWTSTAMP_FILTER_PTP_V2_SYNC:
+	case HWTSTAMP_FILTER_PTP_V2_DELAY_REQ:
+		priv->rx_timestamp_hw = 1;
+		en = 1;
+		break;
+	default:
+		return -ERANGE;
+	}
+
+	octeon3_bgx_hwtstamp(netdev, en);
+	octeon3_pki_hwtstamp(netdev, en);
+
+	priv->cc.read = octeon3_cyclecounter_read;
+	priv->cc.mask = CYCLECOUNTER_MASK(64);
+	/* Ptp counter is always in nsec */
+	priv->cc.mult = 1;
+	priv->cc.shift = 0;
+	timecounter_init(&priv->tc, &priv->cc, ktime_to_ns(ktime_get_real()));
+
+	return 0;
+}
+
+static int octeon3_adjfreq(struct ptp_clock_info *ptp, s32 ppb)
+{
+	struct octeon3_ethernet	*priv;
+	u64			comp;
+	u64			diff;
+	int			neg_ppb = 0;
+
+	priv = container_of(ptp, struct octeon3_ethernet, ptp_info);
+
+	if (ppb < 0) {
+		ppb = -ppb;
+		neg_ppb = 1;
+	}
+
+	/* The part per billion (ppb) is a delta from the base frequency */
+	comp = (NSEC_PER_SEC << 32) / octeon_get_io_clock_rate();
+
+	diff = comp;
+	diff *= ppb;
+	diff = div_u64(diff, 1000000000ULL);
+
+	comp = neg_ppb ? comp - diff : comp + diff;
+
+	oct_csr_write(comp, MIO_PTP_CLOCK_COMP(priv->node));
+
+	return 0;
+}
+
+static int octeon3_adjtime(struct ptp_clock_info *ptp, s64 delta)
+{
+	struct octeon3_ethernet	*priv;
+	s64			now;
+	unsigned long		flags;
+
+	priv = container_of(ptp, struct octeon3_ethernet, ptp_info);
+
+	spin_lock_irqsave(&priv->ptp_lock, flags);
+	now = timecounter_read(&priv->tc);
+	now += delta;
+	timecounter_init(&priv->tc, &priv->cc, now);
+	spin_unlock_irqrestore(&priv->ptp_lock, flags);
+
+	return 0;
+}
+
+static int octeon3_gettime(struct ptp_clock_info *ptp, struct timespec *ts)
+{
+	struct octeon3_ethernet	*priv;
+	u64			ns;
+	u32			remainder;
+	unsigned long		flags;
+
+	priv = container_of(ptp, struct octeon3_ethernet, ptp_info);
+
+	spin_lock_irqsave(&priv->ptp_lock, flags);
+	ns = timecounter_read(&priv->tc);
+	spin_unlock_irqrestore(&priv->ptp_lock, flags);
+	ts->tv_sec = div_u64_rem(ns, 1000000000ULL, &remainder);
+	ts->tv_nsec = remainder;
+
+	return 0;
+}
+
+static int octeon3_settime(struct ptp_clock_info *ptp,
+			   const struct timespec *ts)
+{
+	struct octeon3_ethernet	*priv;
+	u64			ns;
+	unsigned long		flags;
+
+	priv = container_of(ptp, struct octeon3_ethernet, ptp_info);
+	ns = timespec_to_ns(ts);
+
+	spin_lock_irqsave(&priv->ptp_lock, flags);
+	timecounter_init(&priv->tc, &priv->cc, ns);
+	spin_unlock_irqrestore(&priv->ptp_lock, flags);
+
+	return 0;
+}
+
+static int octeon3_enable(struct ptp_clock_info *ptp,
+			  struct ptp_clock_request *rq, int on)
+{
+	return -EOPNOTSUPP;
+}
+
+static int octeon3_ioctl(struct net_device *netdev, struct ifreq *ifr, int cmd)
+{
+	int rc;
+
+	switch (cmd) {
+	case SIOCSHWTSTAMP:
+		rc = octeon3_ioctl_hwtstamp(netdev, ifr, cmd);
+		break;
+
+	default:
+		rc = bgx_port_do_ioctl(netdev, ifr, cmd);
+		break;
+	}
+
+	return rc;
+}
+
+static const struct net_device_ops octeon3_eth_netdev_ops = {
+	.ndo_init		= octeon3_eth_bgx_ndo_init,
+	.ndo_uninit		= octeon3_eth_ndo_uninit,
+	.ndo_open		= octeon3_eth_bgx_ndo_open,
+	.ndo_stop		= octeon3_eth_bgx_ndo_stop,
+	.ndo_start_xmit		= octeon3_eth_ndo_start_xmit,
+	.ndo_get_stats64	= octeon3_eth_ndo_get_stats64,
+	.ndo_set_rx_mode	= bgx_port_set_rx_filtering,
+	.ndo_set_mac_address	= octeon3_eth_set_mac_address,
+	.ndo_change_mtu		= bgx_port_change_mtu,
+	.ndo_do_ioctl		= octeon3_ioctl,
+};
+
+static int octeon3_eth_probe(struct platform_device *pdev)
+{
+	struct octeon3_ethernet *priv;
+	struct net_device *netdev;
+	int r;
+
+	struct mac_platform_data *pd = dev_get_platdata(&pdev->dev);
+
+	r = octeon3_eth_global_init(pd->numa_node, pdev);
+	if (r)
+		return r;
+
+	dev_info(&pdev->dev, "Probing %d-%d:%d\n",
+		 pd->numa_node, pd->interface, pd->port);
+	netdev = alloc_etherdev(sizeof(struct octeon3_ethernet));
+	if (!netdev) {
+		dev_err(&pdev->dev, "Failed to allocated ethernet device\n");
+		return -ENOMEM;
+	}
+
+	SET_NETDEV_DEV(netdev, &pdev->dev);
+	dev_set_drvdata(&pdev->dev, netdev);
+
+	if (pd->mac_type == BGX_MAC)
+		bgx_port_set_netdev(pdev->dev.parent, netdev);
+	priv = netdev_priv(netdev);
+	priv->netdev = netdev;
+	priv->mac_type = pd->mac_type;
+	INIT_LIST_HEAD(&priv->list);
+	priv->node = pd->numa_node;
+
+	mutex_lock(&octeon3_eth_node[priv->node].device_list_lock);
+	list_add_tail_rcu(&priv->list, &octeon3_eth_node[priv->node].device_list);
+	mutex_unlock(&octeon3_eth_node[priv->node].device_list_lock);
+
+	priv->index = pd->port;
+	priv->interface = pd->interface;
+	spin_lock_init(&priv->stat_lock);
+	INIT_DEFERRABLE_WORK(&priv->stat_work, octeon3_eth_stat_poll);
+
+	if (pd->src_type == XCV)
+		snprintf(netdev->name, IFNAMSIZ, "rgmii%d", pd->port);
+
+	if (priv->mac_type == BGX_MAC)
+		netdev->netdev_ops = &octeon3_eth_netdev_ops;
+
+	netdev->min_mtu = 60;
+	if (OCTEON_IS_MODEL(OCTEON_CN78XX_PASS1_X)) {
+		int fifo_size;
+		int max_mtu = 1500;
+
+		/* On 78XX-Pass1 the mtu must be limited.  The PKO may
+		 * to lock up when calculating the L4 checksum for
+		 * large packets. How large the packets can be depends
+		 * on the amount of pko fifo assigned to the port.
+		 *
+		 *   FIFO size                Max frame size
+		 *	2.5 KB				1920
+		 *	5.0 KB				4480
+		 *     10.0 KB				9600
+		 *
+		 * The maximum mtu is set to the largest frame size minus the
+		 * l2 header.
+		 */
+		fifo_size = octeon3_pko_get_fifo_size(priv->node, priv->interface,
+						      priv->index, priv->mac_type);
+
+		switch (fifo_size) {
+		case 2560:
+			max_mtu = 1920 - ETH_HLEN - ETH_FCS_LEN - (2 * VLAN_HLEN);
+			break;
+
+		case 5120:
+			max_mtu = 4480 - ETH_HLEN - ETH_FCS_LEN - (2 * VLAN_HLEN);
+			break;
+
+		case 10240:
+			max_mtu = 9600 - ETH_HLEN - ETH_FCS_LEN - (2 * VLAN_HLEN);
+			break;
+
+		default:
+			break;
+		}
+		netdev->max_mtu = max_mtu;
+	} else {
+		netdev->max_mtu = 65392;
+	}
+
+	if (register_netdev(netdev) < 0) {
+		dev_err(&pdev->dev, "Failed to register ethernet device\n");
+		list_del(&priv->list);
+		free_netdev(netdev);
+	}
+
+	spin_lock_init(&priv->ptp_lock);
+	priv->ptp_info.owner = THIS_MODULE;
+	snprintf(priv->ptp_info.name, 16, "octeon3 ptp");
+	priv->ptp_info.max_adj = 250000000;
+	priv->ptp_info.n_alarm = 0;
+	priv->ptp_info.n_ext_ts = 0;
+	priv->ptp_info.n_per_out = 0;
+	priv->ptp_info.pps = 0;
+	priv->ptp_info.adjfreq = octeon3_adjfreq;
+	priv->ptp_info.adjtime = octeon3_adjtime;
+	priv->ptp_info.gettime64 = octeon3_gettime;
+	priv->ptp_info.settime64 = octeon3_settime;
+	priv->ptp_info.enable = octeon3_enable;
+	priv->ptp_clock = ptp_clock_register(&priv->ptp_info, &pdev->dev);
+
+	netdev_info(netdev, "%d rx queues\n", rx_queues);
+	return 0;
+}
+
+/**
+ * octeon3_eth_global_exit() - Free all the used resources and restore the
+ *			       hardware to the default state.
+ * @node: Node to free/reset.
+ *
+ * Return: 0 if successful.
+ *	 < 0 for error codes.
+ */
+static int octeon3_eth_global_exit(int node)
+{
+	struct octeon3_ethernet_node	*oen = octeon3_eth_node + node;
+	int				i;
+
+	/* Free the tx_complete irq */
+	octeon3_sso_irq_set(node, oen->tx_complete_grp, false);
+	irq_set_affinity_hint(oen->tx_irq, NULL);
+	free_irq(oen->tx_irq, oen);
+	irq_dispose_mapping(oen->tx_irq);
+	oen->tx_irq = 0;
+
+	/* Stop the worker threads */
+	for (i = 0; i < ARRAY_SIZE(oen->workers); i++)
+		kthread_stop(oen->workers[i].task);
+
+	/* Shutdown pki */
+	octeon3_pki_shutdown(node);
+	octeon_fpa3_release_pool(node, oen->pki_packet_pool);
+	kfree(oen->pki_packet_pool_stack);
+
+	/* Shutdown pko */
+	octeon3_pko_exit_global(node);
+	for (;;) {
+		void **w;
+
+		w = octeon_fpa3_alloc(node, oen->pko_aura);
+		if (!w)
+			break;
+		kmem_cache_free(octeon3_eth_sso_pko_cache, w);
+	}
+	octeon_fpa3_release_aura(node, oen->pko_aura);
+	octeon_fpa3_release_pool(node, oen->pko_pool);
+	kfree(oen->pko_pool_stack);
+
+	/* Shutdown sso */
+	octeon3_sso_shutdown(node, oen->sso_aura);
+	octeon3_sso_free_grp(node, oen->tx_complete_grp);
+	for (;;) {
+		void **w;
+
+		w = octeon_fpa3_alloc(node, oen->sso_aura);
+		if (!w)
+			break;
+		kmem_cache_free(octeon3_eth_sso_pko_cache, w);
+	}
+	octeon_fpa3_release_aura(node, oen->sso_aura);
+	octeon_fpa3_release_pool(node, oen->sso_pool);
+	kfree(oen->sso_pool_stack);
+
+	return 0;
+}
+
+static int octeon3_eth_remove(struct platform_device *pdev)
+{
+	struct net_device		*netdev = dev_get_drvdata(&pdev->dev);
+	struct octeon3_ethernet		*priv = netdev_priv(netdev);
+	int				node = priv->node;
+	struct octeon3_ethernet_node	*oen = octeon3_eth_node + node;
+	struct mac_platform_data	*pd = dev_get_platdata(&pdev->dev);
+
+	ptp_clock_unregister(priv->ptp_clock);
+	unregister_netdev(netdev);
+	if (pd->mac_type == BGX_MAC)
+		bgx_port_set_netdev(pdev->dev.parent, NULL);
+	dev_set_drvdata(&pdev->dev, NULL);
+
+	/* Free all resources when there are no more devices */
+	mutex_lock(&octeon3_eth_init_mutex);
+	mutex_lock(&oen->device_list_lock);
+	list_del_rcu(&priv->list);
+	if (oen->init_done && list_empty(&oen->device_list)) {
+		oen->init_done = false;
+		octeon3_eth_global_exit(node);
+	}
+
+	mutex_unlock(&oen->device_list_lock);
+	mutex_unlock(&octeon3_eth_init_mutex);
+	free_netdev(netdev);
+
+	return 0;
+}
+
+static void octeon3_eth_shutdown(struct platform_device *pdev)
+{
+	octeon3_eth_remove(pdev);
+}
+
+static struct platform_driver octeon3_eth_driver = {
+	.probe		= octeon3_eth_probe,
+	.remove		= octeon3_eth_remove,
+	.shutdown       = octeon3_eth_shutdown,
+	.driver		= {
+		.owner	= THIS_MODULE,
+		.name	= "ethernet-mac-pki",
+	},
+};
+
+static int __init octeon3_eth_init(void)
+{
+	int nr = num_online_cpus();
+
+	if (nr >= 4)
+		rx_queues = 4;
+	else if (nr >= 2)
+		rx_queues = 2;
+	else
+		rx_queues = 1;
+
+	return platform_driver_register(&octeon3_eth_driver);
+}
+module_init(octeon3_eth_init);
+
+static void __exit octeon3_eth_exit(void)
+{
+	platform_driver_unregister(&octeon3_eth_driver);
+
+	/* Destroy the memory cache used by sso and pko */
+	kmem_cache_destroy(octeon3_eth_sso_pko_cache);
+}
+module_exit(octeon3_eth_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Cavium, Inc. <support@caviumnetworks.com>");
+MODULE_DESCRIPTION("Cavium, Inc. PKI/PKO Ethernet driver.");
diff --git a/drivers/net/ethernet/cavium/octeon/octeon3-pki.c b/drivers/net/ethernet/cavium/octeon/octeon3-pki.c
new file mode 100644
index 000000000000..4be650872f41
--- /dev/null
+++ b/drivers/net/ethernet/cavium/octeon/octeon3-pki.c
@@ -0,0 +1,824 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2017 Cavium, Inc.
+ *
+ * Configuration and management of the PacKet Input (PKI) block.
+ */
+#include <linux/module.h>
+#include <linux/firmware.h>
+
+#include <asm/octeon/octeon.h>
+
+#include "octeon3.h"
+
+#define PKI_CLUSTER_FIRMWARE		"cavium/pki-cluster.bin"
+#define VERSION_LEN			8
+
+#define MAX_CLUSTERS			4
+#define MAX_BANKS			2
+#define MAX_BANK_ENTRIES		192
+#define PKI_NUM_QPG_ENTRY		2048
+#define PKI_NUM_STYLE			256
+#define PKI_NUM_FINAL_STYLE		64
+#define MAX_PKNDS			64
+
+/* Registers are accessed via xkphys */
+#define PKI_BASE			0x1180044000000ull
+#define PKI_ADDR(node)			(SET_XKPHYS + NODE_OFFSET(node) +      \
+					 PKI_BASE)
+
+#define PKI_SFT_RST(n)			(PKI_ADDR(n)		     + 0x000010)
+#define PKI_BUF_CTL(n)			(PKI_ADDR(n)		     + 0x000100)
+#define PKI_STAT_CTL(n)			(PKI_ADDR(n)		     + 0x000110)
+#define PKI_ICG_CFG(n)			(PKI_ADDR(n)		     + 0x00a000)
+
+#define CLUSTER_OFFSET(c)		((c) << 16)
+#define CL_ADDR(n, c)			(PKI_ADDR(n) + CLUSTER_OFFSET(c))
+#define PKI_CL_ECC_CTL(n, c)		(CL_ADDR(n, c)		     + 0x00c020)
+
+#define PKI_STYLE_BUF(n, s)		(PKI_ADDR(n) + ((s) << 3)    + 0x024000)
+
+#define PKI_LTYPE_MAP(n, l)		(PKI_ADDR(n) + ((l) << 3)    + 0x005000)
+#define PKI_IMEM(n, i)			(PKI_ADDR(n) + ((i) << 3)    + 0x100000)
+
+#define PKI_CL_PKIND_CFG(n, c, p)	(CL_ADDR(n, c) + ((p) << 8)  + 0x300040)
+#define PKI_CL_PKIND_STYLE(n, c, p)	(CL_ADDR(n, c) + ((p) << 8)  + 0x300048)
+#define PKI_CL_PKIND_SKIP(n, c, p)	(CL_ADDR(n, c) + ((p) << 8)  + 0x300050)
+#define PKI_CL_PKIND_L2_CUSTOM(n, c, p)	(CL_ADDR(n, c) + ((p) << 8)  + 0x300058)
+#define PKI_CL_PKIND_LG_CUSTOM(n, c, p)	(CL_ADDR(n, c) + ((p) << 8)  + 0x300060)
+
+#define STYLE_OFFSET(s)			((s) << 3)
+#define STYLE_ADDR(n, c, s)		(PKI_ADDR(n) + CLUSTER_OFFSET(c) +     \
+					 STYLE_OFFSET(s))
+#define PKI_CL_STYLE_CFG(n, c, s)	(STYLE_ADDR(n, c, s)	     + 0x500000)
+#define PKI_CL_STYLE_CFG2(n, c, s)	(STYLE_ADDR(n, c, s)	     + 0x500800)
+#define PKI_CLX_STYLEX_ALG(n, c, s)	(STYLE_ADDR(n, c, s)	     + 0x501000)
+
+#define PCAM_OFFSET(bank)		((bank) << 12)
+#define PCAM_ENTRY_OFFSET(entry)	((entry) << 3)
+#define PCAM_ADDR(n, c, b, e)		(PKI_ADDR(n) + CLUSTER_OFFSET(c) +     \
+					 PCAM_OFFSET(b) + PCAM_ENTRY_OFFSET(e))
+#define PKI_CL_PCAM_TERM(n, c, b, e)	(PCAM_ADDR(n, c, b, e)	     + 0x700000)
+#define PKI_CL_PCAM_MATCH(n, c, b, e)	(PCAM_ADDR(n, c, b, e)	     + 0x704000)
+#define PKI_CL_PCAM_ACTION(n, c, b, e)	(PCAM_ADDR(n, c, b, e)	     + 0x708000)
+
+#define PKI_QPG_TBLX(n, i)		(PKI_ADDR(n) + ((i) << 3)    + 0x800000)
+#define PKI_AURAX_CFG(n, a)		(PKI_ADDR(n) + ((a) << 3)    + 0x900000)
+#define PKI_STATX_STAT0(n, p)		(PKI_ADDR(n) + ((p) << 8)    + 0xe00038)
+#define PKI_STATX_STAT1(n, p)		(PKI_ADDR(n) + ((p) << 8)    + 0xe00040)
+#define PKI_STATX_STAT3(n, p)		(PKI_ADDR(n) + ((p) << 8)    + 0xe00050)
+
+enum pcam_term {
+	NONE		= 0x0,
+	L2_CUSTOM	= 0x2,
+	HIGIGD		= 0x4,
+	HIGIG		= 0x5,
+	SMACH		= 0x8,
+	SMACL		= 0x9,
+	DMACH		= 0xa,
+	DMACL		= 0xb,
+	GLORT		= 0x12,
+	DSA		= 0x13,
+	ETHTYPE0	= 0x18,
+	ETHTYPE1	= 0x19,
+	ETHTYPE2	= 0x1a,
+	ETHTYPE3	= 0x1b,
+	MPLS0		= 0x1e,
+	L3_SIPHH	= 0x1f,
+	L3_SIPMH	= 0x20,
+	L3_SIPML	= 0x21,
+	L3_SIPLL	= 0x22,
+	L3_FLAGS	= 0x23,
+	L3_DIPHH	= 0x24,
+	L3_DIPMH	= 0x25,
+	L3_DIPML	= 0x26,
+	L3_DIPLL	= 0x27,
+	LD_VNI		= 0x28,
+	IL3_FLAGS	= 0x2b,
+	LF_SPI		= 0x2e,
+	L4_SPORT	= 0x2f,
+	L4_PORT		= 0x30,
+	LG_CUSTOM	= 0x39
+};
+
+enum pki_ltype {
+	LTYPE_NONE		= 0x00,
+	LTYPE_ENET		= 0x01,
+	LTYPE_VLAN		= 0x02,
+	LTYPE_SNAP_PAYLD	= 0x05,
+	LTYPE_ARP		= 0x06,
+	LTYPE_RARP		= 0x07,
+	LTYPE_IP4		= 0x08,
+	LTYPE_IP4_OPT		= 0x09,
+	LTYPE_IP6		= 0x0a,
+	LTYPE_IP6_OPT		= 0x0b,
+	LTYPE_IPSEC_ESP		= 0x0c,
+	LTYPE_IPFRAG		= 0x0d,
+	LTYPE_IPCOMP		= 0x0e,
+	LTYPE_TCP		= 0x10,
+	LTYPE_UDP		= 0x11,
+	LTYPE_SCTP		= 0x12,
+	LTYPE_UDP_VXLAN		= 0x13,
+	LTYPE_GRE		= 0x14,
+	LTYPE_NVGRE		= 0x15,
+	LTYPE_GTP		= 0x16,
+	LTYPE_UDP_GENEVE	= 0x17,
+	LTYPE_SW28		= 0x1c,
+	LTYPE_SW29		= 0x1d,
+	LTYPE_SW30		= 0x1e,
+	LTYPE_SW31		= 0x1f
+};
+
+enum pki_beltype {
+	BELTYPE_NONE	= 0x00,
+	BELTYPE_MISC	= 0x01,
+	BELTYPE_IP4	= 0x02,
+	BELTYPE_IP6	= 0x03,
+	BELTYPE_TCP	= 0x04,
+	BELTYPE_UDP	= 0x05,
+	BELTYPE_SCTP	= 0x06,
+	BELTYPE_SNAP	= 0x07
+};
+
+struct ltype_beltype {
+	enum pki_ltype		ltype;
+	enum pki_beltype	beltype;
+};
+
+/**
+ * struct pcam_term_info - Describes a term to configure in the pcam.
+ * @term:	Identifies the term to configure.
+ * @term_mask:	Specifies don't cares in the term.
+ * @style:	Style to compare.
+ * @style_mask:	Specifies don't cares in the style.
+ * @data:	Data to compare.
+ * @data_mask:	Specifies don't cares in the data.
+ */
+struct pcam_term_info {
+	u8	term;
+	u8	term_mask;
+	u8	style;
+	u8	style_mask;
+	u32	data;
+	u32	data_mask;
+};
+
+/**
+ * struct fw_hdr - Describes the firmware.
+ * @version:	Firmware version.
+ * @size:	Size of the data in bytes.
+ * @data:	Actual firmware data.
+ */
+struct fw_hdr {
+	char	version[VERSION_LEN];
+	u64	size;
+	u64	data[];
+};
+
+static struct ltype_beltype dflt_ltype_config[] = {
+	{ LTYPE_NONE,		BELTYPE_NONE },
+	{ LTYPE_ENET,		BELTYPE_MISC },
+	{ LTYPE_VLAN,		BELTYPE_MISC },
+	{ LTYPE_SNAP_PAYLD,	BELTYPE_MISC },
+	{ LTYPE_ARP,		BELTYPE_MISC },
+	{ LTYPE_RARP,		BELTYPE_MISC },
+	{ LTYPE_IP4,		BELTYPE_IP4  },
+	{ LTYPE_IP4_OPT,	BELTYPE_IP4  },
+	{ LTYPE_IP6,		BELTYPE_IP6  },
+	{ LTYPE_IP6_OPT,	BELTYPE_IP6  },
+	{ LTYPE_IPSEC_ESP,	BELTYPE_MISC },
+	{ LTYPE_IPFRAG,		BELTYPE_MISC },
+	{ LTYPE_IPCOMP,		BELTYPE_MISC },
+	{ LTYPE_TCP,		BELTYPE_TCP  },
+	{ LTYPE_UDP,		BELTYPE_UDP  },
+	{ LTYPE_SCTP,		BELTYPE_SCTP },
+	{ LTYPE_UDP_VXLAN,	BELTYPE_UDP  },
+	{ LTYPE_GRE,		BELTYPE_MISC },
+	{ LTYPE_NVGRE,		BELTYPE_MISC },
+	{ LTYPE_GTP,		BELTYPE_MISC },
+	{ LTYPE_UDP_GENEVE,	BELTYPE_UDP  },
+	{ LTYPE_SW28,		BELTYPE_MISC },
+	{ LTYPE_SW29,		BELTYPE_MISC },
+	{ LTYPE_SW30,		BELTYPE_MISC },
+	{ LTYPE_SW31,		BELTYPE_MISC }
+};
+
+static int get_num_clusters(void)
+{
+	if (OCTEON_IS_MODEL(OCTEON_CN73XX) || OCTEON_IS_MODEL(OCTEON_CNF75XX))
+		return 2;
+	return 4;
+}
+
+static int octeon3_pki_pcam_alloc_entry(int node, int entry, int bank)
+{
+	struct global_resource_tag tag;
+	char buf[16];
+	int num_clusters;
+	int rc;
+	int i;
+
+	/* Allocate a pcam entry for cluster0*/
+	strncpy((char *)&tag.lo, "cvm_pcam", 8);
+	snprintf(buf, 16, "_%d%d%d....", node, 0, bank);
+	memcpy(&tag.hi, buf, 8);
+
+	res_mgr_create_resource(tag, MAX_BANK_ENTRIES);
+	rc = res_mgr_alloc(tag, entry, false);
+	if (rc < 0)
+		return rc;
+
+	entry = rc;
+
+	/* Need to allocate entries for all clusters as se code needs it */
+	num_clusters = get_num_clusters();
+	for (i = 1; i < num_clusters; i++) {
+		strncpy((char *)&tag.lo, "cvm_pcam", 8);
+		snprintf(buf, 16, "_%d%d%d....", node, i, bank);
+		memcpy(&tag.hi, buf, 8);
+
+		res_mgr_create_resource(tag, MAX_BANK_ENTRIES);
+		rc = res_mgr_alloc(tag, entry, false);
+		if (rc < 0) {
+			int	j;
+
+			pr_err("octeon3-pki: Failed to allocate pcam entry\n");
+			/* Undo whatever we've did */
+			for (j = 0; i < i; j++) {
+				strncpy((char *)&tag.lo, "cvm_pcam", 8);
+				snprintf(buf, 16, "_%d%d%d....", node, j, bank);
+				memcpy(&tag.hi, buf, 8);
+				res_mgr_free(tag, entry);
+			}
+
+			return -1;
+		}
+	}
+
+	return entry;
+}
+
+static int octeon3_pki_pcam_write_entry(int node,
+					struct pcam_term_info *term_info)
+{
+	int bank;
+	int entry;
+	int num_clusters;
+	u64 term;
+	u64 match;
+	u64 action;
+	int i;
+
+	/* Bit 0 of the pcam term determines the bank to use */
+	bank = term_info->term & 1;
+
+	/* Allocate a pcam entry */
+	entry = octeon3_pki_pcam_alloc_entry(node, -1, bank);
+	if (entry < 0)
+		return entry;
+
+	term = 1ull << 63;
+	term |= (u64)(term_info->term & term_info->term_mask) << 40;
+	term |= (~term_info->term & term_info->term_mask) << 8;
+	term |= (u64)(term_info->style & term_info->style_mask) << 32;
+	term |= ~term_info->style & term_info->style_mask;
+
+	match = (u64)(term_info->data & term_info->data_mask) << 32;
+	match |= ~term_info->data & term_info->data_mask;
+
+	action = 0;
+	if (term_info->term >= ETHTYPE0 && term_info->term <= ETHTYPE3) {
+		action |= 2 << 8;
+		action |= 4;
+	}
+
+	/* Must write the term to all clusters */
+	num_clusters = get_num_clusters();
+	for (i = 0; i < num_clusters; i++) {
+		oct_csr_write(0, PKI_CL_PCAM_TERM(node, i, bank, entry));
+		oct_csr_write(match, PKI_CL_PCAM_MATCH(node, i, bank, entry));
+		oct_csr_write(action, PKI_CL_PCAM_ACTION(node, i, bank, entry));
+		oct_csr_write(term, PKI_CL_PCAM_TERM(node, i, bank, entry));
+	}
+
+	return 0;
+}
+
+static int octeon3_pki_alloc_qpg_entry(int node)
+{
+	struct global_resource_tag tag;
+	char buf[16];
+	int entry;
+
+	/* Allocate a qpg entry */
+	strncpy((char *)&tag.lo, "cvm_qpge", 8);
+	snprintf(buf, 16, "t_%d.....", node);
+	memcpy(&tag.hi, buf, 8);
+
+	res_mgr_create_resource(tag, PKI_NUM_QPG_ENTRY);
+	entry = res_mgr_alloc(tag, -1, false);
+	if (entry < 0)
+		pr_err("octeon3-pki: Failed to allocate qpg entry");
+
+	return entry;
+}
+
+static int octeon3_pki_alloc_style(int node)
+{
+	struct global_resource_tag tag;
+	char buf[16];
+	int entry;
+
+	/* Allocate a style entry */
+	strncpy((char *)&tag.lo, "cvm_styl", 8);
+	snprintf(buf, 16, "e_%d.....", node);
+	memcpy(&tag.hi, buf, 8);
+
+	res_mgr_create_resource(tag, PKI_NUM_STYLE);
+	entry = res_mgr_alloc(tag, -1, false);
+	if (entry < 0)
+		pr_err("octeon3-pki: Failed to allocate style");
+
+	return entry;
+}
+
+int octeon3_pki_set_ptp_skip(int node, int pknd, int skip)
+{
+	u64 data;
+	int num_clusters;
+	u64 i;
+
+	num_clusters = get_num_clusters();
+	for (i = 0; i < num_clusters; i++) {
+		data = oct_csr_read(PKI_CL_PKIND_SKIP(node, i, pknd));
+		data &= ~(GENMASK_ULL(15, 8) | GENMASK_ULL(7, 0));
+		data |= (skip << 8) | skip;
+		oct_csr_write(data, PKI_CL_PKIND_SKIP(node, i, pknd));
+
+		data = oct_csr_read(PKI_CL_PKIND_L2_CUSTOM(node, i, pknd));
+		data &= ~GENMASK_ULL(7, 0);
+		data |= skip;
+		oct_csr_write(data, PKI_CL_PKIND_L2_CUSTOM(node, i, pknd));
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(octeon3_pki_set_ptp_skip);
+
+/**
+ * octeon3_pki_get_stats() - Get the statistics for a given pknd (port).
+ * @node:	Node to get statistics for.
+ * @pknd:	Pknd to get statistis for.
+ * @packets:	Updated with the number of packets received.
+ * @octets:	Updated with the number of octets received.
+ * @dropped:	Updated with the number of dropped packets.
+ *
+ * Return: 0 if successful.
+ *	   < 0 for error codes.
+ */
+int octeon3_pki_get_stats(int node, int pknd,
+			  u64 *packets, u64 *octets, u64 *dropped)
+{
+	/* PKI-20775, must read until not all ones. */
+	do {
+		*packets = oct_csr_read(PKI_STATX_STAT0(node, pknd));
+	} while (*packets == 0xffffffffffffffffull);
+
+	do {
+		*octets = oct_csr_read(PKI_STATX_STAT1(node, pknd));
+	} while (*octets == 0xffffffffffffffffull);
+
+	do {
+		*dropped = oct_csr_read(PKI_STATX_STAT3(node, pknd));
+	} while (*dropped == 0xffffffffffffffffull);
+
+	return 0;
+}
+EXPORT_SYMBOL(octeon3_pki_get_stats);
+
+/**
+ * octeon3_pki_port_init() - Initialize a port.
+ * @node:	Node port is using.
+ * @aura:	Aura to use for packet buffers.
+ * @grp:	SSO group packets will be queued up for.
+ * @skip:	Extra bytes to skip before packet data.
+ * @mb_size:	Size of packet buffers.
+ * @pknd:	Port kind assigned to the port.
+ * @num_rx_cxt:	Number of sso groups used by the port.
+ *
+ * Return: 0 if successful.
+ *	   < 0 for error codes.
+ */
+int octeon3_pki_port_init(int node, int aura, int grp, int skip,
+			  int mb_size, int pknd, int num_rx_cxt)
+{
+	int qpg_entry;
+	int style;
+	u64 data;
+	int num_clusters;
+	u64 i;
+
+	/* Allocate and configure a qpg table entry for the port's group */
+	i = 0;
+	while ((num_rx_cxt & (1 << i)) == 0)
+		i++;
+	qpg_entry = octeon3_pki_alloc_qpg_entry(node);
+	data = i << 45;				/* GRPTAG_OK */
+	data |= ((u64)((node << 8) | grp) << 32); /* GRP_OK */
+	data |= i << 29;			/* GRPTAG_BAD*/
+	data |= ((u64)((node << 8) | grp) << 16); /* GRP_BAD */
+	data |= aura;				/* LAURA */
+	oct_csr_write(data, PKI_QPG_TBLX(node, qpg_entry));
+
+	/* Allocate a style for the port */
+	style = octeon3_pki_alloc_style(node);
+
+	/* Map the qpg table entry to the style */
+	num_clusters = get_num_clusters();
+	for (i = 0; i < num_clusters; i++) {
+		data = BIT(29) | BIT(22) | qpg_entry;
+		oct_csr_write(data, PKI_CL_STYLE_CFG(node, i, style));
+
+		/* Specify the tag generation rules and checksum to use */
+		oct_csr_write(0xfff49f, PKI_CL_STYLE_CFG2(node, i, style));
+
+		data = BIT(31);
+		oct_csr_write(data, PKI_CLX_STYLEX_ALG(node, i, style));
+	}
+
+	/* Set the style's buffer size and skips:
+	 *	Every buffer has 128 bytes reserved for Linux.
+	 *	The first buffer must also skip the wqe (40 bytes).
+	 *	Srio also requires skipping its header (skip)
+	 */
+	data = 1ull << 28;			/* WQE_SKIP */
+#ifdef __LITTLE_ENDIAN
+	data |= BIT(32);			/* PKT_LEND */
+#endif
+	data |= ((128 + 40 + skip) / 8) << 22;	/* FIRST_SKIP */
+	data |= (128 / 8) << 16;		/* LATER_SKIP */
+	data |= (mb_size & ~0xf) / 8;		/* MB_SIZE */
+	oct_csr_write(data, PKI_STYLE_BUF(node, style));
+
+	/* Assign the initial style to the port via the pknd */
+	for (i = 0; i < num_clusters; i++) {
+		data = oct_csr_read(PKI_CL_PKIND_STYLE(node, i, pknd));
+		data &= ~GENMASK_ULL(7, 0);
+		data |= style;
+		oct_csr_write(data, PKI_CL_PKIND_STYLE(node, i, pknd));
+	}
+
+	/* Enable red */
+	data = BIT(18);
+	oct_csr_write(data, PKI_AURAX_CFG(node, aura));
+
+	/* Clear statistic counters */
+	oct_csr_write(0, PKI_STATX_STAT0(node, pknd));
+	oct_csr_write(0, PKI_STATX_STAT1(node, pknd));
+	oct_csr_write(0, PKI_STATX_STAT3(node, pknd));
+
+	return 0;
+}
+EXPORT_SYMBOL(octeon3_pki_port_init);
+
+/**
+ * octeon3_pki_port_shutdown() - Release all the resources used by a port.
+ * @node: Node port is on.
+ * @pknd: Pknd assigned to the port.
+ *
+ * Return: 0 if successful.
+ *	   < 0 for error codes.
+ */
+int octeon3_pki_port_shutdown(int node, int pknd)
+{
+	/* Nothing at the moment */
+	return 0;
+}
+EXPORT_SYMBOL(octeon3_pki_port_shutdown);
+
+/**
+ * octeon3_pki_cluster_init() - Loads the cluster firmware into the
+ *				pki clusters.
+ * @node: Node to configure.
+ * @pdev: Device requesting the firmware.
+ *
+ * Return: 0 if successful.
+ *	   < 0 for error codes.
+ */
+int octeon3_pki_cluster_init(int node, struct platform_device *pdev)
+{
+	const struct firmware *pki_fw;
+	const struct fw_hdr *hdr;
+	const u64 *data;
+	int i;
+	int rc;
+
+	rc = request_firmware(&pki_fw, PKI_CLUSTER_FIRMWARE, &pdev->dev);
+	if (rc) {
+		dev_err(&pdev->dev, "octeon3-pki: Failed to load %s error=%d\n",
+			PKI_CLUSTER_FIRMWARE, rc);
+		return rc;
+	}
+
+	/* Verify the firmware is valid */
+	hdr = (const struct fw_hdr *)pki_fw->data;
+	if ((pki_fw->size - sizeof(const struct fw_hdr) != hdr->size) ||
+	    hdr->size % 8) {
+		dev_err(&pdev->dev, ("octeon3-pki: Corrupted PKI firmware\n"));
+		goto err;
+	}
+
+	dev_info(&pdev->dev, "octeon3-pki: Loading PKI firmware %s\n",
+		 hdr->version);
+	data = hdr->data;
+	for (i = 0; i < hdr->size / 8; i++) {
+		oct_csr_write(cpu_to_be64(*data), PKI_IMEM(node, i));
+		data++;
+	}
+
+err:
+	release_firmware(pki_fw);
+
+	return 0;
+}
+EXPORT_SYMBOL(octeon3_pki_cluster_init);
+
+/**
+ * octeon3_pki_vlan_init() - Configures the pcam to recognize the vlan ethtypes.
+ *
+ * @node: Node to configure.
+ *
+ * Return: 0 if successful.
+ *	   < 0 for error codes.
+ */
+int octeon3_pki_vlan_init(int node)
+{
+	u64 data;
+	int i;
+	int rc;
+
+	/* PKI-20858 */
+	if (OCTEON_IS_MODEL(OCTEON_CN78XX_PASS1_X)) {
+		for (i = 0; i < 4; i++) {
+			data = oct_csr_read(PKI_CL_ECC_CTL(node, i));
+			data &= ~BIT(63);
+			data |= BIT(4) | BIT(3);
+			oct_csr_write(data, PKI_CL_ECC_CTL(node, i));
+		}
+	}
+
+	/* Configure the pcam ethtype0 and ethtype1 terms */
+	for (i = ETHTYPE0; i <= ETHTYPE1; i++) {
+		struct pcam_term_info term_info;
+
+		/* Term for 0x8100 ethtype */
+		term_info.term = i;
+		term_info.term_mask = 0xfd;
+		term_info.style = 0;
+		term_info.style_mask = 0;
+		term_info.data = 0x81000000;
+		term_info.data_mask = 0xffff0000;
+		rc = octeon3_pki_pcam_write_entry(node, &term_info);
+		if (rc)
+			return rc;
+
+		/* Term for 0x88a8 ethtype */
+		term_info.data = 0x88a80000;
+		rc = octeon3_pki_pcam_write_entry(node, &term_info);
+		if (rc)
+			return rc;
+
+		/* Term for 0x9200 ethtype */
+		term_info.data = 0x92000000;
+		rc = octeon3_pki_pcam_write_entry(node, &term_info);
+		if (rc)
+			return rc;
+
+		/* Term for 0x9100 ethtype */
+		term_info.data = 0x91000000;
+		rc = octeon3_pki_pcam_write_entry(node, &term_info);
+		if (rc)
+			return rc;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(octeon3_pki_vlan_init);
+
+/**
+ * octeon3_pki_ltype_init() - Configures the pki layer types.
+ *
+ * @node: Node to configure.
+ *
+ * Return: 0 if successful.
+ *	   < 0 for error codes.
+ */
+int octeon3_pki_ltype_init(int node)
+{
+	enum pki_ltype ltype;
+	u64 data;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(dflt_ltype_config); i++) {
+		ltype = dflt_ltype_config[i].ltype;
+		data = oct_csr_read(PKI_LTYPE_MAP(node, ltype));
+		data &= ~GENMASK_ULL(2, 0);
+		data |= dflt_ltype_config[i].beltype;
+		oct_csr_write(data, PKI_LTYPE_MAP(node, ltype));
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(octeon3_pki_ltype_init);
+
+int octeon3_pki_srio_init(int node, int pknd)
+{
+	u64 data;
+	int num_clusters;
+	int style;
+	int i;
+
+	num_clusters = get_num_clusters();
+	for (i = 0; i < num_clusters; i++) {
+		data = oct_csr_read(PKI_CL_PKIND_STYLE(node, i, pknd));
+		style = data & GENMASK_ULL(7, 0);
+		data &= ~GENMASK_ULL(14, 8);
+		oct_csr_write(data, PKI_CL_PKIND_STYLE(node, i, pknd));
+
+		/* Disable packet length errors and fcs */
+		data = oct_csr_read(PKI_CL_STYLE_CFG(node, i, style));
+		data &= ~(BIT(29) | BIT(26) | BIT(25) | BIT(23) | BIT(22));
+		oct_csr_write(data, PKI_CL_STYLE_CFG(node, i, style));
+
+		/* Packets have no fcs */
+		data = oct_csr_read(PKI_CL_PKIND_CFG(node, i, pknd));
+		data &= ~BIT(7);
+		oct_csr_write(data, PKI_CL_PKIND_CFG(node, i, pknd));
+
+		/* Skip the srio header and the INST_HDR_S data */
+		data = oct_csr_read(PKI_CL_PKIND_SKIP(node, i, pknd));
+		data &= ~(GENMASK_ULL(15, 8) | GENMASK_ULL(7, 0));
+		data |= (16 << 8) | 16;
+		oct_csr_write(data, PKI_CL_PKIND_SKIP(node, i, pknd));
+
+		/* Exclude port number from qpg */
+		data = oct_csr_read(PKI_CLX_STYLEX_ALG(node, i, style));
+		data &= ~GENMASK_ULL(20, 17);
+		oct_csr_write(data, PKI_CLX_STYLEX_ALG(node, i, style));
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(octeon3_pki_srio_init);
+
+/**
+ * octeon3_pki_enable() - Enable the pki.
+ *
+ * @node: Node to configure.
+ *
+ * Return: 0 if successful.
+ *	   < 0 for error codes.
+ */
+int octeon3_pki_enable(int node)
+{
+	u64 data;
+	int timeout;
+
+	/* Enable backpressure */
+	data = oct_csr_read(PKI_BUF_CTL(node));
+	data |= BIT(2);
+	oct_csr_write(data, PKI_BUF_CTL(node));
+
+	/* Enable cluster parsing */
+	data = oct_csr_read(PKI_ICG_CFG(node));
+	data |= BIT(24);
+	oct_csr_write(data, PKI_ICG_CFG(node));
+
+	/* Wait until the pki is out of reset */
+	timeout = 10000;
+	do {
+		data = oct_csr_read(PKI_SFT_RST(node));
+		if (!(data & BIT(63)))
+			break;
+		timeout--;
+		udelay(1);
+	} while (timeout);
+	if (!timeout) {
+		pr_err("octeon3-pki: timeout waiting for reset\n");
+		return -1;
+	}
+
+	/* Enable the pki */
+	data = oct_csr_read(PKI_BUF_CTL(node));
+	data |= BIT(0);
+	oct_csr_write(data, PKI_BUF_CTL(node));
+
+	/* Statistics are kept per pkind */
+	oct_csr_write(0, PKI_STAT_CTL(node));
+
+	return 0;
+}
+EXPORT_SYMBOL(octeon3_pki_enable);
+
+void octeon3_pki_shutdown(int node)
+{
+	struct global_resource_tag tag;
+	char buf[16];
+	u64 data;
+	int timeout;
+	int i;
+	int j;
+	int k;
+
+	/* Disable the pki */
+	data = oct_csr_read(PKI_BUF_CTL(node));
+	if (data & BIT(0)) {
+		data &= ~BIT(0);
+		oct_csr_write(data, PKI_BUF_CTL(node));
+
+		/* Wait until the pki has finished processing packets */
+		timeout = 10000;
+		do {
+			data = oct_csr_read(PKI_SFT_RST(node));
+			if (data & BIT(32))
+				break;
+			timeout--;
+			udelay(1);
+		} while (timeout);
+		if (!timeout)
+			pr_warn("octeon3_pki: disable timeout\n");
+	}
+
+	/* Free all prefetched fpa buffers back to the fpa */
+	data = oct_csr_read(PKI_BUF_CTL(node));
+	data |= BIT(5) | BIT(9);
+	oct_csr_write(data, PKI_BUF_CTL(node));
+	/* Dummy read to get the register write to take effect */
+	data = oct_csr_read(PKI_BUF_CTL(node));
+
+	/* Now we can reset the pki */
+	data = oct_csr_read(PKI_SFT_RST(node));
+	data |= BIT(0);
+	oct_csr_write(data, PKI_SFT_RST(node));
+	timeout = 10000;
+	do {
+		data = oct_csr_read(PKI_SFT_RST(node));
+		if ((data & BIT(63)) == 0)
+			break;
+		timeout--;
+		udelay(1);
+	} while (timeout);
+	if (!timeout)
+		pr_warn("octeon3_pki: reset timeout\n");
+
+	/* Free all the allocated resources. We should only free the resources
+	 * allocated by us (TODO).
+	 */
+	for (i = 0; i < PKI_NUM_STYLE; i++) {
+		strncpy((char *)&tag.lo, "cvm_styl", 8);
+		snprintf(buf, 16, "e_%d.....", node);
+		memcpy(&tag.hi, buf, 8);
+		res_mgr_free(tag, i);
+	}
+	for (i = 0; i < PKI_NUM_QPG_ENTRY; i++) {
+		strncpy((char *)&tag.lo, "cvm_qpge", 8);
+		snprintf(buf, 16, "t_%d.....", node);
+		memcpy(&tag.hi, buf, 8);
+		res_mgr_free(tag, i);
+	}
+	for (i = 0; i < get_num_clusters(); i++) {
+		for (j = 0; j < MAX_BANKS; j++) {
+			strncpy((char *)&tag.lo, "cvm_pcam", 8);
+			snprintf(buf, 16, "_%d%d%d....", node, i, j);
+			memcpy(&tag.hi, buf, 8);
+			for (k = 0; k < MAX_BANK_ENTRIES; k++)
+				res_mgr_free(tag, k);
+		}
+	}
+
+	/* Restore the registers back to their reset state. We should only reset
+	 * the registers used by us (TODO).
+	 */
+	for (i = 0; i < get_num_clusters(); i++) {
+		for (j = 0; j < MAX_PKNDS; j++) {
+			oct_csr_write(0, PKI_CL_PKIND_CFG(node, i, j));
+			oct_csr_write(0, PKI_CL_PKIND_STYLE(node, i, j));
+			oct_csr_write(0, PKI_CL_PKIND_SKIP(node, i, j));
+			oct_csr_write(0, PKI_CL_PKIND_L2_CUSTOM(node, i, j));
+			oct_csr_write(0, PKI_CL_PKIND_LG_CUSTOM(node, i, j));
+		}
+
+		for (j = 0; j < PKI_NUM_FINAL_STYLE; j++) {
+			oct_csr_write(0, PKI_CL_STYLE_CFG(node, i, j));
+			oct_csr_write(0, PKI_CL_STYLE_CFG2(node, i, j));
+			oct_csr_write(0, PKI_CLX_STYLEX_ALG(node, i, j));
+		}
+	}
+	for (i = 0; i < PKI_NUM_FINAL_STYLE; i++)
+		oct_csr_write((0x5 << 22) | 0x20, PKI_STYLE_BUF(node, i));
+}
+EXPORT_SYMBOL(octeon3_pki_shutdown);
+
+MODULE_LICENSE("GPL");
+MODULE_FIRMWARE(PKI_CLUSTER_FIRMWARE);
+MODULE_AUTHOR("Carlos Munoz <cmunoz@cavium.com>");
+MODULE_DESCRIPTION("Cavium, Inc. PKI management.");
diff --git a/drivers/net/ethernet/cavium/octeon/octeon3-pko.c b/drivers/net/ethernet/cavium/octeon/octeon3-pko.c
new file mode 100644
index 000000000000..8371b326fe44
--- /dev/null
+++ b/drivers/net/ethernet/cavium/octeon/octeon3-pko.c
@@ -0,0 +1,1688 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2017 Cavium, Inc.
+ *
+ * Configuration and management of the PacKet Output (PKO) block.
+ */
+#include <linux/module.h>
+
+#include <asm/octeon/octeon.h>
+
+#include "octeon3.h"
+
+#define MAX_OUTPUT_MAC			28
+#define MAX_FIFO_GRP			8
+
+#define FIFO_SIZE			2560
+
+/* Registers are accessed via xkphys */
+#define PKO_BASE			0x1540000000000ull
+#define PKO_ADDR(node)			(SET_XKPHYS + NODE_OFFSET(node) +      \
+					 PKO_BASE)
+
+#define PKO_L1_SQ_SHAPE(n, q)		(PKO_ADDR(n) + ((q) << 9)    + 0x000010)
+#define PKO_L1_SQ_LINK(n, q)		(PKO_ADDR(n) + ((q) << 9)    + 0x000038)
+#define PKO_DQ_WM_CTL(n, q)		(PKO_ADDR(n) + ((q) << 9)    + 0x000040)
+#define PKO_L1_SQ_TOPOLOGY(n, q)	(PKO_ADDR(n) + ((q) << 9)    + 0x080000)
+#define PKO_L2_SQ_SCHEDULE(n, q)	(PKO_ADDR(n) + ((q) << 9)    + 0x080008)
+#define PKO_L3_L2_SQ_CHANNEL(n, q)	(PKO_ADDR(n) + ((q) << 9)    + 0x080038)
+#define PKO_CHANNEL_LEVEL(n)		(PKO_ADDR(n)		     + 0x0800f0)
+#define PKO_SHAPER_CFG(n)		(PKO_ADDR(n)		     + 0x0800f8)
+#define PKO_L2_SQ_TOPOLOGY(n, q)	(PKO_ADDR(n) + ((q) << 9)    + 0x100000)
+#define PKO_L3_SQ_SCHEDULE(n, q)	(PKO_ADDR(n) + ((q) << 9)    + 0x100008)
+#define PKO_L3_SQ_TOPOLOGY(n, q)	(PKO_ADDR(n) + ((q) << 9)    + 0x180000)
+#define PKO_L4_SQ_SCHEDULE(n, q)	(PKO_ADDR(n) + ((q) << 9)    + 0x180008)
+#define PKO_L4_SQ_TOPOLOGY(n, q)	(PKO_ADDR(n) + ((q) << 9)    + 0x200000)
+#define PKO_L5_SQ_SCHEDULE(n, q)	(PKO_ADDR(n) + ((q) << 9)    + 0x200008)
+#define PKO_L5_SQ_TOPOLOGY(n, q)	(PKO_ADDR(n) + ((q) << 9)    + 0x280000)
+#define PKO_DQ_SCHEDULE(n, q)		(PKO_ADDR(n) + ((q) << 9)    + 0x280008)
+#define PKO_DQ_SW_XOFF(n, q)		(PKO_ADDR(n) + ((q) << 9)    + 0x2800e0)
+#define PKO_DQ_TOPOLOGY(n, q)		(PKO_ADDR(n) + ((q) << 9)    + 0x300000)
+#define PKO_PDM_CFG(n)			(PKO_ADDR(n)		     + 0x800000)
+#define PKO_PDM_DQ_MINPAD(n, q)		(PKO_ADDR(n) + ((q) << 3)    + 0x8f0000)
+#define PKO_MAC_CFG(n, m)		(PKO_ADDR(n) + ((m) << 3)    + 0x900000)
+#define PKO_PTF_STATUS(n, f)		(PKO_ADDR(n) + ((f) << 3)    + 0x900100)
+#define PKO_PTGF_CFG(n, g)		(PKO_ADDR(n) + ((g) << 3)    + 0x900200)
+#define PKO_PTF_IOBP_CFG(n)		(PKO_ADDR(n)		     + 0x900300)
+#define PKO_MCI0_MAX_CRED(n, m)		(PKO_ADDR(n) + ((m) << 3)    + 0xa00000)
+#define PKO_MCI1_MAX_CRED(n, m)		(PKO_ADDR(n) + ((m) << 3)    + 0xa80000)
+#define PKO_LUT(n, c)			(PKO_ADDR(n) + ((c) << 3)    + 0xb00000)
+#define PKO_DPFI_STATUS(n)		(PKO_ADDR(n)		     + 0xc00000)
+#define PKO_DPFI_FLUSH(n)		(PKO_ADDR(n)		     + 0xc00008)
+#define PKO_DPFI_FPA_AURA(n)		(PKO_ADDR(n)		     + 0xc00010)
+#define PKO_DPFI_ENA(n)			(PKO_ADDR(n)		     + 0xc00018)
+#define PKO_STATUS(n)			(PKO_ADDR(n)		     + 0xd00000)
+#define PKO_ENABLE(n)			(PKO_ADDR(n)		     + 0xd00008)
+
+/* These levels mimic the pko internal linked queue structure */
+enum queue_level {
+	PQ	= 1,
+	L2_SQ	= 2,
+	L3_SQ	= 3,
+	L4_SQ	= 4,
+	L5_SQ	= 5,
+	DQ	= 6
+};
+
+enum pko_dqop_e {
+	DQOP_SEND,
+	DQOP_OPEN,
+	DQOP_CLOSE,
+	DQOP_QUERY
+};
+
+enum pko_dqstatus_e {
+	PASS = 0,
+	BADSTATE = 0x8,
+	NOFPABUF = 0x9,
+	NOPKOBUF = 0xa,
+	FAILRTNPTR = 0xb,
+	ALREADY = 0xc,
+	NOTCREATED = 0xd,
+	NOTEMPTY = 0xe,
+	SENDPKTDROP = 0xf
+};
+
+struct mac_info {
+	int	fifo_cnt;
+	int	prio;
+	int	speed;
+	int	fifo;
+	int	num_lmacs;
+};
+
+struct fifo_grp_info {
+	int	speed;
+	int	size;
+};
+
+static const int lut_index_78xx[] = {
+	0x200,
+	0x240,
+	0x280,
+	0x2c0,
+	0x300,
+	0x340
+};
+
+static const int lut_index_73xx[] = {
+	0x000,
+	0x040,
+	0x080
+};
+
+static enum queue_level max_sq_level(void)
+{
+	/* 73xx and 75xx only have 3 scheduler queue levels */
+	if (OCTEON_IS_MODEL(OCTEON_CN73XX) || OCTEON_IS_MODEL(OCTEON_CNF75XX))
+		return L3_SQ;
+
+	return L5_SQ;
+}
+
+static int get_num_fifos(void)
+{
+	if (OCTEON_IS_MODEL(OCTEON_CN73XX) || OCTEON_IS_MODEL(OCTEON_CNF75XX))
+		return 16;
+
+	return 28;
+}
+
+static int get_num_fifo_groups(void)
+{
+	if (OCTEON_IS_MODEL(OCTEON_CN73XX) || OCTEON_IS_MODEL(OCTEON_CNF75XX))
+		return 5;
+
+	return 8;
+}
+
+static int get_num_output_macs(void)
+{
+	if (OCTEON_IS_MODEL(OCTEON_CN78XX))
+		return 28;
+	else if (OCTEON_IS_MODEL(OCTEON_CNF75XX))
+		return 10;
+	else if (OCTEON_IS_MODEL(OCTEON_CN73XX))
+		return 14;
+
+	return 0;
+}
+
+static int get_output_mac(int interface, int index,
+			  enum octeon3_mac_type	mac_type)
+{
+	int mac;
+
+	/* Output macs are hardcoded in the hardware. See PKO Output MACs
+	 * section in the HRM.
+	 */
+	if (OCTEON_IS_MODEL(OCTEON_CN73XX) || OCTEON_IS_MODEL(OCTEON_CNF75XX)) {
+		if (mac_type == SRIO_MAC)
+			mac = 4 + 2 * interface + index;
+		else
+			mac = 2 + 4 * interface + index;
+	} else {
+		mac = 4 + 4 * interface + index;
+	}
+
+	return mac;
+}
+
+static int get_num_port_queues(void)
+{
+	if (OCTEON_IS_MODEL(OCTEON_CN73XX) || OCTEON_IS_MODEL(OCTEON_CNF75XX))
+		return 16;
+
+	return 32;
+}
+
+static int allocate_queues(int node, enum queue_level level,
+			   int num_queues, int *queues)
+{
+	struct global_resource_tag tag;
+	char buf[16];
+	int max_queues = 0;
+	int rc;
+
+	if (level == PQ) {
+		strncpy((char *)&tag.lo, "cvm_pkop", 8);
+		snprintf(buf, 16, "oq_%d....", node);
+		memcpy(&tag.hi, buf, 8);
+
+		if (OCTEON_IS_MODEL(OCTEON_CN78XX))
+			max_queues = 32;
+		else
+			max_queues = 16;
+	} else if (level == L2_SQ) {
+		strncpy((char *)&tag.lo, "cvm_pkol", 8);
+		snprintf(buf, 16, "2q_%d....", node);
+		memcpy(&tag.hi, buf, 8);
+
+		if (OCTEON_IS_MODEL(OCTEON_CN78XX))
+			max_queues = 512;
+		else
+			max_queues = 256;
+	} else if (level == L3_SQ) {
+		strncpy((char *)&tag.lo, "cvm_pkol", 8);
+		snprintf(buf, 16, "3q_%d....", node);
+		memcpy(&tag.hi, buf, 8);
+
+		if (OCTEON_IS_MODEL(OCTEON_CN78XX))
+			max_queues = 512;
+		else
+			max_queues = 256;
+	} else if (level == L4_SQ) {
+		strncpy((char *)&tag.lo, "cvm_pkol", 8);
+		snprintf(buf, 16, "4q_%d....", node);
+		memcpy(&tag.hi, buf, 8);
+
+		if (OCTEON_IS_MODEL(OCTEON_CN78XX))
+			max_queues = 1024;
+		else
+			max_queues = 0;
+	} else if (level == L5_SQ) {
+		strncpy((char *)&tag.lo, "cvm_pkol", 8);
+		snprintf(buf, 16, "5q_%d....", node);
+		memcpy(&tag.hi, buf, 8);
+
+		if (OCTEON_IS_MODEL(OCTEON_CN78XX))
+			max_queues = 1024;
+		else
+			max_queues = 0;
+	} else if (level == DQ) {
+		strncpy((char *)&tag.lo, "cvm_pkod", 8);
+		snprintf(buf, 16, "eq_%d....", node);
+		memcpy(&tag.hi, buf, 8);
+
+		if (OCTEON_IS_MODEL(OCTEON_CN78XX))
+			max_queues = 1024;
+		else
+			max_queues = 256;
+	}
+
+	res_mgr_create_resource(tag, max_queues);
+	rc = res_mgr_alloc_range(tag, -1, num_queues, false, queues);
+	if (rc < 0)
+		return rc;
+
+	return 0;
+}
+
+static void free_queues(int node, enum queue_level level,
+			int num_queues, const int *queues)
+{
+	struct global_resource_tag tag;
+	char buf[16];
+
+	if (level == PQ) {
+		strncpy((char *)&tag.lo, "cvm_pkop", 8);
+		snprintf(buf, 16, "oq_%d....", node);
+		memcpy(&tag.hi, buf, 8);
+	} else if (level == L2_SQ) {
+		strncpy((char *)&tag.lo, "cvm_pkol", 8);
+		snprintf(buf, 16, "2q_%d....", node);
+		memcpy(&tag.hi, buf, 8);
+	} else if (level == L3_SQ) {
+		strncpy((char *)&tag.lo, "cvm_pkol", 8);
+		snprintf(buf, 16, "3q_%d....", node);
+		memcpy(&tag.hi, buf, 8);
+	} else if (level == L4_SQ) {
+		strncpy((char *)&tag.lo, "cvm_pkol", 8);
+		snprintf(buf, 16, "4q_%d....", node);
+		memcpy(&tag.hi, buf, 8);
+	} else if (level == L5_SQ) {
+		strncpy((char *)&tag.lo, "cvm_pkol", 8);
+		snprintf(buf, 16, "5q_%d....", node);
+		memcpy(&tag.hi, buf, 8);
+	} else if (level == DQ) {
+		strncpy((char *)&tag.lo, "cvm_pkod", 8);
+		snprintf(buf, 16, "eq_%d....", node);
+		memcpy(&tag.hi, buf, 8);
+	}
+
+	res_mgr_free_range(tag, queues, num_queues);
+}
+
+static int port_queue_init(int node, int pq, int mac)
+{
+	u64 data;
+
+	data = mac << 16;
+	oct_csr_write(data, PKO_L1_SQ_TOPOLOGY(node, pq));
+
+	data = mac << 13;
+	oct_csr_write(data, PKO_L1_SQ_SHAPE(node, pq));
+
+	data = mac;
+	data <<= 44;
+	oct_csr_write(data, PKO_L1_SQ_LINK(node, pq));
+
+	return 0;
+}
+
+static int scheduler_queue_l2_init(int node, int queue, int parent_q)
+{
+	u64 data;
+
+	data = oct_csr_read(PKO_L1_SQ_TOPOLOGY(node, parent_q));
+	data &= ~(GENMASK_ULL(40, 32) | GENMASK_ULL(4, 1));
+	data |= (u64)queue << 32;
+	data |= 0xf << 1;
+	oct_csr_write(data, PKO_L1_SQ_TOPOLOGY(node, parent_q));
+
+	oct_csr_write(0, PKO_L2_SQ_SCHEDULE(node, queue));
+
+	data = parent_q << 16;
+	oct_csr_write(data, PKO_L2_SQ_TOPOLOGY(node, queue));
+
+	return 0;
+}
+
+static int scheduler_queue_l3_init(int node, int queue, int parent_q)
+{
+	u64 data;
+
+	data = oct_csr_read(PKO_L2_SQ_TOPOLOGY(node, parent_q));
+	data &= ~(GENMASK_ULL(40, 32) | GENMASK_ULL(4, 1));
+	data |= (u64)queue << 32;
+	data |= 0xf << 1;
+	oct_csr_write(data, PKO_L2_SQ_TOPOLOGY(node, parent_q));
+
+	oct_csr_write(0, PKO_L3_SQ_SCHEDULE(node, queue));
+
+	data = parent_q << 16;
+	oct_csr_write(data, PKO_L3_SQ_TOPOLOGY(node, queue));
+
+	return 0;
+}
+
+static int scheduler_queue_l4_init(int node, int queue, int parent_q)
+{
+	u64 data;
+
+	data = oct_csr_read(PKO_L3_SQ_TOPOLOGY(node, parent_q));
+	data &= ~(GENMASK_ULL(41, 32) | GENMASK_ULL(4, 1));
+	data |= (u64)queue << 32;
+	data |= 0xf << 1;
+	oct_csr_write(data, PKO_L3_SQ_TOPOLOGY(node, parent_q));
+
+	oct_csr_write(0, PKO_L4_SQ_SCHEDULE(node, queue));
+
+	data = parent_q << 16;
+	oct_csr_write(data, PKO_L4_SQ_TOPOLOGY(node, queue));
+
+	return 0;
+}
+
+static int scheduler_queue_l5_init(int node, int queue, int parent_q)
+{
+	u64 data;
+
+	data = oct_csr_read(PKO_L4_SQ_TOPOLOGY(node, parent_q));
+	data &= ~(GENMASK_ULL(41, 32) | GENMASK_ULL(4, 1));
+	data |= (u64)queue << 32;
+	data |= 0xf << 1;
+	oct_csr_write(data, PKO_L4_SQ_TOPOLOGY(node, parent_q));
+
+	oct_csr_write(0, PKO_L5_SQ_SCHEDULE(node, queue));
+
+	data = parent_q << 16;
+	oct_csr_write(data, PKO_L5_SQ_TOPOLOGY(node, queue));
+
+	return 0;
+}
+
+static int descriptor_queue_init(int node, const int *queue, int parent_q,
+				 int num_dq)
+{
+	u64 data;
+	u64 addr;
+	int prio;
+	int rr_prio;
+	int rr_quantum;
+	int i;
+
+	/* Limit static priorities to the available prio field bits */
+	if (num_dq > 9) {
+		pr_err("octeon3-pko: Invalid number of dqs\n");
+		return -1;
+	}
+
+	prio = 0;
+
+	if (num_dq == 1) {
+		/* Single dq */
+		rr_prio = 0xf;
+		rr_quantum = 0x10;
+	} else {
+		/* Multiple dqs */
+		rr_prio = num_dq;
+		rr_quantum = 0;
+	}
+
+	if (OCTEON_IS_MODEL(OCTEON_CN78XX))
+		addr = PKO_L5_SQ_TOPOLOGY(node, parent_q);
+	else
+		addr = PKO_L3_SQ_TOPOLOGY(node, parent_q);
+
+	data = oct_csr_read(addr);
+	data &= ~(GENMASK_ULL(41, 32) | GENMASK_ULL(4, 1));
+	data |= (u64)queue[0] << 32;
+	data |= rr_prio << 1;
+	oct_csr_write(data, addr);
+
+	for (i = 0; i < num_dq; i++) {
+		data = (prio << 24) | rr_quantum;
+		oct_csr_write(data, PKO_DQ_SCHEDULE(node, queue[i]));
+
+		data = parent_q << 16;
+		oct_csr_write(data, PKO_DQ_TOPOLOGY(node, queue[i]));
+
+		data = BIT(49);
+		oct_csr_write(data, PKO_DQ_WM_CTL(node, queue[i]));
+
+		if (prio << rr_prio)
+			prio++;
+	}
+
+	return 0;
+}
+
+static int map_channel(int node, int pq, int queue, int ipd_port)
+{
+	u64 data;
+	int lut_index = 0;
+	int table_index;
+
+	data = oct_csr_read(PKO_L3_L2_SQ_CHANNEL(node, queue));
+	data &= ~GENMASK_ULL(43, 32);
+	data |= (u64)ipd_port << 32;
+	oct_csr_write(data, PKO_L3_L2_SQ_CHANNEL(node, queue));
+
+	/* See PKO_LUT register description in the HRM for how to compose the
+	 * lut_index.
+	 */
+	if (OCTEON_IS_MODEL(OCTEON_CN78XX)) {
+		table_index = ((ipd_port & 0xf00) - 0x800) >> 8;
+		lut_index = lut_index_78xx[table_index];
+		lut_index += ipd_port & 0xff;
+	} else if (OCTEON_IS_MODEL(OCTEON_CN73XX)) {
+		table_index = ((ipd_port & 0xf00) - 0x800) >> 8;
+		lut_index = lut_index_73xx[table_index];
+		lut_index += ipd_port & 0xff;
+	} else if (OCTEON_IS_MODEL(OCTEON_CNF75XX)) {
+		if ((ipd_port & 0xf00) != 0x800)
+			return -1;
+		lut_index = ipd_port & 0xff;
+	}
+
+	data = BIT(15);
+	data |= pq << 9;
+	data |= queue;
+	oct_csr_write(data, PKO_LUT(node, lut_index));
+
+	return 0;
+}
+
+static int open_dq(int node, int dq)
+{
+	u64 data;
+	u64 *iobdma_addr;
+	u64 *scratch_addr;
+	enum pko_dqstatus_e status;
+
+	/* Build the dq open query. See PKO_QUERY_DMA_S in the HRM for the
+	 * query format.
+	 */
+	data = (LMTDMA_SCR_OFFSET >> 3) << 56;
+	data |= 1ull << 48;
+	data |= 0x51ull << 40;
+	data |= (u64)node << 36;
+	data |= (u64)DQOP_OPEN << 32;
+	data |= dq << 16;
+
+	CVMX_SYNCWS;
+	preempt_disable();
+
+	/* Clear return location */
+	scratch_addr = (u64 *)(SCRATCH_BASE + LMTDMA_SCR_OFFSET);
+	*scratch_addr = ~0ull;
+
+	/* Issue pko lmtdma command */
+	iobdma_addr = (u64 *)(IOBDMA_ORDERED_IO_ADDR);
+	*iobdma_addr = data;
+
+	/* Wait for lmtdma command to complete and get response*/
+	CVMX_SYNCIOBDMA;
+	data = *scratch_addr;
+
+	preempt_enable();
+
+	/* See PKO_QUERY_RTN_S in the HRM for response format */
+	status = (data & GENMASK_ULL(63, 60)) >> 60;
+	if (status != PASS && status != ALREADY) {
+		pr_err("octeon3-pko: Failed to open dq\n");
+		return -1;
+	}
+
+	return 0;
+}
+
+static s64 query_dq(int node, int dq)
+{
+	u64 data;
+	u64 *iobdma_addr;
+	u64 *scratch_addr;
+	enum pko_dqstatus_e status;
+	s64 depth;
+
+	/* Build the dq open query. See PKO_QUERY_DMA_S in the HRM for the
+	 * query format.
+	 */
+	data = (LMTDMA_SCR_OFFSET >> 3) << 56;
+	data |= 1ull << 48;
+	data |= 0x51ull << 40;
+	data |= (u64)node << 36;
+	data |= (u64)DQOP_QUERY << 32;
+	data |= dq << 16;
+
+	CVMX_SYNCWS;
+	preempt_disable();
+
+	/* Clear return location */
+	scratch_addr = (u64 *)(SCRATCH_BASE + LMTDMA_SCR_OFFSET);
+	*scratch_addr = ~0ull;
+
+	/* Issue pko lmtdma command */
+	iobdma_addr = (u64 *)(IOBDMA_ORDERED_IO_ADDR);
+	*iobdma_addr = data;
+
+	/* Wait for lmtdma command to complete and get response*/
+	CVMX_SYNCIOBDMA;
+	data = *scratch_addr;
+
+	preempt_enable();
+
+	/* See PKO_QUERY_RTN_S in the HRM for response format */
+	status = (data & GENMASK_ULL(63, 60)) >> 60;
+	if (status != PASS) {
+		pr_err("octeon3-pko: Failed to query dq=%d\n", dq);
+		return -1;
+	}
+
+	depth = data & GENMASK_ULL(47, 0);
+
+	return depth;
+}
+
+static u64 close_dq(int node, int dq)
+{
+	u64 data;
+	u64 *iobdma_addr;
+	u64 *scratch_addr;
+	enum pko_dqstatus_e status;
+
+	/* Build the dq open query. See PKO_QUERY_DMA_S in the HRM for the
+	 * query format.
+	 */
+	data = (LMTDMA_SCR_OFFSET >> 3) << 56;
+	data |= 1ull << 48;
+	data |= 0x51ull << 40;
+	data |= (u64)node << 36;
+	data |= (u64)DQOP_CLOSE << 32;
+	data |= dq << 16;
+
+	CVMX_SYNCWS;
+	preempt_disable();
+
+	/* Clear return location */
+	scratch_addr = (u64 *)(SCRATCH_BASE + LMTDMA_SCR_OFFSET);
+	*scratch_addr = ~0ull;
+
+	/* Issue pko lmtdma command */
+	iobdma_addr = (u64 *)(IOBDMA_ORDERED_IO_ADDR);
+	*iobdma_addr = data;
+
+	/* Wait for lmtdma command to complete and get response*/
+	CVMX_SYNCIOBDMA;
+	data = *scratch_addr;
+
+	preempt_enable();
+
+	/* See PKO_QUERY_RTN_S in the HRM for response format */
+	status = (data & GENMASK_ULL(63, 60)) >> 60;
+	if (status != PASS) {
+		pr_err("octeon3-pko: Failed to close dq\n");
+		return -1;
+	}
+
+	return 0;
+}
+
+static int get_78xx_fifos_required(int node, struct mac_info *macs)
+{
+	enum port_mode mode;
+	int fifo_cnt = 0;
+	int bgx;
+	int index;
+	int qlm;
+	int num_lmacs;
+	int i;
+	int cnt;
+	int prio;
+	u64 data;
+
+	/* The loopback mac gets 1 fifo by default */
+	macs[0].fifo_cnt = 1;
+	macs[0].speed = 1;
+	fifo_cnt += 1;
+
+	/* The dpi mac gets 1 fifo by default */
+	macs[1].fifo_cnt = 1;
+	macs[1].speed = 50;
+	fifo_cnt += 1;
+
+	/* The ilk macs get default number of fifos (module param) */
+	macs[2].fifo_cnt = ilk0_lanes <= 4 ? ilk0_lanes : 4;
+	macs[2].speed = 40;
+	fifo_cnt += macs[2].fifo_cnt;
+	macs[3].fifo_cnt = ilk1_lanes <= 4 ? ilk1_lanes : 4;
+	macs[3].speed = 40;
+	fifo_cnt += macs[3].fifo_cnt;
+
+	/* Assign fifos to the active bgx macs */
+	for (i = 4; i < get_num_output_macs(); i += 4) {
+		bgx = (i - 4) / 4;
+		qlm = bgx_port_get_qlm(node, bgx, 0);
+
+		data = oct_csr_read(GSER_CFG(node, qlm));
+		if (data & BIT(2)) {
+			data = oct_csr_read(BGX_CMR_TX_LMACS(node, bgx));
+			num_lmacs = data & 7;
+
+			for (index = 0; index < num_lmacs; index++) {
+				switch (num_lmacs) {
+				case 1:
+					macs[i + index].num_lmacs = 4;
+					break;
+				case 2:
+					macs[i + index].num_lmacs = 2;
+					break;
+				case 4:
+				default:
+					macs[i + index].num_lmacs = 1;
+					break;
+				}
+
+				mode = bgx_port_get_mode(node, bgx, 0);
+				switch (mode) {
+				case PORT_MODE_SGMII:
+				case PORT_MODE_RGMII:
+					macs[i + index].fifo_cnt = 1;
+					macs[i + index].prio = 1;
+					macs[i + index].speed = 1;
+					break;
+
+				case PORT_MODE_XAUI:
+				case PORT_MODE_RXAUI:
+					macs[i + index].fifo_cnt = 4;
+					macs[i + index].prio = 2;
+					macs[i + index].speed = 20;
+					break;
+
+				case PORT_MODE_10G_KR:
+				case PORT_MODE_XFI:
+					macs[i + index].fifo_cnt = 4;
+					macs[i + index].prio = 2;
+					macs[i + index].speed = 10;
+					break;
+
+				case PORT_MODE_40G_KR4:
+				case PORT_MODE_XLAUI:
+					macs[i + index].fifo_cnt = 4;
+					macs[i + index].prio = 3;
+					macs[i + index].speed = 40;
+					break;
+
+				default:
+					macs[i + index].fifo_cnt = 0;
+					macs[i + index].prio = 0;
+					macs[i + index].speed = 0;
+					macs[i + index].num_lmacs = 0;
+					break;
+				}
+
+				fifo_cnt += macs[i + index].fifo_cnt;
+			}
+		}
+	}
+
+	/* If more fifos than available were assigned, reduce the number of
+	 * fifos until within limit. Start with the lowest priority macs with 4
+	 * fifos.
+	 */
+	prio = 1;
+	cnt = 4;
+	while (fifo_cnt > get_num_fifos()) {
+		for (i = 0; i < get_num_output_macs(); i++) {
+			if (macs[i].prio == prio && macs[i].fifo_cnt == cnt) {
+				macs[i].fifo_cnt >>= 1;
+				fifo_cnt -= macs[i].fifo_cnt;
+			}
+
+			if (fifo_cnt <= get_num_fifos())
+				break;
+		}
+
+		if (prio >= 3) {
+			prio = 1;
+			cnt >>= 1;
+		} else {
+			prio++;
+		}
+
+		if (cnt == 0)
+			break;
+	}
+
+	/* Assign left over fifos to dpi */
+	if (get_num_fifos() - fifo_cnt > 0) {
+		if (get_num_fifos() - fifo_cnt >= 3) {
+			macs[1].fifo_cnt += 3;
+			fifo_cnt -= 3;
+		} else {
+			macs[1].fifo_cnt += 1;
+			fifo_cnt -= 1;
+		}
+	}
+
+	return 0;
+}
+
+static int get_75xx_fifos_required(int node, struct mac_info *macs)
+{
+	enum port_mode mode;
+	int fifo_cnt = 0;
+	int bgx;
+	int index;
+	int qlm;
+	int i;
+	int cnt;
+	int prio;
+	u64 data;
+
+	/* The loopback mac gets 1 fifo by default */
+	macs[0].fifo_cnt = 1;
+	macs[0].speed = 1;
+	fifo_cnt += 1;
+
+	/* The dpi mac gets 1 fifo by default */
+	macs[1].fifo_cnt = 1;
+	macs[1].speed = 50;
+	fifo_cnt += 1;
+
+	/* Assign fifos to the active bgx macs */
+	bgx = 0;
+	for (i = 2; i < 6; i++) {
+		index = i - 2;
+		qlm = bgx_port_get_qlm(node, bgx, index);
+		data = oct_csr_read(GSER_CFG(node, qlm));
+		if (data & BIT(2)) {
+			macs[i].num_lmacs = 1;
+
+			mode = bgx_port_get_mode(node, bgx, index);
+			switch (mode) {
+			case PORT_MODE_SGMII:
+			case PORT_MODE_RGMII:
+				macs[i].fifo_cnt = 1;
+				macs[i].prio = 1;
+				macs[i].speed = 1;
+				break;
+
+			case PORT_MODE_10G_KR:
+			case PORT_MODE_XFI:
+				macs[i].fifo_cnt = 4;
+				macs[i].prio = 2;
+				macs[i].speed = 10;
+				break;
+
+			default:
+				macs[i].fifo_cnt = 0;
+				macs[i].prio = 0;
+				macs[i].speed = 0;
+				macs[i].num_lmacs = 0;
+				break;
+			}
+
+			fifo_cnt += macs[i].fifo_cnt;
+		}
+	}
+
+	/* If more fifos than available were assigned, reduce the number of
+	 * fifos until within limit. Start with the lowest priority macs with 4
+	 * fifos.
+	 */
+	prio = 1;
+	cnt = 4;
+	while (fifo_cnt > get_num_fifos()) {
+		for (i = 0; i < get_num_output_macs(); i++) {
+			if (macs[i].prio == prio && macs[i].fifo_cnt == cnt) {
+				macs[i].fifo_cnt >>= 1;
+				fifo_cnt -= macs[i].fifo_cnt;
+			}
+
+			if (fifo_cnt <= get_num_fifos())
+				break;
+		}
+
+		if (prio >= 3) {
+			prio = 1;
+			cnt >>= 1;
+		} else {
+			prio++;
+		}
+
+		if (cnt == 0)
+			break;
+	}
+
+	/* Assign left over fifos to dpi */
+	if (get_num_fifos() - fifo_cnt > 0) {
+		if (get_num_fifos() - fifo_cnt >= 3) {
+			macs[1].fifo_cnt += 3;
+			fifo_cnt -= 3;
+		} else {
+			macs[1].fifo_cnt += 1;
+			fifo_cnt -= 1;
+		}
+	}
+
+	return 0;
+}
+
+static int get_73xx_fifos_required(int node, struct mac_info *macs)
+{
+	enum port_mode mode;
+	int fifo_cnt = 0;
+	int bgx;
+	int index;
+	int qlm;
+	int num_lmacs;
+	int i;
+	int cnt;
+	int prio;
+	u64 data;
+
+	/* The loopback mac gets 1 fifo by default */
+	macs[0].fifo_cnt = 1;
+	macs[0].speed = 1;
+	fifo_cnt += 1;
+
+	/* The dpi mac gets 1 fifo by default */
+	macs[1].fifo_cnt = 1;
+	macs[1].speed = 50;
+	fifo_cnt += 1;
+
+	/* Assign fifos to the active bgx macs */
+	for (i = 2; i < get_num_output_macs(); i += 4) {
+		bgx = (i - 2) / 4;
+		qlm = bgx_port_get_qlm(node, bgx, 0);
+		data = oct_csr_read(GSER_CFG(node, qlm));
+
+		/* Bgx2 can be connected to dlm 5, 6, or both */
+		if (bgx == 2) {
+			if (!(data & BIT(2))) {
+				qlm = bgx_port_get_qlm(node, bgx, 2);
+				data = oct_csr_read(GSER_CFG(node, qlm));
+			}
+		}
+
+		if (data & BIT(2)) {
+			data = oct_csr_read(BGX_CMR_TX_LMACS(node, bgx));
+			num_lmacs = data & 7;
+
+			for (index = 0; index < num_lmacs; index++) {
+				switch (num_lmacs) {
+				case 1:
+					macs[i + index].num_lmacs = 4;
+					break;
+				case 2:
+					macs[i + index].num_lmacs = 2;
+					break;
+				case 4:
+				default:
+					macs[i + index].num_lmacs = 1;
+					break;
+				}
+
+				mode = bgx_port_get_mode(node, bgx, index);
+				switch (mode) {
+				case PORT_MODE_SGMII:
+				case PORT_MODE_RGMII:
+					macs[i + index].fifo_cnt = 1;
+					macs[i + index].prio = 1;
+					macs[i + index].speed = 1;
+					break;
+
+				case PORT_MODE_XAUI:
+				case PORT_MODE_RXAUI:
+					macs[i + index].fifo_cnt = 4;
+					macs[i + index].prio = 2;
+					macs[i + index].speed = 20;
+					break;
+
+				case PORT_MODE_10G_KR:
+				case PORT_MODE_XFI:
+					macs[i + index].fifo_cnt = 4;
+					macs[i + index].prio = 2;
+					macs[i + index].speed = 10;
+					break;
+
+				case PORT_MODE_40G_KR4:
+				case PORT_MODE_XLAUI:
+					macs[i + index].fifo_cnt = 4;
+					macs[i + index].prio = 3;
+					macs[i + index].speed = 40;
+					break;
+
+				default:
+					macs[i + index].fifo_cnt = 0;
+					macs[i + index].prio = 0;
+					macs[i + index].speed = 0;
+					break;
+				}
+
+				fifo_cnt += macs[i + index].fifo_cnt;
+			}
+		}
+	}
+
+	/* If more fifos than available were assigned, reduce the number of
+	 * fifos until within limit. Start with the lowest priority macs with 4
+	 * fifos.
+	 */
+	prio = 1;
+	cnt = 4;
+	while (fifo_cnt > get_num_fifos()) {
+		for (i = 0; i < get_num_output_macs(); i++) {
+			if (macs[i].prio == prio && macs[i].fifo_cnt == cnt) {
+				macs[i].fifo_cnt >>= 1;
+				fifo_cnt -= macs[i].fifo_cnt;
+			}
+
+			if (fifo_cnt <= get_num_fifos())
+				break;
+		}
+
+		if (prio >= 3) {
+			prio = 1;
+			cnt >>= 1;
+		} else {
+			prio++;
+		}
+
+		if (cnt == 0)
+			break;
+	}
+
+	/* Assign left over fifos to dpi */
+	if (get_num_fifos() - fifo_cnt > 0) {
+		if (get_num_fifos() - fifo_cnt >= 3) {
+			macs[1].fifo_cnt += 3;
+			fifo_cnt -= 3;
+		} else {
+			macs[1].fifo_cnt += 1;
+			fifo_cnt -= 1;
+		}
+	}
+
+	return 0;
+}
+
+static int setup_macs(int node)
+{
+	struct mac_info macs[MAX_OUTPUT_MAC];
+	struct fifo_grp_info fifo_grp[MAX_FIFO_GRP];
+	int cnt;
+	int fifo;
+	int grp;
+	int i;
+	u64 data;
+	int size;
+
+	memset(macs, 0, sizeof(macs));
+	memset(fifo_grp, 0, sizeof(fifo_grp));
+
+	/* Get the number of fifos required by each mac */
+	if (OCTEON_IS_MODEL(OCTEON_CN78XX)) {
+		get_78xx_fifos_required(node, macs);
+	} else if (OCTEON_IS_MODEL(OCTEON_CNF75XX)) {
+		get_75xx_fifos_required(node, macs);
+	} else if (OCTEON_IS_MODEL(OCTEON_CN73XX)) {
+		get_73xx_fifos_required(node, macs);
+	} else {
+		pr_err("octeon3-pko: Unsupported board type\n");
+		return -1;
+	}
+
+	/* Assign fifos to each mac. Start with macs requiring 4 fifos */
+	fifo = 0;
+	for (cnt = 4; cnt > 0; cnt >>= 1) {
+		for (i = 0; i < get_num_output_macs(); i++) {
+			if (macs[i].fifo_cnt != cnt)
+				continue;
+
+			macs[i].fifo = fifo;
+			grp = fifo / 4;
+
+			fifo_grp[grp].speed += macs[i].speed;
+
+			if (cnt == 4) {
+				/* 10, 0, 0, 0 */
+				fifo_grp[grp].size = 4;
+			} else if (cnt == 2) {
+				/* 5, 0, 5, 0 */
+				fifo_grp[grp].size = 3;
+			} else if (cnt == 1) {
+				if ((fifo & 0x2) && fifo_grp[grp].size == 3) {
+					/* 5, 0, 2.5, 2.5 */
+					fifo_grp[grp].size = 1;
+				} else {
+					/* 2.5, 2.5, 2.5, 2.5 */
+					fifo_grp[grp].size = 0;
+				}
+			}
+
+			fifo += cnt;
+		}
+	}
+
+	/* Configure the fifo groups */
+	for (i = 0; i < get_num_fifo_groups(); i++) {
+		data = oct_csr_read(PKO_PTGF_CFG(node, i));
+		size = data & GENMASK_ULL(2, 0);
+		if (size != fifo_grp[i].size)
+			data |= BIT(6);
+		data &= ~GENMASK_ULL(2, 0);
+		data |= fifo_grp[i].size;
+
+		data &= ~GENMASK_ULL(5, 3);
+		if (fifo_grp[i].speed >= 40) {
+			if (fifo_grp[i].size >= 3) {
+				/* 50 Gbps */
+				data |= 0x3 << 3;
+			} else {
+				/* 25 Gbps */
+				data |= 0x2 << 3;
+			}
+		} else if (fifo_grp[i].speed >= 20) {
+			/* 25 Gbps */
+			data |= 0x2 << 3;
+		} else if (fifo_grp[i].speed >= 10) {
+			/* 12.5 Gbps */
+			data |= 0x1 << 3;
+		}
+		oct_csr_write(data, PKO_PTGF_CFG(node, i));
+		data &= ~BIT(6);
+		oct_csr_write(data, PKO_PTGF_CFG(node, i));
+	}
+
+	/* Configure the macs with their assigned fifo */
+	for (i = 0; i < get_num_output_macs(); i++) {
+		data = oct_csr_read(PKO_MAC_CFG(node, i));
+		data &= ~GENMASK_ULL(4, 0);
+		if (!macs[i].fifo_cnt)
+			data |= 0x1f;
+		else
+			data |= macs[i].fifo;
+		oct_csr_write(data, PKO_MAC_CFG(node, i));
+	}
+
+	/* Setup mci0/mci1/skid credits */
+	for (i = 0; i < get_num_output_macs(); i++) {
+		int fifo_credit;
+		int mac_credit;
+		int skid_credit;
+
+		if (!macs[i].fifo_cnt)
+			continue;
+
+		if (i == 0) {
+			/* Loopback */
+			mac_credit = 4 * 1024;
+			skid_credit = 0;
+		} else if (i == 1) {
+			/* Dpi */
+			mac_credit = 2 * 1024;
+			skid_credit = 0;
+		} else if (OCTEON_IS_MODEL(OCTEON_CN78XX) && ((i == 2 || i == 3))) {
+			/* ILK */
+			mac_credit = 4 * 1024;
+			skid_credit = 0;
+		} else if (OCTEON_IS_MODEL(OCTEON_CNF75XX) && ((i >= 6 && i <= 9))) {
+			/* Srio */
+			mac_credit = 1024 / 2;
+			skid_credit = 0;
+		} else {
+			/* Bgx */
+			mac_credit = macs[i].num_lmacs * 8 * 1024;
+			skid_credit = macs[i].num_lmacs * 256;
+		}
+
+		if (OCTEON_IS_MODEL(OCTEON_CN78XX_PASS1_X)) {
+			fifo_credit = macs[i].fifo_cnt * FIFO_SIZE;
+			data = (fifo_credit + mac_credit) / 16;
+			oct_csr_write(data, PKO_MCI0_MAX_CRED(node, i));
+		}
+
+		data = mac_credit / 16;
+		oct_csr_write(data, PKO_MCI1_MAX_CRED(node, i));
+
+		data = oct_csr_read(PKO_MAC_CFG(node, i));
+		data &= ~GENMASK_ULL(6, 5);
+		data |= ((skid_credit / 256) >> 1) << 5;
+		oct_csr_write(data, PKO_MAC_CFG(node, i));
+	}
+
+	return 0;
+}
+
+static int hw_init_global(int node, int aura)
+{
+	u64 data;
+	int timeout;
+
+	data = oct_csr_read(PKO_ENABLE(node));
+	if (data & BIT(0)) {
+		pr_info("octeon3-pko: Pko already enabled on node %d\n", node);
+		return 0;
+	}
+
+	/* Enable color awareness */
+	data = oct_csr_read(PKO_SHAPER_CFG(node));
+	data |= BIT(1);
+	oct_csr_write(data, PKO_SHAPER_CFG(node));
+
+	/* Clear flush command */
+	oct_csr_write(0, PKO_DPFI_FLUSH(node));
+
+	/* Set the aura number */
+	data = (node << 10) | aura;
+	oct_csr_write(data, PKO_DPFI_FPA_AURA(node));
+
+	data = BIT(0);
+	oct_csr_write(data, PKO_DPFI_ENA(node));
+
+	/* Wait until all pointers have been returned */
+	timeout = 100000;
+	do {
+		data = oct_csr_read(PKO_STATUS(node));
+		if (data & BIT(63))
+			break;
+		udelay(1);
+		timeout--;
+	} while (timeout);
+	if (!timeout) {
+		pr_err("octeon3-pko: Pko dfpi failed on node %d\n", node);
+		return -1;
+	}
+
+	/* Set max outstanding requests in IOBP for any FIFO.*/
+	data = oct_csr_read(PKO_PTF_IOBP_CFG(node));
+	data &= ~GENMASK_ULL(6, 0);
+	if (OCTEON_IS_MODEL(OCTEON_CN78XX))
+		data |= 0x10;
+	else
+		data |= 3;
+	oct_csr_write(data, PKO_PTF_IOBP_CFG(node));
+
+	/* Set minimum packet size per Ethernet standard */
+	data = 0x3c << 3;
+	oct_csr_write(data, PKO_PDM_CFG(node));
+
+	/* Initialize macs and fifos */
+	setup_macs(node);
+
+	/* Enable pko */
+	data = BIT(0);
+	oct_csr_write(data, PKO_ENABLE(node));
+
+	/* Verify pko is ready */
+	data = oct_csr_read(PKO_STATUS(node));
+	if (!(data & BIT(63))) {
+		pr_err("octeon3_pko: pko is not ready\n");
+		return -1;
+	}
+
+	return 0;
+}
+
+static int hw_exit_global(int node)
+{
+	u64 data;
+	int timeout;
+	int i;
+
+	/* Wait until there are no in-flight packets */
+	for (i = 0; i < get_num_fifos(); i++) {
+		data = oct_csr_read(PKO_PTF_STATUS(node, i));
+		if ((data & GENMASK_ULL(4, 0)) == 0x1f)
+			continue;
+
+		timeout = 10000;
+		do {
+			if (!(data & GENMASK_ULL(11, 5)))
+				break;
+			udelay(1);
+			timeout--;
+			data = oct_csr_read(PKO_PTF_STATUS(node, i));
+		} while (timeout);
+		if (!timeout) {
+			pr_err("octeon3-pko: Timeout in-flight fifo\n");
+			return -1;
+		}
+	}
+
+	/* Disable pko */
+	oct_csr_write(0, PKO_ENABLE(node));
+
+	/* Reset all port queues to the virtual mac */
+	for (i = 0; i < get_num_port_queues(); i++) {
+		data = get_num_output_macs() << 16;
+		oct_csr_write(data, PKO_L1_SQ_TOPOLOGY(node, i));
+
+		data = get_num_output_macs() << 13;
+		oct_csr_write(data, PKO_L1_SQ_SHAPE(node, i));
+
+		data = (u64)get_num_output_macs() << 48;
+		oct_csr_write(data, PKO_L1_SQ_LINK(node, i));
+	}
+
+	/* Reset all output macs */
+	for (i = 0; i < get_num_output_macs(); i++) {
+		data = 0x1f;
+		oct_csr_write(data, PKO_MAC_CFG(node, i));
+	}
+
+	/* Reset all fifo groups */
+	for (i = 0; i < get_num_fifo_groups(); i++) {
+		data = oct_csr_read(PKO_PTGF_CFG(node, i));
+		/* Simulator asserts if an unused group is reset */
+		if (data == 0)
+			continue;
+		data = BIT(6);
+		oct_csr_write(data, PKO_PTGF_CFG(node, i));
+	}
+
+	/* Return cache pointers to fpa */
+	data = BIT(0);
+	oct_csr_write(data, PKO_DPFI_FLUSH(node));
+	timeout = 10000;
+	do {
+		data = oct_csr_read(PKO_DPFI_STATUS(node));
+		if (data & BIT(0))
+			break;
+		udelay(1);
+		timeout--;
+	} while (timeout);
+	if (!timeout) {
+		pr_err("octeon3-pko: Timeout flushing cache\n");
+		return -1;
+	}
+	oct_csr_write(0, PKO_DPFI_ENA(node));
+	oct_csr_write(0, PKO_DPFI_FLUSH(node));
+
+	return 0;
+}
+
+static int virtual_mac_config(int node)
+{
+	enum queue_level level;
+	int vmac;
+	int pq;
+	int dq[8];
+	int num_dq;
+	int parent_q;
+	int queue;
+	int i;
+	int rc;
+
+	/* The virtual mac is after the last output mac. Note: for the 73xx it
+	 * might be 2 after the last output mac (15).
+	 */
+	vmac = get_num_output_macs();
+
+	/* Allocate a port queue */
+	rc = allocate_queues(node, PQ, 1, &pq);
+	if (rc < 0) {
+		pr_err("octeon3-pko: Failed to allocate port queue\n");
+		return rc;
+	}
+
+	/* Connect the port queue to the output mac */
+	port_queue_init(node, pq, vmac);
+
+	parent_q = pq;
+	for (level = L2_SQ; level <= max_sq_level(); level++) {
+		rc = allocate_queues(node, level, 1, &queue);
+		if (rc < 0) {
+			pr_err("octeon3-pko: Failed to allocate queue\n");
+			return rc;
+		}
+
+		switch (level) {
+		case L2_SQ:
+			scheduler_queue_l2_init(node, queue, parent_q);
+			break;
+		case L3_SQ:
+			scheduler_queue_l3_init(node, queue, parent_q);
+			break;
+		case L4_SQ:
+			scheduler_queue_l4_init(node, queue, parent_q);
+			break;
+		case L5_SQ:
+			scheduler_queue_l5_init(node, queue, parent_q);
+			break;
+		default:
+			break;
+		}
+
+		parent_q = queue;
+	}
+
+	if (OCTEON_IS_MODEL(OCTEON_CN78XX_PASS1_0))
+		num_dq = 8;
+	else
+		num_dq = 1;
+
+	rc = allocate_queues(node, DQ, num_dq, dq);
+	if (rc < 0) {
+		pr_err("octeon3-pko: Failed to allocate description queues\n");
+		return rc;
+	}
+
+	/* By convention the dq must be zero */
+	if (dq[0] != 0) {
+		pr_err("octeon3-pko: Failed to reserve description queues\n");
+		return -1;
+	}
+	descriptor_queue_init(node, dq, parent_q, num_dq);
+
+	/* Open the dqs */
+	for (i = 0; i < num_dq; i++)
+		open_dq(node, dq[i]);
+
+	return 0;
+}
+
+static int drain_dq(int node, int dq)
+{
+	u64 data;
+	int timeout;
+	s64 rc;
+
+	data = BIT(2) | BIT(1);
+	oct_csr_write(data, PKO_DQ_SW_XOFF(node, dq));
+
+	usleep_range(1000, 2000);
+
+	data = 0;
+	oct_csr_write(data, PKO_DQ_SW_XOFF(node, dq));
+
+	/* Wait for the dq to drain */
+	timeout = 10000;
+	do {
+		rc = query_dq(node, dq);
+		if (!rc)
+			break;
+		else if (rc < 0)
+			return rc;
+		udelay(1);
+		timeout--;
+	} while (timeout);
+	if (!timeout) {
+		pr_err("octeon3-pko: Timeout waiting for dq to drain\n");
+		return -1;
+	}
+
+	/* Close the queue anf free internal buffers */
+	close_dq(node, dq);
+
+	return 0;
+}
+
+int octeon3_pko_exit_global(int node)
+{
+	int dq[8];
+	int num_dq;
+	int i;
+
+	if (OCTEON_IS_MODEL(OCTEON_CN78XX_PASS1_0))
+		num_dq = 8;
+	else
+		num_dq = 1;
+
+	/* Shutdown the virtual/null interface */
+	for (i = 0; i < ARRAY_SIZE(dq); i++)
+		dq[i] = i;
+	octeon3_pko_interface_uninit(node, dq, num_dq);
+
+	/* Shutdown pko */
+	hw_exit_global(node);
+
+	return 0;
+}
+EXPORT_SYMBOL(octeon3_pko_exit_global);
+
+int octeon3_pko_init_global(int node, int aura)
+{
+	int rc;
+
+	rc = hw_init_global(node, aura);
+	if (rc)
+		return rc;
+
+	/* Channel credit level at level 2 */
+	oct_csr_write(0, PKO_CHANNEL_LEVEL(node));
+
+	/* Configure the null mac */
+	rc = virtual_mac_config(node);
+	if (rc)
+		return rc;
+
+	return 0;
+}
+EXPORT_SYMBOL(octeon3_pko_init_global);
+
+int octeon3_pko_set_mac_options(int node, int interface, int index,
+				enum octeon3_mac_type mac_type,
+				bool fcs_en, bool pad_en, int fcs_sop_off)
+{
+	int mac;
+	u64 data;
+	int fifo_num;
+
+	mac = get_output_mac(interface, index, mac_type);
+
+	data = oct_csr_read(PKO_MAC_CFG(node, mac));
+	fifo_num = data & GENMASK_ULL(4, 0);
+	if (fifo_num == 0x1f) {
+		pr_err("octeon3_pko: mac not configured %d:%d:%d\n",
+		       node, interface, index);
+		return -ENODEV;
+	}
+
+	/* Some silicon requires fifo_num=0x1f to change padding, fcs */
+	data &= ~GENMASK_ULL(4, 0);
+	data |= 0x1f;
+
+	data &= ~(BIT(16) | BIT(15) | GENMASK_ULL(14, 7));
+	if (pad_en)
+		data |= BIT(16);
+	if (fcs_en)
+		data |= BIT(15);
+	if (fcs_sop_off)
+		data |= fcs_sop_off << 7;
+
+	oct_csr_write(data, PKO_MAC_CFG(node, mac));
+
+	data &= ~GENMASK_ULL(4, 0);
+	data |= fifo_num;
+	oct_csr_write(data, PKO_MAC_CFG(node, mac));
+
+	return 0;
+}
+EXPORT_SYMBOL(octeon3_pko_set_mac_options);
+
+int octeon3_pko_get_fifo_size(int node, int interface, int index,
+			      enum octeon3_mac_type mac_type)
+{
+	int mac;
+	u64 data;
+	int fifo_grp;
+	int fifo_off;
+	int size;
+
+	/* Set fifo size to 2.4 KB */
+	size = FIFO_SIZE;
+
+	mac = get_output_mac(interface, index, mac_type);
+
+	data = oct_csr_read(PKO_MAC_CFG(node, mac));
+	if ((data & GENMASK_ULL(4, 0)) == 0x1f) {
+		pr_err("octeon3_pko: mac not configured %d:%d:%d\n",
+		       node, interface, index);
+		return -ENODEV;
+	}
+	fifo_grp = (data & GENMASK_ULL(4, 0)) >> 2;
+	fifo_off = data & GENMASK_ULL(1, 0);
+
+	data = oct_csr_read(PKO_PTGF_CFG(node, fifo_grp));
+	data &= GENMASK_ULL(2, 0);
+	switch (data) {
+	case 0:
+		/* 2.5l, 2.5k, 2.5k, 2.5k */
+		break;
+	case 1:
+		/* 5.0k, 0.0k, 2.5k, 2.5k */
+		if (fifo_off == 0)
+			size *= 2;
+		if (fifo_off == 1)
+			size = 0;
+		break;
+	case 2:
+		/* 2.5k, 2.5k, 5.0k, 0.0k */
+		if (fifo_off == 2)
+			size *= 2;
+		if (fifo_off == 3)
+			size = 0;
+		break;
+	case 3:
+		/* 5k, 0, 5k, 0 */
+		if ((fifo_off & 1) != 0)
+			size = 0;
+		size *= 2;
+		break;
+	case 4:
+		/* 10k, 0, 0, 0 */
+		if (fifo_off != 0)
+			size = 0;
+		size *= 4;
+		break;
+	default:
+		size = -1;
+	}
+
+	return size;
+}
+EXPORT_SYMBOL(octeon3_pko_get_fifo_size);
+
+int octeon3_pko_activate_dq(int node, int dq, int cnt)
+{
+	int i;
+	int rc = 0;
+	u64 data;
+
+	for (i = 0; i < cnt; i++) {
+		rc = open_dq(node, dq + i);
+		if (rc)
+			break;
+
+		data = oct_csr_read(PKO_PDM_DQ_MINPAD(node, dq + i));
+		data &= ~BIT(0);
+		oct_csr_write(data, PKO_PDM_DQ_MINPAD(node, dq + i));
+	}
+
+	return rc;
+}
+EXPORT_SYMBOL(octeon3_pko_activate_dq);
+
+int octeon3_pko_interface_init(int node, int interface, int index,
+			       enum octeon3_mac_type mac_type, int ipd_port)
+{
+	enum queue_level level;
+	int mac;
+	int pq;
+	int parent_q;
+	int queue;
+	int rc;
+
+	mac = get_output_mac(interface, index, mac_type);
+
+	/* Allocate a port queue for this interface */
+	rc = allocate_queues(node, PQ, 1, &pq);
+	if (rc < 0) {
+		pr_err("octeon3-pko: Failed to allocate port queue\n");
+		return rc;
+	}
+
+	/* Connect the port queue to the output mac */
+	port_queue_init(node, pq, mac);
+
+	/* Link scheduler queues to the port queue */
+	parent_q = pq;
+	for (level = L2_SQ; level <= max_sq_level(); level++) {
+		rc = allocate_queues(node, level, 1, &queue);
+		if (rc < 0) {
+			pr_err("octeon3-pko: Failed to allocate queue\n");
+			return rc;
+		}
+
+		switch (level) {
+		case L2_SQ:
+			scheduler_queue_l2_init(node, queue, parent_q);
+			map_channel(node, pq, queue, ipd_port);
+			break;
+		case L3_SQ:
+			scheduler_queue_l3_init(node, queue, parent_q);
+			break;
+		case L4_SQ:
+			scheduler_queue_l4_init(node, queue, parent_q);
+			break;
+		case L5_SQ:
+			scheduler_queue_l5_init(node, queue, parent_q);
+			break;
+		default:
+			break;
+		}
+
+		parent_q = queue;
+	}
+
+	/* Link the descriptor queue */
+	rc = allocate_queues(node, DQ, 1, &queue);
+	if (rc < 0) {
+		pr_err("octeon3-pko: Failed to allocate descriptor queue\n");
+		return rc;
+	}
+	descriptor_queue_init(node, &queue, parent_q, 1);
+
+	return queue;
+}
+EXPORT_SYMBOL(octeon3_pko_interface_init);
+
+int octeon3_pko_interface_uninit(int node, const int *dq, int num_dq)
+{
+	enum queue_level level;
+	int queue;
+	int parent_q;
+	u64 data;
+	u64 addr;
+	int i;
+	int rc;
+
+	/* Drain all dqs */
+	for (i = 0; i < num_dq; i++) {
+		rc = drain_dq(node, dq[i]);
+		if (rc)
+			return rc;
+
+		/* Free the dq */
+		data = oct_csr_read(PKO_DQ_TOPOLOGY(node, dq[i]));
+		parent_q = (data & GENMASK_ULL(25, 16)) >> 16;
+		free_queues(node, DQ, 1, &dq[i]);
+
+		/* Free all the scheduler queues */
+		queue = parent_q;
+		for (level = max_sq_level(); (signed int)level >= PQ; level--) {
+			switch (level) {
+			case L5_SQ:
+				addr = PKO_L5_SQ_TOPOLOGY(node, queue);
+				data = oct_csr_read(addr);
+				parent_q = (data & GENMASK_ULL(25, 16)) >> 16;
+				break;
+
+			case L4_SQ:
+				addr = PKO_L4_SQ_TOPOLOGY(node, queue);
+				data = oct_csr_read(addr);
+				parent_q = (data & GENMASK_ULL(24, 16)) >> 16;
+				break;
+
+			case L3_SQ:
+				addr = PKO_L3_SQ_TOPOLOGY(node, queue);
+				data = oct_csr_read(addr);
+				parent_q = (data & GENMASK_ULL(24, 16)) >> 16;
+				break;
+
+			case L2_SQ:
+				addr = PKO_L2_SQ_TOPOLOGY(node, queue);
+				data = oct_csr_read(addr);
+				parent_q = (data & GENMASK_ULL(20, 16)) >> 16;
+				break;
+
+			case PQ:
+				break;
+
+			default:
+				pr_err("octeon3-pko: Invalid level=%d\n",
+				       level);
+				return -1;
+			}
+
+			free_queues(node, level, 1, &queue);
+			queue = parent_q;
+		}
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(octeon3_pko_interface_uninit);
diff --git a/drivers/net/ethernet/cavium/octeon/octeon3-sso.c b/drivers/net/ethernet/cavium/octeon/octeon3-sso.c
new file mode 100644
index 000000000000..7bab6c5f0ac4
--- /dev/null
+++ b/drivers/net/ethernet/cavium/octeon/octeon3-sso.c
@@ -0,0 +1,301 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2017 Cavium, Inc.
+ *
+ * Configuration of Schedule/Synchronize/Order (SSO) block.
+ */
+#include <linux/module.h>
+
+#include <asm/octeon/octeon.h>
+
+#include "octeon3.h"
+
+/* Registers are accessed via xkphys */
+#define SSO_BASE			0x1670000000000ull
+#define SSO_ADDR(node)			(SET_XKPHYS + NODE_OFFSET(node) +      \
+					 SSO_BASE)
+
+#define SSO_AW_STATUS(n)		(SSO_ADDR(n)		   + 0x000010e0)
+#define SSO_AW_CFG(n)			(SSO_ADDR(n)		   + 0x000010f0)
+#define SSO_ERR0(n)			(SSO_ADDR(n)		   + 0x00001240)
+#define SSO_TAQ_ADD(n)			(SSO_ADDR(n)		   + 0x000020e0)
+#define SSO_XAQ_AURA(n)			(SSO_ADDR(n)		   + 0x00002100)
+
+#define AQ_OFFSET(g)			((g) << 3)
+#define AQ_ADDR(n, g)			(SSO_ADDR(n) + AQ_OFFSET(g))
+#define SSO_XAQ_HEAD_PTR(n, g)		(AQ_ADDR(n, g)		   + 0x00080000)
+#define SSO_XAQ_TAIL_PTR(n, g)		(AQ_ADDR(n, g)		   + 0x00090000)
+#define SSO_XAQ_HEAD_NEXT(n, g)		(AQ_ADDR(n, g)		   + 0x000a0000)
+#define SSO_XAQ_TAIL_NEXT(n, g)		(AQ_ADDR(n, g)		   + 0x000b0000)
+
+#define GRP_OFFSET(grp)			((grp) << 16)
+#define GRP_ADDR(n, g)			(SSO_ADDR(n) + GRP_OFFSET(g))
+#define SSO_GRP_TAQ_THR(n, g)		(GRP_ADDR(n, g)		   + 0x20000100)
+#define SSO_GRP_PRI(n, g)		(GRP_ADDR(n, g)		   + 0x20000200)
+#define SSO_GRP_INT(n, g)		(GRP_ADDR(n, g)		   + 0x20000400)
+#define SSO_GRP_INT_THR(n, g)		(GRP_ADDR(n, g)		   + 0x20000500)
+#define SSO_GRP_AQ_CNT(n, g)		(GRP_ADDR(n, g)		   + 0x20000700)
+
+static int get_num_sso_grps(void)
+{
+	if (OCTEON_IS_MODEL(OCTEON_CN78XX))
+		return 256;
+	if (OCTEON_IS_MODEL(OCTEON_CNF75XX) || OCTEON_IS_MODEL(OCTEON_CN73XX))
+		return 64;
+	return 0;
+}
+
+void octeon3_sso_irq_set(int node, int grp, bool en)
+{
+	if (en)
+		oct_csr_write(1, SSO_GRP_INT_THR(node, grp));
+	else
+		oct_csr_write(0, SSO_GRP_INT_THR(node, grp));
+
+	oct_csr_write(BIT(1), SSO_GRP_INT(node, grp));
+}
+EXPORT_SYMBOL(octeon3_sso_irq_set);
+
+/**
+ * octeon3_sso_alloc_grp_range() - Allocate a range of sso groups.
+ * @node: Node where sso resides.
+ * @req_grp: Group number to start allocating sequentially from. -1 for don't
+ *	     care.
+ * @req_cnt: Number of groups to allocate.
+ * @use_last_avail: Set to request the last available groups.
+ * @grp: Updated with allocated groups.
+ *
+ * Return: 0 if successful.
+ *	   < 0 for error codes.
+ */
+int octeon3_sso_alloc_grp_range(int node, int req_grp, int req_cnt,
+				bool use_last_avail, int *grp)
+{
+	struct global_resource_tag tag;
+	char buf[16];
+
+	/* Allocate the request group range */
+	strncpy((char *)&tag.lo, "cvm_sso_", 8);
+	snprintf(buf, 16, "0%d......", node);
+	memcpy(&tag.hi, buf, 8);
+
+	res_mgr_create_resource(tag, get_num_sso_grps());
+	return res_mgr_alloc_range(tag, req_grp, req_cnt, false, grp);
+}
+EXPORT_SYMBOL(octeon3_sso_alloc_grp_range);
+
+/**
+ * octeon3_sso_alloc_grp() - Allocate a sso group.
+ * @node: Node where sso resides.
+ * @req_grp: Group number to allocate, -1 for don't care.
+ *
+ * Return: allocated group.
+ *	   < 0 for error codes.
+ */
+int octeon3_sso_alloc_grp(int node, int req_grp)
+{
+	int grp;
+	int rc;
+
+	rc = octeon3_sso_alloc_grp_range(node, req_grp, 1, false, &grp);
+	if (!rc)
+		rc = grp;
+
+	return rc;
+}
+EXPORT_SYMBOL(octeon3_sso_alloc_grp);
+
+/**
+ * octeon3_sso_free_grp_range() - Free a range of sso groups.
+ * @node: Node where sso resides.
+ * @grp: Array of groups to free.
+ * @req_cnt: Number of groups to free.
+ */
+void octeon3_sso_free_grp_range(int node, int *grp, int req_cnt)
+{
+	struct global_resource_tag tag;
+	char buf[16];
+
+	/* Allocate the request group range */
+	strncpy((char *)&tag.lo, "cvm_sso_", 8);
+	snprintf(buf, 16, "0%d......", node);
+	memcpy(&tag.hi, buf, 8);
+
+	res_mgr_free_range(tag, grp, req_cnt);
+}
+EXPORT_SYMBOL(octeon3_sso_free_grp_range);
+
+/**
+ * octeon3_sso_free_grp() - Free a sso group.
+ * @node: Node where sso resides.
+ * @grp: Group to free.
+ */
+void octeon3_sso_free_grp(int node, int grp)
+{
+	octeon3_sso_free_grp_range(node, &grp, 1);
+}
+EXPORT_SYMBOL(octeon3_sso_free_grp);
+
+/**
+ * octeon3_sso_pass1_limit() - Near full TAQ can cause hang. When the TAQ
+ *			     (Transitory Admission Queue) is near-full, it is
+ *			     possible for SSO to hang.
+ *			     Workaround: Ensure that the sum of
+ *			     SSO_GRP(0..255)_TAQ_THR[MAX_THR] of all used
+ *			     groups is <= 1264. This may reduce single-group
+ *			     performance when many groups are used.
+ *
+ * @node: Node to update.
+ * @grp: SSO group to update.
+ */
+void octeon3_sso_pass1_limit(int node, int grp)
+{
+	u64 taq_thr;
+	u64 taq_add;
+	u64 max_thr;
+	u64 rsvd_thr;
+
+	/* Ideally, we would like to divide the maximum number of TAQ buffers
+	 * (1264) among the sso groups in use. However, since we don't know how
+	 * many sso groups are used by code outside this driver we take the
+	 * worst case approach and assume all 256 sso groups must be supported.
+	 */
+	max_thr = 1264 / get_num_sso_grps();
+	if (max_thr < 4)
+		max_thr = 4;
+	rsvd_thr = max_thr - 1;
+
+	/* Changes to SSO_GRP_TAQ_THR[rsvd_thr] must also update
+	 * SSO_TAQ_ADD[RSVD_FREE].
+	 */
+	taq_thr = oct_csr_read(SSO_GRP_TAQ_THR(node, grp));
+	taq_add = (rsvd_thr - (taq_thr & GENMASK_ULL(10, 0))) << 16;
+
+	taq_thr &= ~(GENMASK_ULL(42, 32) | GENMASK_ULL(10, 0));
+	taq_thr |= max_thr << 32;
+	taq_thr |= rsvd_thr;
+
+	oct_csr_write(taq_thr, SSO_GRP_TAQ_THR(node, grp));
+	oct_csr_write(taq_add, SSO_TAQ_ADD(node));
+}
+EXPORT_SYMBOL(octeon3_sso_pass1_limit);
+
+/**
+ * octeon3_sso_shutdown() - Shutdown the sso. It undoes what octeon3_sso_init()
+ *			    did.
+ * @node: Node where sso to disable is.
+ * @aura: Aura used for the sso buffers.
+ */
+void octeon3_sso_shutdown(int node, int aura)
+{
+	u64 data;
+	int max_grps;
+	int timeout;
+	int i;
+
+	/* Disable sso */
+	data = oct_csr_read(SSO_AW_CFG(node));
+	data |= BIT(6) | BIT(4);
+	data &= ~BIT(0);
+	oct_csr_write(data, SSO_AW_CFG(node));
+
+	/* Extract the fpa buffers */
+	max_grps = get_num_sso_grps();
+	for (i = 0; i < max_grps; i++) {
+		u64 head;
+		u64 tail;
+		void *ptr;
+
+		head = oct_csr_read(SSO_XAQ_HEAD_PTR(node, i));
+		tail = oct_csr_read(SSO_XAQ_TAIL_PTR(node, i));
+		data = oct_csr_read(SSO_GRP_AQ_CNT(node, i));
+
+		/* Verify pointers */
+		head &= GENMASK_ULL(41, 7);
+		tail &= GENMASK_ULL(41, 7);
+		if (head != tail) {
+			pr_err("octeon3_sso: bad ptr\n");
+			continue;
+		}
+
+		/* This sso group should have no pending entries */
+		if (data & GENMASK_ULL(32, 0))
+			pr_err("octeon3_sso: not empty\n");
+
+		ptr = phys_to_virt(head);
+		octeon_fpa3_free(node, aura, ptr);
+
+		/* Clear pointers */
+		oct_csr_write(0, SSO_XAQ_HEAD_PTR(node, i));
+		oct_csr_write(0, SSO_XAQ_HEAD_NEXT(node, i));
+		oct_csr_write(0, SSO_XAQ_TAIL_PTR(node, i));
+		oct_csr_write(0, SSO_XAQ_TAIL_NEXT(node, i));
+	}
+
+	/* Make sure all buffers drained */
+	timeout = 10000;
+	do {
+		data = oct_csr_read(SSO_AW_STATUS(node));
+		if ((data & GENMASK_ULL(5, 0)) == 0)
+			break;
+		timeout--;
+		udelay(1);
+	} while (timeout);
+	if (!timeout)
+		pr_err("octeon3_sso: timeout\n");
+}
+EXPORT_SYMBOL(octeon3_sso_shutdown);
+
+/**
+ * octeon3_sso_init() - Initialize the sso.
+ * @node: Node where sso resides.
+ * @aura: Aura used for the sso buffers.
+ */
+int octeon3_sso_init(int node, int aura)
+{
+	u64 data;
+	int max_grps;
+	int i;
+	int rc = 0;
+
+	data = BIT(3) | BIT(2) | BIT(1);
+	oct_csr_write(data, SSO_AW_CFG(node));
+
+	data = (node << 10) | aura;
+	oct_csr_write(data, SSO_XAQ_AURA(node));
+
+	max_grps = get_num_sso_grps();
+	for (i = 0; i < max_grps; i++) {
+		u64 phys;
+		void *mem;
+
+		mem = octeon_fpa3_alloc(node, aura);
+		if (!mem) {
+			rc = -ENOMEM;
+			goto err;
+		}
+
+		phys = virt_to_phys(mem);
+		oct_csr_write(phys, SSO_XAQ_HEAD_PTR(node, i));
+		oct_csr_write(phys, SSO_XAQ_HEAD_NEXT(node, i));
+		oct_csr_write(phys, SSO_XAQ_TAIL_PTR(node, i));
+		oct_csr_write(phys, SSO_XAQ_TAIL_NEXT(node, i));
+
+		/* SSO-18678 */
+		data = 0x3f << 16;
+		oct_csr_write(data, SSO_GRP_PRI(node, i));
+	}
+
+	data = BIT(0);
+	oct_csr_write(data, SSO_ERR0(node));
+
+	data = BIT(3) | BIT(2) | BIT(1) | BIT(0);
+	oct_csr_write(data, SSO_AW_CFG(node));
+
+ err:
+	return rc;
+}
+EXPORT_SYMBOL(octeon3_sso_init);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Cavium, Inc. <support@cavium.com>");
+MODULE_DESCRIPTION("Cavium, Inc. SSO management.");
diff --git a/drivers/net/ethernet/cavium/octeon/octeon3.h b/drivers/net/ethernet/cavium/octeon/octeon3.h
new file mode 100644
index 000000000000..79b5fdabb50b
--- /dev/null
+++ b/drivers/net/ethernet/cavium/octeon/octeon3.h
@@ -0,0 +1,418 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2017 Cavium, Inc. */
+#ifndef _OCTEON3_H_
+#define _OCTEON3_H_
+
+#include <linux/netdevice.h>
+#include <linux/platform_device.h>
+
+#define MAX_NODES			2
+#define NODE_MASK			(MAX_NODES - 1)
+#define MAX_BGX_PER_NODE		6
+#define MAX_LMAC_PER_BGX		4
+
+#define IOBDMA_ORDERED_IO_ADDR		0xffffffffffffa200ull
+#define LMTDMA_ORDERED_IO_ADDR		0xffffffffffffa400ull
+
+#define SCRATCH_BASE			0xffffffffffff8000ull
+#define PKO_LMTLINE			2ull
+#define LMTDMA_SCR_OFFSET		(PKO_LMTLINE * CVMX_CACHE_LINE_SIZE)
+
+/* Pko sub-command three bit codes (SUBDC3) */
+#define PKO_SENDSUBDC_GATHER		0x1
+
+/* Pko sub-command four bit codes (SUBDC4) */
+#define PKO_SENDSUBDC_TSO		0x8
+#define PKO_SENDSUBDC_FREE		0x9
+#define PKO_SENDSUBDC_WORK		0xa
+#define PKO_SENDSUBDC_MEM		0xc
+#define PKO_SENDSUBDC_EXT		0xd
+
+#define BGX_RX_FIFO_SIZE		(64 * 1024)
+#define BGX_TX_FIFO_SIZE		(32 * 1024)
+
+/* Registers are accessed via xkphys */
+#define SET_XKPHYS			BIT_ULL(63)
+#define NODE_OFFSET(node)		((node) * 0x1000000000ull)
+
+/* Bgx register definitions */
+#define BGX_BASE			0x11800e0000000ull
+#define BGX_OFFSET(bgx)			(BGX_BASE + ((bgx) << 24))
+#define INDEX_OFFSET(index)		((index) << 20)
+#define INDEX_ADDR(n, b, i)		(SET_XKPHYS + NODE_OFFSET(n) +	       \
+					 BGX_OFFSET(b) + INDEX_OFFSET(i))
+#define CAM_OFFSET(mac)			((mac) << 3)
+#define CAM_ADDR(n, b, m)		(INDEX_ADDR(n, b, 0) + CAM_OFFSET(m))
+
+#define BGX_CMR_CONFIG(n, b, i)		(INDEX_ADDR(n, b, i)	      + 0x00000)
+#define BGX_CMR_GLOBAL_CONFIG(n, b)	(INDEX_ADDR(n, b, 0)	      + 0x00008)
+#define BGX_CMR_RX_ID_MAP(n, b, i)	(INDEX_ADDR(n, b, i)	      + 0x00028)
+#define BGX_CMR_RX_BP_ON(n, b, i)	(INDEX_ADDR(n, b, i)	      + 0x00088)
+#define BGX_CMR_RX_ADR_CTL(n, b, i)	(INDEX_ADDR(n, b, i)	      + 0x000a0)
+#define BGX_CMR_RX_FIFO_LEN(n, b, i)	(INDEX_ADDR(n, b, i)	      + 0x000c0)
+#define BGX_CMR_RX_ADRX_CAM(n, b, m)	(CAM_ADDR(n, b, m)	      + 0x00100)
+#define BGX_CMR_CHAN_MSK_AND(n, b)	(INDEX_ADDR(n, b, 0)	      + 0x00200)
+#define BGX_CMR_CHAN_MSK_OR(n, b)	(INDEX_ADDR(n, b, 0)	      + 0x00208)
+#define BGX_CMR_TX_FIFO_LEN(n, b, i)	(INDEX_ADDR(n, b, i)	      + 0x00418)
+#define BGX_CMR_TX_LMACS(n, b)		(INDEX_ADDR(n, b, 0)	      + 0x01000)
+
+#define BGX_SPU_CONTROL1(n, b, i)	(INDEX_ADDR(n, b, i)	      + 0x10000)
+#define BGX_SPU_STATUS1(n, b, i)	(INDEX_ADDR(n, b, i)	      + 0x10008)
+#define BGX_SPU_STATUS2(n, b, i)	(INDEX_ADDR(n, b, i)	      + 0x10020)
+#define BGX_SPU_BX_STATUS(n, b, i)	(INDEX_ADDR(n, b, i)	      + 0x10028)
+#define BGX_SPU_BR_STATUS1(n, b, i)	(INDEX_ADDR(n, b, i)	      + 0x10030)
+#define BGX_SPU_BR_STATUS2(n, b, i)	(INDEX_ADDR(n, b, i)	      + 0x10038)
+#define BGX_SPU_BR_BIP_ERR_CNT(n, b, i)	(INDEX_ADDR(n, b, i)	      + 0x10058)
+#define BGX_SPU_BR_PMD_CONTROL(n, b, i)	(INDEX_ADDR(n, b, i)	      + 0x10068)
+#define BGX_SPU_BR_PMD_LP_CUP(n, b, i)	(INDEX_ADDR(n, b, i)	      + 0x10078)
+#define BGX_SPU_BR_PMD_LD_CUP(n, b, i)	(INDEX_ADDR(n, b, i)	      + 0x10088)
+#define BGX_SPU_BR_PMD_LD_REP(n, b, i)	(INDEX_ADDR(n, b, i)	      + 0x10090)
+#define BGX_SPU_FEC_CONTROL(n, b, i)	(INDEX_ADDR(n, b, i)	      + 0x100a0)
+#define BGX_SPU_AN_CONTROL(n, b, i)	(INDEX_ADDR(n, b, i)	      + 0x100c8)
+#define BGX_SPU_AN_STATUS(n, b, i)	(INDEX_ADDR(n, b, i)	      + 0x100d0)
+#define BGX_SPU_AN_ADV(n, b, i)		(INDEX_ADDR(n, b, i)	      + 0x100d8)
+#define BGX_SPU_MISC_CONTROL(n, b, i)	(INDEX_ADDR(n, b, i)	      + 0x10218)
+#define BGX_SPU_INT(n, b, i)		(INDEX_ADDR(n, b, i)	      + 0x10220)
+#define BGX_SPU_DBG_CONTROL(n, b)	(INDEX_ADDR(n, b, 0)	      + 0x10300)
+
+#define BGX_SMU_RX_INT(n, b, i)		(INDEX_ADDR(n, b, i)	      + 0x20000)
+#define BGX_SMU_RX_FRM_CTL(n, b, i)	(INDEX_ADDR(n, b, i)	      + 0x20008)
+#define BGX_SMU_RX_JABBER(n, b, i)	(INDEX_ADDR(n, b, i)	      + 0x20018)
+#define BGX_SMU_RX_CTL(n, b, i)		(INDEX_ADDR(n, b, i)	      + 0x20030)
+#define BGX_SMU_TX_APPEND(n, b, i)	(INDEX_ADDR(n, b, i)	      + 0x20100)
+#define BGX_SMU_TX_MIN_PKT(n, b, i)	(INDEX_ADDR(n, b, i)	      + 0x20118)
+#define BGX_SMU_TX_INT(n, b, i)		(INDEX_ADDR(n, b, i)	      + 0x20140)
+#define BGX_SMU_TX_CTL(n, b, i)		(INDEX_ADDR(n, b, i)	      + 0x20160)
+#define BGX_SMU_TX_THRESH(n, b, i)	(INDEX_ADDR(n, b, i)	      + 0x20168)
+#define BGX_SMU_CTRL(n, b, i)		(INDEX_ADDR(n, b, i)	      + 0x20200)
+
+#define BGX_GMP_PCS_MR_CONTROL(n, b, i)	(INDEX_ADDR(n, b, i)	      + 0x30000)
+#define BGX_GMP_PCS_MR_STATUS(n, b, i)	(INDEX_ADDR(n, b, i)	      + 0x30008)
+#define BGX_GMP_PCS_AN_ADV(n, b, i)	(INDEX_ADDR(n, b, i)	      + 0x30010)
+#define BGX_GMP_PCS_LINK_TIMER(n, b, i)	(INDEX_ADDR(n, b, i)	      + 0x30040)
+#define BGX_GMP_PCS_SGM_AN_ADV(n, b, i)	(INDEX_ADDR(n, b, i)	      + 0x30068)
+#define BGX_GMP_PCS_MISC_CTL(n, b, i)	(INDEX_ADDR(n, b, i)	      + 0x30078)
+#define BGX_GMP_GMI_PRT_CFG(n, b, i)	(INDEX_ADDR(n, b, i)	      + 0x38010)
+#define BGX_GMP_GMI_RX_FRM_CTL(n, b, i)	(INDEX_ADDR(n, b, i)	      + 0x38018)
+#define BGX_GMP_GMI_RX_JABBER(n, b, i)	(INDEX_ADDR(n, b, i)	      + 0x38038)
+#define BGX_GMP_GMI_TX_THRESH(n, b, i)	(INDEX_ADDR(n, b, i)	      + 0x38210)
+#define BGX_GMP_GMI_TX_APPEND(n, b, i)	(INDEX_ADDR(n, b, i)	      + 0x38218)
+#define BGX_GMP_GMI_TX_SLOT(n, b, i)	(INDEX_ADDR(n, b, i)	      + 0x38220)
+#define BGX_GMP_GMI_TX_BURST(n, b, i)	(INDEX_ADDR(n, b, i)	      + 0x38228)
+#define BGX_GMP_GMI_TX_MIN_PKT(n, b, i)	(INDEX_ADDR(n, b, i)	      + 0x38240)
+#define BGX_GMP_GMI_TX_SGMII_CTL(n, b, i) (INDEX_ADDR(n, b, i)	      + 0x38300)
+
+/* XCV register definitions */
+#define XCV_BASE			0x11800db000000ull
+#define SET_XCV_BASE(node)		(SET_XKPHYS + NODE_OFFSET(node) +      \
+					 XCV_BASE)
+#define XCV_RESET(node)			(SET_XCV_BASE(node)	       + 0x0000)
+#define XCV_DLL_CTL(node)		(SET_XCV_BASE(node)	       + 0x0010)
+#define XCV_COMP_CTL(node)		(SET_XCV_BASE(node)	       + 0x0020)
+#define XCV_CTL(node)			(SET_XCV_BASE(node)	       + 0x0030)
+#define XCV_INT(node)			(SET_XCV_BASE(node)	       + 0x0040)
+#define XCV_INBND_STATUS(node)		(SET_XCV_BASE(node)	       + 0x0080)
+#define XCV_BATCH_CRD_RET(node)		(SET_XCV_BASE(node)	       + 0x0100)
+
+/* Gser register definitions */
+#define GSER_BASE			0x1180090000000ull
+#define GSER_OFFSET(gser)		(GSER_BASE + ((gser) << 24))
+#define GSER_LANE_OFFSET(lane)		((lane) << 20)
+#define GSER_LANE_ADDR(n, g, l)		(SET_XKPHYS + NODE_OFFSET(n) +	       \
+					 GSER_OFFSET(g) + GSER_LANE_OFFSET(l))
+#define GSER_PHY_CTL(n, g)		(GSER_LANE_ADDR(n, g, 0)     + 0x000000)
+#define GSER_CFG(n, g)			(GSER_LANE_ADDR(n, g, 0)     + 0x000080)
+#define GSER_LANE_MODE(n, g)		(GSER_LANE_ADDR(n, g, 0)     + 0x000118)
+#define GSER_RX_EIE_DETSTS(n, g)	(GSER_LANE_ADDR(n, g, 0)     + 0x000150)
+#define GSER_LANE_LBERT_CFG(n, g, l)	(GSER_LANE_ADDR(n, g, l)     + 0x4c0020)
+#define GSER_LANE_PCS_CTLIFC_0(n, g, l)	(GSER_LANE_ADDR(n, g, l)     + 0x4c0060)
+#define GSER_LANE_PCS_CTLIFC_2(n, g, l)	(GSER_LANE_ADDR(n, g, l)     + 0x4c0070)
+
+/* Odd gser registers */
+#define GSER_LANE_OFFSET_1(lane)	((lane) << 7)
+#define GSER_LANE_ADDR_1(n, g, l)	(SET_XKPHYS + NODE_OFFSET(n) +	       \
+					 GSER_OFFSET(g) + GSER_LANE_OFFSET_1(l))
+
+#define GSER_BR_RX_CTL(n, g, l)		(GSER_LANE_ADDR_1(n, g, l)   + 0x000400)
+#define GSER_BR_RX_EER(n, g, l)		(GSER_LANE_ADDR_1(n, g, l)   + 0x000418)
+
+#define GSER_LANE_OFFSET_2(mode)	((mode) << 5)
+#define GSER_LANE_ADDR_2(n, g, m)	(SET_XKPHYS + NODE_OFFSET(n) +	       \
+					 GSER_OFFSET(g) + GSER_LANE_OFFSET_2(m))
+
+#define GSER_LANE_P_MODE_1(n, g, m)	(GSER_LANE_ADDR_2(n, g, m)   + 0x4e0048)
+
+#define DPI_BASE			0x1df0000000000ull
+#define DPI_ADDR(n)			(SET_XKPHYS + NODE_OFFSET(n) + DPI_BASE)
+#define DPI_CTL(n)			(DPI_ADDR(n)                  + 0x00040)
+
+enum octeon3_mac_type {
+	BGX_MAC,
+	SRIO_MAC
+};
+
+enum octeon3_src_type {
+	QLM,
+	XCV
+};
+
+struct mac_platform_data {
+	enum octeon3_mac_type	mac_type;
+	int			numa_node;
+	int			interface;
+	int			port;
+	enum octeon3_src_type	src_type;
+};
+
+struct bgx_port_netdev_priv {
+	struct bgx_port_priv *bgx_priv;
+};
+
+/* Remove this define to use these enums after the last cvmx code references are
+ * gone.
+ */
+/* PKO_MEMDSZ_E */
+enum pko_memdsz_e {
+	MEMDSZ_B64 = 0,
+	MEMDSZ_B32 = 1,
+	MEMDSZ_B16 = 2,
+	MEMDSZ_B8 = 3
+};
+
+/* PKO_MEMALG_E */
+enum pko_memalg_e {
+	MEMALG_SET = 0,
+	MEMALG_SETTSTMP = 1,
+	MEMALG_SETRSLT = 2,
+	MEMALG_ADD = 8,
+	MEMALG_SUB = 9,
+	MEMALG_ADDLEN = 0xA,
+	MEMALG_SUBLEN = 0xB,
+	MEMALG_ADDMBUF = 0xC,
+	MEMALG_SUBMBUF = 0xD
+};
+
+/* PKO_QUERY_RTN_S[DQSTATUS] */
+enum pko_query_dqstatus {
+	PKO_DQSTATUS_PASS = 0,
+	PKO_DQSTATUS_BADSTATE = 0x8,
+	PKO_DQSTATUS_NOFPABUF = 0x9,
+	PKO_DQSTATUS_NOPKOBUF = 0xA,
+	PKO_DQSTATUS_FAILRTNPTR = 0xB,
+	PKO_DQSTATUS_ALREADY = 0xC,
+	PKO_DQSTATUS_NOTCREATED = 0xD,
+	PKO_DQSTATUS_NOTEMPTY = 0xE,
+	PKO_DQSTATUS_SENDPKTDROP = 0xF
+};
+
+union wqe_word0 {
+	u64 u64;
+	struct {
+		__BITFIELD_FIELD(u64 rsvd_0:4,
+		__BITFIELD_FIELD(u64 aura:12,
+		__BITFIELD_FIELD(u64 rsvd_1:1,
+		__BITFIELD_FIELD(u64 apad:3,
+		__BITFIELD_FIELD(u64 channel:12,
+		__BITFIELD_FIELD(u64 bufs:8,
+		__BITFIELD_FIELD(u64 style:8,
+		__BITFIELD_FIELD(u64 rsvd_2:10,
+		__BITFIELD_FIELD(u64 pknd:6,
+		;)))))))))
+	};
+};
+
+union wqe_word1 {
+	u64 u64;
+	struct {
+		__BITFIELD_FIELD(u64 len:16,
+		__BITFIELD_FIELD(u64 rsvd_0:2,
+		__BITFIELD_FIELD(u64 rsvd_1:2,
+		__BITFIELD_FIELD(u64 grp:10,
+		__BITFIELD_FIELD(u64 tag_type:2,
+		__BITFIELD_FIELD(u64 tag:32,
+		;))))))
+	};
+};
+
+union wqe_word2 {
+	u64 u64;
+	struct {
+		__BITFIELD_FIELD(u64 software:1,
+		__BITFIELD_FIELD(u64 lg_hdr_type:5,
+		__BITFIELD_FIELD(u64 lf_hdr_type:5,
+		__BITFIELD_FIELD(u64 le_hdr_type:5,
+		__BITFIELD_FIELD(u64 ld_hdr_type:5,
+		__BITFIELD_FIELD(u64 lc_hdr_type:5,
+		__BITFIELD_FIELD(u64 lb_hdr_type:5,
+		__BITFIELD_FIELD(u64 is_la_ether:1,
+		__BITFIELD_FIELD(u64 rsvd_0:8,
+		__BITFIELD_FIELD(u64 vlan_valid:1,
+		__BITFIELD_FIELD(u64 vlan_stacked:1,
+		__BITFIELD_FIELD(u64 stat_inc:1,
+		__BITFIELD_FIELD(u64 pcam_flag4:1,
+		__BITFIELD_FIELD(u64 pcam_flag3:1,
+		__BITFIELD_FIELD(u64 pcam_flag2:1,
+		__BITFIELD_FIELD(u64 pcam_flag1:1,
+		__BITFIELD_FIELD(u64 is_frag:1,
+		__BITFIELD_FIELD(u64 is_l3_bcast:1,
+		__BITFIELD_FIELD(u64 is_l3_mcast:1,
+		__BITFIELD_FIELD(u64 is_l2_bcast:1,
+		__BITFIELD_FIELD(u64 is_l2_mcast:1,
+		__BITFIELD_FIELD(u64 is_raw:1,
+		__BITFIELD_FIELD(u64 err_level:3,
+		__BITFIELD_FIELD(u64 err_code:8,
+		;))))))))))))))))))))))))
+	};
+};
+
+union buf_ptr {
+	u64 u64;
+	struct {
+		__BITFIELD_FIELD(u64 size:16,
+		__BITFIELD_FIELD(u64 packet_outside_wqe:1,
+		__BITFIELD_FIELD(u64 rsvd0:5,
+		__BITFIELD_FIELD(u64 addr:42,
+		;))))
+	};
+};
+
+union wqe_word4 {
+	u64 u64;
+	struct {
+		__BITFIELD_FIELD(u64 ptr_vlan:8,
+		__BITFIELD_FIELD(u64 ptr_layer_g:8,
+		__BITFIELD_FIELD(u64 ptr_layer_f:8,
+		__BITFIELD_FIELD(u64 ptr_layer_e:8,
+		__BITFIELD_FIELD(u64 ptr_layer_d:8,
+		__BITFIELD_FIELD(u64 ptr_layer_c:8,
+		__BITFIELD_FIELD(u64 ptr_layer_b:8,
+		__BITFIELD_FIELD(u64 ptr_layer_a:8,
+		;))))))))
+	};
+};
+
+struct wqe {
+	union wqe_word0	word0;
+	union wqe_word1	word1;
+	union wqe_word2	word2;
+	union buf_ptr	packet_ptr;
+	union wqe_word4	word4;
+	u64		wqe_data[11];
+};
+
+enum port_mode {
+	PORT_MODE_DISABLED,
+	PORT_MODE_SGMII,
+	PORT_MODE_RGMII,
+	PORT_MODE_XAUI,
+	PORT_MODE_RXAUI,
+	PORT_MODE_XLAUI,
+	PORT_MODE_XFI,
+	PORT_MODE_10G_KR,
+	PORT_MODE_40G_KR4
+};
+
+enum lane_mode {
+	R_25G_REFCLK100,
+	R_5G_REFCLK100,
+	R_8G_REFCLK100,
+	R_125G_REFCLK15625_KX,
+	R_3125G_REFCLK15625_XAUI,
+	R_103125G_REFCLK15625_KR,
+	R_125G_REFCLK15625_SGMII,
+	R_5G_REFCLK15625_QSGMII,
+	R_625G_REFCLK15625_RXAUI,
+	R_25G_REFCLK125,
+	R_5G_REFCLK125,
+	R_8G_REFCLK125
+};
+
+struct port_status {
+	int	link;
+	int	duplex;
+	int	speed;
+};
+
+static inline u64 oct_csr_read(u64 addr)
+{
+	return __raw_readq((void __iomem *)addr);
+}
+
+static inline void oct_csr_write(u64 data, u64 addr)
+{
+	__raw_writeq(data, (void __iomem *)addr);
+}
+
+static inline int bgx_addr_to_interface(u64 addr)
+{
+	return (addr >> 24) & 0xf;
+}
+
+static inline int bgx_node_to_numa_node(struct device_node *np)
+{
+	int ret = of_node_to_nid(np);
+
+	return ret == NUMA_NO_NODE ? 0 : ret;
+}
+
+extern int ilk0_lanes;
+extern int ilk1_lanes;
+
+void bgx_nexus_load(void);
+
+int bgx_port_allocate_pknd(int node);
+int bgx_port_get_pknd(int node, int bgx, int index);
+enum port_mode bgx_port_get_mode(int node, int bgx, int index);
+int bgx_port_get_qlm(int node, int bgx, int index);
+void bgx_port_set_netdev(struct device *dev, struct net_device *netdev);
+int bgx_port_enable(struct net_device *netdev);
+int bgx_port_disable(struct net_device *netdev);
+const u8 *bgx_port_get_mac(struct net_device *netdev);
+void bgx_port_set_rx_filtering(struct net_device *netdev);
+int bgx_port_change_mtu(struct net_device *netdev, int new_mtu);
+int bgx_port_ethtool_get_link_ksettings(struct net_device *netdev,
+					struct ethtool_link_ksettings *cmd);
+int bgx_port_ethtool_get_settings(struct net_device *netdev,
+				  struct ethtool_cmd *cmd);
+int bgx_port_ethtool_set_settings(struct net_device *netdev,
+				  struct ethtool_cmd *cmd);
+int bgx_port_ethtool_nway_reset(struct net_device *netdev);
+int bgx_port_do_ioctl(struct net_device *netdev, struct ifreq *ifr, int cmd);
+
+void bgx_port_mix_assert_reset(struct net_device *netdev, int mix, bool v);
+
+int octeon3_pki_vlan_init(int node);
+int octeon3_pki_cluster_init(int node, struct platform_device *pdev);
+int octeon3_pki_ltype_init(int node);
+int octeon3_pki_enable(int node);
+int octeon3_pki_port_init(int node, int aura, int grp, int skip, int mb_size,
+			  int pknd, int num_rx_cxt);
+int octeon3_pki_get_stats(int node, int pknd, u64 *packets, u64 *octets,
+			  u64 *dropped);
+int octeon3_pki_set_ptp_skip(int node, int pknd, int skip);
+int octeon3_pki_port_shutdown(int node, int pknd);
+void octeon3_pki_shutdown(int node);
+
+void octeon3_sso_pass1_limit(int node, int grp);
+int octeon3_sso_init(int node, int aura);
+void octeon3_sso_shutdown(int node, int aura);
+int octeon3_sso_alloc_grp(int node, int grp);
+int octeon3_sso_alloc_grp_range(int node, int req_grp, int req_cnt,
+				bool use_last_avail, int *grp);
+void octeon3_sso_free_grp(int node, int grp);
+void octeon3_sso_free_grp_range(int node, int *grp, int req_cnt);
+void octeon3_sso_irq_set(int node, int grp, bool en);
+
+int octeon3_pko_interface_init(int node, int interface, int index,
+			       enum octeon3_mac_type mac_type, int ipd_port);
+int octeon3_pko_activate_dq(int node, int dq, int cnt);
+int octeon3_pko_get_fifo_size(int node, int interface, int index,
+			      enum octeon3_mac_type mac_type);
+int octeon3_pko_set_mac_options(int node, int interface, int index,
+				enum octeon3_mac_type mac_type, bool fcs_en,
+				bool pad_en, int fcs_sop_off);
+int octeon3_pko_init_global(int node, int aura);
+int octeon3_pko_interface_uninit(int node, const int *dq, int num_dq);
+int octeon3_pko_exit_global(int node);
+
+#endif /* _OCTEON3_H_ */
-- 
2.14.3

Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 02 Dec 2017 00:19:09 +0100 (CET)
Received: from mail-by2nam03on0043.outbound.protection.outlook.com ([104.47.42.43]:17992
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23991100AbdLAXSag6wns (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 2 Dec 2017 00:18:30 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=+xGCXfVgT3ZjsVa8BaQUj4vjyihr26dDMshXgQeJcmA=;
 b=MyhmuHaa3CxXY3J3pSS5DvLAGXuSgDFz2tJsxw9rmgS7EsTc5X7K+lL33IEbg7J0nhwdazEfgSLZvFAx4ddNV8r6fUzZcJG/1QVl7LEmordwUrgf2xPRutTSAQ7aRqNJ1n7on195dKajRDnLloJ0kU9XMA0PxSVWdUtzFocuHKk=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=David.Daney@cavium.com; 
Received: from ddl.caveonetworks.com (50.233.148.156) by
 DM5PR07MB3499.namprd07.prod.outlook.com (10.164.153.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.260.4; Fri, 1 Dec 2017 23:18:19 +0000
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
Subject: [PATCH v5 net-next,mips 1/7] dt-bindings: Add Cavium Octeon Common Ethernet Interface.
Date:   Fri,  1 Dec 2017 15:18:01 -0800
Message-Id: <20171201231807.25266-2-david.daney@cavium.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20171201231807.25266-1-david.daney@cavium.com>
References: <20171201231807.25266-1-david.daney@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: CO2PR07CA0064.namprd07.prod.outlook.com (10.174.192.32) To
 DM5PR07MB3499.namprd07.prod.outlook.com (10.164.153.30)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 86fb19c7-e8ab-4c14-3dcb-08d53911d2f5
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(4534020)(4602075)(4627115)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603286);SRVR:DM5PR07MB3499;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3499;3:wHEQqyJM5CoXgnmAyoJLbfqfsH2yPbtfpPaZUTZasVSv31AhNOwsjc4RIiSNaJGWSuNOOLZihDg5/h0RfeC+c8iU8Mnx8+7z6AoFqFm8xuT2XC1xriOAqmHzMybJeBYpSMzNImq0WLbiGYgCbtJSdpLH1bpan3lCXZ48F8gTNH/bLDrPA4UpGXCCnAh+Iu/MToBi/4HncEnKEoZVfsukxw1tJjEWNH2Fow16KmSddtuO5v/l+hO0AKPnlWXwNMuX;25:zFy1biO9B/DNM6y3yRVMI/I8S713u6dIpT9Ti5DxYYfocCBHZnuQ99USSf4KAghXPXQKSZbya4mEkwtr4yxGDpO5YGtv5nFYP+JU8bvTtv0HpKHhmUYVs4qi9FXRFVJVjtgLpHKGixjcri0L9nrlMW7ggjq+7bcMWK+LXz813Tf3d1AOOBS9qudNqhfyDkYOn5mB9FFFFjIFgEdx8tm895CQu0fzbcJaFNAqtyW2r1Z9yhoIqGek5PlpbQIpoHw5R2C8DvzFrN0qo/2MgSOOJ6woF2Nlug6QFAmnMIHYb3erWmP+tpAAgtrvI4YYbvxkiTMt/9R1vBZ1vQR873mnlw==;31:JL1i1Qzf4aVli7nNLtCeLZPFvv1F3C5TjN4dZ8ukWkjlDwe+awh7XxtBlb8KTTN+kwQ2/MBPyLLpnd4jr6zTl8uhfVvKTgKlMLy8IbEDsg0RREWpOKP2EaXkj4T7/Asf+qRyH5WWyZx9ysyClF4yMLQqnotMzc96kbMVdE8SttBnAX9TiGuq9v+xhM/yIQI/ESMeqq5i79Ozz/UXv4orhdTLDoFwrsOZQXWAsruzn5M=
X-MS-TrafficTypeDiagnostic: DM5PR07MB3499:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3499;20:cL+c6qT6QnGHd/wZcIACZK284cyftzvtA2hUtSUvr1dzNawglL+HWNxPTJeqlyrICqC+EdDogElxAjByED6p45Z3hbmtLGQR4V48giq0LUtjcxXLmGb3XsjGUFdWtlI8KhB0rly3g/ui2E05FqJCerLcw1D6lZRApC3rhcs690PVDFJk9YWp4qyOgbbBqLEodnV8ujvEFF2OGlWCdhOhZun1uv7Vyb7khbkhKyxou7mLhVWqgPXP/vPET5sUXXcC7rf3beGoFguUmQrun9HAzQrzvVmpkcHjvHlPl0GeCBetaf0fWD7jA/FiRv1dFK7ZtWIjzFfcj3pyncedJSq6ssIA7GPbwxcppW0nL9M1J6ospoA5oCevHWsO66MgQasA+M5OB161EccVIsN+njuBT9beU0Rf7DRmnv16uRZ2cPYQ29DAK4lq2RRC12IgfMUrm4IOz991694Kuogomk8hFwdvoZUQ3bzscWKlCzk1vLa2k154ESonlMRWsKFlVMJy;4:r2hm1bLJTYAjXaz6aSBPSG2LwCiiNcM10fgAYBOdMYaOFTOmpKlJ+pyQCs3m8VVbYE1Ot7GjrSeNpgdtHj2J2h3922jdNUCG4XUTy9zUck+zOS5H5G3jLgWCcUhSiRKJ9L1qCQ16pTkR8GNXDPpoOOcKUI9UKNHLwKVpxnd4m5KkorANiD4NGK6wkFVuZf9v9+6xom/AQgcf6qQspmHsimvc2NfCZjo4W707DDclMlt2l030Ullr+OYGRGIVFD3nyFbDgHtdyj9dKlabrQKHGQ==
X-Microsoft-Antispam-PRVS: <DM5PR07MB3499D0F81624B03EDD07A69697390@DM5PR07MB3499.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040450)(2401047)(8121501046)(5005006)(3231022)(93006095)(93001095)(10201501046)(3002001)(6041248)(20161123564025)(20161123555025)(20161123560025)(20161123558100)(20161123562025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR07MB3499;BCL:0;PCL:0;RULEID:(100000803101)(100110400095);SRVR:DM5PR07MB3499;
X-Forefront-PRVS: 05087F0C24
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(979002)(6009001)(346002)(376002)(366004)(189002)(199003)(47776003)(72206003)(1076002)(7416002)(50466002)(4326008)(66066001)(16526018)(48376002)(33646002)(6666003)(76176011)(97736004)(86362001)(68736007)(25786009)(39060400002)(2950100002)(101416001)(478600001)(53416004)(6506006)(106356001)(5660300001)(3846002)(105586002)(36756003)(69596002)(8676002)(6512007)(2906002)(51416003)(53936002)(81156014)(110136005)(6116002)(81166006)(8936002)(7736002)(52116002)(16586007)(316002)(107886003)(189998001)(6486002)(305945005)(50226002)(54906003)(142933001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR07MB3499;H:ddl.caveonetworks.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR07MB3499;23:bza+ktltbWvo1hRL3UW95bR27kSKlWZeoF9MLCsO3?=
 =?us-ascii?Q?mJKsAmFF05TWY+AXglfqeUeYGTdQhmnX4U4ejtjWPTr/PuDZi9apnRP2qs84?=
 =?us-ascii?Q?UweSmnTtM6V28KZFm5jjdZA5ExK86+NihXP9+CIT8HB2D7dVggz/jkqBW+Hb?=
 =?us-ascii?Q?dIejJXBgovslhKWfV3LK8Lzo5adoaOkk9EeBEc2PNjxlQWFxrBECfUiaj4O+?=
 =?us-ascii?Q?OU6taaTWlDMZ23yDpsSwU5O+KswwXphOUNNSGN5jxPTFTMFEhHTPue3r+2en?=
 =?us-ascii?Q?Cdhc6AXkLK+1Dokmq0CFY6+wnJDNtDAP+4JnUitLi8igkSziW172ZdtIpqRU?=
 =?us-ascii?Q?GEMew7aNxkUGj0tUsWLY5kWyRpOG9FbG4A6tpcYFlP1Ip9kSjqu9EH9CQF1S?=
 =?us-ascii?Q?lrJYX02OKCvUUaIaSSJJAPf6tm21SiMRQAOvAo9fQTpwvSTYJx/PovquUvj0?=
 =?us-ascii?Q?og0b/RmxTUEfEipNwEUVqrv1+UydVXwTAREtgntA3nr3IsZR61ye9gwcrJYB?=
 =?us-ascii?Q?Qqvkv1rXarsxbtF7L1+NCqZGCrRaO6YfG2nkxuaJyjczGjG+uc4e3N8N7oWf?=
 =?us-ascii?Q?IbUuATH86aobIb/VF1xTn5LNTl/g9D7WvZQnoGecjkxZVGGUf1pr3iSu/rZi?=
 =?us-ascii?Q?nIqMJTpw4wHaXZkpIFvrUTpCOQ4KmtcLBM/3pIe58ZiZpdQMPRxOBPiI3u+2?=
 =?us-ascii?Q?imewpPgNMBQ5ZPYXd+bjB8HdTNJBfOf/aNmLqo0cEumTqSQtGCTJq7C3dKAe?=
 =?us-ascii?Q?X1UKYYT5YSh0C/bKuUaucyc93LgZSnOKxGFlDgf4GXYHCrX5sXG3hMpa1SpE?=
 =?us-ascii?Q?U4InjngW4Fu3ABdsSZG56jcEOmxGj59fFiXPArrIZwiNsZyOkoQYWixnktnT?=
 =?us-ascii?Q?CUQ6aHV7QE5sOnnadj+0Xq5t+IiwBg84r7ab8WWEyhP2hg+X2ItGdmLdGaov?=
 =?us-ascii?Q?wX6KHhD9Mf1WzgIoksSYMbXq8SlBILrXFX/dRWt4Ut0vDsdjNZVgvT++hSGW?=
 =?us-ascii?Q?ENkkaadYaeyQQDNLmb+SMJhdqeMibDB8tfoAyTjdtxzE2xoJc/qKmwLzHsX1?=
 =?us-ascii?Q?LLDJAlNMI4pxJ82G0L42Cy/AIRzn/Gstv5YLS8/di0fBD/1knI3Fz0vyeZIj?=
 =?us-ascii?Q?2TVYNOw1tiWiEa4GGpvMO86sLz1PZcNmtvTmgERlRI0VqnJvbl8drF/ZKFLW?=
 =?us-ascii?Q?b7FCjsPP+B3IQheND1EPk9d9pQrCS4whP2WzMcfaXiI8kbQV5HTywr0fJxig?=
 =?us-ascii?Q?96/kzF7w5za/UGxgJHf1UwbOtFaBEEGbE7EIqDsGeM07ILb6vc4x/27GFbFI?=
 =?us-ascii?Q?XHrE2AJ8f/TT1gzewtpjGkEcbhiyW0M72hjUXBcVUudiQCLdCgwO8eW2JD7d?=
 =?us-ascii?Q?mzd6A=3D=3D?=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3499;6:xl4vJimXXKrnu3vtuluudtVvDH7MJCM9bsAkVh+8NRg0sj82RtJuq+xRHqqfkTYMBeCfHQtD5MM6A+HPSPHrLKs+/s8yQvOoSWRR5t20ytYUpU6c+O2HO6y209GjJnRuUrZGwRNV0iqoYiGyW70CXUzuZPV0SSG6xTLrmZ8m9L4a9Y9TGXubnAO7PeYjprOxOp4ysLRKv2oPNsQeDASrfE+UEgvYFPiBpbyFXAuuKTLrP1XWdT4IrCz0Eg5jxJjR/wlCKwCit+pUaDY2IzrDgB/QECQ4/ngwxpW0mZDvfvg+R8R0WqTrj66g9BslOHibMT6jO7mLTr4f5FycJDSlNpCKYaq+weqlkW2ZgcRDuV4=;5:IO/iK1xJimUCqlqlnit1AfwvLj7JsLiV/yyz4bJG1Bz/UHxFtPZ8CFqR8hGfi5B+u7Mw2bWZ2DylGNFu8raGI6GF9ORWWJ/aRalmcDx3xJp8czwAOo1uBSkALffv9nj8iMYhI89j0jO7tREJHmX6KIRfYGFZgJedB/MeAELVPwM=;24:qe0+MNRsrJu1di3zXkcr+rf8Ziaq079hCTBAsmeNSirp5Lef0tZ6kmXb7ZSf+N81AQcJTf8zBPqTa2ecJq2FWu0P6LLAtzqZSxP8KpGPgGc=;7:6qDuhezc4g8w+ZilmeHMGleBC2cjwDA33Wagx9YRyYulRMrVgLWcqaLmYLX/bI1gS8UTfcE4PaHEk3I1eQt6FCIpgYydCtUDWKjd3b25xoakW4D7wMIMUZglXHqJLmnam3uhIVbkOxp2iqK/mlaXCMJ6QQevsda/VqhTnXWJyN9N89B8VfBCCxSU+IGVD8copZqg+cylFhaeFrlrMmYW3E1QOIR2zlSJEW4gU34hetaU5MaTVQoSgHaPTg0BG3/r
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2017 23:18:19.8213 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 86fb19c7-e8ab-4c14-3dcb-08d53911d2f5
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR07MB3499
Return-Path: <David.Daney@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61270
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

Add bindings for Common Ethernet Interface (BGX) block.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Carlos Munoz <cmunoz@cavium.com>
Signed-off-by: Steven J. Hill <Steven.Hill@cavium.com>
Signed-off-by: David Daney <david.daney@cavium.com>
---
 .../devicetree/bindings/net/cavium-bgx.txt         | 61 ++++++++++++++++++++++
 1 file changed, 61 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/cavium-bgx.txt

diff --git a/Documentation/devicetree/bindings/net/cavium-bgx.txt b/Documentation/devicetree/bindings/net/cavium-bgx.txt
new file mode 100644
index 000000000000..830c5f08dddd
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/cavium-bgx.txt
@@ -0,0 +1,61 @@
+* Common Ethernet Interface (BGX) block
+
+Properties:
+
+- compatible: "cavium,octeon-7890-bgx": Compatibility with all cn7xxx SOCs.
+
+- reg: The base address of the BGX block.
+
+- #address-cells: Must be <1>.
+
+- #size-cells: Must be <0>.  BGX addresses have no size component.
+
+A BGX block has several children, each representing an Ethernet
+interface.
+
+
+* Ethernet Interface (BGX port) connects to PKI/PKO
+
+Properties:
+
+- compatible: "cavium,octeon-7890-bgx-port": Compatibility with all
+	      cn7xxx SOCs.
+
+	      "cavium,octeon-7360-xcv": Compatibility with cn73xx SOCs
+	      for RGMII.
+
+- reg: The index of the interface within the BGX block.
+
+Optional properties:
+
+- local-mac-address: Mac address for the interface.
+
+- phy-handle: phandle to the phy node connected to the interface.
+
+- phy-mode: described in ethernet.txt.
+
+- fixed-link: described in fixed-link.txt.
+
+Example:
+
+	ethernet-mac-nexus@11800e0000000 {
+		compatible = "cavium,octeon-7890-bgx";
+		reg = <0x00011800 0xe0000000 0x00000000 0x01000000>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		ethernet@0 {
+			compatible = "cavium,octeon-7360-xcv";
+			reg = <0>;
+			local-mac-address = [ 00 01 23 45 67 89 ];
+			phy-handle = <&phy3>;
+			phy-mode = "rgmii-rxid"
+		};
+		ethernet@1 {
+			compatible = "cavium,octeon-7890-bgx-port";
+			reg = <1>;
+			local-mac-address = [ 00 01 23 45 67 8a ];
+			phy-handle = <&phy4>;
+			phy-mode = "sgmii"
+		};
+	};
-- 
2.14.3

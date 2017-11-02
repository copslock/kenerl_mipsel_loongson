Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Nov 2017 01:36:57 +0100 (CET)
Received: from mail-sn1nam02on0073.outbound.protection.outlook.com ([104.47.36.73]:44904
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993095AbdKBAg22FxJm (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 2 Nov 2017 01:36:28 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=NK7g2IgURWx+mc4e6E5oxTh9qzQcYkyA1vrwpVxOrZs=;
 b=V0iEqwm3Z+QXy3/kMjeqkxd1qLaRZt6tVa5JHXozDxPs9xRrozzYep/SqvDgHyaxk7jcyUrvLLIE6ccoPT4R0x1pEYZi7VBuQJTb3RerC1ZAscFTBbDwYcnq2EPr7mmBEWVjB3em0pLPWzKI0JlcC/aMoqBrkCvAet7c4z6DvY8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=David.Daney@cavium.com; 
Received: from ddl.caveonetworks.com (50.233.148.156) by
 CY4PR07MB3496.namprd07.prod.outlook.com (10.171.252.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.178.6; Thu, 2 Nov 2017 00:36:17 +0000
From:   David Daney <david.daney@cavium.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        James Hogan <james.hogan@mips.com>, netdev@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org,
        "Steven J. Hill" <steven.hill@cavium.com>,
        devicetree@vger.kernel.org, Carlos Munoz <cmunoz@cavium.com>,
        "Steven J . Hill" <Steven.Hill@cavium.com>,
        David Daney <david.daney@cavium.com>
Subject: [PATCH 1/7] dt-bindings: Add Cavium Octeon Common Ethernet Interface.
Date:   Wed,  1 Nov 2017 17:36:00 -0700
Message-Id: <20171102003606.19913-2-david.daney@cavium.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20171102003606.19913-1-david.daney@cavium.com>
References: <20171102003606.19913-1-david.daney@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: CO2PR07CA0072.namprd07.prod.outlook.com (10.174.192.40) To
 CY4PR07MB3496.namprd07.prod.outlook.com (10.171.252.153)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8a3fd446-5e8b-4bf5-2bdd-08d52189bebd
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001)(4534020)(4602075)(2017052603199);SRVR:CY4PR07MB3496;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3496;3:nL/Ktp2t56nO8A0ToblxV9+VNNxktCxWI18/E84sreViXAOK8auquw2pzsjSztNPIXYDARNl8iF+zoss84FJ86qGYWI59P41zwyA4xE1SLuFzLBVYtwlh8oWXRKuJcfG0upUnLrL6NBB+VFrMkJRtONBfF+RcI48uhNcSIb8UrrYgdofgJ7Lv85phHMjZH7C0ijVoHjS6XL/c4c9yKJlb8cH8H0RyDedwL/K5Ks3tpT1ABSS7wp35ExquK/NINiZ;25:iEqn80IV5kwkEZ9PHcHKgMSKDk3IhPnRB7sVz2Te4PnjByouFbNeYIep25kSsuvBCLUf3Sczpu229m4++LYPDfOxm3gcRDHO01+YurWRnnqsNioILBnRFSipe9kDhpe6cruNmzAFAjT+U7+RHb3aXlMte1g74YvRpzh2qH2SoyPo26Mt4OpK23s0SA3wMZy+dG6MIUO6e9ffU9IUxNeMn4+fX/Jg58dGJueddP1dE7Ba4qb3JpxXRgRhqHOyBh7r5bUAsPlmeHp7PbG25+AHUBjniG1Dmdy3lL52n26eihKn5t1RUNGgQDWT+PA8RUuXb8totuNfwGSopxHytbCFMw==;31:CWzpUKdWf6U9nRRfRLcjvx0ZkwQXgghWQHzKKoQasBMejo3Q2///fwhiZxW7GUg7diUht2O66Zd2CLJHXgB/QrCq6/Ts2jnSzOmFAV+n3EPmdPqcZfMOCr5GYJKju4SGM4AZFh+P5yun8x8poyaXh6w8aNV802k6FN0e3z1gSzy0JMvqUaGk1/gIonaW007goZOnW4gvZd31Pk+zLGJOZ9dbeqBbCublyL6MgwxhYDY=
X-MS-TrafficTypeDiagnostic: CY4PR07MB3496:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3496;20:OU27Nqeyx7HyekfR+/lT+XrP8B2et3WQBLdpIGr3Kg3GJJd+Z9kHfzuVqj1ZjsvSLeeNCNpkRSwqaPu2YmUi+T+HNNFxNuZzURnMIB0E5SWL/Y+OnyGW625gcq+WC+CItYCjiFD4k6X1fNgGA6Dl+yCG04BDrfD2ggLa22BDmuXG9UdGE4XgWiDIjYfveC/QjfQpAvb9Yi96teULTyprZklpubYgMfTUwh4Uq5d/seDJIjMIGEieI0iVp6MLAehdRx6HSpKtZEnXkEhXexOfJ+2Axb+n2Xkoz+TNlV6xsNKJUEqFcFf3rinaeijDTdnJYeB+XH+cIHBeeGrylos58AVEKKhPk8s7jOpDdCasSNaqYWeZFGH1xW6IStdOwja8TrDrZFW3LQvtkDMG15Ft4dT1Glp9NwQ9kF6B7u8ZgcWhogW2ZGKLnfBiQD3RTIXQO5qL7sgK9EcYCkLM/ZoSBSifG+J3es7XGiezl49kNBBC7ga9jGKZiDqOXimGmQO2;4:txiEe/ULHQUrXe9OqG5QwHNJyjDv1qEP0UpNAFBwANwU79MKNpppxudh29ZyXjc/aqazQTAxedtih3K0ve3Ol5U+JhTjy8UnuSjRgnh7ttDJG+4yxjBbG5tiId6SbN6feOEnuPBObXrQYXOje9YyMneAFNyMUn35U+2w71l6LqLn6afZKhnqK3TgFZdAB8ikklffBTgyT5OEO4mugpLk1V23TjYCkBEiu+r/sSTiJyrRZq/gNiguqL7bqnZ7Q6TmuWt4KQve4fi9lgHSwUbqSw==
X-Exchange-Antispam-Report-Test: UriScan:;
X-Microsoft-Antispam-PRVS: <CY4PR07MB34965D0EFC4FAF0051BF74D0975C0@CY4PR07MB3496.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(6040450)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(100000703101)(100105400095)(3231020)(6041248)(20161123555025)(20161123560025)(20161123562025)(20161123564025)(20161123558100)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:CY4PR07MB3496;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:CY4PR07MB3496;
X-Forefront-PRVS: 047999FF16
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6009001)(346002)(376002)(189002)(199003)(25786009)(72206003)(16526018)(50226002)(53416004)(7736002)(105586002)(305945005)(101416001)(48376002)(478600001)(50986999)(6506006)(76176999)(50466002)(33646002)(47776003)(5003940100001)(106356001)(107886003)(68736007)(2906002)(4326008)(6666003)(6486002)(2950100002)(6512007)(316002)(110136005)(97736004)(16586007)(54906003)(5660300001)(53936002)(189998001)(3846002)(36756003)(6116002)(8936002)(66066001)(1076002)(8676002)(81166006)(81156014)(86362001)(69596002);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR07MB3496;H:ddl.caveonetworks.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR07MB3496;23:XiZukX+WIgUdp/sH6D9mKymvInst0I16Z39aVDUln?=
 =?us-ascii?Q?mHWd5H0fCx+faWGHxBeoq8YZzvMB/QGs4HTiSZhNpUGcUOjQTK7geJN9qaIC?=
 =?us-ascii?Q?SBYaVwDc9fGcFhvK8e6JPsKVI3u6C5JsCRfiBTvw9jZC9Tgq/uJi7H/BquCY?=
 =?us-ascii?Q?2DjMgD34n4luNvwaAu4yjtqmPNQ51uGwqez9zTNT8cUNt8irE+t2c5PeWmc6?=
 =?us-ascii?Q?orjVjsG1FREV/y7OsgwoUblvgefXS1oTY0E3WcvCkBLATnSVxHSzM2pFdRrw?=
 =?us-ascii?Q?uxJd0pOGxuecJtw9TMQ5h0pH8LEAyNa/hNMbYi9f4sMM/6mzRCz8zuVx3VRs?=
 =?us-ascii?Q?KgNYcsOA/DT7l1SfaAxA6h8kxEe5x2nHPXq8RrywWH/srEnmGmJ5ZM+qmXVt?=
 =?us-ascii?Q?i1V3uH5bYJ+ApuOZ5ammwaJTJ8Opb7zVkQLVA+UE2jCX4nbVVzG4RX/Ifzil?=
 =?us-ascii?Q?/VVIcTjOuGe7xSdlTkbT/ql7YqUCztjx/tGHpPP2DyaiMeASD6TqGwDlj6sG?=
 =?us-ascii?Q?IsGRVuE0LGydhO1s9188Ya7LgkhZxEKhEujeF8vecmmaFtk/RePMmLo4yYGg?=
 =?us-ascii?Q?dh6b0uTpWhovHYe0ll+2f+6V+2i/5BmHl2Sebflt47rLTxVCFU4wDnc0wBsJ?=
 =?us-ascii?Q?du7Cy0z9k68KXZivpn4Vxpap6OxcCPACPGb/a+BlOhueTqDWNypTYc8idFym?=
 =?us-ascii?Q?xtVrmzhf7hXRL+UCVl8SNIJMKS5SMWnixQqR1cGWIlpcJSwi4a6So11PNUQa?=
 =?us-ascii?Q?sf5a0zSdA9XAAHs4fA5b4qj6mtpjvtgoZNOUVxOIECtSxyhHXEE2SInabnye?=
 =?us-ascii?Q?/eMew7MVw1YEpRTe4cRN8mN5PMg+aqEBZhjYQHo1cZ0DyY3Lcc2vcGu18XBI?=
 =?us-ascii?Q?WISyST/J71vy1Nx+68hHXicGy4Rw6nNKcvCGvL4A5APgT8FbZhc+/6n0c6q2?=
 =?us-ascii?Q?tl/pDn5JZS326wFND+ZPfTo09DGgUVyGyprr/ZoeGKUlSxkzVE4+VUc9ZGDL?=
 =?us-ascii?Q?t0UFsl3CtNcV/yywuuKdpq0g/XsVf04WfzUAjoeI0bCGtD5XcNqweUchr8qp?=
 =?us-ascii?Q?WDxLr/tcPEfTEGX5oSfrYhG5ydsdPId8cq2EfHpaNpeekbDnk7pPVwk+gMOC?=
 =?us-ascii?Q?q+9Jwrw0za25hZDU6PUopqa60UKxeVfKsXAcvp6nGie/ua83ynmYMC9+vNM6?=
 =?us-ascii?Q?Q/A20+RPjMecr0=3D?=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3496;6:CmT5i6tsjBNNHUNJtBY2vyIcbIjY4xcvMiN4mSUSBgzuLagdWLeJ6l5NhxtCWkmJAcHu6V83b8GxeOGoa8u4lrMoP94BawYI1PVAfFXqHVgKR3GxxyhUL7Te5BP0ksxL1r+fFdw83kyU2yLMKZr6AgLNkoirxZaovjs5CnfBP5R6jkAMmzJn9qrvBNiia/WxgBecF/R6c+iYe8kjK6YhXUunwd60eQQ/FqQWeOFSbcRvrZwbK2Ygt5afEm8e4OrlcdYGUMR+VHyjC9mLrUGxfMISOr/4OX5T0Y4IoIbwYtVV9RVsSx0gGaxyooQCEFxQHnxpBgXDevHvrKCxWZRAl8BzE9w7TEB3p7s3GjwVX9Y=;5:Qb50UUCx8YxPrkKYbpVIIu9H15kU8MsKvr05gY7gBt8wyYfzZs5wp0nfPeEjQw9b3Cw0pdGPuvezYMxlpcyzuW3CP4sWG4lBdugqz4hg+bBOaWSbECiIQjubZ5x0HeWbFfYUarQqmdowtAtIfO0xWQer0G6BgxbrZrYm+Z13ttQ=;24:lFo+OL2oksN20PrR0RVGE7QyP5/UuAvG1Dxhfjfukj6qplRag+w202k0bclRGvL56GvIC6zSYHU6Ju+VHgUs9IHaU15p1qPVOpeUP874EE4=;7:A656Vy5HJA+UtmD96+BU3bk25wY93ZbXBJO9mSboxkXwrPAh1gyGonRN4sBPUSc/0XhdYAUKc2FTXuHXF5B/eyRy6AEYZsqlqwM9DSyXdJYZOoqm+lv8evCr8Hrc/Ns3b7/0AqYGinXrq2jdwnuLXQiLOrfyBjYLfkMpLuH1eB9pBk7ui5RuOwV34EwDSFqeSzNm1FB9F3SPNZrzB4+TUrEHB8AHCQsUbgGn+bNAlxImsDjyTtKU41PTuBue4EfI
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2017 00:36:17.7875 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a3fd446-5e8b-4bf5-2bdd-08d52189bebd
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR07MB3496
Return-Path: <David.Daney@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60646
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

Signed-off-by: Carlos Munoz <cmunoz@cavium.com>
Signed-off-by: Steven J. Hill <Steven.Hill@cavium.com>
Signed-off-by: David Daney <david.daney@cavium.com>
---
 .../devicetree/bindings/net/cavium-bgx.txt         | 59 ++++++++++++++++++++++
 1 file changed, 59 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/cavium-bgx.txt

diff --git a/Documentation/devicetree/bindings/net/cavium-bgx.txt b/Documentation/devicetree/bindings/net/cavium-bgx.txt
new file mode 100644
index 000000000000..9fb79f8bc17f
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/cavium-bgx.txt
@@ -0,0 +1,59 @@
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
+Typically a BGX block has several children each representing an
+Ethernet interface.
+
+Example:
+
+	ethernet-mac-nexus@11800e0000000 {
+		compatible = "cavium,octeon-7890-bgx";
+		reg = <0x00011800 0xe0000000 0x00000000 0x01000000>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		ethernet-mac@0 {
+			...
+			reg = <0>;
+		};
+	};
+
+
+* Ethernet Interface (BGX port) connects to PKI/PKO
+
+Properties:
+
+- compatible: "cavium,octeon-7890-bgx-port": Compatibility with all cn7xxx
+  SOCs.
+
+- reg: The index of the interface within the BGX block.
+
+- local-mac-address: Mac address for the interface.
+
+- phy-handle: phandle to the phy node connected to the interface.
+
+
+* Ethernet Interface (BGX port) connects to XCV
+
+
+Properties:
+
+- compatible: "cavium,octeon-7360-xcv": Compatibility with cn73xx SOCs.
+
+- reg: The index of the interface within the BGX block.
+
+- local-mac-address: Mac address for the interface.
+
+- phy-handle: phandle to the phy node connected to the interface.
+
+- cavium,rx-clk-delay-bypass: Set to <1> to bypass the rx clock delay setting.
+  Needed by the Micrel PHY.
-- 
2.13.6

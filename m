Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Nov 2017 01:52:22 +0100 (CET)
Received: from mail-by2nam01on0060.outbound.protection.outlook.com ([104.47.34.60]:55296
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23990451AbdKIAvvDetMQ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 9 Nov 2017 01:51:51 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=uO8yERQ+P6dViBptVAzbKPMVueakF2Nk85aYZOXHOAU=;
 b=itqEDvPBgR9i5A3tUhOlgcoeebWQ/3yYxb1UGGugl4qhIduE8mjIC4Y0Sb8Is5rUVYQ1Y9J2lzgwzHPFhF7cAqgUfslKYi1yHL1vKYp4QSkO9BlKhA7S6CNCmsCJY5MQJOYdywHpXpUqtZx78Rd/7IXPh57JRIAfdA+a0jcvJrw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=David.Daney@cavium.com; 
Received: from ddl.caveonetworks.com (50.233.148.156) by
 CY4PR07MB3495.namprd07.prod.outlook.com (10.171.252.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.218.12; Thu, 9 Nov 2017 00:51:38 +0000
From:   David Daney <david.daney@cavium.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        James Hogan <james.hogan@mips.com>, netdev@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devel@driverdev.osuosl.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        "Steven J. Hill" <steven.hill@cavium.com>,
        devicetree@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Carlos Munoz <cmunoz@cavium.com>,
        "Steven J . Hill" <Steven.Hill@cavium.com>,
        David Daney <david.daney@cavium.com>
Subject: [PATCH v2 1/8] dt-bindings: Add Cavium Octeon Common Ethernet Interface.
Date:   Wed,  8 Nov 2017 16:51:19 -0800
Message-Id: <20171109005126.21341-2-david.daney@cavium.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20171109005126.21341-1-david.daney@cavium.com>
References: <20171109005126.21341-1-david.daney@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: SN4PR0701CA0022.namprd07.prod.outlook.com (10.161.192.160)
 To CY4PR07MB3495.namprd07.prod.outlook.com (10.171.252.152)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b915857a-b847-4a10-419d-08d5270c0cd0
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001)(4534020)(4602075)(4627115)(201703031133081)(201702281549075)(2017052603199);SRVR:CY4PR07MB3495;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3495;3:X7fxCJmvnbWAO9Bc2l0/Ylvg9m+/2L3J0QXPsxePplTpqc8Q/m0fiRld0+go2Ja0D331Tos+6WtMkV2MxmlsVYCM8didqRRS+vivMpbieYZKvBQr07hs/nipA+tFtt5M1lRVQdbjq7RgWyZGoQoB5pcj4y0+0KGG92YnCA5EsTulGdu/N1jezEjOWtsKysenhotBTkq+5j0NoGKfX7rPsnxMx65SO1z1QdnOJ+SUqnbqp9hw6ahyoBJ2woae1Mqu;25:JhDFTuwmDg/oI9t2aglSFW1dwdykyTgenWSBHhpLjOzkup9s+cHmpleQ4fSOtpZQ4JxR9g8g1ok/2NCaHubfX2OQ5ANU5iitvcJqYkemv4mLJETH8gwW5z1ZHJP+jvxkvxYm83C5rDnukt/LE0dQggrIjS8byVqoUtqyO6rlWU6ZAapHb1L0C+YpuvSWLwLCisnji3lCK3G+4dgHTwAvpMT+K+3UI0rMPf9S1ZRmmKndKE6Jh5dbjuIEzMS5mPXFAPEtkIgKO3fMEQiuf3zi+3STxw8gt2GWZJJq7QX292g+4wEpNCYoFNq8l/FR7GDgir28L/mHhI+UYeUS1zNS3g==;31:TYK07I+XeDPnAk2LgXrml9WCpN9aSz7lbxfjuQi0iFn7PxKJjTsIyBlWoDq0AQgoXZ2rDQO8tO22sj4LZTjns7bsGahWZiW6gZ424w1ntbgYS373ZQJAEavVULpW4jb+q1gTJuKYK4UEOY4ARZV7q5tezoSunJIXaMsbEDMFnNISeAMx9KxlSXwlZ+1zH6O1kH65DPqlaUZyRIFO1CtosZfyE5KHWwcR5d9JSoZoOtw=
X-MS-TrafficTypeDiagnostic: CY4PR07MB3495:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3495;20:sJEXrA+TEhkzhuBCOsKZumhiLCPM2n/mRnCVYhEQN7SaEgnKZPAHhT3s+XVXOEo3RyKr/ppR3VEKfvGjMdKHb9Sb+63AYRr3Cn7WX/G7fMOvwD3K9D8xMFslnm4WppNxi5V/nUaOpTIs7sZamLBVnFMz7UuY2tawCuI5JcSp/Y7yLtMglhFV9xMdcH67Gb+jIHaLmqiq7Hc9hnEE2+upuP1Wzk0S0uq3GOtKdJrDfJmUUUTSAXFwbixn5Pqkf3ggLWsv88R5Fij7sXMK3SeRylfxKjYz0rQuDSiIKjzYCSXl15+JwRxy4SVKpB4hdKQHoNAmf70in68MAMvdmJN+66JKTRvI1Srb7tCzfawZdnkEoPYBLE0Hf7A2FZ/zWR169T2uMeBZ1dx+Ii+yk/HUkrWa2dRKpxSUfu9A+SMg8fl6/+1rhRUQByAMatHftDZhVed7ICwPgKFJn+rNdpQKQBnwBG0IecF9O2sZ7UhDwaWVo9wxwqU/HbkHxmfeMrvi;4:w26HVCk9Ubu8OHGnhDVXzdJ8OzXPlwZjYtY6H0/l9vZc4ZNsCKKJhYhgPEzCL3F1ySH0YCwzLs8dOX3EMiH+kjvzuTZARI4bT6ORm+lnmLAKPYzG4+fdKFUb0vBZjf2xYvwQs7kOmII+qhLelguNV0ahKmQrbehiiUJBBNUyjGJIVgGygn+lxff35xXvbqYQG/WN8MilKqMB7mv2L2EDyU8wviM9iq9wxXj78vpuNzpAYV/UeDtSsWdpjaYIQIW+Hjvun0OAONDkXZsTKincag==
X-Exchange-Antispam-Report-Test: UriScan:;
X-Microsoft-Antispam-PRVS: <CY4PR07MB349509568EA68B7112DA300C97570@CY4PR07MB3495.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(6040450)(2401047)(8121501046)(5005006)(10201501046)(3231021)(93006095)(93001095)(3002001)(100000703101)(100105400095)(6041248)(20161123560025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123555025)(20161123558100)(20161123562025)(20161123564025)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:CY4PR07MB3495;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:CY4PR07MB3495;
X-Forefront-PRVS: 0486A0CB86
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6009001)(346002)(376002)(189002)(199003)(53936002)(6486002)(50466002)(6506006)(110136005)(2950100002)(36756003)(33646002)(7736002)(54906003)(50986999)(106356001)(189998001)(66066001)(2906002)(25786009)(305945005)(7416002)(97736004)(76176999)(1076002)(48376002)(47776003)(105586002)(16526018)(3846002)(81156014)(6512007)(81166006)(6116002)(8936002)(5003940100001)(101416001)(8676002)(478600001)(53416004)(316002)(6666003)(50226002)(72206003)(4326008)(69596002)(5660300001)(68736007)(16586007)(39060400002)(86362001)(107886003);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR07MB3495;H:ddl.caveonetworks.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR07MB3495;23:9SlNn1de/2BCfN6Swn9sWUkRPBp5sVgoBCON1liOp?=
 =?us-ascii?Q?fuAYuK1DGkDS7idBc1+vvE1IKtrZXZLhIcDTVdgnHLBjTUTDthwqy9zGvlCq?=
 =?us-ascii?Q?gW+DP0Ewphz7WPPcdkQK3f/zPV5nHnH+zAm8/K8liXmolF/IF5DFhlfq0jZh?=
 =?us-ascii?Q?snjdnc+dRS1OS6Fq3fu5bd78PWA57t40xLD4eUzSVRPP0Z5sD91lG9w4WbaW?=
 =?us-ascii?Q?DaIFbvZLi9bsOlxQbiccbJXBjm36xRYrLUMsMHWQNKoTBIzc12HRevr7C6Xv?=
 =?us-ascii?Q?u8j++jblkPRujq9S5+627ESI0dNKunyEqg1cK2bnXey9quIJcmvgtqGMrjKn?=
 =?us-ascii?Q?rKBgMjqbjHe6/uDpgzCDoqypH3HGIRLkYMRopZaVoCQmzzbXI5oB+3yNtzql?=
 =?us-ascii?Q?tOSBcgizm6R5Mtmkn+YZq06HzXsNxcJnFBqdQkNlH5kXN/GyKTXQ3+aKYMmt?=
 =?us-ascii?Q?rNvl+R5I05FjbdaKjtWwtluiF2jL5Jd1qL+c8fwf1mONr1kUUWvnT7Qu6YY/?=
 =?us-ascii?Q?OIBGr5Rw2J3ZyLS9EZQ9LJnDeKbQQmiIGOGFxHhu22I2ZkWQ8ReM2nqkOAn5?=
 =?us-ascii?Q?dLzurtvLeq48rjvo5SIeMkCiUUhe6hgrmFixnXnv5emH1xd2JcfVEJXzOvTF?=
 =?us-ascii?Q?1zClHehj7FwxiLMBMdgg1Im8448opTUJaE+0larY0G/ORfnc/BkDbIKn9+k+?=
 =?us-ascii?Q?52QTPVOiCQNNlvjHpyfisoPNTxecKUdD2WNtIecigpffx2W/vAL38ksRdv99?=
 =?us-ascii?Q?0SJQ5n8edQThdIDuprGRDmaUHBh4+WFkxolCyxIrkNkcqo80tgXLBz6KZE9H?=
 =?us-ascii?Q?5l/GG1kL7HuRumdLOQubejtulRpCEhX6tgpFEAZJc6o9XG+ICDdMJRozN79R?=
 =?us-ascii?Q?/lBM2tUerxP815IfztXHtfXP2GPE0B/+ksKF5Imqv4Ctd8dRk1Ihknzal/vO?=
 =?us-ascii?Q?byqHLw14c3YCFuVvbhYoxz3Y4uzbgxom5ESExHnhflSOh8cTWBjndMiQVTk9?=
 =?us-ascii?Q?R4fnKqN/RLnhzafUCNv56G5ojGqGKIJPqyvoMe/eINtH/MjwVM9xyVqvXDg9?=
 =?us-ascii?Q?Uy1l7QdQNj/dmuMn7aYg/7La9oarzNaCmIpvdWnOs/E0bCdFUB2D01KaLRjy?=
 =?us-ascii?Q?Xf/9XdIFXxCzhXzx1M+fCplfHaLaFtqP8PAtSpGLyDQtxzjKhBjFNt/8cbe7?=
 =?us-ascii?Q?MGE03voubYc27w1QhuCv1EO09aEeRAdbXKO46TuVWBl4tgfPrvg3vY0EQ=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3495;6:O+3j3/BDZMwZZszQfIkmSt+KA0xdPKXX6EPPQhmxINiLGrr1Svwo8e3O7gFCLlhLTzLLaf48PaCWAZx1lyFwizvQHDA0hScyHDzu2CoB0Z0Aw39lITN9TdiGAPcW+GtQ4AG7G6t7JhQO1tiLTTY/VFJLcV+eIEihF1mO5OnOf6BmjvcI0U4PJU3+Ef5qBvdFT1FuardJLG74cj8PFR2gH2ECP5zaGIRIIaG1DzEtdPoQDVnffNnG+e+4EvZw/w121Q9gAUcd/o/vjifuI0uRkrzcO8tBEIOo1711oOaixfHu2e/UWltro/hb6+n+n9qJs4+NAgRx09owBfoYnhlePwsJ+L7DGziyIoBjBmuPs+g=;5:Li0XGQbjcw6CXLCuSixrsqJ39/WlwJT6IZZ+9EWNqDI+lEQZBi4vYqlnypNAvjIyH8ob7MuiT9nhbBNkWo9ktN/q2SmTTNIg4eobjxGntp2yiLYQ1KjaI4PzcgMmmDAgD+akKVUrDa+2xCa95Tk9jBAOJEYxIy0BYG+1wsOetvQ=;24:G3Zi8t/a60LBQHFaJEgXdrciVAbwXl8J70AVM0ehHIuGF8C/44n66yF0tPahX4guL/JeBZKqpCk3cJNeCbZivgfhnvWS4cn2TK1/W9QjW9I=;7:omQ42tp8hw62mgnFlWyooTwalmLnG3bq/LMfmfXjlPwC9sS8UlHDe177N446yyIJOvqT6tOw185/NVHDpwjnUc0CxqbhUr8QgpmCMZUh0aOTAPjC0fMLDkLzgIxwfjm9KbUHN2pYi+cwXgH26SXhrKczPdq/aYftaoDJD3KdkP22Mr2Qydwao4VIeBSW0g02HO5FvtRg/XtSyxwb8HbGnu659d9BpwIkikYMsX9pishcuaxP5rZINzM5kM3qDzkP
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2017 00:51:38.7964 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b915857a-b847-4a10-419d-08d5270c0cd0
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR07MB3495
Return-Path: <David.Daney@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60784
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
 .../devicetree/bindings/net/cavium-bgx.txt         | 61 ++++++++++++++++++++++
 1 file changed, 61 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/cavium-bgx.txt

diff --git a/Documentation/devicetree/bindings/net/cavium-bgx.txt b/Documentation/devicetree/bindings/net/cavium-bgx.txt
new file mode 100644
index 000000000000..6b1f8b994c20
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
+		ethernet-mac@0 {
+			compatible = "cavium,octeon-7360-xcv";
+			reg = <0>;
+			local-mac-address = [ 00 01 23 45 67 89 ];
+			phy-handle = <&phy3>;
+			phy-mode = "rgmii-rxid"
+		};
+		ethernet-mac@1 {
+			compatible = "cavium,octeon-7890-bgx-port";
+			reg = <1>;
+			local-mac-address = [ 00 01 23 45 67 8a ];
+			phy-handle = <&phy4>;
+			phy-mode = "sgmii"
+		};
+	};
-- 
2.13.6

Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Nov 2017 20:30:08 +0100 (CET)
Received: from mail-sn1nam01on0048.outbound.protection.outlook.com ([104.47.32.48]:12112
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23991957AbdKIT3fqj-kL (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 9 Nov 2017 20:29:35 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=uO8yERQ+P6dViBptVAzbKPMVueakF2Nk85aYZOXHOAU=;
 b=XHJD1OiydxAqsGm5Q91CFORTUIiEpjxv1JCZxrakvyjeBaDZA2PwzsxL0DpBs0HyFZreX3ukOMuTXhokNu0UcqBlUJ3EZg3ytcoECnhd7lS1zGEAqHpDjH2o+l3yhWSE2wg9hXt1/HajAByaURd9mOJSLzCs75PL3VdCYMQJ2hM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=David.Daney@cavium.com; 
Received: from ddl.caveonetworks.com (50.233.148.156) by
 CY4PR07MB3496.namprd07.prod.outlook.com (10.171.252.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.218.12; Thu, 9 Nov 2017 19:29:25 +0000
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
Subject: [PATCH v3 1/8] dt-bindings: Add Cavium Octeon Common Ethernet Interface.
Date:   Thu,  9 Nov 2017 11:29:08 -0800
Message-Id: <20171109192915.11912-2-david.daney@cavium.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20171109192915.11912-1-david.daney@cavium.com>
References: <20171109192915.11912-1-david.daney@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: CO2PR07CA0057.namprd07.prod.outlook.com (10.174.192.25) To
 CY4PR07MB3496.namprd07.prod.outlook.com (10.171.252.153)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b257eba9-df9e-4a43-d3ae-08d527a83381
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001)(4534020)(4602075)(4627115)(201703031133081)(201702281549075)(2017052603199);SRVR:CY4PR07MB3496;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3496;3:mVcndf3J5Q5NPuFbiIp3AnFbyrUsBsQ4LdysGD7yJCoacrrkFBv1I1PUWTJ3JelvMZP+P9HgHP4zWUX34rX0kWnPjnMpucqTxQ1kGc9rwXo/fzp593GtZ8B6LKHURJJQETk3UsQKtP/YNCntAf06h/zTUGJYK/hruKmloP1yt7eGXQw58OoM9FncZMtNb3XqAXNQAfOGaQjN9ChLi6NcniJtq/5PnwNGCbALuNkpXuIAzw+sKfUsw7rrHHk0Fz9i;25:gQQ0DYZLxe5rGwPu6iEI0DnHGw9Vymymrlqhg/cfZ+TFiYp6BJsmUosLLqx0b4+AFrY7XEgt9SonAvZQZyKAVTwC0d2lekM//z6uO+IBBxNV4Q+WSbX3syjQbMgasP6+l8poGMwtlHnlwzH9sBeVisp/jH+L5d0UE14ZSOCs4iVYkL4pLNncgt+pqWZC/Pc82hIZFj85oUImztm27aczkRVHy7/1DBr0/Vryq8SBMpYY6WeXvxFQyGmEZa+RB1+NeVQEvJGod/9Hn9tAezy6B4uv5MmXdi/CxyfUvGbzMyDn2yyjt86fmoyo0DXXZFgMLSS6e4g/Zy/1VQbOV+YydQ==;31:Zoh2VInhY4T2rL9fK1J97fI+UQQXw7p1zuynmplHwe9C2bJJuQn4jBnKbVLM1VhW8TZPjhthQWyIjwOZgk2yBzpYko4IZF5RTdCqt4dNrGNzpzGum14Gyuz31gYV0PT9leYWBhSVHW8obDOibBTxx7xdoKtLIaLupOiqdqIsf8cy6AWKPznZAgiiX7cMhnJ/14yVWNOLGCZJnrxoOj/DyZOTxWPRwVmFnIyCcp3sOTk=
X-MS-TrafficTypeDiagnostic: CY4PR07MB3496:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3496;20:v+Q3vytQy8WH4cf+ziCOUR9bHkpp4wqqqYfw7ElXKi6sePLuaDcNMjbQDzRAtw8l0hpb5RcQpnUtOA/Xzv6YLia9d+Ax0P/KpWJIQq/mdQ6NrmS43lWAARWAS3pcKSvO1QNj5B3HU0Gt7ACd6GdW73OV/ExVpnrSB0SonbfNO5hkCxd8epFEHxL9WkiB3BDgZFo+796Mktq7/GNBtfAd8FNsVos18108IxTVhWlu1f4L5IynwXdSmFRClUG5qxY+QZoTPzmIPaKCw8V9J2U+oj31ujc+CnvXjn0w63h5u3x49vOMge/o4LPd50keEoiMdBZhQ5sA3iEEGnWnrzmDep0GdyUIUJuWHe2JBO8QivX3HQE3oTPErslqrw39unOcjFAdEo3v/L41O9UKY8msNdrWl+SfsGu/qX5kE1Ajpo/EsT8Rt9b0Ay3+GZthGI6GA2Yd3dlXvHP8bYVOf5NhzupNfa6Vx+HYduQ2uAWNKCzAU2H9gxrymtL72j8/c3py;4:6dPgeTzCYMLP5a8oOexcmOz4PGx55a/yl7FByPIQmOiBby8Ke+FMrswBULTUxdU8/EAc6slMy3Np/NgnL4XNDgag6TMjUVcam9KOV+gaIUPmY9oXVdAa2VzNQFn/m8qONdymgIqTfv5T+Mmk8tiMAvBUj+GnGNTOpe8T5J4ryAsOD8xVtcUfU4YlHE4lmzSdDJK2388eI7NLzNnK6Vg6lr0jlablL3+KhBLDtMAaMg33MIDP3mCwPvobiaU+rcT2tLtErFKGA9y3Q8URPQKDGA==
X-Exchange-Antispam-Report-Test: UriScan:;
X-Microsoft-Antispam-PRVS: <CY4PR07MB3496E019BD448646341A084D97570@CY4PR07MB3496.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(6040450)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(100000703101)(100105400095)(3231021)(6041248)(20161123564025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123555025)(20161123560025)(20161123558100)(20161123562025)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:CY4PR07MB3496;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:CY4PR07MB3496;
X-Forefront-PRVS: 0486A0CB86
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6009001)(346002)(376002)(189002)(199003)(6116002)(47776003)(6512007)(8676002)(478600001)(81166006)(81156014)(1076002)(36756003)(101416001)(6666003)(2950100002)(69596002)(110136005)(189998001)(86362001)(97736004)(2906002)(54906003)(3846002)(50986999)(16586007)(316002)(68736007)(76176999)(8936002)(50226002)(106356001)(48376002)(50466002)(53416004)(105586002)(305945005)(7736002)(72206003)(25786009)(66066001)(53936002)(107886003)(6486002)(16526018)(39060400002)(33646002)(5660300001)(4326008)(7416002)(5003940100001)(6506006);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR07MB3496;H:ddl.caveonetworks.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR07MB3496;23:zc3WbkkzQtoAyDfsenpMcW3G27h07Uu3xcCj7hzjm?=
 =?us-ascii?Q?i1Xk2DAmzmRsTvggg6Wiyjq2+cinLKj6tquMX56skMeFUvlYEiCQoHGOJyTF?=
 =?us-ascii?Q?U6tsuEs/SLMC4M2VNivG23AuRp6vnjDG4O2TfgshRoZwRrmRBK4+hRRrHJRY?=
 =?us-ascii?Q?mfVebUSQEVn80zZb1i7o3n2XhCuk/lerS0AeSYe1dprqMC1F71Lab5Ftyrrn?=
 =?us-ascii?Q?RqGiiLtNukVlzAnshdMjkTmZua1aGlNEnNNE6wX3M0UImOI0AYnExeeHZUVa?=
 =?us-ascii?Q?FU2iF2dsnl6qIi7iHYgM6UaSMHOyqGpoz0sbkDq+ozM9vXXD1ixBk9uIMMci?=
 =?us-ascii?Q?HOmDM6SwPE+tYbczoT2DZWvvK58gaIy6ILB8PUomFSBI5ckwtYPz2tM1O4fW?=
 =?us-ascii?Q?zTI+u/ql6mOkaJIlsVr3qQi53Pnuoz0oLPBd2YTn0GMVgULImEnkAQtr8M8I?=
 =?us-ascii?Q?WAzExQMyZqxmbserUnUxZUzPstcZJoyDX6bzU1jRzuc/iNgdH5HcvpZczUmn?=
 =?us-ascii?Q?iWTB/M5TKu6crKqO05eRIX0xFazEeXLKwxM0kHml7pmSfeNa5neuL1AsEOUu?=
 =?us-ascii?Q?w+He4bifX4qvfpwQTUDB8v3jsmNa5sTrVIViI2to5f7l/BSTJTUoGdI/RRZ1?=
 =?us-ascii?Q?Dk5rpuUCMJZYS2bNBMJQ2NZPyVqPELvQxmWtG7n6zImF5czaAWu5xCxikRoe?=
 =?us-ascii?Q?vUQZ9n+o49TbM/eBN9oXsgk1+Pt9GiXH7gxvlQBEQ1KNzYUT1keO+GUZyCgn?=
 =?us-ascii?Q?38UfJzXStZbVJVUGPn8fUYoJ7QiFoJeCBViH6gk3BdMct66LHKsadv+yqqxL?=
 =?us-ascii?Q?F3z76qzwSUA0tLXtn5ElXtz+bH3EP5Abf8BQZWryr3X+0a9f8Qh0CgInT/rb?=
 =?us-ascii?Q?UQnyHazh9qqGzRAUVCcekljSZUJTxDT04aZnGvAOR3N/13BKaEaIdoJRAEYU?=
 =?us-ascii?Q?7dzjl5mNyJgf4o8jHeGBwhjKwQVo2X0jAXjFf7v5kdSR3Nv3nGLID6+XaWkM?=
 =?us-ascii?Q?zkP6Q0axHbz4fnIuYAyO5rJ3IRe+6/nA8nLMaiHJpKjLKsqmUyWkeWMs1dF6?=
 =?us-ascii?Q?kC9+eQMpO0xOIQynWY9DTe912+c6a5cPPfIbsej4Afu5Gi0G2cpZEGbFIk6h?=
 =?us-ascii?Q?/qYUMJX6807HEDrjVANYq1zkzYgqE1PfmSEhFTW3kwRoFPexl1Wfd80N0wtK?=
 =?us-ascii?Q?LUJa/rNXql/uITQqHoimuJy+q1xfVr97+OowT0RC0wUJk3wgRTt+Q9IvA=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3496;6:anCi8T16j6+mZF04pWOBCMgK7fh4vSdZansRT1O0sXilvtxm2ydB90n/QGw+087EcatSE/Xz3zIqx/PgMkXza1jM751WDTGUgC8P1BE0QWGoPYHFQfvPVRzTLN4LHk3rQzUqfsHa57/0PYmH3dh5JlTdGRowY0SOLaPQpA0jvQ38tPLo64w3dCUAb+5D3mxa2vraQuWWawRnaqtUHjpeqZT/4GGUZCosfQDpX36JaH+S2LHviaTLXOE/2LVKDZwe1HSKk1isI7PZAF4gKoFjLT+57OOIwB67jxeqIbcoA1vYKewpXmtNC0jBV/+gHfyzVMgqHhi/qSnZpLlwekKCz/ZcXh1g2ZLoZH5TWDo43XM=;5:xNqHR095Iw9luTNfQK1dD32w3ZD1yw49UC7rQ6VEsIbRsSDIC4/KMkK0SS53d3QSGA6+cgj/LP4/lwGJKDq2viklH/zaTtya0AeN4gKTAvCnSmLb9Tq/B96KSUuy2wG8KOn2pFbzw/FBq7kORj0EkZzEyBwhbi3tIsbd68SFdzo=;24:gBPIYI5xG/4wiPbQ62Iamhhz2DPAZs9RZWjLRwsGEdb8gnlQhmAbXuct1IFEmdJ1Y+bF6rQVxZEW6MX3WaGUlxRnoLvuMDD6yJNoUeEGsIk=;7:3+WSvg44gr3+t2RWAEAy7cF7wrl2gywIhe2/VhNmkDWqUwIau2QNl+EX16mba0VjdZuKzzqS1jFk63MiFSs334R+gMuWpWsHMoPVAiO6WtvxM/d7jmWI1OQrl2i5WAn7TKZEYvRo8GaC/WEAv+21trATXjCcDe3Ut2wCv78Olt/TcRW/vACa4Csx6zZuiiS805hCOaJ0uQ9rPXWHPuLHOMmwbfCOzchF2RtVJkFxRdZE/trSopliCtRggr0gh3/F
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2017 19:29:25.5553 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b257eba9-df9e-4a43-d3ae-08d527a83381
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR07MB3496
Return-Path: <David.Daney@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60816
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

Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Nov 2017 01:57:40 +0100 (CET)
Received: from mail-by2nam01on0089.outbound.protection.outlook.com ([104.47.34.89]:64751
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23990491AbdK2A5M399oi (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 29 Nov 2017 01:57:12 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=+xGCXfVgT3ZjsVa8BaQUj4vjyihr26dDMshXgQeJcmA=;
 b=TG1W6PLkO8ZQDhY95Ud3O25nC9ni5cfJL/qwd6akvwjforaqf5eBEpx974g+x6ZMn7egNjCNro9Y78HUApxnk0YKXah4IJZwF/2691rwad21R8+SW5s7NBWpnCHhAHpgezo5z/GW7ZiGM56RqzEm0V2yxwweBgzbwfy29mj9HZs=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=David.Daney@cavium.com; 
Received: from ddl.caveonetworks.com (50.233.148.156) by
 CY4PR07MB3495.namprd07.prod.outlook.com (10.171.252.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.282.5; Wed, 29 Nov 2017 00:57:00 +0000
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
Subject: [PATCH v4 1/8] dt-bindings: Add Cavium Octeon Common Ethernet Interface.
Date:   Tue, 28 Nov 2017 16:55:33 -0800
Message-Id: <20171129005540.28829-2-david.daney@cavium.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20171129005540.28829-1-david.daney@cavium.com>
References: <20171129005540.28829-1-david.daney@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: BY2PR07CA0096.namprd07.prod.outlook.com (10.166.107.49) To
 CY4PR07MB3495.namprd07.prod.outlook.com (10.171.252.152)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2842936a-f23f-4a1f-557f-08d536c41c77
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(4534020)(4602075)(4627115)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603199);SRVR:CY4PR07MB3495;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3495;3:9DfzB5xUivUXmtcnNI94K/m/kbEPu8G/YRL1vuO0SQ57BvV+miEfTWRU7IjLRVJYEa7JjJ5bQ3VKctp69BNGBIiDEPMQGu1jkOQcVThJy95XIwWFg0q4Gv6rvg7JFxyLbrsu0jXjCiCEEMKRXPP9az9K2/RYHGGLocvpKkVB/R/dGwKle5e1ceDaVgwUcfP4tbbFuyIKOmPBcchxIsUaB90egtq6sI+nZLvZ2dAfNuikUw1LK7xpuPRMCEl3Rd0D;25:/tu2/mEk+w/lfpIjdl3wQ08oWcFLJRj3tv8BKthUcfppWkD4+FAGnbPeeMIslayQwWZLyySJHc6EbpjeVRz+8ywR/6KiMNO/uL9Gw71aLVpEesqazLDMndpCqAgJTu4jF98lanGv/mRLPr/7bGLAolgoIqV7KgOP1jeBImJ+D085AgPRjLcUFx71bXWm8C34WhJY+WVXrPYW04oWY+mk7kpHSDhIxIuBI7NRRAQcv2I3sojZaRHED+PEKxHlpU04p9v6OSfxU2wTf2wcySdBfUuP3E80xoBm9DA+k8VvaEp1HDhn/gd4Cbf4d2eIKvTX/sSHawqC4kLa6vkbQKjkpw==;31:GO8xkvDFG3v6ISyvbvLDkBFnc5bHUJm5eN/yFFy+BxDDt/aYBoi9cjfmYypI48paUYF5G8YolJHPqFwxhtSvyzjONH3iZ+pkCtpQ5HN+XK3++4mptxibBR3zhFxNUUokSmE1tR1CrOQjWt9D9donp+0zzhjeUmG+bvdDvURFAjKgnJFFHDQMXy5qQ9JeUQNitUEU/j0YU91V6ZXsywToHwoQ9v0NbbaMz67IcJ97DIM=
X-MS-TrafficTypeDiagnostic: CY4PR07MB3495:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3495;20:IStFue6nafvDDpvwvs4n2/MWTiPB/9+90ZQ7LTIw6PiOwZOKLSH0/ssZKv/UFK6hAK6Y+rA0IRRDAJnFx/dpWD7fSPWt24xBVzs88hluQ0IYuGk/JCwGNMEyltBot4GGZYf/wKHRUhx+ccL+I5A0kfFPxzCBXlCXeY33pmyOmEpJ1wG9mYWs1f48wyWA+ZpgF5SFz4s7X/dlQrWAeICI50HZwH6lz7wpEDcdcqfBfGEFQT8+96Rg2IX0ygA2NUztLf8J2e4K5HzJCPcw1M5QdnzE0JFwjGPtIFisekTsATzk/i8F4jv2HiVToPw0HATgD5Ni9qF02YchBNrHK5+wxZ+ErBy1FQuNxdKUm5I/MBdVQPlqBk6akKlIm68rRBfRW5pAlkTJVaOHgJVX0pQHdSi0NEZGaRoEb3/vCuicPePrtzPH0Gl+Fvd12HdMmXYsMeOU350/M/DSmpRuSZzGu9lz40FHuk5s5P1A4XZic2Q2b+O8k32XFE2KhOyHfg7k;4:ACMS44kqf0zRsLeXj9ns2o9vue9c/7AdpbIl8nVCnTBvz0+jYxElmIP5QMngXqqX1VTAuc9tYjZDbOBXLr//vuHEPYIdrj57eLL5MBOH4RqzVfLZTYBY/296iw6jHFBLTBfEJdCII3kH33yOnk1Gb3+FcT7agn0hv/wMr8Eu5rBMfB3O9bxs3lFlfeJYa/QYsx6R0e636Sx7rO/hrn3iQQMsoUlqArzSFigJ4JTUY9BL9kktsv9EQtadnEQm7DI+ySXv29tRGf0LmcG8+izyiw==
X-Microsoft-Antispam-PRVS: <CY4PR07MB3495D8BFA2CF7C668CA1AB79973B0@CY4PR07MB3495.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040450)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231022)(6041248)(20161123560025)(20161123558100)(20161123555025)(20161123564025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123562025)(6072148)(201708071742011);SRVR:CY4PR07MB3495;BCL:0;PCL:0;RULEID:(100000803101)(100110400095);SRVR:CY4PR07MB3495;
X-Forefront-PRVS: 05066DEDBB
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6009001)(376002)(39830400002)(346002)(366004)(199003)(189002)(50986999)(16586007)(8676002)(4326008)(305945005)(7736002)(76176999)(101416001)(16526018)(86362001)(53936002)(39060400002)(107886003)(66066001)(25786009)(81166006)(81156014)(2906002)(50226002)(2950100002)(1076002)(106356001)(7416002)(8936002)(97736004)(105586002)(72206003)(5660300001)(68736007)(6666003)(33646002)(478600001)(3846002)(6116002)(47776003)(189998001)(36756003)(54906003)(110136005)(51416003)(53416004)(6506006)(316002)(6486002)(48376002)(50466002)(52116002)(6512007)(69596002);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR07MB3495;H:ddl.caveonetworks.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR07MB3495;23:teq1Vd6nO+GoSZMQFUwuAHuIZNVky/zavIL0wksJh?=
 =?us-ascii?Q?8WiNc4Z2OKFV/2SVCYcXqYCy9RmdgVzYNjL9izdMrgh2ce43iWxJJi7XHkvf?=
 =?us-ascii?Q?ooJ9jAqLO0h35TttXuvU+bS7xiAK4rgmbx8p/bL+mvK7gb1zFckvw9JPMYAH?=
 =?us-ascii?Q?+5drJ2XRxMn+8CHKz4PY7clMLtXSKRjLOYdumjRSxBleD8WW9vW1fNIxq27A?=
 =?us-ascii?Q?/e5UDh3vWhbECuWFYmRbFB2FgW1qc6yE4RnbcqdMooIz00sOHHNwvmppaTSd?=
 =?us-ascii?Q?UWJbKXHz/nXxOrN1br3LXau9TPbWSAvzsoCWZJo/q0YRmkcKXZo/38fiwsjj?=
 =?us-ascii?Q?yYq4QetTZheNtWssUvVK8keKsJTZom1RMuA+H9rPcKJJF8obRMambrmmaj85?=
 =?us-ascii?Q?JjSVPNlNisLGCRHVvr9fGy/DQ6qJb5Az9G4uGaTkLtdzVeqRoPZTAFICMYt2?=
 =?us-ascii?Q?g21UOI/XQijhLgLvjn7Cvj4Q4TmG4NL92rKGEtPiXMor6NPEoDxvijFjCGX6?=
 =?us-ascii?Q?ajC4jrcG2z1rVzYjr+2/8Un1Goe/iQxpLgUGKEfvJ8yOxc2h20pGi5n2aPT9?=
 =?us-ascii?Q?LpnM4Bp43d5Pn7VhaVBWl4wwTw0q2zEuONsUn3eogwrXX5yqiuoIgsa0zaC/?=
 =?us-ascii?Q?t4Xprulf+xwSGCzOdXeg1Wj3QgtMXLa8VLdzRc+I/1lLpuujE8PG12KBbtZW?=
 =?us-ascii?Q?iMbooT7HnxlCjDxrAA5r+ESPqGb/V9Ef4uzAMdIeUWsjhvgbpRiLU7QT6e/q?=
 =?us-ascii?Q?LNzjnr+iMcr/igMv05Txk0s15/QLkJBUKg3owXK1SahnogFjPKffZYAVGUNa?=
 =?us-ascii?Q?fVj0btANqWxIOPdXzf1xjrlGfKP/CzkH8o12VIbsvxZWbY9vmB3iXyx68ZKw?=
 =?us-ascii?Q?ep1VXIngSJVVBLGSueP5mHkQ86nusII9I4jtv/W4U+TYq4YEESj+6e8bQc2R?=
 =?us-ascii?Q?wNTU0MtHZCwfnF0YwRnRwtACT3rs7EI8S5r4KPWCtU/iOoDBztmGo2tm7E5Z?=
 =?us-ascii?Q?G11ZxliT0ZPIJd32Scf0GjPLHbqUm+l8bkHAz+ZOKEzJPGPrhe6Vh/RZlT60?=
 =?us-ascii?Q?Axm3s16Or/wNpqFOswdASEqHkLuYngz+aTv7CpQm3s5Srv/2wIx4Z4gt4K0P?=
 =?us-ascii?Q?L4Vd9uHThcUWZer7J3nypfJM5Dn0ujZ910m7jh4CeGabloV3fjAVIw50isAy?=
 =?us-ascii?Q?EOwynpA9hZU0hj21d/AZ5Wr5M85h0DEztVgtuN17j4eh01fc7rLhBKbu/rhB?=
 =?us-ascii?Q?5uU4UGaulybKjEitVAmxYVd2MvxHZ4ZTecY2w73Ygwb4uukE/K45jFhRV46Y?=
 =?us-ascii?B?dz09?=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3495;6:gyfS6wuSmAfknlQMT/SIe8wrAoI1yOdxuQEbzMzxla3C9YFHTE6BpvpatSCfeWkku5ki+BhLWsCwKh2iVcSA4zgIfBwdmLJVqac+V9iL9pgMW6Tf1k/bEp3aaEGVKBLNzDtxam0+pxLc728ZRANmVEVIMy85YzRwCqOgzVHgl7RWds7pkEHjOKBa0rv1ELaaZUbQEfqueA8uOB1wOemzqMmuTynL+UVLAyLuFw/1aqbZgYUMj8UahZbZnx3nWCqa9WCXwxOGvWdgKId8YCvimx9oZabLb1l3w6342iiwyeZ8j2aMsPQrSCt5DnxeB5DpVI95gjMl7GTx3GBkSc1PKwzw9pfXNKHh5lx5E2GyPYs=;5:LbPfmAyCpOzan2+IKxCPTsTQH2/jSgqIkRby0HEkaO9s5wblxZmr0gz1IM1Rcu1EhWeV46l9zom+nL8T3OzIdFFYpyaEhoQX2GBrfesC+oCNs9oVBw7eM77iTJo9laUrNTiNfcijmyBP0C630Hmgmq9jQWMQIg36WbuzOaRjhDs=;24:vFe8zpkTzuafR4qeo/7tDLMf6083aKB7DGy1zHJIWz54Z6nCpocz3zHSC314Urz5pZnddCcJa3Re7DBBHRyJIaNeLiSFHMT0sQnPB2J123k=;7:eTxhPRik/qnb67zALwHoiEzNbmCErhpHBvN0+Teq5KljdDousSKTwRUvpAYQPU8gtHckrABulOwia52u6r3fix1cWz6oTcXVCxlZZGfTHCXn2zJrZPOVszTLG4VfrH/FyKq+lODfc79iI0QNVOd33CMSmr19r9Qb+IM/mPZHKdMrcNDnpfjWuVXoq8+uJz3i8LhawsmomB87RsJzVb+bnVAJubZFw9QlHtedhzVKLpyYPwVVhi/KQlq7PgUj8IiA
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2017 00:57:00.5577 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2842936a-f23f-4a1f-557f-08d536c41c77
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR07MB3495
Return-Path: <David.Daney@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61171
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

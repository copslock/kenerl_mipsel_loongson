Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 Dec 2017 01:10:27 +0100 (CET)
Received: from mail-bn3nam01on0088.outbound.protection.outlook.com ([104.47.33.88]:35584
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23990435AbdLHAKAeCGRA (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 8 Dec 2017 01:10:00 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=+xGCXfVgT3ZjsVa8BaQUj4vjyihr26dDMshXgQeJcmA=;
 b=HUZ6zd5AaYCWYB0eVt1M9q7PJdZLWgca/XJfr2ls2Q/vJ54hRBkv/smvKb+qf/JVRtWomfaMtuIm6xcaVdz0aFBdY8wHCopJOYem1xzx2gde8geal8KNeeeJEHopKxbiEBh11xfLtYEhX2VLT4ylQfB7TIz6xlenDkllNtDZdho=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=David.Daney@cavium.com; 
Received: from ddl.caveonetworks.com (50.233.148.156) by
 MWHPR07MB3504.namprd07.prod.outlook.com (10.164.192.31) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.302.9; Fri, 8 Dec 2017 00:09:44 +0000
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
Subject: [PATCH v6 net-next,mips 1/7] dt-bindings: Add Cavium Octeon Common Ethernet Interface.
Date:   Thu,  7 Dec 2017 16:09:28 -0800
Message-Id: <20171208000934.6554-2-david.daney@cavium.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20171208000934.6554-1-david.daney@cavium.com>
References: <20171208000934.6554-1-david.daney@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: CO2PR07CA0068.namprd07.prod.outlook.com (10.174.192.36) To
 MWHPR07MB3504.namprd07.prod.outlook.com (10.164.192.31)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b7da4cb0-6b75-4b8f-0790-08d53dcfff84
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(5600026)(4604075)(4534020)(4602075)(4627115)(201703031133081)(201702281549075)(2017052603307);SRVR:MWHPR07MB3504;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB3504;3:YFknkes4spTJh+vJNBABNO9EsUzCHlNHl3ZVjg+EbOqp/O+AsaCnJHVXiI6btSkuiU+Swo5U1yyBjP6RCX0SZXfGxdf4sMZvarQr3C7mKF0ilJUEzIk12SXWbH6oGFPxyRs9VO8tdK8+tHYadUIA/SCVq5zkZ1zmktuRhKSYzruD1y3nzqer4WhtHNZOLVVWvzfEzMz3whl1mgLa0RiRX/lrOKx4SK/0q0l4aVg+ER8WkziaZhWprZ/JpsMlwhlu;25:Nrn6fu4S3AqB/FSennVmUKBVPoGFY+PWZPNa3rkRr82BOjZ2FY8iw62M7gvVaWjaiQ7IwPkyX0wcBtDb6+vdtv1/Y+rAEU+j/b3XAzoMaJDJpMvsgTyZRmcaIMLR6ibs7XXOGexVEls7/xO/e5EoH3BXi11RcScT3mxWjH7dPEnEbzadmRFCjH8WuN69Bmf0Fv0w/xIko9y48rrB4gyOLY/0YGBuzh8Ze+L1hQNhLo6UQVAhKi2OITN0UC47+1Ze5cfDru5m8FeuQt3Q+uwKfEOyD2rn6KZAQaykoTbcFDBNaMdcuEnl+zbJkfKvitzqc1+usG8wEuoJ6/9YldGCcA==;31:KwX9BxhPc4iYUB6sAQvQmIMCj5fs6z7YRMUQ3HB2CGZe9+3M2mtV0bQn27sFKHC+Xxm3bpbapVP8aPxxsL/kZsvTLz+BixP6vCBxnPgG2WvGuk1HUn7lZE38IzgbO+6o4qig4ytG0dXD0REgYYOdITcw6AX51aFN31TiRfGbwNEvi1fjaefbg9fwRLSr3/aOJsRSUSU4j4Uy68tvrvjJH3gdOuzjzbo54bUay2Juklw=
X-MS-TrafficTypeDiagnostic: MWHPR07MB3504:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB3504;20:mgoslYoQMfgAdFdWPZ9LO57iEmhxVTuG6CFqXHSf8AlQ98ZYZiNojdq9/ayJszzFzYz6CL0IoVuqmvC4dQHTwFNtvwFIobIqiw9HtukfMZU4BhxVZDaJUeCbue1bhh81dlzJg3qPXo/Nw/fCQ2tXTA+BjvLO22+I6pGhe/2IxmITZiIU2vlCSjxZsOcTa7qcAJUdITkGgmdIvmkEq+tLwqr0tqEZzeynoCO+kvUApkv5XI8mQ+1GwhRlBgv0BpV2EU3xK8yJApkniKkomBxXfGGjDEocuuT2j3hsTxTvepkoggLq+epUr6ZmV2SSefTWwe2cFV17b0lM0zJpyVytJLNk8ryt3drnfTC29YO9oTJpLxOeba0lpjWax6WnbO90zn2MdsFH3JDHHHJmAibqie0ilaxW18BTQFN+Wzq/ZA2y8ywrN6F0NhstqDxbtCoKvRSu6ePnV8dH6tWlRDyOPXHrm5iRWIiR15It7YUN4OFGqg+TELREWSjmCy1frYjC;4:3Yi2sfGgV6yQpAjy8d1GfZ3c4GQvVJDIb3vy5l+nIEHsiNdN/nd0vu+AhSaHD9uNrOdVocVMLjiiEgfzAQSsRGmLaqY774RaJP1P+kdjA0H1dVxJNnUFPuvZkBTJ7DWdQhdmdgRvDqIhmEQUH383vq5xgRS4UzDl9utxV9bZ0Uwnzn4xB+p5w7sqrDcGfyIHFpfp3Gvu+HWxgDH42+8r0XTIR+/VKMPhYfb59nVDUVktkuz3y20hNrk3KRwpEXLcS911X89nbouPjl+YthGEyA==
X-Microsoft-Antispam-PRVS: <MWHPR07MB35046E859CAC3BD214AD929997300@MWHPR07MB3504.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040450)(2401047)(8121501046)(5005006)(10201501046)(3231022)(93006095)(93001095)(3002001)(6041248)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123564025)(20161123558100)(20161123555025)(20161123562025)(20161123560025)(6072148)(201708071742011);SRVR:MWHPR07MB3504;BCL:0;PCL:0;RULEID:(100000803101)(100110400095);SRVR:MWHPR07MB3504;
X-Forefront-PRVS: 0515208626
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(346002)(376002)(199004)(189003)(86362001)(105586002)(106356001)(81166006)(81156014)(8676002)(69596002)(6512007)(47776003)(107886003)(66066001)(48376002)(4326008)(39060400002)(7736002)(50466002)(305945005)(53416004)(53936002)(51416003)(52116002)(68736007)(36756003)(76176011)(6486002)(6506006)(8936002)(50226002)(478600001)(33646002)(72206003)(16526018)(25786009)(3846002)(6116002)(97736004)(16586007)(316002)(2906002)(7416002)(1076002)(54906003)(110136005)(6666003)(5660300001)(2950100002)(142933001);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR07MB3504;H:ddl.caveonetworks.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR07MB3504;23:twxlhHQfdskhAvIKaQ1AEpgfmFIXmbMQdg3/NaPAV?=
 =?us-ascii?Q?Z6ElsVP1U9QTlot0maUbJobpqjHr1SmbhG+L91YzELcyK520ZGSCkmbBr7hN?=
 =?us-ascii?Q?xV3deLFvGGq1Hpe5WUpePEEfFBk7kJD33/hpEaxjmjjqX+xls+p8hFhshsxg?=
 =?us-ascii?Q?Vp9we4yk4gh3qsllSi3Bas3JiguHNsVTAgVkubiXMyYFk9oT3yu+bdc3EhM3?=
 =?us-ascii?Q?v2jxXh278Lkyrjj16Br1wj1oUW+2J8FQtChGmbtxbfwI+6M6DixUNZ014QF8?=
 =?us-ascii?Q?PVqzlgTWpRIzhjo+XuKpFnv7tBluMhkFaAgYvALQvZ1EUkq7lfkUfbb5ekzf?=
 =?us-ascii?Q?1lB1fImfIUYXvKolazHB1bdZIy1VtPv4++Il/iIwWMUQnHFmtfYSJ4W8xIQw?=
 =?us-ascii?Q?YjH1DTi9Fi3xpQN6qx0VPlhByggm9gprC32Vi1lOqFaat4nUGuct64t3EaNw?=
 =?us-ascii?Q?XZms/wB7H4ZNjJtXkUI7QlOAb1rrqteG6gjzodMM1cEI9kwwNmzxfyTpK/FD?=
 =?us-ascii?Q?0oZdYmlQWqm7aTQobn5Tr6pcm3Kfs8P126mVjl+CDUNVjVxVEvrH6cTxkAdk?=
 =?us-ascii?Q?5JjbKH1ZzriGQhxpI4POTF+eXeDqdZ05adIEouYEPPimLxePHfqG0ftlVXuj?=
 =?us-ascii?Q?NjeUt6oYefQcXUMYSzQxYxTSNIOuW9HB8cjD+hiIAPiQaJ3vGKpLf3OUpZvF?=
 =?us-ascii?Q?pCa1vC3QMz2MkyfSuEQZGcXwsQEM0XM4xttFCefGhzb+HMc8UvyJHCWSXV/O?=
 =?us-ascii?Q?GiXsdlZET/fMjbVAYBMU9mlmSXXyFmQDXdj9Nl2TmoevGFjU9NgvdL/y+BXF?=
 =?us-ascii?Q?OuJui9WdxZ20P83lZO0vTgGvriN31B2qiR2usDhlrRVK8cdh013gMOHk4jvs?=
 =?us-ascii?Q?8lfjjuvkr+IGf8KrKgM5dge9Zn56fVciqaLb6KfSdehCPCmwuz+3/D3wkhjP?=
 =?us-ascii?Q?h7euYZrMp+q21xbUS700uq7nuxqW8hIt3vNCRW2YBTakHTKjlf4+KvF55NU8?=
 =?us-ascii?Q?Azy1tJpjoV48vZbYrOjiAxX3Y0/4bzRZl0nlC3iu8eLp2U/PsliWbUKOg/Ob?=
 =?us-ascii?Q?JW38J1CtK0UGsvanPuBqd6zVktLJEHtctM+2bmrJeKiu6W963IecvC+SR/Zi?=
 =?us-ascii?Q?YRQEewYwRxSxqcc8LK/uvcGFngBF8tDbM7CnCC5xlO4CY1oZR2eOSgIFxOD1?=
 =?us-ascii?Q?QgSPdX7EOtdxLSuXmhWfugg15UrAxLiIiJK?=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB3504;6:NiwT/6b8UsXY3XSFwv8YpgAPz7RVPT9eH7FyEErRH66v+of+TjXn1fOVtdnmLjiGfA5Fnhbs88mo/oqoc0vATQdprsw2yWnVET4gjHb5QbO/yj5+vwocpygIoya0/9g5if2K9E2Dvi69MHr7hOP4ShisE6BTqEyd8ef9FY4l4UO2T1QWGLhbol3HqSHuhS4GjEHkqvFUKInd54RU7M3FDJk7nWnfGaEIN1rezk+SEFqGQ5PkD43Ws3aPa9d7M31ZLVLflVNiA2Kbs+w8/Jii+Wpt9RbCibgSUXXVY6z1YvSQYAk0l9IQmFj5j1siMmw4zuAHX2EGQnZf3aCOuwprZLGEb7Gp+iDJSYePnRxT37w=;5:exsZ4BWiuT/jbIoY9RTarmBaRgFtvOLo83QHZOViVP0baPWag9gemC6XUkFcxnkPQwfc/HDY6fGTtXLw47Zt6WNtT3+QnAXH+HiMeZFB7qEqRjlZ9ZO1090G8QWKpEDwOlk9uDMBHbfDFkj/k5dWCBP9J6QuZnLIcL4k7XQfRe8=;24:u6XSZFMZcw+UrxdhL2NGuxqhVneKQCJKZFF+eXyEgQZmSRkRNg1mADpTHPuIQgd6+P0mvyRbL+nlx21ZWRN9ZPTiozEy6/nG/kDly+5axes=;7:SfKSqKscNO3UECy7+kjH88ZjiLe/uMFVfCkqtYJKQZXS8PpoHY3hJgwhEu+Q4+FZ7Q7Mw+LuXohlqtH/XjoIqXcgIK10MjQW1cSZ+D7Bv5KO6KfeN3CaWhOJP/4HmS9hmd/XfR7RoV1PI954KNVTbwY99tm8FKi6cpQBk2mOKSTDTq5YIwyCGwjg5dXI6gST5Y6JRTUaoUFa92Ufeb4cLV0HZcO3dWVlAFAx1e9YPDUgs/WmIYo15ZPMn7sDIvOr
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2017 00:09:44.2472 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b7da4cb0-6b75-4b8f-0790-08d53dcfff84
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR07MB3504
Return-Path: <David.Daney@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61343
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

Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Apr 2018 02:23:28 +0200 (CEST)
Received: from mail-bn3nam01on0099.outbound.protection.outlook.com ([104.47.33.99]:6400
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992615AbeDIAXCKJ4gG convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 9 Apr 2018 02:23:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=rWThu3jr1I8EvsF6RDs86jM4LlV13ElKJ9DwU5jN4K4=;
 b=PyL620oDD5MomtagjWen1yeYF8WTsvQTfc4F99Dioe5ybcXQl+vIfBSZ688yBa6zuOSUFxZRfFHgL3XO2shTUUOoeg2A1bDxwD2r2defIumDVM6ka8njh+RAYbWxh+ncQ0tWyxA8tIlILCBB2NritP0ZZ3JhbbTp23LeK0S+q2Q=
Received: from DM5PR2101MB1032.namprd21.prod.outlook.com (52.132.128.13) by
 DM5PR2101MB1014.namprd21.prod.outlook.com (52.132.133.36) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.696.0; Mon, 9 Apr 2018 00:22:51 +0000
Received: from DM5PR2101MB1032.namprd21.prod.outlook.com
 ([fe80::8109:aef0:a777:7059]) by DM5PR2101MB1032.namprd21.prod.outlook.com
 ([fe80::8109:aef0:a777:7059%2]) with mapi id 15.20.0696.003; Mon, 9 Apr 2018
 00:22:51 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Paul Cercueil <paul@crapouillou.net>,
        Ralf Baechle <ralf@linux-mips.org>,
        Maarten ter Huurne <maarten@treewalker.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 042/161] clk: ingenic: Fix recalc_rate for
 clocks with fixed divider
Thread-Topic: [PATCH AUTOSEL for 4.14 042/161] clk: ingenic: Fix recalc_rate
 for clocks with fixed divider
Thread-Index: AQHTz5iKJStlnLPab06IcEbPJ4Cn5g==
Date:   Mon, 9 Apr 2018 00:20:19 +0000
Message-ID: <20180409001936.162706-42-alexander.levin@microsoft.com>
References: <20180409001936.162706-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001936.162706-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1014;7:Rax+blONOPe5nqRofZs05kTHyiVjDiTphE+FrOpy6daWm3SaETJS23+lUeTZqy68qcMMdUiVqwaxqQ/YzeZ3MqI+GJ9dFvMn0BQ6iDCdRE6YOOmpilM+hrRW6JWg2d7YndqjOCJxq09dAxfDdGJDEAAektceL90V0bPvlfiRa74OWD/09omZGGLA/u2s6+zUZzLAqf05N+tOHxd2lK3NFfDq0XbXX0duP3zO4DHCCWqaSHGc70hSggPEW8Yh7nnD;20:s09wohf5L8deFyNu75N1JqAY0hGF3/KRuI4EedQ9UkKLsGujCyL8xf0rjULo3TfYd5O49L/d22QcWNnXzX7Jdm0YvVPr4ORFXMmuWBekYG3PtuH3k+hdcL8c9FSQBb2a1v+tzWDqbPgzpBnh1ccygIq0JlyLe6yLNWrvH8TFy/4=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2b1d2b7e-24dd-4eaa-f57f-08d59db0081d
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1014;
x-ms-traffictypediagnostic: DM5PR2101MB1014:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <DM5PR2101MB10142792160EE3FEE445F403FBBF0@DM5PR2101MB1014.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1014;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1014;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(39860400002)(39380400002)(396003)(376002)(189003)(199004)(81166006)(81156014)(478600001)(6436002)(72206003)(8936002)(10290500003)(106356001)(99286004)(86362001)(2616005)(7736002)(2501003)(6666003)(446003)(476003)(8676002)(11346002)(105586002)(305945005)(5250100002)(6512007)(53936002)(68736007)(6306002)(107886003)(66066001)(86612001)(966005)(2906002)(14454004)(186003)(22452003)(25786009)(4326008)(2900100001)(486006)(36756003)(6486002)(3660700001)(54906003)(26005)(3280700002)(110136005)(1076002)(10090500001)(76176011)(6506007)(97736004)(316002)(3846002)(6116002)(102836004)(5660300001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1014;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 7QewX96dVr1e9Vb6yf9VqK06ZrLqOmUZDfqDLDkePJZTOrnPMB8bipsGdi3NAbAPF18Nl3gBXGcq0Azb7dAdULOTSbWdyv4YwneB+Jiw0zQ7mZcvI6eawILlb95IK1ja9vBWmSpFTNkvYs5hr4UjsOw5OV+nGsGj4aZBJUEkBmVmCEwo0qOx5/ayiVz0jaUUZ4MA2aksK0UM1Q4kU01FW3zCMrdAT2uzE+kty1QFgyf/Zmvis6UXgC6+G1R0pPmjFQ+UqzfnDqr9PRkWnrZWp8175iFefDwlO+aUW0yRPiyf/3KRBCpJ0f9uCpi8qgvvbF+dR4X0I23kAKDC44ASJmArxjDC83fQ2/IafaVSAZ3Q2iMu8H9Hwj1aUktC9m7V7bJRTHviTE5P4dsVRlKXYnfPXbR8F8pzUx8P3LHcDVA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b1d2b7e-24dd-4eaa-f57f-08d59db0081d
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:20:19.1132
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1014
Return-Path: <Alexander.Levin@microsoft.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63439
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

From: Paul Cercueil <paul@crapouillou.net>

[ Upstream commit e6cfa64375d34a6c8c1861868a381013b2d3b921 ]

Previously, the clocks with a fixed divider would report their rate
as being the same as the one of their parent, independently of the
divider in use. This commit fixes this behaviour.

This went unnoticed as neither the jz4740 nor the jz4780 CGU code
have clocks with fixed dividers yet.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Acked-by: Stephen Boyd <sboyd@codeaurora.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Maarten ter Huurne <maarten@treewalker.org>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/18477/
Signed-off-by: James Hogan <jhogan@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/clk/ingenic/cgu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/ingenic/cgu.c b/drivers/clk/ingenic/cgu.c
index ab393637f7b0..a2e73a6d60fd 100644
--- a/drivers/clk/ingenic/cgu.c
+++ b/drivers/clk/ingenic/cgu.c
@@ -328,6 +328,8 @@ ingenic_clk_recalc_rate(struct clk_hw *hw, unsigned long parent_rate)
 		div *= clk_info->div.div;
 
 		rate /= div;
+	} else if (clk_info->type & CGU_CLK_FIXDIV) {
+		rate /= clk_info->fixdiv.div;
 	}
 
 	return rate;
-- 
2.15.1

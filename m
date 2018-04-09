Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Apr 2018 02:34:04 +0200 (CEST)
Received: from mail-sn1nam01on0121.outbound.protection.outlook.com ([104.47.32.121]:42690
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23994703AbeDIAdQOY7WV convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 9 Apr 2018 02:33:16 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=UADr6qRNR1Q871HLtIUZAatGAe9GBAI8TJJ623dBM64=;
 b=XHK56j8MPQt17Y2dGQVyewG4NJr3GX40PyDNa9+AXbMi3+Ehc8qtZnQ4U2xoJHTQjfBP7xRSUO5cYo1VRO1hw/r2GHF9HRxyimlVeCa2rqEhlgC85EvsnBtmupyIkpTy7Cr39PhjCi2Isa8Ycqaix22X+Fx5rjzq2rq4EQQcGRE=
Received: from DM5PR2101MB1032.namprd21.prod.outlook.com (52.132.128.13) by
 DM5PR2101MB0902.namprd21.prod.outlook.com (52.132.132.159) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.696.0; Mon, 9 Apr 2018 00:33:04 +0000
Received: from DM5PR2101MB1032.namprd21.prod.outlook.com
 ([fe80::8109:aef0:a777:7059]) by DM5PR2101MB1032.namprd21.prod.outlook.com
 ([fe80::8109:aef0:a777:7059%2]) with mapi id 15.20.0696.003; Mon, 9 Apr 2018
 00:33:04 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Paul Cercueil <paul@crapouillou.net>,
        Ralf Baechle <ralf@linux-mips.org>,
        Maarten ter Huurne <maarten@treewalker.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 230/293] clk: ingenic: Fix recalc_rate for
 clocks with fixed divider
Thread-Topic: [PATCH AUTOSEL for 4.9 230/293] clk: ingenic: Fix recalc_rate
 for clocks with fixed divider
Thread-Index: AQHTz5lR7s20/06CbESuTp9Fsoncuw==
Date:   Mon, 9 Apr 2018 00:25:53 +0000
Message-ID: <20180409002239.163177-230-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0902;7:YzFyqRhEUntDGhIJUALmKNL8M0jbWD6tBsfmIm3FbA1UuyPULVJTpmRnQZewt6Srw9pyeb3cyrMovQDoQ/4e9Kh+LRdIfLBPNge4+c/fC/CE9KNaIPJOjq0bTGxDu3EFGdN/rj57YyCUKfcp4oyH96auxRhJWlHQfMMdveZqP5/XXhcunVQD7avQjUbeE6nD5q6qtqVwdxq+BQLgxmp6mbxCQs/B8PmWGHL5rSlRNzx7DgY1r19TGsLaWd7kt1jo;20:q0vOY6pE3tK1CIcccosF/OkZwCQBd8ho0SYnxvKplKDYye954e/Q7dHQNibmEYdyNfUPh25yzjguDUfpT+jE3oPJVrbreCaXUVvZACoAyuPFMMdrcuzM8/Jkw2Kjh2vn+AXW3Vfdcqm3e7mJ1H7F2LSi2z7ijlawny8atz8j0m4=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: b05fab0f-0ac5-42f8-1564-08d59db17541
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0902;
x-ms-traffictypediagnostic: DM5PR2101MB0902:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <DM5PR2101MB0902DD06B25A7C7D56E1BB9CFBBF0@DM5PR2101MB0902.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0902;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0902;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(396003)(39860400002)(39380400002)(346002)(199004)(189003)(5660300001)(478600001)(86612001)(3846002)(6116002)(106356001)(25786009)(6486002)(72206003)(10290500003)(8936002)(6436002)(76176011)(2616005)(6506007)(2900100001)(97736004)(26005)(486006)(10090500001)(36756003)(81166006)(8676002)(81156014)(102836004)(2906002)(99286004)(11346002)(476003)(3660700001)(66066001)(6512007)(86362001)(6306002)(53936002)(966005)(105586002)(186003)(5250100002)(14454004)(22452003)(6666003)(2501003)(446003)(7736002)(316002)(1076002)(110136005)(3280700002)(68736007)(54906003)(107886003)(4326008)(305945005)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0902;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: xGoTTSrt9ci3U5BgE3sNbCCSFUuHS7Qh884hExxtGTXlqggYFSHmKJtXwletjzaS+C8+8JB2Bbo9SQvf8eTaMGP18cgpfuUrylV9+NWyjz8zUaM62ehAIyNsCQRCJSpAqiZ2YZefyxTqDtzSveYaAom8jHQROrnOrUdYVcN7yPI/qevRTXp2EOb9WsMSGdtIqzmEr4r8UB0iCbn0FLDnXYga2gF8M7aDOCgQhluDWbEjDWPbr3pkJQorUag/vySIBWCz0zLFtvzJjWgjI5QrtLxfhmnCg+phCY3xOvB22Qsfh1fbWrRgF9efrlsmm2TDIFpwTBVXm667+AlXOjA87AIR7/e67PmPCKnb77POCznfvITZGmebM31yQ2H/A7WPxcWc7VfG67cu241HMEW7SFiTOqynFj5IQHJZh+8UyJ8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b05fab0f-0ac5-42f8-1564-08d59db17541
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:25:53.4098
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0902
Return-Path: <Alexander.Levin@microsoft.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63456
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
index e8248f9185f7..eb9002ccf3fc 100644
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

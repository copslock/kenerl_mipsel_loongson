Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Apr 2018 02:18:22 +0200 (CEST)
Received: from mail-bl2nam02on0090.outbound.protection.outlook.com ([104.47.38.90]:58093
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23990588AbeDIAR7yn3jG convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 9 Apr 2018 02:17:59 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=rWThu3jr1I8EvsF6RDs86jM4LlV13ElKJ9DwU5jN4K4=;
 b=LT79OABB4WA3roaRFd1lIbFegj0d1YIYeLRJdQQuM8wZZUduP3AcyzzSzomxoC5Y9VXynay8Antupd8GhooVGUfBo+U+8v56N3oa+Wlm4JmHsYkCvrm/pT6et7eUXIY31kqsSLyyqRjIdDaSwGXTm9Xn89jefJ0Wjs1jW33GAg0=
Received: from DM5PR2101MB1032.namprd21.prod.outlook.com (52.132.128.13) by
 DM5PR2101MB1048.namprd21.prod.outlook.com (52.132.128.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.696.0; Mon, 9 Apr 2018 00:17:50 +0000
Received: from DM5PR2101MB1032.namprd21.prod.outlook.com
 ([fe80::8109:aef0:a777:7059]) by DM5PR2101MB1032.namprd21.prod.outlook.com
 ([fe80::8109:aef0:a777:7059%2]) with mapi id 15.20.0696.003; Mon, 9 Apr 2018
 00:17:50 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Paul Cercueil <paul@crapouillou.net>,
        Ralf Baechle <ralf@linux-mips.org>,
        Maarten ter Huurne <maarten@treewalker.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 048/189] clk: ingenic: Fix recalc_rate for
 clocks with fixed divider
Thread-Topic: [PATCH AUTOSEL for 4.15 048/189] clk: ingenic: Fix recalc_rate
 for clocks with fixed divider
Thread-Index: AQHTz5git3dFULHUMUCcLZ/m4cWq6g==
Date:   Mon, 9 Apr 2018 00:17:24 +0000
Message-ID: <20180409001637.162453-48-alexander.levin@microsoft.com>
References: <20180409001637.162453-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001637.162453-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1048;7:VyPLb+s6D2eKQQumFLbKI3J0KaUPfmbaV1Bo5TSlsVNyGhJtisgJw5sdd1GhNazHVeuI+ycuH+BDbjjh9E7ulF5R5/vZiEeKm/ZUsfOywZyoke6zjU0XicbpknWZKl5wB/X7J9GgBhLgEOUwmTiLpRwoSMNX83O1udPLkdmDnF0pIBxGLcW0g1rVDZi1L2lJEMH3xk35HllfaeHB/jqD7u9foZ4XK6yB2meN4zYnRgAdkcAHcDLHK17hDkh36SQy;20:VahbVopeRMgjB6CtT8hoHJ3S2czdl/h1cyIFm4e2s0YYJb+JFRNdC6UeXHAc4DG6QboV7Jo5XNi3FzOP2xw1BxYClmZDygku6vjfTW4rondjp6Ghx7tlIOS9U/RRRvxa8PuZmxQ1cynlS99royQR2GOPAJLMVEII9lLjdJGgwD8=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 66a96968-0e82-4f8f-fc3e-08d59daf5453
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1048;
x-ms-traffictypediagnostic: DM5PR2101MB1048:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <DM5PR2101MB1048BC02AE58D33B3A6F0523FBBF0@DM5PR2101MB1048.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB1048;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1048;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39380400002)(376002)(39860400002)(346002)(396003)(189003)(199004)(86362001)(1076002)(99286004)(6116002)(110136005)(3846002)(54906003)(22452003)(3280700002)(105586002)(2906002)(76176011)(4326008)(6512007)(6436002)(6486002)(3660700001)(6666003)(7736002)(86612001)(25786009)(2900100001)(14454004)(97736004)(6306002)(53936002)(107886003)(68736007)(102836004)(966005)(36756003)(6506007)(26005)(186003)(106356001)(305945005)(5250100002)(72206003)(478600001)(2501003)(10290500003)(81166006)(5660300001)(8676002)(66066001)(316002)(81156014)(2616005)(10090500001)(11346002)(446003)(476003)(8936002)(486006)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1048;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: HtsW4DS4EifxR64y/kqTq9toAiOhG52ToH98WXJGy6FPlZApbxZikOcj/48kGzl/5bZDN8xaDnfQL0JQFrs1ULK2sU9ZAcnOvxpcOGuGfYzxTQXF0esJJacfoBpRdNz14XKBKrUMELKA5AxZFtNS4TBO7lat9BDBihamNFvEdOYelgxkB1999p/eToYIMQX3lF8c3r9QfgpzGrI68SJZH+djY7PMC8uu1+vm1ut/DaCLCzm3ZH9UOpciAPTqpT2KyTsj1XaJp2ziyQvT52cHV7Eazq9/wMx6n9F/d6Z0n5fYGyQYt3XAvUMj+7mZju6TG21jyC3UgFQbRdcjY5XEr3o8QTWYTxalAOXufVDmEQPoVbmETISdRFifF7BhrEE87F8KDbEKZmYNcH+5HMbAEoYLZ20bj+7ZE80YDvMOE/8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66a96968-0e82-4f8f-fc3e-08d59daf5453
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:17:24.0882
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1048
Return-Path: <Alexander.Levin@microsoft.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63433
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

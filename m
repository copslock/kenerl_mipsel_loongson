Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Apr 2018 02:38:43 +0200 (CEST)
Received: from mail-by2nam01on0102.outbound.protection.outlook.com ([104.47.34.102]:26642
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23994775AbeDIAiJ7F8wV convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 9 Apr 2018 02:38:09 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=1T1YHlhj4ryrResjhh/LSF0l5b/gmjHIU+MKJELoOpE=;
 b=M7MFanxNKZWXXHFt4vv4lBnOY7FWhjcmaYPUOPE4mAj/oabVVZntmFZYfy7JpvHhIbampPK6HozCxU+C2ciWdxXJj7H8B94Pm4MSZ7xbaXCaIccIek+vj5uUQBTTxxwg4MDeJLDk6rtQcwFVrG5vCu9kw+Q3h82a3pG6a9upDDs=
Received: from DM5PR2101MB1032.namprd21.prod.outlook.com (52.132.128.13) by
 DM5PR2101MB1110.namprd21.prod.outlook.com (52.132.131.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.696.0; Mon, 9 Apr 2018 00:37:58 +0000
Received: from DM5PR2101MB1032.namprd21.prod.outlook.com
 ([fe80::8109:aef0:a777:7059]) by DM5PR2101MB1032.namprd21.prod.outlook.com
 ([fe80::8109:aef0:a777:7059%2]) with mapi id 15.20.0696.003; Mon, 9 Apr 2018
 00:37:58 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Paul Cercueil <paul@crapouillou.net>,
        Ralf Baechle <ralf@linux-mips.org>,
        Maarten ter Huurne <maarten@treewalker.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 118/162] clk: ingenic: Fix recalc_rate for
 clocks with fixed divider
Thread-Topic: [PATCH AUTOSEL for 4.4 118/162] clk: ingenic: Fix recalc_rate
 for clocks with fixed divider
Thread-Index: AQHTz5nKGdYjw+XmQEuGDFF2C8X15w==
Date:   Mon, 9 Apr 2018 00:29:16 +0000
Message-ID: <20180409002738.163941-118-alexander.levin@microsoft.com>
References: <20180409002738.163941-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002738.163941-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1110;7:wSNwQkKogeFBg4j/yngQnXMxUD+ldrIBlOLgxB6npu3X3ccxHeSlNvPmkNM3tyyUez4o4+yJKTPPWfTTbyjWghdMt7x6a8kcR/fg5BkA/BpZOALLpIshpr1CyQU7S05Eqgc2UdXAq56Ofq5siKiRVMLWd5hy29qm1jxOQIoQ4bUfyPZsvOU//UKrGFh9g13fHftQ1QT4Dv7yMkQefd259F+vuJ9+T//N09Im2GxvAydYMo601985OK+3BBhvqgJa;20:ny5E/nvZOemYKriCXkyVZM4PVtihgi8hjVPUGuuL26hjoOg54FHHS9AoLCI2FKWsz28Ym1h2Ev+WHW6d+8UaVpdB7oogIfqnQiVKcnSANqaHkNm6gJb8uuiEOYz4JcUM4pR8m6FCPTAB/hXUfPrm5G10KeGmvioNgzrwWTikUtI=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 83161fd9-80aa-4330-71f6-08d59db22492
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1110;
x-ms-traffictypediagnostic: DM5PR2101MB1110:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <DM5PR2101MB1110F61FF068AB245B0D8E6FFBBF0@DM5PR2101MB1110.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB1110;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1110;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(39380400002)(346002)(396003)(376002)(366004)(199004)(189003)(53936002)(6306002)(186003)(5250100002)(105586002)(966005)(11346002)(99286004)(476003)(66066001)(6512007)(86362001)(3660700001)(1076002)(54906003)(68736007)(110136005)(3280700002)(316002)(305945005)(4326008)(107886003)(22452003)(14454004)(7736002)(446003)(6666003)(2501003)(10290500003)(3846002)(6116002)(72206003)(106356001)(25786009)(6486002)(6436002)(8936002)(478600001)(5660300001)(86612001)(8676002)(81156014)(2906002)(102836004)(81166006)(6506007)(2900100001)(76176011)(2616005)(486006)(26005)(36756003)(10090500001)(97736004)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1110;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: ye6x4KB1QE9705zUwWaVSFMUOQCeEkJLTOplCM14MgQ2EiNSBCZDoWtXzkDOCcSRYteqCVW/+B8aEi7XEU+7jH0VIfG/VgliazLgT/PYe6mPlNliiN+AkRJj71ApT6qNSV1x2bjSUvcTE0EOH12zGBS282AsQEMmP2HapUmCh3uU1ewe5/LtcUYFn10J4bcUvquErEQioQtIKO6ZFf0Jzfh+u7M5zyrvSMDhHlFMvE47HsJzgJHGrN1NvUdezFBeiHfNXh6eB4fFq+OStZv9HLPgDyitIcWTXhqkdUfvJr02wIWd3RFDXoaTtZcmyA/SEAhNYtEM53UfU9NPXuxbLSWIG9KSZTmeFrlzZUJvbwNAiWOd+94A2rgX1mpalMY92n/yEIqBdRCzEaW2i4HcCgc5TadjnoPOQtsiA+PQ2tY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83161fd9-80aa-4330-71f6-08d59db22492
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:29:16.7399
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1110
Return-Path: <Alexander.Levin@microsoft.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63466
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
index 7cfb7b2a2ed6..e5b1bf4dadcc 100644
--- a/drivers/clk/ingenic/cgu.c
+++ b/drivers/clk/ingenic/cgu.c
@@ -327,6 +327,8 @@ ingenic_clk_recalc_rate(struct clk_hw *hw, unsigned long parent_rate)
 		div += 1;
 
 		rate /= div;
+	} else if (clk_info->type & CGU_CLK_FIXDIV) {
+		rate /= clk_info->fixdiv.div;
 	}
 
 	return rate;
-- 
2.15.1

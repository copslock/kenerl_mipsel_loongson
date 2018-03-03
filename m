Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 03 Mar 2018 23:36:39 +0100 (CET)
Received: from mail-sn1nam02on0117.outbound.protection.outlook.com ([104.47.36.117]:64257
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23994626AbeCCWfMfxplR convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 3 Mar 2018 23:35:12 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=VrpEaVXz7rZ0R3volw3C8EvS83rQlD5DC2cjBNL4lVk=;
 b=fUaaaVb24IJmvjqCRDafFKiOpe//YFo3xDmS+pwbUuZmEd7TpkHMtJX6JQTkVVnryHkuCTVX4espkiKpmGe1aBY+TRnv6kSG5DoO3baUGVj+YVZ4ga7OQVK88agXNzvArMQBVjhzNBQYvv99Ogzbj5QLw6xRID81UGFX0eoNM0w=
Received: from MW2PR2101MB1034.namprd21.prod.outlook.com (52.132.149.10) by
 MW2PR2101MB0924.namprd21.prod.outlook.com (52.132.152.32) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.588.3; Sat, 3 Mar 2018 22:34:55 +0000
Received: from MW2PR2101MB1034.namprd21.prod.outlook.com
 ([fe80::1d56:338f:e2b:cec0]) by MW2PR2101MB1034.namprd21.prod.outlook.com
 ([fe80::1d56:338f:e2b:cec0%3]) with mapi id 15.20.0567.006; Sat, 3 Mar 2018
 22:34:55 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC:     Aleksandar Markovic <aleksandar.markovic@imgtec.com>,
        "james.hogan@imgtec.com" <james.hogan@imgtec.com>,
        "leonid.yegoshin@imgtec.com" <leonid.yegoshin@imgtec.com>,
        "douglas.leung@imgtec.com" <douglas.leung@imgtec.com>,
        "petar.jovanovic@imgtec.com" <petar.jovanovic@imgtec.com>,
        "miodrag.dinic@imgtec.com" <miodrag.dinic@imgtec.com>,
        "goran.ferenc@imgtec.com" <goran.ferenc@imgtec.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 139/219] MIPS: r2-on-r6-emu: Clear BLTZALL and
 BGEZALL debugfs counters
Thread-Topic: [PATCH AUTOSEL for 4.9 139/219] MIPS: r2-on-r6-emu: Clear
 BLTZALL and BGEZALL debugfs counters
Thread-Index: AQHTsz8Rw4AUr9HxkEe1yEeyDdoeIA==
Date:   Sat, 3 Mar 2018 22:29:17 +0000
Message-ID: <20180303222716.26640-139-alexander.levin@microsoft.com>
References: <20180303222716.26640-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222716.26640-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB0924;6:eqndWfkfe7mllvjWw+IfGsYdOI7LzL5nnh0gmumeSOrkTkg8zTNVmlQQz3O3uIfH97GvG3YP984nRcOvj8wgA6ThpAiyxr+WKA327JumEeRLMb3tpB+g9opd3qlTo3WJIWcc1OtydAU9esoOhY+vXK8doH5wKkWy0z6nsgNB0NFxEIBQ34vF+sdSO9Tubr0a3Y0yRzBPdmSUywWAaOXyBWJTW3eTDkROoEtoq8N/88Sg/tS8wOVQN7LYAWwJPK23YPnEcfUggnGnjEc/xHer4hLBxKu1wINhKQqe5OZ2zeEemRbQAdtttE57FzL7mlmPrJI9ULKZBwB4691CrUsZHmf60LyR0Z2ehcoEsVddqwQ=;5:q+zMyzpmQyhMip8hsPCIxvo/PppTN70/xd+QFF7piby2aSnnshIQsjbY5tRXjhn+dxRwinpzYPvqwh8kRq5ejZ6FCP/a2FJ7DM4f4iOLyt9zt+B7g0joZOCG1acYj/OEFM+TKMxLHAsQImL3n9R2F/6ui+4LdE93MwxX0a4Z9Hc=;24:qcrryd99l+cJ8baNdq13DRMN1gvFDb9UeR+q0n+1hRvtfwnoCgPwyFpH/CggziOKOcMNrBlwhylCQ3AwBJ/cCH+i0HrcnqSjKTyQd0rOW2g=;7:4gEzX25GL8wzbOSbAgWI9/mgWPbvj/A8Gy9llHSj5IMFJLuvhI2SRND2XuVJYsT3VE+VPUk4c+BCMGEA1jc1Hlc6vTrUVtf92BFLbYKgj/QTwd2PASt9v3G12ARYOC05o4UhnjfBPxuhwvBhutsjo7VPk1lfX/VgRIaduijF+UcHAhYUaWPjg61W0+MtldYpffWpP7ZdOE3s9JzBRvisjSx+852SrYcFEtd9gGkp1M+4khLP3od6PKmHmjP1Jnw7
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ec376a44-5234-4649-85fa-08d58156fd27
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7193020);SRVR:MW2PR2101MB0924;
x-ms-traffictypediagnostic: MW2PR2101MB0924:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <MW2PR2101MB09249C840EE1E8C21ED31593FBC40@MW2PR2101MB0924.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231220)(944501244)(52105095)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB0924;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB0924;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(39860400002)(396003)(366004)(39380400002)(189003)(199004)(102836004)(2950100002)(10090500001)(6666003)(316002)(26005)(186003)(25786009)(2900100001)(2906002)(7416002)(54906003)(22452003)(110136005)(97736004)(6506007)(59450400001)(7736002)(4326008)(305945005)(5250100002)(86362001)(575784001)(2501003)(99286004)(68736007)(72206003)(53936002)(6436002)(6116002)(3846002)(5660300001)(66066001)(1076002)(76176011)(14454004)(966005)(36756003)(3660700001)(6486002)(86612001)(81156014)(8676002)(81166006)(10290500003)(6512007)(8936002)(3280700002)(478600001)(107886003)(106356001)(6306002)(105586002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB0924;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec376a44-5234-4649-85fa-08d58156fd27
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:29:17.4163
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0924
Return-Path: <Alexander.Levin@microsoft.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62797
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

From: Aleksandar Markovic <aleksandar.markovic@imgtec.com>

[ Upstream commit 411dac79cc2ed80f7e348ccc23eb4d8b0ba9f6d5 ]

Add missing clearing of BLTZALL and BGEZALL emulation counters in
function mipsr2_stats_clear_show().

Previously, it was not possible to reset BLTZALL and BGEZALL
emulation counters - their value remained the same even after
explicit request via debugfs. As far as other related counters
are concerned, they all seem to be properly cleared.

This change affects debugfs operation only, core R2 emulation
functionality is not affected.

Signed-off-by: Aleksandar Markovic <aleksandar.markovic@imgtec.com>
Reviewed-by: Paul Burton <paul.burton@imgtec.com>
Cc: james.hogan@imgtec.com
Cc: leonid.yegoshin@imgtec.com
Cc: douglas.leung@imgtec.com
Cc: petar.jovanovic@imgtec.com
Cc: miodrag.dinic@imgtec.com
Cc: goran.ferenc@imgtec.com
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/15517/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/mips/kernel/mips-r2-to-r6-emul.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/mips/kernel/mips-r2-to-r6-emul.c b/arch/mips/kernel/mips-r2-to-r6-emul.c
index 9a46e52864a1..9a4aed652736 100644
--- a/arch/mips/kernel/mips-r2-to-r6-emul.c
+++ b/arch/mips/kernel/mips-r2-to-r6-emul.c
@@ -2339,6 +2339,8 @@ static int mipsr2_stats_clear_show(struct seq_file *s, void *unused)
 	__this_cpu_write((mipsr2bremustats).bgezl, 0);
 	__this_cpu_write((mipsr2bremustats).bltzll, 0);
 	__this_cpu_write((mipsr2bremustats).bgezll, 0);
+	__this_cpu_write((mipsr2bremustats).bltzall, 0);
+	__this_cpu_write((mipsr2bremustats).bgezall, 0);
 	__this_cpu_write((mipsr2bremustats).bltzal, 0);
 	__this_cpu_write((mipsr2bremustats).bgezal, 0);
 	__this_cpu_write((mipsr2bremustats).beql, 0);
-- 
2.14.1

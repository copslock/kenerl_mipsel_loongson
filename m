Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Apr 2018 02:18:35 +0200 (CEST)
Received: from mail-bl2nam02on0090.outbound.protection.outlook.com ([104.47.38.90]:58093
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23990845AbeDIASAPOIdG convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 9 Apr 2018 02:18:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=zCSWzUfBLY0Su5NZfad5+Hcsa+K7dAOY//kz84S/KMw=;
 b=QoJmI/4qipt8QjCsCgwnc0ItydAnr6xysU7Jyak2rEKwcJtyy+5RkyIkut0GtIVnndfiCbGoy9QI/cpDBzqrcv7Nx7mihQdrrZH3CgxzIPeB9e8NDk7qR/44EsLkFN1dxMMQ0ysELYj/cVre2NHEII9D4FXM3AX5yTCbPU2xIyc=
Received: from DM5PR2101MB1032.namprd21.prod.outlook.com (52.132.128.13) by
 DM5PR2101MB1048.namprd21.prod.outlook.com (52.132.128.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.696.0; Mon, 9 Apr 2018 00:17:51 +0000
Received: from DM5PR2101MB1032.namprd21.prod.outlook.com
 ([fe80::8109:aef0:a777:7059]) by DM5PR2101MB1032.namprd21.prod.outlook.com
 ([fe80::8109:aef0:a777:7059%2]) with mapi id 15.20.0696.003; Mon, 9 Apr 2018
 00:17:51 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Maarten ter Huurne <maarten@treewalker.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 049/189] MIPS: JZ4770: Work around config2
 misreporting associativity
Thread-Topic: [PATCH AUTOSEL for 4.15 049/189] MIPS: JZ4770: Work around
 config2 misreporting associativity
Thread-Index: AQHTz5giXagKVaxq40mr6bifczxMig==
Date:   Mon, 9 Apr 2018 00:17:24 +0000
Message-ID: <20180409001637.162453-49-alexander.levin@microsoft.com>
References: <20180409001637.162453-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001637.162453-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1048;7:z+f+9+qGDRgQNjyAH7sEMBhvrwb9OP0Xa+7Lxs5CnSc/19lTJUwUX5O7S75MI9XsKfTBJvrga5T3I/lIccCjgdLfQbIZSUbKShp2CTc8TxIRdi09NOqTsuqboZIBAQjUBIwm7X0/Wch/QB9XegnkbY7xwtg6m6DhwhgHliLXT/jDfAZr1tDHB2BgZOiUt8dRFsfHnXSE6FzXI1QiZZNqriQGH2wkrU8H/fiDbHnZo/OUZGOIi3AcNKm6J7+J+1Bs;20:/4H6aENg+Uo/3jtIqWm1qjqZAIpYpItfLMgmyS/xgC8NJkwIwp3tlyu2Ln2SVVkjZxA3MeeonmJlApndw3PPCi0L5Z8148Kcp6anEBTJF7zFE3ULpFZCcpfkGtnL/iyzxT+LXw4CeHFz5iksZegKPVVKra+1hlddSbWQWp/ole8=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: a536cbe3-5353-4971-7d2b-08d59daf54d9
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1048;
x-ms-traffictypediagnostic: DM5PR2101MB1048:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <DM5PR2101MB10489C1FC6BAAFE14DBDE698FBBF0@DM5PR2101MB1048.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB1048;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1048;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39380400002)(376002)(39860400002)(346002)(396003)(189003)(199004)(86362001)(1076002)(575784001)(99286004)(6116002)(110136005)(3846002)(54906003)(22452003)(3280700002)(105586002)(2906002)(76176011)(4326008)(6512007)(6436002)(6486002)(3660700001)(6666003)(7736002)(86612001)(25786009)(2900100001)(14454004)(97736004)(6306002)(53936002)(107886003)(68736007)(102836004)(966005)(36756003)(6506007)(26005)(186003)(106356001)(305945005)(5250100002)(72206003)(478600001)(2501003)(10290500003)(81166006)(5660300001)(8676002)(66066001)(316002)(81156014)(2616005)(10090500001)(11346002)(446003)(476003)(8936002)(486006)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1048;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: dPonDHnFdlqxKHpwFT8N/cv/tlO4pez2eFheoHWpfpiD1Bc+qPivkLB/yJJHyHoJMp0h1KBzgnCZ9JQAdmvG7jlD09s+f+HW6ZQN6/fKqrZQh/+8YogU2hi3jd8niwKFkh06N3G5eno6lzNODqgGtHmRqze0DTkm9CGe3Zs/A5gkXvNZuo2vgXrjywwmsvEVSo2vO3zoniAljstklnBi7hzh9WQOqfPo42/MO1mGePhL0wBKnjEbTr2W63F0Go3VkgeGMSsHrT2DigjVN2gTA6Ba+sIZ3ivM9xDrJwiPIfZuu5ft3YPueWFDxZz/vxwncmfvm+e4c9aztJ8chJ+Ah/qTdOLx14VxbOeiYOpzUmaKN+J+HHpOu6pH0Be4et4AqNs/cYkgxa7KKp9PHqY70FR30eyED+XvHp0pGwExS20=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a536cbe3-5353-4971-7d2b-08d59daf54d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:17:24.8850
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1048
Return-Path: <Alexander.Levin@microsoft.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63434
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

From: Maarten ter Huurne <maarten@treewalker.org>

[ Upstream commit 1f7412e0e2f327fe7dc5a0c2fc36d7b319d05d47 ]

According to config2, the associativity would be 5-ways, but the
documentation states 4-ways, which also matches the documented
L2 cache size of 256 kB.

Signed-off-by: Maarten ter Huurne <maarten@treewalker.org>
Reviewed-by: James Hogan <jhogan@kernel.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/18488/
Signed-off-by: James Hogan <jhogan@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/mips/mm/sc-mips.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/mips/mm/sc-mips.c b/arch/mips/mm/sc-mips.c
index 548acb7f8557..394673991bab 100644
--- a/arch/mips/mm/sc-mips.c
+++ b/arch/mips/mm/sc-mips.c
@@ -16,6 +16,7 @@
 #include <asm/mmu_context.h>
 #include <asm/r4kcache.h>
 #include <asm/mips-cps.h>
+#include <asm/bootinfo.h>
 
 /*
  * MIPS32/MIPS64 L2 cache handling
@@ -220,6 +221,14 @@ static inline int __init mips_sc_probe(void)
 	else
 		return 0;
 
+	/*
+	 * According to config2 it would be 5-ways, but that is contradicted
+	 * by all documentation.
+	 */
+	if (current_cpu_type() == CPU_JZRISC &&
+				mips_machtype == MACH_INGENIC_JZ4770)
+		c->scache.ways = 4;
+
 	c->scache.waysize = c->scache.sets * c->scache.linesz;
 	c->scache.waybit = __ffs(c->scache.waysize);
 
-- 
2.15.1

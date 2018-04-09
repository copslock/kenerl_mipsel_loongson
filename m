Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Apr 2018 02:34:59 +0200 (CEST)
Received: from mail-bl2nam02on0090.outbound.protection.outlook.com ([104.47.38.90]:4608
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992821AbeDIAeqkYImV convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 9 Apr 2018 02:34:46 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=abk/t97z6otuh2ezEBD2jA/G4fkHfRpZr1K5KX2I8DY=;
 b=XQBIaOD+gsg+9yTmd+yQ6x4lD706SwbJ1ODu1TidxwV23rlRuMrwOGHqgRVKsqzwSXKrD9QuvH/Xju8gB/FwzWc74G9kW86T4VpwALW1B7tQOggQxehidIM0TAcstgOPEU0Z5nSLtEGCuwdR560kDqyHaO7uqNLjhP3RUe38qww=
Received: from DM5PR2101MB1032.namprd21.prod.outlook.com (52.132.128.13) by
 DM5PR2101MB0984.namprd21.prod.outlook.com (52.132.133.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.696.0; Mon, 9 Apr 2018 00:34:36 +0000
Received: from DM5PR2101MB1032.namprd21.prod.outlook.com
 ([fe80::8109:aef0:a777:7059]) by DM5PR2101MB1032.namprd21.prod.outlook.com
 ([fe80::8109:aef0:a777:7059%2]) with mapi id 15.20.0696.003; Mon, 9 Apr 2018
 00:34:36 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 273/293] MIPS: generic: Fix machine compatible
 matching
Thread-Topic: [PATCH AUTOSEL for 4.9 273/293] MIPS: generic: Fix machine
 compatible matching
Thread-Index: AQHTz5lmdt4YVIsUjU+kcyHKjtv2vQ==
Date:   Mon, 9 Apr 2018 00:26:28 +0000
Message-ID: <20180409002239.163177-273-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0984;7:UVUruND/xWV4TnLZPpWOu7Mw5y8CrrD7qcNIzZXEzgu4hX+UZDg/utGRnbbkx0dldxbYH25daLaE4ASxUj+7iFYABnzfWRQjM40XK/ynvxocX7lWjzYNCLAzuNRd6XacufCgJzQPC9gOhSta3u3WFI2MVOm/qlk0CBQAoYqZvt3szyZECO048J7cbZVFjip1B5bfIURO886XIoFOnyE3KLuriF1RLajdf4aKZRGYPO5R0j9rdvdVTAskaDv9I/3r;20:Rqul0AISHVng6xU0RJMqMC7MghCXUqAWT0VU+Bh9u7VAkx2GIFgMFLht4M9O9OJ5mzy3sax0nzIVWEYkEUvoDOKgVuJtxpP6B0A2yGbRnzQf5H/EjWMkWXiDmAUAjv6OP9TjrM4qOihjcc/DYB0w5+vJ7jx/1Vc6iegEa6arSkU=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8bf8880a-d21f-46e8-88d3-08d59db1ac26
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0984;
x-ms-traffictypediagnostic: DM5PR2101MB0984:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <DM5PR2101MB098473D0F754DB324551F631FBBF0@DM5PR2101MB0984.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0984;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0984;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(366004)(39380400002)(346002)(376002)(199004)(189003)(26005)(99286004)(2906002)(14454004)(97736004)(59450400001)(8676002)(81156014)(81166006)(8936002)(6512007)(106356001)(76176011)(186003)(3280700002)(10090500001)(36756003)(6506007)(66066001)(3660700001)(72206003)(478600001)(6666003)(53936002)(2900100001)(105586002)(102836004)(966005)(2501003)(110136005)(54906003)(5250100002)(486006)(1076002)(25786009)(6116002)(6436002)(11346002)(6486002)(22452003)(4326008)(446003)(7736002)(575784001)(86362001)(305945005)(2616005)(476003)(6306002)(68736007)(3846002)(86612001)(5660300001)(10290500003)(107886003)(316002)(22906009)(41533002)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0984;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: bvd0C0rkVCR9Mf1fs+U80JCF/gVE9ubLEiHT1bBbJY8SGHoDDIQzXMtrgdvaHar35shBIC7zhr9gU9rnEsv1kQSTSlwtwkRfl9FqlAPJDXUqmUuiQrIe7VaF9xIVuCbTTcZbIM4mM/VfX2EHuwN8d0LIjkdadqjZmf37JcQ4SB1YKeVFD7peMe6d/Sm3ZCq4yOfpp3ouZR8LRkY1wqmpe5XfKQ60CCtI6oGIpw2+Ex54uWcayl0kDoOFWVG+9rnlDp69O4gXyZa9LTp74npi93OOzdRRX/23x4sHGT1uG+n+HmmzN0ELXej/xemIUgLSjUl2PQ7BU1MsrEPv9rCRDFTo043X60AKDsLa905CWeLXtHxmJVB68CpvMVPbPmvVDK6oRuxw6NYG2X6yHguP6l6svX6+d8DbpWViv9TJzDE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bf8880a-d21f-46e8-88d3-08d59db1ac26
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:26:28.7539
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0984
Return-Path: <Alexander.Levin@microsoft.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63457
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

From: James Hogan <jhogan@kernel.org>

[ Upstream commit 9a9ab3078e2744a1a55163cfaec73a5798aae33e ]

We now have a platform (Ranchu) in the "generic" platform which matches
based on the FDT compatible string using mips_machine_is_compatible(),
however that function doesn't stop at a blank struct
of_device_id::compatible as that is an array in the struct, not a
pointer to a string.

Fix the loop completion to check the first byte of the compatible array
rather than the address of the compatible array in the struct.

Fixes: eed0eabd12ef ("MIPS: generic: Introduce generic DT-based board support")
Signed-off-by: James Hogan <jhogan@kernel.org>
Reviewed-by: Paul Burton <paul.burton@mips.com>
Reviewed-by: Matt Redfearn <matt.redfearn@mips.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/18580/
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/mips/include/asm/machine.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/machine.h b/arch/mips/include/asm/machine.h
index 6b444cd9526f..db930cdc715f 100644
--- a/arch/mips/include/asm/machine.h
+++ b/arch/mips/include/asm/machine.h
@@ -52,7 +52,7 @@ mips_machine_is_compatible(const struct mips_machine *mach, const void *fdt)
 	if (!mach->matches)
 		return NULL;
 
-	for (match = mach->matches; match->compatible; match++) {
+	for (match = mach->matches; match->compatible[0]; match++) {
 		if (fdt_node_check_compatible(fdt, 0, match->compatible) == 0)
 			return match;
 	}
-- 
2.15.1

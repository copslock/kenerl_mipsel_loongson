Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 02 Sep 2018 15:07:05 +0200 (CEST)
Received: from mail-co1nam05on0712.outbound.protection.outlook.com ([IPv6:2a01:111:f400:fe50::712]:42976
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993067AbeIBNHBTS9gR convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 2 Sep 2018 15:07:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NAkjcfewxpI2QlG19WEufUMyDX8xZOWLvvRwYidC080=;
 b=nBnGDsq+vLLa4rF2FSna00DuepTOqMMCvnLTgc2061UT9UsI13l6H9s4ahYArMNdZaaabHlKoAM3s8BF0NxMkoINO4T3X5S7etc6u0vi5f61U6Cy6y0upYvgvoBN+pvmlfBoPJPmpajZtH1Z9Q4k0ODUdKlSgbNLX23vqCw07Ec=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0822.namprd21.prod.outlook.com (10.173.192.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:06:18 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:06:18 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        Paul Burton <paul.burton@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 128/131] MIPS: WARN_ON invalid DMA cache
 maintenance, not BUG_ON
Thread-Topic: [PATCH AUTOSEL 4.18 128/131] MIPS: WARN_ON invalid DMA cache
 maintenance, not BUG_ON
Thread-Index: AQHUQr2o0cW1N74qFUON7rFlHO4Ggw==
Date:   Sun, 2 Sep 2018 13:05:44 +0000
Message-ID: <20180902064601.183036-128-alexander.levin@microsoft.com>
References: <20180902064601.183036-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902064601.183036-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0822;6:pjuC7Br13qdD3rAmGW/z+P/9mODf3woWAAVHbZisOaC1HIZ4V5oXmW6vY0NenHXgIGk4s1PumexjzUUqcnVYq0hjWQwdl8pEZtnlH+BxiHKbdOTnaotm4yxtKLEC/HhFl8YzC09T5LrsIWhA1Ho7B8p44xUBJuIHJdo3qvko3a8UV1k7knXJyn8OjuJujjO02iHzQjkIgZvqbEYUutqSf8zrJMMycG4yjYZ/s5YaWR48c1jOeHfrS/uN1zindKOhncO7szVWHigc7kGGFDnLZEw8AMY8geh2CwswND1bbQ+uca1UEdSxjqbXvos2NOWMruk3p9u5HzkHAVghLl+O0ZIGn3GtNy8YI8rrvummCQZrC4JqrlmBqzMN8HBK9zyPkygUvok2gyvpePJ05jJSzn5w/K60vvziX8spPlNvPL0XRov1FY8dHljF7XKHSwGof3cu8pv0eK8RYHprEALBQg==;5:ZjatJU06p6ju15XD8Wv+mMnKHc6g7CRhDRHGD1ZL+GhktPOeCLA5+WyDhjmYCtt9wZyjxk4En/8LGA7qOFe9c+R/VNTChRxvUIca1o98XvZWMKrxSRnV2kBp4pzXi52Ab2Kh+6DyZi0meu8ksYrjr39yRsumffGXK873hglNAh8=;7:2d2c6ArcJmm2D1odpo5Q9CK7zL4BEl5yysUmb7EsIv8vBLdQH7n4eqxQXvX/ciB969sXmNJzGur+PB4RcZDuHeaZTavbpgCbTVNop1LJ6vR66+1lYYbJqvRRVE+H3IG7SN4DM4QavE95lMGZ3Z/NAzM7VPQcUvcLn9sjJ/fSy2enlvUTACw+1Kf4UzxoI5ddIQH/pWX60NNz1XZEx0Eh5aICVPaxjOMLvphdcwQZ1RKQFsYC0XRKVpZwjohC5Q66
x-ms-office365-filtering-correlation-id: 741cbd2e-b82a-4529-1282-08d610d4df79
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0822;
x-ms-traffictypediagnostic: CY4PR21MB0822:
x-microsoft-antispam-prvs: <CY4PR21MB0822AFB447C298C876B71F11FB0D0@CY4PR21MB0822.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3231340)(944501410)(52105095)(2018427008)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0822;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0822;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(346002)(136003)(366004)(39860400002)(189003)(199004)(256004)(14444005)(6512007)(486006)(86612001)(97736004)(68736007)(478600001)(446003)(11346002)(25786009)(8676002)(10090500001)(8936002)(2906002)(575784001)(110136005)(86362001)(107886003)(4326008)(186003)(26005)(6346003)(6306002)(76176011)(966005)(6486002)(53936002)(2616005)(476003)(72206003)(10290500003)(6506007)(81166006)(81156014)(66066001)(22452003)(99286004)(102836004)(5660300001)(217873002)(106356001)(2900100001)(1076002)(6666003)(7736002)(2501003)(14454004)(5250100002)(305945005)(3846002)(54906003)(36756003)(6436002)(105586002)(316002)(6116002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0822;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: Y1RMpUNHh4GbP1Qt2IBNDpnNrWVp94CdZwhN51mfEzNaeweSweXhnpY0nXwRTiEl8HmhRdyTgyhgokjGFSVoF/cMHTxz+TlzHogPYGfGqUcdPfSb19aOzuemLC7TDoFIK3SQ1lbEQ761AiJJ0IxzZFhiB/UlNkAO4w70cR7duJXHUqCSsBF0HdjjtMlW3yBKlED+T84+SH2js2dXeZT9g5OzlMzro4icR0ps3N9BttbY9/e9d/coaWnh4r0O2fV+uoRlKmMyFlOJBVDkKhh8KHlK3i57wHEa/olot7uxkPNcDa7h062iha+wBfd7IDBpYHWozlbkHROWmua1pERUedaMnMMMnPmQ+tWloGARz2g=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 741cbd2e-b82a-4529-1282-08d610d4df79
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:05:44.0169
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0822
Return-Path: <Alexander.Levin@microsoft.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65853
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

From: Paul Burton <paul.burton@imgtec.com>

[ Upstream commit d4da0e97baea8768b3d66ccef3967bebd50dfc3b ]

If a driver causes DMA cache maintenance with a zero length then we
currently BUG and kill the kernel. As this is a scenario that we may
well be able to recover from, WARN & return in the condition instead.

Signed-off-by: Paul Burton <paul.burton@mips.com>
Acked-by: Florian Fainelli <f.fainelli@gmail.com>
Patchwork: https://patchwork.linux-mips.org/patch/14623/
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/mips/mm/c-r4k.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
index e12dfa48b478..a5893b2cdc0e 100644
--- a/arch/mips/mm/c-r4k.c
+++ b/arch/mips/mm/c-r4k.c
@@ -835,7 +835,8 @@ static void r4k_flush_icache_user_range(unsigned long start, unsigned long end)
 static void r4k_dma_cache_wback_inv(unsigned long addr, unsigned long size)
 {
 	/* Catch bad driver code */
-	BUG_ON(size == 0);
+	if (WARN_ON(size == 0))
+		return;
 
 	preempt_disable();
 	if (cpu_has_inclusive_pcaches) {
@@ -871,7 +872,8 @@ static void r4k_dma_cache_wback_inv(unsigned long addr, unsigned long size)
 static void r4k_dma_cache_inv(unsigned long addr, unsigned long size)
 {
 	/* Catch bad driver code */
-	BUG_ON(size == 0);
+	if (WARN_ON(size == 0))
+		return;
 
 	preempt_disable();
 	if (cpu_has_inclusive_pcaches) {
-- 
2.17.1

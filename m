Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 Sep 2018 23:19:14 +0200 (CEST)
Received: from mail-sn1nam01on0133.outbound.protection.outlook.com ([104.47.32.133]:58775
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23994646AbeISVTDhRWj1 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 19 Sep 2018 23:19:03 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qISbC7gafU8iQ6T0l93TiYLBj4ZF6xxPx55Ou6cj9Ms=;
 b=Oq2ofjtm4l1hLfEPWFnmQStQsWueYuwrcFHTxxtEYGL3tg999/ycvKONIoax1l4bHofqZphnQFdfihtOwUkucOtPhZkpIrkbxRC+UMDnHIN/71ZCBoB/n8nRs/azXDJ0T0HpDLYz+ZhOnaK4v4GY0c1ZGXwx9XfsGvVW1NJKzpM=
Received: from BYAPR08MB4934.namprd08.prod.outlook.com (20.176.255.143) by
 BYAPR08MB4903.namprd08.prod.outlook.com (20.176.255.96) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.15; Wed, 19 Sep 2018 21:18:52 +0000
Received: from BYAPR08MB4934.namprd08.prod.outlook.com
 ([fe80::d9a4:818:86af:8981]) by BYAPR08MB4934.namprd08.prod.outlook.com
 ([fe80::d9a4:818:86af:8981%5]) with mapi id 15.20.1143.017; Wed, 19 Sep 2018
 21:18:52 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>
CC:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        Rene Nielsen <rene.nielsen@microsemi.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Paul Burton <pburton@wavecomp.com>,
        James Hogan <jhogan@kernel.org>
Subject: [PATCH 4.9] MIPS: VDSO: Match data page cache colouring when D$
 aliases
Thread-Topic: [PATCH 4.9] MIPS: VDSO: Match data page cache colouring when D$
 aliases
Thread-Index: AQHUUF5dQm27n2FBbUitQK1eMKj8GA==
Date:   Wed, 19 Sep 2018 21:18:52 +0000
Message-ID: <20180919211806.20868-1-paul.burton@mips.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: DM5PR06CA0060.namprd06.prod.outlook.com
 (2603:10b6:3:37::22) To BYAPR08MB4934.namprd08.prod.outlook.com
 (2603:10b6:a03:6a::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [4.16.204.77]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR08MB4903;6:3nuamCGBd5f4hg3MTQdNZwoAFde3aoHPiQSWQuLrHrACucwWVlzbu02TePpSmj8Cdqt+KnwNM5CNWXCfmLagR5aggt4AoJIHZE7duLHHrhuSc6THiVmDQu249Lw8u8zEK/fVmhs1mpjYT5/38reCy4BYw5avgvqCidHjdJdQ9fGZyLv+M3Hb+KWKeWUyVC0QD/zczPYUWZC0CFGAGZxCx92FnzYiMlFCfraWdOBhUNpTcY62P1FBZE7jzeGhKPMn5dTvctmvVyTb1azhKAR2RwbboH/lHywrCibpKpAjCg5gpIPyQi9p1WGmQn+EJb9isrX2IqJSbrJbkxhPauk3fFGgzkzODG2g3GdS3Pu05bECEJlGYzy51Zfn8m8q9MLFL8kEo31t4oetbn0FdtybLIcCyNrsM/Qy8e1E0GF0vgm5eJg6qx8ja+up9ovqg2myr3RDdooy5/3bH7DUb/DnZA==;5:OiRpJwzknfSvUu+sQq4LGW6LYIqSU7/IArY6QhMTD3WowLvyaSz5bmkN2PdYrmZjHF/4Dkr3cOO0+slVO1+QQKR/i3dY3J3mf+XZLjwF6P1B5wPHjVJprOpHeCtdkJFpCKFh7mu1g3JtnjlkixRO0Njt74Jgxe/PnHtg68G8M1c=;7:/3w24p7zG62HlQpM1JsDt83tbLDb5PBkYP/uBvQMG+Y5Fox7jfnQnISxbiQtoLbhs3vEVcofKCxqiiDmkAu0sOXoEdJtlK5PWet0XF63ssYNCMDSBoyVfS0PpW3GbzUlSenRnajVIzCv/AGwKwzI7YKhi7qzTA0pGrkzT6PGrTAJNoLmQibabgU0m2ZoXOI+YL4ePmNDyii1x6W2PnjKt8/dBOJF65OZ+Wk1dBRzSUsHaZRbAQvQmjV+NnaxmcyX
x-ms-office365-filtering-correlation-id: a2c87a18-fdf8-40d2-79b1-08d61e757f61
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR08MB4903;
x-ms-traffictypediagnostic: BYAPR08MB4903:
x-microsoft-antispam-prvs: <BYAPR08MB49033BB491D65C9E1A6DB777C11C0@BYAPR08MB4903.namprd08.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(190756311086443)(9452136761055)(72170198267865);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(3002001)(93006095)(10201501046)(149027)(150027)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(201708071742011)(7699051);SRVR:BYAPR08MB4903;BCL:0;PCL:0;RULEID:;SRVR:BYAPR08MB4903;
x-forefront-prvs: 0800C0C167
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39840400004)(376002)(346002)(396003)(136003)(199004)(189003)(42882007)(4326008)(5250100002)(53936002)(2616005)(44832011)(575784001)(1730700003)(81166006)(5640700003)(68736007)(5660300001)(486006)(105586002)(6436002)(8936002)(186003)(36756003)(6486002)(8676002)(7736002)(81156014)(26005)(2351001)(99286004)(316002)(2900100001)(2906002)(3846002)(102836004)(6116002)(106356001)(305945005)(6306002)(6506007)(476003)(386003)(54906003)(25786009)(52116002)(14454004)(478600001)(966005)(2501003)(14444005)(66066001)(256004)(6916009)(97736004)(6512007)(1076002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR08MB4903;H:BYAPR08MB4934.namprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: VCPyFfvuZGsv6w8qYwWJsWyWIiJVDJ9noGjBM+vXIb138sjXN2SYkY3gZFdEkZ/HZMQXqDPLlbDJ9OGSveHGryKIqtnoZzL9ewV4IvrJ9uIiBDp3Gt7USB19pNo4OyuQ5Ie43EQ9TGVoEbWuJCxF2AfwjUXWQyooxUZFXn0o772uL/vnxYSwHLI7NEwjnEr3Kb8W4XxV0dXsT+NU3HlkhiVQQhJQANX79mwuNyGZ/etjSHd9YU722oC2pJGok6+YWVdIVbp4vMyySKA7ScPDe+SQ0k8pUFoqHptxKsoXgxvo4ce5WYajxJkxWNEg7RF8GsgTu77Dvzc3Fu76477ER6fqQfTrBTYac0+YZps6phc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2c87a18-fdf8-40d2-79b1-08d61e757f61
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2018 21:18:52.3080
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR08MB4903
Return-Path: <pburton@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66413
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@mips.com
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

[ Upstream commit 0f02cfbc3d9e413d450d8d0fd660077c23f67eff ]

When a system suffers from dcache aliasing a user program may observe
stale VDSO data from an aliased cache line. Notably this can break the
expectation that clock_gettime(CLOCK_MONOTONIC, ...) is, as its name
suggests, monotonic.

In order to ensure that users observe updates to the VDSO data page as
intended, align the user mappings of the VDSO data page such that their
cache colouring matches that of the virtual address range which the
kernel will use to update the data page - typically its unmapped address
within kseg0.

This ensures that we don't introduce aliasing cache lines for the VDSO
data page, and therefore that userland will observe updates without
requiring cache invalidation.

Signed-off-by: Paul Burton <paul.burton@mips.com>
Reported-by: Hauke Mehrtens <hauke@hauke-m.de>
Reported-by: Rene Nielsen <rene.nielsen@microsemi.com>
Reported-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Fixes: ebb5e78cc634 ("MIPS: Initial implementation of a VDSO")
Patchwork: https://patchwork.linux-mips.org/patch/20344/
Tested-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Tested-by: Hauke Mehrtens <hauke@hauke-m.de>
Cc: James Hogan <jhogan@kernel.org>
Cc: linux-mips@linux-mips.org
Cc: stable@vger.kernel.org # v4.4+
---
 arch/mips/kernel/vdso.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/mips/kernel/vdso.c b/arch/mips/kernel/vdso.c
index f9dbfb14af33..e88344e3d508 100644
--- a/arch/mips/kernel/vdso.c
+++ b/arch/mips/kernel/vdso.c
@@ -14,12 +14,14 @@
 #include <linux/init.h>
 #include <linux/ioport.h>
 #include <linux/irqchip/mips-gic.h>
+#include <linux/kernel.h>
 #include <linux/mm.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
 #include <linux/timekeeper_internal.h>
 
 #include <asm/abi.h>
+#include <asm/page.h>
 #include <asm/vdso.h>
 
 /* Kernel-provided data used by the VDSO. */
@@ -129,12 +131,30 @@ int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
 	vvar_size = gic_size + PAGE_SIZE;
 	size = vvar_size + image->size;
 
+	/*
+	 * Find a region that's large enough for us to perform the
+	 * colour-matching alignment below.
+	 */
+	if (cpu_has_dc_aliases)
+		size += shm_align_mask + 1;
+
 	base = get_unmapped_area(NULL, 0, size, 0, 0);
 	if (IS_ERR_VALUE(base)) {
 		ret = base;
 		goto out;
 	}
 
+	/*
+	 * If we suffer from dcache aliasing, ensure that the VDSO data page
+	 * mapping is coloured the same as the kernel's mapping of that memory.
+	 * This ensures that when the kernel updates the VDSO data userland
+	 * will observe it without requiring cache invalidations.
+	 */
+	if (cpu_has_dc_aliases) {
+		base = __ALIGN_MASK(base, shm_align_mask);
+		base += ((unsigned long)&vdso_data - gic_size) & shm_align_mask;
+	}
+
 	data_addr = base + gic_size;
 	vdso_addr = data_addr + PAGE_SIZE;
 
-- 
2.18.0

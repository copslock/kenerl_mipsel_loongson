Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 Sep 2018 23:21:17 +0200 (CEST)
Received: from mail-eopbgr730116.outbound.protection.outlook.com ([40.107.73.116]:33870
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23994645AbeISVVLew8y1 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 19 Sep 2018 23:21:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=auGRcMOWA2U6UQnplj13Xl3V6WLXKfKHmdtr3IU+5Is=;
 b=JF4xVN5HknY2uFmKH1xq1IXm/KWG3Pg1AHLSXK9Um45XTGH8l5M9mO8Kb7RaNpDU0IhhDeeRDjGxAtdF4g8tysYzd9Pk0O+Z/nk09Fg8grBtmvYOjah7xt87O83gqPcUItFGDvPpkBhnw/Unjew+pt/BWfxJsaDvV6BDITPqWa4=
Received: from BYAPR08MB4934.namprd08.prod.outlook.com (20.176.255.143) by
 BYAPR08MB4744.namprd08.prod.outlook.com (20.176.255.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.15; Wed, 19 Sep 2018 21:20:59 +0000
Received: from BYAPR08MB4934.namprd08.prod.outlook.com
 ([fe80::d9a4:818:86af:8981]) by BYAPR08MB4934.namprd08.prod.outlook.com
 ([fe80::d9a4:818:86af:8981%5]) with mapi id 15.20.1143.017; Wed, 19 Sep 2018
 21:20:59 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>
CC:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        Rene Nielsen <rene.nielsen@microsemi.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Paul Burton <pburton@wavecomp.com>,
        James Hogan <jhogan@kernel.org>
Subject: [PATCH 4.4] MIPS: VDSO: Match data page cache colouring when D$
 aliases
Thread-Topic: [PATCH 4.4] MIPS: VDSO: Match data page cache colouring when D$
 aliases
Thread-Index: AQHUUF6pE6B0SyXeOEut08z/07jbjA==
Date:   Wed, 19 Sep 2018 21:20:59 +0000
Message-ID: <20180919212044.21385-1-paul.burton@mips.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: DM6PR08CA0032.namprd08.prod.outlook.com
 (2603:10b6:5:80::45) To BYAPR08MB4934.namprd08.prod.outlook.com
 (2603:10b6:a03:6a::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [4.16.204.77]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR08MB4744;6:flziwz+vKIAb3WbpuYdSJZhWI8AdtzHtsPb8WXmRe8GFzROwl7hzIXymV0QGWVrr+N3SBjXmLfZmf12/2r4rvTPzMdTHKm9/MsLs5RFbKthDkxF4pFGARsZoK4GDzdyV6aJPqUND3DfA1NHiBXp1GV8H/BXbLtsl4QssRBTVYvjvLBModJ6sGzYDsvj8Vt+6u44BSUVwGnze24ere9430DIhO0ONNh51FpylTGBKGOQuY4wb8FIUzZZV6kVqQS02AEm3yr0Fu76vpGJhY3O1pUVxwFpOY2+3dGN/1vtiqKugxrouNAxPZrbEIzstaIzQ6LH2qVGiL8U6+UmKseCc8WUzljEdk3H0tgMzn6HThP+eo/1k2ao6h6uUtsr8vxAbFuhbpWqLD2DyIfWQ0uC7U3MdhfL/kZhgciItczckJUMGEktTeNlmuefY8dhEkGvbctD/nivR9ecQynYIwC4B7w==;5:yAV7zAzqs1aEN1CLJ+EirnI862hlF69fZLVXSWs7ot9EnNpX0uiyUbyHhU2H6/ov/TX+x0+4xRz+jmzZDNHf8vuMlBUJHtxZx6bx5DFaGGgqCAt769XSLFXGEuSVXLF5zRY8zfMP4Vg0hOyk9jxo1/86VAqhwGeaDxS7sE+Vjd0=;7:nJjz87ZMXIhLVjBKC94HEB1XPxsco2laeItVkYimla9SD23NOPi7TbG8CBrwKwrgEqsAjxAVLaA0DTOWGnMbrC/9264CAeMvKZUaR0g6LeVEDO7ya8xlpS73rS/mtF2dNB4hRI5pi3qpfAUeM4co0I4uDQdz7HCV1C3LEGcCf62Qw2/qt9sv0Rp6F6VJJb7x9Udi+feUIZfskIwOHDWtr0lE0JK6fUq867FEg3ob4zFy9Z+dWhf8uoUre2t7kCXt
x-ms-office365-filtering-correlation-id: 9026da61-b1e1-4f73-3f9f-08d61e75cb63
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR08MB4744;
x-ms-traffictypediagnostic: BYAPR08MB4744:
x-microsoft-antispam-prvs: <BYAPR08MB47449F02494812059E3F0D5DC11C0@BYAPR08MB4744.namprd08.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(190756311086443)(9452136761055)(72170198267865);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(3002001)(3231355)(944501410)(52105095)(149027)(150027)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123560045)(201708071742011)(7699051);SRVR:BYAPR08MB4744;BCL:0;PCL:0;RULEID:;SRVR:BYAPR08MB4744;
x-forefront-prvs: 0800C0C167
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(376002)(39840400004)(136003)(366004)(189003)(199004)(99286004)(256004)(3846002)(6436002)(2351001)(14444005)(52116002)(1730700003)(386003)(305945005)(8676002)(5640700003)(478600001)(6916009)(186003)(486006)(6116002)(105586002)(476003)(68736007)(66066001)(44832011)(1076002)(6486002)(42882007)(2616005)(97736004)(81166006)(26005)(106356001)(53936002)(2906002)(6306002)(36756003)(6506007)(2501003)(7736002)(102836004)(2900100001)(316002)(54906003)(6512007)(81156014)(5660300001)(4326008)(8936002)(14454004)(5250100002)(575784001)(966005)(25786009);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR08MB4744;H:BYAPR08MB4934.namprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: O511UdKqzoUKRyerfHXHo0CPYRMKK4PNJTmACycv52SK+OA2v3yBblqs9xBzfAhAz90bke96bM2C39HFwhqSweC+BMzK9HOSRReIBoFXfWRI/Wa1KJyJP9CEl6P0Jq/IkkHsJolHCffo7dSbBofBz3UyRY+EbmGEZJCTPAuiLODuv6oCxEsjJp08W7hzq2nc6qwtQgsH4gyOb5vnytJcYQDEvAgZleMSRPyESgoKWu8gvHaHA1qpnQAlYDzxtnGQGbM/4UoLx6rDkjZMpOML7ZiFb75WxPjy0IDQUEi/YLT083NNoA1a0qVT51RmAB61J/wJvkFEj9GmAZjdY930PlIBEgOWLKn15eYlGz6vmEk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9026da61-b1e1-4f73-3f9f-08d61e75cb63
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2018 21:20:59.7314
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR08MB4744
Return-Path: <pburton@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66414
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
index 5649a9e429e0..aca06b18c43e 100644
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
@@ -118,12 +120,30 @@ int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
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

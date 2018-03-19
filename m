Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Mar 2018 17:14:22 +0100 (CET)
Received: from mail-cys01nam02on0098.outbound.protection.outlook.com ([104.47.37.98]:8473
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23994611AbeCSQOPRBZsD convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 19 Mar 2018 17:14:15 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=xQQaZFjLCc88D4oRJO7pP1safPqkWIwyxWZ1GmGADT0=;
 b=SUj0fp4eraY3fxXRr0ldz0GbzhefVFKkzo+fl6Fh0igrK7g2uKVr2as1XjcJt7R8VT2WBmtWvR2xPk1ITLOZHlkaUQ56YxNs4IV6HB2qk2PdOAVRoNfZcR7oAhDzPEyLL7LMdUCDVTMdsMUhDEFA9YaJm4Hs1A2eYeRZAkFogpU=
Received: from DM5PR2101MB1032.namprd21.prod.outlook.com (52.132.128.13) by
 DM5PR2101MB1063.namprd21.prod.outlook.com (52.132.128.39) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.631.0; Mon, 19 Mar 2018 16:14:05 +0000
Received: from DM5PR2101MB1032.namprd21.prod.outlook.com
 ([fe80::3d9b:79e7:94eb:5d62]) by DM5PR2101MB1032.namprd21.prod.outlook.com
 ([fe80::3d9b:79e7:94eb:5d62%5]) with mapi id 15.20.0631.004; Mon, 19 Mar 2018
 16:14:05 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC:     Marcin Nowakowski <marcin.nowakowski@imgtec.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 079/102] MIPS: mm: fixed mappings: correct
 initialisation
Thread-Topic: [PATCH AUTOSEL for 3.18 079/102] MIPS: mm: fixed mappings:
 correct initialisation
Thread-Index: AQHTv50rFVJBKHtdoUqWAsrBr3OyRw==
Date:   Mon, 19 Mar 2018 16:13:08 +0000
Message-ID: <20180319161117.17833-79-alexander.levin@microsoft.com>
References: <20180319161117.17833-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319161117.17833-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1063;7:pPxe/v7Qu+GC0PYvxcZb4MBYgft3FHWanNQG7WAcBNVUaKiIQ/w2nnbCtpwBPr32/GP3Wpd9lzEVf2EGX8EEiRWnQ8grBGwHstlOvldCee6BRI0uC8f5ZTk9F7mcXi1+nundTtiXHF4Ln5kGdqsHPAN9ZC2iIUVyXHM//v/lGGbvlABZGpNZaTR1KWiINU/dxtwS9vPVqVvvhNzUS1IpUIpB79y0vloD79DSJKDrj+/ZyxIXnfMGxp4r11uo41O3;20:fvzFaxro/dORDKhEnOJQwj+oiinC1E3U23k+0qLBVdQnLl6lCzelTnIYMpBmex6tuTPNisrVcb41eszr3xrdbJ7mNiXy6s+5rB4doVL+JdlmTSYJnTmxXl75CD1kBI3Dkp6bbFU5cY3ktKBfrQtx70YU47m9Xum+XsvIo024/rI=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d361c2cd-ed74-4a85-6a21-08d58db46fd4
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1063;
x-ms-traffictypediagnostic: DM5PR2101MB1063:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <DM5PR2101MB1063AE0CBCC61EEF08DC8DFEFBD40@DM5PR2101MB1063.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB1063;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1063;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(396003)(39860400002)(376002)(39380400002)(366004)(199004)(189003)(3846002)(6306002)(6116002)(8936002)(1076002)(8676002)(3280700002)(2501003)(5250100002)(81156014)(53936002)(81166006)(2906002)(5660300001)(86362001)(2900100001)(105586002)(22452003)(102836004)(6512007)(316002)(6506007)(66066001)(106356001)(14454004)(97736004)(99286004)(36756003)(2950100002)(107886003)(76176011)(10090500001)(7736002)(305945005)(10290500003)(72206003)(68736007)(478600001)(110136005)(966005)(3660700001)(25786009)(86612001)(26005)(6436002)(6486002)(186003)(4326008)(54906003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1063;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: +hL+qk1v0XHVI6RV/yRZBxdlZgXNxGI+EiNDR3lVQ4II7df65zalL2Lr6JajTXnuBc6mZeG0cctRKmkgDhwXxuJ9dbfIgUsShQXsQaPbA+nOytjEMaKFUeAY9LV5ZYX189bLqsV48e8lqPl3JUepDDA5VAwfrQJ7ZUQX4qC1gQYBhhfxGXQ3LXXoulBf91hXWnbty1rycPlF8m5P88UzyqZmW8zOF/4YwYh/ybybkTG9g7e1HOwnsNWmKMJMjrOmMhdtVbamsV+utihx/RyhLsL/CMNIxc8wjJs8XNFpbNfa/ZqbdXXjoqnjZTtUb0abMkDXLwmSgvykiXkhaLqe1g==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d361c2cd-ed74-4a85-6a21-08d58db46fd4
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:13:08.3813
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1063
Return-Path: <Alexander.Levin@microsoft.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63052
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

From: Marcin Nowakowski <marcin.nowakowski@imgtec.com>

[ Upstream commit 71eb989ab5a110df8bcbb9609bacde73feacbedd ]

fixrange_init operates at PMD-granularity and expects the addresses to
be PMD-size aligned, but currently that might not be the case for
PKMAP_BASE unless it is defined properly, so ensure a correct alignment
is used before passing the address to fixrange_init.

fixed mappings: only align the start address that is passed to
fixrange_init rather than the value before adding the size, as we may
end up with uninitialised upper part of the range.

Signed-off-by: Marcin Nowakowski <marcin.nowakowski@imgtec.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/15948/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/mips/mm/pgtable-32.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/mips/mm/pgtable-32.c b/arch/mips/mm/pgtable-32.c
index adc6911ba748..b19a3c506b1e 100644
--- a/arch/mips/mm/pgtable-32.c
+++ b/arch/mips/mm/pgtable-32.c
@@ -51,15 +51,15 @@ void __init pagetable_init(void)
 	/*
 	 * Fixed mappings:
 	 */
-	vaddr = __fix_to_virt(__end_of_fixed_addresses - 1) & PMD_MASK;
-	fixrange_init(vaddr, vaddr + FIXADDR_SIZE, pgd_base);
+	vaddr = __fix_to_virt(__end_of_fixed_addresses - 1);
+	fixrange_init(vaddr & PMD_MASK, vaddr + FIXADDR_SIZE, pgd_base);
 
 #ifdef CONFIG_HIGHMEM
 	/*
 	 * Permanent kmaps:
 	 */
 	vaddr = PKMAP_BASE;
-	fixrange_init(vaddr, vaddr + PAGE_SIZE*LAST_PKMAP, pgd_base);
+	fixrange_init(vaddr & PMD_MASK, vaddr + PAGE_SIZE*LAST_PKMAP, pgd_base);
 
 	pgd = swapper_pg_dir + __pgd_offset(vaddr);
 	pud = pud_offset(pgd, vaddr);
-- 
2.14.1

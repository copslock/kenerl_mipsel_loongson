Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Mar 2018 17:05:19 +0100 (CET)
Received: from mail-dm3nam03on0117.outbound.protection.outlook.com ([104.47.41.117]:28787
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23994611AbeCSQEzgGGsD convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 19 Mar 2018 17:04:55 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=w9WPyVHz2L1P6y577KPPbyrrnUQFZOgMyQ2ZXems+IY=;
 b=oePd5BLwEJokxr3v7cEmsGQfbJ7o2h8t8eb/zgFfy+UO5A/TdLrI5Jg5+W+tevmp3UsRi2kuAyMLKNdT9Q91z+p7axnYX7Djf4TgDeizoN0etUsmXaXwon9U6MDc5MKTyQP70u+2aodfZxs+oxW8fmU5NTQwMolsa/BUCmbQQdY=
Received: from DM5PR2101MB1032.namprd21.prod.outlook.com (52.132.128.13) by
 DM5PR2101MB0805.namprd21.prod.outlook.com (10.167.105.149) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.631.2; Mon, 19 Mar 2018 16:04:45 +0000
Received: from DM5PR2101MB1032.namprd21.prod.outlook.com
 ([fe80::3d9b:79e7:94eb:5d62]) by DM5PR2101MB1032.namprd21.prod.outlook.com
 ([fe80::3d9b:79e7:94eb:5d62%5]) with mapi id 15.20.0631.004; Mon, 19 Mar 2018
 16:04:45 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC:     Marcin Nowakowski <marcin.nowakowski@imgtec.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 224/281] MIPS: mm: adjust PKMAP location
Thread-Topic: [PATCH AUTOSEL for 4.9 224/281] MIPS: mm: adjust PKMAP location
Thread-Index: AQHTv5uo8WEq5/JaF0yBgQ2Fs7PATw==
Date:   Mon, 19 Mar 2018 16:02:19 +0000
Message-ID: <20180319155742.13731-224-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0805;7:uESDOAS+ofI5CqfFOkKF/t2MOQWI+6kQA8YFkq7aGJOAzLpa0U37xmXXxDfjs5HqRukJFn9JfLkbZUQdvamMgCC9OOTTUF1+A0I2Ocep7jzq9hVCFvoKfwE/Su4i9QO5xLYAgll2iIOTbnhUAAp1Gxa7ZGCnETdFWrOt+87pOWFeln0tKsH3nM3yhJsbMz3iU962k2ZmWsXwgoLjo+K/zQcHFbTAXejEe2rMuJIppfrHuEF65G3WywoURG+bcxD5;20:OVzQzvFHnUdURHHxaA24G+KDHNLbxSwGP668NnmssIXQkUSYMs+sDC0gMaMFT8PPmyO9gZvLdiJU5dS1L/ijPmyuzFajp7Zvf2DM+AKslaxUYHIh2Ug35XxKn2seKP76HC+X+6WN7WzRwubrSOUb/sxlb6QX7wLAzaS/d3RQcDY=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c083a0b1-9eaa-4e69-e009-08d58db32258
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0805;
x-ms-traffictypediagnostic: DM5PR2101MB0805:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <DM5PR2101MB0805C9FD3FDC8CFF57219611FBD40@DM5PR2101MB0805.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231221)(944501300)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0805;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0805;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(39860400002)(346002)(376002)(39380400002)(199004)(189003)(54906003)(3280700002)(316002)(966005)(66066001)(22452003)(10290500003)(4326008)(6306002)(6512007)(72206003)(478600001)(25786009)(107886003)(53936002)(2501003)(5250100002)(36756003)(76176011)(106356001)(110136005)(97736004)(99286004)(26005)(1076002)(8936002)(3846002)(2950100002)(86362001)(186003)(305945005)(575784001)(3660700001)(5660300001)(6116002)(6666003)(6506007)(59450400001)(102836004)(81156014)(81166006)(10090500001)(105586002)(8676002)(14454004)(6436002)(2900100001)(6486002)(7736002)(68736007)(86612001)(2906002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0805;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: XuJcK+7BGFNSsriVlGA3BAlFLDV0UFz5fQkqC5AOfaRwg/z5BnrTkNCgYFIjNu7PFe+7zcgavObsrT0V0+VGSsPHICAt/mcShCbAsuydAyRz6DDGNj/Urno6oCMKfajNEZIlglv6f6DU/bux4lo1a2jCzCLK2vISMPmaLOEuqjvcow6K/eKLzt8b1JL84FsdK6WcUwg5l63JrzO8032d9+bRUGSkzWV4YZYhghUG4f8pMbfNM/KwJhT1PyX935B1bY1yDL5Tkzc4pr+8+pjKKyr0FOZcMdA1uZaIkIdaCzihB+vYBJpUxi/qpykcnUwOrCNZoihjQC9l3T8B/tB6/w==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c083a0b1-9eaa-4e69-e009-08d58db32258
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:02:19.3076
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0805
Return-Path: <Alexander.Levin@microsoft.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63047
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

[ Upstream commit c56e7a4c3e77f6fbd9b55c06c14eda65aae58958 ]

Space reserved for PKMap should span from PKMAP_BASE to FIXADDR_START.
For large page sizes this is not the case as eg. for 64k pages the range
currently defined is from 0xfe000000 to 0x102000000(!!) which obviously
isn't right.
Remove the hardcoded location and set the BASE address as an offset from
FIXADDR_START.

Since all PKMAP ptes have to be placed in a contiguous memory, ensure
that this is the case by placing them all in a single page. This is
achieved by aligning the end address to pkmap pages count pages.

Signed-off-by: Marcin Nowakowski <marcin.nowakowski@imgtec.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/15950/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/mips/include/asm/pgtable-32.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/pgtable-32.h b/arch/mips/include/asm/pgtable-32.h
index d21f3da7bdb6..c0be540e83cb 100644
--- a/arch/mips/include/asm/pgtable-32.h
+++ b/arch/mips/include/asm/pgtable-32.h
@@ -18,6 +18,10 @@
 
 #include <asm-generic/pgtable-nopmd.h>
 
+#ifdef CONFIG_HIGHMEM
+#include <asm/highmem.h>
+#endif
+
 extern int temp_tlb_entry;
 
 /*
@@ -61,7 +65,8 @@ extern int add_temporary_entry(unsigned long entrylo0, unsigned long entrylo1,
 
 #define VMALLOC_START	  MAP_BASE
 
-#define PKMAP_BASE		(0xfe000000UL)
+#define PKMAP_END	((FIXADDR_START) & ~((LAST_PKMAP << PAGE_SHIFT)-1))
+#define PKMAP_BASE	(PKMAP_END - PAGE_SIZE * LAST_PKMAP)
 
 #ifdef CONFIG_HIGHMEM
 # define VMALLOC_END	(PKMAP_BASE-2*PAGE_SIZE)
-- 
2.14.1

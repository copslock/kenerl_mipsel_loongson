Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Mar 2018 17:11:14 +0100 (CET)
Received: from mail-sn1nam02on0099.outbound.protection.outlook.com ([104.47.36.99]:9248
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23994658AbeCSQKxXZgvD convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 19 Mar 2018 17:10:53 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=Jf9F9btYzjAAzg9fJFPNg8Yki1nclgyQ7G43C+Le64c=;
 b=NeR/ZIXeFYnmjWE7AtCEhqgWJ62I2AqezWwRqHrj04Qc4qi+ABWZoH6R8JCrxl7v7gUBbyivGJMIm+pKIpT01tGn4XRnjJJ9/Z008+hxVLmrIbg0KKRv3ZHQG7qvjf4GbNLH6D/hO0tUNP7IlaNXZ5Oc+Uuj1okevCGw/09qJx0=
Received: from DM5PR2101MB1032.namprd21.prod.outlook.com (52.132.128.13) by
 DM5PR2101MB1095.namprd21.prod.outlook.com (52.132.130.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.631.0; Mon, 19 Mar 2018 16:10:42 +0000
Received: from DM5PR2101MB1032.namprd21.prod.outlook.com
 ([fe80::3d9b:79e7:94eb:5d62]) by DM5PR2101MB1032.namprd21.prod.outlook.com
 ([fe80::3d9b:79e7:94eb:5d62%5]) with mapi id 15.20.0631.004; Mon, 19 Mar 2018
 16:10:42 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC:     Marcin Nowakowski <marcin.nowakowski@imgtec.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 136/167] MIPS: mm: adjust PKMAP location
Thread-Topic: [PATCH AUTOSEL for 4.4 136/167] MIPS: mm: adjust PKMAP location
Thread-Index: AQHTv5x7PZsTsYQjY0i42w5FsRTaPw==
Date:   Mon, 19 Mar 2018 16:08:13 +0000
Message-ID: <20180319160513.16384-136-alexander.levin@microsoft.com>
References: <20180319160513.16384-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319160513.16384-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1095;7:KVwj07RosKMq5rOBgNKRSDdXGpkP/iFsVMmRLVqR4dFJWAbBmQAP7e2x6J2Q3Zg+7STq2PGDR+FuuSPZUIv2wkqtA3NJCLmzNIQ5wvGrbBF9JTHBPMi1/bhoT7L5HY+dafOqB59u0HTyV/z4rvKbnJPeIms10MAirE2OHmTa1ibB+mIbEFlwC2wAqDr2oOSLFepraQ1ukIeMGySpcVvqkthlPajBwWqgLo7aFaI/s2AWyWHohGhWGR6cNnKvXIqo;20:LPvx5kui++sv9qnBEdVuQPeg7OwLsJpCzxpQM4wVQUC6Em4jixAJX7JWfTwcLUocWWHMYS1fHfm+WleQYIs6BM5m9PsgbAdTda9ZzrPcgh/91jKAY4Ro4oFEvixY/45sVmbugU/5I782oHGUikICoV1fYu4T0HpbwCm1NXDr7EI=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8c238b48-a04e-4023-4df5-08d58db3f6af
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1095;
x-ms-traffictypediagnostic: DM5PR2101MB1095:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <DM5PR2101MB10950DE52D3F3CF41F7515EFFBD40@DM5PR2101MB1095.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB1095;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1095;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(366004)(39860400002)(396003)(39380400002)(189003)(199004)(305945005)(316002)(1076002)(7736002)(14454004)(86612001)(25786009)(8936002)(2950100002)(110136005)(66066001)(186003)(10090500001)(6666003)(5250100002)(2501003)(99286004)(76176011)(86362001)(4326008)(68736007)(3660700001)(105586002)(8676002)(81166006)(81156014)(106356001)(3280700002)(72206003)(10290500003)(478600001)(2900100001)(966005)(59450400001)(97736004)(54906003)(6512007)(6306002)(53936002)(6506007)(102836004)(6436002)(5660300001)(6486002)(107886003)(26005)(2906002)(22452003)(6116002)(3846002)(36756003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1095;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: RCTYDg/GVTlYV2DwAqU7Sp9+HlrxYySSDSB/9pb2Zh1IM7Pz3s4dt3wbrdvBRaae4LHbkE0QxTSWTGKaAGKuzm6nqhZjAutE2jcF2w7Xq1B/vqUmE8CEn7nc7RiGY/o62wJjF0FwDf2LEQ06YI7Cb/FlTiu2q1OWKpoq1EEcuKxYjyiaSoLDx0e6VmOXJnXuMguYkvpYquXcT0LfqH5OR4spwl0sTJZj+ImN7WCXTVf12X7NcPcnuOkHmyZoCf1UGvWZMBvQsjhBU3keFKQZXjOgJeOWmPVpp8Lu+VIXIue41DX0hEndw6sSBW05690ifudg5u8JCBj2R+wKDBaYmQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c238b48-a04e-4023-4df5-08d58db3f6af
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:08:13.6668
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1095
Return-Path: <Alexander.Levin@microsoft.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63050
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
index 832e2167d00f..ef7c02af7522 100644
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

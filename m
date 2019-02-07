Return-Path: <SRS0=1crz=QO=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51D3EC282C2
	for <linux-mips@archiver.kernel.org>; Thu,  7 Feb 2019 19:07:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01727218D3
	for <linux-mips@archiver.kernel.org>; Thu,  7 Feb 2019 19:07:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="EJicR3HX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbfBGTHI (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Thu, 7 Feb 2019 14:07:08 -0500
Received: from mail-eopbgr720098.outbound.protection.outlook.com ([40.107.72.98]:12566
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726774AbfBGTHI (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Thu, 7 Feb 2019 14:07:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fxq5HHn9BHdIGho29fKZw0Oy05x/zK/cSTxmaWBhoHs=;
 b=EJicR3HX2TVOdvf2xxnvqodsv27eHpxgt7z4g18+j6dYCv/at2+EeOXyW4MngPr3FWgMAPHkMrzM71cCUw5A1uDzHSfjj3/Prq9H6Gt/DyTCd/EYywF2Ge6m+f2XwLhk2vrQYoLNxdCcTJ0svwUHdqLbVT7nAcA9zkAQ+FeN+Mc=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1216.namprd22.prod.outlook.com (10.174.161.149) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.17; Thu, 7 Feb 2019 19:07:04 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::7d5e:f3b0:4a5:4636]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::7d5e:f3b0:4a5:4636%9]) with mapi id 15.20.1580.019; Thu, 7 Feb 2019
 19:07:04 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>
CC:     Paul Burton <pburton@wavecomp.com>,
        Davidlohr Bueso <dave@stgolabs.net>
Subject: [PATCH] MIPS: Delete unused flush_cache_sigtramp()
Thread-Topic: [PATCH] MIPS: Delete unused flush_cache_sigtramp()
Thread-Index: AQHUvxhPZn12Pifqsk2N48ZYPYnNIA==
Date:   Thu, 7 Feb 2019 19:07:04 +0000
Message-ID: <20190207190646.10962-1-paul.burton@mips.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR05CA0089.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::30) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.20.1
x-originating-ip: [67.207.99.198]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1216;6:I+ChtvomMW2b/vyw6GHTQGu2hI31GP1jLUVvPyOAwKDMLrSXid7x2Quw703ls6UXIOkBUVWeGJk4zuX1YVmPwjvkLElM07ryiCEZRoTF/OnKFWtJ3swPwTlOj6240E+qCROK373OnAIQAAV4g6qBoEPPLzBEmCUtzl93p6dnbmOYpDhLTd9WXSCQymOv6s6vFq4DP0kMg5CYLwzwCV/JPa8PjVYvTxQqR9iIW7wSIvDK4ygCWL5uXDHT/jImxs4Gn6MqV7cDWrKvAmaFkEaoE3eavzje/FO5OfhJPF0oxX+/MzYDofF6Sawwb4YGbVKDC10rvOrCd8bYWFN8nfZcyBc5p3+Xz5yXpTae/62aTq+caykt80SBmt2JXBqgclpcQoIt2C6DMRmjkys3v97aXWYsMEfEKENWd7kDVKqLWJ9LokkPYTZ2aszvbPGL5Wb/xp4PtYFl2KQOQUKbCK408w==;5:NLeZyaZE6Ndq/3c8/qrvU7zzQxBQkdfvtMCdEoE/bWa6dFuydU6Bo9zZT5zYeM46ElnxWfz7MU6FOtQVeAI7ZBfwmSQT4Q4gYpPWwQkjvDq/ujqU/5sAwJMIQPfysNe50Sp5RlmgKRiVBAMXUNizXCLWKSVLO1w13mZ2zAzjTxW3bB9KB2TkmVpEs8CduysU4LyD6+WGkLm7WuX7ytnVHw==;7:bOQ+FrjL8CNCTQnlUnfMXD4KbBgCQR9nUI6d9CjxT26TV6XYugWdMf0UKywmnDiLyP/Ky61YAy5hQCp+yVe4nQUM/kTQ+vHr+SIqW3NkJEfVxvFh/kaBpCw6mdEOS0QBFxMnY8Nj3ft+jfPanzBH7g==
x-ms-office365-filtering-correlation-id: 91a5467e-3c97-4f04-d109-08d68d2f722a
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1216;
x-ms-traffictypediagnostic: MWHPR2201MB1216:
x-microsoft-antispam-prvs: <MWHPR2201MB12166FFE0D35700F5DFB8954C1680@MWHPR2201MB1216.namprd22.prod.outlook.com>
x-forefront-prvs: 0941B96580
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(396003)(39840400004)(346002)(366004)(376002)(189003)(199004)(54906003)(105586002)(2906002)(106356001)(186003)(1076003)(81156014)(71190400001)(71200400001)(25786009)(42882007)(81166006)(36756003)(6116002)(6486002)(102836004)(8676002)(476003)(3846002)(44832011)(2616005)(486006)(386003)(6506007)(68736007)(8936002)(316002)(52116002)(6436002)(66066001)(2501003)(4326008)(6512007)(50226002)(478600001)(5640700003)(14454004)(53936002)(2351001)(26005)(7736002)(305945005)(99286004)(97736004)(14444005)(256004)(6916009);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1216;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 3aFbtF5NKHW2NDuX2vt0ig8UQCFkwEspCYg0XQjnpFwojiaTMSGq4u+lq+dtG0slwUaBVRy92oPLvPfKJPthv7k4WdfLtEdW32PcS40cJ3uVrXkLXnaY5NtufTV5EbY41d9ZnKgdzElQKr0aNs7i1qG9/0HWNqupxwfrlCtwatzjvGwNHb2Z8zkUbiqBkunYJoce2zEnpjZligQW9UZwyvduacZtuj4WuhQKOHlhLp9l2PF2R+Zp2o7QaYsECJqBCK0y9Cd3vaJyiDo5VfVUvwYQRJp48TMcTSUgTdT9insatqEoCpoGVyXNIWJVP4IaHkwA0HjpeOflu8XVucpezchF3POHJrE0897Mf/3HVFuf7odi0D/qP+66shte9E1D790dCVLKYugypenKQfeMsZix8EsrXHQKCNIctWnDYyo=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91a5467e-3c97-4f04-d109-08d68d2f722a
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2019 19:07:03.6570
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1216
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

Commit adcc81f148d7 ("MIPS: math-emu: Write-protect delay slot emulation
pages") left flush_cache_sigtramp() unused. Delete the dead code.

Signed-off-by: Paul Burton <paul.burton@mips.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>
---

 arch/mips/include/asm/cacheflush.h |   2 -
 arch/mips/mm/c-octeon.c            |  18 -----
 arch/mips/mm/c-r3k.c               |  25 -------
 arch/mips/mm/c-r4k.c               | 116 -----------------------------
 arch/mips/mm/c-tx39.c              |  21 ------
 arch/mips/mm/cache.c               |   1 -
 6 files changed, 183 deletions(-)

diff --git a/arch/mips/include/asm/cacheflush.h b/arch/mips/include/asm/cac=
heflush.h
index 4812d1fed0c2..d687b40b9fbb 100644
--- a/arch/mips/include/asm/cacheflush.h
+++ b/arch/mips/include/asm/cacheflush.h
@@ -25,7 +25,6 @@
  *
  * MIPS specific flush operations:
  *
- *  - flush_cache_sigtramp() flush signal trampoline
  *  - flush_icache_all() flush the entire instruction cache
  *  - flush_data_cache_page() flushes a page from the data cache
  *  - __flush_icache_user_range(start, end) flushes range of user instruct=
ions
@@ -110,7 +109,6 @@ extern void copy_from_user_page(struct vm_area_struct *=
vma,
 	struct page *page, unsigned long vaddr, void *dst, const void *src,
 	unsigned long len);
=20
-extern void (*flush_cache_sigtramp)(unsigned long addr);
 extern void (*flush_icache_all)(void);
 extern void (*local_flush_data_cache_page)(void * addr);
 extern void (*flush_data_cache_page)(unsigned long addr);
diff --git a/arch/mips/mm/c-octeon.c b/arch/mips/mm/c-octeon.c
index 0e45b061e514..8064821e9805 100644
--- a/arch/mips/mm/c-octeon.c
+++ b/arch/mips/mm/c-octeon.c
@@ -127,23 +127,6 @@ static void octeon_flush_icache_range(unsigned long st=
art, unsigned long end)
 }
=20
=20
-/**
- * Flush the icache for a trampoline. These are used for interrupt
- * and exception hooking.
- *
- * @addr:   Address to flush
- */
-static void octeon_flush_cache_sigtramp(unsigned long addr)
-{
-	struct vm_area_struct *vma;
-
-	down_read(&current->mm->mmap_sem);
-	vma =3D find_vma(current->mm, addr);
-	octeon_flush_icache_all_cores(vma);
-	up_read(&current->mm->mmap_sem);
-}
-
-
 /**
  * Flush a range out of a vma
  *
@@ -289,7 +272,6 @@ void octeon_cache_init(void)
 	flush_cache_mm			=3D octeon_flush_cache_mm;
 	flush_cache_page		=3D octeon_flush_cache_page;
 	flush_cache_range		=3D octeon_flush_cache_range;
-	flush_cache_sigtramp		=3D octeon_flush_cache_sigtramp;
 	flush_icache_all		=3D octeon_flush_icache_all;
 	flush_data_cache_page		=3D octeon_flush_data_cache_page;
 	flush_icache_range		=3D octeon_flush_icache_range;
diff --git a/arch/mips/mm/c-r3k.c b/arch/mips/mm/c-r3k.c
index 01848cdf2074..0ca401ddf3b7 100644
--- a/arch/mips/mm/c-r3k.c
+++ b/arch/mips/mm/c-r3k.c
@@ -274,30 +274,6 @@ static void r3k_flush_data_cache_page(unsigned long ad=
dr)
 {
 }
=20
-static void r3k_flush_cache_sigtramp(unsigned long addr)
-{
-	unsigned long flags;
-
-	pr_debug("csigtramp[%08lx]\n", addr);
-
-	flags =3D read_c0_status();
-
-	write_c0_status(flags&~ST0_IEC);
-
-	/* Fill the TLB to avoid an exception with caches isolated. */
-	asm(	"lw\t$0, 0x000(%0)\n\t"
-		"lw\t$0, 0x004(%0)\n\t"
-		: : "r" (addr) );
-
-	write_c0_status((ST0_ISC|ST0_SWC|flags)&~ST0_IEC);
-
-	asm(	"sb\t$0, 0x000(%0)\n\t"
-		"sb\t$0, 0x004(%0)\n\t"
-		: : "r" (addr) );
-
-	write_c0_status(flags);
-}
-
 static void r3k_flush_kernel_vmap_range(unsigned long vaddr, int size)
 {
 	BUG();
@@ -331,7 +307,6 @@ void r3k_cache_init(void)
=20
 	__flush_kernel_vmap_range =3D r3k_flush_kernel_vmap_range;
=20
-	flush_cache_sigtramp =3D r3k_flush_cache_sigtramp;
 	local_flush_data_cache_page =3D local_r3k_flush_data_cache_page;
 	flush_data_cache_page =3D r3k_flush_data_cache_page;
=20
diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
index cc4e17caeb26..5166e38cd1c6 100644
--- a/arch/mips/mm/c-r4k.c
+++ b/arch/mips/mm/c-r4k.c
@@ -937,119 +937,6 @@ static void r4k_dma_cache_inv(unsigned long addr, uns=
igned long size)
 }
 #endif /* CONFIG_DMA_NONCOHERENT */
=20
-struct flush_cache_sigtramp_args {
-	struct mm_struct *mm;
-	struct page *page;
-	unsigned long addr;
-};
-
-/*
- * While we're protected against bad userland addresses we don't care
- * very much about what happens in that case.  Usually a segmentation
- * fault will dump the process later on anyway ...
- */
-static void local_r4k_flush_cache_sigtramp(void *args)
-{
-	struct flush_cache_sigtramp_args *fcs_args =3D args;
-	unsigned long addr =3D fcs_args->addr;
-	struct page *page =3D fcs_args->page;
-	struct mm_struct *mm =3D fcs_args->mm;
-	int map_coherent =3D 0;
-	void *vaddr;
-
-	unsigned long ic_lsize =3D cpu_icache_line_size();
-	unsigned long dc_lsize =3D cpu_dcache_line_size();
-	unsigned long sc_lsize =3D cpu_scache_line_size();
-
-	/*
-	 * If owns no valid ASID yet, cannot possibly have gotten
-	 * this page into the cache.
-	 */
-	if (!has_valid_asid(mm, R4K_HIT))
-		return;
-
-	if (mm =3D=3D current->active_mm) {
-		vaddr =3D NULL;
-	} else {
-		/*
-		 * Use kmap_coherent or kmap_atomic to do flushes for
-		 * another ASID than the current one.
-		 */
-		map_coherent =3D (cpu_has_dc_aliases &&
-				page_mapcount(page) &&
-				!Page_dcache_dirty(page));
-		if (map_coherent)
-			vaddr =3D kmap_coherent(page, addr);
-		else
-			vaddr =3D kmap_atomic(page);
-		addr =3D (unsigned long)vaddr + (addr & ~PAGE_MASK);
-	}
-
-	R4600_HIT_CACHEOP_WAR_IMPL;
-	if (!cpu_has_ic_fills_f_dc) {
-		if (dc_lsize)
-			vaddr ? flush_dcache_line(addr & ~(dc_lsize - 1))
-			      : protected_writeback_dcache_line(
-							addr & ~(dc_lsize - 1));
-		if (!cpu_icache_snoops_remote_store && scache_size)
-			vaddr ? flush_scache_line(addr & ~(sc_lsize - 1))
-			      : protected_writeback_scache_line(
-							addr & ~(sc_lsize - 1));
-	}
-	if (ic_lsize)
-		vaddr ? flush_icache_line(addr & ~(ic_lsize - 1))
-		      : protected_flush_icache_line(addr & ~(ic_lsize - 1));
-
-	if (vaddr) {
-		if (map_coherent)
-			kunmap_coherent();
-		else
-			kunmap_atomic(vaddr);
-	}
-
-	if (MIPS4K_ICACHE_REFILL_WAR) {
-		__asm__ __volatile__ (
-			".set push\n\t"
-			".set noat\n\t"
-			".set "MIPS_ISA_LEVEL"\n\t"
-#ifdef CONFIG_32BIT
-			"la	$at,1f\n\t"
-#endif
-#ifdef CONFIG_64BIT
-			"dla	$at,1f\n\t"
-#endif
-			"cache	%0,($at)\n\t"
-			"nop; nop; nop\n"
-			"1:\n\t"
-			".set pop"
-			:
-			: "i" (Hit_Invalidate_I));
-	}
-	if (MIPS_CACHE_SYNC_WAR)
-		__asm__ __volatile__ ("sync");
-}
-
-static void r4k_flush_cache_sigtramp(unsigned long addr)
-{
-	struct flush_cache_sigtramp_args args;
-	int npages;
-
-	down_read(&current->mm->mmap_sem);
-
-	npages =3D get_user_pages_fast(addr, 1, 0, &args.page);
-	if (npages < 1)
-		goto out;
-
-	args.mm =3D current->mm;
-	args.addr =3D addr;
-
-	r4k_on_each_cpu(R4K_HIT, local_r4k_flush_cache_sigtramp, &args);
-
-	put_page(args.page);
-out:
-	up_read(&current->mm->mmap_sem);
-}
-
 static void r4k_flush_icache_all(void)
 {
 	if (cpu_has_vtag_icache)
@@ -1978,7 +1865,6 @@ void r4k_cache_init(void)
=20
 	__flush_kernel_vmap_range =3D r4k_flush_kernel_vmap_range;
=20
-	flush_cache_sigtramp	=3D r4k_flush_cache_sigtramp;
 	flush_icache_all	=3D r4k_flush_icache_all;
 	local_flush_data_cache_page	=3D local_r4k_flush_data_cache_page;
 	flush_data_cache_page	=3D r4k_flush_data_cache_page;
@@ -2033,7 +1919,6 @@ void r4k_cache_init(void)
 		/* I$ fills from D$ just by emptying the write buffers */
 		flush_cache_page =3D (void *)b5k_instruction_hazard;
 		flush_cache_range =3D (void *)b5k_instruction_hazard;
-		flush_cache_sigtramp =3D (void *)b5k_instruction_hazard;
 		local_flush_data_cache_page =3D (void *)b5k_instruction_hazard;
 		flush_data_cache_page =3D (void *)b5k_instruction_hazard;
 		flush_icache_range =3D (void *)b5k_instruction_hazard;
@@ -2052,7 +1937,6 @@ void r4k_cache_init(void)
 		flush_cache_mm		=3D (void *)cache_noop;
 		flush_cache_page	=3D (void *)cache_noop;
 		flush_cache_range	=3D (void *)cache_noop;
-		flush_cache_sigtramp	=3D (void *)cache_noop;
 		flush_icache_all	=3D (void *)cache_noop;
 		flush_data_cache_page	=3D (void *)cache_noop;
 		local_flush_data_cache_page	=3D (void *)cache_noop;
diff --git a/arch/mips/mm/c-tx39.c b/arch/mips/mm/c-tx39.c
index 5f6c099a9457..b7c8a9d79c35 100644
--- a/arch/mips/mm/c-tx39.c
+++ b/arch/mips/mm/c-tx39.c
@@ -290,25 +290,6 @@ static void tx39_dma_cache_inv(unsigned long addr, uns=
igned long size)
 	}
 }
=20
-static void tx39_flush_cache_sigtramp(unsigned long addr)
-{
-	unsigned long ic_lsize =3D current_cpu_data.icache.linesz;
-	unsigned long dc_lsize =3D current_cpu_data.dcache.linesz;
-	unsigned long config;
-	unsigned long flags;
-
-	protected_writeback_dcache_line(addr & ~(dc_lsize - 1));
-
-	/* disable icache (set ICE#) */
-	local_irq_save(flags);
-	config =3D read_c0_conf();
-	write_c0_conf(config & ~TX39_CONF_ICE);
-	TX39_STOP_STREAMING();
-	protected_flush_icache_line(addr & ~(ic_lsize - 1));
-	write_c0_conf(config);
-	local_irq_restore(flags);
-}
-
 static __init void tx39_probe_cache(void)
 {
 	unsigned long config;
@@ -368,7 +349,6 @@ void tx39_cache_init(void)
 		flush_icache_range	=3D (void *) tx39h_flush_icache_all;
 		local_flush_icache_range =3D (void *) tx39h_flush_icache_all;
=20
-		flush_cache_sigtramp	=3D (void *) tx39h_flush_icache_all;
 		local_flush_data_cache_page	=3D (void *) tx39h_flush_icache_all;
 		flush_data_cache_page	=3D (void *) tx39h_flush_icache_all;
=20
@@ -397,7 +377,6 @@ void tx39_cache_init(void)
=20
 		__flush_kernel_vmap_range =3D tx39_flush_kernel_vmap_range;
=20
-		flush_cache_sigtramp =3D tx39_flush_cache_sigtramp;
 		local_flush_data_cache_page =3D local_tx39_flush_data_cache_page;
 		flush_data_cache_page =3D tx39_flush_data_cache_page;
=20
diff --git a/arch/mips/mm/cache.c b/arch/mips/mm/cache.c
index 55099fbff4e6..3da216988672 100644
--- a/arch/mips/mm/cache.c
+++ b/arch/mips/mm/cache.c
@@ -47,7 +47,6 @@ void (*__flush_kernel_vmap_range)(unsigned long vaddr, in=
t size);
 EXPORT_SYMBOL_GPL(__flush_kernel_vmap_range);
=20
 /* MIPS specific cache operations */
-void (*flush_cache_sigtramp)(unsigned long addr);
 void (*local_flush_data_cache_page)(void * addr);
 void (*flush_data_cache_page)(unsigned long addr);
 void (*flush_icache_all)(void);
--=20
2.20.1


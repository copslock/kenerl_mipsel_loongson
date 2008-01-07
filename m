Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Jan 2008 15:38:57 +0000 (GMT)
Received: from mba.ocn.ne.jp ([122.1.235.107]:46792 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S28574254AbYAGPis (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 7 Jan 2008 15:38:48 +0000
Received: from localhost (p7144-ipad210funabasi.chiba.ocn.ne.jp [58.88.126.144])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 65D344137; Tue,  8 Jan 2008 00:38:44 +0900 (JST)
Date:	Tue, 08 Jan 2008 00:41:13 +0900 (JST)
Message-Id: <20080108.004113.126142686.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: Re: [MIPS] 64-bit Sibyte kernels need DMA32.
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20071228.014321.41630007.anemo@mba.ocn.ne.jp>
References: <S20038938AbXKZMRu/20071126121750Z+44508@ftp.linux-mips.org>
	<20071228.014321.41630007.anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 5.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17942
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Fri, 28 Dec 2007 01:43:21 +0900 (JST), Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:
> This commit breaks platforms which have real prom_free_prom_memory().
> ...
> If I reverted the commit, this crash does not happen.  How I can fix this?

I see malta disabled prom_free_prom_memory for now, but it seems some
other boards are affected by this problem too.

How about this fix?

diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index 7f6ddcb..f8a535a 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -269,7 +269,7 @@ static void __init bootmem_init(void)
 
 static void __init bootmem_init(void)
 {
-	unsigned long init_begin, reserved_end;
+	unsigned long reserved_end;
 	unsigned long mapstart = ~0UL;
 	unsigned long bootmap_size;
 	int i;
@@ -344,7 +344,6 @@ static void __init bootmem_init(void)
 					 min_low_pfn, max_low_pfn);
 
 
-	init_begin = PFN_UP(__pa_symbol(&__init_begin));
 	for (i = 0; i < boot_mem_map.nr_map; i++) {
 		unsigned long start, end;
 
@@ -352,8 +351,8 @@ static void __init bootmem_init(void)
 		end = PFN_DOWN(boot_mem_map.map[i].addr
 				+ boot_mem_map.map[i].size);
 
-		if (start <= init_begin)
-			start = init_begin;
+		if (start <= min_low_pfn)
+			start = min_low_pfn;
 		if (start >= end)
 			continue;
 

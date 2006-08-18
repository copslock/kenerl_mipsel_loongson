Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Aug 2006 02:51:13 +0100 (BST)
Received: from topsns2.toshiba-tops.co.jp ([202.230.225.126]:43889 "EHLO
	topsns2.toshiba-tops.co.jp") by ftp.linux-mips.org with ESMTP
	id S20037675AbWHRBvL (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 18 Aug 2006 02:51:11 +0100
Received: from topsms.toshiba-tops.co.jp by topsns2.toshiba-tops.co.jp
          via smtpd (for ftp.linux-mips.org [194.74.144.162]) with ESMTP; Fri, 18 Aug 2006 10:51:09 +0900
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id 75B5920474;
	Fri, 18 Aug 2006 10:51:06 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (srd2sd.toshiba-tops.co.jp [172.17.28.2])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id 61E08202D2;
	Fri, 18 Aug 2006 10:51:06 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id k7I1p5W0087154;
	Fri, 18 Aug 2006 10:51:05 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Fri, 18 Aug 2006 10:51:05 +0900 (JST)
Message-Id: <20060818.105105.41197512.nemoto@toshiba-tops.co.jp>
To:	mark.e.mason@broadcom.com
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org, ths@networkno.de
Subject: Re: [MIPS] SB1: Build fix: delete initialization of
 flush_icache_page pointer.
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <7E000E7F06B05C49BDBB769ADAF44D07EEEC8C@NT-SJCA-0750.brcm.ad.broadcom.com>
References: <S20037884AbWHMBM7/20060813011259Z+2871@ftp.linux-mips.org>
	<7E000E7F06B05C49BDBB769ADAF44D07EEEC8C@NT-SJCA-0750.brcm.ad.broadcom.com>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.3 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12356
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Thu, 17 Aug 2006 14:20:07 -0700, "Mark E Mason" <mark.e.mason@broadcom.com> wrote:
> The sb1_flash_icache_page change below breaks causes 1480 kernels to
> hang after freeing memory:

Does this (untested) patch work for you?

diff --git a/arch/mips/mm/c-sb1.c b/arch/mips/mm/c-sb1.c
index 4bd9ad8..0f5691a 100644
--- a/arch/mips/mm/c-sb1.c
+++ b/arch/mips/mm/c-sb1.c
@@ -253,6 +253,17 @@ void sb1___flush_cache_all(void)
 	__attribute__((alias("local_sb1___flush_cache_all")));
 #endif
 
+static inline void local_sb1_flush_data_cache_page(void * addr)
+{
+	__sb1_writeback_inv_dcache_range((unsigned long)addr,
+					 (unsigned long)addr + PAGE_SIZE);
+}
+
+static void sb1_flush_data_cache_page(unsigned long addr)
+{
+	on_each_cpu(local_sb1_flush_data_cache_page, (void *) addr, 1, 1);
+}
+
 /*
  * When flushing a range in the icache, we have to first writeback
  * the dcache for the same range, so new ifetches will see any
@@ -527,8 +538,8 @@ #endif
 	flush_cache_page = sb1_flush_cache_page;
 
 	flush_cache_sigtramp = sb1_flush_cache_sigtramp;
-	local_flush_data_cache_page = (void *) sb1_nop;
-	flush_data_cache_page = (void *) sb1_nop;
+	local_flush_data_cache_page = local_sb1_flush_data_cache_page;
+	flush_data_cache_page = sb1_flush_data_cache_page;
 
 	/* Full flush */
 	__flush_cache_all = sb1___flush_cache_all;

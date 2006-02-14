Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Feb 2006 03:02:54 +0000 (GMT)
Received: from topsns2.toshiba-tops.co.jp ([202.230.225.126]:58865 "EHLO
	topsns2.toshiba-tops.co.jp") by ftp.linux-mips.org with ESMTP
	id S3467615AbWBNDCi (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 14 Feb 2006 03:02:38 +0000
Received: from topsms.toshiba-tops.co.jp by topsns2.toshiba-tops.co.jp
          via smtpd (for ftp.linux-mips.org [194.74.144.162]) with ESMTP; Tue, 14 Feb 2006 12:08:57 +0900
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id 27858203DB;
	Tue, 14 Feb 2006 12:08:48 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (srd2sd.toshiba-tops.co.jp [172.17.28.2])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id 1C6CB1FDD7;
	Tue, 14 Feb 2006 12:08:48 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id k1E38l4D074215;
	Tue, 14 Feb 2006 12:08:47 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Tue, 14 Feb 2006 12:08:46 +0900 (JST)
Message-Id: <20060214.120846.15248106.nemoto@toshiba-tops.co.jp>
To:	yoichi_yuasa@tripeaks.co.jp
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH] fix cache coherency issues
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20060214112653.25ed3e05.yoichi_yuasa@tripeaks.co.jp>
References: <20060214105928.0cd46e6f.yoichi_yuasa@tripeaks.co.jp>
	<20060214.111547.21591480.nemoto@toshiba-tops.co.jp>
	<20060214112653.25ed3e05.yoichi_yuasa@tripeaks.co.jp>
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
X-archive-position: 10432
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

>>>>> On Tue, 14 Feb 2006 11:26:53 +0900, Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp> said:
yuasa> Here is the boot log.

Thanks.  Could you try with this patch?

http://www.linux-mips.org/cgi-bin/mesg.cgi?a=linux-mips&i=20060204.015356.74753400.anemo%40mba.ocn.ne.jp

Or this quick workaround?

diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
index 1b71d91..5bd413f 100644
--- a/arch/mips/mm/c-r4k.c
+++ b/arch/mips/mm/c-r4k.c
@@ -425,7 +425,7 @@ static inline void local_r4k_flush_cache
 	 * Do indexed flush, too much work to get the (possible) TLB refills
 	 * to work correctly.
 	 */
-	addr = INDEX_BASE + (addr & (dcache_size - 1));
+	addr = INDEX_BASE + (addr & (current_cpu_data.dcache.waysize - 1));
 	if (cpu_has_dc_aliases || (exec && !cpu_has_ic_fills_f_dc)) {
 		r4k_blast_dcache_page_indexed(addr);
 		if (exec && !cpu_icache_snoops_remote_store)

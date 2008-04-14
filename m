Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Apr 2008 09:56:48 +0100 (BST)
Received: from topsns2.toshiba-tops.co.jp ([202.230.225.126]:7244 "EHLO
	topsns2.toshiba-tops.co.jp") by ftp.linux-mips.org with ESMTP
	id S20022890AbYDNI4q (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 14 Apr 2008 09:56:46 +0100
Received: from topsms.toshiba-tops.co.jp by topsns2.toshiba-tops.co.jp
          via smtpd (for [213.58.128.207] [213.58.128.207]) with ESMTP; Mon, 14 Apr 2008 17:56:43 +0900
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id 5583247294;
	Mon, 14 Apr 2008 17:56:34 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (srd2sd.toshiba-tops.co.jp [172.17.28.2])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id 41F3E4728D;
	Mon, 14 Apr 2008 17:56:34 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id m3E8uWAF052958;
	Mon, 14 Apr 2008 17:56:33 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Mon, 14 Apr 2008 17:56:32 +0900 (JST)
Message-Id: <20080414.175632.128440098.nemoto@toshiba-tops.co.jp>
To:	ths@networkno.de
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH] Reimplement clear_page/copy_page
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20080218193249.GD4747@networkno.de>
References: <20080218193249.GD4747@networkno.de>
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
X-archive-position: 18908
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Mon, 18 Feb 2008 19:32:49 +0000, Thiemo Seufer <ths@networkno.de> wrote:
> Fold the SB-1 specific implementation of clear_page/copy_page in the
> generic version, and rewrite that one in tlbex style. The immediate
> benefits:
>   - It converts the compile-time workaround for SB-1 pass 1 prefetches
>     to a more efficient run-time check.
>   - It allows adjustment of loop unfolling, which helps to reduce the
>     number of redundant cdex cache ops.
>   - It fixes some esoteric cornercases (the cache line length calculations
>     can go wrong, and support for 64k pages without prefetch instructions
>     will overflow the addiu immediate).
>   - Somewhat better guesses of "good" prefetch values.
> 
> 
> Signed-off-by: Thiemo Seufer <ths@networkno.de>

With this patch, on platforms do not have prefetch instruction, a
first instruction of clear_page and copy_page would be something like:

	ori a2, a0, PAGE_SIZE

Of course this does not work for odd pages.  Please fold this fix into
your patch.

diff --git a/arch/mips/mm/page.c b/arch/mips/mm/page.c
index e763101..d827d61 100644
--- a/arch/mips/mm/page.c
+++ b/arch/mips/mm/page.c
@@ -302,7 +302,7 @@ void __cpuinit build_clear_page(void)
 	BUG_ON(PAGE_SIZE < pref_bias_clear_store);
 
 	off = PAGE_SIZE - pref_bias_clear_store;
-	if (off > 0xffff)
+	if (off > 0xffff || !pref_bias_clear_store)
 		pg_addiu(&buf, A2, A0, off);
 	else
 		uasm_i_ori(&buf, A2, A0, off);
@@ -446,7 +446,7 @@ void __cpuinit build_copy_page(void)
 	BUG_ON(pref_bias_copy_store > pref_bias_copy_load);
 
 	off = PAGE_SIZE - pref_bias_copy_load;
-	if (off > 0xffff)
+	if (off > 0xffff || !pref_bias_copy_load)
 		pg_addiu(&buf, A2, A0, off);
 	else
 		uasm_i_ori(&buf, A2, A0, off);

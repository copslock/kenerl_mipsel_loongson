Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 May 2008 05:16:13 +0100 (BST)
Received: from p549F7A8A.dip.t-dialin.net ([84.159.122.138]:38042 "EHLO
	p549F7A8A.dip.t-dialin.net") by ftp.linux-mips.org with ESMTP
	id S20022020AbYE3EQL (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 30 May 2008 05:16:11 +0100
Received: from [202.230.225.126] ([202.230.225.126]:64102 "EHLO
	topsns2.toshiba-tops.co.jp") by lappi.linux-mips.net with ESMTP
	id S1099251AbYE3EIF (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 30 May 2008 06:08:05 +0200
Received: from no.name.available by topsns2.toshiba-tops.co.jp
          via smtpd (for p549F7A8A.dip.t-dialin.net [84.159.122.138]) with ESMTP; Fri, 30 May 2008 13:07:59 +0900
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id 058F142B6C;
	Fri, 30 May 2008 13:07:25 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (srd2sd.toshiba-tops.co.jp [172.17.28.2])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id E59DA42B38;
	Fri, 30 May 2008 13:07:24 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id m4U47MZf023516;
	Fri, 30 May 2008 13:07:22 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Fri, 30 May 2008 13:07:21 +0900 (JST)
Message-Id: <20080530.130721.41629284.nemoto@toshiba-tops.co.jp>
To:	yoichi_yuasa@tripeaks.co.jp
Cc:	ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: [PATCH][MIPS] fix divide by zero error in build_clear_page and
 build_copy_page
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20080507233815.e6de28da.yoichi_yuasa@tripeaks.co.jp>
References: <20080507233815.e6de28da.yoichi_yuasa@tripeaks.co.jp>
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
X-archive-position: 19385
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Wed, 7 May 2008 23:38:15 +0900, Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp> wrote:
> Fix divide by zero error in build_clear_page() and build_copy_page()
> 
> Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
> 
> diff -pruN -X /home/yuasa/Memo/dontdiff linux-orig/arch/mips/mm/page.c linux/arch/mips/mm/page.c
> --- linux-orig/arch/mips/mm/page.c	2008-05-07 10:28:03.732151097 +0900
> +++ linux/arch/mips/mm/page.c	2008-05-07 23:27:00.212977534 +0900
...
> -	off = min(8, pref_bias_copy_store / cache_line_size) * cache_line_size;
> +	off = cache_line_size ? min(8, pref_bias_copy_load / cache_line_size) *
> +	                        cache_line_size : 0;
>  	while (off) {
>  		build_copy_store_pref(&buf, -off);
>  		off -= cache_line_size;

This change is wrong.  Please apply this on top of the patch.

diff --git a/arch/mips/mm/page.c b/arch/mips/mm/page.c
index cab81f4..1edf0cb 100644
--- a/arch/mips/mm/page.c
+++ b/arch/mips/mm/page.c
@@ -460,7 +460,7 @@ void __cpuinit build_copy_page(void)
 		build_copy_load_pref(&buf, -off);
 		off -= cache_line_size;
 	}
-	off = cache_line_size ? min(8, pref_bias_copy_load / cache_line_size) *
+	off = cache_line_size ? min(8, pref_bias_copy_store / cache_line_size) *
 	                        cache_line_size : 0;
 	while (off) {
 		build_copy_store_pref(&buf, -off);

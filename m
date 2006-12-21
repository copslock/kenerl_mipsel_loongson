Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 Dec 2006 16:03:33 +0000 (GMT)
Received: from mba.ocn.ne.jp ([210.190.142.172]:59094 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S28644086AbWLUQDU (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 21 Dec 2006 16:03:20 +0000
Received: from localhost (p2195-ipad203funabasi.chiba.ocn.ne.jp [222.146.81.195])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 0A4F5C105; Fri, 22 Dec 2006 01:03:17 +0900 (JST)
Date:	Fri, 22 Dec 2006 01:03:16 +0900 (JST)
Message-Id: <20061222.010316.63742169.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: Re: [PATCH] Fix build_store_reg()
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20061218.003821.96686517.anemo@mba.ocn.ne.jp>
References: <20061218.003821.96686517.anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13510
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Mon, 18 Dec 2006 00:38:21 +0900 (JST), Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:
> The commit a923660d786a53e78834b19062f7af2535f7f8ad accidently
> prevents TX49 from using CDEX.  Use build_dst_pref() only if prefetch
> for store was really available.
> 
> Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
> ---
> diff --git a/arch/mips/mm/pg-r4k.c b/arch/mips/mm/pg-r4k.c
> index d41fc58..dc795be 100644
> --- a/arch/mips/mm/pg-r4k.c
> +++ b/arch/mips/mm/pg-r4k.c
> @@ -243,11 +243,10 @@ static void __init __build_store_reg(int
>  
>  static inline void build_store_reg(int reg)
>  {
> -	if (cpu_has_prefetch)
> -		if (reg)
> -			build_dst_pref(pref_offset_copy);
> -		else
> -			build_dst_pref(pref_offset_clear);
> +	int pref_off = cpu_has_prefetch ?
> +		(reg ? pref_offset_copy : pref_offset_clear) : 0;
> +	if (pref_off)
> +		build_dst_pref(pref_off);
>  	else if (cpu_has_cache_cdex_s)
>  		build_cdex_s();
>  	else if (cpu_has_cache_cdex_p)

BTW, why prefetch is preferred than cache_cdex?  I feel cdex is better
while it avoids unnecessary load...

---
Atsushi Nemoto

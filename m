Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 24 Sep 2006 16:24:17 +0100 (BST)
Received: from mba.ocn.ne.jp ([210.190.142.172]:14311 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20037883AbWIXPYO (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 24 Sep 2006 16:24:14 +0100
Received: from localhost (p5142-ipad209funabasi.chiba.ocn.ne.jp [58.88.116.142])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id BA6B29DE0; Mon, 25 Sep 2006 00:24:09 +0900 (JST)
Date:	Mon, 25 Sep 2006 00:26:16 +0900 (JST)
Message-Id: <20060925.002616.126574366.anemo@mba.ocn.ne.jp>
To:	girishvg@gmail.com
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] cleanup hardcoding __pa/__va macros etc.
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <34a75100609232239y29cdabd4xeefb898e502c5dfa@mail.gmail.com>
References: <34a75100609232239y29cdabd4xeefb898e502c5dfa@mail.gmail.com>
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
X-archive-position: 12641
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Sun, 24 Sep 2006 14:39:38 +0900, girish <girishvg@gmail.com> wrote:
> --- linux-vanilla/include/asm-mips/page.h	2006-09-24 12:23:34.000000000 +0900
> +++ linux/include/asm-mips/page.h	2006-09-24 14:00:53.000000000 +0900
> @@ -134,8 +134,13 @@ typedef struct { unsigned long pgprot; }
>  /* to align the pointer to the (next) page boundary */
>  #define PAGE_ALIGN(addr)	(((addr) + PAGE_SIZE - 1) & PAGE_MASK)
> 
> -#define __pa(x)			((unsigned long) (x) - PAGE_OFFSET)
> -#define __va(x)			((void *)((unsigned long) (x) + PAGE_OFFSET))
> +#define UNMAPLIMIT              (UNCAC_BASE - CAC_BASE) /*HIGHMEM_START*/
> +#define ISMAPPED(x)             (KSEGX((x)) > UNMAPLIMIT)
> +#define ___pa(x)		((unsigned long) (x) - PAGE_OFFSET)
> +#define __pa(x)		        (ISMAPPED(x) ? (x) : ___pa(x))
> +
> +#define ___va(x)		((void *)((unsigned long) (x) + PAGE_OFFSET))
> +#define __va(x)			(ISMAPPED(x) ? (x) : ___va(x))
> 
>  #define pfn_to_kaddr(pfn)	__va((pfn) << PAGE_SHIFT)

This part looks broken for 64-bit kernel.

For other parts, it would be better to keep correct indentation level.

---
Atsushi Nemoto

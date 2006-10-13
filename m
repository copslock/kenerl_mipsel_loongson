Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 Oct 2006 17:25:40 +0100 (BST)
Received: from mba.ocn.ne.jp ([210.190.142.172]:43978 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20038794AbWJMQZ3 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 13 Oct 2006 17:25:29 +0100
Received: from localhost (p5231-ipad203funabasi.chiba.ocn.ne.jp [222.146.84.231])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 571F29C55; Sat, 14 Oct 2006 01:25:21 +0900 (JST)
Date:	Sat, 14 Oct 2006 01:27:38 +0900 (JST)
Message-Id: <20061014.012738.26097195.anemo@mba.ocn.ne.jp>
To:	vagabon.xyz@gmail.com
Cc:	ralf@linux-mips.org, ths@networkno.de, linux-mips@linux-mips.org,
	fbuihuu@gmail.com
Subject: Re: [PATCH 2/7] Make __pa() aware of XKPHYS/CKSEG0 address mix for
 64 bit kernels
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <1160743146824-git-send-email-fbuihuu@gmail.com>
References: <11607431461469-git-send-email-fbuihuu@gmail.com>
	<1160743146824-git-send-email-fbuihuu@gmail.com>
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
X-archive-position: 12947
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Fri, 13 Oct 2006 14:39:01 +0200, Franck Bui-Huu <vagabon.xyz@gmail.com> wrote:
> -#define __pa(x)			((unsigned long) (x) - PAGE_OFFSET)
> -#define __va(x)			((void *)((unsigned long) (x) + PAGE_OFFSET))
> +#if defined(CONFIG_64BITS) && !defined(CONFIG_BUILD_ELF64)
> +#define __page_offset(x)	((unsigned long)(x) < CKSEG0 ? PAGE_OFFSET : CKSEG0)
> +#else
> +#define __page_offset(x)	PAGE_OFFSET
> +#endif
> +#define __pa(x)			((unsigned long)(x) - __page_offset(x))
> +#define __va(x)			((void *)((unsigned long)(x) + __page_offset(x)))

In __va(), you are passing an physical address to __page_offset().

---
Atsushi Nemoto

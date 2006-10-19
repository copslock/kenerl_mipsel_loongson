Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Oct 2006 08:23:38 +0100 (BST)
Received: from mo30.po.2iij.net ([210.128.50.53]:60197 "EHLO mo30.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20037434AbWJSHXh (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 19 Oct 2006 08:23:37 +0100
Received: by mo.po.2iij.net (mo30) id k9J7NYdj015324; Thu, 19 Oct 2006 16:23:34 +0900 (JST)
Received: from localhost.localdomain (65.126.232.202.bf.2iij.net [202.232.126.65])
	by mbox.po.2iij.net (mbox31) id k9J7NX0u019343
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 19 Oct 2006 16:23:33 +0900 (JST)
Message-Id: <200610190723.k9J7NX0u019343@mbox31.po.2iij.net>
Date:	Thu, 19 Oct 2006 16:23:32 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	yoichi_yuasa@tripeaks.co.jp, vagabon.xyz@gmail.com,
	ralf@linux-mips.org, ths@networkno.de, linux-mips@linux-mips.org,
	fbuihuu@gmail.com
Subject: Re: [PATCH 2/7] Make __pa() aware of XKPHYS/CKSEG0 address mix for
 64 bit kernels
In-Reply-To: <20061019.160145.63741509.nemoto@toshiba-tops.co.jp>
References: <1160743146824-git-send-email-fbuihuu@gmail.com>
	<20061019.130133.108306753.nemoto@toshiba-tops.co.jp>
	<20061019154138.0343bbd0.yoichi_yuasa@tripeaks.co.jp>
	<20061019.160145.63741509.nemoto@toshiba-tops.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13011
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

On Thu, 19 Oct 2006 16:01:45 +0900 (JST)
Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:

> On Thu, 19 Oct 2006 15:41:38 +0900, Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp> wrote:
> > > +#define _LLCONST_(x)	x ## L
> >             ^^               ^
> > The name is not corresponding to reality.
> > It's not so good.
> 
> Indeed.  How about this?
> 
> 
> Subject: Use "long" for 64-bit values on 64-bit kernel.
> 
> Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
> 
> diff --git a/include/asm-mips/addrspace.h b/include/asm-mips/addrspace.h
> index 45c706e..7401711 100644
> --- a/include/asm-mips/addrspace.h
> +++ b/include/asm-mips/addrspace.h
> @@ -19,12 +19,17 @@ #ifdef __ASSEMBLY__
>  #define _ATYPE_
>  #define _ATYPE32_
>  #define _ATYPE64_
> -#define _LLCONST_(x)	x
> +#define _CONST64_(x)	x
>  #else
>  #define _ATYPE_		__PTRDIFF_TYPE__
>  #define _ATYPE32_	int
> +#ifdef CONFIG_64BIT
> +#define _ATYPE64_	long
> +#define _CONST64_(x)	x ## L
> +#else
>  #define _ATYPE64_	long long
> -#define _LLCONST_(x)	x ## LL
> +#define _CONST64_(x)	x ## LL
> +#endif
>  #endif

<snip>

It's good for me.

Thanks,

Yoichi

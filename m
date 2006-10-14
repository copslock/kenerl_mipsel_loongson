Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 14 Oct 2006 09:39:40 +0100 (BST)
Received: from nf-out-0910.google.com ([64.233.182.187]:49851 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20039047AbWJNIji (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 14 Oct 2006 09:39:38 +0100
Received: by nf-out-0910.google.com with SMTP id l23so1884961nfc
        for <linux-mips@linux-mips.org>; Sat, 14 Oct 2006 01:39:34 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=De75teH1rfCuMA68lbJQCrlXaTsbz4jNuY5xh2YQt53qNKAau4PxpSlKLP2pclGn08U/Wn6H3YjFwu6Av8YW+ELFwkNjYvCQ+GpCMbbgAUWSqMGFxwEEXNj9NeyLtjmfXN23kQVzY50XfghGp5DelQKVJ1dkaPXsX1ouC9N4tHc=
Received: by 10.78.201.15 with SMTP id y15mr4937844huf;
        Sat, 14 Oct 2006 01:39:34 -0700 (PDT)
Received: by 10.78.124.19 with HTTP; Sat, 14 Oct 2006 01:39:34 -0700 (PDT)
Message-ID: <cda58cb80610140139i4d20b423m9997f63cfdd90e31@mail.gmail.com>
Date:	Sat, 14 Oct 2006 10:39:34 +0200
From:	"Franck Bui-Huu" <vagabon.xyz@gmail.com>
To:	"Atsushi Nemoto" <anemo@mba.ocn.ne.jp>
Subject: Re: [PATCH 2/7] Make __pa() aware of XKPHYS/CKSEG0 address mix for 64 bit kernels
Cc:	ralf@linux-mips.org, ths@networkno.de, linux-mips@linux-mips.org,
	fbuihuu@gmail.com
In-Reply-To: <20061014.012738.26097195.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <11607431461469-git-send-email-fbuihuu@gmail.com>
	 <1160743146824-git-send-email-fbuihuu@gmail.com>
	 <20061014.012738.26097195.anemo@mba.ocn.ne.jp>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12951
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

On 10/13/06, Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:
> On Fri, 13 Oct 2006 14:39:01 +0200, Franck Bui-Huu <vagabon.xyz@gmail.com> wrote:
> > -#define __pa(x)                      ((unsigned long) (x) - PAGE_OFFSET)
> > -#define __va(x)                      ((void *)((unsigned long) (x) + PAGE_OFFSET))
> > +#if defined(CONFIG_64BITS) && !defined(CONFIG_BUILD_ELF64)
> > +#define __page_offset(x)     ((unsigned long)(x) < CKSEG0 ? PAGE_OFFSET : CKSEG0)
> > +#else
> > +#define __page_offset(x)     PAGE_OFFSET
> > +#endif
> > +#define __pa(x)                      ((unsigned long)(x) - __page_offset(x))
> > +#define __va(x)                      ((void *)((unsigned long)(x) + __page_offset(x)))
>
> In __va(), you are passing an physical address to __page_offset().
>

oops, good catch ! I'll change that.

thanks
-- 
               Franck

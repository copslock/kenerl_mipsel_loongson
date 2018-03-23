Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Mar 2018 04:51:23 +0100 (CET)
Received: from forward106p.mail.yandex.net ([IPv6:2a02:6b8:0:1472:2741:0:8b7:109]:49592
        "EHLO forward106p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990411AbeCWDvPneWzK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 23 Mar 2018 04:51:15 +0100
Received: from mxback14g.mail.yandex.net (mxback14g.mail.yandex.net [IPv6:2a02:6b8:0:1472:2741:0:8b7:93])
        by forward106p.mail.yandex.net (Yandex) with ESMTP id DCCB72D83563;
        Fri, 23 Mar 2018 06:51:09 +0300 (MSK)
Received: from smtp3o.mail.yandex.net (smtp3o.mail.yandex.net [2a02:6b8:0:1a2d::27])
        by mxback14g.mail.yandex.net (nwsmtp/Yandex) with ESMTP id 4lPL1HOGOQ-p6oCJx1v;
        Fri, 23 Mar 2018 06:51:09 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; s=mail; t=1521777069;
        bh=5SvjjoAUaysI2wrTTFD9UUpWnSloq+ThLng+isqMh9o=;
        h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=lHkXx2N2g3r+ukjyvevXiufSaniAYxmCxusabFowL961JCH+vsbjNq6COsKmXQwcP
         +vw0dfVnf5HZapO3qwht6uPC8o4iEslzgh0y1RcNdrA+TIKYdvYZPNy2tE7+/SWkUi
         GaIS/vVJrT2ipM7ygvnvYS3AiyqhoMpwOZk2nSVI=
Received: by smtp3o.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id D7pNAh9uwJ-owcCxaRF;
        Fri, 23 Mar 2018 06:51:03 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; s=mail; t=1521777064;
        bh=5SvjjoAUaysI2wrTTFD9UUpWnSloq+ThLng+isqMh9o=;
        h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=bOqWGPya+FtO031ZYUsV8ILP2vNq1uPJ1u9rl4js2Dz4Ugp9WUj2+uXucsXlvXWSc
         14Jb8zkvYPnKvdw5eN78/m8foQMWrGI3MxyBFOnU4YMQ2whRX5GjRgWKk3r3G/9+p6
         vcKPa9jha79SDG/LYqf7hwZv7m4HbBlw0J0LYQjQ=
Authentication-Results: smtp3o.mail.yandex.net; dkim=pass header.i=@flygoat.com
Message-ID: <1521777055.1510.9.camel@flygoat.com>
Subject: Re: [PATCH V3] ZBOOT: fix stack protector in compressed boot phase
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     James Hogan <jhogan@kernel.org>, Huacai Chen <chenhc@lemote.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
        linux-mips@linux-mips.org, Russell King <linux@arm.linux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
        stable@vger.kernel.org
Date:   Fri, 23 Mar 2018 11:50:55 +0800
In-Reply-To: <20180322222107.GJ13126@saruman>
References: <1521186916-13745-1-git-send-email-chenhc@lemote.com>
         <20180322222107.GJ13126@saruman>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.5 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-Path: <jiaxun.yang@flygoat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63161
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jiaxun.yang@flygoat.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

在 2018-03-22四的 22:21 +0000，James Hogan写道：
> On Fri, Mar 16, 2018 at 03:55:16PM +0800, Huacai Chen wrote:
> > diff --git a/arch/mips/boot/compressed/decompress.c
> > b/arch/mips/boot/compressed/decompress.c
> > index fdf99e9..5ba431c 100644
> > --- a/arch/mips/boot/compressed/decompress.c
> > +++ b/arch/mips/boot/compressed/decompress.c
> > @@ -78,11 +78,6 @@ void error(char *x)
> >  
> >  unsigned long __stack_chk_guard;
> 
> ...
> 
> > diff --git a/arch/mips/boot/compressed/head.S
> > b/arch/mips/boot/compressed/head.S
> > index 409cb48..00d0ee0 100644
> > --- a/arch/mips/boot/compressed/head.S
> > +++ b/arch/mips/boot/compressed/head.S
> > @@ -32,6 +32,10 @@ start:
> >  	bne	a2, a0, 1b
> >  	 addiu	a0, a0, 4
> >  
> > +	PTR_LA	a0, __stack_chk_guard
> > +	PTR_LI	a1, 0x000a0dff
> > +	sw	a1, 0(a0)
> 

Hi James

Huacai Can't reply this mail. His chenhc@lemote.com is blcoked by
Linux-MIPS mailing list while his Gmail didn't receive this email, so
I'm replying for him.

> Should that not be LONG_S? Otherwise big endian MIPS64 would get a
> word-swapped canary (which is probably mostly harmless, but still).

Yes, he said it's considerable.

> 
> Also I think it worth mentioning in the commit message the MIPS
> configuration you hit this with, presumably a Loongson one? For me
> decompress_kernel() gets a stack guard on loongson3_defconfig, but
> not
> malta_defconfig or malta_defconfig + 64-bit. I presume its sensitive
> to
> the compiler inlining stuff into decompress_kernel() or something
> such
> that it suddenly qualifies for a stack guard.

Have you tested with CONFIG_CC_STACKPROTECTOR_STRONG=y ?
Huacai reproduced the issue by this[1] config with GCC 4.9.

[1] https://github.com/loongson-community/linux-stable/blob/rebase-4.14
/arch/mips/configs/loongson3_defconfig

> 
> Cheers
> James

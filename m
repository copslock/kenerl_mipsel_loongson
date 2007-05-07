Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 May 2007 09:51:27 +0100 (BST)
Received: from nz-out-0506.google.com ([64.233.162.234]:43769 "EHLO
	nz-out-0506.google.com") by ftp.linux-mips.org with ESMTP
	id S20021969AbXEGIvX (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 7 May 2007 09:51:23 +0100
Received: by nz-out-0506.google.com with SMTP id x7so1593998nzc
        for <linux-mips@linux-mips.org>; Mon, 07 May 2007 01:50:22 -0700 (PDT)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Y++pxD+tD/TDeG6S0D/Lle5UsC/I74lqP3nZnUDKuf7qNCyCsh+0ITIDfUTqP+5KBLXZZ6lBQWDzpNIDenVPEYNUCLT9IlnJIderkpi/khah+QNZvrkkDhKmR79s+xtbz2ktaxqgsZW34ArbM1oolsenRp04qCSdgHmnxAzxgts=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=pGlGtz/GnMNjZcBfKt7Dc9VgzV5tXilILdISt8Q9qJIkKshXuCyHqQ2/DEGG9WGgbdn3SG3mUizwwmPux0WSfn0yzqjXsjvMGQN8fS154mep13qLAEyuI2LJUMk47Svw47hQTr9DwZB+k2DjglYGLI9ibA4U6AvgEsb5C8Yf2OU=
Received: by 10.114.136.1 with SMTP id j1mr2055588wad.1178527820528;
        Mon, 07 May 2007 01:50:20 -0700 (PDT)
Received: by 10.115.94.16 with HTTP; Mon, 7 May 2007 01:50:20 -0700 (PDT)
Message-ID: <cda58cb80705070150u75165c47n252a664fc92646f3@mail.gmail.com>
Date:	Mon, 7 May 2007 10:50:20 +0200
From:	"Franck Bui-Huu" <vagabon.xyz@gmail.com>
To:	"Atsushi Nemoto" <anemo@mba.ocn.ne.jp>
Subject: Re: [PATCH 2/3] time: replace board_time_init() by plat_clk_setup()
Cc:	ralf@linux-mips.org, linux-mips@linux-mips.org
In-Reply-To: <20070506.010313.41199101.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <1178293006633-git-send-email-fbuihuu@gmail.com>
	 <11782930063123-git-send-email-fbuihuu@gmail.com>
	 <20070506.010313.41199101.anemo@mba.ocn.ne.jp>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14968
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Hi Atsushi,

On 5/5/07, Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:
>
> Though providing plat_clk_setup() for timekeeping code might be a good
> idea, I think your patch break at least those two platforms:
>
> MOMENCO_JAGUAR_ATX: momenco_time_init() assumes tlb_init() was already
> called.  (wire_stupidity_into_tlb() calls local_flush_tlb_all())
>

Ok, but in this case it seems a bad use of time init hook: the
platform seems to use its time init hook to setup the tlb. That sounds
pretty hackish, isn't it ?

If so, doesn't it mean that we should give the opportunity to
platform's code to modify the tlb mapping properly ? Actually I had
the same problem with mapped kernels and the only way to solve it was
to hack tlb_init()...

BTW, do you know why wire_stupidity_into_tlb() is called twice: one
time in plat_mem_setup() and a second time in momenco_time_init() ?
Note for the former case, tlb_init() hasn't been called yet...

> MOMENCO_OCELOT_G: gt64240_time_init() assumes IRQ subsystem are
> already initialized.
>

heh ? why not using plat_timer_setup() hook in this case ?

> How about keeping board_time_init pointer as is and adding
> plat_clk_setup only for simple platforms?
>

Not sure that would force us to duplicate all timekeeping stuff in
time_init() hook because of several hacks. If this is really true,
let's try to clean up some code.

Thanks
-- 
               Franck

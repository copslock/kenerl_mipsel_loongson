Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 06 Feb 2010 10:52:39 +0100 (CET)
Received: from elvis.franken.de ([193.175.24.41]:34695 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491178Ab0BFJwc (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 6 Feb 2010 10:52:32 +0100
Received: from uucp (helo=solo.franken.de)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1NdhL5-0002Oh-00; Sat, 06 Feb 2010 10:52:31 +0100
Received: by solo.franken.de (Postfix, from userid 1000)
        id 37976C2C79; Sat,  6 Feb 2010 10:52:18 +0100 (CET)
Date:   Sat, 6 Feb 2010 10:52:18 +0100
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Julia Lawall <julia@diku.dk>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 2/11] arch/mips/sni: Correct NULL test
Message-ID: <20100206095218.GA7185@alpha.franken.de>
References: <Pine.LNX.4.64.1002060942010.8092@ask.diku.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.1002060942010.8092@ask.diku.dk>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25888
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
Precedence: bulk
X-list: linux-mips

On Sat, Feb 06, 2010 at 09:42:16AM +0100, Julia Lawall wrote:
> From: Julia Lawall <julia@diku.dk>
> 
> Test the value that was just allocated rather than the previously tested one.
> 
> A simplified version of the semantic match that finds this problem is as
> follows: (http://coccinelle.lip6.fr/)
> 
> // <smpl>
> @r@
> expression *x;
> expression e;
> identifier l;
> @@
> 
> if (x == NULL || ...) {
>     ... when forall
>     return ...; }
> ... when != goto l;
>     when != x = e
>     when != &x
> *x == NULL
> // </smpl>
> 
> Signed-off-by: Julia Lawall <julia@diku.dk>
> send
> ---
>  arch/mips/sni/rm200.c               |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/mips/sni/rm200.c b/arch/mips/sni/rm200.c
> index 46f0069..31e2583 100644
> --- a/arch/mips/sni/rm200.c
> +++ b/arch/mips/sni/rm200.c
> @@ -404,7 +404,7 @@ void __init sni_rm200_i8259_irqs(void)
>  	if (!rm200_pic_master)
>  		return;
>  	rm200_pic_slave = ioremap_nocache(0x160000a0, 4);
> -	if (!rm200_pic_master) {
> +	if (!rm200_pic_slave) {
>  		iounmap(rm200_pic_master);
>  		return;
>  	}

Acked-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>

Thanks for fixing.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessary a
good idea.                                                [ RFC1925, 2.3 ]

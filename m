Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 21 Sep 2009 21:24:22 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:58674 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1493221AbZIUTYP (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 21 Sep 2009 21:24:15 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n8LJPNxh020603;
	Mon, 21 Sep 2009 20:25:23 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n8LJPL18020601;
	Mon, 21 Sep 2009 20:25:21 +0100
Date:	Mon, 21 Sep 2009 20:25:20 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Julia Lawall <julia@diku.dk>,
	"Kevin D. Kissell" <kevink@paralogos.com>
Cc:	dmitri.vorobiev@gmail.com, linux-mips@linux-mips.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] arch/mips: remove duplicate structure field
	initialization
Message-ID: <20090921192520.GB17310@linux-mips.org>
References: <Pine.LNX.4.64.0909211708200.8549@pc-004.diku.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0909211708200.8549@pc-004.diku.dk>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24061
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Sep 21, 2009 at 05:08:55PM +0200, Julia Lawall wrote:

Adding Kevin "SMTC Kissel to cc.

> From: Julia Lawall <julia@diku.dk>
> 
> The definition of the irq_ipi structure has two initializations of the
> flags field.  This combines them.
> 
> The semantic match that finds this problem is as follows:
> (http://coccinelle.lip6.fr/)
> 
> // <smpl>
> @r@
> identifier I, s, fld;
> position p0,p;
> expression E;
> @@
> 
> struct I s =@p0 { ... .fld@p = E, ...};
> 
> @s@
> identifier I, s, r.fld;
> position r.p0,p;
> expression E;
> @@
> 
> struct I s =@p0 { ... .fld@p = E, ...};
> 
> @script:python@
> p0 << r.p0;
> fld << r.fld;
> ps << s.p;
> pr << r.p;
> @@
> 
> if int(ps[0].line)!=int(pr[0].line) or int(ps[0].column)!=int(pr[0].column):
>   cocci.print_main(fld,p0)
> // </smpl>
> 
> Signed-off-by: Julia Lawall <julia@diku.dk>
> 
> ---
>  arch/mips/kernel/smtc.c             |    5 ++---
>  1 files changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/mips/kernel/smtc.c b/arch/mips/kernel/smtc.c
> index 67153a0..4d181df 100644
> --- a/arch/mips/kernel/smtc.c
> +++ b/arch/mips/kernel/smtc.c
> @@ -1098,9 +1098,8 @@ static void ipi_irq_dispatch(void)
>  
>  static struct irqaction irq_ipi = {
>  	.handler	= ipi_interrupt,
> -	.flags		= IRQF_DISABLED,
> -	.name		= "SMTC_IPI",
> -	.flags		= IRQF_PERCPU
> +	.flags		= IRQF_DISABLED | IRQF_PERCPU,
> +	.name		= "SMTC_IPI"
>  };
>  
>  static void setup_cross_vpe_interrupts(unsigned int nvpe)

The actual semantic of this code as implemented by gcc is that all but the
last initializer are ignored so until somebody actually tests your code
I'll just remove the first of the two initializers and put a comment there.

  Ralf

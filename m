Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6PB52Rw000512
	for <linux-mips-outgoing@oss.sgi.com>; Thu, 25 Jul 2002 04:05:02 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6PB52Im000511
	for linux-mips-outgoing; Thu, 25 Jul 2002 04:05:02 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from hell (buserror-extern.convergence.de [212.84.236.66])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6PB4qRw000481
	for <linux-mips@oss.sgi.com>; Thu, 25 Jul 2002 04:04:54 -0700
Received: from js by hell with local (Exim 3.35 #1 (Debian))
	id 17XgR8-0001oO-00; Thu, 25 Jul 2002 13:05:38 +0200
Date: Thu, 25 Jul 2002 13:05:38 +0200
From: Johannes Stezenbach <js@convergence.de>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: linux-mips@oss.sgi.com
Subject: Re: _stext is ill-defined / SysRq-T broken
Message-ID: <20020725110538.GA6804@convergence.de>
Mail-Followup-To: Johannes Stezenbach <js@convergence.de>,
	"Maciej W. Rozycki" <macro@ds2.pg.gda.pl>, linux-mips@oss.sgi.com
References: <20020724181708.GA5399@convergence.de> <Pine.GSO.3.96.1020725114648.27463B-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.3.96.1020725114648.27463B-100000@delta.ds2.pg.gda.pl>
User-Agent: Mutt/1.4i
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, Jul 25, 2002 at 12:08:15PM +0200, Maciej W. Rozycki wrote:
> 
>  I think the intent is to skip initial parts of .text, specifically the
> exception handlers (if linked at KSEG0).  kernel_entry is in .text.init
> deliberately, as it's not needed except early in the boot process.  I
> propose the following change.  Does it work for you? 
> 
> diff -up --recursive --new-file linux-mips-2.4.19-rc1-20020719.macro/arch/mips/kernel/head.S linux-mips-2.4.19-rc1-20020719/arch/mips/kernel/head.S
> --- linux-mips-2.4.19-rc1-20020719.macro/arch/mips/kernel/head.S	2002-06-04 03:04:12.000000000 +0000
> +++ linux-mips-2.4.19-rc1-20020719/arch/mips/kernel/head.S	2002-07-25 10:03:16.000000000 +0000
> @@ -35,6 +35,10 @@
>  		 */
>  		.fill	0x400
>  
> +		/* The following two symbols are used for kernel profiling. */
> +		EXPORT(stext)
> +		EXPORT(_stext)
> +
>  		__INIT
>  
>  		/* Cache Error */
> @@ -144,9 +148,6 @@ ejtag_return:
>  		 */
>  		NESTED(kernel_entry, 16, sp)
>  		.set	noreorder
> -		/* The following two symbols are used for kernel profiling. */
> -		EXPORT(stext)
> -		EXPORT(_stext)
>  
>  		/*
>  		 * Stack for kernel and init, current variable
> 

Yes, works.

Just one nit while we're at it:
On most systems the .fill 0x400 is unnecessary  and wastes 1KB (more
than the .text.init size of head.o). Wouldn't it be better to remove the
.fill and require the LOADADDR in arch/mips/Makefile to be >= 0x80000400?


Johannes

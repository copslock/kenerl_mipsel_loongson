Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Nov 2006 15:11:55 +0000 (GMT)
Received: from phoenix.bawue.net ([193.7.176.60]:20695 "EHLO mail.bawue.net")
	by ftp.linux-mips.org with ESMTP id S20038979AbWKXPLt (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 24 Nov 2006 15:11:49 +0000
Received: from lagash (intrt.mips-uk.com [194.74.144.130])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.bawue.net (Postfix) with ESMTP id 37861B8D4C;
	Fri, 24 Nov 2006 16:13:24 +0100 (CET)
Received: from ths by lagash with local (Exim 4.63)
	(envelope-from <ths@networkno.de>)
	id 1Gncij-0000Fu-75; Fri, 24 Nov 2006 15:12:05 +0000
Date:	Fri, 24 Nov 2006 15:12:05 +0000
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	linux-mips@linux-mips.org
Subject: Re: [PATCH 2.6.18] dz: Fixes to make it work
Message-ID: <20061124151205.GA927@networkno.de>
References: <Pine.LNX.4.64N.0611241420500.20948@blysk.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64N.0611241420500.20948@blysk.ds.pg.gda.pl>
User-Agent: Mutt/1.5.13 (2006-08-11)
From:	Thiemo Seufer <ths@networkno.de>
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13256
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

Maciej W. Rozycki wrote:
>  This a set of fixes mostly to make the driver actually work:
> 
> 1. Actually select the line for setting parameters and receiver 
>    disable/enable.
> 2. Select the line for receive and transmit interrupt handling correctly.
> 3. Report the transmitter empty state correctly.
> 4. Set the I/O type of ports correctly.
> 5. Perform polled transmission correctly.
> 6. Don't fix the console line at ttyS3.
> 7. Magic SysRq support.
> 8. Various small bits here and there.
> 
> Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
> ---
>  Tested with a DECstation 2100 (thanks Flo for making this possible).
> 
>  Please apply.
> 
>   Maciej
> 
> patch-2.6.18-dz-13
> diff -up --recursive --new-file linux-2.6.18.macro/drivers/char/decserial.c linux-2.6.18/drivers/char/decserial.c
> --- linux-2.6.18.macro/drivers/char/decserial.c	2006-09-20 03:42:06.000000000 +0000
> +++ linux-2.6.18/drivers/char/decserial.c	2006-11-23 18:29:38.000000000 +0000
> @@ -23,20 +23,12 @@
>  extern int zs_init(void);
>  #endif
>  
> -#ifdef CONFIG_DZ
> -extern int dz_init(void);
> -#endif
> -
>  #ifdef CONFIG_SERIAL_CONSOLE
>  
>  #ifdef CONFIG_ZS
>  extern void zs_serial_console_init(void);
>  #endif
>  
> -#ifdef CONFIG_DZ
> -extern void dz_serial_console_init(void);
> -#endif
> -
>  #endif
>  
>  /* rs_init - starts up the serial interface -
> @@ -46,23 +38,11 @@ extern void dz_serial_console_init(void)
>  
>  int __init rs_init(void)
>  {
> -
> -#if defined(CONFIG_ZS) && defined(CONFIG_DZ)
> +#ifdef ONFIG_ZS
          ^
Minor typo. :-)

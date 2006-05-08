Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 08 May 2006 21:55:29 +0100 (BST)
Received: from fmr18.intel.com ([134.134.136.17]:41658 "EHLO
	orsfmr003.jf.intel.com") by ftp.linux-mips.org with ESMTP
	id S8133523AbWEHUzS (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 8 May 2006 21:55:18 +0100
Received: from orsfmr100.jf.intel.com (orsfmr100.jf.intel.com [10.7.209.16])
	by orsfmr003.jf.intel.com (8.12.10/8.12.10/d: major-outer.mc,v 1.1 2004/09/17 17:50:56 root Exp $) with ESMTP id k48KtBQ0026153;
	Mon, 8 May 2006 20:55:11 GMT
Received: from [134.134.3.210] (ahkok-mobl.jf.intel.com.jf.intel.com [134.134.3.210])
	by orsfmr100.jf.intel.com (8.12.10/8.12.10/d: major-inner.mc,v 1.2 2004/09/17 18:05:01 root Exp $) with ESMTP id k48KtAT1005279;
	Mon, 8 May 2006 20:55:10 GMT
Message-ID: <445FB02D.3020905@intel.com>
Date:	Mon, 08 May 2006 13:55:09 -0700
From:	Auke Kok <auke-jan.h.kok@intel.com>
User-Agent: Mail/News 1.5.0.2 (X11/20060424)
MIME-Version: 1.0
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
CC:	Jeff Garzik <jgarzik@pobox.com>, linux-mips@linux-mips.org,
	linux-net@vger.kernel.org
Subject: Re: [PATCH] Fix RTL8019AS init for Toshiba RBTX49xx boards
References: <444291E9.2070407@ru.mvista.com>	<20060417.110945.59031594.nemoto@toshiba-tops.co.jp>	<444392CF.7070808@ru.mvista.com> <20060418.000918.95064811.anemo@mba.ocn.ne.jp> <4443BD39.4030200@ru.mvista.com> <4443BE71.6090908@ru.mvista.com> <445FA36E.3080500@ru.mvista.com>
In-Reply-To: <445FA36E.3080500@ru.mvista.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.52 on 10.7.209.16
Return-Path: <auke-jan.h.kok@intel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11361
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: auke-jan.h.kok@intel.com
Precedence: bulk
X-list: linux-mips

Hi,

this won't work - first of all patches need to go to netdev and second jeff 
Garzik is offline for another week. Stephan Hemminger is covering for the net 
tree.

Please repost and add these people.

Auke


Sergei Shtylyov wrote:
>    Ensure that 8-bit mode is selected for the on-board Realtek RTL8019AS 
> chip on Toshiba RBHMA4x00, get rid of the duplicate #ifdef's when setting
> ei_status.word16.
>    The chip's datasheet says that the PSTOP register shouldn't exceed 
> 0x60 in
> 8-bit mode -- ensure this too.
> 
> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
> 
> 
> ------------------------------------------------------------------------
> 
> Index: linus/drivers/net/ne.c
> ===================================================================
> --- linus.orig/drivers/net/ne.c
> +++ linus/drivers/net/ne.c
> @@ -139,8 +139,9 @@ bad_clone_list[] __initdata = {
>  
>  #if defined(CONFIG_PLAT_MAPPI)
>  #  define DCR_VAL 0x4b
> -#elif defined(CONFIG_PLAT_OAKS32R)
> -#  define DCR_VAL 0x48
> +#elif defined(CONFIG_PLAT_OAKS32R)  || \
> +   defined(CONFIG_TOSHIBA_RBTX4927) || defined(CONFIG_TOSHIBA_RBTX4938)
> +#  define DCR_VAL 0x48		/* 8-bit mode */
>  #else
>  #  define DCR_VAL 0x49
>  #endif
> @@ -396,10 +397,22 @@ static int __init ne_probe1(struct net_d
>  		/* We must set the 8390 for word mode. */
>  		outb_p(DCR_VAL, ioaddr + EN0_DCFG);
>  		start_page = NESM_START_PG;
> -		stop_page = NESM_STOP_PG;
> +
> +		/*
> +		 * Realtek RTL8019AS datasheet says that the PSTOP register
> +		 * shouldn't exceed 0x60 in 8-bit mode.
> +		 * This chip can be identified by reading the signature from
> +		 * the  remote byte count registers (otherwise write-only)...
> +		 */
> +		if ((DCR_VAL & 0x01) == 0 &&		/* 8-bit mode */
> +		    inb(ioaddr + EN0_RCNTLO) == 0x50 &&
> +		    inb(ioaddr + EN0_RCNTHI) == 0x70)
> +			stop_page = 0x60;
> +		else
> +			stop_page = NESM_STOP_PG;
>  	} else {
>  		start_page = NE1SM_START_PG;
> -		stop_page = NE1SM_STOP_PG;
> +		stop_page  = NE1SM_STOP_PG;
>  	}
>  
>  #if  defined(CONFIG_PLAT_MAPPI) || defined(CONFIG_PLAT_OAKS32R)
> @@ -509,15 +522,9 @@ static int __init ne_probe1(struct net_d
>  	ei_status.name = name;
>  	ei_status.tx_start_page = start_page;
>  	ei_status.stop_page = stop_page;
> -#if defined(CONFIG_TOSHIBA_RBTX4927) || defined(CONFIG_TOSHIBA_RBTX4938)
> -	wordlength = 1;
> -#endif
>  
> -#ifdef CONFIG_PLAT_OAKS32R
> -	ei_status.word16 = 0;
> -#else
> -	ei_status.word16 = (wordlength == 2);
> -#endif
> +	/* Use 16-bit mode only if this wasn't overridden by DCR_VAL */
> +	ei_status.word16 = (wordlength == 2 && (DCR_VAL & 0x01));
>  
>  	ei_status.rx_start_page = start_page + TX_PAGES;
>  #ifdef PACKETBUF_MEMSIZE
> 
> 

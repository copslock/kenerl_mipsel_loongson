Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 May 2008 13:14:37 +0100 (BST)
Received: from h155.mvista.com ([63.81.120.155]:53865 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S20021380AbYEHMOe (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 8 May 2008 13:14:34 +0100
Received: from [192.168.1.234] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id 28BF83ECD; Thu,  8 May 2008 05:14:29 -0700 (PDT)
Message-ID: <4822EE83.9000708@ru.mvista.com>
Date:	Thu, 08 May 2008 16:13:55 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	ralf@linux-mips.org
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] Pb1000: bury the remnants of the PCI code (part 2)
References: <200804292333.47099.sshtylyov@ru.mvista.com>
In-Reply-To: <200804292333.47099.sshtylyov@ru.mvista.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19162
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello, I wrote:

> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

> ---
> Here's the fragment I missed in the initial patch. Combine them if possible...

    So, Ralf, will you apply this patch as is or I need to do something about 
it (like adding log message)?

>  arch/mips/au1000/pb1000/board_setup.c |    7 -------
>  1 files changed, 7 deletions(-)
> 
> Index: linux-2.6/arch/mips/au1000/pb1000/board_setup.c
> ===================================================================
> --- linux-2.6.orig/arch/mips/au1000/pb1000/board_setup.c
> +++ linux-2.6/arch/mips/au1000/pb1000/board_setup.c
> @@ -153,13 +153,6 @@ void __init board_setup(void)
>  	au_writel(0x280E3D07, MEM_STTIME3); /* 250ns cycle time */
>  	au_writel(0x10000000, MEM_STADDR3); /* any PCMCIA select */
>  
> -#ifdef CONFIG_PCI
> -	au_writel(0, PCI_BRIDGE_CONFIG); // set extend byte to 0
> -	au_writel(0, SDRAM_MBAR);        // set mbar to 0
> -	au_writel(0x2, SDRAM_CMD);       // enable memory accesses
> -	au_sync_delay(1);
> -#endif
> -
>  	/* Enable Au1000 BCLK switching - note: sed1356 must not use
>  	 * its BCLK (Au1000 LCLK) for any timings */
>  	switch (prid & 0x000000FF)
> 

WBR, Sergei

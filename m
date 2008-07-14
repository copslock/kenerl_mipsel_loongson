Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Jul 2008 14:34:44 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:56237 "EHLO
	ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk") by ftp.linux-mips.org
	with ESMTP id S20038809AbYGNNel (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 14 Jul 2008 14:34:41 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk (8.14.2/8.14.1) with ESMTP id m6EDYmEY006060;
	Mon, 14 Jul 2008 14:34:48 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.2/8.14.2/Submit) id m6EDYleC006059;
	Mon, 14 Jul 2008 14:34:47 +0100
Date:	Mon, 14 Jul 2008 14:34:47 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] Remove mips_machtype from ARC based machines
Message-ID: <20080714133447.GA5963@linux-mips.org>
References: <20080714131140.6B5E0DE7BA@solo.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080714131140.6B5E0DE7BA@solo.franken.de>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19824
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Jul 14, 2008 at 03:11:40PM +0200, Thomas Bogendoerfer wrote:

> diff --git a/arch/mips/jazz/setup.c b/arch/mips/jazz/setup.c
> index f136c8a..f60524e 100644
> --- a/arch/mips/jazz/setup.c
> +++ b/arch/mips/jazz/setup.c
> @@ -76,8 +76,7 @@ void __init plat_mem_setup(void)
>  
>  	set_io_port_base(JAZZ_PORT_BASE);
>  #ifdef CONFIG_EISA
> -	if (mips_machtype == MACH_MIPS_MAGNUM_4000)
> -		EISA_bus = 1;
> +	EISA_bus = 1;
>  #endif

It may be a little academic at this stage but the Acer PICA has no EISA
but just ISA slots.

  Ralf

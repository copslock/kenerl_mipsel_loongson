Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 30 Oct 2007 07:34:18 +0000 (GMT)
Received: from sorrow.cyrius.com ([65.19.161.204]:60432 "EHLO
	sorrow.cyrius.com") by ftp.linux-mips.org with ESMTP
	id S20023491AbXJ3HeK (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 30 Oct 2007 07:34:10 +0000
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id 24BBED8C8; Tue, 30 Oct 2007 07:34:04 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id B829B54501; Tue, 30 Oct 2007 08:33:49 +0100 (CET)
Date:	Tue, 30 Oct 2007 08:33:49 +0100
From:	Martin Michlmayr <tbm@cyrius.com>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: Re: [PATCH] IP22: Disable EARLY PRINTK, because it breaks serial
	console
Message-ID: <20071030073349.GA15984@deprecation.cyrius.com>
References: <20070911104459.GB7624@alpha.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070911104459.GB7624@alpha.franken.de>
User-Agent: Mutt/1.5.16 (2007-06-11)
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17302
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

* Thomas Bogendoerfer <tsbogend@alpha.franken.de> [2007-09-11 12:44]:
> Disable EARLY PRINTK, because it breaks serial console

Ralf, at the moment IP22 output stops after "Serial: IP22 Zilog driver
(1 chips).".  Can you put this patch in until there's a real fix?

Tested-by: Martin Michlmayr <tbm@cyrius.com>

> Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> ---
>  arch/mips/Kconfig |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index 3b807b4..1f0502d 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -334,7 +334,6 @@ config SGI_IP22
>  	select SWAP_IO_SPACE
>  	select SYS_HAS_CPU_R4X00
>  	select SYS_HAS_CPU_R5000
> -	select SYS_HAS_EARLY_PRINTK
>  	select SYS_SUPPORTS_32BIT_KERNEL
>  	select SYS_SUPPORTS_64BIT_KERNEL
>  	select SYS_SUPPORTS_BIG_ENDIAN
> -- 
> 1.4.4.4
> 
> -- 
> Crap can work. Given enough thrust pigs will fly, but it's not necessary a
> good idea.                                                [ RFC1925, 2.3 ]

-- 
Martin Michlmayr
http://www.cyrius.com/

Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Feb 2005 11:25:46 +0000 (GMT)
Received: from extgw-uk.mips.com ([IPv6:::ffff:62.254.210.129]:12306 "EHLO
	mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225359AbVBWLZb>; Wed, 23 Feb 2005 11:25:31 +0000
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by mail.linux-mips.net (8.13.1/8.13.1) with ESMTP id j1NBJI9g008085;
	Wed, 23 Feb 2005 11:19:18 GMT
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.1/8.13.1/Submit) id j1NBJIna008084;
	Wed, 23 Feb 2005 11:19:18 GMT
Date:	Wed, 23 Feb 2005 11:19:18 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Ulrich Eckhardt <eckhardt@satorlaser.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [patch] generate error when trying to compile PCMCIA driver without 64 bit addresses
Message-ID: <20050223111918.GC6327@linux-mips.org>
References: <200502230947.53588.eckhardt@satorlaser.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200502230947.53588.eckhardt@satorlaser.com>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7318
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Feb 23, 2005 at 09:47:53AM +0100, Ulrich Eckhardt wrote:

> PCMCIA controller registers are mapped in an area that requires the upper four 
> of the 36 bit addresses, so this can't work without 64 bit physical address 
> support. Sick thing is that due to some stupid casts the whole thing compiles 
> without warnings even without 64 bit support but of course doesn't run. 
> However, that's a topic for a different patch.

> +#if !defined(CONFIG_64BIT_PHYS_ADDR)
> +#  error "need 64bit physical address support to access PCMCIA controller"
> +#endif
> +
>  #define AU1000_PCMCIA_POLL_PERIOD    (2*HZ)
>  #define AU1000_PCMCIA_IO_SPEED       (255)
>  #define AU1000_PCMCIA_MEM_SPEED      (300)

No.  In drivers/pcmcia/Kconfig do something like:

config PCMCIA_AU1X00
        tristate "Au1x00 pcmcia support"
	select 64BIT_PHYS_ADDR
        depends on SOC_AU1X00 && PCMCIA

  Ralf

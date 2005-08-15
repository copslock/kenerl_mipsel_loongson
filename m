Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Aug 2005 15:55:45 +0100 (BST)
Received: from extgw-uk.mips.com ([IPv6:::ffff:62.254.210.129]:20486 "EHLO
	bacchus.net.dhis.org") by linux-mips.org with ESMTP
	id <S8225944AbVHOOz3>; Mon, 15 Aug 2005 15:55:29 +0100
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.1) with ESMTP id j7FExx8C027807;
	Mon, 15 Aug 2005 15:59:59 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.4/8.13.4/Submit) id j7FExwaq027806;
	Mon, 15 Aug 2005 15:59:58 +0100
Date:	Mon, 15 Aug 2005 15:59:57 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org
Subject: Re: include/asm-mips/pci.h fix
Message-ID: <20050815145957.GD2727@linux-mips.org>
References: <20050805.225805.25908929.anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050805.225805.25908929.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8749
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Aug 05, 2005 at 10:58:05PM +0900, Atsushi Nemoto wrote:

> Currently pci_unmap_addr(), etc. are always defined as nop.  It should
> be defined when pci_unmap_single is not a nop.  Here is a patch.
> 
> diff -ur linux-mips/include/asm-mips/pci.h linux/include/asm-mips/pci.h
> --- linux-mips/include/asm-mips/pci.h	2005-07-26 22:14:07.000000000 +0900
> +++ linux/include/asm-mips/pci.h	2005-08-05 22:33:14.000000000 +0900
> @@ -94,7 +94,7 @@
>   */
>  extern unsigned int PCI_DMA_BUS_IS_PHYS;
>  
> -#ifdef CONFIG_MAPPED_DMA_IO

Almost correct, this be enabled for any variant of non-coherent DMA, so
I'm going to checkin a different patch.

Thanks,

  Ralf

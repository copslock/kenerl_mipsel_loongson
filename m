Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Mar 2007 22:30:17 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:56793 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20021975AbXCSWaQ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 19 Mar 2007 22:30:16 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id l2JMSGii016923;
	Mon, 19 Mar 2007 22:28:17 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id l2JMSEvd016922;
	Mon, 19 Mar 2007 22:28:14 GMT
Date:	Mon, 19 Mar 2007 22:28:14 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Cc:	mbizon@freebox.fr, linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH] Always use virt_to_phys() when translating kernel addresses [take #2]
Message-ID: <20070319222814.GA16895@linux-mips.org>
References: <45FE5ADA.3030309@innova-card.com> <1174320169.32046.113.camel@sakura.staff.proxad.net> <cda58cb80703190916g7851000dn7defeaa09eb038f@mail.gmail.com> <45FEBC1A.8070604@innova-card.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45FEBC1A.8070604@innova-card.com>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14572
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Mar 19, 2007 at 05:36:42PM +0100, Franck Bui-Huu wrote:

> diff --git a/include/asm-mips/mach-generic/dma-coherence.h b/include/asm-mips/mach-generic/dma-coherence.h
> index 76e04e7..3a2ac54 100644
> --- a/include/asm-mips/mach-generic/dma-coherence.h
> +++ b/include/asm-mips/mach-generic/dma-coherence.h
> @@ -28,6 +28,13 @@ static inline unsigned long plat_dma_addr_to_phys(dma_addr_t dma_addr)
>  	return dma_addr;
>  }
>  
> +static inline unsigned long plat_dma_addr_to_virt(dma_addr_t dma_addr)
> +{
> +	unsigned long addr = plat_dma_addr_to_phys(dma_addr);
> +
> +	return (unsigned long)phys_to_virt(addr);
> +}
> +

Putting this function into include/asm-mips/mach-generic/dma-coherence.h
breaks the build for all machines that don't include this header.  I
applied your patch with this issue fixed.

  Ralf

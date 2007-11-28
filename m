Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Nov 2007 14:35:03 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:10646 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20030856AbXK1OfB (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 28 Nov 2007 14:35:01 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id lASEZ0jw025127;
	Wed, 28 Nov 2007 14:35:00 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id lASEYxvo025126;
	Wed, 28 Nov 2007 14:34:59 GMT
Date:	Wed, 28 Nov 2007 14:34:59 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] IP28 support
Message-ID: <20071128143459.GA22943@linux-mips.org>
References: <20071126224004.D885AC2B26@solo.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20071126224004.D885AC2B26@solo.franken.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17629
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Nov 26, 2007 at 11:40:04PM +0100, Thomas Bogendoerfer wrote:

> Add support for SGI IP28 machines (Indigo 2 with R10k CPUs)
> This work is mainly based on Peter Fuersts work.
> 
> Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>

Wonderful, this is all looking quite sane now.

 drivers/char/Kconfig                               |    2 
 drivers/input/serio/i8042.h                        |    2 
 drivers/net/Kconfig                                |    2 
 drivers/scsi/Kconfig                               |    2 
 drivers/serial/Kconfig                             |    8 
 drivers/watchdog/Kconfig                           |    2 
 fs/partitions/Kconfig                              |    2 

As just discussed on IRC this all should go via the respective maintainers
or where none is available via akpm + lkml.

> diff --git a/include/asm-mips/dma.h b/include/asm-mips/dma.h
> index 833437d..80caf6b 100644
> --- a/include/asm-mips/dma.h
> +++ b/include/asm-mips/dma.h
> @@ -88,6 +88,9 @@
>  /* Horrible hack to have a correct DMA window on IP22 */
>  #include <asm/sgi/mc.h>
>  #define MAX_DMA_ADDRESS		(PAGE_OFFSET + SGIMC_SEG0_BADDR + 0x01000000)
> +#elif defined(CONFIG_SGI_IP28)
> +#include <asm/sgi/mc.h>
> +#define MAX_DMA_ADDRESS		(PAGE_OFFSET + SGIMC_SEG1_BADDR + 0x01000000)
>  #else
>  #define MAX_DMA_ADDRESS		(PAGE_OFFSET + 0x01000000)
>  #endif

I've always been wondering if the even the IP22 segment was correct at
all.  Afair nobody ever had (E)ISA DMA working on Indigo 2 so that code
is a shot into the dark.  Of course for now it's the sanest thing to
assume that IP28 is the same as the "classic" Indigo 2.

  Ralf

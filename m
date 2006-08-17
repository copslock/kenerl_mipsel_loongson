Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Aug 2006 16:05:20 +0100 (BST)
Received: from h155.mvista.com ([63.81.120.155]:63120 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S20037496AbWHQPFR (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 17 Aug 2006 16:05:17 +0100
Received: from [192.168.1.248] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id 0A88F3ED5; Thu, 17 Aug 2006 08:04:59 -0700 (PDT)
Message-ID: <44E485E2.40108@ru.mvista.com>
Date:	Thu, 17 Aug 2006 19:06:10 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Vitaly Wool <vitalywool@gmail.com>
Cc:	ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: [PATCH/RFC] fix compilation breakage for PNX8550: conservative
 variant
References: <20060817181137.45680622.vitalywool@gmail.com>
In-Reply-To: <20060817181137.45680622.vitalywool@gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12352
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Vitaly Wool wrote:

> taken into account what Sergey told me wrt kgdb code for pnx8550,  I've made the second attempt to make it work. So, inlined is the patch that only restores the pnx8550 compilation and removes dependency on BROKEN for 
that target.
> I've verified that the target will boot up to mounting the NFS filesystem if this patch is applied.

>  Signed-off-by: Vitaly Wool <vitalywool@gmail.com>

>  arch/mips/Kconfig                           |    2 
>  arch/mips/philips/pnx8550/common/Makefile   |    2 
>  arch/mips/philips/pnx8550/common/int.c      |    9 ++-
>  arch/mips/philips/pnx8550/common/mipsIRQ.S  |   76 ++++++++++++++++++++++++++++
>  arch/mips/philips/pnx8550/common/platform.c |    4 -
>  arch/mips/philips/pnx8550/common/setup.c    |    2 
>  include/asm-mips/mach-pnx8550/uart.h        |   14 +++++
>  7 files changed, 99 insertions(+), 10 deletions(-)

> Index: powerpc.git/arch/mips/philips/pnx8550/common/setup.c
> ===================================================================
> --- powerpc.git.orig/arch/mips/philips/pnx8550/common/setup.c
> +++ powerpc.git/arch/mips/philips/pnx8550/common/setup.c
> @@ -56,7 +56,7 @@ extern char *prom_getcmdline(void);
>  
>  struct resource standard_io_resources[] = {
>  	{
> -		.start	= .0x00,
> +		.start	= 0x00,
>  		.end	= 0x1f,
>  		.name	= "dma1",
>  		.flags	= IORESOURCE_BUSY

    Right, there should be no FP in kernel! :-D

> Index: powerpc.git/arch/mips/philips/pnx8550/common/int.c
> Index: powerpc.git/arch/mips/philips/pnx8550/common/mipsIRQ.S
> ===================================================================
> --- /dev/null
> +++ powerpc.git/arch/mips/philips/pnx8550/common/mipsIRQ.S
> @@ -0,0 +1,76 @@
> +/*
> + * Copyright (c) 2002 Philips, Inc. All rights.
> + * Copyright (c) 2002 Red Hat, Inc. All rights.
> + *
> + * This software may be freely redistributed under the terms of the
> + * GNU General Public License.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
> + *
> + * Based upon arch/mips/galileo-boards/ev64240/int-handler.S
> + *
> + */

    I guess Ralf has something to say on this file... :-)

> +#include <asm/asm.h>
> +#include <asm/mipsregs.h>
> +#include <asm/addrspace.h>
> +#include <asm/regdef.h>
> +#include <asm/stackframe.h>
> +
> +/*
> + * cp0_irqdispatch
> + *
> + *    Code to handle in-core interrupt exception.
> + */
> +
> +		.align	5
> +		.set	reorder
> +		.set	noat
> +		NESTED(cp0_irqdispatch, PT_SIZE, sp)
> +		SAVE_ALL
> +		CLI
> +		.set	at
> +		mfc0	t0,CP0_CAUSE
> +		mfc0	t2,CP0_STATUS
> +
> +		and	t0,t2
> +
> +		andi	t1,t0,STATUSF_IP2 /* int0 hardware line */
> +		bnez	t1,ll_hw0_irq
> +		nop

    I don't see much sense in nops with "set .reorder"...

> Index: powerpc.git/include/asm-mips/mach-pnx8550/uart.h
> ===================================================================
> --- powerpc.git.orig/include/asm-mips/mach-pnx8550/uart.h
> +++ powerpc.git/include/asm-mips/mach-pnx8550/uart.h
> @@ -13,4 +13,18 @@
>  #define PNX8550_UART_INT(x)		(PNX8550_INT_GIC_MIN+19+x)
>  #define IRQ_TO_UART(x)			(x-PNX8550_INT_GIC_MIN-19)
>  
> +/* early macros needed for prom/kgdb */
> +
> +#define ip3106_lcr(base,port)    *(volatile u32 *)(base+(port*0x1000) + 0x000)
> +#define ip3106_mcr(base, port)   *(volatile u32 *)(base+(port*0x1000) + 0x004)
> +#define ip3106_baud(base, port)  *(volatile u32 *)(base+(port*0x1000) + 0x008)
> +#define ip3106_cfg(base, port)   *(volatile u32 *)(base+(port*0x1000) + 0x00C)
> +#define ip3106_fifo(base, port)	 *(volatile u32 *)(base+(port*0x1000) + 0x028)
> +#define ip3106_istat(base, port) *(volatile u32 *)(base+(port*0x1000) + 0xFE0)
> +#define ip3106_ien(base, port)   *(volatile u32 *)(base+(port*0x1000) + 0xFE4)
> +#define ip3106_iclr(base, port)  *(volatile u32 *)(base+(port*0x1000) + 0xFE8)
> +#define ip3106_iset(base, port)  *(volatile u32 *)(base+(port*0x1000) + 0xFEC)
> +#define ip3106_pd(base, port)    *(volatile u32 *)(base+(port*0x1000) + 0xFF4)
> +#define ip3106_mid(base, port)   *(volatile u32 *)(base+(port*0x1000) + 0xFFC)
> +
>  #endif

    Ugh, LCR ar offset 0... This can't be called 16550 compatible whatever
Philips might think. Especially taking into account that its bit fields are
laid out differently. :-)

WBR, Sergei

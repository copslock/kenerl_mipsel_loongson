Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Aug 2016 17:06:32 +0200 (CEST)
Received: from pmta2.delivery5.ore.mailhop.org ([54.186.218.12]:28277 "EHLO
        pmta2.delivery5.ore.mailhop.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992087AbcHOPGUsd39f (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 15 Aug 2016 17:06:20 +0200
X-MHO-User: 0667ac43-62fa-11e6-8929-8ded99d5e9d7
X-Report-Abuse-To: https://support.duocircle.com/support/solutions/articles/5000540958-duocircle-standard-smtp-abuse-information
X-Originating-IP: 74.99.77.15
X-Mail-Handler: DuoCircle Outbound SMTP
Received: from io (unknown [74.99.77.15])
        by outbound2.ore.mailhop.org (Halon Mail Gateway) with ESMTPSA;
        Mon, 15 Aug 2016 15:07:46 +0000 (UTC)
Received: from io.lakedaemon.net (localhost [127.0.0.1])
        by io (Postfix) with ESMTP id D874780071;
        Mon, 15 Aug 2016 15:06:13 +0000 (UTC)
X-DKIM: OpenDKIM Filter v2.6.8 io D874780071
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lakedaemon.net;
        s=mail; t=1471273573;
        bh=Qm60lqkmRUNYYiCd7qTHrGVCHJ2hBDE5xThwtt4pdRc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=uw5j7id4v/HNdvxUSeRmbZLJb3xvzLjlBZUfHKEU5SNp/PDNTWQ9y/DMm8a1QSUwE
         WKntlPJh9b3x06wCbllumhNBGQFeut8s+PfrPASl8mB4VngceJL6x2hbsNgmps+h/2
         qJdMJSqPsay//c2yyWpAtpsXFiFiso/+sqafsgUXjYAPQRVudz18SMpb2jYv4CC07k
         5E8Q/d9Sqg9VPaA61mmdzRXu3VA86IwUjz0Fha6M3yd25hyjOtIGMjWKHq41Fc1inb
         nU8BxWk3CpQqzhpdeRgIKKpFsN+wUh7QeWqyY/DolLrnRvMOXY27W0Nj0TMC4cZ4MO
         o4lxcq+8fAQrw==
Date:   Mon, 15 Aug 2016 15:06:13 +0000
From:   Jason Cooper <jason@lakedaemon.net>
To:     Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
Cc:     monstr@monstr.eu, ralf@linux-mips.org, tglx@linutronix.de,
        marc.zyngier@arm.com, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 1/9] microblaze: irqchip: Move intc driver to irqchip
Message-ID: <20160815150613.GB3353@io.lakedaemon.net>
References: <1471269335-58747-1-git-send-email-Zubair.Kakakhel@imgtec.com>
 <1471269335-58747-2-git-send-email-Zubair.Kakakhel@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1471269335-58747-2-git-send-email-Zubair.Kakakhel@imgtec.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <jason@lakedaemon.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54546
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jason@lakedaemon.net
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

Hi Zubair,

On Mon, Aug 15, 2016 at 02:55:27PM +0100, Zubair Lutfullah Kakakhel wrote:
> The Xilinx AXI Interrupt Controller IP block is used by the MIPS
> based xilfpga platform.
> 
> Move the interrupt controller code out of arch/microblaze so that
> it can be used by everyone
> 
> Signed-off-by: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
> ---
>  arch/microblaze/Kconfig                                       | 1 +
>  arch/microblaze/kernel/Makefile                               | 2 +-
>  drivers/irqchip/Kconfig                                       | 4 ++++
>  drivers/irqchip/Makefile                                      | 1 +
>  arch/microblaze/kernel/intc.c => drivers/irqchip/irq-xilinx.c | 0
>  5 files changed, 7 insertions(+), 1 deletion(-)
>  rename arch/microblaze/kernel/intc.c => drivers/irqchip/irq-xilinx.c (100%)

How about irq-axi-intc.c?

> diff --git a/arch/microblaze/Kconfig b/arch/microblaze/Kconfig
> index 86f6572..198e921 100644
> --- a/arch/microblaze/Kconfig
> +++ b/arch/microblaze/Kconfig
> @@ -27,6 +27,7 @@ config MICROBLAZE
>  	select HAVE_MEMBLOCK_NODE_MAP
>  	select HAVE_OPROFILE
>  	select IRQ_DOMAIN
> +	select XILINX_IRQ
>  	select MODULES_USE_ELF_RELA
>  	select OF
>  	select OF_EARLY_FLATTREE
> diff --git a/arch/microblaze/kernel/Makefile b/arch/microblaze/kernel/Makefile
> index f08baca..e098381 100644
> --- a/arch/microblaze/kernel/Makefile
> +++ b/arch/microblaze/kernel/Makefile
> @@ -15,7 +15,7 @@ endif
>  extra-y := head.o vmlinux.lds
>  
>  obj-y += dma.o exceptions.o \
> -	hw_exception_handler.o intc.o irq.o \
> +	hw_exception_handler.o irq.o \
>  	platform.o process.o prom.o ptrace.o \
>  	reset.o setup.o signal.o sys_microblaze.o timer.o traps.o unwind.o
>  
> diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
> index 7f87289..b5e40ee 100644
> --- a/drivers/irqchip/Kconfig
> +++ b/drivers/irqchip/Kconfig
> @@ -203,6 +203,10 @@ config XTENSA_MX
>  	bool
>  	select IRQ_DOMAIN
>  
> +config XILINX_IRQ

XILINX_AXI_INTC ?

thx,

Jason.

> +	bool
> +	select IRQ_DOMAIN
> +
>  config IRQ_CROSSBAR
>  	bool
>  	help
> diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
> index 4c203b6..2bd833d 100644
> --- a/drivers/irqchip/Makefile
> +++ b/drivers/irqchip/Makefile
> @@ -51,6 +51,7 @@ obj-$(CONFIG_TB10X_IRQC)		+= irq-tb10x.o
>  obj-$(CONFIG_TS4800_IRQ)		+= irq-ts4800.o
>  obj-$(CONFIG_XTENSA)			+= irq-xtensa-pic.o
>  obj-$(CONFIG_XTENSA_MX)			+= irq-xtensa-mx.o
> +obj-$(CONFIG_XILINX_IRQ)		+= irq-xilinx.o
>  obj-$(CONFIG_IRQ_CROSSBAR)		+= irq-crossbar.o
>  obj-$(CONFIG_SOC_VF610)			+= irq-vf610-mscm-ir.o
>  obj-$(CONFIG_BCM6345_L1_IRQ)		+= irq-bcm6345-l1.o
> diff --git a/arch/microblaze/kernel/intc.c b/drivers/irqchip/irq-xilinx.c
> similarity index 100%
> rename from arch/microblaze/kernel/intc.c
> rename to drivers/irqchip/irq-xilinx.c
> -- 
> 1.9.1
> 

Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Dec 2006 13:15:58 +0000 (GMT)
Received: from h155.mvista.com ([63.81.120.155]:62047 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S20038409AbWLFNPy (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 6 Dec 2006 13:15:54 +0000
Received: from [192.168.1.248] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id BD6FD3EC9; Wed,  6 Dec 2006 05:15:51 -0800 (PST)
Message-ID: <4576C2E9.4060900@ru.mvista.com>
Date:	Wed, 06 Dec 2006 16:17:29 +0300
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	anemo@mba.sphere.ne.jp
Cc:	ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: [PATCH] Import updates from i386's i8259.c
References: <20061206.103923.71086192.nemoto@toshiba-tops.co.jp>	<20061206015818.GB27985@linux-mips.org>	<20061206.115602.63741871.nemoto@toshiba-tops.co.jp> <20061206.133836.89067271.nemoto@toshiba-tops.co.jp>
In-Reply-To: <20061206.133836.89067271.nemoto@toshiba-tops.co.jp>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13367
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

anemo@mba.sphere.ne.jp wrote:

> Import many updates from i386's i8259.c, especially genirq
> transitions.

> Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
> ---
> diff --git a/arch/mips/kernel/i8259.c b/arch/mips/kernel/i8259.c
> index 2526c0c..85ca2a9 100644
> --- a/arch/mips/kernel/i8259.c
> +++ b/arch/mips/kernel/i8259.c
[...]
> @@ -31,23 +28,16 @@ void disable_8259A_irq(unsigned int irq)
>   * moves to arch independent land
>   */
>  
> +static int i8259A_auto_eoi;
>  DEFINE_SPINLOCK(i8259A_lock);
> -
> -static void end_8259A_irq (unsigned int irq)
> -{
> -	if (!(irq_desc[irq].status & (IRQ_DISABLED|IRQ_INPROGRESS)) &&
> -	    irq_desc[irq].action)
> -		enable_8259A_irq(irq);
> -}
> -
> +/* some platforms call this... */
>  void mask_and_ack_8259A(unsigned int);
>  
> -static struct irq_chip i8259A_irq_type = {
> -	.typename = "XT-PIC",
> -	.enable = enable_8259A_irq,
> -	.disable = disable_8259A_irq,
> -	.ack = mask_and_ack_8259A,
> -	.end = end_8259A_irq,
> +static struct irq_chip i8259A_chip = {
> +	.name		= "XT-PIC",
> +	.mask		= disable_8259A_irq,
> +	.unmask		= enable_8259A_irq,
> +	.mask_ack	= mask_and_ack_8259A,
>  };

    I wonder whose idea was to call this device XT-PIC. XT never had dual 
8259A PICs and so was capable of handling only 8 IRQs. Dual 8259A was first 
used in the AT class machines...

> @@ -84,23 +74,23 @@ void enable_8259A_irq(unsigned int irq)
>  	spin_lock_irqsave(&i8259A_lock, flags);
>  	cached_irq_mask &= mask;
>  	if (irq & 8)
> -		outb(cached_A1,0xA1);
> +		outb(cached_slave_mask, PIC_SLAVE_IMR);
>  	else
> -		outb(cached_21,0x21);
> +		outb(cached_master_mask, PIC_MASTER_IMR);
>  	spin_unlock_irqrestore(&i8259A_lock, flags);
>  }
>  
>  int i8259A_irq_pending(unsigned int irq)
>  {
> -	unsigned int mask = 1 << irq;
> +	unsigned int mask = 1<<irq;

    Unnecassary, to say the least.

> @@ -109,7 +99,8 @@ int i8259A_irq_pending(unsigned int irq)
>  void make_8259A_irq(unsigned int irq)
>  {
>  	disable_irq_nosync(irq);
> -	set_irq_chip(irq, &i8259A_irq_type);
> +	set_irq_chip_and_handler_name(irq, &i8259A_chip, handle_level_irq,
> +				      "XT");

    No! Do not evoke the memory of XT anymore, let it rest in peace at last!
Call it 8259A, please.

> @@ -122,17 +113,17 @@ void make_8259A_irq(unsigned int irq)
>  static inline int i8259A_irq_real(unsigned int irq)
>  {
>  	int value;
> -	int irqmask = 1 << irq;
> +	int irqmask = 1<<irq;

    Unnecessary too.

> @@ -214,15 +207,52 @@ spurious_8259A_irq:
>  	}
>  }
>  
> +static char irq_trigger[2];
> +/**
> + * ELCR registers (0x4d0, 0x4d1) control edge/level of IRQ
> + */
> +static void restore_ELCR(char *trigger)
> +{
> +	outb(trigger[0], 0x4d0);
> +	outb(trigger[1], 0x4d1);
> +}
> +
> +static void save_ELCR(char *trigger)
> +{
> +	/* IRQ 0,1,2,8,13 are marked as reserved */
> +	trigger[0] = inb(0x4d0) & 0xF8;
> +	trigger[1] = inb(0x4d1) & 0xDE;

    Erm, the bits should be zero, why mask them out I wonder...

WBR, Sergei

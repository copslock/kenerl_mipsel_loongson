Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 03 Nov 2008 12:22:56 +0000 (GMT)
Received: from h155.mvista.com ([63.81.120.155]:64207 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S23005096AbYKBV40 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 2 Nov 2008 21:56:26 +0000
Received: from [127.0.0.1] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id EAFE93EC9; Sun,  2 Nov 2008 13:56:21 -0800 (PST)
Message-ID: <490E2200.1070201@ru.mvista.com>
Date:	Mon, 03 Nov 2008 00:56:16 +0300
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
User-Agent: Thunderbird 2.0.0.17 (Windows/20080914)
MIME-Version: 1.0
To:	Phil Sutter <n0-1@freewrt.org>
Cc:	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH] provide functions for gpio configuration
References: <1225412757-17894-1-git-send-email-n0-1@freewrt.org> <1225465088-29365-1-git-send-email-n0-1@freewrt.org>
In-Reply-To: <1225465088-29365-1-git-send-email-n0-1@freewrt.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21167
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Phil Sutter wrote:

> As gpiolib doesn't support pin multiplexing, it provides no way to
> access the GPIOFUNC register. Also there is no support for setting
> interrupt status and level. These functions provide access to them and
> are needed by the CompactFlash driver.
>
> This is a combined version of the first two patches send in this thread
> on the linux-mips mailinglist. It's also addressing the conflict
> generated due to the change in arch/mips/include/asm/mach-rc32434/rb.h.
> Though this patch depends on it, it has been moved to another
> (yet uncommitted) patch changing the same part of rb.h.
>
> Signed-off-by: Phil Sutter <n0-1@freewrt.org>
>   

   NAK, some of the code is wrong.

> diff --git a/arch/mips/rb532/gpio.c b/arch/mips/rb532/gpio.c
> index 76a7fd9..de29aba 100644
> --- a/arch/mips/rb532/gpio.c
> +++ b/arch/mips/rb532/gpio.c
>   
[...]
> @@ -111,15 +107,47 @@ unsigned char get_latch_u5(void)
>  }
>  EXPORT_SYMBOL(get_latch_u5);
>  
> +/* rb532_set_bit - sanely set a bit
> + * 
> + * bitval: new value for the bit
> + * offset: bit index in the 4 byte address range
> + * ioaddr: 4 byte aligned address being altered
> + */
> +static inline void rb532_set_bit(unsigned bitval,
> +		unsigned offset, void __iomem *ioaddr)
> +{
> +	unsigned long flags;
> +	u32 val;
> +
> +	bitval = !!bitval;              /* map parameter to {0,1} */
> +
> +	local_irq_save(flags);
> +
> +	val = readl(ioaddr);
> +	val &= ~( ~bitval << offset );   /* unset bit if bitval == 0 */
>   

   If bitval == 0, ~bitval evaluates to all ones, and the final AND mask 
~(0xffffffff << offset) clears 32-offset MSBs. What you want is simply 
~(1 << offset).

> +	val |=  (  bitval << offset );   /* set bit if bitval == 1 */
>   

   And don't put spaces before ) and after (, checkpatch.pl wouldn't 
approve that. ;-)

> @@ -176,117 +184,60 @@ static int rb532_gpio_direction_input(struct gpio_chip *chip, unsigned offset)
>  static int rb532_gpio_direction_output(struct gpio_chip *chip,
>  					unsigned offset, int value)
>  {
> -	unsigned long		flags;
> -	u32			mask = 1 << offset;
> -	u32			tmp;
>  	struct rb532_gpio_chip	*gpch;
> -	void __iomem		*gpdr;
>  
>  	gpch = container_of(chip, struct rb532_gpio_chip, chip);
> -	writel(mask, gpch->regbase + GPIOD);
>   

   Hm, the old code seems really borked here...

MBR, Sergei

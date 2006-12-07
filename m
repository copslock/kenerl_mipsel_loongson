Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Dec 2006 15:45:34 +0000 (GMT)
Received: from h155.mvista.com ([63.81.120.155]:9863 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S20027579AbWLGPp1 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 7 Dec 2006 15:45:27 +0000
Received: from [192.168.1.248] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id 4E46E3EC9; Thu,  7 Dec 2006 07:45:22 -0800 (PST)
Message-ID: <45783772.6030504@ru.mvista.com>
Date:	Thu, 07 Dec 2006 18:46:58 +0300
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Vitaly Wool <vitalywool@gmail.com>
Cc:	ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: [PATCH] add STB810 support (Philips PNX8550-based)
References: <20061207182234.83212939.vitalywool@gmail.com>
In-Reply-To: <20061207182234.83212939.vitalywool@gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13402
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Vitaly Wool wrote:

> please find the patch that adds support for STB810 below.

[...]

> Signed-off-by: Vitaly Wool <vitalywool@gmail.com>

> Index: linux-mips.git/arch/mips/philips/pnx8550/stb810/board_setup.c
> ===================================================================
> --- /dev/null	1970-01-01 00:00:00.000000000 +0000
> +++ linux-mips.git/arch/mips/philips/pnx8550/stb810/board_setup.c	2006-12-07 18:21:04.000000000 +0300
> @@ -0,0 +1,56 @@
[...]
> +/* CP0 hazard avoidance. */
> +#define BARRIER __asm__ __volatile__(".set noreorder\n\t" \
> +				     "nop; nop; nop; nop; nop; nop;\n\t" \
> +				     ".set reorder\n\t")
> +

    Erm, barrier code have been reworked, IIRC. Is there really a need for the 
6-nop custom barrier here?

> +void __init board_setup(void)
> +{
> +	unsigned long config0, configpr;
> +
> +	config0 = read_c0_config();
> +
> +	/* clear all three cache coherency fields */
> +	config0 &= ~(0x7 | (7<<25) | (7<<28));
> +	config0 |= (CONF_CM_DEFAULT | (CONF_CM_DEFAULT<<25) |
> +			(CONF_CM_DEFAULT<<28));
> +	write_c0_config(config0);
> +	BARRIER;
> +
> +	configpr = read_c0_config7();
> +	configpr |= (1<<19); /* enable tlb */
> +	write_c0_config7(configpr);
> +	BARRIER;
> +}
> Index: linux-mips.git/arch/mips/philips/pnx8550/stb810/irqmap.c
> ===================================================================
> --- /dev/null	1970-01-01 00:00:00.000000000 +0000
> +++ linux-mips.git/arch/mips/philips/pnx8550/stb810/irqmap.c	2006-12-07 18:21:04.000000000 +0300
> @@ -0,0 +1,23 @@
[...]
> +char irq_tab_jbs[][5] __initdata = {
> + [8] =  { -1, PNX8550_INT_PCI_INTA, 0xff, 0xff, 0xff},
> + [9] =  { -1, PNX8550_INT_PCI_INTA, 0xff, 0xff, 0xff},
> + [10] = { -1, PNX8550_INT_PCI_INTA, 0xff, 0xff, 0xff},
> +};

    This is somewhat unusual PCI interrupt rounting...

> Index: linux-mips.git/arch/mips/kernel/head.S
> Index: linux-mips.git/arch/mips/configs/pnx8550-stb810_defconfig
> ===================================================================
> --- /dev/null	1970-01-01 00:00:00.000000000 +0000
> +++ linux-mips.git/arch/mips/configs/pnx8550-stb810_defconfig	2006-12-07 18:21:04.000000000 +0300
> @@ -0,0 +1,1777 @@
> +#
> +# Automatically generated make config: don't edit
> +# Linux kernel version: 2.6.19-rc5
> +# Wed Nov  8 13:46:57 2006
> +#
> +CONFIG_ARM=y

    ARM?! Are you sure it's a correct defconfig? ;-)

WBR, Sergei

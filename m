Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Jun 2007 22:13:54 +0100 (BST)
Received: from smtp2.linux-foundation.org ([207.189.120.14]:29931 "EHLO
	smtp2.linux-foundation.org") by ftp.linux-mips.org with ESMTP
	id S20023675AbXFSVNu (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 19 Jun 2007 22:13:50 +0100
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l5JLD1mB006524
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 19 Jun 2007 14:13:03 -0700
Received: from akpm.corp.google.com (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with SMTP id l5JLCuaj021297;
	Tue, 19 Jun 2007 14:12:56 -0700
Date:	Tue, 19 Jun 2007 14:12:56 -0700
From:	Andrew Morton <akpm@linux-foundation.org>
To:	Marc St-Jean <stjeanma@pmc-sierra.com>
Cc:	ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: [PATCH 7/12] drivers: PMC MSP71xx GPIO char driver
Message-Id: <20070619141256.3d573a41.akpm@linux-foundation.org>
In-Reply-To: <200706152046.l5FKk3NU015608@pasqua.pmc-sierra.bc.ca>
References: <200706152046.l5FKk3NU015608@pasqua.pmc-sierra.bc.ca>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-MIMEDefang-Filter: osdl$Revision: 1.181 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Return-Path: <akpm@linux-foundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15476
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: akpm@linux-foundation.org
Precedence: bulk
X-list: linux-mips

On Fri, 15 Jun 2007 14:46:03 -0600
Marc St-Jean <stjeanma@pmc-sierra.com> wrote:

> [PATCH 7/12] drivers: PMC MSP71xx GPIO char driver
> 
> Patch to add a GPIO char driver for the PMC-Sierra MSP71xx devices.


> +const u32 GPIO_DATA_COUNT[] = { 2, 4, 4, 6 };
> +const u32 GPIO_DATA_SHIFT[] = { 0, 2, 6, 10 };
> +const u32 GPIO_DATA_MASK[] = { 0x03, 0x0f, 0x0f, 0x3f };
> +u32 * const GPIO_DATA_REG[] = {
> +	(u32 *)GPIO_DATA1_REG, (u32 *)GPIO_DATA2_REG,
> +	(u32 *)GPIO_DATA3_REG, (u32 *)GPIO_DATA4_REG,
> +};
> +const u32 GPIO_CFG_MASK[] = { 0x0000ff, 0x00ffff, 0x00ffff, 0xffffff };
> +u32 * const GPIO_CFG_REG[] = {
> +	(u32 *)GPIO_CFG1_REG, (u32 *)GPIO_CFG2_REG,
> +	(u32 *)GPIO_CFG3_REG, (u32 *)GPIO_CFG4_REG,
> +};
> +
> +/* Maps MODE to allowed pin mask */
> +const u32 MSP_GPIO_MODE_ALLOWED[] = {
> +	0xfffff,	/* Mode 0 - INPUT */
> +	0x00000,	/* Mode 1 - INTERRUPT */
> +	0x00030,	/* Mode 2 - UART_INPUT (GPIO 4, 5)*/
> +	0, 0, 0, 0, 0,	/* Modes 3, 4, 5, 6, and 7 are reserved */
> +	0xfffff,	/* Mode 8 - OUTPUT */
> +	0x0000f,	/* Mode 9 - UART_OUTPUT/PERF_TIMERA (GPIO 0,1,2,3) */
> +	0x00003,	/* Mode a - PERF_TIMERB (GPIO 0, 1) */
> +	0x00000,	/* Mode b - Not really a mode! */
> +};

all the above should be lower-case and have static scope.

> +#define GPIO_CFG_SHIFT(i)	(i * 4)
> +#define GPIO_CFG_PINMASK	0xf
> +
> +/* The extended gpio register */
> +
> +#define EXTENDED_GPIO_COUNT	4
> +#define EXTENDED_GPIO_SHIFT	16
> +#define EXTENDED_GPIO_MASK	0x0f
> +
> +#define EXTENDED_GPIO_DATA_SHIFT(i)	(i * 2)
> +#define EXTENDED_GPIO_DATA_MASK(i)	(0x3 << (i*2))
> +#define EXTENDED_GPIO_DATA_SET		0x2
> +#define EXTENDED_GPIO_DATA_CLR		0x1
> +#define EXTENDED_GPIO_CFG_SHIFT(i)	((i * 2) + 16)
> +#define EXTENDED_GPIO_CFG_MASK(i)	(0x3 << ((i*2)+16))
> +#define EXTENDED_GPIO_CFG_DISABLE	0x2
> +#define EXTENDED_GPIO_CFG_ENABLE	0x1
> +
> +/* -- Data structures -- */
> +
> +static DEFINE_SPINLOCK(msp_gpio_spinlock);
> +
> +static struct task_struct *msp_blinkthread;
> +static DEFINE_SPINLOCK(msp_blink_lock);
> +static DECLARE_COMPLETION(msp_blink_wait);
> +
> +struct blink_table {
> +	u32 count;
> +	u32 period;
> +	u32 dcycle;
> +};
> +
> +static struct blink_table blink_table[MSP_NUM_GPIOS];
> +
> +/* -- Utility functions -- */
> +
> +/* Define the following for extra debug output */
> +#undef DEBUG

The under shouldn't be needed: -DDEBUG can be provided on the kbuild
command line.

> +#ifdef DEBUG
> +#define DBG(args...) printk(KERN_DEBUG args)
> +#else
> +#define DBG(args...) do {} while (0)
> +#endif
> +
> +/* Reads the data bits from a single register set */
> +static u32 msp_gpio_read_data_basic(int reg)
> +{
> +	return read_reg32(GPIO_DATA_REG[reg], GPIO_DATA_MASK[reg]);
> +}
> +
> +/* Reads the data bits from the extended register set */
> +static u32 msp_gpio_read_data_extended(void)
> +{
> +	int pin;
> +	u32 tmp = *EXTENDED_GPIO_REG;

`tmp' is always a bad name for a variable.

> +	u32 retval = 0;
> +	
> +	for (pin = 0; pin < EXTENDED_GPIO_COUNT; pin++) {
> +		u32 bit = 0;
> +		
> +		/*
> +		 * In output mode, read CLR bit
> +		 * In input mode, read SET bit
> +		 */
> +		if (tmp & (EXTENDED_GPIO_CFG_ENABLE <<
> +				EXTENDED_GPIO_CFG_SHIFT(pin)))
> +			bit = EXTENDED_GPIO_DATA_CLR <<
> +				EXTENDED_GPIO_DATA_SHIFT(pin);
> +		else
> +			bit = EXTENDED_GPIO_DATA_SET <<
> +				EXTENDED_GPIO_DATA_SHIFT(pin);
> +
> +		if (tmp & bit)
> +			retval |= 1 << pin;
> +	}
> +	
> +	return retval;
> +}
> +
> +/*
> + * Reads the current state of all 20 pins, putting the values in
> + * the lowest 20 bits (1=HI, 0=LO)
> + */
> +static u32 msp_gpio_read_data(void)
> +{
> +	int reg;
> +	u32 retval = 0;
> +	
> +	spin_lock(&msp_gpio_spinlock);
> +	for (reg = 0; reg < GPIO_REG_COUNT; reg++)
> +		retval |= msp_gpio_read_data_basic(reg) <<
> +				GPIO_DATA_SHIFT[reg];
> +	retval |= msp_gpio_read_data_extended() << EXTENDED_GPIO_SHIFT;
> +	spin_unlock(&msp_gpio_spinlock);
> +	
> +	DBG("%s: 0x%08x\n", __FUNCTION__, retval);
> +	return retval;
> +}
> +
>
> ...
>
> +/* Maps 'basic' pins to relative offset from 0 per register */
> +static int const MSP_GPIO_OFFSET[] = {
> +	/* GPIO 0 and 1 on the first register */
> +	0, 0,
> +	/* GPIO 2, 3, 4, and 5 on the second register */
> +	2, 2, 2, 2,
> +	/* GPIO 6, 7, 8, and 9 on the third register */
> +	6, 6, 6, 6,
> +	/* GPIO 10, 11, 12, 13, 14, and 15 on the fourth register */
> +	10, 10, 10, 10, 10, 10,
> +};

This shouldn't be in a header file.  Because each compilation unit which
includes this header will (potentially) get its own copy of the data.

That includes any userspace apps which include this header(!)

> +/* This gives you the 'register relative ofet gpio' number */
> +#define OFFSET_GPIO_NUMBER(gpio)	(gpio - MSP_GPIO_OFFSET[gpio])
> +
> +/* These take the 'register relative offset gpio' number */
> +#define BASIC_MODE_REG_SHIFT(ogpio)	(ogpio * 4)
> +#define BASIC_MODE_REG_VALUE(mode, ogpio) \
> +			(mode << BASIC_MODE_REG_SHIFT(ogpio))
> +#define BASIC_MODE_REG_MASK(ogpio) \
> +			BASIC_MODE_REG_VALUE(0xf, ogpio)
> +#define BASIC_DATA_REG_MASK(ogpio)	(1 << ogpio)
> +
> +/* These take the actual GPIO number (0 through 15) */
> +#define BASIC_DATA_MASK(gpio) \
> +		BASIC_DATA_REG_MASK(OFFSET_GPIO_NUMBER(gpio))
> +#define BASIC_MODE_MASK(gpio) \
> +		BASIC_MODE_REG_MASK(OFFSET_GPIO_NUMBER(gpio))
> +#define BASIC_MODE(mode, gpio) \
> +		BASIC_MODE_REG_VALUE(mode, OFFSET_GPIO_NUMBER(gpio))
> +#define BASIC_MODE_SHIFT(gpio) \
> +		BASIC_MODE_REG_SHIFT(OFFSET_GPIO_NUMBER(gpio))
> +#define BASIC_MODE_FROM_REG(data, gpio)	\
> +		BASIC_MODE_REG_FROM_REG(data, OFFSET_GPIO_NUMBER(gpio))
> +
> +/* This gives you the 'register relative offset gpio' number */
> +#define EXTENDED_OFFSET_GPIO(gpio)	(gpio - 16)
> +
> +/* These take the 'register relative offset gpio' number */
> +#define EXTENDED_REG_DISABLE(ogpio)	(0x2 << ((ogpio * 2) + 16))
> +#define EXTENDED_REG_ENABLE(ogpio)	(0x1 << ((ogpio * 2) + 16))
> +#define EXTENDED_REG_SET(ogpio)		(0x2 << (ogpio * 2))
> +#define EXTENDED_REG_CLR(ogpio)		(0x1 << (ogpio * 2))
> +
> +/* These take the actual GPIO number (16 through 19) */
> +#define EXTENDED_DISABLE(gpio) \
> +		EXTENDED_REG_DISABLE(EXTENDED_OFFSET_GPIO(gpio))
> +#define EXTENDED_ENABLE(gpio) \
> +		EXTENDED_REG_ENABLE(EXTENDED_OFFSET_GPIO(gpio))
> +#define EXTENDED_SET(gpio) \
> +		EXTENDED_REG_SET(EXTENDED_OFFSET_GPIO(gpio))
> +#define EXTENDED_CLR(gpio) \
> +		EXTENDED_REG_CLR(EXTENDED_OFFSET_GPIO(gpio))

inlined functions are preferred over macros.  Only use macros when for some
reason you *must* use macros.

Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Sep 2008 12:18:30 +0100 (BST)
Received: from h155.mvista.com ([63.81.120.155]:62956 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S29034195AbYIXLI2 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 24 Sep 2008 12:08:28 +0100
Received: from [127.0.0.1] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id B91FC3ECC; Wed, 24 Sep 2008 04:08:18 -0700 (PDT)
Message-ID: <48DA1F9D.6000501@ru.mvista.com>
Date:	Wed, 24 Sep 2008 15:08:13 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
User-Agent: Thunderbird 2.0.0.16 (Windows/20080708)
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	bzolnier@gmail.com, linux-ide@vger.kernel.org,
	"Maciej W. Rozycki" <macro@linux-mips.org>,
	linux-mips@linux-mips.org
Subject: Re: [PATCH] IDE: Fix platform device registration in Swarm IDE driver
References: <20080922122853.GA15210@linux-mips.org>
In-Reply-To: <20080922122853.GA15210@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20611
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Ralf Baechle wrote:

> The Swarm IDE driver uses a release method which is defined in the driver
> itself thus potencially oopsable.  The simpel fix would be to just leak
>   

   "Potentially" and "simple". :-P

> the device but this patch goes the full length and moves the entire
> handling of the platform device in the platform code and retains only
> the platform driver code in drivers/ide/mips/swarm.c.
>
> Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
> ---
>
> This patch is for 2.6.27.  The same issue exists in -stable but the patch
> won't apply due to other driver changes.
>
>  arch/mips/sibyte/swarm/Makefile   |    3 
>  arch/mips/sibyte/swarm/platform.c |   60 ++++++++++++++++
>  drivers/ide/mips/swarm.c          |  140 +++++++++++---------------------------
>  3 files changed, 104 insertions(+), 99 deletions(-)
>
> Index: linux-mips/arch/mips/sibyte/swarm/platform.c
> ===================================================================
> --- /dev/null
> +++ linux-mips/arch/mips/sibyte/swarm/platform.c
> @@ -0,0 +1,60 @@
>   
[...]
> +static struct resource swarm_ide_resource[] = {
> +	{
> +		.name	= "Swarm GenBus IDE",
> +		.flags	= IORESOURCE_MEM,
> +	}, {
> +		.name	= "Swarm GenBus IDE",
> +		.flags	= IORESOURCE_IRQ,
> +		.start	= K_INT_GB_IDE,
> +		.end	= K_INT_GB_IDE,
> +	},
> +};
> +
> +static int __init swarm_ide_init(void)
> +{
>   
[...]
> +	pdev = platform_device_register_simple(DEV_NAME, -1,
> +		       swarm_ide_resource, ARRAY_SIZE(swarm_ide_resource));
>   

   If you have the resources as static array anyway, why not have the 
device in the static variable too and use platform_device_register()?

> Index: linux-mips/drivers/ide/mips/swarm.c
> ===================================================================
> --- linux-mips.orig/drivers/ide/mips/swarm.c
> +++ linux-mips/drivers/ide/mips/swarm.c
> @@ -46,21 +46,10 @@
>  
>  #include <asm/io.h>
>  
> -#include <asm/sibyte/board.h>
> -#include <asm/sibyte/sb1250_genbus.h>
> -#include <asm/sibyte/sb1250_regs.h>
> -
>  #define DRV_NAME "ide-swarm"
>  
>  static char swarm_ide_string[] = DRV_NAME;
>  
> -static struct resource swarm_ide_resource = {
> -	.name	= "SWARM GenBus IDE",
> -	.flags	= IORESOURCE_MEM,
> -};
> -
> -static struct platform_device *swarm_ide_dev;
>   

   Platform device in the driver itself? Interesting... :-)

> @@ -70,41 +59,18 @@ static const struct ide_port_info swarm_
>   * swarm_ide_probe - if the board header indicates the existence of
>   * Generic Bus IDE, allocate a HWIF for it.
>   */
> -static int __devinit swarm_ide_probe(struct device *dev)
> +static int __devinit swarm_ide_probe(struct platform_device *pdev)
>  {
>  	u8 __iomem *base;
>  	struct ide_host *host;
>  	phys_t offset, size;
> +	struct resource *r;
>  	int i, rc;
>  	hw_regs_t hw, *hws[] = { &hw, NULL, NULL, NULL };
>  
> -	if (!SIBYTE_HAVE_IDE)
> -		return -ENODEV;
> -
> -	base = ioremap(A_IO_EXT_BASE, 0x800);
> -	offset = __raw_readq(base + R_IO_EXT_REG(R_IO_EXT_START_ADDR, IDE_CS));
> -	size = __raw_readq(base + R_IO_EXT_REG(R_IO_EXT_MULT_SIZE, IDE_CS));
> -	iounmap(base);
> -
> -	offset = G_IO_START_ADDR(offset) << S_IO_ADDRBASE;
> -	size = (G_IO_MULT_SIZE(size) + 1) << S_IO_REGSIZE;
> -	if (offset < A_PHYS_GENBUS || offset >= A_PHYS_GENBUS_END) {
> -		printk(KERN_INFO DRV_NAME
> -		       ": IDE interface at GenBus disabled\n");
> -		return -EBUSY;
> -	}
> -
> -	printk(KERN_INFO DRV_NAME ": IDE interface at GenBus slot %i\n",
> -	       IDE_CS);
> -
> -	swarm_ide_resource.start = offset;
> -	swarm_ide_resource.end = offset + size - 1;
> -	if (request_resource(&iomem_resource, &swarm_ide_resource)) {
>   

   Why drop request_resource() completely? Replace it by 
request_mem_region().

MBR, Sergei

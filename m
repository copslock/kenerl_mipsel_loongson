Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 12 Aug 2006 17:34:05 +0100 (BST)
Received: from nf-out-0910.google.com ([64.233.182.185]:39875 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20037826AbWHLQeD (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 12 Aug 2006 17:34:03 +0100
Received: by nf-out-0910.google.com with SMTP id o60so1397552nfa
        for <linux-mips@linux-mips.org>; Sat, 12 Aug 2006 09:34:00 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=IUxcGctV+6etoBIkiVUF+0iDK/2aFSHgwKa7CnUjfnUCp3mY0LQ4J/HEDT7yuTA0dwO0WE/38TGHbOemzNTkexjRfjscPMeMbE9G6aGK99LHUF/F76HAA8eBNyrdQJ5AOi7pC2qyv8bzBSJX+il+PVeUs3orWBjICcmY44Lo0oY=
Received: by 10.48.48.15 with SMTP id v15mr5104826nfv;
        Sat, 12 Aug 2006 09:33:59 -0700 (PDT)
Received: from gmail.com ( [217.67.117.64])
        by mx.gmail.com with ESMTP id o9sm6055838nfa.2006.08.12.09.33.58;
        Sat, 12 Aug 2006 09:33:59 -0700 (PDT)
Received: by gmail.com (nbSMTP-1.00) for uid 1000
	(using TLSv1/SSLv3 with cipher DES-CBC3-SHA (168/168 bits))
	adobriyan@gmail.com; Sat, 12 Aug 2006 20:34:01 +0400 (MSD)
Date:	Sat, 12 Aug 2006 20:33:59 +0400
From:	Alexey Dobriyan <adobriyan@gmail.com>
To:	thomas@koeller.dyndns.org
Cc:	Alan Cox <alan@lxorguk.ukuu.org.uk>, wim@iguana.be,
	linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
	linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS RM9K watchdog driver
Message-ID: <20060812163359.GB6252@martell.zuzino.mipt.ru>
References: <200608121805.52358.thomas@koeller.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200608121805.52358.thomas@koeller.dyndns.org>
User-Agent: Mutt/1.5.11
Return-Path: <adobriyan@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12318
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: adobriyan@gmail.com
Precedence: bulk
X-list: linux-mips

On Sat, Aug 12, 2006 at 06:05:52PM +0200, thomas@koeller.dyndns.org wrote:
> This is a driver for the on-chip watchdog device found on some
> MIPS RM9000 processors.

> +/* Module arguments */
> +static int timeout = MAX_TIMEOUT_SECONDS;
> +module_param(timeout, int, 444);
			      ^^^
*cough* ITYM, 0444

> +static unsigned long resetaddr = 0xbffdc200;
> +module_param(resetaddr, ulong, 444);

0444

> +static unsigned long flagaddr = 0xbffdc104;
> +module_param(flagaddr, ulong, 444);

0444

> +static int powercycle = 0;
> +module_param(powercycle, bool, 444);

0444

> +module_param(nowayout, bool, 444);

0444

> +static struct file_operations fops =
> +{

On one line, please.

> +static struct miscdevice miscdev =
> +{

Ditto.

> +static struct device_driver wdt_gpi_driver =
> +{

> +	.shutdown	= NULL,
> +	.suspend	= NULL,
> +	.resume		= NULL

If you don't provide, don't write it at all and C99 compiler will DTRT.

> +static struct notifier_block wdt_gpi_shutdown =
> +{
> +	wdt_gpi_notify
> +};

C99 initializer needed.

> +static int __init wdt_gpi_probe(struct device *dev)
> +{
> +	int res;
> +	struct platform_device * const pdv = to_platform_device(dev);
> +	const struct resource
> +		* const rr = wdt_gpi_get_resource(pdv, WDT_RESOURCE_REGS,
> +						  IORESOURCE_MEM),
> +		* const ri = wdt_gpi_get_resource(pdv, WDT_RESOURCE_IRQ,
> +						  IORESOURCE_IRQ),
> +		* const rc = wdt_gpi_get_resource(pdv, WDT_RESOURCE_COUNTER,
> +						  0);

Looks horrible. First, gcc almost certainly won't do anything useful
with const qualifiers. Second, only short initializers are tolerated.
That way you won't even hit 80-chars border.

	struct resource *rr, *ri, *rc;

	rr = wdt_gpi_get_resource(...);
	ri = wdt_gpi_get_resource(...);
	rc = wdt_gpi_get_resource(...);

> +	if (unlikely(!rr || !ri || !rc))
> +		return -ENXIO;

Probing is hardly critical path, so code clarity wins and "unlikely"
should be removed here and below. And give better names to these
variables. ;-)

> +static int wdt_gpi_release(struct inode *i, struct file *f)

It's usually "struct inode *inode" and "struct file *file".

> +	switch (cmd) {
> +		case WDIOC_GETSUPPORT:

One tab please

	switch (cmd) {
	case WDIOC_GETSUPPORT:
		...
	}

> +			wdinfo.options = nowayout ?
> +				WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING :
> +				WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING | WDIOF_MAGICCLOSE;
> +			res = __copy_to_user((void __user *)arg, &wdinfo, size) ?
> +				-EFAULT : size;
> +			break;
> +
> +		case WDIOC_GETSTATUS:
> +			break;
> +		
> +		case WDIOC_GETBOOTSTATUS:
> +			stat = (*(volatile char *) flagaddr & 0x01)
> +				? WDIOF_CARDRESET : 0;
> +			res = __copy_to_user((void __user *)arg, &stat, size) ?
> +				-EFAULT : size;
> +			break;
> +
> +		case WDIOC_SETOPTIONS:
> +			break;
> +
> +		case WDIOC_KEEPALIVE:
> +			wdt_gpi_set_timeout(timeout);
> +			res = size;
> +			break;
> +
> +		case WDIOC_SETTIMEOUT:
> +			{
> +				int val;
> +				if (unlikely(__copy_from_user(&val, (const void __user *) arg,
> +						     size))) {
> +					res = -EFAULT;
> +					break;
> +				}
> +
> +				if (val > 32)
> +					val = 32;
> +				timeout = val;
> +				wdt_gpi_set_timeout(val);
> +				res = size;
> +				printk("%s: timeout set to %u seconds\n",
> +				       wdt_gpi_name, timeout);
> +			}
> +			break;
> +
> +		case WDIOC_GETTIMEOUT:
> +			res = __copy_to_user((void __user *) arg, &timeout, size) ?
> +				-EFAULT : size;
> +			break;
> +	}
> +	
> +	return res;

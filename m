Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 25 Jan 2010 12:55:51 +0100 (CET)
Received: from mail.gmx.net ([213.165.64.20]:32925 "HELO mail.gmx.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with SMTP
        id S2097170Ab0AYLzr (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 25 Jan 2010 12:55:47 +0100
Received: (qmail invoked by alias); 25 Jan 2010 11:55:41 -0000
Received: from unknown (EHLO [192.100.130.239]) [192.100.130.239]
  by mail.gmx.net (mp048) with SMTP; 25 Jan 2010 12:55:41 +0100
X-Authenticated: #54578410
X-Provags-ID: V01U2FsdGVkX19ggecQgDdg6U5TJ/qcr3d4wedHi8uJET5QlnX9RI
        GgAPMZmfoovShd
Message-ID: <4B5D86BB.7040405@gmx.de>
Date:   Mon, 25 Jan 2010 12:55:39 +0100
From:   Michael Lawnick <ml.lawnick@gmx.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.8.1.23) Gecko/20090812 Lightning/0.9 Thunderbird/2.0.0.23 Mnenhy/0.7.5.0
MIME-Version: 1.0
To:     Ben Dooks <ben-linux@fluff.org>
CC:     David Daney <ddaney@caviumnetworks.com>, linux-mips@linux-mips.org,
        ralf@linux-mips.org, linux-i2c@vger.kernel.org, khali@linux-fr.org,
        rade.bozic.ext@nsn.com
Subject: Re: [PATCH 2/3] I2C: Add driver for Cavium OCTEON I2C ports.
References: <4B463B1F.6000404@caviumnetworks.com> <1262894061-32613-2-git-send-email-ddaney@caviumnetworks.com> <20100124160017.GF28675@fluff.org.uk>
In-Reply-To: <20100124160017.GF28675@fluff.org.uk>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.44
X-archive-position: 25649
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ml.lawnick@gmx.de
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 15930

Hi,

this is the author.

Ben Dooks said the following:
> On Thu, Jan 07, 2010 at 11:54:20AM -0800, David Daney wrote:
<snip>
>> +#ifndef NO_IRQ
>> +#define NO_IRQ (-1)
>> +#endif
> 
> this does not fill me with a warm joyous feeling... 

see near end of reply.

> 
>> +struct octeon_i2c {
>> +	wait_queue_head_t queue;
>> +	struct i2c_adapter adap;
>> +	int irq;
>> +	int twsi_freq;
>> +	int sys_freq;
>> +	uint8_t twsi_ctl;
>> +	resource_size_t twsi_phys;
>> +	void __iomem *twsi_base;
>> +	resource_size_t regsize;
>> +	struct device *dev;
>> +};
> 
> kerneldoc or any documentation at-all would be nice.

This is driver private data, used within this file only. Usage should be
rather obvious?!

<snip>

>> +	do {
>> +		data = octeon_i2c_read_sw(i2c, SW_TWSI_EOP_TWSI_STAT);
>> +		if (data == STAT_IDLE)
>> +			break;
>> +		udelay(1);
>> +	} while (!time_after(jiffies, orig_jiffies + 2));
> 
> you sure you want to busy wait like this?
> 
Hmm, yes?
Its a busy wait of typically 10us, but not guaranteed.
Timeout is 1 to 2 jiffies.
Any other suggestion?

<snip>

>> +	i2c_data = pdev->dev.platform_data;
>> +
>> +	res_mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +	irq = platform_get_irq(pdev, 0);
>> +
>> +	if (res_mem == NULL) {
>> +		dev_dbg(i2c->dev, "%s: found no memory resource\n", __func__);
>> +		kfree(i2c);
>> +		return -ENODEV;
>> +	}
>> +
>> +	if (i2c_data == NULL) {
>> +		dev_dbg(i2c->dev, "%s: no I2C frequence data\n", __func__);
>> +		kfree(i2c);
>> +		return -ENODEV;
>> +	}
> 
> returning -ENODEV isn't a good idea, the device layer won't print an
> error on seeing -ENODEV as it thinks this is a probe for a device that
> was never there.
> 
ACK, couldn't find something really appropriate. Will change to EINVAL.

<snip>

>> +	i2c->twsi_phys = res_mem->start;
>> +	i2c->regsize = resource_size(res_mem);
>> +	i2c->twsi_freq = i2c_data->i2c_freq;
>> +	i2c->sys_freq = i2c_data->sys_freq;
>> +
>> +	if (!request_mem_region(i2c->twsi_phys, i2c->regsize, res_mem->name)) {
>> +		dev_dbg(i2c->dev,
>> +			"%s i2c-cavium - request_mem_region failed\n",
>> +			__func__);
>> +		goto fail_region;
>> +	}
>> +	i2c->twsi_base = ioremap(i2c->twsi_phys, i2c->regsize);
>> +
>> +	init_waitqueue_head(&i2c->queue);
>> +
>> +	i2c->irq = irq;
>> +	if (i2c->irq != NO_IRQ) {
> 
> platform_get_irq() returns a negative error cdoe if no irq is found,
> so you need to do (irq < 0) here otherwise it'll never trip. Should
> also mean yo ucan get rid of NO_IRQ define above.

NO_IRQ is thought of as polling.
The code assumes that request_irq() denies irq < 0
After reviewing kernel code I think this should not be assumed.
I will have to contemplate about this.

<snip>

>> +static struct platform_driver octeon_i2c_driver = {
>> +	.probe		= octeon_i2c_probe,
>> +	.remove		= __exit_p(octeon_i2c_remove),
> __devexit_p() here, probably should change __exit to __devexit on the
> remove function.

I thought I had read something about abuse of __devexit (to be used only
for hotplugable devices), but I can't find it anymore.
I'll change.

Currently I'm unsure about using __devinit for probe().
It will be called twice (2 devices), but I can't absolutely tell that
second call will be in system initialization phase.
Your 2 Cents?

>> +	.driver		= {
>> +		.owner	= THIS_MODULE,
>> +		.name	= DRV_NAME,
>> +	},
>> +};
>> +
>> +static int __init octeon_i2c_init(void)
>> +{
>> +	int rv;
>> +
>> +	rv = platform_driver_register(&octeon_i2c_driver);
>> +	printk(KERN_INFO "driver %s is loaded\n", DRV_NAME);
>> +	return rv;
>> +}
> 
> I'd rather not see 'driver loaded' messages if possible.

Whats about adjusting your message filter? ;-)
Would KERN_DEBUG be more appropriate?
We love such messages in our projects. You can filter for the 'loaded
phrases and have an fast overview this way.
-- 
Kind Regards,
Michael

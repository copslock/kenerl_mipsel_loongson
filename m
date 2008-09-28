Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 28 Sep 2008 10:23:24 +0100 (BST)
Received: from h155.mvista.com ([63.81.120.155]:7466 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S28579684AbYI1JWb (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 28 Sep 2008 10:22:31 +0100
Received: from [127.0.0.1] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id CD12E3ED2; Sun, 28 Sep 2008 02:22:24 -0700 (PDT)
Message-ID: <48DF4CCD.1070007@ru.mvista.com>
Date:	Sun, 28 Sep 2008 13:22:21 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
User-Agent: Thunderbird 2.0.0.17 (Windows/20080914)
MIME-Version: 1.0
To:	Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc:	Ralf Baechle <ralf@linux-mips.org>, linux-ide@vger.kernel.org,
	"Maciej W. Rozycki" <macro@linux-mips.org>,
	linux-mips@linux-mips.org
Subject: Re: [PATCH] IDE: Fix platform device registration in Swarm IDE driver
References: <20080922122853.GA15210@linux-mips.org> <48DA1F9D.6000501@ru.mvista.com> <200809271859.55304.bzolnier@gmail.com>
In-Reply-To: <200809271859.55304.bzolnier@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20654
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Bartlomiej Zolnierkiewicz wrote:

>>> @@ -70,41 +59,18 @@ static const struct ide_port_info swarm_
>>>   * swarm_ide_probe - if the board header indicates the existence of
>>>   * Generic Bus IDE, allocate a HWIF for it.
>>>   */
>>> -static int __devinit swarm_ide_probe(struct device *dev)
>>> +static int __devinit swarm_ide_probe(struct platform_device *pdev)
>>>  {
>>>  	u8 __iomem *base;
>>>  	struct ide_host *host;
>>>  	phys_t offset, size;
>>> +	struct resource *r;
>>>  	int i, rc;
>>>  	hw_regs_t hw, *hws[] = { &hw, NULL, NULL, NULL };
>>>  
>>> -	if (!SIBYTE_HAVE_IDE)
>>> -		return -ENODEV;
>>> -
>>> -	base = ioremap(A_IO_EXT_BASE, 0x800);
>>> -	offset = __raw_readq(base + R_IO_EXT_REG(R_IO_EXT_START_ADDR, IDE_CS));
>>> -	size = __raw_readq(base + R_IO_EXT_REG(R_IO_EXT_MULT_SIZE, IDE_CS));
>>> -	iounmap(base);
>>> -
>>> -	offset = G_IO_START_ADDR(offset) << S_IO_ADDRBASE;
>>> -	size = (G_IO_MULT_SIZE(size) + 1) << S_IO_REGSIZE;
>>> -	if (offset < A_PHYS_GENBUS || offset >= A_PHYS_GENBUS_END) {
>>> -		printk(KERN_INFO DRV_NAME
>>> -		       ": IDE interface at GenBus disabled\n");
>>> -		return -EBUSY;
>>> -	}
>>> -
>>> -	printk(KERN_INFO DRV_NAME ": IDE interface at GenBus slot %i\n",
>>> -	       IDE_CS);
>>> -
>>> -	swarm_ide_resource.start = offset;
>>> -	swarm_ide_resource.end = offset + size - 1;
>>> -	if (request_resource(&iomem_resource, &swarm_ide_resource)) {
>>>   
>>>       
>>    Why drop request_resource() completely? Replace it by 
>> request_mem_region().
>>     
>
> Yes, this needs fixing (otherwise everything looks good).
>   

   BTW, calling request_resource() seems pointless, as 
platform_device_register() call will have called __request_resource() 
already...

WBR, Sergei

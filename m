Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Jan 2005 20:11:53 +0000 (GMT)
Received: from mail.chipsandsystems.com ([IPv6:::ffff:64.164.196.27]:65189
	"EHLO mail.chipsag.com") by linux-mips.org with ESMTP
	id <S8225339AbVAFULt>; Thu, 6 Jan 2005 20:11:49 +0000
Received: from [10.1.100.35] ([10.1.100.35]) by mail.chipsag.com with Microsoft SMTPSVC(6.0.3790.0);
	 Thu, 6 Jan 2005 12:13:55 -0800
Message-ID: <41DD9B75.7060904@embeddedalley.com>
Date: Thu, 06 Jan 2005 12:11:33 -0800
From: Pete Popov <ppopov@embeddedalley.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christian Gan <christian.gan@librestream.com>
CC: linux-mips@linux-mips.org
Subject: Re: vmalloc memory corruption
References: <8230E1CC35AF9F43839F3049E930169A0D8A63@yang.LibreStream.local>
In-Reply-To: <8230E1CC35AF9F43839F3049E930169A0D8A63@yang.LibreStream.local>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 06 Jan 2005 20:13:55.0869 (UTC) FILETIME=[3FC2DCD0:01C4F42C]
Return-Path: <ppopov@embeddedalley.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6824
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@embeddedalley.com
Precedence: bulk
X-list: linux-mips

Christian Gan wrote:
> Just a little update on this:
> 
> I turned off 36 bit address support for the MIPS32
> (CONFIG_64BIT_PHYS_ADDR) and found that my tests for vmalloc work.
> 
> Can anyone who knows better point me in a direction of where I should
> start?

Hmmm. I'll take a look at this.

Pete

> 
> Thanks!
> 
> Christian
> 
> -----Original Message-----
> From: linux-mips-bounce@linux-mips.org
> [mailto:linux-mips-bounce@linux-mips.org] On Behalf Of Christian Gan
> Sent: Tuesday, January 04, 2005 3:25 PM
> To: linux-mips@linux-mips.org
> Subject: vmalloc memory corruption
> 
> Hey all,
> 
> I'm running into a strange memory corruption problem while trying to get
> a driver to load firmware using hotplug support on a DBAU1550 eval
> board.  This board has a single AU1550 MIPS32 processor.  I'm running
> kernel version 2.6.10-rc3.
> 
> I've attached a code snippet below that I'd like somebody to try to
> verify for me so I can determine whether or not it is a problem with my
> kernel/hardware.  
> 
> The test code is a simplified version of the interaction between the
> driver and the firmware/hotplug support of the kernel.  The firmware
> hotplug support (linux/drivers/base/firmware_class.c) if fed data from a
> file and places it into a buffer, this buffer gets reallocated when
> required and grows as more data is read in.  Old data is memcopied into
> the new reallocated buffer and newly read data is appended to the end.
> What I'm finding is that eventually this data is corrupted.
> 
> Compile the test snippet below as a module and insmod it.  If things are
> successful you should see results like this:
> 
> # insmod vmalloctest.ko
> Using vmalloctest.ko
> testing vmalloc
> 0x00 0x01 0x02 0x03 0x04 0x05 0x06 0x07 0x08 0x09
> 0x00 0x01 0x02 0x03 0x04 0x05 0x06 0x07 0x08 0x09
> 0x00 0x01 0x02 0x03 0x04 0x05 0x06 0x07 0x08 0x09
> ...
> 0x00 0x01 0x02 0x03 0x04 0x05 0x06 0x07 0x08 0x09
> 
> But if data changes at any time, you've got problems like me.  When I
> run this on my platform eventually the data becomes all 0x00.
> 
> Notice that if you use kmalloc instead of vmalloc (define USE_KMALLOC),
> everything works.
> 
> Thanks!
> 
> Christian Gan
> 
> // Start vmalloctest.c
> 
> #ifndef __KERNEL__
> #define __KERNEL__
> #endif
> 
> #include <linux/config.h>
> #include <linux/version.h>
> #include <linux/module.h>
> #include <linux/kernel.h>
> #include <linux/errno.h>
> #include <linux/string.h>
> #include <linux/mm.h>
> #include <linux/delay.h>
> #include <linux/init.h>
> #include <linux/vmalloc.h>
> 
> #include <asm/io.h>
> 
> //#define USE_KMALLOC
> 
> void fillbuf(char * buf, unsigned long len)
> {
> 	int i = 0;
> 	for (i = 0; i < len; i++)
> 	{
> 		buf[i] = 0xFF & i;
> 	}
> }
> 
> int __init vmalloctest_init(void)
> {
>     char * buf = NULL;
> 	int i = 0;
> 
> 	printk("testing vmalloc\n");
> 	
> 	for (i = 0; i < 50; i++)
> 	{
> 		int j = 0;
> #ifndef USE_KMALLOC		
> 		char * newbuf = vmalloc( (i+1)*PAGE_SIZE );
> // allocate a new buffer that grows in size
> #else
> 		char * newbuf = kmalloc( (i+1)*PAGE_SIZE, GFP_KERNEL );
> // allocate a new buffer that grows in size
> #endif		
> 		if (!newbuf)
> 		{
> 			printk("Could not allocate memory: %ld bytes\n",
> (i+1)*PAGE_SIZE);
> 			break;
> 		}
> 				
> 		if (i==0)
> 		{
> 			fillbuf(newbuf, PAGE_SIZE );		// fill
> the original buffer with some data... any will suffice
> 		}
> 		else
> 		{
> 			memcpy(newbuf, buf, i*PAGE_SIZE);	// copy
> the contents of the old buffer to the new	
> 		}
> 		
> #ifndef USE_KMALLOC
> 		vfree(buf);		// free the old buffer
> #else
> 		kfree(buf);		// free the old buffer
> #endif		
> 
> 		buf = newbuf;
> 		
> 		// print out the first few bytes
> 		for (j=0; j < 10; j++)
> 		{
> 			printk("0x%02X ", 0xff & buf[j]);
> 		}
> 		printk("\n");
> 	}
> 
> #ifndef USE_KMALLOC
> 	vfree(buf);
> #else
> 	kfree(buf);
> #endif		
> 
> 	return 0;
> }
> module_init(vmalloctest_init);
> 
> MODULE_LICENSE("GPL");
> 
> 
> 
> 
> 
> 

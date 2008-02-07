Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Feb 2008 15:20:45 +0000 (GMT)
Received: from host.infinivid.com ([64.119.179.76]:1231 "EHLO
	host.infinivid.com") by ftp.linux-mips.org with ESMTP
	id S20037787AbYBGPUg (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 7 Feb 2008 15:20:36 +0000
Received: (qmail 8093 invoked from network); 7 Feb 2008 15:20:34 -0000
Received: from unknown (HELO ?10.41.13.129?) (38.101.235.133)
  by host.infinivid.com with (RC4-MD5 encrypted) SMTP; 7 Feb 2008 08:20:33 -0700
Subject: iomemory causing a data bus error
From:	Jon Dufresne <jon.dufresne@infinitevideocorporation.com>
To:	linux-mips@linux-mips.org
Content-Type: text/plain
Date:	Thu, 07 Feb 2008 10:20:02 -0500
Message-Id: <1202397602.3298.25.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.3 (2.8.3-2.fc6) 
Content-Transfer-Encoding: 7bit
Return-Path: <jon.dufresne@infinitevideocorporation.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18193
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jon.dufresne@infinitevideocorporation.com
Precedence: bulk
X-list: linux-mips

Hi,

I am writing a linux mips device driver for a PCI device. I am currently
running into a strange problem when writing a lot of data to iomemory.

I have written a test function that looks like this:

void test_iomem(struct pci_dev *dev)
{
	void __iomem *mem;
	unsigned long start;
	unsigned long size;

	start = pci_resource_start(dev, 0);
	size = pci_resource_len(dev, 0);

	printk("start=%08lx size=%08lx\n", start, size);
	mem = ioremap(start, size);
	while(1) {
		printk("memset %p\n", mem);
		memset_io(mem, 0, 10000);
	}
}

This function is just being used to test the iomemory. If this works, it
should just keep writing 0's to the iomemory forever (at least as I
understand it). When I run insmod on this device driver I see the
following output:

start=20000000 size=04000000
memset c0580000
memset c0580000
memset c0580000
...
...
...

And this goes on for quite some time. Eventually it will stop, moments
later I will see a kernel panic with the following output:


> memset c0580000
> memset c0580000
> memset c0580000
> Data bus error, epc == c027a64c, ra == 800aa27c
> Oops[#1]:
> Cpu 0
> $ 0   : 00000000 10008400 c0363050 00063050
> $ 4   : 00000037 82937800 8109d000 10008401
> $ 8   : 10008400 1000001f 80320000 80320000
> $12   : 80320000 00000001 83133bf8 8031c960
> $16   : 8311c600 00000080 00000001 00000037
> $20   : c02815e8 802e1ae4 c025a000 8008cde4
> $24   : 00000008 00000000                  
> $28   : 83132000 83133be8 c02815ac 800aa27c
> Hi    : 00000000
> Lo    : 00000800
> epc   : c027a64c     Tainted: P     
> ra    : 800aa27c Status: 10008403    KERNEL EXL IE 
> Cause : 1080801c
> PrId  : 00061200
> Modules linked in: tmman1700(P) mousedev usbhid usb_storage phStbFB(P) phStbFBRead(P) phStbVideoRenderer(P) phStbVideoRenderer_Layer(P) phStbStreamingSystem(P) phStbDraw(P) snd_usb_audio snd_usb_lib snd_rawmie
> Process insmod (pid: 790, threadinfo=83132000, task=833e1278)
> Stack : 801ecd20 801ecd20 00000000 00000037 8311c600 00000080 00000001 800aa27c
>         00000000 8008c23c 0000004f 810b9c00 802f7dc0 810c3c00 00000037 810b9c00
>         800aa398 800aa340 10008400 8008c31c 80320000 80320000 00000000 04000000
>         c0280000 8006386c 80320000 c027e814 10008401 8031c570 80061310 802e1ae4
>         c025a000 8008cde4 00000008 00000000 00000000 80062040 83132000 83133ca8
>         ...
> Call Trace:[<801ecd20>][<801ecd20>][<800aa27c>][<8008c23c>][<800aa398>][<800aa340>][<8008c31c>][<8006386c>][<80061310>][<8008cde4>][<80062040>][<80086918>][<8019f924>][<8008cde4>][<c02746d0>][<8017039c>][<801]
> 
> Code: 3c030006  34633050  00431021 <8c430000> 2402ffff  1062002e  00a08821  38620001  30420001 
> Kernel panic - not syncing: Fatal exception in interrupt

I am at a complete loss as to what could be causing this to occur. Any
ideas about why this would crash? In case it helps this is what my PCI
configuration space looks like:

00: 31 11 06 54 02 00 90 02 00 00 80 04 00 40 00 00
10: 08 00 00 20 00 00 00 24 00 00 00 1c 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 36 11 17 00
30: 00 00 00 00 40 00 00 00 00 00 00 00 00 01 09 18
40: 01 00 02 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

I thought the command register and latency timer looked wrong, so I did
modify them before running the above function. And now it looks like the
following:

00: 31 11 06 54 16 01 90 02 00 00 80 04 00 40 00 00
10: 08 00 00 20 00 00 00 24 00 00 00 1c 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 36 11 17 00
30: 00 00 00 00 40 00 00 00 00 00 00 00 00 01 09 18
40: 01 00 02 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

Still no luck. Anyone have an idea?

Thanks,
Jon

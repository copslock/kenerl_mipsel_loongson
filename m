Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Sep 2008 16:01:07 +0100 (BST)
Received: from h155.mvista.com ([63.81.120.155]:5641 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S20271572AbYILPBF (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 12 Sep 2008 16:01:05 +0100
Received: from [192.168.1.234] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id 60F933ECA; Fri, 12 Sep 2008 08:01:00 -0700 (PDT)
Message-ID: <48CA8458.6000906@ru.mvista.com>
Date:	Fri, 12 Sep 2008 19:01:44 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org, linux-ide@vger.kernel.org,
	bzolnier@gmail.com, ralf@linux-mips.org
Subject: Re: [PATCH 1/2] ide: Add tx4939ide driver
References: <20080910.010824.07456636.anemo@mba.ocn.ne.jp>	<48C99CA8.5030602@ru.mvista.com> <20080912.233717.27957136.anemo@mba.ocn.ne.jp>
In-Reply-To: <20080912.233717.27957136.anemo@mba.ocn.ne.jp>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20477
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Atsushi Nemoto wrote:

>>>+static void tx4939ide_dma_host_set(ide_drive_t *drive, int on)
>>>+{
>>>+	ide_hwif_t *hwif	= HWIF(drive);
>>>+	u8 unit			= drive->dn & 1;
>>>+	unsigned long base = TX4939IDE_BASE(hwif);
>>>+	u8 dma_stat = TX4939IDE_readb(base, DMA_stat);
>>>+
>>>+	if (on)
>>>+		dma_stat |= (1 << (5 + unit));
>>>+	else
>>>+		dma_stat &= ~(1 << (5 + unit));
>>>+
>>>+	TX4939IDE_writeb(dma_stat, base, DMA_stat);
>>>+}

>>   BTW, you could save on using ide_dma_host_set() in LE mode if you'd 
>>set hwif->dma_base properly...

> Yes.  I like endian-free approach in general, but there is already
> some ifdefs in this driver.  I have no strong opinion here.

    Unfortunately, the way SFF-8038i registers were implemented in TX4939 
necessiates BE specific #ifdef'ery.  Or at least the run-time endianness 
detection and passing the right struct *_ops to the IDE core -- but that would 
burden the driver with unused and/or unneeded code for the opposite endiannes. 
  It could've been somewhat easied by the use of hwif->dma_{command|status}, 
etc. but those were recently removed (then again, if the DMA engine is not 
SFF-8038i compatible, those fields make little sense)...

>>>+static int __tx4939ide_dma_setup(ide_drive_t *drive)
>>>+{
>>>+	ide_hwif_t *hwif = drive->hwif;
>>>+	struct request *rq = HWGROUP(drive)->rq;
>>>+	unsigned int reading;
>>>+	u8 dma_stat;
>>>+	unsigned long base = TX4939IDE_BASE(hwif);
>>>+

>>[...]

>>>+
>>>+	/* read DMA status for INTR & ERROR flags */
>>>+	dma_stat = TX4939IDE_readb(base, DMA_stat);
>>>+
>>>+	/* clear INTR & ERROR flags */
>>>+	TX4939IDE_writeb(dma_stat | 6, base, DMA_stat);
>>>+	/* recover intmask cleared by writing to bit2 of DMA_stat */
>>>+	TX4939IDE_writew(TX4939IDE_IGNORE_INTS << 8, base, int_ctl);
>>>  
>>
>>   I think it might be worth factoring the BMDMA status clearing code 
>>into a separate function...

    ...along with the int_ctl write, of course.

> OK.  Good idea.

>>>+#ifdef __BIG_ENDIAN
>>>+/* custom iops (independent from SWAP_IO_SPACE) */
>>>+static u8 mm_inb(unsigned long port)
>>>+{
>>>+	return (u8)readb((void __iomem *)port);
>>>+}
>>>+static void mm_outb(u8 value, unsigned long port)
>>>+{
>>>+	writeb(value, (void __iomem *)port);
>>>+}

>>   I'm not sure readb()/writeb() are good substitute for 
>>__raw_readb()/__raw_writeb() as __swizzle_addr_b() might be actually 
>>changing the address...

> __swizzle_addr_b() used for both readb() and __raw_readb().  ioswabb()

    Ah, I missed that. :-/
    More's the reason to rely on the default methods where possible.

> ---
> Atsushi Nemoto

MBR, Sergei

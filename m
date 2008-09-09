Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 09 Sep 2008 18:07:44 +0100 (BST)
Received: from h155.mvista.com ([63.81.120.155]:63966 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S29051588AbYIIRHl (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 9 Sep 2008 18:07:41 +0100
Received: from [192.168.1.234] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id DE46F3EC9; Tue,  9 Sep 2008 10:07:33 -0700 (PDT)
Message-ID: <48C6AD7E.10005@ru.mvista.com>
Date:	Tue, 09 Sep 2008 21:08:14 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-mips@linux-mips.org,
	linux-ide@vger.kernel.org,
	Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
	ralf@linux-mips.org
Subject: Re: [PATCH 1/2] ide: Add tx4939ide driver
References: <20080910.010824.07456636.anemo@mba.ocn.ne.jp> <20080909174459.2aa9808a@lxorguk.ukuu.org.uk>
In-Reply-To: <20080909174459.2aa9808a@lxorguk.ukuu.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20423
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Alan Cox wrote:

>>+#define TX4939IDE_readl(base, reg) \
>>+	__raw_readl((void __iomem *)((base) + TX4939IDE_REG32(reg)))
>>+#define TX4939IDE_readw(base, reg) \
>>+	__raw_readw((void __iomem *)((base) + TX4939IDE_REG16(reg)))
>>+#define TX4939IDE_readb(base, reg) \
>>+	__raw_readb((void __iomem *)((base) + TX4939IDE_REG8(reg)))
>>+#define TX4939IDE_writel(val, base, reg) \
>>+	__raw_writel(val, (void __iomem *)((base) + TX4939IDE_REG32(reg)))
>>+#define TX4939IDE_writew(val, base, reg) \
>>+	__raw_writew(val, (void __iomem *)((base) + TX4939IDE_REG16(reg)))
>>+#define TX4939IDE_writeb(val, base, reg) \
>>+	__raw_writeb(val, (void __iomem *)((base) + TX4939IDE_REG8(reg)))

> It's generally frowned upon to hide all the detail in macros, it is much
> easier to read and understand the code if you don't do this.

>>+#define TX4939IDE_BASE(hwif)	((hwif)->io_ports.data_addr & ~0xfff)

> Why do you have void __iomem casts all over the write methods not in the
> _BASE() method - that would let sparse do its job properly

    I don't get why there's need for & at all -- isn't IDE data register 
address always on 4K boundary?

>>+	for (i = 0; i < MAX_DRIVES; i++) {
>>+		if (drive != &hwif->drives[i] &&

> You don't actually need the first test.

    No, he does need it -- in order not to clamp the new PIO mode based on the 
previosly selected one. Although, one should call ide_get_paired_drive() ISO 
this loop.

> This also appears wrong. In your
> tests MW_DMA_0 is 'faster' than PIO4 but in fact MW_DMA_0 PIO timings are
> *slower* than PIO4 so the mode is not in fact slower.

    I don't think it's about the DMA timings at all. Though indeed, MWDMA0/1 
do (iff it's drive's max) implies slower max PIO mode than PIO4.

>>+	case XFER_MW_DMA_2:
>>+	case XFER_MW_DMA_1:
>>+	case XFER_MW_DMA_0:
>>+	case XFER_PIO_4:
>>+		value |= 0x0400;
>>+		break;

> This looks odd according to the speed tables. Can you clarify what is
> going on ?

    This apparently selects the command PIO timing safest for both drives but 
does this incorrectly -- the current DMA (or even PIO) mode shouldn't be a 
part of the equation.  There are several examples how to do this including 
siimage.c and cs5535.c...

MBR, Sergei

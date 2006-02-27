Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Feb 2006 03:03:23 +0000 (GMT)
Received: from nproxy.gmail.com ([64.233.182.195]:36292 "EHLO nproxy.gmail.com")
	by ftp.linux-mips.org with ESMTP id S8133622AbWB0DDO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 27 Feb 2006 03:03:14 +0000
Received: by nproxy.gmail.com with SMTP id x30so496394nfb
        for <linux-mips@linux-mips.org>; Sun, 26 Feb 2006 19:10:50 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=oPPGzui9XYaRIwg9LbVlQMZfNL0U2FAkKfJtUYKnzGC1kd4kPv7qG4JjKfVLblY2kRWCVu3edFf37vIR4DGW9mwzck9IoMhZkloJQj8jsf/KWtFNERnjpz/wSUNSv1nPicq0vU7vHO8Nx7ciEogRCnXigucp2uRObAgl7cEGSnk=
Received: by 10.48.161.16 with SMTP id j16mr3567604nfe;
        Sun, 26 Feb 2006 19:10:50 -0800 (PST)
Received: by 10.48.249.14 with HTTP; Sun, 26 Feb 2006 19:10:50 -0800 (PST)
Message-ID: <50c9a2250602261910t2241cd14ue877361310e29136@mail.gmail.com>
Date:	Mon, 27 Feb 2006 11:10:50 +0800
From:	zhuzhenhua <zzh.hust@gmail.com>
To:	"Atsushi Nemoto" <anemo@mba.ocn.ne.jp>
Subject: Re: bogus packet in ei_receive of 8390.c
Cc:	linux-mips@linux-mips.org
In-Reply-To: <20060227.111020.74752419.nemoto@toshiba-tops.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <50c9a2250602251831n27d11b5ar7a309c9716a8683a@mail.gmail.com>
	 <20060226.230541.75185772.anemo@mba.ocn.ne.jp>
	 <50c9a2250602261729q543eb515hff7af85153ac779@mail.gmail.com>
	 <20060227.111020.74752419.nemoto@toshiba-tops.co.jp>
Return-Path: <zzh.hust@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10652
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zzh.hust@gmail.com
Precedence: bulk
X-list: linux-mips

On 2/27/06, Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:
> >>>>> On Mon, 27 Feb 2006 09:29:23 +0800, zhuzhenhua <zzh.hust@gmail.com> said:
> zzh> our board is a FPGA board for embedded system, there is no ISA,
> zzh> and use memory map IO, is there anything need to configure?
>
> Even if it is not true ISA, your FPGA should drive ISA-like signals
> for the chip.  AC timings of these signals should meet the
> requirements of the chip.  I do not know they are configurable or not.
> Do cross-check the 8019 datasheet and the FPGA specification.
the ethernet just use the sram interface to control IO
>
> zzh> now i printk the ISR and RSR value when bogus packet accepted,
> zzh> are these two registers correct? messages as follow
>
> It seems correct.  So it would be something wrong with get_8390_hdr ...
the get_8390_hdr is very simple , as follow

static void my_enet_get_8390_hdr(struct net_device *dev,
				    struct e8390_pkt_hdr *hdr,
				    int ring_page)
{
	int cnt;
	unsigned char *ptrc;

	/* This *shouldn't* happen. If it does, it's the last thing you'll see */
	if (ei_status.dmaing) {
		printk("%s: DMAing conflict in ne_get_8390_hdr "
		       "[DMAstat:%d][irqlock:%d].\n", dev->name,
		       ei_status.dmaing, ei_status.irqlock);
		return;
	}

	ei_status.dmaing |= 0x01;
	writeb(E8390_NODMA + E8390_PAGE0 + E8390_START, iobase + NE_CMD);
	writeb(ENISR_RDC, iobase + NE_EN0_ISR);
	writeb(sizeof(struct e8390_pkt_hdr), iobase + NE_EN0_RCNTLO);
	writeb(0, iobase + NE_EN0_RCNTHI);
	writeb(0, iobase + NE_EN0_RSARLO);	/* On page boundary */
	writeb(ring_page, iobase + NE_EN0_RSARHI);
	writeb(E8390_RREAD + E8390_START, iobase + NE_CMD);

	ptrc = (unsigned char *) hdr;
	for (cnt = 0; cnt < sizeof(struct e8390_pkt_hdr); cnt++)
		*ptrc++ = readb(iobase + NE_DATAPORT);

	writeb(ENISR_RDC, iobase + NE_EN0_ISR);	/* Ack intr. */

	/* I am Little Endian, and received byte count is Little Endian. */
	hdr->count = le16_to_cpu(hdr->count);

	ei_status.dmaing &= ~0x01;
}

>
> ---
> Atsushi Nemoto
>

i have try to disable the check of status in ei_receive, as follow
...
#ifdef CONFIG_REDWOOD_4
		 else if ((pkt_stat & 0x1F) == ENRSR_RXOK)
#else
		 else if ( 1 || (pkt_stat & 0x0F) == ENRSR_RXOK)
#endif
		{
...
but the nfs still not accept the packet, it still have the messages
"nfs server xxxx not responding, still trying"


Best Regards
zhuzhenhua

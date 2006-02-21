Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Feb 2006 11:33:22 +0000 (GMT)
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:55227 "EHLO
	lxorguk.ukuu.org.uk") by ftp.linux-mips.org with ESMTP
	id S8133394AbWBULdO (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 21 Feb 2006 11:33:14 +0000
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by lxorguk.ukuu.org.uk (8.13.4/8.13.4) with ESMTP id k1LBiJV3001123;
	Tue, 21 Feb 2006 11:44:19 GMT
Received: (from alan@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id k1LBiJKD001122;
	Tue, 21 Feb 2006 11:44:19 GMT
X-Authentication-Warning: localhost.localdomain: alan set sender to alan@lxorguk.ukuu.org.uk using -f
Subject: Re: "Hw. address read/write mismap 0" or RTL8019 ethernet in linux
From:	Alan Cox <alan@lxorguk.ukuu.org.uk>
To:	zhuzhenhua <zzh.hust@gmail.com>
Cc:	linux-mips <linux-mips@linux-mips.org>
In-Reply-To: <50c9a2250602202133g2e7350aesdaf1df810c90cef8@mail.gmail.com>
References: <50c9a2250602202133g2e7350aesdaf1df810c90cef8@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date:	Tue, 21 Feb 2006 11:44:18 +0000
Message-Id: <1140522258.840.16.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Return-Path: <alan@lxorguk.ukuu.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10591
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alan@lxorguk.ukuu.org.uk
Precedence: bulk
X-list: linux-mips

On Maw, 2006-02-21 at 13:33 +0800, zhuzhenhua wrote:
> then i check the code and find it's in 8390.c, caused by uncorrect
> write of MAC addr, and now i repalce all the inb,outb,inb_p, outb_p
> with get_reg and put_reg in the 8390.c.as follow:
> 
> static unsigned char get_reg (unsigned int regno)
> {
> 	return (*(volatile unsigned char *) regno);
> }
> 
> static void put_reg (unsigned int regno, unsigned char val)
> {
> 	*(volatile unsigned char *) regno = val;
> }

Should be

	return readb(regno);

and

	writeb(val, regno)

if regno holds the ioremap result of the memory mapped address of the
8019. Right now 8390.c assumes PIO mappings and you hardware appears to
be MMIO ?

> does someone have any idea of this situation?

If the card is MMIO then make sure you are using readb/writeb and
ioremap properly, otherwise you may get cache consistency and other
strange errors.

Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Nov 2003 05:45:43 +0000 (GMT)
Received: from p508B68E7.dip.t-dialin.net ([IPv6:::ffff:80.139.104.231]:7296
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225361AbTKKFpc>; Tue, 11 Nov 2003 05:45:32 +0000
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by dea.linux-mips.net (8.12.8/8.12.8) with ESMTP id hAB5jVJH026396;
	Tue, 11 Nov 2003 06:45:31 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.12.8/8.12.8/Submit) id hAB5jTA6026395;
	Tue, 11 Nov 2003 06:45:29 +0100
Date: Tue, 11 Nov 2003 06:45:29 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: "Liu Hongming (Alan)" <alanliu@trident.com.cn>
Cc: Adeel Malik <AdeelM@quartics.com>, linux-mips@linux-mips.org
Subject: Re: How to request an IRQ for NMI on MIPS Processor
Message-ID: <20031111054529.GA26238@linux-mips.org>
References: <15F9E1AE3207D6119CEA00D0B7DD5F6801C9949F@TMTMS>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15F9E1AE3207D6119CEA00D0B7DD5F6801C9949F@TMTMS>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3600
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Nov 11, 2003 at 01:26:53PM +0800, Liu Hongming (Alan) wrote:

> I have understood your situation.
>  
> Under this situation,I think you need not use request_irq.

Request_irq is just the software interface; it could be used to drive
any kind of interrupt mechanism, even NMI or the two MIPS software
interrupts.  The actual problem here is the underlying hardware
mechanism and firmware.

> Just keep your 'interrupt' handler in BIOS or bootloader,
> of course,it is different with Rest Exception,since 
> many registers' status are not the same as hardware-reseting.
> You could detect the difference.Right?

Note the firmware is usually in some kind of PROM (sloooow) and also
running uncached.  One reasons of many why the MIPS NMI is only a good
idea for fatal events.

  Ralf

Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Jul 2006 10:53:24 +0100 (BST)
Received: from www.osadl.org ([213.239.205.134]:54979 "EHLO mail.tglx.de")
	by ftp.linux-mips.org with ESMTP id S8133425AbWGJJxP (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 10 Jul 2006 10:53:15 +0100
Received: from localhost (debian [213.239.205.147])
	by mail.tglx.de (Postfix) with ESMTP id D320465C003;
	Mon, 10 Jul 2006 11:53:13 +0200 (CEST)
Subject: Re: [PATCH] PNX8550 NAND flash driver
From:	Thomas Gleixner <tglx@linutronix.de>
To:	"Vladimir A. Barinov" <vbarinov@ru.mvista.com>
Cc:	Todd Poynor <tpoynor@mvista.com>, linux-mtd@lists.infradead.org,
	linux-mips@linux-mips.org
In-Reply-To: <43F1D439.60205@ru.mvista.com>
References: <43A2F819.1040106@ru.mvista.com> <43C69EC2.2070601@mvista.com>
	 <43F1D439.60205@ru.mvista.com>
Content-Type: text/plain
Organization: linutronix
Date:	Mon, 10 Jul 2006 11:53:16 +0200
Message-Id: <1152525196.30929.11.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Return-Path: <tglx@linutronix.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11961
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tglx@linutronix.de
Precedence: bulk
X-list: linux-mips

On Tue, 2006-02-14 at 15:59 +0300, Vladimir A. Barinov wrote:
> >> +    }
> >> +
> >> +    if (((bytes & 3) || (bytes < 16)) || ((u32) to & 3) || ((u32) 
> >> from & 3)) {
> >> +        if (((bytes & 1) == 0) &&
> >> +            (((u32) to & 1) == 0) && (((u32) from & 1) == 0)) {
> >> +            int words = bytes / 2;
> >> +
> >> +            local_irq_disable();
> >> +            for (i = 0; i < words; i++) {
> >> +                to16[i] = from16[i];
> >> +            }
> >> +            local_irq_enable();
> >
> >
> > Really necessary to disable all irqs around this transfer?  How long 
> > can interrupts be off during that time?
> 
> That is needed since the NAND device is binded to the external XIO bus 
> that could be used by another devices.

Err, you have to protect the whole access sequence then. What protects
the chip against access between the command write and data read ?

If this really is a bus conflict problem, then you need some more
protection than this.

Can you please describe in detail why you think this is necessary. 

	tglx

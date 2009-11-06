Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Nov 2009 06:40:04 +0100 (CET)
Received: from mail-pw0-f45.google.com ([209.85.160.45]:43061 "EHLO
	mail-pw0-f45.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1491872AbZKFFj5 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 6 Nov 2009 06:39:57 +0100
Received: by pwi15 with SMTP id 15so475225pwi.24
        for <multiple recipients>; Thu, 05 Nov 2009 21:39:48 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=y0wRPV3FQS2QYBgxai75ftrOjszmsEXB8HtF9ghHwD4=;
        b=iCXAlY/LM0gZ7E1Klo9xUyGVsxh2IHoERwbdonuKpFdEbMVc09Y/tsjWsl5w7da7Sl
         dtZkzgFVNJ2Z20ky0KdA7qChvavaWHe3fSi2BitjZDXquPGer3KP3H8ZOBttFMaNgoZM
         6LWsweLGA4v2OKrJRVi74euMyblNt6bf0f3Io=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=OtQ07kUJxKaBrjszk6uL0XQOMsDqnzeAVTJUt5t5hzVkMzLt42WAm+B2CbTC9bG2ld
         W9Va6KI4YHBuOpQjZqxPUVZcYL+l9/0lgw+PMlreff3pUPQv3c2NWOQg6PLjBLlDz6Lb
         4i3tHg27PMPJpiG7xl+o/QqAWzmwD+edcrvyQ=
Received: by 10.114.19.30 with SMTP id 30mr6113627was.134.1257485988509;
        Thu, 05 Nov 2009 21:39:48 -0800 (PST)
Received: from ?172.16.2.101? ([222.92.8.142])
        by mx.google.com with ESMTPS id 23sm1565058pzk.0.2009.11.05.21.39.41
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 05 Nov 2009 21:39:47 -0800 (PST)
Subject: Re: [PATCH -queue v0 4/6] [loongson] add basic fuloong2f support
From:	Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org, LKML <linux-kernel@vger.kernel.org>,
	huhb@lemote.com, yanh@lemote.com, Zhang Le <r0bertz@gentoo.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Nicholas Mc Guire <der.herr@hofr.at>, zhangfx@lemote.com,
	liujl@lemote.com
In-Reply-To: <20091105131603.GA18232@linux-mips.org>
References: <cover.1257325319.git.wuzhangjin@gmail.com>
	 <0f805f7d12c5a7cbcc125ba4a1b70113ec2047a6.1257325319.git.wuzhangjin@gmail.com>
	 <20091105131603.GA18232@linux-mips.org>
Content-Type: text/plain; charset="UTF-8"
Organization: DSLab, Lanzhou University, China
Date:	Fri, 06 Nov 2009 13:39:44 +0800
Message-ID: <1257485984.2299.21.camel@falcon.domain.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.1 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24709
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

On Thu, 2009-11-05 at 14:16 +0100, Ralf Baechle wrote:
> On Wed, Nov 04, 2009 at 05:05:47PM +0800, Wu Zhangjin wrote:
> 
> > diff --git a/arch/mips/loongson/fuloong-2f/irq.c b/arch/mips/loongson/fuloong-2f/irq.c
> > new file mode 100644
> > index 0000000..22c45fd
> > --- /dev/null
> > +++ b/arch/mips/loongson/fuloong-2f/irq.c
> > @@ -0,0 +1,114 @@
> > +/*
> > + * Copyright (C) 2007 Lemote Inc.
> > + * Author: Fuxin Zhang, zhangfx@lemote.com
> > + *
> > + *  This program is free software; you can redistribute  it and/or modify it
> > + *  under  the terms of  the GNU General  Public License as published by the
> > + *  Free Software Foundation;  either version 2 of the  License, or (at your
> > + *  option) any later version.
> > + */
> > +
> > +#include <linux/interrupt.h>
> > +
> > +#include <asm/irq_cpu.h>
> > +#include <asm/i8259.h>
> > +#include <asm/mipsregs.h>
> > +
> > +#include <loongson.h>
> > +#include <machine.h>
> > +
> > +#define LOONGSON_TIMER_IRQ	(MIPS_CPU_IRQ_BASE + 7)	/* cpu timer */
> > +#define LOONGSON_PERFCNT_IRQ	(MIPS_CPU_IRQ_BASE + 6) /* cpu perf counter */
> > +#define LOONGSON_NORTH_BRIDGE_IRQ	(MIPS_CPU_IRQ_BASE + 6)	/* bonito */
> > +#define LOONGSON_UART_IRQ	(MIPS_CPU_IRQ_BASE + 3)	/* cpu serial port */
> > +#define LOONGSON_SOUTH_BRIDGE_IRQ	(MIPS_CPU_IRQ_BASE + 2)	/* i8259 */
> > +
> > +#define LOONGSON_INT_BIT_INT0		(1 << 11)
> > +#define LOONGSON_INT_BIT_INT1		(1 << 12)
> > +
> > +static int mach_i8259_irq(void)
> > +{
> > +	int irq, isr, imr;
> > +
> > +	irq = -1;
> > +
> > +	if ((LOONGSON_INTISR & LOONGSON_INTEN) & LOONGSON_INT_BIT_INT0) {
> > +		imr = inb(0x21) | (inb(0xa1) << 8);
> > +		isr = inb(0x20) | (inb(0xa0) << 8);
> > +		isr &= ~0x4;	/* irq2 for cascade */
> > +		isr &= ~imr;
> > +		irq = ffs(isr) - 1;
> > +	}
> 
> Any reason why you're not using i8259_irq() from <asm/i8259.h> here?
> That function not only gets the locking right, it also minimizes the number
> of accesses to the i8259 - which even on modern silicon can be stuningly
> slow.
> 

Hi, Ralf

Just asked Yanhua, He told me there is a bug in cs5536, if using the
i8259_irq() directly, we can not get the irq. and just tried it, the
kernel hang on booting.

Regards,
	Wu Zhangjin

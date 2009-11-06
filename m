Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Nov 2009 09:34:56 +0100 (CET)
Received: from mail-pw0-f45.google.com ([209.85.160.45]:55325 "EHLO
	mail-pw0-f45.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492199AbZKFIeu (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 6 Nov 2009 09:34:50 +0100
Received: by pwi15 with SMTP id 15so543284pwi.24
        for <multiple recipients>; Fri, 06 Nov 2009 00:34:43 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=SICRChQB/BsL72aoh0mkO5ZKN4SCJTldKS+7XYaaQpk=;
        b=S/fqkumfaljk47dV+Z81IGK40dDzzFhSUBiTan7qd4OFts1PL1MwVTPdmTkpydLA47
         ExLO6UswPXH5dpqaJO5ESuRGi6AU3q3egeqRtR/JY2okU5acPawXi5A2+8vls32W1l8L
         27VSOk5qsGlSQtsiJcOSH9152X2GWEPVQV0CI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=fQkAQYdg/Gp+VLroKUEVJGTzQQ9iPZve2cK2Rf+g4doWjVsjj6JIN+pMPSUlaViQh0
         I8503DJKn1EqgrHLrqwD8zLO//8Z2BnHsOMaqAWg3h+iWGczqZnt2943PFB7PBJDlmxi
         YAIevvNgc/kaQuTpPUZo49JtV8ue6I5L3WfpE=
Received: by 10.115.26.13 with SMTP id d13mr6349998waj.210.1257496483416;
        Fri, 06 Nov 2009 00:34:43 -0800 (PST)
Received: from ?172.16.2.101? ([222.92.8.142])
        by mx.google.com with ESMTPS id 22sm1626060pzk.14.2009.11.06.00.34.38
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 06 Nov 2009 00:34:43 -0800 (PST)
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
Date:	Fri, 06 Nov 2009 16:34:41 +0800
Message-ID: <1257496481.2299.30.camel@falcon.domain.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.1 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24711
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

Hi,

On Thu, 2009-11-05 at 14:16 +0100, Ralf Baechle wrote:
[...]
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

Just checked it again, seems we can only access the ISR registers, but
even if with this restriction, we can also optimize it to minimize the
number of accesses to the i8259, this is the new version:

+ isr = inb(PIC_MASTER_CMD) &
+     ~inb(PIC_MASTER_IMR) & ~(1 << PIC_CASCADE_IR);
+ if (!isr)
+    isr = (inb(PIC_SLAVE_CMD) & ~inb(PIC_SLAVE_IMR)) << 8;

Will resend it with this version.

Thanks,
	Wu Zhangjin

Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Nov 2009 11:06:18 +0100 (CET)
Received: from mail-pw0-f45.google.com ([209.85.160.45]:58053 "EHLO
	mail-pw0-f45.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492246AbZKFKGL (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 6 Nov 2009 11:06:11 +0100
Received: by pwi15 with SMTP id 15so578114pwi.24
        for <multiple recipients>; Fri, 06 Nov 2009 02:06:03 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=Oh5P0bl7b1wMO+JvV6GC1dL0R3NGWWphhs3nCYJHBCc=;
        b=rmgq678u8I9xflj5keV5aRHNxzIKjXEIRF6F2bpMqcfmk+Iofsazio+ajvEFiGTeft
         UnTlqeO48RwR/z9WgYquaP2Q0hJSt5Wm9BNSvTzPlBIUO9VvRH9WKxBT/6XeXgn4vWlu
         j77hW9dUtrWw0VDYhETN/+5SBrDTCDFOAdIi4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=xfV/sDxlZ/ReG1Hk98JXSFPYSKZFU/USVXPgSV3zt0HvAKz9kFUBiud/vwcFduGsy5
         SIhwr2AuwkO1nPV812qalHyhxfqkxsvdEETY+YIzeie4C2n0OZiOG96DY0nbPz7TmHjk
         lc51S9qa/dCdmoGWr8lWFoNdmSAATTE8ClahA=
Received: by 10.114.164.20 with SMTP id m20mr6377197wae.216.1257501963140;
        Fri, 06 Nov 2009 02:06:03 -0800 (PST)
Received: from ?172.16.2.101? ([222.92.8.142])
        by mx.google.com with ESMTPS id 23sm975954pxi.13.2009.11.06.02.05.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 06 Nov 2009 02:06:02 -0800 (PST)
Subject: Re: [PATCH -queue v0 4/6] [loongson] add basic fuloong2f support
From:	Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org, LKML <linux-kernel@vger.kernel.org>,
	huhb@lemote.com, yanh@lemote.com, Zhang Le <r0bertz@gentoo.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Nicholas Mc Guire <der.herr@hofr.at>, zhangfx@lemote.com,
	liujl@lemote.com
In-Reply-To: <20091106083042.GA17723@linux-mips.org>
References: <cover.1257325319.git.wuzhangjin@gmail.com>
	 <0f805f7d12c5a7cbcc125ba4a1b70113ec2047a6.1257325319.git.wuzhangjin@gmail.com>
	 <20091105131603.GA18232@linux-mips.org>
	 <1257485984.2299.21.camel@falcon.domain.org>
	 <20091106083042.GA17723@linux-mips.org>
Content-Type: text/plain; charset="UTF-8"
Organization: DSLab, Lanzhou University, China
Date:	Fri, 06 Nov 2009 18:05:59 +0800
Message-ID: <1257501959.2299.52.camel@falcon.domain.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.1 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24712
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

Hi, Ralf

I will split the coming patchset as three parts?

1. fixes of old support
2. loongson2f support
3. lemote 2f family machines support

is this okay?

Regards,
	Wu Zhangjin

On Fri, 2009-11-06 at 09:30 +0100, Ralf Baechle wrote:
> On Fri, Nov 06, 2009 at 01:39:44PM +0800, Wu Zhangjin wrote:
> 
> > > > +	if ((LOONGSON_INTISR & LOONGSON_INTEN) & LOONGSON_INT_BIT_INT0) {
> > > > +		imr = inb(0x21) | (inb(0xa1) << 8);
> > > > +		isr = inb(0x20) | (inb(0xa0) << 8);
> > > > +		isr &= ~0x4;	/* irq2 for cascade */
> > > > +		isr &= ~imr;
> > > > +		irq = ffs(isr) - 1;
> > > > +	}
> > > 
> > > Any reason why you're not using i8259_irq() from <asm/i8259.h> here?
> > > That function not only gets the locking right, it also minimizes the number
> > > of accesses to the i8259 - which even on modern silicon can be stuningly
> > > slow.
> 
> > Just asked Yanhua, He told me there is a bug in cs5536, if using the
> > i8259_irq() directly, we can not get the irq. and just tried it, the
> > kernel hang on booting.
> 
> Wonderful.  Even 30 years after it was built there are still new i8259
> bugs :-)
> 
> This is probably worth a comment in the code.
> 
>   Ralf

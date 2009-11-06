Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Nov 2009 09:29:31 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:45015 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-FAIL) by ftp.linux-mips.org with ESMTP
	id S1492224AbZKFI32 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 6 Nov 2009 09:29:28 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id nA68UlEa028644;
	Fri, 6 Nov 2009 09:30:48 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id nA68UgG2028640;
	Fri, 6 Nov 2009 09:30:42 +0100
Date:	Fri, 6 Nov 2009 09:30:42 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Wu Zhangjin <wuzhangjin@gmail.com>
Cc:	linux-mips@linux-mips.org, LKML <linux-kernel@vger.kernel.org>,
	huhb@lemote.com, yanh@lemote.com, Zhang Le <r0bertz@gentoo.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Nicholas Mc Guire <der.herr@hofr.at>, zhangfx@lemote.com,
	liujl@lemote.com
Subject: Re: [PATCH -queue v0 4/6] [loongson] add basic fuloong2f support
Message-ID: <20091106083042.GA17723@linux-mips.org>
References: <cover.1257325319.git.wuzhangjin@gmail.com> <0f805f7d12c5a7cbcc125ba4a1b70113ec2047a6.1257325319.git.wuzhangjin@gmail.com> <20091105131603.GA18232@linux-mips.org> <1257485984.2299.21.camel@falcon.domain.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1257485984.2299.21.camel@falcon.domain.org>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24710
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Nov 06, 2009 at 01:39:44PM +0800, Wu Zhangjin wrote:

> > > +	if ((LOONGSON_INTISR & LOONGSON_INTEN) & LOONGSON_INT_BIT_INT0) {
> > > +		imr = inb(0x21) | (inb(0xa1) << 8);
> > > +		isr = inb(0x20) | (inb(0xa0) << 8);
> > > +		isr &= ~0x4;	/* irq2 for cascade */
> > > +		isr &= ~imr;
> > > +		irq = ffs(isr) - 1;
> > > +	}
> > 
> > Any reason why you're not using i8259_irq() from <asm/i8259.h> here?
> > That function not only gets the locking right, it also minimizes the number
> > of accesses to the i8259 - which even on modern silicon can be stuningly
> > slow.

> Just asked Yanhua, He told me there is a bug in cs5536, if using the
> i8259_irq() directly, we can not get the irq. and just tried it, the
> kernel hang on booting.

Wonderful.  Even 30 years after it was built there are still new i8259
bugs :-)

This is probably worth a comment in the code.

  Ralf

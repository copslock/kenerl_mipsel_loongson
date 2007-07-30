Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Jul 2007 13:06:07 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:49846 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20022572AbXG3MGF (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 30 Jul 2007 13:06:05 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l6UC5xxj014191;
	Mon, 30 Jul 2007 13:05:59 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l6UC5vJo014190;
	Mon, 30 Jul 2007 13:05:57 +0100
Date:	Mon, 30 Jul 2007 13:05:57 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	"H. Peter Anvin" <hpa@zytor.com>
Cc:	maximilian attems <max@stro.at>, linux-mips@linux-mips.org,
	klibc@zytor.com
Subject: Re: [klibc] klibc kernelheaders build failure on mips/mipsel
Message-ID: <20070730120557.GE11436@linux-mips.org>
References: <20070729095217.GE7448@stro.at> <46AC997B.2030706@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46AC997B.2030706@zytor.com>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15940
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, Jul 29, 2007 at 06:43:23AM -0700, H. Peter Anvin wrote:

> >  In file included from usr/klibc/arch/mips/crt0.S:11:
> >  usr/include/arch/mips/machine/asm.h:8:24: error: asm/regdef.h: No such
> >  file or directory
> >  usr/include/arch/mips/machine/asm.h:9:21: error: asm/asm.h: No such file
> >  or directory
> >
> >  i'm not sure if you want to export both headers in the make
> >  kernelheaders target or if it is the fault of klibc to assume
> >  that those are available?
> >
> 
> If I remember correctly (sorry, I'm on the road at the moment), those 
> files should be exportable.  They wouldn't be all that hard to replicate 
> in klibc, though.

<asm/asm.h> would need to add __KERNEL__ wrappers around the CONFIG_* bits.
In addition you probably want to have <asm/fpregdef.h> exported.  With a
few changes you should be able to get away without using <asm/sgidefs.h>.

  Ralf

Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Oct 2009 21:57:17 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:42490 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-FAIL) by ftp.linux-mips.org with ESMTP
	id S1493615AbZJMT5O (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 13 Oct 2009 21:57:14 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n9DJwS6k002811;
	Tue, 13 Oct 2009 21:58:29 +0200
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n9DJwM88002809;
	Tue, 13 Oct 2009 21:58:22 +0200
Date:	Tue, 13 Oct 2009 21:58:22 +0200
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Dmitri Vorobiev <dmitri.vorobiev@gmail.com>
Cc:	Linux-MIPS <linux-mips@linux-mips.org>, davem@davemloft.net
Subject: Re: [RFC] [IP22] parsing PROM variables at startup
Message-ID: <20091013195822.GA2686@linux-mips.org>
References: <90edad820910131055t3cb46d39t87fa568c001634cf@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <90edad820910131055t3cb46d39t87fa568c001634cf@mail.gmail.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24279
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Oct 13, 2009 at 08:55:12PM +0300, Dmitri Vorobiev wrote:

> I tried booting a few kernels, ranging from 2.2.1 to the current Linus
> Git, on my IP22s using an ecoff image directly, without the help of
> arcboot or tip22. It turns out that during many years (at least, since
> the times of late 2.4 series) the sizes of ecoff images have been so
> big that ARCS was not capable of reading the kernel images. Therefore,
> I'd like to claim that it's safe to assume that at least from now on,
> nobody is ever going to boot ecoffs on IP22 whatsoever, and arcboot
> and tip22 remain the only way to load Linux on an IP22 machine.

Only the very oldest IP22 firmware does not support ELF files.  In practice
those seem to be very rare - I never encountered one - and Linux
distributions are shipping a 2nd stage bootloader, so there never has
been much of a need for booting ECOFF, at least not on Indy.

> I'm leading to the following thing. Currently we have the
> arch/mips/fw/arc/cmdline.c, which assumes that the kernel could
> receive command-line parameters directly from PROM, including such
> variables as OSLoadPartition, OSLoadFilename, etc. Both arcboot and
> tip22 handle those parameters by themselves, never exposing them to
> the kernel. The latter fact is easy to see from the sources of the
> arcboot and tip22 loaders. That said, I would like to simplify
> arch/mips/fw/arc/cmdline.c::prom_init_cmdline() so that the PROM
> variables do not get any special treatment.

But keep kernels usable without a 2nd stage bootloader.  I for example
have never ever used one on my SGI hardware.

> Are you asking me why did I start touching the 13-years-old code?
> 
> There is an unpleasant bug in the current PROM command line handler.
> Namely, the CONFIG_CMDLINE, if set, is overwritten when
> prom_init_cmdline() tries to strip off some of the PROM variables, and
> it's easy to see from the code of that function. So, I thought of
> fixing that, and, simultaneously, of simplifying the overall logic by
> assuming that we never ever have to special-case the PROM variables at
> all.
> 
> Could anyone see any drawbacks in the discourse above? If not, I'll
> start making a patch.

I think nobody will claim a 13 year old quickhack can't be improved.

  Ralf

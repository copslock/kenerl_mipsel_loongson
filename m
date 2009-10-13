Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Oct 2009 22:39:22 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:49660 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-FAIL) by ftp.linux-mips.org with ESMTP
	id S1493632AbZJMUjT (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 13 Oct 2009 22:39:19 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n9DKeY9v004082;
	Tue, 13 Oct 2009 22:40:34 +0200
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n9DKeUJI004080;
	Tue, 13 Oct 2009 22:40:30 +0200
Date:	Tue, 13 Oct 2009 22:40:29 +0200
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Dmitri Vorobiev <dmitri.vorobiev@gmail.com>
Cc:	Linux-MIPS <linux-mips@linux-mips.org>, davem@davemloft.net
Subject: Re: [RFC] [IP22] parsing PROM variables at startup
Message-ID: <20091013204029.GC727@linux-mips.org>
References: <90edad820910131055t3cb46d39t87fa568c001634cf@mail.gmail.com> <20091013195822.GA2686@linux-mips.org> <90edad820910131330t67d6b293o150bef62aec0c5eb@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <90edad820910131330t67d6b293o150bef62aec0c5eb@mail.gmail.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24281
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Oct 13, 2009 at 11:30:29PM +0300, Dmitri Vorobiev wrote:

> >> I tried booting a few kernels, ranging from 2.2.1 to the current Linus
> >> Git, on my IP22s using an ecoff image directly, without the help of
> >> arcboot or tip22. It turns out that during many years (at least, since
> >> the times of late 2.4 series) the sizes of ecoff images have been so
> >> big that ARCS was not capable of reading the kernel images. Therefore,
> >> I'd like to claim that it's safe to assume that at least from now on,
> >> nobody is ever going to boot ecoffs on IP22 whatsoever, and arcboot
> >> and tip22 remain the only way to load Linux on an IP22 machine.
> >
> > Only the very oldest IP22 firmware does not support ELF files.  In practice
> > those seem to be very rare - I never encountered one - and Linux
> > distributions are shipping a 2nd stage bootloader, so there never has
> > been much of a need for booting ECOFF, at least not on Indy.
> 
> That is, it's safe to assume that it's either a 32-bit ELF or a 2nd
> stage bootloader that gets loaded by the firmware.

Yes.  The IP22 firmware does not support 64-bit ELF, so 64-bit kernels
have to be converted to 32-bit ELF for booting first.  The vmlinux.32
target does that.

  Ralf

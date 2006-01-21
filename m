Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 21 Jan 2006 01:01:31 +0000 (GMT)
Received: from i-83-67-53-76.freedom2surf.net ([83.67.53.76]:14537 "EHLO
	nephila.localnet") by ftp.linux-mips.org with ESMTP
	id S3951045AbWAUBBD (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 21 Jan 2006 01:01:03 +0000
Received: from pdh by nephila.localnet with local (Exim 4.50)
	id 1F07BX-0000yf-Gh; Sat, 21 Jan 2006 01:04:55 +0000
Date:	Sat, 21 Jan 2006 01:04:55 +0000
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Martin Michlmayr <tbm@cyrius.com>, linux-mips@linux-mips.org
Subject: Re: Crash on Cobalt with CONFIG_SERIO=y
Message-ID: <20060121010455.GC3514@colonel-panic.org>
References: <20060120004208.GA18327@deprecation.cyrius.com> <20060120144710.GA30415@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060120144710.GA30415@linux-mips.org>
User-Agent: Mutt/1.5.9i
From:	Peter Horton <pdh@colonel-panic.org>
Return-Path: <pdh@colonel-panic.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10034
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pdh@colonel-panic.org
Precedence: bulk
X-list: linux-mips

On Fri, Jan 20, 2006 at 03:47:10PM +0100, Ralf Baechle wrote:
> On Fri, Jan 20, 2006 at 12:42:08AM +0000, Martin Michlmayr wrote:
> 
> > I get the following crash on Cobalt when CONFIG_SERIO=y is set.
> > I realize that this option is not really necessary on Cobalt but the
> > kernel should neverless not crash if it is enabled.
> > 
> > 
> >  Activating ISA DMA hang workarounds.
> >  rtc: Digital UNIX epoch (1952) detected
> >  Real Time Clock Driver v1.12a
> >  Cobalt LCD Driver v2.10
> >  i8042.c: i8042 controller self test timeout.
> >  Unhandled kernel unaligned access[#1]:
> 
> The i8042 error message is a little surprising.  The Cobalt boards afair
> have some sort of SuperIO chip on the board which includes PS/2 keyboard
> even though that has not been wired.  I wonder if anybody can take a
> look at the board what type of SuperIO is there?
> 

No SuperIO, but there is a bog standard VIA PCI-ISA bridge which
contains a bog standard PS/2 keyboard controller, which you would have
thought should just work ...

P.

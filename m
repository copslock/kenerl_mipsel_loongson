Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Oct 2007 17:27:11 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:60804 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20023427AbXJKQ1J (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 11 Oct 2007 17:27:09 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l9BGQM8P003250;
	Thu, 11 Oct 2007 17:26:22 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l9BGPtA3001998;
	Thu, 11 Oct 2007 17:25:55 +0100
Date:	Thu, 11 Oct 2007 17:25:55 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	Thiemo Seufer <ths@networkno.de>,
	Franck Bui-Huu <vagabon.xyz@gmail.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [RFC] Add __initbss section
Message-ID: <20071011162554.GC12782@linux-mips.org>
References: <470DF25E.60009@gmail.com> <20071011152615.GE3379@networkno.de> <Pine.LNX.4.64N.0710111707010.16370@blysk.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64N.0710111707010.16370@blysk.ds.pg.gda.pl>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16973
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Oct 11, 2007 at 05:16:45PM +0100, Maciej W. Rozycki wrote:

> > > Also not that with the current patchset applied, there are now 2
> > > segments that need to be loaded, hopefully it won't cause any issues
> > > with any bootloaders out there that would assume that an image has
> > > only one segment...
> > 
> > This breaks at least conversion to ECOFF as used on DECstations.
> 
>  Indeed, thanks for pointing it out -- I use ELF over MOP and keep 
> forgetting about people preferring TFTP, sigh.  I wonder whether `objcopy' 
> might be doing a better job than `elf2ecoff' these days though.  It may be 
> worth checking...

That would be quite unexpected.  Binutils has severe issues when used
with multiple binary formats.  For the general case fixing and maintaining
that would be of almost nightmarish complexity so years ago I settled for
elf2ecoff and I guess that step also made binutils maintainers alot
happier ;-)

>  It all boils down to padding out what cannot be expressed in a less 
> capable format after all.  That's what I did in `mopd' for ELF support too 
> -- holes between segments are transmitted as zeroes.  Though MOP clients 
> may actually support discontiguous images as each MOP "downline load" 
> packet has its designated memory load address included in the header (it 
> just shows how reasonable a bootstrap protocol it is!).

With ELF dumb more generic protocols like TFTP work great.  Shows what
a great format ELF is ;-)

  Ralf

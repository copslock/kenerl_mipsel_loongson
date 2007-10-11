Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Oct 2007 17:39:41 +0100 (BST)
Received: from relay01.mx.bawue.net ([193.7.176.67]:47786 "EHLO
	relay01.mx.bawue.net") by ftp.linux-mips.org with ESMTP
	id S20024057AbXJKQjd (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 11 Oct 2007 17:39:33 +0100
Received: from lagash (intrt.mips-uk.com [194.74.144.130])
	by relay01.mx.bawue.net (Postfix) with ESMTP id BD97F48BCB;
	Thu, 11 Oct 2007 18:39:05 +0200 (CEST)
Received: from ths by lagash with local (Exim 4.67)
	(envelope-from <ths@networkno.de>)
	id 1Ig14G-0003Uz-97; Thu, 11 Oct 2007 17:39:24 +0100
Date:	Thu, 11 Oct 2007 17:39:24 +0100
From:	Thiemo Seufer <ths@networkno.de>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	Franck Bui-Huu <vagabon.xyz@gmail.com>,
	Ralf Baechle <ralf@linux-mips.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [RFC] Add __initbss section
Message-ID: <20071011163924.GG3379@networkno.de>
References: <470DF25E.60009@gmail.com> <20071011152615.GE3379@networkno.de> <Pine.LNX.4.64N.0710111707010.16370@blysk.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64N.0710111707010.16370@blysk.ds.pg.gda.pl>
User-Agent: Mutt/1.5.16 (2007-06-11)
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16974
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

Maciej W. Rozycki wrote:
> On Thu, 11 Oct 2007, Thiemo Seufer wrote:
> 
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

The problem seems to be that (DECstation-firmware's view of) ECOFF can
only handle a single .text segment.

>  It all boils down to padding out what cannot be expressed in a less 
> capable format after all.  That's what I did in `mopd' for ELF support too 
> -- holes between segments are transmitted as zeroes.

AFAICS this won't work for interleaved .text / .data / .bss segments.


Thiemo

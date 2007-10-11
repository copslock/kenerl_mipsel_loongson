Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Oct 2007 17:17:34 +0100 (BST)
Received: from cerber.ds.pg.gda.pl ([153.19.208.18]:734 "EHLO
	cerber.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20023236AbXJKQRZ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 11 Oct 2007 17:17:25 +0100
Received: from localhost (unknown [127.0.0.17])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id 892AF400B9;
	Thu, 11 Oct 2007 18:16:56 +0200 (CEST)
X-Virus-Scanned: amavisd-new at cerber.ds.pg.gda.pl
Received: from cerber.ds.pg.gda.pl ([153.19.208.18])
	by localhost (cerber.ds.pg.gda.pl [153.19.208.18]) (amavisd-new, port 10024)
	with ESMTP id 0kC1jBTsWp8s; Thu, 11 Oct 2007 18:16:46 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id BD69B40095;
	Thu, 11 Oct 2007 18:16:46 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.8) with ESMTP id l9BGGoll026536;
	Thu, 11 Oct 2007 18:16:51 +0200
Date:	Thu, 11 Oct 2007 17:16:45 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Thiemo Seufer <ths@networkno.de>
cc:	Franck Bui-Huu <vagabon.xyz@gmail.com>,
	Ralf Baechle <ralf@linux-mips.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [RFC] Add __initbss section
In-Reply-To: <20071011152615.GE3379@networkno.de>
Message-ID: <Pine.LNX.4.64N.0710111707010.16370@blysk.ds.pg.gda.pl>
References: <470DF25E.60009@gmail.com> <20071011152615.GE3379@networkno.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.91.2/4529/Thu Oct 11 08:54:06 2007 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16971
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, 11 Oct 2007, Thiemo Seufer wrote:

> > Also not that with the current patchset applied, there are now 2
> > segments that need to be loaded, hopefully it won't cause any issues
> > with any bootloaders out there that would assume that an image has
> > only one segment...
> 
> This breaks at least conversion to ECOFF as used on DECstations.

 Indeed, thanks for pointing it out -- I use ELF over MOP and keep 
forgetting about people preferring TFTP, sigh.  I wonder whether `objcopy' 
might be doing a better job than `elf2ecoff' these days though.  It may be 
worth checking...

 It all boils down to padding out what cannot be expressed in a less 
capable format after all.  That's what I did in `mopd' for ELF support too 
-- holes between segments are transmitted as zeroes.  Though MOP clients 
may actually support discontiguous images as each MOP "downline load" 
packet has its designated memory load address included in the header (it 
just shows how reasonable a bootstrap protocol it is!).

  Maciej

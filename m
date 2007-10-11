Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Oct 2007 18:08:26 +0100 (BST)
Received: from cerber.ds.pg.gda.pl ([153.19.208.18]:46004 "EHLO
	cerber.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20030622AbXJKRIR (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 11 Oct 2007 18:08:17 +0100
Received: from localhost (unknown [127.0.0.17])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id 74870400A4;
	Thu, 11 Oct 2007 19:07:48 +0200 (CEST)
X-Virus-Scanned: amavisd-new at cerber.ds.pg.gda.pl
Received: from cerber.ds.pg.gda.pl ([153.19.208.18])
	by localhost (cerber.ds.pg.gda.pl [153.19.208.18]) (amavisd-new, port 10024)
	with ESMTP id pfqeZf21Yl8x; Thu, 11 Oct 2007 19:07:42 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id 62E2240095;
	Thu, 11 Oct 2007 19:07:42 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.8) with ESMTP id l9BH7lfu008918;
	Thu, 11 Oct 2007 19:07:47 +0200
Date:	Thu, 11 Oct 2007 18:07:41 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Ralf Baechle <ralf@linux-mips.org>
cc:	Thiemo Seufer <ths@networkno.de>,
	Franck Bui-Huu <vagabon.xyz@gmail.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [RFC] Add __initbss section
In-Reply-To: <20071011162554.GC12782@linux-mips.org>
Message-ID: <Pine.LNX.4.64N.0710111745160.16370@blysk.ds.pg.gda.pl>
References: <470DF25E.60009@gmail.com> <20071011152615.GE3379@networkno.de>
 <Pine.LNX.4.64N.0710111707010.16370@blysk.ds.pg.gda.pl>
 <20071011162554.GC12782@linux-mips.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.91.2/4529/Thu Oct 11 08:54:06 2007 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16975
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, 11 Oct 2007, Ralf Baechle wrote:

> That would be quite unexpected.  Binutils has severe issues when used
> with multiple binary formats.  For the general case fixing and maintaining
> that would be of almost nightmarish complexity so years ago I settled for
> elf2ecoff and I guess that step also made binutils maintainers alot
> happier ;-)

 I have now recalled what the issue is -- `objcopy' is keen to copy the 
file header as well as possible and that includes MIPS-III annotation 
which makes the firmware of R4k-based DECstations unhappy.  They all 
expect MIPS-I binaries.  It's not binutils's fault I am afraid.

> With ELF dumb more generic protocols like TFTP work great.  Shows what
> a great format ELF is ;-)

 Yeah, sure...  Until you discover your ELF parser in the firmware does 
not do this and that and also crashes on yet something else (since when 
has CFE supported ELF64, then?).  You cannot escape such bugs as one with 
ECOFF above for example.  And if your firmware is a binary blob in a 
classic PROM, then you are bust.

 At least an <address,size> pair is dumb enough it is hard to get it wrong 
and `mopd' may be modified however you like to get what you need; the 
daemon itself is not interested in the gory details of the binary being 
sent, so it will accept about anything remotely conforming to the ELF 
format anyway. :-)

  Maciej

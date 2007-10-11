Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Oct 2007 14:19:19 +0100 (BST)
Received: from cerber.ds.pg.gda.pl ([153.19.208.18]:27543 "EHLO
	cerber.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20030439AbXJKNTJ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 11 Oct 2007 14:19:09 +0100
Received: from localhost (unknown [127.0.0.17])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id 2AA03400A4;
	Thu, 11 Oct 2007 15:19:10 +0200 (CEST)
X-Virus-Scanned: amavisd-new at cerber.ds.pg.gda.pl
Received: from cerber.ds.pg.gda.pl ([153.19.208.18])
	by localhost (cerber.ds.pg.gda.pl [153.19.208.18]) (amavisd-new, port 10024)
	with ESMTP id qfCR-O5NWLGY; Thu, 11 Oct 2007 15:19:03 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id D3C6C40095;
	Thu, 11 Oct 2007 15:19:03 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.8) with ESMTP id l9BDJ7eL024056;
	Thu, 11 Oct 2007 15:19:07 +0200
Date:	Thu, 11 Oct 2007 14:19:02 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Franck Bui-Huu <vagabon.xyz@gmail.com>
cc:	Ralf Baechle <ralf@linux-mips.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [RFC] Add __initbss section
In-Reply-To: <470DF25E.60009@gmail.com>
Message-ID: <Pine.LNX.4.64N.0710111307180.16370@blysk.ds.pg.gda.pl>
References: <470DF25E.60009@gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.91.2/4529/Thu Oct 11 08:54:06 2007 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16960
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, 11 Oct 2007, Franck Bui-Huu wrote:

> and the kernel image is bigger after the patch is applied !
> 
> $ ls -l vmlinux*
> -rwxrwxr-x 1 fbuihuu fbuihuu 2503324 2007-10-11 11:41 vmlinux*
> -rwxrwxr-x 1 fbuihuu fbuihuu 2503264 2007-10-11 11:41 vmlinux~old*
> 
> Could anybody explain me why ? The time is missing and I probably
> couldn't investigate into this until this weekend. 

 I guess for a bss-type section you want to use something like:

	.section .init.bss,"aw",@nobits

> Also not that with the current patchset applied, there are now 2
> segments that need to be loaded, hopefully it won't cause any issues
> with any bootloaders out there that would assume that an image has
> only one segment...

 Well, there should be no need for an extra segment -- just rearrange the 
order of the sections in the linker script appropriately.  You should 
probably add __exitbss for consistency too.  You can make all the three 
sections adjacent so that no separate initialisation is required.

 Another place for optimisation are inline string literals referred to 
from .init.text or .exit.text only, which is a bit more complicated to 
handle, but sounds interesting enough to me I shall give it a try in the 
next few days.  I have an idea how to do it.

  Maciej

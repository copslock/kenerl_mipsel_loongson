Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Oct 2007 13:19:53 +0100 (BST)
Received: from cerber.ds.pg.gda.pl ([153.19.208.18]:8607 "EHLO
	cerber.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20036514AbXJOMTp (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 15 Oct 2007 13:19:45 +0100
Received: from localhost (unknown [127.0.0.17])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id 9753940085;
	Mon, 15 Oct 2007 14:19:45 +0200 (CEST)
X-Virus-Scanned: amavisd-new at cerber.ds.pg.gda.pl
Received: from cerber.ds.pg.gda.pl ([153.19.208.18])
	by localhost (cerber.ds.pg.gda.pl [153.19.208.18]) (amavisd-new, port 10024)
	with ESMTP id CAZhX-dqV93X; Mon, 15 Oct 2007 14:19:40 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id 217D3400E0;
	Mon, 15 Oct 2007 14:19:40 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.8) with ESMTP id l9FCJgLE022766;
	Mon, 15 Oct 2007 14:19:42 +0200
Date:	Mon, 15 Oct 2007 13:19:39 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Franck Bui-Huu <vagabon.xyz@gmail.com>
cc:	Ralf Baechle <ralf@linux-mips.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [RFC] Add __initbss section
In-Reply-To: <4712738A.5000703@gmail.com>
Message-ID: <Pine.LNX.4.64N.0710151311350.16262@blysk.ds.pg.gda.pl>
References: <470DF25E.60009@gmail.com> <Pine.LNX.4.64N.0710111307180.16370@blysk.ds.pg.gda.pl>
 <4712738A.5000703@gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.91.2/4540/Sun Oct 14 03:43:55 2007 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17035
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, 14 Oct 2007, Franck Bui-Huu wrote:

> >  I guess for a bss-type section you want to use something like:
> > 
> > 	.section .init.bss,"aw",@nobits
> > 
> 
> Sorry but I'm missing your point here. This indeed should be added
> for assembler code but I don't see how it's related with the kernel
> image size difference I was seeing.

 Well, otherwise the section is marked as containing data and therefore 
taking space in the image.  Compare the output of `readelf -S' and/or 
`objdump -h' with and without the directive above.

 What do you mean by "assembler code" in this context, BTW?  Everything is 
assembler code, be it handwritten or GCC-generated.  Have a look at how 
GCC sets flags for your section, by running `gcc -S' and examining the 
output.

  Maciej

Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Oct 2007 11:30:43 +0100 (BST)
Received: from cerber.ds.pg.gda.pl ([153.19.208.18]:39331 "EHLO
	cerber.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20039751AbXJPKae (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 16 Oct 2007 11:30:34 +0100
Received: from localhost (unknown [127.0.0.17])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id 0AF7A4011C;
	Tue, 16 Oct 2007 12:30:04 +0200 (CEST)
X-Virus-Scanned: amavisd-new at cerber.ds.pg.gda.pl
Received: from cerber.ds.pg.gda.pl ([153.19.208.18])
	by localhost (cerber.ds.pg.gda.pl [153.19.208.18]) (amavisd-new, port 10024)
	with ESMTP id gIXsutQNyTrP; Tue, 16 Oct 2007 12:29:51 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id E2BF940085;
	Tue, 16 Oct 2007 12:29:51 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.8) with ESMTP id l9GATsL8030506;
	Tue, 16 Oct 2007 12:29:54 +0200
Date:	Tue, 16 Oct 2007 11:29:50 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Franck Bui-Huu <vagabon.xyz@gmail.com>
cc:	Ralf Baechle <ralf@linux-mips.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [RFC] Add __initbss section
In-Reply-To: <4713C840.8080206@gmail.com>
Message-ID: <Pine.LNX.4.64N.0710161123110.22596@blysk.ds.pg.gda.pl>
References: <470DF25E.60009@gmail.com> <Pine.LNX.4.64N.0710111307180.16370@blysk.ds.pg.gda.pl>
 <4712738A.5000703@gmail.com> <Pine.LNX.4.64N.0710151311350.16262@blysk.ds.pg.gda.pl>
 <4713C840.8080206@gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.91.2/4540/Sun Oct 14 03:43:55 2007 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17060
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, 15 Oct 2007, Franck Bui-Huu wrote:

> Well, since .init.bss is declared as follow:
> 
> 	.init.bss (NOLOAD) : {
> 		...
> 	}
> 
> data should not take any space in the image...

 The above only marks it as unloadable (cf. e.g. debugging information).  
It is still there.

> I meant to be able to put data into .init.bss section from assembly
> code (*.S files) like __INITDATA does for .init.data section.

 That does not differ from what has to be done for any other language -- 
ultimately `gas', which is responsible for such arrangements, has to see 
an appropriate ".section" directive.

  Maciej

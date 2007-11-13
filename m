Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Nov 2007 12:11:06 +0000 (GMT)
Received: from cerber.ds.pg.gda.pl ([153.19.208.18]:59033 "EHLO
	cerber.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20026085AbXKMMK6 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 13 Nov 2007 12:10:58 +0000
Received: from localhost (unknown [127.0.0.17])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id 160574016E;
	Tue, 13 Nov 2007 13:10:58 +0100 (CET)
X-Virus-Scanned: amavisd-new at cerber.ds.pg.gda.pl
Received: from cerber.ds.pg.gda.pl ([153.19.208.18])
	by localhost (cerber.ds.pg.gda.pl [153.19.208.18]) (amavisd-new, port 10024)
	with ESMTP id Nv4NKY7sgdrB; Tue, 13 Nov 2007 13:10:48 +0100 (CET)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id B6CFD4008C;
	Tue, 13 Nov 2007 13:10:48 +0100 (CET)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.8) with ESMTP id lADCApmq018676;
	Tue, 13 Nov 2007 13:10:51 +0100
Date:	Tue, 13 Nov 2007 12:10:44 +0000 (GMT)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
cc:	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: problem with 64bit kernel, BOOT_ELF32 and memory outside CKSEG0
In-Reply-To: <20071112223104.GA7900@alpha.franken.de>
Message-ID: <Pine.LNX.4.64N.0711131203110.5550@blysk.ds.pg.gda.pl>
References: <20071111143302.GA26458@alpha.franken.de> <20071111213127.GA26297@linux-mips.org>
 <20071112083242.GA6065@alpha.franken.de> <20071112104423.GA27588@linux-mips.org>
 <20071112223104.GA7900@alpha.franken.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.91.2/4762/Tue Nov 13 11:42:30 2007 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17479
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, 12 Nov 2007, Thomas Bogendoerfer wrote:

> I simply used call_o32.S from the decstation part and missed the
> fact, that it simply uses the normal kernel stack when calling
> firmware. This works quite good until the first kernel thread
> gets scheduled, which has a kernel stack via a CAC_BASE address.

 You could do stack switching in call_o32() -- I just figured there was no 
point in adding this complication as the DECstation always runs from KSEG0 
-- it has the maximum of 480MB of RAM mapped linearly starting from 0.

  Maciej

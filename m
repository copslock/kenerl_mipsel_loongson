Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Aug 2007 17:26:52 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:9736 "EHLO
	pollux.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20021969AbXHAQ0q (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 1 Aug 2007 17:26:46 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 16AC9E1C78;
	Wed,  1 Aug 2007 18:26:42 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
	by localhost (pollux.ds.pg.gda.pl [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nwM8QihGGCDy; Wed,  1 Aug 2007 18:26:41 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id AF540E1C63;
	Wed,  1 Aug 2007 18:26:41 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.8) with ESMTP id l71GQpbE032143;
	Wed, 1 Aug 2007 18:26:51 +0200
Date:	Wed, 1 Aug 2007 17:26:46 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
cc:	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: Modpost warning on Alchemy
In-Reply-To: <46B0AA74.7040100@ru.mvista.com>
Message-ID: <Pine.LNX.4.64N.0708011708250.20314@blysk.ds.pg.gda.pl>
References: <20070801115231.GA20323@linux-mips.org> <46B07B36.1000501@ru.mvista.com>
 <Pine.LNX.4.64N.0708011337390.20314@blysk.ds.pg.gda.pl> <46B086EB.2030101@ru.mvista.com>
 <46B0880B.2000009@ru.mvista.com> <Pine.LNX.4.64N.0708011629010.20314@blysk.ds.pg.gda.pl>
 <46B0AA74.7040100@ru.mvista.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.91.1/3846/Wed Aug  1 09:27:07 2007 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15994
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, 1 Aug 2007, Sergei Shtylyov wrote:

>    PCI config. space is mapped at 0x600000000, well beyond KGSEG0/1.

 It is still just fine with ioremap() -- it will simply use KSEG2 in this 
case.  You cannot bypass the TLB here with a 32-bit processor no matter 
what.

 And regarding what you have written above and the size issue you 
mentioned in another e-mail (do you map the whole PCI config space 
linearly in the physical address space of the CPU or suchlike?) -- PCI 
config space accesses are rare (by design rather than chance), so 
performance is a non-issue and it should be absolutely fine for you to 
call ioremap() and iounmap() in code specific for your PCI host bridge for 
the required fragment upon every access.  There is no need for a permanent 
map here.  You probably waste more performance by taking away a TLB entry 
to wire it anyway.

>    Thanks for wasting time on my education about MIPS. ;-)

 Well, more about Linux perhaps than MIPS in general. :-)

  Maciej

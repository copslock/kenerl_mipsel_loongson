Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Jul 2005 10:45:23 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.7]:46342 "EHLO
	pollux.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8224908AbVGTJpI>; Wed, 20 Jul 2005 10:45:08 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 71C14E1CB1; Wed, 20 Jul 2005 11:46:55 +0200 (CEST)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 31910-03; Wed, 20 Jul 2005 11:46:55 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 37470E1CAC; Wed, 20 Jul 2005 11:46:55 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.3/8.13.1) with ESMTP id j6K9kuT0008110;
	Wed, 20 Jul 2005 11:46:56 +0200
Date:	Wed, 20 Jul 2005 10:47:01 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Thiemo Seufer <ths@networkno.de>
Cc:	Pete Popov <ppopov@embeddedalley.com>,
	Kishore K <hellokishore@gmail.com>,
	Ralf Baechle <ralf@linux-mips.org>,
	"'linux-mips@linux-mips.org'" <linux-mips@linux-mips.org>
Subject: Re: bal instruction in gcc 3.x
In-Reply-To: <20050720091706.GJ2071@hattusa.textio>
Message-ID: <Pine.LNX.4.61L.0507201044420.30702@blysk.ds.pg.gda.pl>
References: <f07e6e05071909301c212ab4@mail.gmail.com> <20050719164427.GB8758@linux-mips.org>
 <f07e6e05071910194bab9b16@mail.gmail.com> <1121802786.7285.88.camel@localhost.localdomain>
 <Pine.LNX.4.61L.0507200955390.30702@blysk.ds.pg.gda.pl>
 <20050720091706.GJ2071@hattusa.textio>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.85.1/984/Tue Jul 19 11:16:09 2005 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8574
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, 20 Jul 2005, Thiemo Seufer wrote:

> >  Apart from other changes why not simply s/bal/jal/?  Your proposed code 
> > is bad if ever to be built to a 64-bit object.
> 
> Non-PIC jal isn't relocateable, the PIC jal wants a regular stack
> frame, and the end of the patch shows the 32bit assumption was
> already made earlier. :-)

 Hmm, the joys of inconsistency -- oh well...

  Maciej

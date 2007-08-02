Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Aug 2007 10:14:53 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:7945 "EHLO
	pollux.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20021941AbXHBJOv (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 2 Aug 2007 10:14:51 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 70288E1C78;
	Thu,  2 Aug 2007 11:14:48 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
	by localhost (pollux.ds.pg.gda.pl [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nnmlz6XyWO1I; Thu,  2 Aug 2007 11:14:48 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 1DCE6E1C66;
	Thu,  2 Aug 2007 11:14:48 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.8) with ESMTP id l729EqxN030127;
	Thu, 2 Aug 2007 11:14:53 +0200
Date:	Thu, 2 Aug 2007 10:14:49 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
cc:	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: Modpost warning on Alchemy
In-Reply-To: <46B0BD99.6070901@ru.mvista.com>
Message-ID: <Pine.LNX.4.64N.0708020945020.22591@blysk.ds.pg.gda.pl>
References: <20070801115231.GA20323@linux-mips.org> <46B07B36.1000501@ru.mvista.com>
 <Pine.LNX.4.64N.0708011337390.20314@blysk.ds.pg.gda.pl> <46B086EB.2030101@ru.mvista.com>
 <46B0880B.2000009@ru.mvista.com> <Pine.LNX.4.64N.0708011629010.20314@blysk.ds.pg.gda.pl>
 <46B0AA74.7040100@ru.mvista.com> <Pine.LNX.4.64N.0708011708250.20314@blysk.ds.pg.gda.pl>
 <46B0B6B4.5090103@ru.mvista.com> <Pine.LNX.4.64N.0708011737170.20314@blysk.ds.pg.gda.pl>
 <46B0BD99.6070901@ru.mvista.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.91.1/3846/Wed Aug  1 09:27:07 2007 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16005
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, 1 Aug 2007, Sergei Shtylyov wrote:

> > So what is the issue with the size then?  How big is the area?
> 
>    I've already said: 4 gigs! At least in theory, actually it's 2 gigs due to

 Oh, I mistook it for the base physical address, sorry.

> a device # being limited to 0 thru 19 (address bits 11 thru 30 are used as
> IDSELx).

 It does not help too much with a 32-bit virtual address space indeed.  
Though I gather it has to be very sparsely populated as 16MiB is enough to 
cover the whole configuration space of a single PCI bus tree.  Thus it has 
to be another example where the chip designer "forgot" to talk to software 
people.  Or a shifter was traded for software performance and complexity. 
;-)

>    I meant that the implementation "caches" the 8 KiB mapping used for the
> last config. access.

 Ah, that can certainly be done with ioremap().

>    There was no need to tell me about how KSEG0/1/2 work -- that's why I
> cosidered it wasting time. :-)

 As I say -- the key is how you look at it.  There are other readers on 
the list who may benefit; it is archived too.  In this sense I can hardly 
consider it a waste of time.  And it was fun to explain and no fun shall 
be ever considered of no use. :-)

  Maciej

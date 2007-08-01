Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Aug 2007 17:55:14 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:25354 "EHLO
	pollux.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20021437AbXHAQzH (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 1 Aug 2007 17:55:07 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 0BD38E1C7B;
	Wed,  1 Aug 2007 18:54:33 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
	by localhost (pollux.ds.pg.gda.pl [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Dpz2Pa28hqHp; Wed,  1 Aug 2007 18:54:32 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id B8CC4E1C66;
	Wed,  1 Aug 2007 18:54:32 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.8) with ESMTP id l71Gsh9P003488;
	Wed, 1 Aug 2007 18:54:43 +0200
Date:	Wed, 1 Aug 2007 17:54:37 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
cc:	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: Modpost warning on Alchemy
In-Reply-To: <46B0B6B4.5090103@ru.mvista.com>
Message-ID: <Pine.LNX.4.64N.0708011737170.20314@blysk.ds.pg.gda.pl>
References: <20070801115231.GA20323@linux-mips.org> <46B07B36.1000501@ru.mvista.com>
 <Pine.LNX.4.64N.0708011337390.20314@blysk.ds.pg.gda.pl> <46B086EB.2030101@ru.mvista.com>
 <46B0880B.2000009@ru.mvista.com> <Pine.LNX.4.64N.0708011629010.20314@blysk.ds.pg.gda.pl>
 <46B0AA74.7040100@ru.mvista.com> <Pine.LNX.4.64N.0708011708250.20314@blysk.ds.pg.gda.pl>
 <46B0B6B4.5090103@ru.mvista.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.91.1/3846/Wed Aug  1 09:27:07 2007 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15997
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, 1 Aug 2007, Sergei Shtylyov wrote:

> > And regarding what you have written above and the size issue you mentioned
> > in another e-mail (do you map the whole PCI config space linearly in the
> > physical address space of the CPU or suchlike?) -- PCI 
> 
>    No, I don't.  But that was why the original code preferred the wired entry
> approach over ioremap() -- not to map a whole range...

 So what is the issue with the size then?  How big is the area?

> > config space accesses are rare (by design rather than chance), so 
> 
>    That depends on the drivers used (some IDE drivers access it really often).

 It is their problem I would say -- there is a design problem either in 
these drivers or the hardware handled.  The PCI spec is very explicit that 
the config space is meant to be seldom accessed only.  Device 
initialization/shutdown and bus error recovery are the normal places.

> > performance is a non-issue and it should be absolutely fine for you to call
> > ioremap() and iounmap() in code specific for your PCI host bridge for the
> > required fragment upon every access.  There is no need for a permanent 
> 
>    That's an idea -- however, as the currecnt code uses a cached mapping, this
> part would certainly need to be saved in the new implementaion -- if someone
> will go and fix it eventually. :-)

 Well, cached mapping does not seem particularly wise with PCI 
configuration registers, but you have got the ioremap_cachable() call if 
you insist. ;-)

> > Well, more about Linux perhaps than MIPS in general. :-)
> 
>    Let's say that was about Linux/MIPS.  But the key word was "wasting". ;-)

 I reckon the key is how you look at it. ;-)

  Maciej

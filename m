Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 26 Nov 2007 11:35:53 +0000 (GMT)
Received: from cerber.ds.pg.gda.pl ([153.19.208.18]:37348 "EHLO
	cerber.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20038904AbXKZLfn (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 26 Nov 2007 11:35:43 +0000
Received: from localhost (unknown [127.0.0.17])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id 5BE2B40003;
	Mon, 26 Nov 2007 12:35:13 +0100 (CET)
X-Virus-Scanned: amavisd-new at cerber.ds.pg.gda.pl
Received: from cerber.ds.pg.gda.pl ([153.19.208.18])
	by localhost (cerber.ds.pg.gda.pl [153.19.208.18]) (amavisd-new, port 10024)
	with ESMTP id tVArfQIO7xjT; Mon, 26 Nov 2007 12:34:55 +0100 (CET)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id 6B3A3400AB;
	Mon, 26 Nov 2007 12:34:55 +0100 (CET)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.8) with ESMTP id lAQBYv9s024818;
	Mon, 26 Nov 2007 12:34:57 +0100
Date:	Mon, 26 Nov 2007 11:34:50 +0000 (GMT)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Martin Michlmayr <tbm@cyrius.com>
cc:	linux-mips@linux-mips.org, manoj.ekbote@broadcom.com,
	mark.e.mason@broadcom.com
Subject: Re: BigSur: garbled characters during boot
In-Reply-To: <20071125134333.GO20922@deprecation.cyrius.com>
Message-ID: <Pine.LNX.4.64N.0711261127190.20797@blysk.ds.pg.gda.pl>
References: <20071125124842.GA32479@deprecation.cyrius.com>
 <20071125.222803.25909189.anemo@mba.ocn.ne.jp> <20071125134333.GO20922@deprecation.cyrius.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.91.2/4923/Mon Nov 26 11:46:15 2007 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17586
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, 25 Nov 2007, Martin Michlmayr wrote:

> > IIRC Maciej have tried to fix this issue a while ago on LKML.
> 
> Right, I think I remember that discussion.  Did anything come out
> of it?

 The exact mess encountered is specific to the chip/board used.  I haven't 
seen too much of clutter on my SWARM, so I just disregarded the issue.  
If this is found problematic, I may have a look at the driver to see if 
anything can be done.  At least CFE sources are available, so if it turns 
out to be an issue there, it can be fixed too.  All the relevant registers 
in the DUART are r/w, so the state can easily be examined and preserved if 
need be.

 But please feel free to complain to the author of the change -- I am not 
sure if the amount of breakage throughout systems is justified by the gain 
from the additional message.  And there may be a way to implement it in a 
less intrusive way.

  Maciej

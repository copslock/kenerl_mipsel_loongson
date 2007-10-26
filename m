Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 26 Oct 2007 10:31:47 +0100 (BST)
Received: from cerber.ds.pg.gda.pl ([153.19.208.18]:47233 "EHLO
	cerber.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20024884AbXJZJbj (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 26 Oct 2007 10:31:39 +0100
Received: from localhost (unknown [127.0.0.17])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id A6ADB400DE;
	Fri, 26 Oct 2007 11:31:08 +0200 (CEST)
X-Virus-Scanned: amavisd-new at cerber.ds.pg.gda.pl
Received: from cerber.ds.pg.gda.pl ([153.19.208.18])
	by localhost (cerber.ds.pg.gda.pl [153.19.208.18]) (amavisd-new, port 10024)
	with ESMTP id SxK-D3id0xlx; Fri, 26 Oct 2007 11:31:02 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id D0B774007F;
	Fri, 26 Oct 2007 11:31:02 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.8) with ESMTP id l9Q9V5CW009473;
	Fri, 26 Oct 2007 11:31:05 +0200
Date:	Fri, 26 Oct 2007 10:31:03 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Thiemo Seufer <ths@networkno.de>
cc:	linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH] Use a sensible tlbex default for unknown CPUs
In-Reply-To: <20071025205654.GF3994@networkno.de>
Message-ID: <Pine.LNX.4.64N.0710261019290.26339@blysk.ds.pg.gda.pl>
References: <20071025155912.GD3994@networkno.de>
 <Pine.LNX.4.64N.0710251707170.24086@blysk.ds.pg.gda.pl> <20071025205654.GF3994@networkno.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.91.2/4596/Fri Oct 26 01:37:29 2007 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17240
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, 25 Oct 2007, Thiemo Seufer wrote:

> This is circular, as isa_level won't be initialized for a unknown CPU.
> The *_r2 check suggested by Ralf has the same problem AFAICS, so it
> looks like we have to stick with the original solution.

 Hmm, it looks like we have a misfeature in the probing code.  I think it 
would be reasonable to perform full discovery of features for all MIPS 
Architecture processors, even if the Company or Processor ID as reported 
by the PRId register is not a recognised one.  This is because for these 
processors we have all the necessary information about the privileged 
resource architecture implemented reported through the cp0 Config 
registers, including the type of the TLB and the topology of caches.  
With the revision 2 of the architecture, we also have the "ehb" and 
"jr.hb" instructions available to take care of cp0 hazards in a generic 
way.  So in a sense, we should be able to handle these processors 
correctly without the knowledge of what has been printed on their cases.

 Ralf's proposal is essentially the same code, except expressed a little 
bit differently, so no surprise it suffers from the same problem.

  Maciej

Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 16 Feb 2006 10:11:21 +0000 (GMT)
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:16400 "EHLO
	pollux.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S8133375AbWBPKLL (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 16 Feb 2006 10:11:11 +0000
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 2A8C4F5BD2;
	Thu, 16 Feb 2006 11:17:39 +0100 (CET)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux.ds.pg.gda.pl [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 05396-04; Thu, 16 Feb 2006 11:17:38 +0100 (CET)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id BEC86F59D6;
	Thu, 16 Feb 2006 11:17:38 +0100 (CET)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.3/8.13.1) with ESMTP id k1GAHaJq020859;
	Thu, 16 Feb 2006 11:17:37 +0100
Date:	Thu, 16 Feb 2006 10:17:38 +0000 (GMT)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Ralf Baechle <ralf@linux-mips.org>
cc:	Martin Michlmayr <tbm@cyrius.com>, linux-mips@linux-mips.org
Subject: Re: Please pull drivers/scsi/dec_esp.c from Linus' git
In-Reply-To: <20060215150839.GA27719@linux-mips.org>
Message-ID: <Pine.LNX.4.64N.0602161016260.7169@blysk.ds.pg.gda.pl>
References: <20060213225331.GA5315@deprecation.cyrius.com>
 <20060215150839.GA27719@linux-mips.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV version 0.88, clamav-milter version 0.87 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10470
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, 15 Feb 2006, Ralf Baechle wrote:

> > @@ -230,7 +230,7 @@
> >  			mem_start = get_tc_base_addr(slot);
> >  
> >  			/* Store base addr into esp struct */
> > -			esp->slot = mem_start;
> > +			esp->slot = CPHYSADDR(mem_start);
> >  
> >  			esp->dregs = 0;
> >  			esp->eregs = (void *)CKSEG1ADDR(mem_start +
> 
> I merged allmost all of the differences from mainline except this one.
> 
> Maciej, does this need the CPHYSADDR() op or not here?

 Of course not as get_tc_base_addr() returns a physical address these 
days.  Thanks for spotting this bit.

  Maciej

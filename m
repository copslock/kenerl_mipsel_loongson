Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 16 Feb 2006 15:42:29 +0000 (GMT)
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:9229 "EHLO
	pollux.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S8133413AbWBPPmU (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 16 Feb 2006 15:42:20 +0000
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 6AC5DF5BCD;
	Thu, 16 Feb 2006 16:48:48 +0100 (CET)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux.ds.pg.gda.pl [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 00755-03; Thu, 16 Feb 2006 16:48:48 +0100 (CET)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 264A5F59E3;
	Thu, 16 Feb 2006 16:48:48 +0100 (CET)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.3/8.13.1) with ESMTP id k1GFmlgo008987;
	Thu, 16 Feb 2006 16:48:47 +0100
Date:	Thu, 16 Feb 2006 15:48:52 +0000 (GMT)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Ralf Baechle <ralf@linux-mips.org>
cc:	Martin Michlmayr <tbm@cyrius.com>, linux-mips@linux-mips.org
Subject: Re: Please pull drivers/scsi/dec_esp.c from Linus' git
In-Reply-To: <20060216145931.GA1633@linux-mips.org>
Message-ID: <Pine.LNX.4.64N.0602161504230.7169@blysk.ds.pg.gda.pl>
References: <20060213225331.GA5315@deprecation.cyrius.com>
 <20060215150839.GA27719@linux-mips.org> <Pine.LNX.4.64N.0602161016260.7169@blysk.ds.pg.gda.pl>
 <20060216145931.GA1633@linux-mips.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.88/1290/Thu Feb 16 10:14:53 2006 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10476
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, 16 Feb 2006, Ralf Baechle wrote:

> That still leaves below gem to sort out.

 Yeah -- there is that mmiowb() macro that is supposed to fit here, but 
some MIPS-based hardware is ordered weakly (and strangely) enough for this 
single macro to be a bit insufficient.  I think we should have at least 
mmiowb() and mmiob() (corresponding to wmb() and mb(), respectively) as 
there is a system we support that does writes in order, but snoops the 
writeback buffer (the R3220).  Another one is worse yet as does all of 
that plus byte gathering (the R2020).  At least the latter cannot have the 
NCR/Emulex SCSI chip and uses DEC's own design instead (a DC7061 gate 
array highly suspected to also support DSSI if appropriately configured).

 I'm not sure if we really need mmiorb() -- probably not.

  Maciej

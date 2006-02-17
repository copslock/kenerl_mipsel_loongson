Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Feb 2006 12:44:54 +0000 (GMT)
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:33550 "EHLO
	pollux.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S8133636AbWBQMop (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 17 Feb 2006 12:44:45 +0000
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id BBE43F5C14;
	Fri, 17 Feb 2006 13:51:14 +0100 (CET)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux.ds.pg.gda.pl [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 00783-05; Fri, 17 Feb 2006 13:51:14 +0100 (CET)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 55AFDF5C0F;
	Fri, 17 Feb 2006 13:51:14 +0100 (CET)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.3/8.13.1) with ESMTP id k1HCpIRX014997;
	Fri, 17 Feb 2006 13:51:18 +0100
Date:	Fri, 17 Feb 2006 12:51:21 +0000 (GMT)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Jes Sorensen <jes@sgi.com>
cc:	Ralf Baechle <ralf@linux-mips.org>,
	Martin Michlmayr <tbm@cyrius.com>, linux-mips@linux-mips.org
Subject: Re: Please pull drivers/scsi/dec_esp.c from Linus' git
In-Reply-To: <43F5C300.10108@sgi.com>
Message-ID: <Pine.LNX.4.64N.0602171245580.7169@blysk.ds.pg.gda.pl>
References: <20060213225331.GA5315@deprecation.cyrius.com>
 <20060215150839.GA27719@linux-mips.org> <Pine.LNX.4.64N.0602161016260.7169@blysk.ds.pg.gda.pl>
 <20060216145931.GA1633@linux-mips.org> <Pine.LNX.4.64N.0602161504230.7169@blysk.ds.pg.gda.pl>
 <yq0pslmxsb7.fsf@jaguar.mkp.net> <Pine.LNX.4.64N.0602171039320.7169@blysk.ds.pg.gda.pl>
 <43F5C300.10108@sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.88/1292/Fri Feb 17 10:39:02 2006 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10486
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, 17 Feb 2006, Jes Sorensen wrote:

> > It's just horribly slow and an overkill if it's only ordering of consecutive
> > writes rather than ordering of a read after a write that has to be
> > guaranteed.  But perhaps we could keep abusing wmb() for the former...
> 
> Depends on where it's happening. If it's the CPU doing it before it hits
> the bus then wmb() would probably be ok.

 These systems only allow the CPU to access devices other than RAM.  But 
consistency between platforms is important as the same drivers may be used 
for systems that have different access rules.  Examples are currently the 
defxx and the tgafb drivers.  They should work correctly with the R3220 
writeback buffer as well as with PCI.

  Maciej

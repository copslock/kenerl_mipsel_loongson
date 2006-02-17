Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Feb 2006 10:44:29 +0000 (GMT)
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:15889 "EHLO
	pollux.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S8133627AbWBQKoT (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 17 Feb 2006 10:44:19 +0000
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 85CCBF5C07;
	Fri, 17 Feb 2006 11:44:57 +0100 (CET)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux.ds.pg.gda.pl [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 01113-08; Fri, 17 Feb 2006 11:44:57 +0100 (CET)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 90C18F5C02;
	Fri, 17 Feb 2006 11:44:56 +0100 (CET)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.3/8.13.1) with ESMTP id k1HAj0As023820;
	Fri, 17 Feb 2006 11:45:01 +0100
Date:	Fri, 17 Feb 2006 10:45:02 +0000 (GMT)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Jes Sorensen <jes@sgi.com>
cc:	Ralf Baechle <ralf@linux-mips.org>,
	Martin Michlmayr <tbm@cyrius.com>, linux-mips@linux-mips.org
Subject: Re: Please pull drivers/scsi/dec_esp.c from Linus' git
In-Reply-To: <yq0pslmxsb7.fsf@jaguar.mkp.net>
Message-ID: <Pine.LNX.4.64N.0602171039320.7169@blysk.ds.pg.gda.pl>
References: <20060213225331.GA5315@deprecation.cyrius.com>
 <20060215150839.GA27719@linux-mips.org> <Pine.LNX.4.64N.0602161016260.7169@blysk.ds.pg.gda.pl>
 <20060216145931.GA1633@linux-mips.org> <Pine.LNX.4.64N.0602161504230.7169@blysk.ds.pg.gda.pl>
 <yq0pslmxsb7.fsf@jaguar.mkp.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.88/1291/Thu Feb 16 21:15:09 2006 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10483
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, 17 Feb 2006, Jes Sorensen wrote:

> Just make mmiowb() strong enough on those platforms. There's really no
> reason to introduce yet another variation at this point.

 It's just horribly slow and an overkill if it's only ordering of 
consecutive writes rather than ordering of a read after a write that has 
to be guaranteed.  But perhaps we could keep abusing wmb() for the 
former...

  Maciej

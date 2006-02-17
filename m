Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Feb 2006 15:10:33 +0000 (GMT)
Received: from jaguar.mkp.net ([192.139.46.146]:2278 "EHLO jaguar.mkp.net")
	by ftp.linux-mips.org with ESMTP id S8133657AbWBQPKX (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 17 Feb 2006 15:10:23 +0000
Received: by jaguar.mkp.net (Postfix, from userid 1655)
	id AA956286D89; Fri, 17 Feb 2006 10:17:00 -0500 (EST)
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	Ralf Baechle <ralf@linux-mips.org>,
	Martin Michlmayr <tbm@cyrius.com>, linux-mips@linux-mips.org
Subject: Re: Please pull drivers/scsi/dec_esp.c from Linus' git
References: <20060213225331.GA5315@deprecation.cyrius.com>
	<20060215150839.GA27719@linux-mips.org>
	<Pine.LNX.4.64N.0602161016260.7169@blysk.ds.pg.gda.pl>
	<20060216145931.GA1633@linux-mips.org>
	<Pine.LNX.4.64N.0602161504230.7169@blysk.ds.pg.gda.pl>
	<yq0pslmxsb7.fsf@jaguar.mkp.net>
	<Pine.LNX.4.64N.0602171039320.7169@blysk.ds.pg.gda.pl>
	<43F5C300.10108@sgi.com>
	<Pine.LNX.4.64N.0602171245580.7169@blysk.ds.pg.gda.pl>
From:	Jes Sorensen <jes@sgi.com>
Date:	17 Feb 2006 10:17:00 -0500
In-Reply-To: <Pine.LNX.4.64N.0602171245580.7169@blysk.ds.pg.gda.pl>
Message-ID: <yq0d5hmxbf7.fsf@jaguar.mkp.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <jes@trained-monkey.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10490
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jes@sgi.com
Precedence: bulk
X-list: linux-mips

>>>>> "Maciej" == Maciej W Rozycki <macro@linux-mips.org> writes:

Maciej>  These systems only allow the CPU to access devices other than
Maciej> RAM.  But consistency between platforms is important as the
Maciej> same drivers may be used for systems that have different
Maciej> access rules.  Examples are currently the defxx and the tgafb
Maciej> drivers.  They should work correctly with the R3220 writeback
Maciej> buffer as well as with PCI.

So just change the implementation of mmiowb depending on whether it's
on an R3220 or a PCI system.

Cheers,
Jes

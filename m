Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Feb 2006 09:05:49 +0000 (GMT)
Received: from jaguar.mkp.net ([192.139.46.146]:62946 "EHLO jaguar.mkp.net")
	by ftp.linux-mips.org with ESMTP id S8133370AbWBQJFh (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 17 Feb 2006 09:05:37 +0000
Received: by jaguar.mkp.net (Postfix, from userid 1655)
	id D464B286DAD; Fri, 17 Feb 2006 04:12:12 -0500 (EST)
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	Ralf Baechle <ralf@linux-mips.org>,
	Martin Michlmayr <tbm@cyrius.com>, linux-mips@linux-mips.org
Subject: Re: Please pull drivers/scsi/dec_esp.c from Linus' git
References: <20060213225331.GA5315@deprecation.cyrius.com>
	<20060215150839.GA27719@linux-mips.org>
	<Pine.LNX.4.64N.0602161016260.7169@blysk.ds.pg.gda.pl>
	<20060216145931.GA1633@linux-mips.org>
	<Pine.LNX.4.64N.0602161504230.7169@blysk.ds.pg.gda.pl>
From:	Jes Sorensen <jes@sgi.com>
Date:	17 Feb 2006 04:12:12 -0500
In-Reply-To: <Pine.LNX.4.64N.0602161504230.7169@blysk.ds.pg.gda.pl>
Message-ID: <yq0pslmxsb7.fsf@jaguar.mkp.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <jes@trained-monkey.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10482
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jes@sgi.com
Precedence: bulk
X-list: linux-mips

>>>>> "Maciej" == Maciej W Rozycki <macro@linux-mips.org> writes:

Maciej> On Thu, 16 Feb 2006, Ralf Baechle wrote:
>> That still leaves below gem to sort out.

Maciej>  Yeah -- there is that mmiowb() macro that is supposed to fit
Maciej> here, but some MIPS-based hardware is ordered weakly (and
Maciej> strangely) enough for this single macro to be a bit
Maciej> insufficient.  I think we should have at least mmiowb() and
Maciej> mmiob() (corresponding to wmb() and mb(), respectively) as
Maciej> there is a system we support that does writes in order, but
Maciej> snoops the writeback buffer (the R3220).  Another one is worse
Maciej> yet as does all of that plus byte gathering (the R2020).  At
Maciej> least the latter cannot have the NCR/Emulex SCSI chip and uses
Maciej> DEC's own design instead (a DC7061 gate array highly suspected
Maciej> to also support DSSI if appropriately configured).

Maciej>  I'm not sure if we really need mmiorb() -- probably not.

Just make mmiowb() strong enough on those platforms. There's really no
reason to introduce yet another variation at this point.

Jes

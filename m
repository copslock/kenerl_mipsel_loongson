Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Apr 2003 15:52:02 +0100 (BST)
Received: from cm19173.red.mundo-r.com ([IPv6:::ffff:213.60.19.173]:54389 "EHLO
	trasno.mitica") by linux-mips.org with ESMTP id <S8225197AbTDCOwA>;
	Thu, 3 Apr 2003 15:52:00 +0100
Received: by trasno.mitica (Postfix, from userid 1001)
	id 09F65724; Thu,  3 Apr 2003 16:51:54 +0200 (CEST)
To: Ralf Baechle <ralf@linux-mips.org>
Cc: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
	linux-mips@linux-mips.org
Subject: Re: CVS Update@-mips.org: linux
X-Url: http://people.mandrakesoft.com/~quintela
From: Juan Quintela <quintela@mandrakesoft.com>
In-Reply-To: <20030403162428.A2460@linux-mips.org> (Ralf Baechle's message
 of "Thu, 3 Apr 2003 16:24:29 +0200")
References: <20030403133610Z8225197-1272+1139@linux-mips.org>
	<Pine.GSO.3.96.1030403154337.19058E-100000@delta.ds2.pg.gda.pl>
	<20030403162428.A2460@linux-mips.org>
Date: Thu, 03 Apr 2003 16:51:53 +0200
Message-ID: <86of3nk512.fsf@trasno.mitica>
User-Agent: Gnus/5.090015 (Oort Gnus v0.15) Emacs/21.2.93
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <quintela@mandrakesoft.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1911
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: quintela@mandrakesoft.com
Precedence: bulk
X-list: linux-mips

>>>>> "ralf" == Ralf Baechle <ralf@linux-mips.org> writes:

ralf> On Thu, Apr 03, 2003 at 04:11:02PM +0200, Maciej W. Rozycki wrote:
>> Hmm, erratum #2 is about status output pins.  I suppose you mean erratum
>> #5.  But then it applies to V3.0, too.
>> 
>> Then the bit is r/w, so how about toggling it instead of panicking? 
>> With an informational message like:
>> 
>> printk(KERN_ERR "Firmware bug: 32-byte I-cache line size unsupported for
>> the R4000...\n");
>> printk(KERN_ERR "... fixing up to 16-byte size.\n");
>> 
>> Of course that probably requires a temporary cache inhibition and
>> invalidation.

ralf> I know of one machine where changing the size of the cacheline is supposed
ralf> not to work, that's the MIPS Magnum 4000 and it's close relatives.

ralf> Anyway, I put the check there for the unlikely case there are broken
ralf> systems out there.  In practice I assume vendors were aware of this
ralf> problem and the check is purely theoretical and for paranoid correctness's
ralf> sake.

ralf> It seems like changing the configuration to larger cache lines where
ralf> possible should improve performance somewhat.  If all the cache code is
ralf> working truly correct we also should no longer see VCE exceptions on
ralf> R4000SC processors - the reason why Indys are still a valuable test tool.

I still got lot of them :(

VCED exceptions         : 1544376
VCEI exceptions         : 92380

That machine was booted yesterday night.  I haven't login on it,
i.e. only normal daemons for a nfsrooted machine running.

Later, Juan.

-- 
In theory, practice and theory are the same, but in practice they 
are different -- Larry McVoy

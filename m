Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 Mar 2003 19:00:05 +0000 (GMT)
Received: from p508B652B.dip.t-dialin.net ([IPv6:::ffff:80.139.101.43]:2278
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8224827AbTC1TAE>; Fri, 28 Mar 2003 19:00:04 +0000
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id h2SIxrB19202;
	Fri, 28 Mar 2003 19:59:53 +0100
Date: Fri, 28 Mar 2003 19:59:53 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Juan Quintela <quintela@mandrakesoft.com>,
	mipslist <linux-mips@linux-mips.org>
Subject: Re: [PATCH]: c-r4k.c 4/7 flush_cache_mm cleanup
Message-ID: <20030328195953.A17890@linux-mips.org>
References: <m2smt89ut8.fsf@neno.mitica> <Pine.GSO.3.96.1030328175039.26178B-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.GSO.3.96.1030328175039.26178B-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Fri, Mar 28, 2003 at 06:51:57PM +0100
Return-Path: <ralf@linux-mips.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1850
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Mar 28, 2003 at 06:51:57PM +0100, Maciej W. Rozycki wrote:

> > 	flush_cache_mm can use __flush_cache_all.
> 
>  Wrong, it should use r4k_flush_pcache_all() unconditionally, but I'm told
> such a setup triggers a bug somewhere, that needs to be tracked down
> before committing that change to the CVS.

Now that the problem is mentioned on the list lemme elaborate a bit.  The
problem mentioned only affects R4000SC and R4400SC processors.
Flush_cache_mm is only used when a mm is either copied on fork or when
it's finally destroyed.  Because the S-cache is is physically indexed
and the P-cache is refilled from the S-cache if data should be still in
there we don't need to flush the S-cache ever for any of the mm's
cacheflushing functions.  So the observation that things are only
working properly if we do flush the S-cache also suggest we're either
having a bug elsewhere in the cache code or we're hitting a hardware
problem.

  Ralf

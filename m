Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Jun 2009 19:50:36 +0100 (WEST)
Received: from waste.org ([66.93.16.53]:48051 "EHLO waste.org"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S20021952AbZFCSu2 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 3 Jun 2009 19:50:28 +0100
Received: from [192.168.1.100] ([10.0.0.101])
	(authenticated bits=0)
	by waste.org (8.13.8/8.13.8/Debian-3) with ESMTP id n53Inq36016400
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 3 Jun 2009 13:49:54 -0500
Subject: Re: [PATCH] hwrng: Add TX4939 RNG driver (v2)
From:	Matt Mackall <mpm@selenic.com>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Herbert Xu <herbert@gondor.apana.org.au>,
	Atsushi Nemoto <anemo@mba.ocn.ne.jp>,
	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
In-Reply-To: <20090603100215.GA13250@linux-mips.org>
References: <1243954462-18149-1-git-send-email-anemo@mba.ocn.ne.jp>
	 <1243973584.22069.182.camel@calx> <20090603090238.GH23561@linux-mips.org>
	 <20090603092610.GA11258@gondor.apana.org.au>
	 <20090603092927.GA11369@gondor.apana.org.au>
	 <20090603100215.GA13250@linux-mips.org>
Content-Type: text/plain
Date:	Wed, 03 Jun 2009 13:49:46 -0500
Message-Id: <1244054986.22069.200.camel@calx>
Mime-Version: 1.0
X-Mailer: Evolution 2.26.1.1 
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: by amavisd-new
Return-Path: <mpm@selenic.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23233
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mpm@selenic.com
Precedence: bulk
X-list: linux-mips

On Wed, 2009-06-03 at 11:02 +0100, Ralf Baechle wrote:
> On Wed, Jun 03, 2009 at 07:29:27PM +1000, Herbert Xu wrote:
> 
> > On Wed, Jun 03, 2009 at 07:26:10PM +1000, Herbert Xu wrote:
> > > On Wed, Jun 03, 2009 at 10:02:38AM +0100, Ralf Baechle wrote:
> > >
> > > > Ok, I'll send this to Linus for 2.6.31 then.
> > > 
> > > Actually I've already added it to my tree since I'm looking after
> > > the hwrng drivers.
> >
> > But if this causes any conflicts for you, then please let me know
> > and I'll back it out.
> 
> Ah, I was looking at MAINTAINERS which said Mack who had acked it was
> handling it.

I'm the maintainer of record for random.c, which is different. Not long
ago, I sent in a patch to add myself to the HWRNG piece because people
were regularly sending me things to review and it was marked as orphan. 

So, Herbert: we should probably resolve this confusion in MAINTAINERS.
We should add one or both of our names to HWRNG and, if necessary, add a
comment to RANDOM pointing to HWRNG. I have an eventual goal to make
random.c sample the hwrngs without a trip through userspace, so this may
get even more confusing.

-- 
http://selenic.com : development and support for Mercurial and Linux

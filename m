Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6MAZBRw018988
	for <linux-mips-outgoing@oss.sgi.com>; Mon, 22 Jul 2002 03:35:11 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6MAZBMm018987
	for linux-mips-outgoing; Mon, 22 Jul 2002 03:35:11 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from hell (buserror-extern.convergence.de [212.84.236.66])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6MAZ4Rw018966
	for <linux-mips@oss.sgi.com>; Mon, 22 Jul 2002 03:35:05 -0700
Received: from js by hell with local (Exim 3.35 #1 (Debian))
	id 17WaXP-0004Kp-00; Mon, 22 Jul 2002 12:35:35 +0200
Date: Mon, 22 Jul 2002 12:35:35 +0200
From: Johannes Stezenbach <js@convergence.de>
To: Richard Hodges <rh@matriplex.com>
Cc: "Kevin D. Kissell" <kevink@mips.com>, linux-mips@oss.sgi.com
Subject: Re: LL/SC benchmarking [was: Mipsel libc with LL/SC online anywhere?]
Message-ID: <20020722103534.GA16198@convergence.de>
Mail-Followup-To: Johannes Stezenbach <js@convergence.de>,
	Richard Hodges <rh@matriplex.com>,
	"Kevin D. Kissell" <kevink@mips.com>, linux-mips@oss.sgi.com
References: <20020719123828.GA5521@convergence.de> <Pine.BSF.4.10.10207190846180.1937-100000@mail.matriplex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.BSF.4.10.10207190846180.1937-100000@mail.matriplex.com>
User-Agent: Mutt/1.4i
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, Jul 19, 2002 at 08:54:46AM -0700, Richard Hodges wrote:
> On Fri, 19 Jul 2002, Johannes Stezenbach wrote:
> 
> > I think the beql-hack needs a kernel patch to guarantee k1 !=
> > MAGIC_COOKIE after each eret, but for a those few tests I was just
> > taking my chance.
> 
> Maybe something like this in front of every "eret" instruction?
> 
> #ifdef CONFIG_CPU_VR41XX
> 	move	$27,$0
> #endif

The Sony patch for CPUs without LL/SC and without branch-likely
(posted here on Tue 22 Jan 2002 15:27:44 +0900 by
Machida Hiroyuki <machida@sm.sony.co.jp>) requires to load
a certain magic cookie into k1 before every eret/rfe.

OTOH, Kevin D. Kissel speculates that for the branch-likely
trick it might be possible to find a magic value that already can
never end up in k1 after an eret, as side effect of the
current implementation. So we wouldn't have to patch the
kernel at all.

I for one would be content if I could find a magic cookie value
that lets me avoid adding instructions to the TLB refill handler.


Johannes

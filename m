Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g14KKNv10302
	for linux-mips-outgoing; Mon, 4 Feb 2002 12:20:23 -0800
Received: from cygnus.equallogic.com (cygnus.equallogic.com [65.170.102.10])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g14KKHA10161
	for <linux-mips@oss.sgi.com>; Mon, 4 Feb 2002 12:20:17 -0800
Received: from deneb.dev.equallogic.com (deneb.dev.equallogic.com [172.16.1.99])
	by cygnus.equallogic.com (8.11.6/8.11.6) with ESMTP id g14JHC606535;
	Mon, 4 Feb 2002 14:17:12 -0500
Received: from pkoning.dev.equallogic.com.equallogic.com (localhost.localdomain [127.0.0.1])
	by deneb.dev.equallogic.com (8.11.6/8.11.2) with SMTP id g14JH8704342;
	Mon, 4 Feb 2002 14:17:08 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15454.56884.108220.380799@pkoning.dev.equallogic.com>
Date: Mon, 4 Feb 2002 14:17:08 -0500 (EST)
From: Paul Koning <pkoning@equallogic.com>
To: justinca@ri.cmu.edu
Cc: hjl@lucon.org, dan@debian.org, macro@ds2.pg.gda.pl, machida@sm.sony.co.jp,
   libc-alpha@sources.redhat.com, linux-mips@oss.sgi.com, gcc@gcc.gnu.org
Subject: Re: PATCH: Fix ll/sc for mips (take 3)
References: <20020131231714.E32690@lucon.org>
	<Pine.GSO.3.96.1020201124328.26449A-100000@delta.ds2.pg.gda.pl>
	<20020201102943.A11146@lucon.org>
	<20020201180126.A23740@nevyn.them.org>
	<20020201151513.A15913@lucon.org>
	<20020201222657.A13339@nevyn.them.org>
	<1012676003.1563.6.camel@xyzzy.stargate.net>
	<20020202120354.A1522@lucon.org>
	<1012715250.2297.9.camel@xyzzy.stargate.net>
X-Mailer: VM 6.75 under 21.1 (patch 11) "Carlsbad Caverns" XEmacs Lucid
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

>>>>> "Justin" == Justin Carlson <justinca@ri.cmu.edu> writes:

 Justin> On Sat, 2002-02-02 at 15:03, H . J . Lu wrote:
 >> Does everyone agree with this? If yes, I can make a patch not to
 >> use branch likely. But on the other hand, "gcc -mips2" will
 >> generate code using branch likely. If branch likely doesn't buy
 >> you anything, shouldn't we change gcc not to generate branch
 >> likely instructions?
 >> 

 Justin> I know of at least one internal version of gcc which already
 Justin> has been hacked to remove generation of branch likely
 Justin> instructions. 

More precisely (if you're looking at the same one I was) -- it has a
target processor type check that disables it for those CPUs where it
is known to be not a good idea.

 Justin> Also, I didn't say branch likely doesn't buy you anything;
 Justin> there are situations where it works well.  Looking at the
 Justin> spin_lock code, though, this isn't one of them.  

I agree, and I think that point was missed.  Independent of whether a
particular processor (MIPS or otherwise) has the concept of "branch
likely", the design rule of spinlocks is that you try to avoid
spinning (i.e., avoid lock contention) in the system design.  So for
that particular construct, the right answer is "branch not likely".

     paul

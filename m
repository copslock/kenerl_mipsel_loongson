Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6NIUNRw012524
	for <linux-mips-outgoing@oss.sgi.com>; Tue, 23 Jul 2002 11:30:23 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6NIUN0Y012523
	for linux-mips-outgoing; Tue, 23 Jul 2002 11:30:23 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from av.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6NIU5Rw012504;
	Tue, 23 Jul 2002 11:30:06 -0700
Received: from mvista.com (av [127.0.0.1])
	by av.mvista.com (8.9.3/8.9.3) with ESMTP id LAA20170;
	Tue, 23 Jul 2002 11:28:38 -0700
Message-ID: <3D3D9E5D.8080309@mvista.com>
Date: Tue, 23 Jul 2002 11:20:13 -0700
From: Jun Sun <jsun@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020408
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
CC: Ralf Baechle <ralf@oss.sgi.com>, linux-mips@fnet.fr,
   linux-mips@oss.sgi.com
Subject: Re: [patch] linux: cpu_probe(): remove 32-bit CPU bits for MIPS64
References: <Pine.GSO.3.96.1020723144023.26569B-100000@delta.ds2.pg.gda.pl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, hits=0.0 required=5.0 tests= version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Maciej W. Rozycki wrote:
> On Tue, 23 Jul 2002, Ralf Baechle wrote:
> 
> 
>>I intentionally have that 32-bit stuff in the 64-bit kernel so we can simply
>>have share identical CPU probing code between the 32-bit and 64-bit kernels.
>>This in anticipation of a further unification of the two ports which still
>>duplicate plenty of code with just minor changes.
> 
> 
>  I suspected a maintability reason.  Thus as a temporary fix I'm checking
> in a version that provides the missing cpu_has_fpu() function (a copy
> from the trunk).
> 
> 
>>To make sharing easier I suggest to move all the CPU probing code into it's
>>own file, probe.c or so?
> 
> 
>  That might be a good idea in principle, but it won't solve the problem
> anyway.  I'd like to see the code for 32-bit processors get annihilated by
> the compiler if built for mips64.  I'll look at it soon.  The MIPS32/64
> crap needs to be fixed here as well.
> 

FWIW, I like to see CPU probing and setup done in a distributed, configurable 
fashion.  Here are some of my ideas which have been floating around for a while.

. There is a global table, where each entry in the table have (at least) four 
fields:
	uint company_id
	uint processor_id
	uint revision_id
	void (*setup_cpu)(void);

. cpu_probe() simply reads prid register and search through the table.  If it 
finds matching one, then issue the (setup_cpu) call.

. matching allows wildcard matching.  Apparently more specific entry should be 
checked before more generic entries.

. cpu cache routines and tlb routines are organized accordingly, so that 
static configurations can be done sensibly.

This structure allows maximum code sharing for conforming CPUs and also give 
an easy for unique ones or buggy, early-production ones.  It should also make 
it easy to add or remove support for particular CPU or CPU family.  Of course, 
more details need to be fleshed out.


Jun

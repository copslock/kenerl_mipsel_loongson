Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g4TNQinC004368
	for <linux-mips-outgoing@oss.sgi.com>; Wed, 29 May 2002 16:26:44 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g4TNQiAL004367
	for linux-mips-outgoing; Wed, 29 May 2002 16:26:44 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from av.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g4TNQbnC004364;
	Wed, 29 May 2002 16:26:38 -0700
Received: from mvista.com (av [127.0.0.1])
	by av.mvista.com (8.9.3/8.9.3) with ESMTP id QAA10269;
	Wed, 29 May 2002 16:26:23 -0700
Message-ID: <3CF56335.3010404@mvista.com>
Date: Wed, 29 May 2002 16:24:37 -0700
From: Jun Sun <jsun@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.2.1) Gecko/20010901
X-Accept-Language: en-us
MIME-Version: 1.0
To: Justin Carlson <justinca@cs.cmu.edu>
CC: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>, linux-mips@oss.sgi.com,
   ralf@oss.sgi.com
Subject: Re: __flush_cache_all() miscellany
References: <Pine.GSO.3.96.1020529222325.17584N-100000@delta.ds2.pg.gda.pl> <1022713145.7644.363.camel@ldt-sj3-022.sj.broadcom.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Justin Carlson wrote:

 
> I'm still looking for a reason for the existence of __flush_cache_all().
> 


It is needed by kgdb where gdb client may modify several instructions before a 
'c' command is issued.  In that case, you cannot use flush_icache_range 
because you don't know the range.  It is probably not safe either as the data 
cache may not be written back yet

Does flush_icache_range() mandates write-back of dcache in the same range?  If 
it does, you might be able to get away with flush_icache_range(ICACHE_BEGIN, 
ICACHE_END).

Like someone else has pointed out, __flush_cache_all() is introduced to ensure 
i-cache/d-cache consistency.  I remember it was shortly introduced after we 
had the first cache-coherent system where flush_cache_all() is a null function.

Jun

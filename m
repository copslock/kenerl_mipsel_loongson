Received: from oss.sgi.com (localhost.localdomain [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g39HaQ8d027815
	for <linux-mips-outgoing@oss.sgi.com>; Tue, 9 Apr 2002 10:36:26 -0700
Received: (from mail@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g39HaQBi027814
	for linux-mips-outgoing; Tue, 9 Apr 2002 10:36:26 -0700
X-Authentication-Warning: oss.sgi.com: mail set sender to owner-linux-mips@oss.sgi.com using -f
Received: from av.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g39HaN8d027810
	for <linux-mips@oss.sgi.com>; Tue, 9 Apr 2002 10:36:23 -0700
Received: from mvista.com (av [127.0.0.1])
	by av.mvista.com (8.9.3/8.9.3) with ESMTP id SAA20052;
	Tue, 9 Apr 2002 18:46:25 -0700
Message-ID: <3CB32694.1010503@mvista.com>
Date: Tue, 09 Apr 2002 10:36:20 -0700
From: Jun Sun <jsun@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20011126 Netscape6/6.2.1
X-Accept-Language: en-us
MIME-Version: 1.0
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
CC: Ralf Baechle <ralf@uni-koblenz.de>, linux-mips@fnet.fr,
   linux-mips@oss.sgi.com
Subject: Re: [patch] linux: New style IRQs for DECstation
References: <Pine.GSO.3.96.1020409153428.397F-100000@delta.ds2.pg.gda.pl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Maciej W. Rozycki wrote:

> I can't see a reason why to handle this option in
> system-specific code.
> 


How about "there will be likely no such CPUs/systems in the future"?

Your patch will force every new CPU to add FPUEX option to the cpu_option, 
where apparently no place really need to use it.


Leaving FPU exception enabled for a CPU that does not generate FPU exception 
is acceptable. (because it does *not* generate FPU exceptions).  And hooking 
up/dispatching the FPU exception interrupt is system-specific already anyway.

It, however, makes sense to provide a common wrapper code for fpu interrupt to 
jump to fpu exception handling code.

Over-abstraction can make the picture cloudy rather than clear.  My 2 cents.

Jun

Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g5BJtRnC020123
	for <linux-mips-outgoing@oss.sgi.com>; Tue, 11 Jun 2002 12:55:27 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g5BJtR4n020122
	for linux-mips-outgoing; Tue, 11 Jun 2002 12:55:27 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from localhost.localdomain (ip68-6-25-170.hu.sd.cox.net [68.6.25.170])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g5BJtOnC020113
	for <linux-mips@oss.sgi.com>; Tue, 11 Jun 2002 12:55:24 -0700
Received: (from justin@localhost)
	by localhost.localdomain (8.11.6/8.11.6) id g5BJv0v02919;
	Tue, 11 Jun 2002 12:57:00 -0700
X-Authentication-Warning: localhost.localdomain: justin set sender to justin@cs.cmu.edu using -f
Subject: Re: Atomicity & preemptive kernels
From: Justin Carlson <justin@cs.cmu.edu>
To: Jun Sun <jsun@mvista.com>
Cc: linux-mips@oss.sgi.com
In-Reply-To: <3D0644F4.8070902@mvista.com>
References: <1023738247.1133.56.camel@localhost.localdomain>
		<3D0524B5.403@mvista.com> <1023753603.1152.28.camel@localhost.localdomain>
	 <3D0644F4.8070902@mvista.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 11 Jun 2002 12:56:59 -0700
Message-Id: <1023825419.2776.13.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, 2002-06-11 at 11:44, Jun Sun wrote:

> I see your point now.
> 
> However, the race is not there.  switch_mm() is only called from inside 
> schedule() function, which as a whole is preemption-safe.  In other words, the 
> above event sequence won't cause a context switch until we exit from 
> schedule() function.
> 

Yes, but the initial code I cited was explicitly not in the schedule
function.  It was an icache_flush_page() implementation.

Just something to be careful of.  I think it's going to bite more than a
few people as a bug that's about impossible to track down...

-Justin

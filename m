Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g7A05SRw027730
	for <linux-mips-outgoing@oss.sgi.com>; Fri, 9 Aug 2002 17:05:28 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g7A05SaD027729
	for linux-mips-outgoing; Fri, 9 Aug 2002 17:05:28 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from localhost.localdomain (ip68-6-25-170.hu.sd.cox.net [68.6.25.170])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g7A05NRw027720
	for <linux-mips@oss.sgi.com>; Fri, 9 Aug 2002 17:05:23 -0700
Received: (from justin@localhost)
	by localhost.localdomain (8.11.6/8.11.6) id g7A07xd01812;
	Fri, 9 Aug 2002 17:07:59 -0700
X-Authentication-Warning: localhost.localdomain: justin set sender to carlson@broadcom.com using -f
Subject: Re: a really really weird crash on swarm
From: Justin Carlson <carlson@broadcom.com>
To: Jun Sun <jsun@mvista.com>
Cc: linux-mips@oss.sgi.com
In-Reply-To: <3D544E9B.6040205@mvista.com>
References: <3D544E9B.6040205@mvista.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 09 Aug 2002 17:07:58 -0700
Message-Id: <1028938078.1531.8.camel@xyzzy.rlson.org>
Mime-Version: 1.0
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, 2002-08-09 at 16:22, Jun Sun wrote:
> 
> Call me crazy - I have seen crash like this.  As you can see, the register is 
> loaded with one value and on next instruction it shows another value.  What 
> the hell is it possibly going on?
> 

As presented, this seems exceedingly unlikely; even processor bugs don't
look quite like this.  You just don't lose state in such a blatant
manner.

I'd be more inclined to believe that we took an interrupt and somehow
the saved processor state was corrupted.  The positioning of the code
looks suspicious to me;  we're shortly into a bottom half, which means
if we just, say, unmasked an interrupt in the SCD, we could quite
possibly take the interrupt around then.

Unfortunately, unless you can reliably reproduce this crash, there's not
enough info there to really do more than speculate wildly.

-Justin

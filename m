Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g7CI1jRw012938
	for <linux-mips-outgoing@oss.sgi.com>; Mon, 12 Aug 2002 11:01:45 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g7CI1iOS012937
	for linux-mips-outgoing; Mon, 12 Aug 2002 11:01:44 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from dea.linux-mips.net (c-180-196-67.ka.dial.de.ignite.net [62.180.196.67])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g7CI1cRw012928
	for <linux-mips@oss.sgi.com>; Mon, 12 Aug 2002 11:01:40 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id g7BGpd202146;
	Sun, 11 Aug 2002 18:51:39 +0200
Date: Sun, 11 Aug 2002 18:51:38 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: Jun Sun <jsun@mvista.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: a really really weird crash on swarm
Message-ID: <20020811185138.A2133@dea.linux-mips.net>
References: <3D544E9B.6040205@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3D544E9B.6040205@mvista.com>; from jsun@mvista.com on Fri, Aug 09, 2002 at 04:22:03PM -0700
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, Aug 09, 2002 at 04:22:03PM -0700, Jun Sun wrote:

> Call me crazy - I have seen crash like this.  As you can see, the register is 
> loaded with one value and on next instruction it shows another value.  What 
> the hell is it possibly going on?
> 
> This is with today's OSS tree 2.4 branch.

Really odd because the register only lost the upper 16 bits; the lower 16
bits still have their expected value.

  Ralf

Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Jan 2003 19:44:10 +0000 (GMT)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:250 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S8225262AbTATToK>;
	Mon, 20 Jan 2003 19:44:10 +0000
Received: (from jsun@localhost)
	by orion.mvista.com (8.11.6/8.11.6) id h0KJi5001568;
	Mon, 20 Jan 2003 11:44:05 -0800
Date: Mon, 20 Jan 2003 11:44:05 -0800
From: Jun Sun <jsun@mvista.com>
To: linux-mips@linux-mips.org
Cc: jsun@mvista.com
Subject: Re: Anyone running crashme?
Message-ID: <20030120114405.T2100@mvista.com>
References: <20030117012644.GA2058@wumpus.internal.keyresearch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030117012644.GA2058@wumpus.internal.keyresearch.com>; from lindahl@keyresearch.com on Thu, Jan 16, 2003 at 05:26:44PM -0800
Return-Path: <jsun@orion.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1182
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips


I have crashme running on several boards here.  The only problem
found is that kernel does not check for MDMX exception
for newer CPUs, which is already fixed in the tree.

Jun

On Thu, Jan 16, 2003 at 05:26:44PM -0800, Greg Lindahl wrote:
> I've been running crashme a little against Linux mips, and from the
> bugs I immediately found I suspect that no one's been running it.
> Crashme generates random bytes and then executes them, catching the
> resulting signals and generating more random bytes. The random number
> seed is provided by the user, so that problems are repeatable.
> 
> If you like debugging, you can find the source at:
> 
> http://people.delphiforums.com/gjc/crashme.html
> 
> -- greg
> 
> 
> 
> 
> 

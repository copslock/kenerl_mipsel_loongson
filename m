Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Feb 2003 18:46:31 +0000 (GMT)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:47611 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S8225222AbTBGSqa>;
	Fri, 7 Feb 2003 18:46:30 +0000
Received: (from jsun@localhost)
	by orion.mvista.com (8.11.6/8.11.6) id h17IkLx04992;
	Fri, 7 Feb 2003 10:46:21 -0800
Date: Fri, 7 Feb 2003 10:46:21 -0800
From: Jun Sun <jsun@mvista.com>
To: Vivien Chappelier <vivienc@nerim.net>
Cc: Ralf Baechle <ralf@oss.sgi.com>, linux-mips@linux-mips.org,
	jsun@mvista.com
Subject: Re: [PATCH 2.5] clear USEDFPU in copy_thread
Message-ID: <20030207104621.L13258@mvista.com>
References: <Pine.LNX.4.21.0302042349200.31806-100000@melkor> <20030206164342.G13258@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030206164342.G13258@mvista.com>; from jsun@mvista.com on Thu, Feb 06, 2003 at 04:43:42PM -0800
Return-Path: <jsun@orion.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1368
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips

On Thu, Feb 06, 2003 at 04:43:42PM -0800, Jun Sun wrote:
> 
> You should *not* clear USEDFPU in copy_thread().  Imagine
> you assign a floating point variable f=0.3, then do fork()
> and then in the child process, alas, f is undefined (zero
> most likely).
> 
> If you really want to do it, it should be in start_thread().
>

This is plain stupid comment!  I was thinking about task->used_math
flag.  Please igore it.  
 
> I am still curious whether this is a bug in i386 as well or they do
> clear the flag in some non-obvious way.  Note that the unlazy_fpu()
> in copy_thread won't do it.  It only clears the current process's
> USEDFPU flag, while the child process's flag is set way back in
> copy_flags() calls inside do_fork().
>

But this comment still makes sense... 

Jun

Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0QHEk228770
	for linux-mips-outgoing; Sat, 26 Jan 2002 09:14:46 -0800
Received: from xyzzy.stargate.net ([198.144.45.122])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0QHEhP28764
	for <linux-mips@oss.sgi.com>; Sat, 26 Jan 2002 09:14:43 -0800
Received: (from justin@localhost)
	by xyzzy.stargate.net (8.11.6/8.11.6) id g0QGFdJ01998;
	Sat, 26 Jan 2002 11:15:39 -0500
X-Authentication-Warning: xyzzy.stargate.net: justin set sender to justinca@ri.cmu.edu using -f
Subject: Re: A linuxthreads bug on mips?
From: Justin Carlson <justinca@ri.cmu.edu>
To: hjl@lucon.org
Cc: libc-alpha@sources.redhat.com, linux-mips@oss.sgi.com
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.1 
Date: 26 Jan 2002 11:15:38 -0500
Message-Id: <1012061738.1322.22.camel@xyzzy.stargate.net>
Mime-Version: 1.0
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Sat, 2002-01-26 at 02:45, H . J . Lu wrote:
> Here is a modified ex2.c which only uses one conditional variable. It
> works fine on x86. But it leads to dead lock on mips where both
> producer and consumer are suspended. Is this testcase correct?
> 

I stared at it for a while and see nothing wrong with it.  Well, ok, 
iters is #define'd but never used.  But somehow I doubt that's the root
of your problems.  ;)

-Justin

Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1LJC8a09569
	for linux-mips-outgoing; Thu, 21 Feb 2002 11:12:08 -0800
Received: from web11908.mail.yahoo.com (web11908.mail.yahoo.com [216.136.172.192])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1LJC5909566
	for <linux-mips@oss.sgi.com>; Thu, 21 Feb 2002 11:12:05 -0800
Message-ID: <20020221181204.48818.qmail@web11908.mail.yahoo.com>
Received: from [209.243.184.191] by web11908.mail.yahoo.com via HTTP; Thu, 21 Feb 2002 10:12:04 PST
Date: Thu, 21 Feb 2002 10:12:04 -0800 (PST)
From: Wayne Gowcher <wgowcher@yahoo.com>
Subject: Re: pthread support in mipsel-linux
To: "H . J . Lu" <hjl@lucon.org>
Cc: Linux-MIPS <linux-mips@oss.sgi.com>
In-Reply-To: <20020221095505.A28496@lucon.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

H.J.

Thank you for your reply.

> The threads works well with glibc compiled with
> -mips2. But the threads
> in my RedHat 7.1 is broken when compiled with -mips2
> :-(. I have fixed
> it in glibc CVS.

Just to clarify, the glibc rpm in your Redhat 7.1 is
compiled with -mips1 right ? So as it is broken yes ?

So if I REALLY wanted to use pthreads with your redhat
7.1 distribution, could I get away with checking out
the current glibc from CVS, recompiling it and
installing over the rpm glibc ? Or is that too
simplistic, and it will need recompilation of a lot of
other applications ? 
If so could you give me an idea of just how big a job
that is ?

Wayne

__________________________________________________
Do You Yahoo!?
Yahoo! Sports - Coverage of the 2002 Olympic Games
http://sports.yahoo.com

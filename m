Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1LJPEo09792
	for linux-mips-outgoing; Thu, 21 Feb 2002 11:25:14 -0800
Received: from rwcrmhc54.attbi.com (rwcrmhc54.attbi.com [216.148.227.87])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1LJPA909789
	for <linux-mips@oss.sgi.com>; Thu, 21 Feb 2002 11:25:10 -0800
Received: from ocean.lucon.org ([12.234.16.87]) by rwcrmhc54.attbi.com
          (InterMail vM.4.01.03.27 201-229-121-127-20010626) with ESMTP
          id <20020221182504.VMBQ1214.rwcrmhc54.attbi.com@ocean.lucon.org>;
          Thu, 21 Feb 2002 18:25:04 +0000
Received: by ocean.lucon.org (Postfix, from userid 1000)
	id B0867125C1; Thu, 21 Feb 2002 10:25:03 -0800 (PST)
Date: Thu, 21 Feb 2002 10:25:03 -0800
From: "H . J . Lu" <hjl@lucon.org>
To: Wayne Gowcher <wgowcher@yahoo.com>
Cc: Linux-MIPS <linux-mips@oss.sgi.com>
Subject: Re: pthread support in mipsel-linux
Message-ID: <20020221102503.A28936@lucon.org>
References: <20020221095505.A28496@lucon.org> <20020221181204.48818.qmail@web11908.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020221181204.48818.qmail@web11908.mail.yahoo.com>; from wgowcher@yahoo.com on Thu, Feb 21, 2002 at 10:12:04AM -0800
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, Feb 21, 2002 at 10:12:04AM -0800, Wayne Gowcher wrote:
> H.J.
> 
> Thank you for your reply.
> 
> > The threads works well with glibc compiled with
> > -mips2. But the threads
> > in my RedHat 7.1 is broken when compiled with -mips2
> > :-(. I have fixed
> > it in glibc CVS.
> 
> Just to clarify, the glibc rpm in your Redhat 7.1 is
> compiled with -mips1 right ? So as it is broken yes ?

Yes. -mips1 doesn't work well with thread.

> 
> So if I REALLY wanted to use pthreads with your redhat
> 7.1 distribution, could I get away with checking out
> the current glibc from CVS, recompiling it and
> installing over the rpm glibc ? Or is that too
> simplistic, and it will need recompilation of a lot of
> other applications ? 

It should be mostly ok if you use gcc 2.96. But glibc in CVS lacks
a few mips change in my glibc in RedHat 7.1. At least, you may want
glibc-2.2-mmap64.patch in my glibc.



H.J.

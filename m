Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f7GK5q307217
	for linux-mips-outgoing; Thu, 16 Aug 2001 13:05:52 -0700
Received: from www.transvirtual.com (root@www.transvirtual.com [206.14.214.140])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f7GK5nj07213;
	Thu, 16 Aug 2001 13:05:49 -0700
Received: from www.transvirtual.com (jsimmons@localhost [127.0.0.1])
        by localhost (8.12.0.Beta7/8.12.0.Beta7/Debian 8.12.0.Beta7-1) with ESMTP id f7GK5ZTc031044;
	Thu, 16 Aug 2001 13:05:35 -0700
Received: from localhost (jsimmons@localhost)
        by www.transvirtual.com (8.12.0.Beta7/8.12.0.Beta7/Debian 8.12.0.Beta7-1) with ESMTP id f7GK5Y3W031039;
	Thu, 16 Aug 2001 13:05:35 -0700
X-Authentication-Warning: www.transvirtual.com: jsimmons owned process doing -bs
Date: Thu, 16 Aug 2001 13:05:33 -0700 (PDT)
From: James Simmons <jsimmons@transvirtual.com>
To: Martin Michlmayr <tbm@cyrius.com>
cc: Ralf Baechle <ralf@oss.sgi.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
   Brian Murphy <brian.murphy@eicon.com>, linux-mips@oss.sgi.com
Subject: Re: glibc
In-Reply-To: <20010816210940.A21001@fisch.cyrius.com>
Message-ID: <Pine.LNX.4.10.10108161246491.15614-100000@transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


> > The latest glibc 2.0.6 I was spreading only has MIPS-specific bug
> > fixes.  All the other big holes which are indeed big enough to drive
> > a nice shipload of trucks through are unfixed.  I haven't noticed
> > that any other glibc 2.0 variant floating around has additional
> > fixes.
> > 
> > Nice for Cobalt boxen ...
> 
> Debian is being ported to Cobalts.  A base tar ball can be found at
> http://www.pocketlinux.com/~samc/debian-cobalt

All the latest stuff there. I use it for my native build system. The
kernel is a 2.4.5 BTW if people are curious. I attempt a 2.4.6 kernel but
for some reason the cube doesn't like it. I believe I have a bug in the
old time code which is affected by the soft_pending change. I will attempt
to track it down some time next week.

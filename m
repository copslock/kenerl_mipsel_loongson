Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6DFtnRw030082
	for <linux-mips-outgoing@oss.sgi.com>; Sat, 13 Jul 2002 08:55:49 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6DFtnw9030081
	for linux-mips-outgoing; Sat, 13 Jul 2002 08:55:49 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from sccrmhc02.attbi.com (sccrmhc02.attbi.com [204.127.202.62])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6DFteRw030070
	for <linux-mips@oss.sgi.com>; Sat, 13 Jul 2002 08:55:40 -0700
Received: from ocean.lucon.org ([12.234.143.38]) by sccrmhc02.attbi.com
          (InterMail vM.4.01.03.27 201-229-121-127-20010626) with ESMTP
          id <20020713160018.EOUH6023.sccrmhc02.attbi.com@ocean.lucon.org>;
          Sat, 13 Jul 2002 16:00:18 +0000
Received: by ocean.lucon.org (Postfix, from userid 1000)
	id 0A895125D6; Sat, 13 Jul 2002 09:00:16 -0700 (PDT)
Date: Sat, 13 Jul 2002 09:00:16 -0700
From: "H. J. Lu" <hjl@lucon.org>
To: "Kevin D. Kissell" <kevink@mips.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: Gcc v2.96 versus Trolltech QtEmbedded Window System
Message-ID: <20020713090016.A18723@lucon.org>
References: <023e01c22a5e$c013f120$10eca8c0@grendel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <023e01c22a5e$c013f120$10eca8c0@grendel>; from kevink@mips.com on Sat, Jul 13, 2002 at 01:15:54PM +0200
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Sat, Jul 13, 2002 at 01:15:54PM +0200, Kevin D. Kissell wrote:
> I am trying to build the GPL version of the Trolltech
> QT embedded windowing system on my Malta, using
> what I believe to be H.J. Lu's most recent tool chain:
> 
> [root@localhost release-emb-generic]# g++ -v
> Reading specs from /usr/lib/gcc-lib/mipsel-redhat-linux-gnu/2.96/specs
> gcc version 2.96 20000731 (Red Hat Linux 7.3 2.96-110.1)
> 
> The QT build process is a little unusual - the configure
> script causes a fairly huge (640KB) C++ source file
> to be generated, which is then thrown at the compiler.
> I would expect that to take a while, but after about 
> 20 hours with zero output passed to the assembler
> stage (it runs with -pipe) and the gradual accretion
> of about 90MB of virtual memory (on my poor 32MB
> system) I concluded that it was probably trapped in
> an infinite loop.  As I have seen this sort of thing occur
> in the past in optimizer stages, I hacked the makefile
> to replace -O2 with -O0.  It hasn't run for 20 hours
> at -O0 yet, but after a couple of hours the memory 
> allocation dynamic looks to be the same, only faster
> (72MB after only a couple of hours), so I'm not
> optimistic.
> 
> My questions to the assembled panel of experts are:
> 
> Are there known problems with gcc 2.96.110.1 in
> this regard?

Have you tried the same C++ code with the same version of the cross
toolchain on Linux/x86? It may just take huge amount of memory.

> 
> Is there a native toolchain that would be more 
> likely to be able to handle the build of QT?
> I'm considering trying the 2.95 set on Maciej's
> site out of desperation.
> 

You can try my gcc 3.1 for RedHat 7.3. But it may need more memory.



H.J.

Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Jul 2005 15:32:00 +0100 (BST)
Received: from mra03.ch.as12513.net ([IPv6:::ffff:82.153.252.25]:55711 "EHLO
	mra03.ch.as12513.net") by linux-mips.org with ESMTP
	id <S8226872AbVGSObl>; Tue, 19 Jul 2005 15:31:41 +0100
Received: from localhost (localhost [127.0.0.1])
	by mra03.ch.as12513.net (Postfix) with ESMTP id 4EAC7D421C
	for <linux-mips@linux-mips.org>; Tue, 19 Jul 2005 15:33:20 +0100 (BST)
Received: from mra03.ch.as12513.net ([127.0.0.1])
 by localhost (mra03.ch.as12513.net [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 01860-01-4 for <linux-mips@linux-mips.org>;
 Tue, 19 Jul 2005 15:33:19 +0100 (BST)
Received: from euskadi.packetvision (unknown [82.152.104.245])
	by mra03.ch.as12513.net (Postfix) with ESMTP id 03782D4291
	for <linux-mips@linux-mips.org>; Tue, 19 Jul 2005 15:33:17 +0100 (BST)
Subject: Re: remote debugging: "Reply contains invalid hex digit 59"
From:	Alex Gonzalez <alex.gonzalez@packetvision.com>
To:	linux-mips@linux-mips.org
In-Reply-To: <1121783462.12629.10.camel@euskadi.packetvision>
References: <20050719135122Z8226926-3678+3493@linux-mips.org>
	 <1121783462.12629.10.camel@euskadi.packetvision>
Content-Type: text/plain
Message-Id: <1121783718.12629.12.camel@euskadi.packetvision>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-9) 
Date:	Tue, 19 Jul 2005 15:35:19 +0100
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: by Eclipse VIRUSshield at eclipse.net.uk
Return-Path: <alex.gonzalez@packetvision.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8549
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alex.gonzalez@packetvision.com
Precedence: bulk
X-list: linux-mips

I have seen something similar in our platform when the gdb on the host
computer was not compiled correctly.

For example it may be cross-compiled for mips n32 while the gdbserver is
compiled for o32, or similar incompatibilities.

I would double check that the toolchains used to compile the host gdb
and target gdbserver match.

Alex
> 
> On Tue, 2005-07-19 at 14:52, Bryan Althouse wrote:
> > Is anyone doing remote debugging for mips?  
> > 
> > I start the gdbserver on mips with:  
> >     gdbserver 192.168.2.39:2222 ./hello_loop
> > This produces:
> >     Process ./hello_loop created; pid = 158
> > 
> > On my PC, I type:
> >     ddd --debugger mips64-linux-gnu-gdb hello_loop
> >     (at gdb prompt) target remote 192.168.2.55:2222
> > 
> > This produces:
> >     (on gdb prompt) Couldn't establish connection to remote target
> >      Reply contains invalid hex digit 59
> >     (on mips) Remote debugging from host 192.168.2.39
> >      Readchar: Got EOF
> >      Remote side has terminated connection.  GDBserver will reopen the
> > connection. 
> > 
> > This problem is also described here:
> > http://mailman.uclinux.org/pipermail/uclinux-dev/2004-April/025421.html
> > 
> > Any ideas?  Thanks!
> > 
> > Bryan
> > 

Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6J8xeRw018982
	for <linux-mips-outgoing@oss.sgi.com>; Fri, 19 Jul 2002 01:59:40 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6J8xeCX018981
	for linux-mips-outgoing; Fri, 19 Jul 2002 01:59:40 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from laposte.enst-bretagne.fr (laposte.enst-bretagne.fr [192.108.115.3])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6J8xaRw018965
	for <linux-mips@oss.sgi.com>; Fri, 19 Jul 2002 01:59:36 -0700
Received: from resel.enst-bretagne.fr (UNKNOWN@maisel-gw.enst-bretagne.fr [192.44.76.8])
	by laposte.enst-bretagne.fr (8.11.6/8.11.6) with ESMTP id g6J905Y06111;
	Fri, 19 Jul 2002 11:00:05 +0200
Received: from melkor (mail@melkor.maisel.enst-bretagne.fr [172.16.20.65])
	by resel.enst-bretagne.fr (8.12.3/8.12.3/Debian -4) with ESMTP id g6J905TF032304;
	Fri, 19 Jul 2002 11:00:05 +0200
Received: from glaurung (helo=localhost)
	by melkor with local-esmtp (Exim 3.35 #1 (Debian))
	id 17VTcK-0000C5-00; Fri, 19 Jul 2002 11:00:04 +0200
Date: Fri, 19 Jul 2002 11:00:04 +0200 (CEST)
From: Vivien Chappelier <vivien.chappelier@enst-bretagne.fr>
X-Sender: glaurung@melkor
To: Frank Foerstemann <Foerstemann@web.de>
cc: linux-mips@oss.sgi.com
Subject: Re: booting 2.5.3 kernel crashes
In-Reply-To: <200207180542.g6I5gcQ01010@marvin.ffo.org>
Message-ID: <Pine.LNX.4.21.0207191055370.684-100000@melkor>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: by amavisd-milter (http://amavis.org/) at enst-bretagne.fr
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

> I tried the 2.5.3 Kernel from CVS on my R44K-Indy. Compiling works fine, but 
> when I try to boot the kernel it crashes after the message "Posix conformance 
> testing ..." with the error:
> 
> "Kernel unaligned instruction access in: unaligned.c::do_ade, line 409 ..."
> 
> Does anybody know what's wrong ? 

Yep: context switching.
I've a patch for 2.5.4/mips64, I'm sending it again to Ralf and to this
mailing list.
Anyway, you get what you deserve playing with an unstable kernel :)
(you may want to try the linux_2_4 branch)

regards,
Vivien Chappelier.

Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6C3eqRw007855
	for <linux-mips-outgoing@oss.sgi.com>; Thu, 11 Jul 2002 20:40:52 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6C3eqxQ007854
	for linux-mips-outgoing; Thu, 11 Jul 2002 20:40:52 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from perninha.conectiva.com.br (perninha.conectiva.com.br [200.250.58.156])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6C3ekRw007843
	for <linux-mips@oss.sgi.com>; Thu, 11 Jul 2002 20:40:47 -0700
Received: from burns.conectiva (burns.conectiva [10.0.0.4])
	by perninha.conectiva.com.br (Postfix) with SMTP id 65FDF38DC6
	for <linux-mips@oss.sgi.com>; Fri, 12 Jul 2002 00:45:21 -0300 (EST)
Received: (qmail 25748 invoked by uid 0); 12 Jul 2002 03:45:37 -0000
Received: from freak.distro.conectiva (10.0.17.22)
  by burns.conectiva with SMTP; 12 Jul 2002 03:45:37 -0000
Date: Thu, 11 Jul 2002 23:51:10 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jun Sun <jsun@mvista.com>, <linux-mips@oss.sgi.com>,
   Ralf Baechle <ralf@oss.sgi.com>, Jeff Garzik <jgarzik@mandrakesoft.com>
Subject: Re: [2.4 PATCH] pcnet32.c - tx underflow error
In-Reply-To: <E17SRFB-00087H-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.44.0207112350440.21590-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk



On Thu, 11 Jul 2002, Alan Cox wrote:

> > This patch fixes a tx underflow error for 79c973 chip.  It essentially delay
> > the transmission until the whole packet is received into the on-chip sdram.
> >
> > The patch is already accepted by Marcelo for the 2.4 tree, I think.
>
> Which slows the stuff down for people with real computers. Please apply
> some kind of heuristic to this - eg switch to delaying if you exceed
> 50 failures in a 60 second period.

I haven't applied it yet.

I'll let it come to me throught Jeff Garzik after the issues are resolved.

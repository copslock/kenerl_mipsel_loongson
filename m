Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6B1rLRw030978
	for <linux-mips-outgoing@oss.sgi.com>; Wed, 10 Jul 2002 18:53:21 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6B1rLGC030977
	for linux-mips-outgoing; Wed, 10 Jul 2002 18:53:21 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from the-village.bc.nu (lightning.swansea.linux.org.uk [194.168.151.1])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6B1r8Rw030951;
	Wed, 10 Jul 2002 18:53:15 -0700
Received: from alan by the-village.bc.nu with local (Exim 3.33 #5)
	id 17STa3-0008M5-00; Thu, 11 Jul 2002 03:21:19 +0100
Subject: Re: [2.4 PATCH] pcnet32.c - tx underflow error
To: jsun@mvista.com (Jun Sun)
Date: Thu, 11 Jul 2002 03:21:19 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-mips@oss.sgi.com,
   ralf@oss.sgi.com (Ralf Baechle), marcelo@conectiva.com.br
In-Reply-To: <3D2CC891.1010506@mvista.com> from "Jun Sun" at Jul 10, 2002 04:51:45 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17STa3-0008M5-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

> > Which slows the stuff down for people with real computers.
> 
> Contrary to what it might appear at first glance, it does not really.

Throughput and latency are quite different things. Try that on a latency
sensitive setup like a beowulf.

Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6ANNlRw023670
	for <linux-mips-outgoing@oss.sgi.com>; Wed, 10 Jul 2002 16:23:47 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6ANNlCI023669
	for linux-mips-outgoing; Wed, 10 Jul 2002 16:23:47 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from the-village.bc.nu (lightning.swansea.linux.org.uk [194.168.151.1])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6ANNcRw023655;
	Wed, 10 Jul 2002 16:23:40 -0700
Received: from alan by the-village.bc.nu with local (Exim 3.33 #5)
	id 17SRFB-00087H-00; Thu, 11 Jul 2002 00:51:37 +0100
Subject: Re: [2.4 PATCH] pcnet32.c - tx underflow error
To: jsun@mvista.com (Jun Sun)
Date: Thu, 11 Jul 2002 00:51:37 +0100 (BST)
Cc: linux-mips@oss.sgi.com, ralf@oss.sgi.com (Ralf Baechle),
   marcelo@conectiva.com.br
In-Reply-To: <3D2CAD78.9070609@mvista.com> from "Jun Sun" at Jul 10, 2002 02:56:08 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17SRFB-00087H-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

> This patch fixes a tx underflow error for 79c973 chip.  It essentially delay 
> the transmission until the whole packet is received into the on-chip sdram.
> 
> The patch is already accepted by Marcelo for the 2.4 tree, I think.

Which slows the stuff down for people with real computers. Please apply
some kind of heuristic to this - eg switch to delaying if you exceed
50 failures in a 60 second period.

Alan

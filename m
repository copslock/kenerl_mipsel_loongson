Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6B1m1Rw030631
	for <linux-mips-outgoing@oss.sgi.com>; Wed, 10 Jul 2002 18:48:01 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6B1m1mu030630
	for linux-mips-outgoing; Wed, 10 Jul 2002 18:48:01 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from the-village.bc.nu (lightning.swansea.linux.org.uk [194.168.151.1])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6B1lqRw030621;
	Wed, 10 Jul 2002 18:47:55 -0700
Received: from alan by the-village.bc.nu with local (Exim 3.33 #5)
	id 17STUx-0008LR-00; Thu, 11 Jul 2002 03:16:03 +0100
Subject: Re: [2.4 PATCH] pcnet32.c - tx underflow error
To: jsun@mvista.com (Jun Sun)
Date: Thu, 11 Jul 2002 03:16:03 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-mips@oss.sgi.com,
   ralf@oss.sgi.com (Ralf Baechle), marcelo@conectiva.com.br
In-Reply-To: <3D2CCC83.6090304@mvista.com> from "Jun Sun" at Jul 10, 2002 05:08:35 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17STUx-0008LR-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

> I even suspect this is the default setting on PCI cards on PC.  Can someone 
> verify?  If that is the case, that will explain why driver never sets this 
> bit.  Maybe we don't have any "real computers" after all. :-)

Most PC hardware can deliver that kind of DMA guarantee. UDMA100 doesn't
work very well otherwise.

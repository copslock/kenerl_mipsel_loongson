Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f72KP3g06094
	for linux-mips-outgoing; Thu, 2 Aug 2001 13:25:03 -0700
Received: from bagpuss.swansea.linux.org.uk (pc1-cwbl2-0-cust80.cdf.cable.ntl.com [62.252.63.80])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f72KP1V06085
	for <linux-mips@oss.sgi.com>; Thu, 2 Aug 2001 13:25:02 -0700
Received: (from alan@localhost)
	by bagpuss.swansea.linux.org.uk (8.11.2/8.11.2) id f6TLQ7m01578;
	Sun, 29 Jul 2001 17:26:07 -0400
From: Alan Cox <alan@bagpuss.swansea.linux.org.uk>
Message-Id: <200107292126.f6TLQ7m01578@bagpuss.swansea.linux.org.uk>
Subject: Re: [long] Lance on DS5k/200
To: jbglaw@lug-owl.de (Jan-Benedict Glaw)
Date: Sun, 29 Jul 2001 17:26:06 -0400 (EDT)
Cc: macro@ds2.pg.gda.pl (Maciej W. Rozycki), airlied@csn.ul.ie (Dave Airlie),
   linux-mips@oss.sgi.com (SGI MIPS list),
   debian-mips@lists.debian.org (Debian MIPS list), engel@unix-ag.org
In-Reply-To: <20010731004556.C19713@lug-owl.de> from "Jan-Benedict Glaw" at Jul 31, 2001 12:45:56 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

> >  Z8530 is on my to-do list.  Our driver really sucks: neither DMA (the I/O
> > ASIC again) nor sychronous mode, just basic asynchronous support.  I'm
> > going to look at LANCE one day, too, but it's lower on the list.
> 
> You you facing towards all those Z8530 implementation or only to
> "ours"?

All the 8530 sync support is in my Z85230 driver. Its written so
someone can add async support to it.

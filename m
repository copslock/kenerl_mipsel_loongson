Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g04HehX12820
	for linux-mips-outgoing; Fri, 4 Jan 2002 09:40:43 -0800
Received: from the-village.bc.nu (lightning.swansea.linux.org.uk [194.168.151.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g04Hecg12817
	for <linux-mips@oss.sgi.com>; Fri, 4 Jan 2002 09:40:39 -0800
Received: from alan by the-village.bc.nu with local (Exim 3.22 #1)
	id 16MXZ1-0004da-00; Fri, 04 Jan 2002 16:51:27 +0000
Subject: Re: Designing hardware to join PCI to large local memory
To: dom@algor.co.uk (Dominic Sweetman)
Date: Fri, 4 Jan 2002 16:51:27 +0000 (GMT)
Cc: linux-mips@oss.sgi.com (linux-mips), rick@algor.co.uk, nigel@algor.co.uk,
   john@algor.co.uk
In-Reply-To: <200201041634.QAA19027@mudchute.algor.co.uk> from "Dominic Sweetman" at Jan 04, 2002 04:34:49 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16MXZ1-0004da-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

> or less) can handle much larger memories - we would like it to go on
> past 4Gbytes.  So now there aren't enough addresses on PCI to map all
> the memory.

Good PCI devices can support DAC and can access 64bits on a 32bit bus at
a tiny penalty.

> We (more specifically Chris) have looked at the kernel sources, and
> concluded that schemes of both types have been attempted - though the
> sources don't, of course, pass judgement on how well it worked.
> 
> Those of you with experience: which would you recommend?  And if (2),
> can you point us to descriptions of good hardware facilities you've
> met or even imagined?

On big X86 setups bounce buffers really do hurt I/O performance. The
real answer is either DAC aware hardware for performance critical stuff
or some kind of mapping hardware, which requires much more complex toys
than a random cheap pci bridge.

Alan

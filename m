Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1QBufS12767
	for linux-mips-outgoing; Tue, 26 Feb 2002 03:56:41 -0800
Received: from the-village.bc.nu (lightning.swansea.linux.org.uk [194.168.151.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1QBuc912755
	for <linux-mips@oss.sgi.com>; Tue, 26 Feb 2002 03:56:39 -0800
Received: from alan by the-village.bc.nu with local (Exim 3.33 #5)
	id 16ffVG-0000IW-00; Tue, 26 Feb 2002 11:10:38 +0000
Subject: Re: MIPS, i8259 and spurious interrupts.
To: dom@algor.co.uk (Dominic Sweetman)
Date: Tue, 26 Feb 2002 11:10:38 +0000 (GMT)
Cc: samcconn@cotw.com (Scott A McConnell), linux-mips@oss.sgi.com
In-Reply-To: <15483.26654.874273.652089@gladsmuir.algor.co.uk> from "Dominic Sweetman" at Feb 26, 2002 10:49:02 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16ffVG-0000IW-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

> Then 8259s are ugly things which have some very CPU-specific
> interactions with x86 CPUs.  In a non-x86 context you need to
> initialise them in particular ways.  
 
Like with a soldering iron 8)

In paticular if you are getting hangs at the point where you allow an IRQ
to come in check the level/edge behaviour and see if in fact you are taking
a continuous stream of interrupts jamming the CPU in irq handling

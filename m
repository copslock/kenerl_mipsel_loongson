Received:  by oss.sgi.com id <S42380AbQI1TlW>;
	Thu, 28 Sep 2000 12:41:22 -0700
Received: from noose.gt.owl.de ([62.52.19.4]:61444 "HELO noose.gt.owl.de")
	by oss.sgi.com with SMTP id <S42347AbQI1TlD>;
	Thu, 28 Sep 2000 12:41:03 -0700
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id B30227F3; Thu, 28 Sep 2000 21:41:00 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 0497D9014; Thu, 28 Sep 2000 21:40:02 +0200 (CEST)
Date:   Thu, 28 Sep 2000 21:40:02 +0200
From:   Florian Lohoff <flo@rfc822.org>
To:     Ralf Baechle <ralf@oss.sgi.com>
Cc:     linux-mips@oss.sgi.com, "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Subject: Decstation broken Was: CVS Update@oss.sgi.com: linux
Message-ID: <20000928214002.B767@paradigm.rfc822.org>
References: <20000825213106Z42310-31375+267@oss.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
User-Agent: Mutt/1.0.1i
In-Reply-To: <20000825213106Z42310-31375+267@oss.sgi.com>; from ralf@oss.sgi.com on Fri, Aug 25, 2000 at 02:31:06PM -0700
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Fri, Aug 25, 2000 at 02:31:06PM -0700, Ralf Baechle wrote:
> CVSROOT:	/home/pub/cvs
> Module name:	linux
> Changes by:	ralf@oss.sgi.com	00/08/25 14:30:56
> 
> Modified files:
> 	arch/mips      : Makefile 
> 	arch/mips/dec  : Makefile int-handler.S irq.c setup.c time.c 
> 	include/asm-mips: addrspace.h div64.h 
> 	include/asm-mips/dec: interrupts.h ioasic_addrs.h kn02xa.h 
> 	                      kn03.h 
> Added files:
> 	include/asm-mips/dec: ioasic.h 
> 
> Log message:
> 	NTP fixes from Maciej.

Hi,
since this commit my machines are all broken (5000/260, 5000/150 
and 5000/125) - They all hang in the "Calibrating delay loop ...".

Reverting it let me boot the current kernels ...

Maciej ?

Flo
-- 
Florian Lohoff		flo@rfc822.org		      	+49-5201-669912
      "Write only memory - Oops. Time for my medication again ..."

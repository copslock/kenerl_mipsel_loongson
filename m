Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 16 Jul 2005 16:41:42 +0100 (BST)
Received: from smtp001.bizmail.yahoo.com ([IPv6:::ffff:216.136.172.125]:7801
	"HELO smtp001.bizmail.yahoo.com") by linux-mips.org with SMTP
	id <S8226777AbVGPPlY>; Sat, 16 Jul 2005 16:41:24 +0100
Received: (qmail 92730 invoked from network); 16 Jul 2005 15:42:49 -0000
Received: from unknown (HELO ?192.168.1.107?) (ppopov@embeddedalley.com@63.194.214.47 with plain)
  by smtp001.bizmail.yahoo.com with SMTP; 16 Jul 2005 15:42:49 -0000
Subject: Re: Support for (au1100) 64-bit physical address space broken on
	2.6.12?
From:	Pete Popov <ppopov@embeddedalley.com>
Reply-To: ppopov@embeddedalley.com
To:	Rodolfo Giometti <giometti@linux.it>
Cc:	linux-mips <linux-mips@linux-mips.org>
In-Reply-To: <20050716124205.GA26127@enneenne.com>
References: <20050716124205.GA26127@enneenne.com>
Content-Type: text/plain
Organization: Embedded Alley Solutions, Inc
Date:	Sat, 16 Jul 2005 08:42:55 -0700
Message-Id: <1121528575.27121.3.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Return-Path: <ppopov@embeddedalley.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8519
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@embeddedalley.com
Precedence: bulk
X-list: linux-mips

On Sat, 2005-07-16 at 14:42 +0200, Rodolfo Giometti wrote:
> Hello,
> 
> switching from linux-mips 2.6.12-rc3 to 2.6.12 I notice that the
> following patch has been applied:
> 
>    http://www.linux-mips.org/archives/linux-mips/2005-06/msg00207.html
> 
> But, on my system, recompiling the source I noticed that compilation
> stops with errors. Even downloading a clean version of source code
> from linux-mips's CVS and choosing, for instance, the board DB1100, I
> got the same result.
> 
> The problem is that the above patch works well if the 64-bit physical
> address space support is disabled, but, if enabled, it breaks
> compilation stage.

I fixed this is the latest tree a couple of days ago.

Pete

> Here what I get after getting source form CVS and doing the commands:
> 
>    # make pb1100_defconfig   (this board turn on CONFIG_64BIT_PHYS_ADDR option)
>    # make
>    ...
>    include/asm-mips/mach-au1x00/ioremap.h:25: warning: static declaration of 'fixup_bigphys_addr' follows non-static declaration
>    include/asm/pgtable.h:363: warning: 'fixup_bigphys_addr' declared inline after being called
>    include/asm/pgtable.h:363: warning: previous declaration of 'fixup_bigphys_addr' was here
>    include/asm-mips/mach-au1x00/ioremap.h: In function `fixup_bigphys_addr':
>    include/asm-mips/mach-au1x00/ioremap.h:26: warning: implicit declaration of function `__fixup_bigphys_addr'
>    arch/mips/au1000/common/setup.c: At top level:
>    arch/mips/au1000/common/setup.c:159: error: conflicting types for '__fixup_bigphys_addr'
>    include/asm-mips/mach-au1x00/ioremap.h:26: error: previous implicit declaration of '__fixup_bigphys_addr' was here
>    arch/mips/au1000/common/setup.c: In function `__fixup_bigphys_addr':
>    ...
> 
> After a little job I implemented the attached patch
> (patch-64BIT_PHYS_ADDR) that works on my system on both settings
> (CONFIG_64BIT_PHYS_ADDR on or off).
> 
> I don't know if it can resolve the above problem for others CPUs (I
> tested it on au1100) but, at least, on this processor the PCMCIA
> support now is functional. :)
> 
> I also suggest to apply the second patch (patch-PCMCIA_Kconfig) who
> simply auto enable 64 bit support when choosing PCMCIA support.
> 
> Ciao,
> 
> Rodolfo
> 

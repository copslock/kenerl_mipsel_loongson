Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 May 2005 15:08:15 +0100 (BST)
Received: from mra02.ex.eclipse.net.uk ([IPv6:::ffff:212.104.129.89]:45457
	"EHLO mra02.ex.eclipse.net.uk") by linux-mips.org with ESMTP
	id <S8225794AbVEDOH7>; Wed, 4 May 2005 15:07:59 +0100
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mra02.ex.eclipse.net.uk (Postfix) with ESMTP id EA7AC4064E2;
	Wed,  4 May 2005 15:07:56 +0100 (BST)
Received: from mra02.ex.eclipse.net.uk ([127.0.0.1])
 by localhost (mra02.ex.eclipse.net.uk [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 28074-01-55; Wed,  4 May 2005 15:07:55 +0100 (BST)
Received: from euskadi.packetvision (unknown [82.152.104.245])
	by mra02.ex.eclipse.net.uk (Postfix) with ESMTP id E5859406526;
	Wed,  4 May 2005 15:05:29 +0100 (BST)
Subject: Re: your mail (yosemite + 2.6.x issues)
From:	Alex Gonzalez <linux-mips@packetvision.com>
To:	Manish Lachwani <mlachwani@mvista.com>
Cc:	Bryan Althouse <bryan.althouse@3phoenix.com>,
	'Ralf Baechle' <ralf@linux-mips.org>, linux-mips@linux-mips.org
In-Reply-To: <42725C07.6050100@mvista.com>
References: <20050429135220Z8225807-1340+6357@linux-mips.org>
	 <42725C07.6050100@mvista.com>
Content-Type: text/plain
Message-Id: <1115215540.13387.18.camel@euskadi.packetvision>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-9) 
Date:	Wed, 04 May 2005 15:05:40 +0100
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: by Eclipse VIRUSshield at eclipse.net.uk
Return-Path: <linux-mips@packetvision.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7851
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linux-mips@packetvision.com
Precedence: bulk
X-list: linux-mips

I remember having some problem with the serial driver for the rm9000.
pmc-sierra had to supply a fix. 

Their 2.6.10-rc3-20041208 kernel had the fix applied. Sorry not to
remember more details.

Alex

On Fri, 2005-04-29 at 17:08, Manish Lachwani wrote:
> Do you load the kernel first and then do a "go"? If you load the kernel 
> first using the "load" command, then you should come back to the PMON 
> prompt where you can type a "go". I was not clear about it from your 
> email below.
> 
> Thanks
> Manish Lachwani
> 
> Bryan Althouse wrote:
> 
> >Thanks Ralf, now I can compile the kernel.  But, I don't get any serial
> >console output when I try to boot it.  Actually, I get a single line that
> >looks like this:
> >
> >Loading file: tftp://192.168.2.39/vmlinux (elf)
> >0x80100000/2288188 + 0x8032ea3c/111372(z) + 4125 syms|
> >
> >I have found PMC's "yosemite_defconfig" file and I am using it as the
> >".config". I have tried using CONFIG_PMC_INTERNAL_UART=y and I have also
> >tried commenting it out.  Either way, I get no console output.
> >
> >Thanks for the help!
> >Bryan
> >
> >-----Original Message-----
> >From: Ralf Baechle [mailto:ralf@linux-mips.org] 
> >Sent: Friday, April 29, 2005 7:03 AM
> >To: Bryan Althouse
> >Cc: linux-mips@linux-mips.org; TheNop@gmx.net
> >Subject: Re: your mail
> >
> >On Thu, Apr 28, 2005 at 03:15:49PM -0400, Bryan Althouse wrote:
> >
> >  
> >
> >>I would like to use a 2.6.x kernel with my Yosemite/HalfDome board.
> >>Somehow, I am unable to compile the kernel.  I have tried the 2.6.10
> >>    
> >>
> >kernel
> >  
> >
> >>trees from ftp.pmc-sierra.com and also the latest 2.6.12 snapshot from
> >>linux-mips.  I am using the 3.3.x cross compile tools from
> >>ftp.pmc-sierra.com .  The 2.4.x kernels from PMC compile fine.
> >>
> >>In the case of 2.6.10 from ftp.pmc-sierra.com, my error looks like:
> >>       Make[3]: *** [drivers/char/agp/backend.o] Error 1
> >>    
> >>
> >
> >Configuring AGP support for a MIPS kernel is obviously nonsense.  Disable
> >CONFIG_AGP.
> >
> >  
> >
> >>In the case of 2.6.12 from linux-mips, my error looks like:
> >>	drivers/net/titan_ge.c1950: error: 'titan_device_remove"  undeclared
> >>here (not in a function)
> >>    
> >>
> >
> >Whoops, a bug.  The function indeed doesn't exist even though it should,
> >will fix that.  You will hit this bug only if compiling the titan driver
> >as a module, so workaround set CONFIG_TITAN_GE=y.  Which for the typical
> >titan-based device seems to be the preferable choice anyway.
> >
> >  Ralf
> >
> >
> >
> >  
> >
> 
> 

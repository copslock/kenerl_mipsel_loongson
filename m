Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Oct 2008 17:24:26 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:44429 "EHLO
	localhost.localdomain") by ftp.linux-mips.org with ESMTP
	id S22597084AbYJ1RYX (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 28 Oct 2008 17:24:23 +0000
Date:	Tue, 28 Oct 2008 17:24:22 +0000 (GMT)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Ralf Baechle <ralf@linux-mips.org>
cc:	David Daney <ddaney@caviumnetworks.com>, linux-mips@linux-mips.org,
	Tomaso Paoletti <tpaoletti@caviumnetworks.com>,
	Paul Gortmaker <Paul.Gortmaker@windriver.com>
Subject: Re: [PATCH 02/36] Add Cavium OCTEON files to
 arch/mips/include/asm/mach-cavium-octeon
In-Reply-To: <20081028161757.GA349@linux-mips.org>
Message-ID: <alpine.LFD.1.10.0810281712410.27396@ftp.linux-mips.org>
References: <490655B6.4030406@caviumnetworks.com> <1225152181-3221-1-git-send-email-ddaney@caviumnetworks.com> <1225152181-3221-2-git-send-email-ddaney@caviumnetworks.com> <20081028075733.GB20858@linux-mips.org> <alpine.LFD.1.10.0810281600460.27396@ftp.linux-mips.org>
 <20081028161757.GA349@linux-mips.org>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21065
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, 28 Oct 2008, Ralf Baechle wrote:

> >  I have long had plans to lift this stupid assumption and if I finally 
> > lose my patience, I may even actually do it one day. ;)
> 
> If we're talking about actual ISA cards - I don't think we should even try
> to remove the restriction.  Interrupt numbers are printed on PCBs and
> the sysadmin has to jumper the bloody board so for sanity and consistency
> we rather stick to 0..15 for these systems.

 I have thought of some sort of a simple translation layer.  Module 
parameters, etc. would stay the same for sanity's sake if nothing else.  
Unsure about /proc/interrupts, but if drivers printed the translation at 
initialisation, that shouldn't be that much of a problem.

 I recall x86 maintainers contemplating a switch to the use of interrupt 
vectors as received by the CPU rather that the current interrrupt lines 
(which are often artificial anyway).  That would make the whole thing on 
that platform consistent with MSIs which do not have a "line" at all (how 
do *we* handle MSIs, BTW?).

 I do not think ISA deserves to be treated in a special way these days 
anymore.  It's merely yet another kind of a bus which may be buried in a 
system somewhere down there behind a number of bridges.  There may be more 
than one too -- think about that USB-to-ISA bridge someone used to sell. 
;)  I bet there is someone making PCI-to-ISA option cards these days too.

 Thus I am more and more convinced for the ISA interrupts to get "freed".  
Just not enough yet to find some time to actually do it. ;)

  Maciej

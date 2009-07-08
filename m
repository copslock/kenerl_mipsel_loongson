Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Jul 2009 21:11:08 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:49482 "EHLO
	localhost.localdomain" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S1493039AbZGHTLF (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 8 Jul 2009 21:11:05 +0200
Date:	Wed, 8 Jul 2009 20:11:05 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	David VomLehn <dvomlehn@cisco.com>
cc:	Ralf Baechle <ralf@linux-mips.org>, joe seb <joe.seb8@gmail.com>,
	linux-mips@linux-mips.org
Subject: Re: Linux port failing on MIPS32 24Kc
In-Reply-To: <20090708182500.GA31285@cuplxvomd02.corp.sa.net>
Message-ID: <alpine.LFD.2.00.0907081946240.13862@eddie.linux-mips.org>
References: <4f9abdc70907080107t28fdac03h86b834a60806fb10@mail.gmail.com> <20090708103756.GB22308@linux-mips.org> <20090708182500.GA31285@cuplxvomd02.corp.sa.net>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23684
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, 8 Jul 2009, David VomLehn wrote:

> > (Why do people use non-zero starting addresses for memory?  Handling of
> > cache error exceptions is hard enough as it is but with no memory in the
> > low 32k the design idea of the cache architecture that stores relative to
> > $zero can be used goes down the drain and (not considering platform-specific
> > solutions here) only be handled by burning the scarce resource of a TLB
> > entry for an extremly rare event ...)
> 
> (Because hardware people are, uh, insufficiently acquainted with the MIPS
> architecture and don't know what the conventions are. Or why they are that
> way. Then, you're stuck with that architecture forever. Sigh.)

 Many processor architectures have assumptions (i.e. power-up/reset 
defaults) about or even force the existence of RAM at physical address 0.  
With the MIPS architecture actually it has been pretty a recent addition 
in its long history that you are able to get away without.  Given these 
circumstances I am afraid your suspicion sounds like an understatement.

 With the MIPS64r2 architecture though and if you want more than 400+some 
MB of memory, placing RAM from the top of the physical address space seems 
more reasonable to me as you can avoid ROM popping up in the middle then.  

 For the sake of flexibility, including but not limited to ERL operation, 
the virtual-to-physical address translation for the CKSEG0 and CKSEG1 
space could be made configurable via an additional CP0 register.  I'm a 
little bit surprised nobody had thought about it at the time CP0.EBase was 
introduced.  The remapping has to be done anyway and it does not look to 
me as it would take a lot of power and/or silicon space to make it use a 
configurable set of latches rather than a predefined set of hardwired 
logical levels.

  Maciej

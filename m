Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Jul 2005 13:08:54 +0100 (BST)
Received: from mx01.qsc.de ([IPv6:::ffff:213.148.129.14]:690 "EHLO mx01.qsc.de")
	by linux-mips.org with ESMTP id <S8225275AbVGVMIe>;
	Fri, 22 Jul 2005 13:08:34 +0100
Received: from port-195-158-170-19.dynamic.qsc.de ([195.158.170.19] helo=hattusa.textio)
	by mx01.qsc.de with esmtp (Exim 3.35 #1)
	id 1DvwMJ-0007c2-00; Fri, 22 Jul 2005 14:10:31 +0200
Received: from ths by hattusa.textio with local (Exim 4.52)
	id 1DvwMI-0005VP-VY; Fri, 22 Jul 2005 14:10:30 +0200
Date:	Fri, 22 Jul 2005 14:10:30 +0200
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org
Subject: Re: CVS Update@linux-mips.org: linux
Message-ID: <20050722121030.GD1692@hattusa.textio>
References: <20050721153359Z8225218-3678+3745@linux-mips.org> <20050722043057.GA3803@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050722043057.GA3803@linux-mips.org>
User-Agent: Mutt/1.5.9i
From:	Thiemo Seufer <ths@networkno.de>
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8597
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:
> On Thu, Jul 21, 2005 at 04:33:53PM +0100, ths@linux-mips.org wrote:
> 
> > Modified files:
> > 	arch/mips/kernel: binfmt_elfo32.c 
> > 	include/asm-mips: elf.h 
> > 
> > Log message:
> > 	Fix ELF defines: EF_* is a field, E_* a distinct flag therein.
> 
> Remarkably bad idea after the old definitions are already being used since
> over a decade.

Well, kernel headers are less widely used than others, and everywhere
else it is E_*. Since
 - kernel headers in general aren't meant as an interface for userland,
 - the definition is inconsistent to the userland one,
 - the in-kernel use seems to be limited to the ELF binary object
   loader and probably third party modules loaders
I found moving to a consistent definition to be more useful than
keeping the old inconsistent one.


Thiemo

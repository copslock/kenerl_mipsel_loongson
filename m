Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Mar 2003 18:17:27 +0000 (GMT)
Received: from crack.them.org ([IPv6:::ffff:65.125.64.184]:38886 "EHLO
	crack.them.org") by linux-mips.org with ESMTP id <S8225203AbTCGSR1>;
	Fri, 7 Mar 2003 18:17:27 +0000
Received: from nevyn.them.org ([66.93.61.169] ident=mail)
	by crack.them.org with asmtp (Exim 3.12 #1 (Debian))
	id 18rOIe-0008RM-00; Fri, 07 Mar 2003 14:18:37 -0600
Received: from drow by nevyn.them.org with local (Exim 3.36 #1 (Debian))
	id 18rMPI-0001WF-00; Fri, 07 Mar 2003 13:17:20 -0500
Date: Fri, 7 Mar 2003 13:17:20 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: HG <henri@broadbandnetdevices.com>
Cc: linux-mips@linux-mips.org
Subject: Re: mips-linux-ld related question
Message-ID: <20030307181720.GA5795@nevyn.them.org>
References: <000f01c2e4c6$65818600$0400a8c0@amdk62400>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000f01c2e4c6$65818600$0400a8c0@amdk62400>
User-Agent: Mutt/1.5.1i
Return-Path: <drow@false.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1656
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@debian.org
Precedence: bulk
X-list: linux-mips

On Fri, Mar 07, 2003 at 11:25:14AM -0500, HG wrote:
> Hi All
> 
> I installed the binutils-mips-linux-2.13.1.i386.rpm and
> egcs-mips-linux-1.1.2-4.i386.rpm from the linux-mips ftp site on a caldera
> distribution 3.11 linux box to crosscompile a 2.4 kernel.
> no error message while compiling , i get the following error while linking :
>  mips-linux-ld: target elf32-bigmips not found
> 
> is there some env variable or path that I missed that needs to be set ????

Fix the kernel; if it references elf32-bigmips your source is too old. 
It should be tradbigmips with those tools.

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer

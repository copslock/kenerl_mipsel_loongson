Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Feb 2003 22:36:05 +0000 (GMT)
Received: from p508B5BA5.dip.t-dialin.net ([IPv6:::ffff:80.139.91.165]:39850
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225205AbTBNWgE>; Fri, 14 Feb 2003 22:36:04 +0000
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id h1EMZr601599;
	Fri, 14 Feb 2003 23:35:53 +0100
Date: Fri, 14 Feb 2003 23:35:53 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Mark and Janice Juszczec <juszczec@hotmail.com>
Cc: linux-mips@linux-mips.org
Subject: Re: R3000 stack docs
Message-ID: <20030214233553.B952@linux-mips.org>
References: <F103oqFXfyY0QUUBPcZ00009516@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <F103oqFXfyY0QUUBPcZ00009516@hotmail.com>; from juszczec@hotmail.com on Fri, Feb 14, 2003 at 07:23:02PM +0000
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1431
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Feb 14, 2003 at 07:23:02PM +0000, Mark and Janice Juszczec wrote:

> There is one in ftp://www.linux-mips.org/pub/linux/mips/doc/ABI/mipsabi.pdf
> 
> Does this refer to the stack the kernel loads in binfmt_elf.c and is it the 
> correct place to start?

The ABI only describes the stack frame used by functions and for their
arguments.  The arguments as passed to an invoked program are not subject
to the ABI documents though obviously the layout is choose such that it
can be passed to the program's main() without costly conversion.  I
therefore suggest you simply read binfmt_elf.c - that part is fairly
straight forward.

  Ralf

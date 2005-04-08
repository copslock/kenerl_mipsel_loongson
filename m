Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 Apr 2005 17:57:37 +0100 (BST)
Received: from nevyn.them.org ([IPv6:::ffff:66.93.172.17]:16027 "EHLO
	nevyn.them.org") by linux-mips.org with ESMTP id <S8225417AbVDHQ5X>;
	Fri, 8 Apr 2005 17:57:23 +0100
Received: from drow by nevyn.them.org with local (Exim 4.50 #1 (Debian))
	id 1DJwnF-00028l-PF; Fri, 08 Apr 2005 12:57:17 -0400
Date:	Fri, 8 Apr 2005 12:57:17 -0400
From:	Daniel Jacobowitz <dan@debian.org>
To:	Fabrizio Fazzino <fabrizio@fazzino.it>
Cc:	linux-mips@linux-mips.org
Subject: Re: Assembly macro with parameters
Message-ID: <20050408165717.GA8157@nevyn.them.org>
References: <425573AD.9010702@fazzino.it> <20050407182549.GA24235@linux-mips.org> <4256B5BE.8070708@fazzino.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4256B5BE.8070708@fazzino.it>
User-Agent: Mutt/1.5.8i
Return-Path: <drow@nevyn.them.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7656
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@debian.org
Precedence: bulk
X-list: linux-mips

On Fri, Apr 08, 2005 at 06:47:58PM +0200, Fabrizio Fazzino wrote:
> Ralf Baechle wrote:
> >Fabrizio Fazzino wrote:
> >
> >>It works, but I need a way to set the values of the parameters
> >>at runtime; so I've tried the following macro:
> >>
> >>	#define fzmin(rd, rs, rt) asm("lwc1 $rt, rd<<11($rs)");
> >
> >Which will leave the assembler entirely unimpressed ;-)
> 
> I thought that the compiler was able to substitute also the
> values inside strings... Is there any way to force it to do so?
> 
> >Unless you only have a few instructions and are going for a quick hack
> >I really suggest to add proper support for these instructions to binutils.
> >Having working support in as, gdb, objdump will make your life so much
> >easier.
> 
> The processor I'm designing probably will not be implemented in
> any way (we just have to simulate the VHDL hardware description),
> so we just need a quick-and-dirty way to make the opcode
> conversion.

You should probably be using .word then, and generating the instruction
completely by hand.

-- 
Daniel Jacobowitz
CodeSourcery, LLC

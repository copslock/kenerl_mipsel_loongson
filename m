Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 21 Apr 2003 14:19:32 +0100 (BST)
Received: from crack.them.org ([IPv6:::ffff:65.125.64.184]:17619 "EHLO
	crack.them.org") by linux-mips.org with ESMTP id <S8225073AbTDUNTb>;
	Mon, 21 Apr 2003 14:19:31 +0100
Received: from nevyn.them.org ([66.93.61.169] ident=mail)
	by crack.them.org with asmtp (Exim 3.12 #1 (Debian))
	id 197bCp-0002IW-00; Mon, 21 Apr 2003 08:19:35 -0500
Received: from drow by nevyn.them.org with local (Exim 3.36 #1 (Debian))
	id 197bCZ-0006wL-00; Mon, 21 Apr 2003 09:19:19 -0400
Date: Mon, 21 Apr 2003 09:19:19 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: Mike Connors <mike.connors@ghs.com>
Cc: linux-mips@linux-mips.org
Subject: Re: assembly debug question
Message-ID: <20030421131919.GA26660@nevyn.them.org>
References: <001d01c306d2$a55fbe80$7c70a8c0@NOMAD>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <001d01c306d2$a55fbe80$7c70a8c0@NOMAD>
User-Agent: Mutt/1.5.1i
Return-Path: <drow@false.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2118
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@debian.org
Precedence: bulk
X-list: linux-mips

On Sat, Apr 19, 2003 at 05:20:27PM -0700, Mike Connors wrote:
> Hi All, 
> 
> I'm using gcc v2.96 to compile a MIPS targeted Linux kernel 
> and am finding it difficult to produce debug information 
> for assembly files. 
> 
> I've discovered that a typical compile line for assembly 
> in the kernel gets its parameters from AFLAGS and results 
> in the following commandline: 
> 
> mipsel-linux-gcc -D__ASSEMBLY__ -D__KERNEL__ -I/l/include \
> 	-G 0 -mno-abicalls -fno-pic -mcpu=r4600 -mips2 \
> 	-Wa,--trap -pipe -c entry.S -o entry.o 
> 
> According to the documentation, some targets support 
> dwarf debug information using --gdwarf2.  Does anyone 
> know if the MIPS target is supported in version? 
> 
> Also, --gstabs doesn't seem to work either.  Nor does 
> -gdwarf-2, -gdwarf -g2, -gstabs+, -gdwarf+, etc. 
> 
> Has anyone had luck producing debug information for 
> assembly files with this version of gcc? 
> 
> ./mipsel-linux-gcc --version 
> 2.96 
> ./mipsel-linux-as --version 
> GNU assembler 2.11.92.0.10 

I think --gstabs is later than that version of binutils.  Also, I
didn't fix DWARF-2 for MIPS until well after those tools versions,
so I believe you won't be able to use that at all.

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer

Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 Aug 2003 00:15:29 +0100 (BST)
Received: from iris1.csv.ica.uni-stuttgart.de ([IPv6:::ffff:129.69.118.2]:44618
	"EHLO iris1.csv.ica.uni-stuttgart.de") by linux-mips.org with ESMTP
	id <S8225208AbTHGXPZ>; Fri, 8 Aug 2003 00:15:25 +0100
Received: from rembrandt.csv.ica.uni-stuttgart.de ([129.69.118.42])
	by iris1.csv.ica.uni-stuttgart.de with esmtp (Exim 3.35 #1)
	id 19ktyZ-0006lc-00; Fri, 08 Aug 2003 01:15:19 +0200
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.35 #1 (Debian))
	id 19ktyY-0007WH-00; Fri, 08 Aug 2003 01:15:18 +0200
Date: Fri, 8 Aug 2003 01:15:18 +0200
To: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc: linux-mips@linux-mips.org
Subject: Re: load/store address overflow on binutils 2.14
Message-ID: <20030807231518.GH3759@rembrandt.csv.ica.uni-stuttgart.de>
References: <20030807.190330.26271096.nemoto@toshiba-tops.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030807.190330.26271096.nemoto@toshiba-tops.co.jp>
User-Agent: Mutt/1.5.4i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Return-Path: <ica2_ts@csv.ica.uni-stuttgart.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3005
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ica2_ts@csv.ica.uni-stuttgart.de
Precedence: bulk
X-list: linux-mips

Atsushi Nemoto wrote:
> I'm trying binutils 2.14 (and binutils 2.14.90.0.5).  These versions
> can not compile this inctruction.
> 
> 	lw	$2, 0x80000000
> 
> $ mips-linux-gcc -c foo.s
> b.S: Assembler messages:
> foo.S:1: Error: load/store address overflow (max 32 bits)
> 
> Using such an immediate address for load instructions is legal?  I
> found the error message in tc-mips.c and it looks like something
> related to 64bit ABIs, but I just want to compile 32bit (standalone)
> program.
> 
> Is this code really needed for 32bit ABI?
> 
> binutils-2.14/gas/config/tc-mips.c:6297
>  	  else if (offset_expr.X_op == O_constant
>  		   && !HAVE_64BIT_ADDRESS_CONSTANTS
>  		   && !IS_SEXT_32BIT_NUM (offset_expr.X_add_number))
>  	    as_bad (_("load/store address overflow (max 32 bits)"));

It shouldn't trigger for 32bit, because 0x80000000 is a sign-extended
32bit number. How is mips-linux-as actually invoked?


Thiemo

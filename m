Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 10 May 2003 20:44:01 +0100 (BST)
Received: from crack.them.org ([IPv6:::ffff:146.82.138.56]:3310 "EHLO
	crack.them.org") by linux-mips.org with ESMTP id <S8225290AbTEJTn7>;
	Sat, 10 May 2003 20:43:59 +0100
Received: from nevyn.them.org ([66.93.61.169] ident=mail)
	by crack.them.org with asmtp (Exim 3.12 #1 (Debian))
	id 19EaGZ-0006P6-00; Sat, 10 May 2003 14:44:20 -0500
Received: from drow by nevyn.them.org with local (Exim 3.36 #1 (Debian))
	id 19EaG7-00048j-00; Sat, 10 May 2003 15:43:51 -0400
Date: Sat, 10 May 2003 15:43:51 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: menkuec@auto-intern.com
Cc: linux-mips@linux-mips.org
Subject: Re: compiling glibc
Message-ID: <20030510194351.GA15891@nevyn.them.org>
References: <200305092145.43690.benmen@gmx.de> <20030510042535.GA2336@nevyn.them.org> <200305101156.08254.benmen@gmx.de> <200305101321.21232.benmen@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200305101321.21232.benmen@gmx.de>
User-Agent: Mutt/1.5.1i
Return-Path: <drow@false.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2344
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@debian.org
Precedence: bulk
X-list: linux-mips

On Sat, May 10, 2003 at 01:21:21PM +0200, Benjamin Menküc wrote:
> Okay, I fixed this problem by adding --disable-profile:
> 
> [benmen@linuxpc1 mipsel-glibc] LD_LIBRARY_PATH="" CFLAGS="-O2 -g 
> -finline-limit=10000" CC="mipsel-linux-gcc" AS="mipsel-linux-as" 
> ../glibc-2.3.2/configure --build=i686-linux --host=mipsel-linux 
> --enable-add-ons --prefix=/home/benmen/mipsel 
> --with-headers=/home/benmen/mips/kernel/mips-2.4.20/include --disable-profile
> 
> ...
> 
> Now I can compile until this comes:

Try glibc from CVS instead of 2.3.2.  Known bug.

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer

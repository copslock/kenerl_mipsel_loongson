Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 25 Oct 2002 18:43:59 +0200 (CEST)
Received: from crack.them.org ([65.125.64.184]:19471 "EHLO crack.them.org")
	by linux-mips.org with ESMTP id <S1123253AbSJYQn6>;
	Fri, 25 Oct 2002 18:43:58 +0200
Received: from nevyn.them.org ([66.93.61.169] ident=mail)
	by crack.them.org with asmtp (Exim 3.12 #1 (Debian))
	id 1858UG-0002dB-00; Fri, 25 Oct 2002 12:43:09 -0500
Received: from drow by nevyn.them.org with local (Exim 3.36 #1 (Debian))
	id 1857Z4-0005n2-00; Fri, 25 Oct 2002 12:44:02 -0400
Date: Fri, 25 Oct 2002 12:44:02 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: "Steven J. Hill" <sjhill@realitydiluted.com>
Cc: linux-mips@linux-mips.org, binutils@sources.redhat.com
Subject: Re: Problems generating shared library for MIPS using binutils-2.13...
Message-ID: <20021025164402.GB6451@nevyn.them.org>
Mail-Followup-To: "Steven J. Hill" <sjhill@realitydiluted.com>,
	linux-mips@linux-mips.org, binutils@sources.redhat.com
References: <3DB97381.8070501@realitydiluted.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DB97381.8070501@realitydiluted.com>
User-Agent: Mutt/1.5.1i
Return-Path: <drow@false.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 509
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@debian.org
Precedence: bulk
X-list: linux-mips

On Fri, Oct 25, 2002 at 11:38:25AM -0500, Steven J. Hill wrote:
> Greetings.
> 
> I'm doing something stupid here, so please help me out. I am trying
> to create a shared library with gcc passing parameters to the linker
> and it is not working.
> 
> I compiled all the object files with '-mips2' and then I attempt to
> create the shared library with:
> 
>    mipsel-linux-gcc -shared -Wl,-Amips2,-soname,libz.so.1 \
>       -o libz.so.1.1.4 adler32.o compress.o crc32.o gzio.o \
>       uncompr.o deflate.o trees.o zutil.o inflate.o infblock.o \
>       inftrees.o infcodes.o infutil.o inffast.o
> 
> The object files are all mips2, but the generated '.so' object
> is mips1?! What am I not understanding? I am using binutils-2.13,
> gcc-3.2 and uClibc-0.9.15. The use of uClibc is not the problem.

More information:

Add -Wl,-v and give us the linker command line.

Is every object or library mentioned on that line already marked as
MIPS-2 by readelf?  Even crt*, libc*?

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer

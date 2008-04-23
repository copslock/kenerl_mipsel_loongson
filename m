Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Apr 2008 23:32:08 +0100 (BST)
Received: from kirk.serum.com.pl ([213.77.9.205]:21755 "EHLO serum.com.pl")
	by ftp.linux-mips.org with ESMTP id S20032688AbYDWWcG (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 23 Apr 2008 23:32:06 +0100
Received: from serum.com.pl (IDENT:macro@localhost [127.0.0.1])
	by serum.com.pl (8.12.11/8.12.11) with ESMTP id m3NMW3XN002360;
	Thu, 24 Apr 2008 00:32:03 +0200
Received: from localhost (macro@localhost)
	by serum.com.pl (8.12.11/8.12.11/Submit) with ESMTP id m3NMVnO8002356;
	Wed, 23 Apr 2008 23:31:58 +0100
Date:	Wed, 23 Apr 2008 23:31:48 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Dmitri Vorobiev <dmitri.vorobiev@gmail.com>
cc:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>, yoichi_yuasa@tripeaks.co.jp,
	ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: [PATCH 2/2] [MIPS] add DECstation DS1287 clockevent
In-Reply-To: <480F83A6.50308@gmail.com>
Message-ID: <Pine.LNX.4.55.0804232245580.31934@cliff.in.clinika.pl>
References: <20080423085140.a693b2e5.yoichi_yuasa@tripeaks.co.jp>
 <200804222353.m3MNr8m4025538@po-mbox303.hop.2iij.net>
 <20080423.115528.59033169.nemoto@toshiba-tops.co.jp> <480F83A6.50308@gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19008
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, 23 Apr 2008, Dmitri Vorobiev wrote:

> After I had saved a DECstation 5000/200 from a junkyard a few years
> ago (very neat hardware, actually), I did some research on this brand.
> AFAICT, all MIPS-based DECstation models were UP.

 As were all the TURBOchannel Alpha machines which may eventually reuse 
many bits of code.  That does not mean code should not be written in a 
clean and portable way and all the associated atomic operations and 
spinlock types will be optimised away when built for UP.

 BTW, DEC actually used to manufacture a MIPS-based line of SMP computers.  
It was called DECsystem 5800 and supported up to four CPU boards.  
Similarly to the DECsystem 5400 and 5500 computers the design was based
around an existing VAX cabinet with the CPU cards using MIPS R3000
processors rather than VAX ones.

 As a curiosity the systems included a low-end VAX processor as well, as a
service unit for the purpose of console diagnostics and system bootstrap.  
The main CPU would be kept frozen until an OS was loaded at which point
the MIPS unit would get unlocked and start executing while the service
procesor would get halted.  AFAIK, the operation was controlled by some
external register and was atomic, never allowing the two processors to run
simultaneously.  Conceptually it was similar to how the original
VAX-11/780 and its console operated.

 We will probably never support any of these systems as getting these
pieces of hardware is problematic and then you need to use a lorry to move
them around.  Support for SMP operation of the 5800 would be particularly
tricky, because, as we all know too well, ;) the R3000 did not support
atomic operations and bus lock logic for atomic RMW cycles was provided by
the chipset.  All the relevant bits of code would have to be modified to
make use of it.  I am told NetBSD folks have had some success with one of
the machines; the 5500, I think.

 These DECsystem computers were designed by a different group to one which
did all the DECstations (WSE).  The same group also designed a small box
called DECsystem 5100 which was also similar to a VAX computer.  We have
some initial support for this machine implemented and if I got my hands on
an actual piece of hardware, I might consider getting it into a better
state.  Chances are our code as it is would crash on this system
immediately ;) -- otherwise the only supported peripheral might be the
serial port.

  Maciej

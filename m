Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Sep 2002 15:29:29 +0200 (CEST)
Received: from crack.them.org ([65.125.64.184]:2066 "EHLO crack.them.org")
	by linux-mips.org with ESMTP id <S1122958AbSIEN32>;
	Thu, 5 Sep 2002 15:29:28 +0200
Received: from nevyn.them.org ([66.93.61.169] ident=mail)
	by crack.them.org with asmtp (Exim 3.12 #1 (Debian))
	id 17mxdP-00031W-00; Thu, 05 Sep 2002 09:29:27 -0500
Received: from drow by nevyn.them.org with local (Exim 3.35 #1 (Debian))
	id 17mwhB-0003eS-00; Thu, 05 Sep 2002 09:29:17 -0400
Date: Thu, 5 Sep 2002 09:29:17 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: Carsten Lange <Carsten.Lange@detewe.de>
Cc: linux-mips@linux-mips.org
Subject: Re: gdbserver (gdb 5.2) with thread supprt
Message-ID: <20020905132917.GA13975@nevyn.them.org>
References: <3D76FEE7.D1DA2D99@detewe.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D76FEE7.D1DA2D99@detewe.de>
User-Agent: Mutt/1.5.1i
Return-Path: <drow@false.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 107
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@debian.org
Precedence: bulk
X-list: linux-mips

On Thu, Sep 05, 2002 at 08:51:19AM +0200, Carsten Lange wrote:
> Hi,
> 
> gdbserver from gdb 5.2 does not work for applications using threads, for others it
> works fine.
> 
> I wonder whether gdbserver supports threads and what I have to do to set it up
> (e.g where to get the
> patch)?
> 
> Any hints?

GDB CVS repository, of course.  I added thread support in June.  It
will be in 5.3, and 5.3 snapshots should start showing up on
sources.redhat.com/pub/gdb/ tomorrow.

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer

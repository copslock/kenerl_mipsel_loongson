Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 Sep 2002 16:18:51 +0200 (CEST)
Received: from crack.them.org ([65.125.64.184]:26886 "EHLO crack.them.org")
	by linux-mips.org with ESMTP id <S1122961AbSIMOSv>;
	Fri, 13 Sep 2002 16:18:51 +0200
Received: from nevyn.them.org ([66.93.61.169] ident=mail)
	by crack.them.org with asmtp (Exim 3.12 #1 (Debian))
	id 17psDB-0001te-00; Fri, 13 Sep 2002 10:18:25 -0500
Received: from drow by nevyn.them.org with local (Exim 3.35 #1 (Debian))
	id 17prHM-0003AY-00; Fri, 13 Sep 2002 10:18:40 -0400
Date: Fri, 13 Sep 2002 10:18:40 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: Gareth <g.c.bransby-99@student.lboro.ac.uk>
Cc: linux-mips@linux-mips.org
Subject: Re: Instruction tracing
Message-ID: <20020913141840.GA12165@nevyn.them.org>
References: <20020913151236.45429b74.g.c.bransby-99@student.lboro.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020913151236.45429b74.g.c.bransby-99@student.lboro.ac.uk>
User-Agent: Mutt/1.5.1i
Return-Path: <drow@false.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 176
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@debian.org
Precedence: bulk
X-list: linux-mips

On Fri, Sep 13, 2002 at 03:12:36PM +0100, Gareth wrote:
> Hello,
> 
> I am trying to debug a program running on a mips malta dev board (no operating
> system). I am using gdb running on a linux pc connected to the board via
> serial and the board is running YAMON gdb. I can step through the code, set
> break points, examine memory and variables etc, but what I would really like 
> to do is get an instruction trace of the program. 
> 
> Any help greatly appreciated.

Sorry, but I don't believe GDB supports this.  Some simulators or
probes may support it directly but core GDB really can't do anything
about it.

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer

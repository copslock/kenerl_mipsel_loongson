Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Feb 2006 21:24:17 +0000 (GMT)
Received: from nevyn.them.org ([66.93.172.17]:25507 "EHLO nevyn.them.org")
	by ftp.linux-mips.org with ESMTP id S8133474AbWBWVYJ (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 23 Feb 2006 21:24:09 +0000
Received: from drow by nevyn.them.org with local (Exim 4.54)
	id 1FCO3Y-0000xE-6t; Thu, 23 Feb 2006 16:31:24 -0500
Date:	Thu, 23 Feb 2006 16:31:24 -0500
From:	Daniel Jacobowitz <dan@debian.org>
To:	Pete Popov <ppopov@embeddedalley.com>
Cc:	"'linux-mips@linux-mips.org'" <linux-mips@linux-mips.org>
Subject: Re: gdb/kgdb register mismatch
Message-ID: <20060223213124.GA3638@nevyn.them.org>
References: <1140723606.11388.321.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1140723606.11388.321.camel@localhost.localdomain>
User-Agent: Mutt/1.5.8i
Return-Path: <drow@nevyn.them.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10627
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@debian.org
Precedence: bulk
X-list: linux-mips

On Thu, Feb 23, 2006 at 11:40:06AM -0800, Pete Popov wrote:
> 
> I'm having the following problems with gdb/kgdb:
> 
> 64bit CPU, running a 32 bit kernel. When I break at a certain point, I
> can see that the kernel kgdb stub appears to be sending the correct
> register information, where each reg value written in the kgdb packet is
> 32bit. However, the cross gdb client seems to be interpreting, or
> expecting, 64bit register values so it 'skips' over every other value.
> For example:
> 
> reg values sent by kgdb:      reg values shown by gdb client:
> reg 0:  0x00000000            reg0:  0x00000001
> reg 1:  0x00000001            reg1:  0x00000002
> reg 2:  0x00000002            reg2:  0x00000004
> reg 3:  0x00000003
> reg 4:  0x00000004
> 
> Should the kgdb stub be sending 64bit values for the registers, even
> though it's a 32bit kernel?  If the stub is supposed to be sending 32bit
> register values, any suggestion why cross gdb is not interpreting them
> correctly?

This is a FAQ; it's a bug in GDB that will be fixed someday, but for
now use "set architecture mips:isa32".

-- 
Daniel Jacobowitz
CodeSourcery

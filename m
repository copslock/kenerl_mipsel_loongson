Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Mar 2003 13:26:14 +0000 (GMT)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:41712 "EHLO
	av.mvista.com") by linux-mips.org with ESMTP id <S8225204AbTCGN0O>;
	Fri, 7 Mar 2003 13:26:14 +0000
Received: from zeus.mvista.com (av [127.0.0.1])
	by av.mvista.com (8.9.3/8.9.3) with ESMTP id FAA06116;
	Fri, 7 Mar 2003 05:26:10 -0800
Subject: Re: Kernel Debugging on the DBAu1500
From: Pete Popov <ppopov@mvista.com>
To: baitisj@evolution.com
Cc: linux-mips@linux-mips.org
In-Reply-To: <1047043427.30914.432.camel@zeus.mvista.com>
References: <20030306185345.W20129@luca.pas.lab>
	 <1047043427.30914.432.camel@zeus.mvista.com>
Content-Type: text/plain
Organization: MontaVista Software
Message-Id: <1047043677.6389.436.camel@zeus.mvista.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 07 Mar 2003 05:27:58 -0800
Content-Transfer-Encoding: 7bit
Return-Path: <ppopov@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1649
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@mvista.com
Precedence: bulk
X-list: linux-mips

On Fri, 2003-03-07 at 05:23, Pete Popov wrote:
> Jeff,
> 
> Take a look at the board and remind me if the second serial port is
> actually uart2, where the first is uart0. 

Sorry, I meant uart3, which would be a reason why the UART2_ADDR define
below wouldn't work.

Pete

> I think it might be. If that's
> the case, arch/mips/au1000/common/dbg_io.c has this define if kgdb is
> defined:
> 
> #define DEBUG_BASE  UART2_ADDR
> 
> That needs to get fixed. It would be better to parse the command line
> for something like "kgdb=ttyS2,115200".
> 
> Pete
> 
> On Thu, 2003-03-06 at 18:53, Jeff Baitis wrote:
> > Hi all:
> > 
> > I've been trying to get a kernel debugger running on my AMD DBAu1500.  It boots
> > up over a serial console. I enable "Remote GDB kernel debugging," and "Console
> > output to GDB."
> > 
> > Here's what I tell YAMON to do:
> > 
> >     go . gdb gdbttyS=0 gdbbaud=115200
> > 
> > And on my x86 machine, I:
> > 
> >     stty ispeed 115200 ospeed 115200 < /dev/ttyS1
> > 
> >     /opt/hardhat/devkit/mips/fp_le/bin/mips_fp_le-gdb vmlinux
> >     (gdb) target remote /dev/ttyS1 
> > 
> > GDB seems not to communicate. Here's what it says:
> > 
> >     Ignoring packet error, continuing...
> >     Ignoring packet error, continuing...
> >     Ignoring packet error, continuing...
> >     Couldn't establish connection to remote target
> >     Malformed response to offset query, timeout
> > 
> > Suggestions?
> > 
> > Thanks in advance!
> > 
> > -Jeff
> 
> 
> 

Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 08 Nov 2004 14:40:16 +0000 (GMT)
Received: from nevyn.them.org ([IPv6:::ffff:66.93.172.17]:29359 "EHLO
	nevyn.them.org") by linux-mips.org with ESMTP id <S8225287AbUKHOkL>;
	Mon, 8 Nov 2004 14:40:11 +0000
Received: from drow by nevyn.them.org with local (Exim 4.34 #1 (Debian))
	id 1CRAgb-0006DX-Vv; Mon, 08 Nov 2004 09:40:02 -0500
Date: Mon, 8 Nov 2004 09:40:01 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: Yoni Rabinovitch <Yoni.Rabinovich@Teledata-Networks.com>
Cc: linux-mips@linux-mips.org
Subject: Re: Problems debugging multithreaded program wirh gdbserver via serial port
Message-ID: <20041108144001.GA23783@nevyn.them.org>
References: <D6FAAE89E48C5B488B41BEBBDCD746CD09E7CE@tndcmail.Teledata.Local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D6FAAE89E48C5B488B41BEBBDCD746CD09E7CE@tndcmail.Teledata.Local>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Return-Path: <drow@nevyn.them.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6275
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@debian.org
Precedence: bulk
X-list: linux-mips

On Mon, Nov 08, 2004 at 04:11:32PM +0200, Yoni Rabinovitch wrote:
> Hi,
> 
>   I am trying to debug a multithreaded program running on an embedded MIPS 5Kc using gdb and gdbserver, connected via
> a serial port.
> 
>   My environment is as follows:
> 
>   MIPS kernel based on 2.4.18
>   gdb :  6.2.1, configured with --host=i686-pc-linux-gnu --target=mips-hardhat-linux --disable-sim --disable-tcl --enable-threads --enable-shared
>   gdbserver: 6.2.1, configured with --target=mips-linux --enable-threads --enable-shared
>   gcc : 3.2.3,     }
>   binutils : 2.13  }   Built using crosstool
>   glibc: 2.2.5      }
> 
>   My problems are as follows:
> 
> 1)  If I try to run the program from gdbserver (i.e. gdbserver /dev/ttyS0 wlsd), I get "readchar: Input/output error" messages,
> and nothing works. See attached file gdb_fail.
> What is going on here ?

It sounds like your serial port is messed up.

> 2) If I first run the program, and then attach gdbserver to it (i.e. gdbserver /dev/ttyS0 --attach 80), I can debug it. 
> However, debugging is amazingly slow !! 
> For example, it can take 10 minutes for the "backtrace" (bt) command to complete !!! 
> Also, I get messages saying "Cannot access memory at address 0x2c" whnever I try to look at the stack.
> See attached file gdb_trace.
> Why is it going so slow ?
> What is the cause of the "Cannot access memory at address 0x2c"  messages ?

GDB is confused by glibc's syscall stubs.  In general, don't worry
about errors at the end of backtraces.

> 3) If I repeat the scenario described in 2), but with "set debug remote 1", it seems to work somewhat faster
> (e.g. bt takes about 1 minute to complete).
> I am seeing alot of "Packet instead of Ack, ignoring it" messages.
> See attached file gdb_trace_debug.
> What do these messages mean ? 

Try "set debug serial 1" in addition - it's very verbose but maybe it
will tell you what the "packet" is.

-- 
Daniel Jacobowitz

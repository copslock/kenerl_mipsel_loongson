Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 08 Dec 2003 03:10:45 +0000 (GMT)
Received: from nevyn.them.org ([IPv6:::ffff:66.93.172.17]:39837 "EHLO
	nevyn.them.org") by linux-mips.org with ESMTP id <S8225205AbTLHDKo>;
	Mon, 8 Dec 2003 03:10:44 +0000
Received: from drow by nevyn.them.org with local (Exim 4.24 #1 (Debian))
	id 1ATBnD-0004gT-Qa; Sun, 07 Dec 2003 22:10:39 -0500
Date: Sun, 7 Dec 2003 22:10:39 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: Mark and Janice Juszczec <juszczec@hotmail.com>
Cc: linux-mips@linux-mips.org
Subject: Re: cross debugging r3912 cpu with gdb
Message-ID: <20031208031039.GA17991@nevyn.them.org>
References: <Law10-F80XN3su1U6s400015b8a@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Law10-F80XN3su1U6s400015b8a@hotmail.com>
User-Agent: Mutt/1.5.1i
Return-Path: <drow@crack.them.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3709
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@debian.org
Precedence: bulk
X-list: linux-mips

On Mon, Dec 08, 2003 at 12:02:14AM +0000, Mark and Janice Juszczec wrote:
> 
> Daniel
> 
> you wrote:
> >
> >You left out lots of details.
> >
> 
>  Oops.  My bad.
> 
> >What operating system is the r3900 running?
> 
>  Yes its linux.  kernel v2.4.0-test1-acc22
> 
> >From the list name, I assume it's Linux/MIPS.  So why did you configure 
> >for mips-idt-ecoff?
> >
>  Hmmmmm.  Good question.  The gdb docs say I have to if I want to use the 
> MIPS remote debugging protocol.
> 
>  I did try --target=mipsel-elf-linux and --target-mipsel-linux.  I got the 
> following targets:
> 
> (gdb) help target
> Connect to a target machine or process.
> The first argument is the type or protocol of the target machine.
> Remaining arguments are interpreted by the target protocol.  For more
> information on the arguments for a particular protocol, type
> `help target ' followed by the protocol name.
> 
> List of target subcommands:
> 
> target async -- Use a remote computer via a serial line
> target cisco -- Use a remote machine via TCP
> target core -- Use a core file as a target
> target exec -- Use an executable file as a target
> target extended-async -- Use a remote computer via a serial line
> target extended-remote -- Use a remote computer via a serial line
> target remote -- Use a remote computer via a serial line
> target sim -- Use the compiled-in simulator
> 
>  I figured mips should show up, so I guessed they were incorrect.  Even so, 
> I tried connecting with both and got the same results:
> 
> (gdb) target async /dev/ttyUSB0
> Remote debugging using /dev/ttyUSB0
> Sending packet: $Hc-1#09...Sending packet: $Hc-1#09...Sending packet: 
> $Hc-1#09...Sending packet: $Hc-1#09...Timed out.
> Timed out.
> Timed out.
> Ignoring packet error, continuing...
> Sending packet: $qC#b4...Sending packet: $qC#b4...Sending packet: 
> $qC#b4...Sending packet: $qC#b4...Timed out.
> Timed out.
> Timed out.
> Ignoring packet error, continuing...
> Sending packet: $qOffsets#4b...Sending packet: $qOffsets#4b...Sending 
> packet: $qOffsets#4b...Sending packet: $qOffsets#4b...Timed out.
> Timed out.
> Timed out.
> Ignoring packet error, continuing...
> Couldn't establish connection to remote target
> Malformed response to offset query, timeout
> 
>  Any idea what that all means?
> 
> >If you're using gdbserver, then you want target=mips-linux and "target
> >remote", not "target mips".
> >
> 
>  I'm not using gdbserver.  It won't fit on my pda if I include kaffe and 
> its associated files.

Then what ARE you using on the target?

You have to connect to some particular debug stub.  That determines
what protocol to use.

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer

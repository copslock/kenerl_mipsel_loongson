Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 08 Dec 2003 00:02:39 +0000 (GMT)
Received: from law10-f8.law10.hotmail.com ([IPv6:::ffff:64.4.15.8]:37643 "EHLO
	hotmail.com") by linux-mips.org with ESMTP id <S8225346AbTLHACY>;
	Mon, 8 Dec 2003 00:02:24 +0000
Received: from mail pickup service by hotmail.com with Microsoft SMTPSVC;
	 Sun, 7 Dec 2003 16:02:14 -0800
Received: from 24.209.41.112 by lw10fd.law10.hotmail.msn.com with HTTP;
	Mon, 08 Dec 2003 00:02:14 GMT
X-Originating-IP: [24.209.41.112]
X-Originating-Email: [juszczec@hotmail.com]
X-Sender: juszczec@hotmail.com
From: "Mark and Janice Juszczec" <juszczec@hotmail.com>
To: dan@debian.org
Cc: linux-mips@linux-mips.org
Subject: Re: cross debugging r3912 cpu with gdb
Date: Mon, 08 Dec 2003 00:02:14 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <Law10-F80XN3su1U6s400015b8a@hotmail.com>
X-OriginalArrivalTime: 08 Dec 2003 00:02:14.0621 (UTC) FILETIME=[894588D0:01C3BD1E]
Return-Path: <juszczec@hotmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3708
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: juszczec@hotmail.com
Precedence: bulk
X-list: linux-mips


Daniel

you wrote:
>
>You left out lots of details.
>

  Oops.  My bad.

>What operating system is the r3900 running?

  Yes its linux.  kernel v2.4.0-test1-acc22

>From the list name, I assume it's Linux/MIPS.  So why did you configure for 
>mips-idt-ecoff?
>
  Hmmmmm.  Good question.  The gdb docs say I have to if I want to use the 
MIPS remote debugging protocol.

  I did try --target=mipsel-elf-linux and --target-mipsel-linux.  I got the 
following targets:

(gdb) help target
Connect to a target machine or process.
The first argument is the type or protocol of the target machine.
Remaining arguments are interpreted by the target protocol.  For more
information on the arguments for a particular protocol, type
`help target ' followed by the protocol name.

List of target subcommands:

target async -- Use a remote computer via a serial line
target cisco -- Use a remote machine via TCP
target core -- Use a core file as a target
target exec -- Use an executable file as a target
target extended-async -- Use a remote computer via a serial line
target extended-remote -- Use a remote computer via a serial line
target remote -- Use a remote computer via a serial line
target sim -- Use the compiled-in simulator

  I figured mips should show up, so I guessed they were incorrect.  Even so, 
I tried connecting with both and got the same results:

(gdb) target async /dev/ttyUSB0
Remote debugging using /dev/ttyUSB0
Sending packet: $Hc-1#09...Sending packet: $Hc-1#09...Sending packet: 
$Hc-1#09...Sending packet: $Hc-1#09...Timed out.
Timed out.
Timed out.
Ignoring packet error, continuing...
Sending packet: $qC#b4...Sending packet: $qC#b4...Sending packet: 
$qC#b4...Sending packet: $qC#b4...Timed out.
Timed out.
Timed out.
Ignoring packet error, continuing...
Sending packet: $qOffsets#4b...Sending packet: $qOffsets#4b...Sending 
packet: $qOffsets#4b...Sending packet: $qOffsets#4b...Timed out.
Timed out.
Timed out.
Ignoring packet error, continuing...
Couldn't establish connection to remote target
Malformed response to offset query, timeout

  Any idea what that all means?

>If you're using gdbserver, then you want target=mips-linux and "target
>remote", not "target mips".
>

  I'm not using gdbserver.  It won't fit on my pda if I include kaffe and 
its associated files.

  Mark

_________________________________________________________________
Take advantage of our best MSN Dial-up offer of the year — six months 
@$9.95/month. Sign up now! http://join.msn.com/?page=dept/dialup

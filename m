Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Mar 2003 12:03:16 +0000 (GMT)
Received: from cm19173.red.mundo-r.com ([IPv6:::ffff:213.60.19.173]:19980 "EHLO
	trasno.mitica") by linux-mips.org with ESMTP id <S8225204AbTCGMDP>;
	Fri, 7 Mar 2003 12:03:15 +0000
Received: by trasno.mitica (Postfix, from userid 1001)
	id 8A69A7BC; Fri,  7 Mar 2003 13:02:52 +0100 (CET)
To: baitisj@evolution.com
Cc: linux-mips@linux-mips.org
Subject: Re: Kernel Debugging on the DBAu1500
X-Url: http://people.mandrakesoft.com/~quintela
From: Juan Quintela <quintela@mandrakesoft.com>
In-Reply-To: <20030306185345.W20129@luca.pas.lab> (Jeff Baitis's message of
 "Thu, 6 Mar 2003 18:53:45 -0800")
References: <20030306185345.W20129@luca.pas.lab>
Date: Fri, 07 Mar 2003 13:02:52 +0100
Message-ID: <86y93rpeoj.fsf@trasno.mitica>
User-Agent: Gnus/5.090015 (Oort Gnus v0.15) Emacs/21.2.93
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <quintela@mandrakesoft.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1644
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: quintela@mandrakesoft.com
Precedence: bulk
X-list: linux-mips

>>>>> "jeff" == Jeff Baitis <baitisj@evolution.com> writes:

Hi
        perhaps don't help, but try using 57600 bauds.  Some
        chipsets don't like 115200 bauds.

I have never used gdb on MIPS, but at least on intel, you need run a
program in your MIPS board (in intel it is gdbstart called).

Later, Juan.

jeff> Hi all:
jeff> I've been trying to get a kernel debugger running on my AMD DBAu1500.  It boots
jeff> up over a serial console. I enable "Remote GDB kernel debugging," and "Console
jeff> output to GDB."

jeff> Here's what I tell YAMON to do:

jeff> go . gdb gdbttyS=0 gdbbaud=115200

jeff> And on my x86 machine, I:

jeff> stty ispeed 115200 ospeed 115200 < /dev/ttyS1

jeff> /opt/hardhat/devkit/mips/fp_le/bin/mips_fp_le-gdb vmlinux
jeff> (gdb) target remote /dev/ttyS1 

jeff> GDB seems not to communicate. Here's what it says:

jeff> Ignoring packet error, continuing...
jeff> Ignoring packet error, continuing...
jeff> Ignoring packet error, continuing...
jeff> Couldn't establish connection to remote target
jeff> Malformed response to offset query, timeout

jeff> Suggestions?

jeff> Thanks in advance!




-- 
In theory, practice and theory are the same, but in practice they 
are different -- Larry McVoy

Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Oct 2003 23:46:46 +0000 (GMT)
Received: from avtrex.com ([IPv6:::ffff:216.102.217.178]:24810 "EHLO
	avtrex.com") by linux-mips.org with ESMTP id <S8225447AbTJ1Xqn>;
	Tue, 28 Oct 2003 23:46:43 +0000
Received: from avtrex.com ([192.168.0.111] RDNS failed) by avtrex.com with Microsoft SMTPSVC(5.0.2195.6713);
	 Tue, 28 Oct 2003 15:46:40 -0800
Message-ID: <3F9EFFDF.7070205@avtrex.com>
Date: Tue, 28 Oct 2003 15:46:39 -0800
From: David Daney <ddaney@avtrex.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021130
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-mips@linux-mips.org
Subject: Help needed WRT GDB and multithreaded programs.
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 28 Oct 2003 23:46:40.0137 (UTC) FILETIME=[BBC09790:01C39DAD]
Return-Path: <ddaney@avtrex.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3543
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@avtrex.com
Precedence: bulk
X-list: linux-mips

A question about debugging user space programs on a mips/linux system:

I'm fairly sure that this problem has been encountered before and hope 
someone can help me solve it.

I am running linux 2.4.18 on a MIPS 4Kc core with all tools configured 
as mipsel-linux, with glibc-2.2.4 and the corresponding version of pthreads.

When using GDB 5.3 I get strange errors and am basically not able to 
debug multi-threaded programs.  For example any java program compiled 
with GCC/GCJ runs in multiple threads and does something like this:

# gdb PR218
GNU gdb 5.3
Copyright 2002 Free Software Foundation, Inc.
GDB is free software, covered by the GNU General Public License, and you are
welcome to change it and/or distribute copies of it under certain 
conditions.
Type "show copying" to see the conditions.
There is absolutely no warranty for GDB.  Type "show warranty" for details.
This GDB was configured as "mipsel-linux"...
(gdb) b main
Breakpoint 1 at 0x400dec: file /tmp/ccr0H72i.i, line 10.
(gdb) c
The program is not being run.
(gdb) run
Starting program: /junk/PR218
[New Thread 1024 (LWP 103)]

Program received signal SIGTRAP, Trace/breakpoint trap.
[Switching to Thread 1024 (LWP 103)]
0x00000000 in ?? ()
(gdb)


At this point no further debugging is possible.

If I attach to a particular thread after the program is started I can do 
some debugging, but that is inferior to having it work properly.

Q:  Has anyone else seen this type of behavior from GDB?

Q:  What is the solution?

Thanks in advance
David Daney.

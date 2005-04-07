Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Apr 2005 18:58:18 +0100 (BST)
Received: from mail.timesys.com ([IPv6:::ffff:65.117.135.102]:36563 "EHLO
	exchange.timesys.com") by linux-mips.org with ESMTP
	id <S8225281AbVDGR6D>; Thu, 7 Apr 2005 18:58:03 +0100
Received: from [192.168.2.27] ([192.168.2.27]) by exchange.timesys.com with Microsoft SMTPSVC(5.0.2195.6713);
	 Thu, 7 Apr 2005 13:53:51 -0400
Message-ID: <425574A8.4030605@timesys.com>
Date:	Thu, 07 Apr 2005 13:58:00 -0400
From:	Greg Weeks <greg.weeks@timesys.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Brian Kuschak <bkuschak@yahoo.com>
CC:	linux-mips@linux-mips.org
Subject: Re: gdb backtrace with core files
References: <20050407174454.77209.qmail@web40909.mail.yahoo.com>
In-Reply-To: <20050407174454.77209.qmail@web40909.mail.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 07 Apr 2005 17:53:51.0093 (UTC) FILETIME=[C1B71250:01C53B9A]
Return-Path: <greg.weeks@timesys.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7637
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: greg.weeks@timesys.com
Precedence: bulk
X-list: linux-mips

Brian Kuschak wrote:

>Is anyone succesfully using gdb for mipsel to debug
>core dumps?  If so, can you share your secrets for
>success?  I tried various recent versions (6.3,
>6.1.1), but backtrace never works right, even though
>the stack pointer appears to be valid.  gdb-5.3
>partially works, but not completely.  
>
>Forcing gdb to use a specific stack pointer and PC
>(frame <sp> <pc>) doesn't seem to help either.  
>
>Using linux 2.4.25 and gcc 3.3.3.
>
>  
>
It appears to work for me. My gdb has a ton of patches from Amit Kale 
though. The kernel is the latest malta with a couple of patches that 
shouldn't affect gdb.

-bash-2.05b# gdb
GNU gdb TimeSys Linux (6.2.1-1rh)
Copyright 2004 Free Software Foundation, Inc.
GDB is free software, covered by the GNU General Public License, and you are
welcome to change it and/or distribute copies of it under certain 
conditions.
Type "show copying" to see the conditions.
There is absolutely no warranty for GDB.  Type "show warranty" for details.
This GDB was configured as "mipsel-linux".
(gdb) file gdb_core_tester
Reading symbols from 
/root/TestWare/TTS_2.4.2/command/gdb_man/gdb_core_tester...done.
Using host libthread_db library "/lib/libthread_db.so.1".
(gdb) core-file core.2045
Core was generated by `./gdb_core_tester'.
Program terminated with signal 11, Segmentation fault.
Reading symbols from /usr/lib/libgcc_s.so.1...done.
Loaded symbols for /usr/lib/libgcc_s.so.1
Reading symbols from /lib/libc.so.6...done.
Loaded symbols for /lib/libc.so.6
Reading symbols from /lib/ld.so.1...done.
Loaded symbols for /lib/ld.so.1
#0  0x00400f48 in add_node (rootptr=0x1000105c, nodeval=193)
    at create_core.c:75
75              if(node_ptr->value.value >= nodeval) {
(gdb) bt
#0  0x00400f48 in add_node (rootptr=0x1000105c, nodeval=193)
    at create_core.c:75
#1  0x00400fcc in add_node (rootptr=0x10001048, nodeval=193)
    at create_core.c:81
#2  0x00400f74 in add_node (rootptr=0x10000140, nodeval=193)
    at create_core.c:76
#3  0x00400df8 in create_tree (rootptr=0x10000140) at create_core.c:38
#4  0x00400b4c in main (argc=1, argv=0x7f931b44) at main.c:25

Greg Weeks

Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 Sep 2002 12:07:36 +0200 (CEST)
Received: from [212.74.13.151] ([212.74.13.151]:8432 "EHLO dell.zee2.com")
	by linux-mips.org with ESMTP id <S1122961AbSIMKHg>;
	Fri, 13 Sep 2002 12:07:36 +0200
Received: from zee2.com (localhost [127.0.0.1])
	by dell.zee2.com (8.11.6/8.11.6) with ESMTP id g8DA7GC10963
	for <linux-mips@linux-mips.org>; Fri, 13 Sep 2002 11:07:23 +0100
Message-ID: <3D81B8D3.1609CD69@zee2.com>
Date: Fri, 13 Sep 2002 11:07:15 +0100
From: Stuart Hughes <seh@zee2.com>
Organization: Zee2 Ltd
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux-MIPS <linux-mips@linux-mips.org>
Subject: cannot debug multi-threaded programs with gdb
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <seh@zee2.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 170
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: seh@zee2.com
Precedence: bulk
X-list: linux-mips

Hi,

I've been trying to debug a simple multi-threaded test program using
gdb, and it always fails as follows:

[New Thread 1024 (LWP
39)]                                                      
                                                                                
Program received signal SIGTRAP, Trace/breakpoint
trap.                         
[Switching to Thread 1024 (LWP
39)]                                             
warning: Warning: GDB can't find the start of the function at
0xffffffff.       

I've tried various different compilers, gdb, glibc version but the
problem is the same.  Note that I can debug non-threaded c/c++ programs
without any problem.  My environment is as follows:

CPU:		NEC VR5432
kernel: 	linux-2.4.10 + patches
glibc:		2.2.3 + patches
gdb:		5.2/3 from CVS
gcc:		3.1 (also tried 3.0.1)
binutils:	Version 2.11.90.0.25

Does anyone have any idea what is wrong and how to fix it. 

Regards, Stuart

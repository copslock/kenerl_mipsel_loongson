Received:  by oss.sgi.com id <S553808AbQJ0PYv>;
	Fri, 27 Oct 2000 08:24:51 -0700
Received: from [206.207.108.63] ([206.207.108.63]:3964 "HELO
        ridgerun-lx.ridgerun.cxm") by oss.sgi.com with SMTP
	id <S553756AbQJ0PY1>; Fri, 27 Oct 2000 08:24:27 -0700
Received: (qmail 21813 invoked from network); 27 Oct 2000 09:24:17 -0600
Received: from skranz-lx.ridgerun.cxm (HELO ridgerun.com) (skranz@192.168.1.15)
  by ridgerun-lx.ridgerun.cxm with SMTP; 27 Oct 2000 09:24:17 -0600
Message-ID: <39F99E20.8EE47072@ridgerun.com>
Date:   Fri, 27 Oct 2000 09:24:17 -0600
From:   Steve Kranz <skranz@ridgerun.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.16 i686)
X-Accept-Language: en
MIME-Version: 1.0
To:     linux-mips@oss.sgi.com, linux-mips@fnet.fr
Subject: remote GDB debugging and the __init macro of init.h
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Note:

  I had to make a change to allow remote MIPS kernel
  debugging (GDB). The change I found necessary was in the
  file:

    include/linux/init.h     (2.4.0-test9)

  As you can see from the snippet below the change
  involves conditionally defining the "__init" macro as
  a function of whether remote debugging is enabled or
  not. Am I missing something, or does this seem like a
  reasonable change?

===========
Was this...
===========
/*
 * Mark functions and data as being only used at initialization
 * or exit time.
 */
#define __init  __attribute__ ((__section__ (".text.init")))

==================================
I changed my local copy to this...
==================================
/*
 * Mark functions and data as being only used at initialization
 * or exit time.
 */
#ifdef CONFIG_REMOTE_DEBUG
// Note: While running the mips-linux-elf-gdb (GNU gdb 5.0), RidgeRun
Inc
// noticed that gdb could not correctly derive the true address of any
symbol
// declared with the __init pragma. This prevented being able to
correctly
// set breakpoints on any of those functions. So, if we are building
// with the GDB remote debugger in mind, then null out the __init
// definition making those functions look like a normal functions
// since this seems to satisfy things for remote kernel debugging.
// Incidentally, for reference, the GDB being used at the time of this
writing
// was configured as "--host=i686-pc-linux-gnu --target=mips-linux-elf".

// and the mips-linux-gcc crosscompiler being used is egcs-2.90.29
980515
// (egcs-1.0.3 release) with binutils version 2.8.1. (These tools
running on
// a x86 host producing code for target CONFIG_CPU_R5000).
#define __init
#else
#define __init  __attribute__ ((__section__ (".text.init")))
#endif


Steve Kranz
skranz@ridgerun.com
Senior Kernel Developer
RidgeRun Inc.

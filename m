Received:  by oss.sgi.com id <S553819AbQJ0Psv>;
	Fri, 27 Oct 2000 08:48:51 -0700
Received: from mx.mips.com ([206.31.31.226]:59330 "EHLO mx.mips.com")
	by oss.sgi.com with ESMTP id <S553816AbQJ0PsZ>;
	Fri, 27 Oct 2000 08:48:25 -0700
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id IAA11139;
	Fri, 27 Oct 2000 08:47:30 -0700 (PDT)
Received: from Ulysses (ulysses [192.168.236.13])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id IAA12832;
	Fri, 27 Oct 2000 08:47:44 -0700 (PDT)
Message-ID: <014a01c0402d$b432ada0$0deca8c0@Ulysses>
From:   "Kevin D. Kissell" <kevink@mips.com>
To:     "Steve Kranz" <skranz@ridgerun.com>, <linux-mips@oss.sgi.com>,
        <linux-mips@fnet.fr>
References: <39F99E20.8EE47072@ridgerun.com>
Subject: Re: remote GDB debugging and the __init macro of init.h
Date:   Fri, 27 Oct 2000 17:50:50 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

What you've done should solve the problem, but note
that it has the side effect of preventing the text and data
sections in question from getting freed up at the end
of initialization.  I probably should have done so myself
last year when I was struggling with debugging some init 
code using kgdb, but instead I simply got used to finding 
the address in the symbol table and setting the breakpoints 
by hex address instead of by symbol.

The real fix would be to  teach gdb to treat symbols
in the init section as valid targets.

            Kevin K.

----- Original Message ----- 
From: "Steve Kranz" <skranz@ridgerun.com>
To: <linux-mips@oss.sgi.com>; <linux-mips@fnet.fr>
Sent: Friday, October 27, 2000 5:24 PM
Subject: remote GDB debugging and the __init macro of init.h


> Note:
> 
>   I had to make a change to allow remote MIPS kernel
>   debugging (GDB). The change I found necessary was in the
>   file:
> 
>     include/linux/init.h     (2.4.0-test9)
> 
>   As you can see from the snippet below the change
>   involves conditionally defining the "__init" macro as
>   a function of whether remote debugging is enabled or
>   not. Am I missing something, or does this seem like a
>   reasonable change?
> 
> ===========
> Was this...
> ===========
> /*
>  * Mark functions and data as being only used at initialization
>  * or exit time.
>  */
> #define __init  __attribute__ ((__section__ (".text.init")))
> 
> ==================================
> I changed my local copy to this...
> ==================================
> /*
>  * Mark functions and data as being only used at initialization
>  * or exit time.
>  */
> #ifdef CONFIG_REMOTE_DEBUG
> // Note: While running the mips-linux-elf-gdb (GNU gdb 5.0), RidgeRun
> Inc
> // noticed that gdb could not correctly derive the true address of any
> symbol
> // declared with the __init pragma. This prevented being able to
> correctly
> // set breakpoints on any of those functions. So, if we are building
> // with the GDB remote debugger in mind, then null out the __init
> // definition making those functions look like a normal functions
> // since this seems to satisfy things for remote kernel debugging.
> // Incidentally, for reference, the GDB being used at the time of this
> writing
> // was configured as "--host=i686-pc-linux-gnu --target=mips-linux-elf".
> 
> // and the mips-linux-gcc crosscompiler being used is egcs-2.90.29
> 980515
> // (egcs-1.0.3 release) with binutils version 2.8.1. (These tools
> running on
> // a x86 host producing code for target CONFIG_CPU_R5000).
> #define __init
> #else
> #define __init  __attribute__ ((__section__ (".text.init")))
> #endif
> 
> 
> Steve Kranz
> skranz@ridgerun.com
> Senior Kernel Developer
> RidgeRun Inc.
> 

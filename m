Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f2JMrMv11724
	for linux-mips-outgoing; Mon, 19 Mar 2001 14:53:22 -0800
Received: from hermes.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f2JMrMM11721
	for <linux-mips@oss.sgi.com>; Mon, 19 Mar 2001 14:53:22 -0800
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id f2JMmI326581;
	Mon, 19 Mar 2001 14:48:18 -0800
Message-ID: <3AB68CFC.A2840808@mvista.com>
Date: Mon, 19 Mar 2001 14:49:32 -0800
From: Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-mips@oss.sgi.com
Subject: gdb 5.0 display arguments problem
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


I am using gdb 5.0 client to debug kernel, and found a bug in gdb 5.0 when it
trys to display an function argument.

The following is the relavent code segment where breakpoint is set to the
first instruction of serial_console_write().

00000000801270ac <serial_console_write>:
    801270ac:   3c04801d        lui     $a0,0x801d
    801270b0:   8c84bc1c        lw      $a0,-17380($a0)
    801270b4:   27bdffc0        addiu   $sp,$sp,-64
    801270b8:   afb40028        sw      $s4,40($sp)
    801270bc:   00a0a021        move    $s4,$a1
    801270c0:   24050001        li      $a1,1

For whatever reason gdb client on the host side apparently thinks the second
arg is stored in register s4.  When the breakpoint is hit, gdb tries to
display the value of s4 (which is 0x4 in this case).  Since the type of this
argument is char *, gdb further tries to read the content at 0x4 which causes
kernel panic.

I believe I have seen this problem before (and in most case the symptom is
wrong argument values instead of kernel panic).  Does someone have an idea how
to fix it or work around it? 

Does this problem exist in native debugging?

I assume we can disable gdb to display char strings by default.  Does someone
know how to do it?

Thanks.

Jun

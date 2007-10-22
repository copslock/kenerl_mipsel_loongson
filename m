Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 22 Oct 2007 22:11:31 +0100 (BST)
Received: from smtp-out2.libero.it ([212.52.84.42]:13456 "EHLO
	smtp-out2.libero.it") by ftp.linux-mips.org with ESMTP
	id S20021616AbXJVVLX (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 22 Oct 2007 22:11:23 +0100
Received: from MailRelay10.libero.it (192.168.32.119) by smtp-out2.libero.it (7.3.120)
        id 4688F31B0C53C62A for linux-mips@linux-mips.org; Mon, 22 Oct 2007 23:08:08 +0200
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AgAAAA6uHEeXP4U8/2dsb2JhbAAMkDA
Received: from unknown (HELO [192.168.1.2]) ([151.63.133.60])
  by outrelay-b10.libero.it with ESMTP; 22 Oct 2007 23:08:08 +0200
From:	Bemipefe <bemipefe@libero.it>
To:	linux-mips@linux-mips.org
Subject: Compiling for MIPS  - Problem with "mips-linux-ld" address exeption in run time
Date:	Mon, 22 Oct 2007 23:07:51 +0200
User-Agent: KMail/1.9.4
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200710222307.51600.bemipefe@libero.it>
Return-Path: <bemipefe@libero.it>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17164
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bemipefe@libero.it
Precedence: bulk
X-list: linux-mips

Hi to all mips programmers!
First i want sorry for my bad english ... i'm working for upgrade :-D 

So i want to submit any question:

I'm compiling with mips compiler gcc (mips-linux-gcc from tools mips-2007 iso 
image ) and all GNU tools and i have any problems.

I succeed to compile the program demo "hello_mips.c" from gxemul sample in 
this way:


____________________________________________________________________
____________________________________________________________________

$mips-linux-gcc -I../../src/include/testmachine -g -DMIPS 
hello.c -mips1 -mabi=32 -c -o hello_mips32.o

$mips-linux-ld -T /home/bemipefe/Programs/mipstools/usr/lib/ldscripts/elf32btsmip.x  -e 
f hello_mips32.o -o hello_mips32                         


____________________________________________________________________
____________________________________________________________________

As you see i must specify the script for linking because option "-Ttext 
0x80030000" supplied from gxemul README don't work.

So i have modified the script changing "0x1000000" in "0x10000000" in that is:

PROVIDE (__executable_start = 0x10000000); . = 0x10000000 + SIZEOF_HEADERS;
 
I have also added "SIZEOF_HEADERS" that (at first "0") . Now the linker don't 
claim any message but if i test the binary, occur a exeption in run time:
____________________________________________________________________
____________________________________________________________________

[bemipefe@M-Parallelmind hello]$  ../../gxemul -V -E testmips -C 
R3000 ./hello_mips32
GXemul 0.4.4    Copyright (C) 2003-2007  Anders Gavare
Read the source code and/or documentation for other Copyright messages.

Simple setup...
    net: simulating 10.0.0.0/8 (max outgoing: TCP=100, UDP=100)
        simulated gateway: 10.0.0.254 (60:50:40:30:20:10)
            using nameserver 192.168.1.1
    machine "default":
        memory: 32 MB
        cpu0: R3000 (I+D = 4+4 KB)
        machine: MIPS test machine
        loading ./hello_mips32
        starting cpu0 at 0x100001ac
-------------------------------------------------------------------------------

GXemul> step
[ exception TLBL <tlb> vaddr=0x100001ac pc=0x100001ac ]
80000000: 00000000      nop
 

____________________________________________________________________
____________________________________________________________________


If I change "0x10000000" in "0x80000000" and also the section:

____________________________________________________________________
____________________________________________________________________

 /* Adjust the address for the data segment.  We want to adjust up to
     the same address within the page on the next page up.  */
  . = 0x80000000;

____________________________________________________________________
____________________________________________________________________

In the same way from "0x10000000" to "0x80000000". Now i do run the program 
with gxemul and i still down in trap of "exeption" in TLBL:

____________________________________________________________________
____________________________________________________________________

[bemipefe@M-Parallelmind hello]$  ../../gxemul -V -E testmips -C 
R3000 ./hello_mips32
GXemul 0.4.4    Copyright (C) 2003-2007  Anders Gavare
Read the source code and/or documentation for other Copyright messages.

Simple setup...
    net: simulating 10.0.0.0/8 (max outgoing: TCP=100, UDP=100)
        simulated gateway: 10.0.0.254 (60:50:40:30:20:10)
            using nameserver 192.168.1.1
    machine "default":
        memory: 32 MB
        cpu0: R3000 (I+D = 4+4 KB)
        machine: MIPS test machine
        loading ./hello_mips32
        starting cpu0 at 0x800001ac
-------------------------------------------------------------------------------

GXemul> step
800001ac: 3c1c0000      lui     gp,0x0
GXemul> step
800001b0: 279c7e44      addiu   gp,gp,32324
GXemul> step
800001b4: 0399e021      addu    gp,gp,t9
GXemul> step
800001b8: 27bdffe0      addiu   sp,sp,-32
GXemul> step
800001bc: afbf001c      sw      ra,28(sp)       [0xa0007efc]
GXemul> step
800001c0: afbe0018      sw      fp,24(sp)       [0xa0007ef8]
GXemul> step
800001c4: 03a0f021      move    fp,sp
GXemul> step
800001c8: afbc0010      sw      gp,16(sp)       [0xa0007ef0]
GXemul> step
800001cc: 8f828018      lw      v0,-32744(gp)   [0xfffffe5c]
[ exception TLBL <tlb> vaddr=0xfffffe5c pc=0x800001cc ]

____________________________________________________________________
____________________________________________________________________

But in this time i see any executed istruction.


The ask is: How can fix it ? The problem is in the linker ? How can find 
documentation from ELF format ?

Thank you and Good Work!  

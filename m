Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f8DJpch12443
	for linux-mips-outgoing; Thu, 13 Sep 2001 12:51:38 -0700
Received: from real.realitydiluted.com (real.realitydiluted.com [208.242.241.164])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f8DJpVe12439
	for <linux-mips@oss.sgi.com>; Thu, 13 Sep 2001 12:51:31 -0700
Received: from localhost.localdomain ([127.0.0.1] helo=cotw.com)
	by real.realitydiluted.com with esmtp (Exim 3.22 #1 (Red Hat Linux))
	id 15hcW7-0001pX-00; Thu, 13 Sep 2001 14:51:19 -0500
Message-ID: <3BA10C29.713DB745@cotw.com>
Date: Thu, 13 Sep 2001 14:42:33 -0500
From: "Steven J. Hill" <sjhill@cotw.com>
Reply-To: sjhill@cotw.com
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.9-xfs i686)
X-Accept-Language: en
MIME-Version: 1.0
To: binutils@sourceware.cygnus.com, linux-mips@oss.sgi.com
Subject: Corrupted symbols for MIPS debugging...
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Greetings.

I am currently working with the Insight as well as the
command line driven GDB for remotely debugging my MIPS
kernel (using KGDB of course). Here are the tools used
to compile, link, etc.:

    binutils-2.11.90.0.31 (HJLu patches applied)
    gcc-3.0.1 (stock)
    glibc-2.3.3 (minor build patches)
    linux-kernel-2.4.5 (OSS)
    Insight debugger (20010910-cvs)
    gdb-5.1 (20010913-cvs)

I have breakpoints set at the 'sys_create_module'
and 'sys_init_module' functions in the kernel. Observe
the output below:

--------------------------------------------------------------------
(gdb) target remote /dev/ttyS1
Remote debugging using /dev/ttyS1
0x80012828 in breakinst () at af_packet.c:1879
1879            sock_unregister(PF_PACKET);
(gdb) bt
#0  0x80012828 in breakinst () at af_packet.c:1879
#1  0x8001a0d4 in sys_create_module (name_user=0x10001dc8 "cfi_probe", 
    size=8176) at module.c:305
(gdb) c
Continuing.

Program received signal SIGTRAP, Trace/breakpoint trap.
0x80012828 in breakinst () at af_packet.c:1879
1879            sock_unregister(PF_PACKET);
(gdb) bt
#0  0x80012828 in breakinst () at af_packet.c:1879
#1  0x8001a2c0 in sys_init_module (name_user=0x10001dc8 "cfi_probe", 
    mod_user=0x1002eed0) at module.c:363
--------------------------------------------------------------------

The address 0x80012828 is clearly not in af_packet.c. Herein
is the problem. I have looked at various output with objdump
and nm, but am not getting any clues as to why the symbols
are corrupted. Below is the compile and final link line for
the kernel:

--------------------------------------------------------------------
mipsel-linux-gcc -I /opt/mipskern/include/asm/gcc -D__KERNEL__
-I/opt/mipskern/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer
-fno-strict-aliasing -g -G 0 -mno-abicalls -fno-pic -mcpu=r5000 -mips2
-Wa,--trap -pipe   -c -o init/main.o init/main.c

mipsel-linux-ld -G 0 -static -T arch/mips/ld.script -Ttext 0x80001000
arch/mips/kernel/head.o arch/mips/kernel/init_task.o init/main.o init/version.o
\
        --start-group \
        arch/mips/kernel/kernel.o arch/mips/mm/mm.o kernel/kernel.o mm/mm.o
fs/fs.o ipc/ipc.o arch/mips/math-emu/fpu_emulator.o \
         drivers/char/char.o drivers/block/block.o drivers/misc/misc.o
drivers/net/net.o drivers/media/media.o drivers/ide/idedriver.o
drivers/pci/driver.o drivers/video/video.o drivers/usb/usbdrv.o \
        net/network.o \
        arch/mips/lib/lib.a /opt/mips/settop/lib/lib.a arch/mips/brcm/brcm.a \
        --end-group \
        -o vmlinux
--------------------------------------------------------------------

Does anyone have some insight (no pun intended) as to what is
wrong here. Thanks everyone.

-Steve

-- 
 Steven J. Hill - Embedded SW Engineer

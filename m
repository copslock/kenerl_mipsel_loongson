Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fAMNUii04386
	for linux-mips-outgoing; Thu, 22 Nov 2001 15:30:44 -0800
Received: from real.realitydiluted.com (real.realitydiluted.com [208.242.241.164])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fAMNUTo04323
	for <linux-mips@oss.sgi.com>; Thu, 22 Nov 2001 15:30:29 -0800
Received: from localhost.localdomain ([127.0.0.1] helo=cotw.com)
	by real.realitydiluted.com with esmtp (Exim 3.22 #1 (Red Hat Linux))
	id 1672MO-0001ns-00; Thu, 22 Nov 2001 16:30:21 -0600
Message-ID: <3BFD8860.2FC63231@cotw.com>
Date: Thu, 22 Nov 2001 17:21:05 -0600
From: "Steven J. Hill" <sjhill@cotw.com>
Reply-To: sjhill@cotw.com
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.12-xfs i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-mips@oss.sgi.com, gdb@sources.redhat.com
Subject: Failure to remote debug MIPS kernel modules...
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Greetings.

I first want to thank Dan J. for fixing binutils to address the
error preventing proper parsing of the symbols so that GDB
worked properly with remote MIPS kernel debugging. Now onto more
of this issue.

I am now working on remote debugging of MIPS kernel modules. I
am utilizing the script from (http://kgdb.sourceforge.net/) to
upload the module to my target and get the GDB script back. The
problem that I am running into can be seen below in my run of
GDB. I insert the module, there is a breakpoint in 'module.c'
of course. I bring in the symbol table for the module and
attempt to set a breakpoint. If I continue, the breakpoint in
the module triggers, but GDB loses its marbles at this point as
you can see below. It appears that it does not believe there to
be a stack frame in existance. Does anyone have some insight on
this?

The tools and kernel source used were:

   binutils-20011121
   gcc-3.0.2
   gdb-20011121
   linux-2.4.5 (last 2.4.5 code from SGI MIPS kernel tree)

Any insight that people have on this would be very much
appreciated. Usage of 'set heuristic-fence-post' did not help
me at all. Thanks.

-Steve

********************************************************************

-------------------------
COMPLETE GDB DEBUGGER RUN
-------------------------
GNU gdb 2001-11-21-cvs
Copyright 2001 Free Software Foundation, Inc.
GDB is free software, covered by the GNU General Public License, and you are
welcome to change it and/or distribute copies of it under certain conditions.
Type "show copying" to see the conditions.
There is absolutely no warranty for GDB.  Type "show warranty" for details.
This GDB was configured as "--host=i686-pc-linux-gnu --target=mips-linux-elf"...
(gdb) target remote /dev/ttyS1
Remote debugging using /dev/ttyS1
0x80012cc8 in breakinst () at gdb-stub.c:907
907             __asm__ __volatile__("
(gdb) c

[MODULE GETS INSERTED]

Program received signal SIGTRAP, Trace/breakpoint trap.
0x80012cc8 in breakinst () at gdb-stub.c:907
907             __asm__ __volatile__("
(gdb) source /opt/mips/gdbscripts/loadmtdchar.o 
add symbol table from file "/opt/mips/settop/drivers/mtd/mtdchar.o" at
        .text_addr = 0xc0000060
        .reginfo_addr = 0xc0000fe0
        .rodata_addr = 0xc0001000
        .data_addr = 0xc0001120
        .bss_addr = 0xc0001170
(gdb) maintenance print msymbols syms.txt
(gdb) break mtdchar.c:548
Breakpoint 1 at 0xc0000f5c: file mtdchar.c, line 548.
(gdb) c
Continuing.

Program received signal SIGTRAP, Trace/breakpoint trap.
warning: Warning: GDB can't find the start of the function at 0xc0000f5c.

    GDB is unable to find the start of the function at 0xc0000f5c
and thus can't determine the size of that function's stack frame.
This means that GDB may be unable to access that stack frame, or
the frames below it.
    This problem is most likely caused by an invalid program counter or
stack pointer.
    However, if you think GDB should simply search farther back
from 0xc0000f5c for code which looks like the beginning of a
function, you can increase the range of the search using the `set
heuristic-fence-post' command.
0xc0000f5c in ?? ()
(gdb) c
Continuing.

[NEVER RECOVERS]


-----------------------------------------
FILE '/opt/mips/gdbscripts/loadmtdchar.o'
-----------------------------------------
add-symbol-file /opt/mips/settop/drivers/mtd/mtdchar.o 0xc0000060 -s .reginfo 0x
c0000fe0 -s .rodata 0xc0001000 -s .data 0xc0001120 -s .bss 0xc0001170


--------------------------
SNIPPET OF 'syms.txt' FILE
--------------------------
   Object file /opt/mips/settop/drivers/mtd/mtdchar.o:

   [ 0] d 0x0 __module_kernel_version section .modinfo
   [ 1] t 0xc0000060 mtd_lseek section .text
   [ 2] t 0xc0000144 mtd_open section .text

   [ 3] t 0xc00002d0 mtd_close section .text
   [ 4] t 0xc0000364 mtd_read section .text
   [ 5] t 0xc0000554 mtd_write section .text
   [ 6] t 0xc000077c mtd_erase_callback section .text
   [ 7] t 0xc00007a8 mtd_ioctl section .text
   [ 8] T 0xc0000f58 init_module section .text
   [ 9] t 0xc0000f58 init_mtdchar section .text
   [10] T 0xc0000fb4 cleanup_module section .text
   [11] t 0xc0000fb4 cleanup_mtdchar section .text
   [12] d 0xc0001120 mtd_fops section .data


---------------------------
SNIPPET OF 'mtdchar.c' FILE
---------------------------
540:  #if LINUX_VERSION_CODE < 0x20212 && defined(MODULE)
541:  #define init_mtdchar init_module
542:  #define cleanup_mtdchar cleanup_module
543:  #endif
544:  
545:  mod_init_t init_mtdchar(void)
546:  {
547:  #ifdef CONFIG_DEVFS_FS
548:          if (devfs_register_chrdev(MTD_CHAR_MAJOR, "mtd", &mtd_fops))
549:          {

-- 
 Steven J. Hill - Embedded SW Engineer

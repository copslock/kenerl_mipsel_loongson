Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f9VG9qJ02671
	for linux-mips-outgoing; Wed, 31 Oct 2001 08:09:52 -0800
Received: from real.realitydiluted.com (real.realitydiluted.com [208.242.241.164])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f9VG9c002666
	for <linux-mips@oss.sgi.com>; Wed, 31 Oct 2001 08:09:38 -0800
Received: from localhost.localdomain ([127.0.0.1] helo=cotw.com)
	by real.realitydiluted.com with esmtp (Exim 3.22 #1 (Red Hat Linux))
	id 15yxvl-0002hg-00; Wed, 31 Oct 2001 10:09:29 -0600
Message-ID: <3BE02E31.3B2CA5FC@cotw.com>
Date: Wed, 31 Oct 2001 11:00:33 -0600
From: "Steven J. Hill" <sjhill@cotw.com>
Reply-To: sjhill@cotw.com
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.12-xfs i686)
X-Accept-Language: en
MIME-Version: 1.0
To: gdb@sources.redhat.com
CC: binutils@sources.redhat.com, linux-mips@oss.sgi.com
Subject: Old bug with 'gdb/dbxread.c' and screwed up MIPS symbolic debugging...
References: <3BDF7F79.6050205@cygnus.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

I have attempted to do as much research and testing as I possibly can before
posting this. I remember reading a thread associated with this problem in the
past, but things are still not working properly. I have also taken the liberty
of CC'ing the binutils and linux-mips list just in case.

GOAL
----
To use my KGDB stub with GDB and/or Insight to debug my embedded MIPS kernel
over the serial link utilizing symbolic debugging.


TOOLCHAIN
---------
binutils-2.11.92.0.10 (stock)
gcc-3.0.2 (stock)
glibc-2.2.3 (minor patches to ld-scripts and a small fixes for ipc/shm)
gdb-10312001 (fresh out of cvs this morning w/patch applied, see bottom)


CONFIGURATION LINES FOR TOOLS
-----------------------------
../binutils-2.11.92.0.10/configure --prefix=/opt/toolchains/mips
--target=mipsel-linux

AR=mipsel-linux-ar RANLIB=mipsel-linux-ranlib ../gcc-3.0.2/configure
--prefix=/opt/toolchains/mips --target=mipsel-linux i686-pc-linux-gnu
--with-newlib --disable-shared --enable-languages=c

BUILD_CC=gcc CC=mipsel-linux-gcc AR=mipsel-linux-ar AS=mipsel-linux-as
RANLIB=mipsel-linux-ranlib ../glibc-2.2.3/configure
--prefix=/opt/toolchains/mips/mipsel-linux mipsel-linux
--build=i686-pc-linux-gnu --enable-add-ons --with-elf --disable-profile
--with-headers=/opt/toolchains/mips/mipsel-linux/include
--mandir=/opt/toolchains/mips/man --infodir=/opt/toolchains/mips/info

AR=mipsel-linux-ar RANLIB=mipsel-linux-ranlib ../gcc-3.0.2/configure
--prefix=/opt/toolchains/mips --target=mipsel-linux i686-pc-linux-gnu
--with-gxx-include-dir=/opt/toolchains/mips/mipsel-linux/include
--mandir=/opt/toolchains/mips/man --infodir=/opt/toolchains/mips/info
--enable-languages=c,c++ --enable-threads

../gdb-10312001/configure --prefix=/opt/toolchains/mips --target=mips-linux-elf


KERNEL
------
Last 2.4.5 release from oss.sgi.com CVS


TYPICAl KERNEL COMPILE LINE
---------------------------
mipsel-linux-gcc -I /opt/mips/settop/include/asm/gcc -D__KERNEL__
-I/opt/mips/settop/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer
-fno-strict-aliasing -g -G 0 -mno-abicalls -fno-pic -mcpu=r5000 -mips2
-Wa,--trap -pipe  -I .. -I /opt/mips/settop/fs  -funsigned-char   -c -o
xfs_griostubs.o xfs_griostubs.c
Assembler messages:
Warning: The -mcpu option is deprecated.  Please use -march and -mtune instead.
Warning: The -march option is incompatible to -mipsN and therefore ignored.


PROBLEM REPORT
--------------
I am using a NEC MIPS VR5432 in little endian and 32-bit mode. If I run
'mipsel-linux-objdump -d vmlinux', I get addresses starting with 0x8000XXXX.
With older toolchains I remember getting 0xffffffff8000XXXX. My kernel boots
fine and patiently waits for GDB to connect. If I use GDB stock from CVS
without applying any patches, the following output occurs:

This GDB was configured as "--host=i686-pc-linux-gnu --target=mips-linux-elf"...
(gdb) target remote /dev/ttyS1
Remote debugging using /dev/ttyS1
0x80012c88 in breakinst () at 1879
1879            sock_unregister(PF_PACKET);
(gdb) bt
#0  0x80012c88 in breakinst () at af_packet.c:1879
#1  0x8020aabc in brcm_irq_setup () at irq.c:421
#2  0x8020aaf0 in init_IRQ () at irq.c:434
#3  0x801fc83c in start_kernel () at init/main.c:524
#4  0x801fd6f8 in init_arch (argc=160, argv=0xb3000000, envp=0x2, 
    prom_vec=0xbf) at setup.c:425
(gdb) c
Continuing.

Program received signal SIGTRAP, Trace/breakpoint trap.
0x80012c88 in breakinst () at af_packet.c:1879
1879            sock_unregister(PF_PACKET);
(gdb) bt
#0  0x80012c88 in breakinst () at af_packet.c:1879
#1  0x8001a554 in sys_create_module (name_user=0x10001dc8 "brcmdrv", 
    size=713264) at module.c:305
(gdb) c
Continuing.

Which is clearly wrong. 'breakinst' is clearly not in that file, but all the
other symbolics in the backtrace are correct. Then if I go to insert a module,
'breakinst' again is decoded at the wrong place, but it gets 'sys_create_module'
module symbol decoded right. I will point out that 'breakinst' is defined in
'arch/mips/kernel/gdb-stub.c' and FWIW, looks like:

        __asm__ __volatile__("
                        .globl  breakinst
                        .set    noreorder
                        nop
breakinst:              break
                        nop
                        .set    reorder
        ");


"SOLUTION"
----------
On August 15, H.J. Lu applied a patch to 'gdb/dbxread.c' shown here:

   diff -urN -x CVS work/gdb/dbxread.c gdb-5.0-08162001/gdb/dbxread.c
   --- work/gdb/dbxread.c  Tue Oct 30 16:33:33 2001
   +++ gdb-5.0-08162001/gdb/dbxread.c      Wed Aug 15 00:02:28 2001
   @@ -951,7 +951,10 @@
        (intern).n_type = bfd_h_get_8 (abfd, (extern)->e_type);            \
        (intern).n_strx = bfd_h_get_32 (abfd, (extern)->e_strx);           \
        (intern).n_desc = bfd_h_get_16 (abfd, (extern)->e_desc);           \
   -    (intern).n_value = bfd_h_get_32 (abfd, (extern)->e_value);         \
   +    if (bfd_get_sign_extend_vma
(abfd))                                       \
   +      (intern).n_value = bfd_h_get_signed_32 (abfd,
(extern)->e_value);       \
   +    else                                                               \
   +      (intern).n_value = bfd_h_get_32 (abfd, (extern)->e_value);       \
      }
 
    /* Invariant: The symbol pointed to by symbuf_idx is the first one

If I back out this change, my debug output is "correct", but I no longer
have the nice line numbers and files decoded for me:

(gdb) target remote /dev/ttyS1
Remote debugging using /dev/ttyS1
0x80012c88 in breakinst ()
(gdb) bt
#0  0x80012c88 in breakinst ()
#1  0x8020aabc in brcm_irq_setup ()
#2  0x8020aaf0 in init_IRQ ()
#3  0x801fc83c in start_kernel ()
#4  0x801fd6f8 in init_arch ()
(gdb) c
Continuing.

Also, if I attempt to back out this patch from the latest insight CVS code,
it has not affect. Insight would still decode 'breakinst' at 'af_packet.c'.


CONCLUSION
----------
Conclusion? Uhh, things don't work. I greatly appreciate input from people
on this issue and hope I have supplied enough detail. I don't want to start
digging into the gdb source too deep without hearing other people's opinions.
Thanks.

-Steve

-- 
 Steven J. Hill - Embedded SW Engineer

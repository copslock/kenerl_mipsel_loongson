Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0OEwsM04328
	for linux-mips-outgoing; Thu, 24 Jan 2002 06:58:54 -0800
Received: from real.realitydiluted.com (real.realitydiluted.com [208.242.241.164])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0OEwjP04308
	for <linux-mips@oss.sgi.com>; Thu, 24 Jan 2002 06:58:45 -0800
Received: from dsl73.cedar-rapids.net ([208.242.241.39] helo=cotw.com)
	by real.realitydiluted.com with esmtp (Exim 3.22 #1 (Red Hat Linux))
	id 16TkOj-0001pC-00
	for <linux-mips@oss.sgi.com>; Thu, 24 Jan 2002 07:58:37 -0600
Message-ID: <3C502108.B4024075@cotw.com>
Date: Thu, 24 Jan 2002 08:58:16 -0600
From: Scott A McConnell <samcconn@cotw.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17-xfs i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "MIPS/Linux List (SGI)" <linux-mips@oss.sgi.com>
Subject: gdb, pthreads and MIPS
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

I am targeting a NEC VR5432

I am able to debug/set break points on executables that are not linked
with -lpthreads. However, whenever I try an executable that was linked
with pthreads gdb can never find the stack (PC).

Once a SIGTRAP occurs gdb has lost track of the stack. Up until that
point it seems to be keeping track of the PC.

I have tried gdb from the SGI site (H J Lu) I also have built 5.1.0.1
native. Both fail.

Are other people having trouble debugging pthreads?
Are there any patches available?
Can anyone even help me classify this problem? (gcc, glibc, gdb all
three)

--------------------------------------------------
The programs I am running are cross compiled with:

$ mipsel-linux-gcc -v
Reading specs from
/opt/toolchains/mips/lib/gcc-lib/mipsel-linux/3.0.3/specs
Configured with: ../gcc-3.0.3/configure --prefix=/opt/toolchains/mips
--target=mipsel-linux i686-pc-linux-gnu
--includedir=/opt/toolchains/mips/mipsel-linux/include
--with-gxx-include-dir=/opt/toolchains/mips/mipsel-linux/include
--mandir=/opt/toolchains/mips/man --infodir=/opt/toolchains/mips/info
--enable-languages=c,c++ --enable-threads
Thread model: posix
gcc version 3.0.3

--------------------------------------------------------
The native compiler on the MIS box is:

bash-2.04# gcc -v
Reading specs from /usr/lib/gcc-lib/mipsel-redhat-linux/2.96/specs
gcc version 2.96 20000731 (Red Hat Linux 7.1 2.96-99.1)





[New Thread 1024 (LWP 175)]

Program received signal SIGTRAP, Trace/breakpoint trap.
[Switching to Thread 1024 (LWP 175)]

warning: Warning: GDB can't find the start of the function at
0xffffffff.

    GDB is unable to find the start of the function at 0xffffffff
and thus can't determine the size of that function's stack frame.
This means that GDB may be unable to access that stack frame, or
the frames below it.
    This problem is most likely caused by an invalid program counter or
stack pointer.
    However, if you think GDB should simply search farther back
from 0xffffffff for code which looks like the beginning of a
function, you can increase the range of the search using the `set
heuristic-fence-post' command.
0xffffffff in ?? ()

(gdb) info registers
          zero       at       v0       v1       a0       a1      
a2       a3
 R0   00000000 2ab04e60 00000001 2aab9920 00000000 2ab052b8 00000000
0000004d 
            t0       t1       t2       t3       t4       t5      
t6       t7
 R8   0000f000 00000053 00000000 00000001 00000001 8022eef3 7fff7904
7fff7700 
            s0       s1       s2       s3       s4       s5      
s6       s7
 R16  2ab05860 00400d40 10012c10 00000000 7fff7b18 7fff7af4 00000008
2ab052c8 
            t8       t9       k0       k1       gp       sp      
s8       ra
 R24  00000000 2aab9920 7fff76b8 00000000 2ab0c9e0 7fff7a98 2ab052b0
2aab9288 
            sr       lo       hi      bad    cause       pc
      ffffffff ffffffff 00000000 2abfd290 00000024 ffffffff 
           fsr      fir       fp
      00000000 00000000 00000000 




-- 
Scott A. McConnell

Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 May 2005 09:09:42 +0100 (BST)
Received: from web32501.mail.mud.yahoo.com ([IPv6:::ffff:68.142.207.211]:3668
	"HELO web32501.mail.mud.yahoo.com") by linux-mips.org with SMTP
	id <S8224953AbVERIJZ>; Wed, 18 May 2005 09:09:25 +0100
Received: (qmail 45524 invoked by uid 60001); 18 May 2005 08:09:17 -0000
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=CgD2XZEZZlCHAdtuOyvudEuKn9pXmQTVcNOD00dX+Tb32MgIsr7GZrOqCOHTJL7/aRAxuzQ3Dm+Dy8+Npo3gp1N47sUYmJLsqnSEw86zYDocTqFQOAh6prZrzIhMcF0UoWvg3dqCJsnCR0NwEfY/nFti5RurFR/m0JZj1ZXwhOs=  ;
Message-ID: <20050518080917.45521.qmail@web32501.mail.mud.yahoo.com>
Received: from [85.250.113.238] by web32501.mail.mud.yahoo.com via HTTP; Wed, 18 May 2005 01:09:17 PDT
Date:	Wed, 18 May 2005 01:09:17 -0700 (PDT)
From:	Michael Belamina <belamina1@yahoo.com>
Subject: Re: 64 bit kernel for BCM1250
To:	linux-mips@linux-mips.org
In-Reply-To: 6667
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <belamina1@yahoo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7925
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: belamina1@yahoo.com
Precedence: bulk
X-list: linux-mips


I downloaded a new toolchain from ftp.mips-linux.org 
 and the previous problem is not repeating itself (t0
is now loaded properly with the _edata value). 

 Now I have another problem. I am getting the
following exception:


----  Start of pasted message  ---------

Starting program at 0xffffffff802ec000
Broadcom SiByte BCM1250 B2 @ 800 MHz (SB1 rev 2)
Board type: SiByte BCM91250E (Sentosa)
@@@@ This is a BCM1250 B1/B2, but the kernel is
conservatively configured for an 'A' stepping. @@@@
This kernel optimized for board runs with CFE
CPU revision is: 01040102
FPU revision is: 000f0102
Primary instruction cache 32kB, 4-way, linesize 32
bytes.
Primary data cache 32kB, 4-way, linesize 32 bytes.
Linux version 2.4.30 (michael@LinuxServer.lan) (gcc
version 3.4.3) #29 SMP Wed May 18 10:37:00 IDT 2005
Determined physical RAM map:
 memory: 0000000001effe00 @ 0000000000000000 (usable)
 memory: 000000000dffbe00 @ 0000000002004000 (usable)
 memory: 000000000ffffe00 @ 0000000080000000 (usable)
On node 0 totalpages: 589823
zone(0): 589823 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: root=/dev/nfs ip=any
ramdisk_size=48000
Calibrating delay loop... 532.48 BogoMIPS
Memory: 468216k/523236k available (1951k kernel code,
55020k reserved, 148k data, 112k init)
Dentry cache hash table entries: 131072 (order: 9,
2097152 bytes)
Inode cache hash table entries: 131072 (order: 9,
2097152 bytes)
Mount cache hash table entries: 256 (order: 0, 4096
bytes)
Buffer cache hash table entries: 262144 (order: 9,
2097152 bytes)
Page-cache hash table entries: 262144 (order: 9,
2097152 bytes)
Checking for 'wait' instruction...  unavailable.
Checking for the multiply/shift bug... no.
Checking for the daddi bug... no.
Checking for the daddiu bug... no.
POSIX conformance testing by UNIFIX
Detected 2 available CPU(s)
Starting CPU 1...
Primary instruction cache 32kB, 4-way, linesize 32
bytes.
Primary data cache 32kB, 4-way, linesize 32 bytes.
Slave cpu booted successfully
Waiting on wait_init_idle (map = 0x2)
All processors have done init_idle
pipe_mnt =                0
Cpu 0 Unable to handle kernel paging request at
address 0000000000000028, epc == ffffffff8016e3bc, ra
== ffffffff8014
Oops in fault.c::do_page_fault, line 231:
Cpu 0
$0      : 0000000000000000 ffffffff803b0000
0000000000000000 0000000000000009
$4      : ffffffff802c31ba ffffffff802c45f2
0000000000000072 0000000000000000
$8      : ffffffff803bf630 ffffffff803bf630
ffffffff803bd550 000000000000000a
$12     : ffffffffffffffff ffffffff8039b487
0000000000000000 ffffffff802bf0d0
$16     : ffffffff80100098 a80000008fff6080
ffffffffffffffe9 a80000008fff6140
$20     : 0000000000000000 ffffffff803078c0
0000000000000001 ffffffff80324688
$24     : 0000000000000000 0000000000000020
$28     : ffffffff802e8000 ffffffff802ebce0
ffffffff802ebd70 ffffffff8016e3c4
Hi      : 0000000000000000
Lo      : 0000000000000000
epc     : ffffffff8016e3bc    Not tainted
badvaddr: 0000000000000028
Status  : 14001fe3  [ KX SX UX KERNEL EXL IE ]
Cause   : 80808008
PrId  : 01040102
Process swapper (pid: 0, stackpage=ffffffff802e8000)
Stack: 0000000000000000 0000000000040004
0000000000000000 9000000010060120
       9000000010060100 ffffffff803bd550
ffffffff803bf630 ffffffff803bf630
       ffffffff80100098 0000000000000000
0000000000010f00 ffffffff80307860
       0000000000000000 ffffffff803078c0
0000000000000001 ffffffff80324688
       0000000000000000 ffffffff8010a0c8
ffffffffffffffff 000000000000000a
       ffffffff80107e2c 0000000000000000
0000000000000000 0000000000000020
       0000000000000001 000000000000000a
ffffffff802e8000 ffffffff802ebe00
       0000000000000000 ffffffff8021458c
00000000000013bf c000000000000000
       0000000000010f00 0000000000000000
ffffffff802ebef0 0000000000000fc0
       ffffffffffffffc0 0000000000000000
0000000014001fe1 ffffffff8039b488
       000000000000003e ...
Call Trace: [<ffffffff80100098>] [<ffffffff8010a0c8>]
[<ffffffff80107e2c>]
            [<ffffffff8021458c>] [<ffffffff80100098>]
[<ffffffff8012583c>]
            [<ffffffff80105488>] [<ffffffff8012583c>]

Code: dc42a5f0  104000fc  00000000 <0c05ffcc> dc440028
 104000e7  0040802d  0c05b892  0040202d
Kernel panic: Attempted to kill the idle task!
In idle task - not syncing
 <0>Rebooting in 5 seconds..Passing control back to
CFE...


----  End of pasted message  ---------


The fault is in do_pipe() function when trying to
call:

struct inode *inode = new_inode(pipe_mnt->mnt_sb);

The pipe_mnt is NULL at this point because
init_pipe_fs () was not called yet.


Any ideas what could be wrong?

Thanks,
  Michael






--- "Maciej W. Rozycki" <macro@linux-mips.org> wrote:
> On Tue, 17 May 2005, Michael Belamina wrote:
> 
> >   I have built a 64 bit kernel for BCM1250.
> >   When the kernel is loaded and control is passed
> to
> > kernel_entry there is an exception:
> > 
> > CFE> boot -elf LinuxServer:vmlinux.64
> [...]
> 
>  I'm assuming vmlinux.64 is a 64-bit ELF file.  If
> so, then, well, 
> depending on the version of CFE you have, this may
> or may not work.  The 
> workaround is to always use 32-bit ELF files.  You
> should get one after 
> your Linux build -- if not (which may depend on how
> you do builds), then 
> try `make vmlinux.32' and use the result.
> 
>   Maciej
> 

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 

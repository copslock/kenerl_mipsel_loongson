Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Oct 2002 14:46:28 +0200 (CEST)
Received: from [64.238.111.99] ([64.238.111.99]:57353 "EHLO mail.ivivity.com")
	by linux-mips.org with ESMTP id <S1123891AbSJAMq1>;
	Tue, 1 Oct 2002 14:46:27 +0200
Received: by ATLOPS with Internet Mail Service (5.5.2653.19)
	id <4B1K5AT4>; Tue, 1 Oct 2002 08:46:19 -0400
Message-ID: <AEC4671C8179D61194DE0002B328BDD2070C5C@ATLOPS>
From: Dinesh Nagpure <dinesh_nagpure@ivivity.com>
To: linux-mips@linux-mips.org
Subject: RE: un handled paging request, kernel v2.4.16
Date: Tue, 1 Oct 2002 08:46:18 -0400 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Return-Path: <dinesh_nagpure@ivivity.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 323
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dinesh_nagpure@ivivity.com
Precedence: bulk
X-list: linux-mips

Hello again,

I have been searching the mailing archives and haven't yet seen any
problem/mail exchanged about RM5231A. I did saw a mail from Carsten where he
was worried about a probable bug in _save_fp_context function in
arch/mips/kernel/r4k_fpu.S. I am not sure which kernel version he was
looking into then but the one I am using don't have this fix (if it was a
required one). I tried it anyways but it did not work. Also Matt Dharm was
having some crashing problems initially this year(it was a different MIPS
processor though), I have not yet reached the mail where he found his
solution or his mail on what fixed the problem, Matt can you throw some
light here?

Since there is no talk about RM5231A I am wondering if there were no
problems at all or no one have verified it in a while now.

I am also trying to understand where does execution goes after start_thread(
) is called to setup a new thread for execution. Is it put to execution
immediately or later when schedule gets called. Anybody?

Hoping to put this problem to bed soon,
Dinesh
iViVITY Inc.

 
-----Original Message-----
From: Dinesh Nagpure [mailto:dinesh_nagpure@ivivity.com]
Sent: Monday, September 30, 2002 4:22 PM
To: linux-mips@linux-mips.org; gcc-help@gcc.gnu.org
Subject: un handled paging request, kernel v2.4.16


Hi,

In porting Linux kernel version 2.4.16 to our platform using the RM5231A, I
am struggling with this page fault for a couple of days now and would very
much appreciate any input to fix this.

Here is what I see is happening, after completing the initial boot up when
it is time to start the user-mode stuff I get a un handled paging request
fault.

From the printk statements and the Oops dump I can see that execution goes
as far as start_thread( ) function called from load_elf_binary( ) and also
EPC and SP passed to start_thread( ) appear valid.

After putting the thread to execution, load_elf_binary( ) returns zero and
system Oops with a page fault. Control never comes back to
search_binary_handler( )

I can see the load_elf_binary( ) address still on the stack (8015e4ac).

I am running the kernel uncached.

I have already tried 
1) Disabling the use of wait instruction, thinking that it may be the cause.

2) Disabling the FPU with no success.

Could this be a page fault on instruction in delay slot which is not being
handled properly? To avoid this I modified save_fp_context( ) in r4k_fpu.S
but again with no success.

May be I am using a wrong ramdisk.gz image, but the same image works fine on
my Malta board (this one has a 4Kc core), I am creating my ramdisk image
using busybox and tinylogin.

Could this be a toolchain problem? While compiling, I do get warnings which
says:
mcpu option is deprecated, pls use -march and -mtune instead. and then,
the -march option is incompatible to -mipsN and therefore ignored.
All this essentially means it is taking -mtune=r5000 and -mips2 options for
generating/scheduling instructions. 

Tool chain I am using is built from binutils-2.11.92.0.7, gcc-3.0.2 and
glibc-2.2.3 (Were there any recommended versions for building kernel
v2.4.16?)
 

Are there any special flag I should be using to build busybox ramdisk for
RM5231A (which is very unlikely if the ramdisk is working well on a MIPS
Malta board with 4Kc core)

Could this be a hardware bug? ;)

Here are the boot time messages and the Oops dump. Objdump -t of vmlinux is
in the attached file idisx13log

PAGING_INIT : max_dmable_pfn<4096> max_low_pfn<16384>
On node 0 totalpages: 16384
Required map size to hold all the page structs <983100>
zone(0): 16384 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line:  console=ttyS0,38400
Have QED style interrupt
Value in Status reg 0x90000400
time_init : Entered
RTC port based at 0xb411fff0
for 200MHz CPU clock, r4k_offset is
000f4240(1000000)
In idisx_rtc_read_data
In idisx_rtc_read_data
In idisx_rtc_read_data
In idisx_rtc_read_data
In idisx_rtc_read_data
In idisx_rtc_read_data
Value in Status reg 0x90008000
BEFORE console_init
Dinesh : serial_console_setup : Entered............
Dinesh : UART_LCR = 0x93
Dinesh : UART_DLL = 0x6
Dinesh : UART_DLM = 0x0
Dinesh : UART_LCR = 0x13
Dinesh : UART_MCR = 0x3
Primary instruction cache 32kb, linesize 32 bytes.
Primary data cache 32kb, linesize 32 bytes.
offset=lmem_map - mem_map = <0>
AFTER console_init
AFTER init_modules
before kmem_cache_init
before sti
Value in Status reg 0x90008000
Value in Debug reg 0x0
Value in Status reg 0x90008001
before calibrate_delay
Calibrating delay loop... 0.81 BogoMIPS
before mem_init
Memory: 61272k/62244k available (1025k kernel code, 972k reserved, 1041k
data, 6
0k init)
before kmem_cache_sizes_init
before fork_init
before proc_caches_init
before vfs_caches_init
Dentry-cache hash table entries: 8192 (order: 4, 65536 bytes)
Inode-cache hash table entries: 4096 (order: 3, 32768 bytes)
Mount-cache hash table entries: 1024 (order: 1, 8192 bytes)
before buffer_init
Buffer-cache hash table entries: 4096 (order: 2, 16384 bytes)
before page_cache_init
Page-cache hash table entries: 16384 (order: 4, 65536 bytes)
before signals_init
before proc_root_init
before ipc_init
before check_bugs
POSIX conformance testing by UNIFIX
before smp_init
before rest_init
do_basic_setup : Entering
sock_init : Entering
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
start_context_thread : Entering
do_initcalls : Entering
Starting kswapd
do_gettimeofday : Entered
do_fast_gettimeoffset : Entering
do_fast_gettimeoffset : 1
do_fast_gettimeoffset : 2
do_fast_gettimeoffset : 3
do_fast_gettimeoffset : Done
do_gettimeofday : Leaving
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with no serial options enabled
block: 128 slots per queue, batch=32
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 4096 bind 8192)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
prepare_namespace : Entering
RAMDISK: Compressed image found at block 0
Leaving : identify_ramdisk_image
Freeing initrd memory: 976k freed
EXT2-fs warning: mounting unchecked fs, running e2fsck is recommended
VFS: Mounted root (ext2 filesystem).
Freeing unused kernel memory: 60k freed
Dinesh : Initial console opened successfully
After first dup
After second dup
trying sbin init
do_execve : Entered executing /sbin/init
do_execve : before PTR_ERR
do_execve : before IS_ERR
do_execve : In IS_ERR clause
trying etc/init
do_execve : Entered executing /etc/init
do_execve : before PTR_ERR
do_execve : before IS_ERR
do_execve : In IS_ERR clause
trying bin init
do_execve : Entered executing /bin/init
do_execve : before PTR_ERR
do_execve : before IS_ERR
do_execve : Computing top of mem
do_execve : bprm.p = 0x1fffc
do_execve : before memset on bprm.page 1
do_execve : 7
prepare_binprm : Entered
prepare_binprm : mode = 33261
prepare_binprm : bprm->e_uid = 0
prepare_binprm : bprm->e_gid = 0
prepare_binprm : Clearing capabilities
prepare_binprm : memset of bprm->buf, size 128 chars
prepare_binprm : reading 128 chars from file
kernel_read : Entered
kernel_read : calling get_fs
kernel_read : calling set_fs
kernel_read : calling  read from file
kernel_read : calling set_fs again to restore old_fs
do_execve : 8
do_execve : 9
do_execve : 10
do_execve : 11
do_execve : 12
do_execve : 13
do_execve : 14
do_execve : 15
search_binary_handler : Entered
search_binary_handler : Before set_fs
search_binary_handler : Before for loop of try
search_binary_handler : In for loop with try = 0
search_binary_handler : In for loop searching formats for a match
search_binary_handler : calling fn
fn is 8015e4ac
kernel_read : Entered
kernel_read : calling get_fs
kernel_read : calling set_fs
kernel_read : calling  read from file
kernel_read : calling set_fs again to restore old_fs
load_elf_binary : in for loop1 with i=0 limit=4
load_elf_binary : in for loop1 with i=1 limit=4
load_elf_binary : in for loop1 with i=2 limit=4
load_elf_binary : in for loop1 with i=3 limit=4
load_elf_binary : out of for loop1
load_elf_binary : Before start_thread
load_elf_binary : New Thread info
load_elf_binary : cp0_epc = 0x400190
load_elf_binary : sp = 0x7fff7f40
load_elf_binary : After start thread
load_elf_binary : did not send sigtrap
Unable to handle kernel paging request at virtual address 00000000, epc ==
00000
000, ra == 8014a68c
Oops in fault.c:do_page_fault, line 204:
$0 : 00000000 90008000 00000000 00000000 801ecb28 00000001 00000001 000007f8
$8 : 000007f8 ffffc7f8 000007f8 00000000 00000000 00000000 80318ec1 fffffff4
$16: 8015e4ac 8021b1c0 00000001 8035dd88 00000000 00000000 fffffff8 8035dd38
$24: 00000010 8035dacf                   8035c000 8035dd20 8035def8 8014a68c
Hi : 00000000
Lo : 00000120
epc  : 00000000    Not tainted
Status: 90008003
Cause : 00800408
Process init (pid: 1, stackpage=8035c000)
Stack: 801ecaa8 8015e4ac 0000000a 8035dd24 ffffffff 8020f62c 00000313
fffffced
       8020f650 00000000 90008003 00808400 00000000 80221000 80212d7c
80212d54
       8035def8 00000000 00000000 00000000 800af880 8014a920 801eccbc
00000000
       0000000a 8035dd7c 464c457f 00010101 00000000 00000000 00080002
00000001
       00400190 00000034 0011429c 00000005 00200034 00280004 00120013
70000000
       000000e0 ...
Call Trace: [<801ecaa8>] [<8015e4ac>] [<8014a920>] [<801eccbc>] [<8014be70>]
[<8
01082cc>]
 [<8010c280>] [<801082cc>] [<8010ca24>] [<801e868c>] [<801e8678>]
[<80108c9c>]
 [<80108020>] [<80108c8c>]

Code: (Bad address in epc)

Kernel panic: Attempted to kill init!

 <<idisx13objdump>> 
Thanks,
Dinesh
iViVITY Inc.

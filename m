Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Sep 2002 23:32:42 +0200 (CEST)
Received: from [64.238.111.99] ([64.238.111.99]:64005 "EHLO mail.ivivity.com")
	by linux-mips.org with ESMTP id <S1123907AbSI3Vcl>;
	Mon, 30 Sep 2002 23:32:41 +0200
Received: by ATLOPS with Internet Mail Service (5.5.2653.19)
	id <TXZAV2F7>; Mon, 30 Sep 2002 16:21:35 -0400
Message-ID: <AEC4671C8179D61194DE0002B328BDD2070C59@ATLOPS>
From: Dinesh Nagpure <dinesh_nagpure@ivivity.com>
To: linux-mips@linux-mips.org, gcc-help@gcc.gnu.org
Subject: un handled paging request, kernel v2.4.16
Date: Mon, 30 Sep 2002 16:21:30 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_000_01C268BE.F60BF950"
Return-Path: <dinesh_nagpure@ivivity.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 314
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dinesh_nagpure@ivivity.com
Precedence: bulk
X-list: linux-mips

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_000_01C268BE.F60BF950
Content-Type: text/plain;
	charset="iso-8859-1"

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



------_=_NextPart_000_01C268BE.F60BF950
Content-Type: application/octet-stream;
	name="idisx13objdump"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="idisx13objdump"

=0A=
vmlinux:     file format elf32-tradlittlemips=0A=
=0A=
SYMBOL TABLE:=0A=
80100000 l    d  .text	00000000 =0A=
801f9970 l    d  .fixup	00000000 =0A=
801fa758 l    d  .kstrtab	00000000 =0A=
801fd590 l    d  __ex_table	00000000 =0A=
801ff080 l    d  __dbe_table	00000000 =0A=
801ff080 l    d  __ksymtab	00000000 =0A=
80202000 l    d  .text.init	00000000 =0A=
8020f9c0 l    d  .data.init	00000000 =0A=
8020ff70 l    d  .setup.init	00000000 =0A=
80210038 l    d  .initcall.init	00000000 =0A=
80211000 l    d  .data.cacheline_aligned	00000000 =0A=
80211a60 l    d  .reginfo	00000000 =0A=
80211a80 l    d  .data	00000000 =0A=
80316000 l    d  .bss	00000000 =0A=
80336420 l    d  .comment	00000000 =0A=
00000000 l    d  .pdr	00000000 =0A=
00000000 l    d  *ABS*	00000000 =0A=
00000000 l    d  *ABS*	00000000 =0A=
00000000 l    d  *ABS*	00000000 =0A=
00000000 l    df *ABS*	00000000 head.S=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/bootinfo.h=0A=
00000000 l    df *ABS*	00000000 head.S=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/stackframe.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/linux/config.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/stackframe.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/offset.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/stackframe.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/asm.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/stackframe.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/processor.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/stackframe.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/mipsregs.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/stackframe.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/addrspace.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/stackframe.h=0A=
00000000 l    df *ABS*	00000000 head.S=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/mipsregs.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/linux/config.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/mipsregs.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/linux/linkage.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/linux/config.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/linux/linkage.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/mipsregs.h=0A=
00000000 l    df *ABS*	00000000 head.S=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/cachectl.h=0A=
00000000 l    df *ABS*	00000000 head.S=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/regdef.h=0A=
00000000 l    df *ABS*	00000000 head.S=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/processor.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/isadep.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/linux/config.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/isadep.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/processor.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/linux/cache.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/cache.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/linux/config.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/cache.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/linux/cache.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/linux/config.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/linux/cache.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/processor.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/linux/config.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/processor.h=0A=
00000000 l    df *ABS*	00000000 head.S=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/offset.h=0A=
00000000 l    df *ABS*	00000000 head.S=0A=
00000000 l    df *ABS*	00000000 /opt/iDISX/src/linux/include/asm/current=
.h=0A=
00000000 l    df *ABS*	00000000 head.S=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/asm.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/sgidefs.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/asm.h=0A=
00000000 l    df *ABS*	00000000 head.S=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/linux/threads.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/linux/config.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/linux/threads.h=0A=
00000000 l    df *ABS*	00000000 head.S=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/linux/init.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/linux/config.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/linux/init.h=0A=
00000000 l    df *ABS*	00000000 head.S=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/linux/config.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/linux/autoconf.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/linux/config.h=0A=
00000000 l    df *ABS*	00000000 head.S=0A=
80106000 l       .text	00000000 dummy=0A=
00000000 l    df *ABS*	00000000 init_task.c=0A=
80211ac0 l     O .data	00000020 init_fs=0A=
80211ae0 l     O .data	0000019c init_files=0A=
80211c7c l     O .data	00001004 init_signals=0A=
00000000 l    df *ABS*	00000000 init/main.c=0A=
80212d04 l     O .data	00000028 argv_init=0A=
80212d2c l     O .data	00000028 envp_init=0A=
80212d54 l     O .data	00000028 argv_init1=0A=
80212d7c l     O .data	00000028 envp_init1=0A=
80202000 l     F .text.init	00000000 profile_setup=0A=
8020f9c0 l     O .data.init	00000009 __setup_str_profile_setup=0A=
8020ff70 l     O .setup.init	00000008 __setup_profile_setup=0A=
8020f9cc l     O .data.init	00000268 root_dev_names=0A=
80202144 l     F .text.init	00000000 root_dev_setup=0A=
8020fc34 l     O .data.init	00000006 __setup_str_root_dev_setup=0A=
8020ff78 l     O .setup.init	00000008 __setup_root_dev_setup=0A=
8020225c l     F .text.init	00000000 checksetup=0A=
80202490 l     F .text.init	00000000 readonly=0A=
802024c0 l     F .text.init	00000000 readwrite=0A=
802024f4 l     F .text.init	00000000 debug_kernel=0A=
8020251c l     F .text.init	00000000 quiet_kernel=0A=
8020fc3c l     O .data.init	00000003 __setup_str_readonly=0A=
8020ff80 l     O .setup.init	00000008 __setup_readonly=0A=
8020fc40 l     O .data.init	00000003 __setup_str_readwrite=0A=
8020ff88 l     O .setup.init	00000008 __setup_readwrite=0A=
8020fc44 l     O .data.init	00000006 __setup_str_debug_kernel=0A=
8020ff90 l     O .setup.init	00000008 __setup_debug_kernel=0A=
8020fc4c l     O .data.init	00000006 __setup_str_quiet_kernel=0A=
8020ff98 l     O .setup.init	00000008 __setup_quiet_kernel=0A=
80202544 l     F .text.init	00000000 parse_options=0A=
80108000 l     F .text	00000000 rest_init=0A=
801082cc l     F .text	00000000 init=0A=
80212da8 l     O .data	00000008 argv.0=0A=
80108038 l     F .text	00000000 do_linuxrc=0A=
80202a40 l     F .text.init	00000000 do_initcalls=0A=
80202a94 l     F .text.init	00000000 do_basic_setup=0A=
8010812c l     F .text	00000000 prepare_namespace=0A=
00000000 l    df *ABS*	00000000 init/version.c=0A=
00000000 l    df *ABS*	00000000 branch.c=0A=
00000000 l    df *ABS*	00000000 process.c=0A=
00000000 l    df *ABS*	00000000 signal.c=0A=
80108edc l     F .text	00000000 _sys_sigsuspend=0A=
80109084 l     F .text	00000000 _sys_rt_sigsuspend=0A=
8010a120 l     F .text	00000000 setup_sigcontext=0A=
00000000 l    df *ABS*	00000000 entry.S=0A=
00000000 l    df *ABS*	00000000 syscalls.h=0A=
00000000 l    df *ABS*	00000000 entry.S=0A=
00000000 l    df *ABS*	00000000 syscalls.h=0A=
00000000 l    df *ABS*	00000000 entry.S=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/isadep.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/linux/config.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/isadep.h=0A=
00000000 l    df *ABS*	00000000 entry.S=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/unistd.h=0A=
00000000 l    df *ABS*	00000000 entry.S=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/fpregdef.h=0A=
00000000 l    df *ABS*	00000000 entry.S=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/regdef.h=0A=
00000000 l    df *ABS*	00000000 entry.S=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/processor.h=0A=
00000000 l    df *ABS*	00000000 entry.S=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/stackframe.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/linux/config.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/stackframe.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/offset.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/stackframe.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/asm.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/stackframe.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/processor.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/isadep.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/linux/config.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/isadep.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/processor.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/linux/cache.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/cache.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/linux/config.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/cache.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/linux/cache.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/linux/config.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/linux/cache.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/processor.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/linux/config.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/processor.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/stackframe.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/mipsregs.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/stackframe.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/addrspace.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/stackframe.h=0A=
00000000 l    df *ABS*	00000000 entry.S=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/pgtable.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/page.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/pgtable.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/addrspace.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/pgtable.h=0A=
00000000 l    df *ABS*	00000000 entry.S=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/page.h=0A=
00000000 l    df *ABS*	00000000 entry.S=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/mipsregs.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/linux/config.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/mipsregs.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/linux/linkage.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/linux/config.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/linux/linkage.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/mipsregs.h=0A=
00000000 l    df *ABS*	00000000 entry.S=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/errno.h=0A=
00000000 l    df *ABS*	00000000 entry.S=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/current.h=0A=
00000000 l    df *ABS*	00000000 entry.S=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/cacheops.h=0A=
00000000 l    df *ABS*	00000000 entry.S=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/asm.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/sgidefs.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/asm.h=0A=
00000000 l    df *ABS*	00000000 entry.S=0A=
00000000 l    df *ABS*	00000000 /opt/iDISX/src/linux/include/asm/addrspa=
ce.h=0A=
00000000 l    df *ABS*	00000000 entry.S=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/linux/sys.h=0A=
00000000 l    df *ABS*	00000000 entry.S=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/linux/init.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/linux/config.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/linux/init.h=0A=
00000000 l    df *ABS*	00000000 entry.S=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/linux/config.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/linux/autoconf.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/linux/config.h=0A=
00000000 l    df *ABS*	00000000 entry.S=0A=
8010a500 l       .text	00000000 tracesys_exit=0A=
8010a528 l       .text	00000000 reschedule=0A=
8010a624 l     F .text	00000000 signal_return=0A=
80202b54 l       .text.init	00000000 handle_vced=0A=
80202b80 l       .text.init	00000000 handle_vcei=0A=
00000000 l    df *ABS*	00000000 traps.c=0A=
80218f40 l     O .data	00000008 archdata.0=0A=
80218f50 l     O .data	00000004 ll_task=0A=
8010abfc l     F .text	00000000 default_be_board_handler=0A=
00000000 l    df *ABS*	00000000 ptrace.c=0A=
00000000 l    df *ABS*	00000000 vm86.c=0A=
00000000 l    df *ABS*	00000000 ioport.c=0A=
00000000 l    df *ABS*	00000000 reset.c=0A=
00000000 l    df *ABS*	00000000 semaphore.c=0A=
00000000 l    df *ABS*	00000000 setup.c=0A=
80218f70 l     O .data	0000001c code_resource=0A=
80218f8c l     O .data	0000001c data_resource=0A=
80203c98 l     F .text.init	00000000 print_memory_map=0A=
80316328 l     O .bss	00000050 command_line=0A=
8020fc54 l     O .data.init	00000006 __setup_str_fpu_disable=0A=
8020ffa0 l     O .setup.init	00000008 __setup_fpu_disable=0A=
00000000 l    df *ABS*	00000000 syscall.c=0A=
8010c168 l     F .text	00000000 _sys_fork=0A=
8010c1c8 l     F .text	00000000 _sys_clone=0A=
00000000 l    df *ABS*	00000000 sysmips.c=0A=
00000000 l    df *ABS*	00000000 ipc.c=0A=
00000000 l    df *ABS*	00000000 scall_o32.S=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/unistd.h=0A=
00000000 l    df *ABS*	00000000 scall_o32.S=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/sysmips.h=0A=
00000000 l    df *ABS*	00000000 scall_o32.S=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/isadep.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/linux/config.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/isadep.h=0A=
00000000 l    df *ABS*	00000000 scall_o32.S=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/stackframe.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/linux/config.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/stackframe.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/offset.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/stackframe.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/asm.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/stackframe.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/processor.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/isadep.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/linux/config.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/isadep.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/processor.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/linux/cache.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/cache.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/linux/config.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/cache.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/linux/cache.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/linux/config.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/linux/cache.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/processor.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/linux/config.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/processor.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/stackframe.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/mipsregs.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/stackframe.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/addrspace.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/stackframe.h=0A=
00000000 l    df *ABS*	00000000 scall_o32.S=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/regdef.h=0A=
00000000 l    df *ABS*	00000000 scall_o32.S=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/mipsregs.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/linux/config.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/mipsregs.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/linux/linkage.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/linux/config.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/linux/autoconf.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/linux/config.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/linux/linkage.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/mipsregs.h=0A=
00000000 l    df *ABS*	00000000 scall_o32.S=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/current.h=0A=
00000000 l    df *ABS*	00000000 scall_o32.S=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/linux/errno.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/errno.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/linux/errno.h=0A=
00000000 l    df *ABS*	00000000 scall_o32.S=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/asm.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/sgidefs.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/asm.h=0A=
00000000 l    df *ABS*	00000000 scall_o32.S=0A=
8010cc0c l       .text	00000000 illegal_syscall=0A=
8010cb94 l       .text	00000000 stackargs=0A=
8010ca08 l       .text	00000000 stack_done=0A=
8010cb28 l       .text	00000000 trace_a_syscall=0A=
8010cb18 l       .text	00000000 o32_reschedule=0A=
8010cad0 l     F .text	00000000 signal_return=0A=
8010ca6c l       .text	00000000 restore_all=0A=
8010cbf4 l       .text	00000000 bad_stack=0A=
8010cc9c l       .text	00000000 no_mem=0A=
00000000 l    df *ABS*	00000000 unaligned.c=0A=
00000000 l    df *ABS*	00000000 mips_ksyms.c=0A=
00000000 l    df *ABS*	00000000 r4k_fpu.S=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/regdef.h=0A=
00000000 l    df *ABS*	00000000 r4k_fpu.S=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/offset.h=0A=
00000000 l    df *ABS*	00000000 r4k_fpu.S=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/mipsregs.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/linux/config.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/mipsregs.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/linux/linkage.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/linux/config.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/linux/autoconf.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/linux/config.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/linux/linkage.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/mipsregs.h=0A=
00000000 l    df *ABS*	00000000 r4k_fpu.S=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/fpregdef.h=0A=
00000000 l    df *ABS*	00000000 r4k_fpu.S=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/errno.h=0A=
00000000 l    df *ABS*	00000000 r4k_fpu.S=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/asm.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/sgidefs.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/asm.h=0A=
00000000 l    df *ABS*	00000000 r4k_fpu.S=0A=
8010d07c l     F .text	00000000 fault=0A=
00000000 l    df *ABS*	00000000 r4k_switch.S=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/asmmacro.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/offset.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/asmmacro.h=0A=
00000000 l    df *ABS*	00000000 r4k_switch.S=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/stackframe.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/linux/config.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/stackframe.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/offset.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/stackframe.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/asm.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/stackframe.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/processor.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/stackframe.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/mipsregs.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/stackframe.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/addrspace.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/stackframe.h=0A=
00000000 l    df *ABS*	00000000 r4k_switch.S=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/regdef.h=0A=
00000000 l    df *ABS*	00000000 r4k_switch.S=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/processor.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/isadep.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/linux/config.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/isadep.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/processor.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/linux/cache.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/cache.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/linux/config.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/cache.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/linux/cache.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/linux/config.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/linux/cache.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/processor.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/linux/config.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/processor.h=0A=
00000000 l    df *ABS*	00000000 r4k_switch.S=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/pgtable.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/page.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/pgtable.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/addrspace.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/pgtable.h=0A=
00000000 l    df *ABS*	00000000 r4k_switch.S=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/page.h=0A=
00000000 l    df *ABS*	00000000 r4k_switch.S=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/offset.h=0A=
00000000 l    df *ABS*	00000000 r4k_switch.S=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/mipsregs.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/linux/config.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/mipsregs.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/linux/linkage.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/linux/config.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/linux/linkage.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/mipsregs.h=0A=
00000000 l    df *ABS*	00000000 r4k_switch.S=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/fpregdef.h=0A=
00000000 l    df *ABS*	00000000 r4k_switch.S=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/current.h=0A=
00000000 l    df *ABS*	00000000 r4k_switch.S=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/cachectl.h=0A=
00000000 l    df *ABS*	00000000 r4k_switch.S=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/bootinfo.h=0A=
00000000 l    df *ABS*	00000000 r4k_switch.S=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/asm.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/sgidefs.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/asm.h=0A=
00000000 l    df *ABS*	00000000 r4k_switch.S=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/linux/config.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/linux/autoconf.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/linux/config.h=0A=
00000000 l    df *ABS*	00000000 r4k_switch.S=0A=
00000000 l    df *ABS*	00000000 irq.c=0A=
8010d308 l     F .text	00000000 enable_none=0A=
8010d310 l     F .text	00000000 startup_none=0A=
8010d318 l     F .text	00000000 disable_none=0A=
8010d320 l     F .text	00000000 ack_none=0A=
80219030 l     O .data	00000010 probe_sem=0A=
00000000 l    df *ABS*	00000000 i8259.c=0A=
8010e180 l     F .text	00000000 end_8259A_irq=0A=
8010e1c0 l     F .text	00000000 startup_8259A_irq=0A=
80219040 l     O .data	00000020 i8259A_irq_type=0A=
80219060 l     O .data	00000004 cached_irq_mask=0A=
80219064 l     O .data	00000004 spurious_irq_mask.0=0A=
80219068 l     O .data	00000018 irq2=0A=
80219080 l     O .data	0000001c pic1_io_resource=0A=
8021909c l     O .data	0000001c pic2_io_resource=0A=
00000000 l    df *ABS*	00000000 proc.c=0A=
802190c0 l     O .data	000000b0 cpu_name=0A=
8010e5c0 l     F .text	00000000 show_cpuinfo=0A=
8010e868 l     F .text	00000000 c_start=0A=
8010e874 l     F .text	00000000 c_next=0A=
8010e8ac l     F .text	00000000 c_stop=0A=
00000000 l    df *ABS*	00000000 extable.c=0A=
00000000 l    df *ABS*	00000000 init.c=0A=
80316494 l     O .bss	00000004 totalram_pages=0A=
00000000 l    df *ABS*	00000000 ioremap.c=0A=
8010eee0 l     F .text	00000000 remap_area_pages=0A=
00000000 l    df *ABS*	00000000 fault.c=0A=
00000000 l    df *ABS*	00000000 loadmmu.c=0A=
00000000 l    df *ABS*	00000000 pg-r4k.S=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/mipsregs.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/linux/config.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/mipsregs.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/linux/linkage.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/linux/config.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/linux/autoconf.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/linux/config.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/linux/linkage.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/mipsregs.h=0A=
00000000 l    df *ABS*	00000000 pg-r4k.S=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/cacheops.h=0A=
00000000 l    df *ABS*	00000000 pg-r4k.S=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/regdef.h=0A=
00000000 l    df *ABS*	00000000 pg-r4k.S=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/asm.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/sgidefs.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/asm.h=0A=
00000000 l    df *ABS*	00000000 pg-r4k.S=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/addrspace.h=0A=
00000000 l    df *ABS*	00000000 pg-r4k.S=0A=
00000000 l    df *ABS*	00000000 c-r4k.c=0A=
8010fff0 l     F .text	00000000 no_sc_noop=0A=
80219180 l     O .data	00000010 no_sc_ops=0A=
8010fff8 l     F .text	00000000 r4k_flush_cache_range_s16d16i16=0A=
803164e4 l     O .bss	00000004 dcache_size=0A=
803164e0 l     O .bss	00000004 icache_size=0A=
803164f0 l     O .bss	00000004 scache_size=0A=
801103ec l     F .text	00000000 r4k_flush_cache_range_s32d16i16=0A=
801107e0 l     F .text	00000000 r4k_flush_cache_range_s64d16i16=0A=
80110c44 l     F .text	00000000 r4k_flush_cache_range_s128d16i16=0A=
80111018 l     F .text	00000000 r4k_flush_cache_range_s32d32i32=0A=
8011140c l     F .text	00000000 r4k_flush_cache_range_s64d32i32=0A=
80111870 l     F .text	00000000 r4k_flush_cache_range_s128d32i32=0A=
80111c44 l     F .text	00000000 r4k_flush_cache_range_d16i16=0A=
80111dfc l     F .text	00000000 r4k_flush_cache_range_d32i32=0A=
80111fb4 l     F .text	00000000 r4k_flush_cache_mm_s16d16i16=0A=
8011221c l     F .text	00000000 r4k_flush_cache_mm_s32d16i16=0A=
80112484 l     F .text	00000000 r4k_flush_cache_mm_s64d16i16=0A=
801126ec l     F .text	00000000 r4k_flush_cache_mm_s128d16i16=0A=
80112954 l     F .text	00000000 r4k_flush_cache_mm_s32d32i32=0A=
80112bbc l     F .text	00000000 r4k_flush_cache_mm_s64d32i32=0A=
80112e24 l     F .text	00000000 r4k_flush_cache_mm_s128d32i32=0A=
8011308c l     F .text	00000000 r4k_flush_cache_mm_d16i16=0A=
80113244 l     F .text	00000000 r4k_flush_cache_mm_d32i32=0A=
801133fc l     F .text	00000000 r4k_flush_cache_page_s16d16i16=0A=
801136a8 l     F .text	00000000 r4k_flush_cache_page_s32d16i16=0A=
80113954 l     F .text	00000000 r4k_flush_cache_page_s64d16i16=0A=
80113c00 l     F .text	00000000 r4k_flush_cache_page_s128d16i16=0A=
80113e70 l     F .text	00000000 r4k_flush_cache_page_s32d32i32=0A=
8011411c l     F .text	00000000 r4k_flush_cache_page_s64d32i32=0A=
801143c8 l     F .text	00000000 r4k_flush_cache_page_s128d32i32=0A=
80114638 l     F .text	00000000 r4k_flush_cache_page_d16i16=0A=
8011483c l     F .text	00000000 r4k_flush_cache_page_d32i32=0A=
80114a64 l     F .text	00000000 r4k_flush_cache_page_d32i32_r4600=0A=
80114d34 l     F .text	00000000 r4k_flush_page_to_ram_s16=0A=
80114de0 l     F .text	00000000 r4k_flush_page_to_ram_s32=0A=
80114e8c l     F .text	00000000 r4k_flush_page_to_ram_s64=0A=
80114f38 l     F .text	00000000 r4k_flush_page_to_ram_s128=0A=
80114fc4 l     F .text	00000000 r4k_flush_page_to_ram_d16=0A=
80115070 l     F .text	00000000 r4k_flush_page_to_ram_d32=0A=
80115134 l     F .text	00000000 r4k_flush_page_to_ram_d32_r4600=0A=
8011523c l     F .text	00000000 r4k_flush_icache_page_s=0A=
80115244 l     F .text	00000000 r4k_flush_icache_range=0A=
80115268 l     F .text	00000000 r4k_flush_icache_page_p=0A=
80115298 l     F .text	00000000 r4k_dma_cache_wback_inv_pc=0A=
803164ec l     O .bss	00000004 dc_lsize=0A=
8011535c l     F .text	00000000 r4k_dma_cache_wback_inv_sc=0A=
803164f4 l     O .bss	00000004 sc_lsize=0A=
801153cc l     F .text	00000000 r4k_dma_cache_inv_pc=0A=
80115490 l     F .text	00000000 r4k_dma_cache_inv_sc=0A=
80115500 l     F .text	00000000 r4k_dma_cache_wback=0A=
80115518 l     F .text	00000000 r4k_flush_cache_sigtramp=0A=
803164e8 l     O .bss	00000004 ic_lsize=0A=
80115558 l     F .text	00000000 r4600v20k_flush_cache_sigtramp=0A=
80204958 l     F .text.init	00000000 probe_icache=0A=
802049f0 l     F .text.init	00000000 probe_dcache=0A=
80204a88 l     F .text.init	00000000 probe_scache=0A=
80204c84 l     F .text.init	00000000 setup_noscache_funcs=0A=
80116804 l     F .text	00000000 r4k_flush_cache_all_d32i32=0A=
80116658 l     F .text	00000000 r4k_flush_cache_all_d16i16=0A=
80204e44 l     F .text.init	00000000 setup_scache_funcs=0A=
801155d4 l     F .text	00000000 r4k_flush_cache_all_s16d16i16=0A=
801163fc l     F .text	00000000 r4k_flush_cache_all_s128d32i32=0A=
80115ce8 l     F .text	00000000 r4k_flush_cache_all_s128d16i16=0A=
801161a0 l     F .text	00000000 r4k_flush_cache_all_s64d32i32=0A=
80115a8c l     F .text	00000000 r4k_flush_cache_all_s64d16i16=0A=
80115f44 l     F .text	00000000 r4k_flush_cache_all_s32d32i32=0A=
80115830 l     F .text	00000000 r4k_flush_cache_all_s32d16i16=0A=
00000000 l    df *ABS*	00000000 tlb-r4k.c=0A=
8020fc5c l     O .data.init	00000004 temp_tlb_entry=0A=
80205530 l     F .text.init	00000000 probe_tlb=0A=
00000000 l    df *ABS*	00000000 tlbex-r4k.S=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/stackframe.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/linux/config.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/stackframe.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/offset.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/stackframe.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/asm.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/stackframe.h=0A=
00000000 l    df *ABS*	00000000 /opt/iDISX/src/linux/include/asm/process=
or.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/stackframe.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/mipsregs.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/stackframe.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/addrspace.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/stackframe.h=0A=
00000000 l    df *ABS*	00000000 tlbex-r4k.S=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/regdef.h=0A=
00000000 l    df *ABS*	00000000 tlbex-r4k.S=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/processor.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/isadep.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/linux/config.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/isadep.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/processor.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/linux/cache.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/cache.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/linux/config.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/cache.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/linux/cache.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/linux/config.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/linux/cache.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/processor.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/linux/config.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/processor.h=0A=
00000000 l    df *ABS*	00000000 tlbex-r4k.S=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/pgtable.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/page.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/pgtable.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/addrspace.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/pgtable.h=0A=
00000000 l    df *ABS*	00000000 tlbex-r4k.S=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/page.h=0A=
00000000 l    df *ABS*	00000000 tlbex-r4k.S=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/mipsregs.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/linux/config.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/mipsregs.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/linux/linkage.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/linux/config.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/linux/linkage.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/mipsregs.h=0A=
00000000 l    df *ABS*	00000000 tlbex-r4k.S=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/fpregdef.h=0A=
00000000 l    df *ABS*	00000000 tlbex-r4k.S=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/cachectl.h=0A=
00000000 l    df *ABS*	00000000 tlbex-r4k.S=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/bootinfo.h=0A=
00000000 l    df *ABS*	00000000 tlbex-r4k.S=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/offset.h=0A=
00000000 l    df *ABS*	00000000 tlbex-r4k.S=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/current.h=0A=
00000000 l    df *ABS*	00000000 tlbex-r4k.S=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/asm.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/sgidefs.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/asm.h=0A=
00000000 l    df *ABS*	00000000 tlbex-r4k.S=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/linux/init.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/linux/config.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/linux/autoconf.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/linux/config.h=0A=
00000000 l    df *ABS*	00000000 /opt/iDISX/src/linux/include/linux/init.=
h=0A=
00000000 l    df *ABS*	00000000 tlbex-r4k.S=0A=
80117000 l       .text	00000000 invalid_tlbl=0A=
80117084 l       .text	00000000 nopage_tlbl=0A=
80117204 l       .text	00000000 nopage_tlbs=0A=
80117380 l       .text	00000000 nowrite_mod=0A=
00000000 l    df *ABS*	00000000 sched.c=0A=
802191a8 l     O .data	00000008 runqueue_head=0A=
80211800 l     O .data.cacheline_aligned	00000020 aligned_data=0A=
8011749c l     F .text	00000000 reschedule_idle=0A=
80117574 l     F .text	00000000 process_timeout=0A=
801185c4 l     F .text	00000000 setscheduler=0A=
802191b0 l     O .data	00000018 stat_nam.0=0A=
80118ba0 l     F .text	00000000 show_task=0A=
00000000 l    df *ABS*	00000000 dma.c=0A=
802191d0 l     O .data	00000040 dma_chan_busy=0A=
00000000 l    df *ABS*	00000000 fork.c=0A=
80219210 l     O .data	00000004 next_safe.0=0A=
801194a0 l     F .text	00000000 get_pid=0A=
80119658 l     F .text	00000000 mm_init=0A=
801198a0 l     F .text	00000000 copy_mm=0A=
80119dac l     F .text	00000000 count_open_files=0A=
80119de4 l     F .text	00000000 copy_files=0A=
00000000 l    df *ABS*	00000000 exec_domain.c=0A=
80219220 l     O .data	00000004 exec_domains=0A=
80219224 l     O .data	00000000 exec_domains_lock=0A=
80219224 l     O .data	00000080 ident_map=0A=
8011a950 l     F .text	00000000 default_handler=0A=
8011a9cc l     F .text	00000000 lookup_exec_domain=0A=
802192e0 l     O .data	00000134 abi_table=0A=
80219414 l     O .data	00000058 abi_root_table=0A=
80205e64 l     F .text.init	00000000 abi_register_sysctl=0A=
80210038 l     O .initcall.init	00000004 =
__initcall_abi_register_sysctl=0A=
00000000 l    df *ABS*	00000000 panic.c=0A=
80205e8c l     F .text.init	00000000 panic_setup=0A=
8020fc60 l     O .data.init	00000007 __setup_str_panic_setup=0A=
8020ffa8 l     O .setup.init	00000008 __setup_panic_setup=0A=
80318a80 l     O .bss	00000400 buf.0=0A=
80318e80 l     O .bss	00000014 buf.1=0A=
00000000 l    df *ABS*	00000000 printk.c=0A=
80219498 l     O .data	00000010 console_sem=0A=
802194a8 l     O .data	00000000 logbuf_lock=0A=
802194a8 l     O .data	00000004 preferred_console=0A=
8020fc68 l     O .data.init	00000009 __setup_str_console_setup=0A=
8020ffb0 l     O .setup.init	00000008 __setup_console_setup=0A=
8031d2a8 l     O .bss	00000004 log_start=0A=
8031d2b0 l     O .bss	00000004 log_end=0A=
803192a8 l     O .bss	00004000 log_buf=0A=
8031d2b4 l     O .bss	00000004 logged_chars=0A=
8011b4e8 l     F .text	00000000 __call_console_drivers=0A=
8011b570 l     F .text	00000000 _call_console_drivers=0A=
802194ac l     O .data	00000004 msg_level.0=0A=
8011b5f0 l     F .text	00000000 call_console_drivers=0A=
8011b774 l     F .text	00000000 emit_log_char=0A=
8031d2ac l     O .bss	00000004 con_start=0A=
80318ea0 l     O .bss	00000400 printk_buf.1=0A=
802194b0 l     O .data	00000004 log_level_unknown.2=0A=
8031d338 l     O .bss	00000004 console_may_schedule=0A=
00000000 l    df *ABS*	00000000 module.c=0A=
802194c0 l     O .data	00000008 archdata.0=0A=
8021952c l     O .data	00000008 ime_list=0A=
80219534 l     O .data	00000000 ime_lock=0A=
8031d340 l     O .bss	00000004 kmalloc_failed=0A=
80219534 l     O .data	00000000 unload_lock=0A=
8011d24c l     F .text	00000000 qm_modules=0A=
8011d3b8 l     F .text	00000000 qm_deps=0A=
8011d598 l     F .text	00000000 qm_refs=0A=
8011d744 l     F .text	00000000 qm_symbols=0A=
8011d958 l     F .text	00000000 qm_info=0A=
8011e3f8 l     F .text	00000000 s_start=0A=
8011e4b0 l     F .text	00000000 s_next=0A=
8011e530 l     F .text	00000000 s_stop=0A=
8011e56c l     F .text	00000000 s_show=0A=
00000000 l    df *ABS*	00000000 exit.c=0A=
8011e83c l     F .text	00000000 will_become_orphaned_pgrp=0A=
8011ee24 l     F .text	00000000 exit_notify=0A=
00000000 l    df *ABS*	00000000 itimer.c=0A=
8011f870 l     F .text	00000000 tvtojiffies=0A=
8011f8c0 l     F .text	00000000 jiffiestotv=0A=
00000000 l    df *ABS*	00000000 info.c=0A=
00000000 l    df *ABS*	00000000 time.c=0A=
8011fe40 l     F .text	00000000 do_normal_gettime=0A=
80219554 l     O .data	00000004 firsttime.0=0A=
00000000 l    df *ABS*	00000000 softirq.c=0A=
80211860 l     O .data.cacheline_aligned	00000100 softirq_vec=0A=
80120c30 l     F .text	00000000 tasklet_action=0A=
80120d80 l     F .text	00000000 tasklet_hi_action=0A=
80120fb0 l     F .text	00000000 bh_action=0A=
8031d620 l     O .bss	00000080 bh_base=0A=
8012119c l     F .text	00000000 ksoftirqd=0A=
8020617c l     F .text.init	00000000 spawn_ksoftirqd=0A=
8021003c l     O .initcall.init	00000004 __initcall_spawn_ksoftirqd=0A=
00000000 l    df *ABS*	00000000 resource.c=0A=
802195a8 l     O .data	00000000 resource_lock=0A=
801212e0 l     F .text	00000000 do_resource_list=0A=
80121414 l     F .text	00000000 __request_resource=0A=
80121494 l     F .text	00000000 __release_resource=0A=
80121570 l     F .text	00000000 find_resource=0A=
802195a8 l     O .data	00000004 reserved.0=0A=
8031d6a0 l     O .bss	00000070 reserve.1=0A=
80206208 l     F .text.init	00000000 reserve_setup=0A=
8020fc74 l     O .data.init	00000009 __setup_str_reserve_setup=0A=
8020ffb8 l     O .setup.init	00000008 __setup_reserve_setup=0A=
00000000 l    df *ABS*	00000000 sysctl.c=0A=
802195b0 l     O .data	00000004 maxolduid=0A=
802195b4 l     O .data	0000000c root_table_header=0A=
80219648 l     O .data	00000160 root_table=0A=
80122218 l     F .text	00000000 proc_readsys=0A=
80122250 l     F .text	00000000 proc_writesys=0A=
80219608 l     O .data	00000040 proc_sys_inode_operations=0A=
80122288 l     F .text	00000000 proc_sys_permission=0A=
802197a8 l     O .data	000004d0 kern_table=0A=
80219c78 l     O .data	00000160 vm_table=0A=
80219dd8 l     O .data	0000002c proc_table=0A=
80219e04 l     O .data	00000210 fs_table=0A=
8021a014 l     O .data	0000002c debug_table=0A=
8021a040 l     O .data	0000002c dev_table=0A=
801224ec l     F .text	00000000 proc_doutsstring=0A=
8031d710 l     O .bss	00000004 minolduid=0A=
80121f28 l     F .text	00000000 register_proc_table=0A=
80121adc l     F .text	00000000 parse_table=0A=
80121a78 l     F .text	00000000 test_perm=0A=
80122088 l     F .text	00000000 unregister_proc_table=0A=
80122148 l     F .text	00000000 do_rw_proc=0A=
801225a8 l     F .text	00000000 do_proc_dointvec=0A=
80122f38 l     F .text	00000000 do_proc_doulongvec_minmax=0A=
00000000 l    df *ABS*	00000000 acct.c=0A=
00000000 l    df *ABS*	00000000 capability.c=0A=
801239c4 l     F .text	00000000 cap_set_pg=0A=
80123a18 l     F .text	00000000 cap_set_all=0A=
00000000 l    df *ABS*	00000000 ptrace.c=0A=
801240ac l     F .text	00000000 access_one_page=0A=
8012432c l     F .text	00000000 access_mm=0A=
00000000 l    df *ABS*	00000000 timer.c=0A=
801eaf80 l     O .text	00000014 tvecs=0A=
8031df78 l     O .bss	00000804 tv1=0A=
8031dd74 l     O .bss	00000204 tv2=0A=
8031db70 l     O .bss	00000204 tv3=0A=
8031d96c l     O .bss	00000204 tv4=0A=
8031d768 l     O .bss	00000204 tv5=0A=
8031e77c l     O .bss	00000004 timer_jiffies=0A=
80124b30 l     F .text	00000000 second_overflow=0A=
80124e48 l     F .text	00000000 update_wall_time_one_tick=0A=
80124f44 l     F .text	00000000 update_wall_time=0A=
801251f4 l     F .text	00000000 count_active_tasks=0A=
8021a0b8 l     O .data	00000004 count.0=0A=
00000000 l    df *ABS*	00000000 user.c=0A=
8021a0c0 l     O .data	00000000 uidhash_lock=0A=
8031e790 l     O .bss	00000004 uid_cachep=0A=
8031e794 l     O .bss	00000400 uidhash_table=0A=
8020634c l     F .text.init	00000000 uid_cache_init=0A=
80210040 l     O .initcall.init	00000004 __initcall_uid_cache_init=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/linux/sched.h=0A=
00000000 l    df *ABS*	00000000 signal.c=0A=
8031eba0 l     O .bss	00000004 sigqueue_cachep=0A=
80125b10 l     F .text	00000000 next_signal=0A=
80125bd0 l     F .text	00000000 flush_sigqueue=0A=
80125ea0 l     F .text	00000000 collect_signal=0A=
8012619c l     F .text	00000000 rm_from_queue=0A=
80126294 l     F .text	00000000 rm_sig_from_queue=0A=
80126358 l     F .text	00000000 signal_type=0A=
801263cc l     F .text	00000000 ignored_signal=0A=
80126430 l     F .text	00000000 handle_stop_signal=0A=
801264dc l     F .text	00000000 send_signal=0A=
801266ac l     F .text	00000000 deliver_signal=0A=
80126b1c l     F .text	00000000 kill_something_info=0A=
80126d5c l     F .text	00000000 wake_up_parent=0A=
80127ea4 l     F .text	00000000 recalc_sigpending=0A=
00000000 l    df *ABS*	00000000 sys.c=0A=
8031ebb0 l     O .bss	00000004 reboot_notifier_list=0A=
8012806c l     F .text	00000000 proc_sel=0A=
801284f8 l     F .text	00000000 deferred_cad=0A=
8021a108 l     O .data	00000014 cad_tq.0=0A=
8012877c l     F .text	00000000 set_user=0A=
80129580 l     F .text	00000000 supplemental_group_member=0A=
00000000 l    df *ABS*	00000000 kmod.c=0A=
8021a230 l     O .data	00000010 envp.0=0A=
8012a45c l     F .text	00000000 exec_modprobe=0A=
8021a240 l     O .data	00000004 kmod_concurrent.1=0A=
8031ebc0 l     O .bss	00000004 kmod_loop_msg.2=0A=
8012a82c l     F .text	00000000 ____call_usermodehelper=0A=
8012a868 l     F .text	00000000 __call_usermodehelper=0A=
8021a248 l     O .data	00000010 dev_probe_sem=0A=
00000000 l    df *ABS*	00000000 context.c=0A=
8021a260 l     O .data	00000008 tq_context=0A=
8021a268 l     O .data	00000008 context_task_wq=0A=
8021a270 l     O .data	00000008 context_task_done=0A=
8012aa60 l     F .text	00000000 need_keventd=0A=
8031ebd0 l     O .bss	00000004 keventd_running=0A=
8031ebd4 l     O .bss	00000004 keventd_task=0A=
8012abc0 l     F .text	00000000 context_thread=0A=
8031ebd8 l     O .bss	00000014 dummy_task=0A=
8020fc80 l     O .data.init	0000000c startup.0=0A=
00000000 l    df *ABS*	00000000 ksyms.c=0A=
00000000 l    df *ABS*	00000000 memory.c=0A=
8012b648 l     F .text	00000000 follow_page=0A=
8012c2a0 l     F .text	00000000 do_wp_page=0A=
8012c5a8 l     F .text	00000000 vmtruncate_list=0A=
8012c870 l     F .text	00000000 do_swap_page=0A=
8012ca30 l     F .text	00000000 do_anonymous_page=0A=
8012cbac l     F .text	00000000 do_no_page=0A=
00000000 l    df *ABS*	00000000 mmap.c=0A=
8012d2f4 l     F .text	00000000 find_vma_prepare=0A=
8012d37c l     F .text	00000000 __vma_link=0A=
8012d460 l     F .text	00000000 vma_merge=0A=
8012df1c l     F .text	00000000 unmap_fixup=0A=
8012e0fc l     F .text	00000000 free_pgtables=0A=
00000000 l    df *ABS*	00000000 filemap.c=0A=
8012eb20 l     F .text	00000000 add_page_to_hash_queue=0A=
8012ee14 l     F .text	00000000 do_flushpage=0A=
8012ee58 l     F .text	00000000 truncate_complete_page=0A=
8012eedc l     F .text	00000000 truncate_list_pages=0A=
8012f174 l     F .text	00000000 invalidate_list_pages2=0A=
8012f3d8 l     F .text	00000000 writeout_one_page=0A=
8012f4cc l     F .text	00000000 do_buffer_fdatasync=0A=
8012fb6c l     F .text	00000000 page_cache_read=0A=
8012fc8c l     F .text	00000000 read_cluster_nonblocking=0A=
8012fe98 l     F .text	00000000 __lock_page=0A=
801300a4 l     F .text	00000000 __find_lock_page_helper=0A=
8013043c l     F .text	00000000 generic_file_readahead=0A=
80130c1c l     F .text	00000000 generic_file_direct_IO=0A=
801310b4 l     F .text	00000000 file_send_actor=0A=
801313fc l     F .text	00000000 do_readahead=0A=
8013157c l     F .text	00000000 nopage_sequential_readahead=0A=
8021a2dc l     O .data	0000000c generic_file_vm_ops=0A=
80131dbc l     F .text	00000000 msync_interval=0A=
8013202c l     F .text	00000000 madvise_fixup_start=0A=
80132198 l     F .text	00000000 madvise_fixup_end=0A=
80132304 l     F .text	00000000 madvise_fixup_middle=0A=
80132534 l     F .text	00000000 madvise_behavior=0A=
80132604 l     F .text	00000000 madvise_willneed=0A=
801327cc l     F .text	00000000 madvise_dontneed=0A=
8013280c l     F .text	00000000 madvise_vma=0A=
801329ac l     F .text	00000000 mincore_page=0A=
80132a44 l     F .text	00000000 mincore_vma=0A=
00000000 l    df *ABS*	00000000 mprotect.c=0A=
801337c0 l     F .text	00000000 change_protection=0A=
801339d8 l     F .text	00000000 mprotect_fixup=0A=
00000000 l    df *ABS*	00000000 mlock.c=0A=
80134190 l     F .text	00000000 mlock_fixup=0A=
80134590 l     F .text	00000000 do_mlock=0A=
801347f8 l     F .text	00000000 do_mlockall=0A=
00000000 l    df *ABS*	00000000 mremap.c=0A=
80134990 l     F .text	00000000 move_one_page=0A=
80134ac8 l     F .text	00000000 move_page_tables=0A=
00000000 l    df *ABS*	00000000 vmalloc.c=0A=
00000000 l    df *ABS*	00000000 slab.c=0A=
8021a2f0 l     O .data	00000004 slab_break_gfp_order=0A=
8021a2f4 l     O .data	000000a8 cache_sizes=0A=
8021a39c l     O .data	0000006c cache_cache=0A=
8021a408 l     O .data	00000004 clock_searchp=0A=
80135c20 l     F .text	00000000 kmem_cache_estimate=0A=
8031ec48 l     O .bss	00000010 cache_chain_sem=0A=
8031ec40 l     O .bss	00000004 offslab_limit=0A=
80210044 l     O .initcall.init	00000004 =
__initcall_kmem_cpucache_init=0A=
80135ccc l     F .text	00000000 kmem_slab_destroy=0A=
801362a0 l     F .text	00000000 __kmem_cache_shrink=0A=
801365e0 l     F .text	00000000 kmem_cache_grow=0A=
80137328 l     F .text	00000000 proc_getdata=0A=
00000000 l    df *ABS*	00000000 bootmem.c=0A=
80206750 l     F .text.init	00000000 init_bootmem_core=0A=
80206830 l     F .text.init	00000000 reserve_bootmem_core=0A=
802069c8 l     F .text.init	00000000 free_bootmem_core=0A=
80206afc l     F .text.init	00000000 __alloc_bootmem_core=0A=
80206eb0 l     F .text.init	00000000 free_all_bootmem_core=0A=
00000000 l    df *ABS*	00000000 swap.c=0A=
00000000 l    df *ABS*	00000000 vmscan.c=0A=
80137980 l     F .text	00000000 swap_out=0A=
80137f58 l     F .text	00000000 shrink_cache=0A=
801383ac l     F .text	00000000 refill_inactive=0A=
80138590 l     F .text	00000000 shrink_caches=0A=
801386d8 l     F .text	00000000 check_classzone_need_balance=0A=
80138718 l     F .text	00000000 kswapd_balance_pgdat=0A=
801387f0 l     F .text	00000000 kswapd_balance=0A=
80138838 l     F .text	00000000 kswapd_can_sleep_pgdat=0A=
80138884 l     F .text	00000000 kswapd_can_sleep=0A=
802072a4 l     F .text.init	00000000 kswapd_init=0A=
80210048 l     O .initcall.init	00000004 __initcall_kswapd_init=0A=
00000000 l    df *ABS*	00000000 page_io.c=0A=
801389d0 l     F .text	00000000 rw_swap_page_base=0A=
00000000 l    df *ABS*	00000000 page_alloc.c=0A=
8021a430 l     O .data	0000000c zone_names=0A=
8020fc8c l     O .data.init	0000000c zone_balance_ratio=0A=
8020fc98 l     O .data.init	0000000c zone_balance_min=0A=
8020fca4 l     O .data.init	0000000c zone_balance_max=0A=
80138d70 l     F .text	00000000 __free_pages_ok=0A=
8013922c l     F .text	00000000 rmqueue=0A=
80139698 l     F .text	00000000 balance_classzone=0A=
80207894 l     F .text.init	00000000 setup_mem_frac=0A=
8020fcb0 l     O .data.init	00000009 __setup_str_setup_mem_frac=0A=
8020ffc0 l     O .setup.init	00000008 __setup_setup_mem_frac=0A=
00000000 l    df *ABS*	00000000 swap_state.c=0A=
8013a040 l     F .text	00000000 swap_writepage=0A=
8021a440 l     O .data	00000024 swap_aops=0A=
8031eca0 l     O .bss	00000018 swap_cache_info=0A=
00000000 l    df *ABS*	00000000 swapfile.c=0A=
801ebbf0 l     O .text	00000015 Bad_file=0A=
801ebc08 l     O .text	00000018 Unused_file=0A=
801ebc20 l     O .text	00000017 Bad_offset=0A=
801ebc38 l     O .text	0000001a Unused_offset=0A=
8013a838 l     F .text	00000000 swap_info_get=0A=
8013a94c l     F .text	00000000 swap_info_put=0A=
8013a954 l     F .text	00000000 swap_entry_free=0A=
8013aa0c l     F .text	00000000 exclusive_swap_page=0A=
8013adbc l     F .text	00000000 unuse_vma=0A=
8013b070 l     F .text	00000000 unuse_process=0A=
8013b0e8 l     F .text	00000000 find_next_to_unuse=0A=
8013b140 l     F .text	00000000 try_to_unuse=0A=
8031f348 l     O .bss	00000004 swap_overflow=0A=
8021a4a8 l     O .data	00000004 least_priority.0=0A=
00000000 l    df *ABS*	00000000 numa.c=0A=
8031f350 l     O .bss	00000014 contig_bootmem_data=0A=
00000000 l    df *ABS*	00000000 oom_kill.c=0A=
8013c7c0 l     F .text	00000000 int_sqrt=0A=
8013c810 l     F .text	00000000 badness=0A=
8013c940 l     F .text	00000000 select_bad_process=0A=
8013ca48 l     F .text	00000000 oom_kill=0A=
8031f370 l     O .bss	00000004 first.0=0A=
8031f374 l     O .bss	00000004 last.1=0A=
8031f378 l     O .bss	00000004 count.2=0A=
00000000 l    df *ABS*	00000000 shmem.c=0A=
8021a7d8 l     O .data	00000000 shmem_ilock=0A=
8013cb90 l     F .text	00000000 shmem_recalc_inode=0A=
8013cbdc l     F .text	00000000 shmem_swp_entry=0A=
8013cc84 l     F .text	00000000 shmem_free_swp=0A=
8013ccfc l     F .text	00000000 shmem_truncate=0A=
8013cfdc l     F .text	00000000 shmem_delete_inode=0A=
8013d060 l     F .text	00000000 shmem_clear_swp=0A=
8013d0d8 l     F .text	00000000 shmem_unuse_inode=0A=
8013d270 l     F .text	00000000 shmem_writepage=0A=
8013d428 l     F .text	00000000 shmem_getpage_locked=0A=
8013d7a8 l     F .text	00000000 shmem_getpage=0A=
8013da14 l     F .text	00000000 shmem_mmap=0A=
8021a950 l     O .data	0000000c shmem_vm_ops=0A=
8021a7dc l     O .data	00000024 shmem_aops=0A=
8021a8d0 l     O .data	00000040 shmem_dir_inode_operations=0A=
8021a888 l     O .data	00000048 shmem_dir_operations=0A=
8021a848 l     O .data	00000040 shmem_inode_operations=0A=
8021a800 l     O .data	00000048 shmem_file_operations=0A=
8013dc10 l     F .text	00000000 shmem_set_size=0A=
8013dc64 l     F .text	00000000 shmem_read_super=0A=
8021a910 l     O .data	00000040 shmem_ops=0A=
8021a95c l     O .data	0000001c tmpfs_fs_type=0A=
80207968 l     F .text.init	00000000 init_shmem_fs=0A=
8031f380 l     O .bss	00000004 shm_mnt=0A=
8021004c l     O .initcall.init	00000004 __initcall_init_shmem_fs=0A=
00000000 l    df *ABS*	00000000 open.c=0A=
8013f274 l     F .text	00000000 chown_common=0A=
8021a980 l     O .data	00000008 kill_list.0=0A=
00000000 l    df *ABS*	00000000 read_write.c=0A=
801401f8 l     F .text	00000000 do_readv_writev=0A=
00000000 l    df *ABS*	00000000 devices.c=0A=
8021a9e0 l     O .data	00000000 chrdevs_lock=0A=
8031f3d0 l     O .bss	000007f8 chrdevs=0A=
801408f8 l     F .text	00000000 get_chrfops=0A=
8021a9e0 l     O .data	00000048 def_chr_fops=0A=
8031f390 l     O .bss	00000020 buffer.0=0A=
8031f3b0 l     O .bss	00000020 buffer.1=0A=
80140c90 l     F .text	00000000 sock_no_open=0A=
8021aa28 l     O .data	00000048 bad_sock_fops=0A=
00000000 l    df *ABS*	00000000 file_table.c=0A=
8021aa7c l     O .data	00000008 anon_list=0A=
8021aa84 l     O .data	00000008 free_list=0A=
8021aa8c l     O .data	00000004 old_max.0=0A=
00000000 l    df *ABS*	00000000 buffer.c=0A=
8021aa90 l     O .data	00000000 hash_table_lock=0A=
8021aa90 l     O .data	00000000 lru_list_lock=0A=
8021aa90 l     O .data	00000000 unused_list_lock=0A=
8021aa90 l     O .data	00000008 buffer_wait=0A=
80141448 l     F .text	00000000 write_locked_buffers=0A=
801414a0 l     F .text	00000000 write_some_buffers=0A=
8031fbdc l     O .bss	0000000c lru_list=0A=
8031fbe8 l     O .bss	0000000c nr_buffers_type=0A=
80142bf4 l     F .text	00000000 __refile_buffer=0A=
801415fc l     F .text	00000000 write_unlocked_buffers=0A=
8014164c l     F .text	00000000 wait_for_buffers=0A=
8014175c l     F .text	00000000 wait_for_locked_buffers=0A=
80141cb4 l     F .text	00000000 __insert_into_lru_list=0A=
8031fbf4 l     O .bss	0000000c size_buffers_type=0A=
80141da0 l     F .text	00000000 __remove_from_lru_list=0A=
80141e30 l     F .text	00000000 __remove_from_queues=0A=
80141e70 l     F .text	00000000 remove_from_queues=0A=
8031fbd4 l     O .bss	00000004 bh_hash_shift=0A=
8031fbd0 l     O .bss	00000004 bh_hash_mask=0A=
8031fbd8 l     O .bss	00000004 hash_table=0A=
80141fc0 l     F .text	00000000 __remove_inode_queue=0A=
8014223c l     F .text	00000000 free_more_memory=0A=
8021ab08 l     O .data	00000000 page_uptodate_lock.0=0A=
801422c4 l     F .text	00000000 end_buffer_io_async=0A=
80145064 l     F .text	00000000 grow_buffers=0A=
80142a5c l     F .text	00000000 balance_dirty_state=0A=
80142dd8 l     F .text	00000000 __put_unused_buffer_head=0A=
8031fc04 l     O .bss	00000004 nr_unused_buffer_heads=0A=
8031fc00 l     O .bss	00000004 unused_list=0A=
80142fd8 l     F .text	00000000 create_buffers=0A=
801430e8 l     F .text	00000000 discard_buffer=0A=
8014342c l     F .text	00000000 unmap_underlying_metadata=0A=
801434d0 l     F .text	00000000 __block_write_full_page=0A=
801436f0 l     F .text	00000000 __block_prepare_write=0A=
801439cc l     F .text	00000000 __block_commit_write=0A=
801446b4 l     F .text	00000000 end_buffer_io_kiobuf=0A=
80144728 l     F .text	00000000 wait_kio=0A=
80144e2c l     F .text	00000000 grow_dev_page=0A=
80144f40 l     F .text	00000000 hash_page_buffers=0A=
8014522c l     F .text	00000000 sync_page_buffers=0A=
8014554c l     F .text	00000000 sync_old_buffers=0A=
8020fcbc l     O .data.init	0000000c startup.1=0A=
80207b74 l     F .text.init	00000000 bdflush_init=0A=
80210050 l     O .initcall.init	00000004 __initcall_bdflush_init=0A=
00000000 l    df *ABS*	00000000 super.c=0A=
8021ab18 l     O .data	00000000 file_systems_lock=0A=
80145ad0 l     F .text	00000000 get_filesystem=0A=
80145b08 l     F .text	00000000 put_filesystem=0A=
80145b40 l     F .text	00000000 find_filesystem=0A=
8031fc14 l     O .bss	00000004 file_systems=0A=
80145c88 l     F .text	00000000 fs_index=0A=
80145d60 l     F .text	00000000 fs_name=0A=
80145e18 l     F .text	00000000 fs_maxindex=0A=
8014602c l     F .text	00000000 put_super=0A=
801463f0 l     F .text	00000000 alloc_super=0A=
80146508 l     F .text	00000000 read_super=0A=
8031fc18 l     O .bss	00000020 unnamed_dev_in_use=0A=
801467e4 l     F .text	00000000 grab_super=0A=
80146868 l     F .text	00000000 get_sb_bdev=0A=
80146bf0 l     F .text	00000000 get_sb_nodev=0A=
80146c8c l     F .text	00000000 get_sb_single=0A=
80207bdc l     F .text.init	00000000 root_data_setup=0A=
8020fce0 l     O .data.init	00000004 root_mount_data=0A=
80207bec l     F .text.init	00000000 fs_names_setup=0A=
8020fce4 l     O .data.init	00000004 root_fs_names=0A=
8020fcc8 l     O .data.init	0000000b __setup_str_root_data_setup=0A=
8020ffc8 l     O .setup.init	00000008 __setup_root_data_setup=0A=
8020fcd4 l     O .data.init	0000000c __setup_str_fs_names_setup=0A=
8020ffd0 l     O .setup.init	00000008 __setup_fs_names_setup=0A=
80207bfc l     F .text.init	00000000 get_fs_names=0A=
00000000 l    df *ABS*	00000000 block_dev.c=0A=
80147470 l     F .text	00000000 max_block=0A=
80147514 l     F .text	00000000 blkdev_size=0A=
80147560 l     F .text	00000000 kill_bdev=0A=
80147700 l     F .text	00000000 blkdev_get_block=0A=
8014776c l     F .text	00000000 blkdev_direct_IO=0A=
80147798 l     F .text	00000000 blkdev_writepage=0A=
801477bc l     F .text	00000000 blkdev_readpage=0A=
801477e4 l     F .text	00000000 blkdev_prepare_write=0A=
80147814 l     F .text	00000000 blkdev_commit_write=0A=
80147838 l     F .text	00000000 block_llseek=0A=
80147920 l     F .text	00000000 __block_fsync=0A=
8014796c l     F .text	00000000 block_fsync=0A=
8021ab20 l     O .data	00000040 sops.0=0A=
8014798c l     F .text	00000000 bd_read_super=0A=
8021ab60 l     O .data	0000001c bd_type=0A=
8021ab7c l     O .data	00000000 bdev_lock=0A=
80147a80 l     F .text	00000000 init_once=0A=
8031fc64 l     O .bss	00000200 bdev_hashtable=0A=
8031fe64 l     O .bss	00000004 bdev_cachep=0A=
8031fc60 l     O .bss	00000004 bd_mnt=0A=
80147af0 l     F .text	00000000 bdfind=0A=
8031fe68 l     O .bss	000007f8 blkdevs=0A=
80148194 l     F .text	00000000 do_open=0A=
80148618 l     F .text	00000000 blkdev_ioctl=0A=
8031fc40 l     O .bss	00000020 buffer.1=0A=
00000000 l    df *ABS*	00000000 char_dev.c=0A=
8021abf0 l     O .data	00000000 cdev_lock=0A=
801486c0 l     F .text	00000000 init_once=0A=
80320660 l     O .bss	00000200 cdev_hashtable=0A=
80320860 l     O .bss	00000004 cdev_cachep=0A=
80148724 l     F .text	00000000 cdfind=0A=
00000000 l    df *ABS*	00000000 stat.c=0A=
8021abf0 l     O .data	00000004 warncount.0=0A=
801488b0 l     F .text	00000000 cp_old_stat=0A=
801489c8 l     F .text	00000000 cp_new_stat=0A=
80148f90 l     F .text	00000000 cp_new_stat64=0A=
00000000 l    df *ABS*	00000000 exec.c=0A=
8021ac00 l     O .data	00000000 binfmt_lock=0A=
80320874 l     O .bss	00000004 formats=0A=
801494c4 l     F .text	00000000 count=0A=
80149bb4 l     F .text	00000000 exec_mmap=0A=
00000000 l    df *ABS*	00000000 pipe.c=0A=
8014ad98 l     F .text	00000000 pipe_read=0A=
8014b058 l     F .text	00000000 pipe_write=0A=
8014b3b8 l     F .text	00000000 pipe_lseek=0A=
8014b3c4 l     F .text	00000000 bad_pipe_r=0A=
8014b3cc l     F .text	00000000 bad_pipe_w=0A=
8014b3d4 l     F .text	00000000 pipe_ioctl=0A=
8014b418 l     F .text	00000000 pipe_poll=0A=
8014b4ac l     F .text	00000000 pipe_release=0A=
8014b5bc l     F .text	00000000 pipe_read_release=0A=
8014b5dc l     F .text	00000000 pipe_write_release=0A=
8014b5fc l     F .text	00000000 pipe_rdwr_release=0A=
8014b624 l     F .text	00000000 pipe_read_open=0A=
8014b6c8 l     F .text	00000000 pipe_write_open=0A=
8014b76c l     F .text	00000000 pipe_rdwr_open=0A=
8014b904 l     F .text	00000000 pipefs_delete_dentry=0A=
8021adb0 l     O .data	00000018 pipefs_dentry_operations=0A=
8014b90c l     F .text	00000000 get_pipe_inode=0A=
80320880 l     O .bss	00000004 pipe_mnt=0A=
8014bd44 l     F .text	00000000 pipefs_statfs=0A=
8021adc8 l     O .data	00000040 pipefs_ops=0A=
8014bd68 l     F .text	00000000 pipefs_read_super=0A=
8021ae08 l     O .data	0000001c pipe_fs_type=0A=
80208330 l     F .text.init	00000000 init_pipe_fs=0A=
80210054 l     O .initcall.init	00000004 __initcall_init_pipe_fs=0A=
00000000 l    df *ABS*	00000000 namei.c=0A=
8021ae30 l     O .data	00000000 arbitration_lock=0A=
8014c1a4 l     F .text	00000000 cached_lookup=0A=
8014c228 l     F .text	00000000 real_lookup=0A=
8014d020 l     F .text	00000000 __emul_lookup_dentry=0A=
8014de2c l     F .text	00000000 lookup_create=0A=
8014e4f8 l     F .text	00000000 d_unhash=0A=
80150458 l     F .text	00000000 page_getlink=0A=
00000000 l    df *ABS*	00000000 fcntl.c=0A=
801507b0 l     F .text	00000000 expand_files=0A=
80150828 l     F .text	00000000 locate_fd=0A=
80150980 l     F .text	00000000 dupfd=0A=
80150c10 l     F .text	00000000 setfl=0A=
80150d78 l     F .text	00000000 do_fcntl=0A=
8021ae70 l     O .data	00000018 band_table=0A=
8015116c l     F .text	00000000 send_sigio_to_task=0A=
8021ae88 l     O .data	00000000 fasync_lock=0A=
80320890 l     O .bss	00000004 fasync_cache=0A=
802083b0 l     F .text.init	00000000 fasync_init=0A=
80210058 l     O .initcall.init	00000004 __initcall_fasync_init=0A=
00000000 l    df *ABS*	00000000 ioctl.c=0A=
801515a0 l     F .text	00000000 file_ioctl=0A=
00000000 l    df *ABS*	00000000 readdir.c=0A=
80151cac l     F .text	00000000 fillonedir=0A=
80151e00 l     F .text	00000000 filldir=0A=
80151fd4 l     F .text	00000000 filldir64=0A=
00000000 l    df *ABS*	00000000 select.c=0A=
80152378 l     F .text	00000000 max_select_fd=0A=
801526e8 l     F .text	00000000 select_bits_alloc=0A=
80152714 l     F .text	00000000 select_bits_free=0A=
80152b8c l     F .text	00000000 do_pollfd=0A=
80152c80 l     F .text	00000000 do_poll=0A=
00000000 l    df *ABS*	00000000 fifo.c=0A=
801530c0 l     F .text	00000000 wait_for_partner=0A=
80153120 l     F .text	00000000 wake_up_partner=0A=
80153144 l     F .text	00000000 fifo_open=0A=
00000000 l    df *ABS*	00000000 locks.c=0A=
8021aef0 l     O .data	00000008 blocked_list=0A=
80153490 l     F .text	00000000 locks_alloc_lock=0A=
803208a0 l     O .bss	00000004 filelock_cache=0A=
8015354c l     F .text	00000000 init_once=0A=
801535f8 l     F .text	00000000 flock_make_lock=0A=
80153680 l     F .text	00000000 assign_type=0A=
801536a4 l     F .text	00000000 flock_to_posix_lock=0A=
801537b4 l     F .text	00000000 flock64_to_posix_lock=0A=
80153938 l     F .text	00000000 lease_alloc=0A=
80153a64 l     F .text	00000000 locks_delete_block=0A=
80153aa4 l     F .text	00000000 locks_insert_block=0A=
80153b64 l     F .text	00000000 locks_wake_up_blocks=0A=
80153c48 l     F .text	00000000 locks_insert_lock=0A=
80153ca8 l     F .text	00000000 locks_delete_lock=0A=
80153dc0 l     F .text	00000000 locks_conflict=0A=
80153e0c l     F .text	00000000 posix_locks_conflict=0A=
80153ee0 l     F .text	00000000 flock_locks_conflict=0A=
80153f48 l     F .text	00000000 interruptible_sleep_on_locked=0A=
80153ff4 l     F .text	00000000 locks_block_on=0A=
8015403c l     F .text	00000000 locks_block_on_timeout=0A=
8015444c l     F .text	00000000 flock_lock_file=0A=
80154f18 l     F .text	00000000 lease_modify=0A=
80155e78 l     F .text	00000000 lock_get_status=0A=
8015612c l     F .text	00000000 move_lock_status=0A=
80208400 l     F .text.init	00000000 filelock_init=0A=
8021005c l     O .initcall.init	00000004 __initcall_filelock_init=0A=
00000000 l    df *ABS*	00000000 dcache.c=0A=
8021af00 l     O .data	00000008 dentry_unused=0A=
803208c0 l     O .bss	00000004 dentry_cache=0A=
80156d5c l     F .text	00000000 select_parent=0A=
803208c8 l     O .bss	00000004 d_hash_shift=0A=
803208c4 l     O .bss	00000004 d_hash_mask=0A=
803208cc l     O .bss	00000004 dentry_hashtable=0A=
80208458 l     F .text.init	00000000 dcache_init=0A=
80157c08 l     F .text	00000000 init_buffer_head=0A=
00000000 l    df *ABS*	00000000 inode.c=0A=
8021af20 l     O .data	00000008 inode_in_use=0A=
8021af28 l     O .data	00000008 inode_unused=0A=
8021af30 l     O .data	00000008 anon_hash_chain=0A=
8021af38 l     O .data	00000000 inode_lock=0A=
80157c60 l     F .text	00000000 destroy_inode=0A=
803209a8 l     O .bss	00000004 inode_cachep=0A=
80157cb8 l     F .text	00000000 init_once=0A=
80157e60 l     F .text	00000000 __wait_on_inode=0A=
8015838c l     F .text	00000000 get_super_to_sync=0A=
80158494 l     F .text	00000000 try_to_sync_unused_inodes=0A=
80158b84 l     F .text	00000000 dispose_list=0A=
80158c20 l     F .text	00000000 invalidate_list=0A=
803209ac l     O .bss	00000014 unused_inodes_flush_task=0A=
80159008 l     F .text	00000000 find_inode=0A=
803208d0 l     O .bss	00000024 empty_aops.0=0A=
803208f4 l     O .bss	00000040 empty_iops.1=0A=
80320934 l     O .bss	00000048 empty_fops.2=0A=
801590b8 l     F .text	00000000 clean_inode=0A=
8032097c l     O .bss	00000004 last_ino.3=0A=
80159214 l     F .text	00000000 get_new_inode=0A=
8021af38 l     O .data	00000004 counter.4=0A=
803209a0 l     O .bss	00000004 i_hash_shift=0A=
8032099c l     O .bss	00000004 i_hash_mask=0A=
803209a4 l     O .bss	00000004 inode_hashtable=0A=
00000000 l    df *ABS*	00000000 attr.c=0A=
80159e48 l     F .text	00000000 setattr_mask=0A=
00000000 l    df *ABS*	00000000 bad_inode.c=0A=
8015a030 l     F .text	00000000 bad_follow_link=0A=
8015a0b8 l     F .text	00000000 return_EIO=0A=
8021af40 l     O .data	00000048 bad_file_ops=0A=
00000000 l    df *ABS*	00000000 file.c=0A=
00000000 l    df *ABS*	00000000 iobuf.c=0A=
8015a660 l     F .text	00000000 kiobuf_init=0A=
00000000 l    df *ABS*	00000000 dnotify.c=0A=
8021afd4 l     O .data	00000000 dn_lock=0A=
8015aa80 l     F .text	00000000 redo_inode_mask=0A=
803209c0 l     O .bss	00000004 dn_cache=0A=
802087f0 l     F .text.init	00000000 dnotify_init=0A=
80210060 l     O .initcall.init	00000004 __initcall_dnotify_init=0A=
00000000 l    df *ABS*	00000000 filesystems.c=0A=
00000000 l    df *ABS*	00000000 namespace.c=0A=
8021afe0 l     O .data	00000008 vfsmntlist=0A=
8021afe8 l     O .data	00000010 mount_sem=0A=
803209dc l     O .bss	00000004 mnt_cache=0A=
803209d8 l     O .bss	00000004 hash_bits=0A=
803209d4 l     O .bss	00000004 hash_mask=0A=
803209d0 l     O .bss	00000004 mount_hashtable=0A=
8015af24 l     F .text	00000000 check_mnt=0A=
8015af54 l     F .text	00000000 detach_mnt=0A=
8015afb8 l     F .text	00000000 attach_mnt=0A=
8015b0e8 l     F .text	00000000 next_mnt=0A=
8015b124 l     F .text	00000000 clone_mnt=0A=
8015b240 l     F .text	00000000 m_start=0A=
8015b2f0 l     F .text	00000000 m_next=0A=
8015b330 l     F .text	00000000 m_stop=0A=
8021aff8 l     O .data	0000006c nfs_info.0=0A=
8015b37c l     F .text	00000000 show_nfs_mount=0A=
8021b064 l     O .data	00000028 fs_info.1=0A=
8021b08c l     O .data	00000020 mnt_info.2=0A=
8015b59c l     F .text	00000000 show_vfsmnt=0A=
8015baf0 l     F .text	00000000 do_umount=0A=
8015bd78 l     F .text	00000000 mount_is_safe=0A=
8015bdac l     F .text	00000000 copy_tree=0A=
8015c044 l     F .text	00000000 do_loopback=0A=
8015c200 l     F .text	00000000 do_remount=0A=
8015c2f8 l     F .text	00000000 do_add_mount=0A=
8015c47c l     F .text	00000000 copy_mount_options=0A=
8015c7f8 l     F .text	00000000 chroot_fs_refs=0A=
8015ce8c l     F .text	00000000 rootfs_lookup=0A=
8021b0bc l     O .data	00000048 rootfs_dir_operations=0A=
8021b104 l     O .data	00000040 rootfs_dir_inode_operations=0A=
8021b144 l     O .data	00000040 s_ops.3=0A=
8015cec4 l     F .text	00000000 rootfs_read_super=0A=
8021b184 l     O .data	0000001c root_fs_type=0A=
80208840 l     F .text.init	00000000 init_mount_tree=0A=
00000000 l    df *ABS*	00000000 seq_file.c=0A=
8015d418 l     F .text	00000000 traverse=0A=
00000000 l    df *ABS*	00000000 noquot.c=0A=
00000000 l    df *ABS*	00000000 binfmt_script.c=0A=
8015d9e0 l     F .text	00000000 load_script=0A=
80208d1c l     F .text.init	00000000 init_script_binfmt=0A=
80210064 l     O .initcall.init	00000004 =
__initcall_init_script_binfmt=0A=
00000000 l    df *ABS*	00000000 binfmt_elf.c=0A=
8021b1c0 l     O .data	00000018 elf_format=0A=
8015e4ac l     F .text	00000000 load_elf_binary=0A=
8015f0a4 l     F .text	00000000 load_elf_library=0A=
8015f4f0 l     F .text	00000000 elf_core_dump=0A=
8015dc90 l     F .text	00000000 set_brk=0A=
8015dcd8 l     F .text	00000000 padzero=0A=
8015dd34 l     F .text	00000000 create_elf_tables=0A=
8015e020 l     F .text	00000000 load_elf_interp=0A=
8015e334 l     F .text	00000000 load_aout_interp=0A=
8015f310 l     F .text	00000000 dump_write=0A=
8015f34c l     F .text	00000000 dump_seek=0A=
8015f3d8 l     F .text	00000000 notesize=0A=
8015f424 l     F .text	00000000 writenote=0A=
80208d40 l     F .text.init	00000000 init_elf_binfmt=0A=
80210068 l     O .initcall.init	00000004 __initcall_init_elf_binfmt=0A=
00000000 l    df *ABS*	00000000 inode.c=0A=
8015fdd4 l     F .text	00000000 proc_delete_inode=0A=
8015fe58 l     F .text	00000000 proc_read_inode=0A=
8015fe70 l     F .text	00000000 proc_statfs=0A=
8021b1e0 l     O .data	00000040 proc_sops=0A=
8015fe9c l     F .text	00000000 parse_options=0A=
00000000 l    df *ABS*	00000000 root.c=0A=
8021b220 l     O .data	0000001c proc_fs_type=0A=
801602b0 l     F .text	00000000 proc_root_lookup=0A=
80160320 l     F .text	00000000 proc_root_readdir=0A=
8021b23c l     O .data	00000048 proc_root_operations=0A=
8021b284 l     O .data	00000040 proc_root_inode_operations=0A=
00000000 l    df *ABS*	00000000 base.c=0A=
801603a0 l     F .text	00000000 proc_fd_link=0A=
80160454 l     F .text	00000000 proc_exe_link=0A=
80160598 l     F .text	00000000 proc_cwd_link=0A=
8016067c l     F .text	00000000 proc_root_link=0A=
80160760 l     F .text	00000000 proc_pid_environ=0A=
801607e4 l     F .text	00000000 proc_pid_cmdline=0A=
801608fc l     F .text	00000000 proc_check_root=0A=
80160a90 l     F .text	00000000 proc_permission=0A=
80160ad4 l     F .text	00000000 pid_maps_read=0A=
8021b320 l     O .data	00000048 proc_maps_operations=0A=
80160b18 l     F .text	00000000 proc_info_read=0A=
8021b368 l     O .data	00000048 proc_info_file_operations=0A=
80160ca8 l     F .text	00000000 mem_open=0A=
80160cb8 l     F .text	00000000 mem_read=0A=
8021b3b0 l     O .data	00000048 proc_mem_operations=0A=
8021b3f8 l     O .data	00000040 proc_mem_inode_operations=0A=
80160e80 l     F .text	00000000 proc_pid_follow_link=0A=
80160f2c l     F .text	00000000 do_proc_readlink=0A=
801610d0 l     F .text	00000000 proc_pid_readlink=0A=
8021b438 l     O .data	00000040 proc_pid_link_inode_operations=0A=
8021b478 l     O .data	000000c0 base_stuff=0A=
801611d8 l     F .text	00000000 proc_readfd=0A=
80161438 l     F .text	00000000 proc_base_readdir=0A=
80161614 l     F .text	00000000 task_dumpable=0A=
80161630 l     F .text	00000000 proc_pid_make_inode=0A=
8016174c l     F .text	00000000 pid_fd_revalidate=0A=
80161754 l     F .text	00000000 pid_base_revalidate=0A=
80161798 l     F .text	00000000 pid_delete_dentry=0A=
8021b538 l     O .data	00000018 pid_fd_dentry_operations=0A=
8021b550 l     O .data	00000018 pid_dentry_operations=0A=
8021b568 l     O .data	00000018 pid_base_dentry_operations=0A=
801617a0 l     F .text	00000000 proc_lookupfd=0A=
8021b580 l     O .data	00000048 proc_fd_operations=0A=
8021b5c8 l     O .data	00000040 proc_fd_inode_operations=0A=
80161978 l     F .text	00000000 proc_base_lookup=0A=
8021b608 l     O .data	00000048 proc_base_operations=0A=
8021b650 l     O .data	00000040 proc_base_inode_operations=0A=
80161bb8 l     F .text	00000000 proc_self_readlink=0A=
80161c18 l     F .text	00000000 proc_self_follow_link=0A=
8021b690 l     O .data	00000040 proc_self_inode_operations=0A=
80161efc l     F .text	00000000 get_pid_list=0A=
00000000 l    df *ABS*	00000000 generic.c=0A=
8021b6d0 l     O .data	00000048 proc_file_operations=0A=
801623c0 l     F .text	00000000 proc_file_lseek=0A=
80162160 l     F .text	00000000 proc_file_read=0A=
80162388 l     F .text	00000000 proc_file_write=0A=
80162474 l     F .text	00000000 xlate_proc_name=0A=
80162520 l     F .text	00000000 make_inode_number=0A=
80320a30 l     O .bss	00000200 proc_alloc_map=0A=
801625b8 l     F .text	00000000 proc_readlink=0A=
801625e0 l     F .text	00000000 proc_follow_link=0A=
8021b718 l     O .data	00000040 proc_link_inode_operations=0A=
80162608 l     F .text	00000000 proc_delete_dentry=0A=
8021b758 l     O .data	00000018 proc_dentry_operations=0A=
8021b770 l     O .data	00000048 proc_dir_operations=0A=
8021b7b8 l     O .data	00000040 proc_dir_inode_operations=0A=
801628c8 l     F .text	00000000 proc_register=0A=
801629ac l     F .text	00000000 proc_kill_inodes=0A=
80162a48 l     F .text	00000000 proc_create=0A=
00000000 l    df *ABS*	00000000 array.c=0A=
8021b800 l     O .data	00000018 task_state_array=0A=
80162f30 l     F .text	00000000 collect_sigign_sigcatch=0A=
801636d4 l     F .text	00000000 statm_pgd_range=0A=
80163ac8 l     F .text	00000000 proc_pid_maps_get_line=0A=
00000000 l    df *ABS*	00000000 kmsg.c=0A=
80163fd0 l     F .text	00000000 kmsg_open=0A=
80163ff4 l     F .text	00000000 kmsg_release=0A=
8016401c l     F .text	00000000 kmsg_read=0A=
80164038 l     F .text	00000000 kmsg_poll=0A=
00000000 l    df *ABS*	00000000 proc_tty.c=0A=
80164090 l     F .text	00000000 tty_drivers_read_proc=0A=
80164308 l     F .text	00000000 tty_ldiscs_read_proc=0A=
80320c34 l     O .bss	00000004 proc_tty_driver=0A=
80320c30 l     O .bss	00000004 proc_tty_ldisc=0A=
00000000 l    df *ABS*	00000000 proc_misc.c=0A=
80164510 l     F .text	00000000 proc_calc_metrics=0A=
80164554 l     F .text	00000000 loadavg_read_proc=0A=
80164660 l     F .text	00000000 uptime_read_proc=0A=
80164738 l     F .text	00000000 meminfo_read_proc=0A=
801649e8 l     F .text	00000000 version_read_proc=0A=
80164a74 l     F .text	00000000 cpuinfo_open=0A=
8021b870 l     O .data	00000048 proc_cpuinfo_operations=0A=
80164a9c l     F .text	00000000 modules_read_proc=0A=
80164b04 l     F .text	00000000 ksyms_open=0A=
8021b8b8 l     O .data	00000048 proc_ksyms_operations=0A=
80164b2c l     F .text	00000000 kstat_read_proc=0A=
80164de8 l     F .text	00000000 devices_read_proc=0A=
80164e50 l     F .text	00000000 partitions_read_proc=0A=
80164e8c l     F .text	00000000 interrupts_read_proc=0A=
80164ef4 l     F .text	00000000 filesystems_read_proc=0A=
80164f5c l     F .text	00000000 dma_read_proc=0A=
80164fc4 l     F .text	00000000 ioports_read_proc=0A=
8016503c l     F .text	00000000 cmdline_read_proc=0A=
801650bc l     F .text	00000000 locks_read_proc=0A=
801650f8 l     F .text	00000000 execdomains_read_proc=0A=
80165160 l     F .text	00000000 swaps_read_proc=0A=
801651c8 l     F .text	00000000 memory_read_proc=0A=
80165240 l     F .text	00000000 read_profile=0A=
80165364 l     F .text	00000000 write_profile=0A=
8021b900 l     O .data	00000048 proc_profile_operations=0A=
801653a8 l     F .text	00000000 mounts_open=0A=
8021b948 l     O .data	00000048 proc_mounts_operations=0A=
801653d0 l     F .text	00000000 create_seq_entry=0A=
80320c40 l     O .bss	00000004 p.0=0A=
8021b990 l     O .data	00000090 simple_ones.1=0A=
00000000 l    df *ABS*	00000000 kcore.c=0A=
80165400 l     F .text	00000000 open_kcore=0A=
801658c4 l     F .text	00000000 read_kcore=0A=
80165430 l     F .text	00000000 get_kcore_size=0A=
801654c0 l     F .text	00000000 notesize=0A=
8016550c l     F .text	00000000 storenote=0A=
801655d0 l     F .text	00000000 elf_kcore_store_hdr=0A=
00000000 l    df *ABS*	00000000 check.c=0A=
8021ba74 l     O .data	00000008 check_part=0A=
8021ba7c l     O .data	00000004 first_time.0=0A=
80166060 l     F .text	00000000 check_partition=0A=
00000000 l    df *ABS*	00000000 msdos.c=0A=
801664d0 l     F .text	00000000 partition_name=0A=
801664ec l     F .text	00000000 extended_partition=0A=
801667f8 l     F .text	00000000 solaris_x86_partition=0A=
80166800 l     F .text	00000000 bsd_partition=0A=
80166808 l     F .text	00000000 netbsd_partition=0A=
80166810 l     F .text	00000000 openbsd_partition=0A=
80166818 l     F .text	00000000 unixware_partition=0A=
80166820 l     F .text	00000000 minix_partition=0A=
8021ba80 l     O .data	00000038 subtypes=0A=
80166828 l     F .text	00000000 handle_ide_mess=0A=
00000000 l    df *ABS*	00000000 balloc.c=0A=
80166c70 l     F .text	00000000 read_block_bitmap=0A=
80166d3c l     F .text	00000000 __load_block_bitmap=0A=
00000000 l    df *ABS*	00000000 bitmap.c=0A=
8021bac0 l     O .data	00000040 nibblemap=0A=
00000000 l    df *ABS*	00000000 dir.c=0A=
80167f60 l     F .text	00000000 ext2_commit_chunk=0A=
80168008 l     F .text	00000000 ext2_check_page=0A=
80168254 l     F .text	00000000 ext2_get_page=0A=
8021bb00 l     O .data	00000008 ext2_filetype_table=0A=
8021bb08 l     O .data	0000000f ext2_type_by_mode=0A=
80168300 l     F .text	00000000 ext2_readdir=0A=
00000000 l    df *ABS*	00000000 file.c=0A=
80168f70 l     F .text	00000000 ext2_release_file=0A=
00000000 l    df *ABS*	00000000 fsync.c=0A=
00000000 l    df *ABS*	00000000 ialloc.c=0A=
80169050 l     F .text	00000000 read_inode_bitmap=0A=
801690e8 l     F .text	00000000 load_inode_bitmap=0A=
80169524 l     F .text	00000000 find_group_dir=0A=
80169638 l     F .text	00000000 find_group_other=0A=
00000000 l    df *ABS*	00000000 inode.c=0A=
8016b4bc l     F .text	00000000 ext2_update_inode=0A=
80169cf4 l     F .text	00000000 ext2_alloc_block=0A=
80169da8 l     F .text	00000000 ext2_block_to_path=0A=
80169ec4 l     F .text	00000000 ext2_get_branch=0A=
8016a024 l     F .text	00000000 ext2_alloc_branch=0A=
8016a2a8 l     F .text	00000000 ext2_get_block=0A=
8016a770 l     F .text	00000000 ext2_writepage=0A=
8016a794 l     F .text	00000000 ext2_readpage=0A=
8016a7bc l     F .text	00000000 ext2_prepare_write=0A=
8016a7ec l     F .text	00000000 ext2_bmap=0A=
8016a810 l     F .text	00000000 ext2_direct_IO=0A=
8016a83c l     F .text	00000000 ext2_find_shared=0A=
8016a9ec l     F .text	00000000 ext2_free_branches=0A=
00000000 l    df *ABS*	00000000 ioctl.c=0A=
00000000 l    df *ABS*	00000000 namei.c=0A=
8016bbd0 l     F .text	00000000 ext2_lookup=0A=
8016bc54 l     F .text	00000000 ext2_create=0A=
8016bd28 l     F .text	00000000 ext2_mknod=0A=
8016bdfc l     F .text	00000000 ext2_symlink=0A=
8016bf8c l     F .text	00000000 ext2_link=0A=
8016c06c l     F .text	00000000 ext2_mkdir=0A=
8016c1cc l     F .text	00000000 ext2_unlink=0A=
8016c254 l     F .text	00000000 ext2_rmdir=0A=
8016c300 l     F .text	00000000 ext2_rename=0A=
00000000 l    df *ABS*	00000000 super.c=0A=
80320c50 l     O .bss	00000400 error_buf=0A=
8021bc60 l     O .data	00000040 ext2_sops=0A=
8016c950 l     F .text	00000000 parse_options=0A=
8016d0a8 l     F .text	00000000 ext2_setup_super=0A=
8016d24c l     F .text	00000000 ext2_check_descriptors=0A=
8016d374 l     F .text	00000000 ext2_max_size=0A=
8016dd54 l     F .text	00000000 ext2_commit_super=0A=
8021bca0 l     O .data	0000001c ext2_fs_type=0A=
802090f0 l     F .text.init	00000000 init_ext2_fs=0A=
8021006c l     O .initcall.init	00000004 __initcall_init_ext2_fs=0A=
00000000 l    df *ABS*	00000000 symlink.c=0A=
8016e090 l     F .text	00000000 ext2_readlink=0A=
8016e0b4 l     F .text	00000000 ext2_follow_link=0A=
00000000 l    df *ABS*	00000000 dir.c=0A=
8016e0e0 l     F .text	00000000 autofs_dir_lookup=0A=
00000000 l    df *ABS*	00000000 dirhash.c=0A=
8016e120 l     F .text	00000000 autofs_init_usage=0A=
8016e14c l     F .text	00000000 autofs_delete_usage=0A=
00000000 l    df *ABS*	00000000 init.c=0A=
8021bd90 l     O .data	0000001c autofs_fs_type=0A=
80209114 l     F .text.init	00000000 init_autofs_fs=0A=
80210070 l     O .initcall.init	00000004 __initcall_init_autofs_fs=0A=
00000000 l    df *ABS*	00000000 inode.c=0A=
8016e990 l     F .text	00000000 autofs_put_super=0A=
8021bdb0 l     O .data	00000040 autofs_sops=0A=
8016f008 l     F .text	00000000 autofs_read_inode=0A=
8016efe8 l     F .text	00000000 autofs_statfs=0A=
8016ea48 l     F .text	00000000 parse_options=0A=
00000000 l    df *ABS*	00000000 root.c=0A=
8016f160 l     F .text	00000000 autofs_root_readdir=0A=
8016fdc8 l     F .text	00000000 autofs_root_ioctl=0A=
8016f618 l     F .text	00000000 autofs_root_lookup=0A=
8016fa0c l     F .text	00000000 autofs_root_unlink=0A=
8016f798 l     F .text	00000000 autofs_root_symlink=0A=
8016fc58 l     F .text	00000000 autofs_root_mkdir=0A=
8016fb6c l     F .text	00000000 autofs_root_rmdir=0A=
8016f330 l     F .text	00000000 try_to_fill_dentry=0A=
8016f518 l     F .text	00000000 autofs_revalidate=0A=
8021be78 l     O .data	00000018 autofs_dentry_operations=0A=
00000000 l    df *ABS*	00000000 symlink.c=0A=
801700c0 l     F .text	00000000 autofs_readlink=0A=
801700e8 l     F .text	00000000 autofs_follow_link=0A=
00000000 l    df *ABS*	00000000 waitq.c=0A=
8021bed0 l     O .data	00000004 autofs_next_wait_queue=0A=
801701ac l     F .text	00000000 autofs_write=0A=
80170320 l     F .text	00000000 autofs_notify_daemon=0A=
00000000 l    df *ABS*	00000000 init.c=0A=
8021bee0 l     O .data	0000001c autofs_fs_type=0A=
80209138 l     F .text.init	00000000 init_autofs4_fs=0A=
80210074 l     O .initcall.init	00000004 __initcall_init_autofs4_fs=0A=
00000000 l    df *ABS*	00000000 inode.c=0A=
801707f0 l     F .text	00000000 ino_lnkfree=0A=
80170958 l     F .text	00000000 autofs4_put_super=0A=
8021bf00 l     O .data	00000040 autofs4_sops=0A=
80170fe0 l     F .text	00000000 autofs4_statfs=0A=
801709bc l     F .text	00000000 parse_options=0A=
80170d5c l     F .text	00000000 autofs4_mkroot=0A=
00000000 l    df *ABS*	00000000 root.c=0A=
80171dd8 l     F .text	00000000 autofs4_root_ioctl=0A=
801716d4 l     F .text	00000000 autofs4_root_lookup=0A=
80171a58 l     F .text	00000000 autofs4_dir_unlink=0A=
80171898 l     F .text	00000000 autofs4_dir_symlink=0A=
80171c10 l     F .text	00000000 autofs4_dir_mkdir=0A=
80171b44 l     F .text	00000000 autofs4_dir_rmdir=0A=
80171698 l     F .text	00000000 autofs4_dir_lookup=0A=
80171120 l     F .text	00000000 autofs4_update_usage=0A=
8017118c l     F .text	00000000 try_to_fill_dentry=0A=
80171454 l     F .text	00000000 autofs4_root_revalidate=0A=
801715dc l     F .text	00000000 autofs4_revalidate=0A=
8017163c l     F .text	00000000 autofs4_dentry_release=0A=
8021c050 l     O .data	00000018 autofs4_root_dentry_operations=0A=
8021c068 l     O .data	00000018 autofs4_dentry_operations=0A=
00000000 l    df *ABS*	00000000 symlink.c=0A=
80172090 l     F .text	00000000 autofs4_readlink=0A=
801720b4 l     F .text	00000000 autofs4_follow_link=0A=
00000000 l    df *ABS*	00000000 waitq.c=0A=
8021c0c0 l     O .data	00000004 autofs4_next_wait_queue=0A=
8017219c l     F .text	00000000 autofs4_write=0A=
80172310 l     F .text	00000000 autofs4_notify_daemon=0A=
00000000 l    df *ABS*	00000000 expire.c=0A=
801728e0 l     F .text	00000000 check_vfsmnt=0A=
80172a44 l     F .text	00000000 is_tree_busy=0A=
80172c18 l     F .text	00000000 autofs4_expire=0A=
00000000 l    df *ABS*	00000000 root.c=0A=
80172f70 l     F .text	00000000 devpts_root_readdir=0A=
80173170 l     F .text	00000000 devpts_root_lookup=0A=
8021c158 l     O .data	00000018 devpts_dentry_operations=0A=
80173138 l     F .text	00000000 devpts_revalidate=0A=
00000000 l    df *ABS*	00000000 inode.c=0A=
801732b0 l     F .text	00000000 devpts_put_super=0A=
8021c170 l     O .data	00000040 devpts_sops=0A=
801737a8 l     F .text	00000000 devpts_statfs=0A=
801735c8 l     F .text	00000000 devpts_remount=0A=
80173368 l     F .text	00000000 devpts_parse_options=0A=
8021c1b0 l     O .data	0000001c devpts_fs_type=0A=
80321050 l     O .bss	00000004 devpts_mnt=0A=
8020915c l     F .text.init	00000000 init_devpts_fs=0A=
80210078 l     O .initcall.init	00000004 __initcall_init_devpts_fs=0A=
00000000 l    df *ABS*	00000000 util.c=0A=
80173988 l     F .text	00000000 grow_ary=0A=
00000000 l    df *ABS*	00000000 msg.c=0A=
8021c1dc l     O .data	00000004 msg_bytes=0A=
8021c1e0 l     O .data	00000004 msg_hdrs=0A=
80321060 l     O .bss	00000028 msg_ids=0A=
80175380 l     F .text	00000000 sysvipc_msg_read_proc=0A=
80173e10 l     F .text	00000000 newque=0A=
80173f00 l     F .text	00000000 free_msg=0A=
80173f48 l     F .text	00000000 load_msg=0A=
801740a4 l     F .text	00000000 store_msg=0A=
80174184 l     F .text	00000000 ss_wakeup=0A=
801741e0 l     F .text	00000000 expunge_all=0A=
80174238 l     F .text	00000000 freeque=0A=
80174bb8 l     F .text	00000000 testmsg=0A=
00000000 l    df *ABS*	00000000 sem.c=0A=
80321090 l     O .bss	00000028 sem_ids=0A=
803210b8 l     O .bss	00000004 used_sems=0A=
80177178 l     F .text	00000000 sysvipc_sem_read_proc=0A=
801756e0 l     F .text	00000000 newary=0A=
801759f4 l     F .text	00000000 sem_revalidate=0A=
80175aa8 l     F .text	00000000 try_atomic_semop=0A=
80175c40 l     F .text	00000000 update_queue=0A=
80175d18 l     F .text	00000000 count_semncnt=0A=
80175d84 l     F .text	00000000 count_semzcnt=0A=
80175df0 l     F .text	00000000 freeary=0A=
80175ea0 l     F .text	00000000 copy_semid_to_user=0A=
8017696c l     F .text	00000000 freeundos=0A=
801769d4 l     F .text	00000000 alloc_undo=0A=
00000000 l    df *ABS*	00000000 shm.c=0A=
803210c0 l     O .bss	00000028 shm_ids=0A=
80178740 l     F .text	00000000 sysvipc_shm_read_proc=0A=
801773a0 l     F .text	00000000 shm_open=0A=
8017745c l     F .text	00000000 shm_destroy=0A=
803210e8 l     O .bss	00000004 shm_tot=0A=
801774c8 l     F .text	00000000 shm_close=0A=
80177614 l     F .text	00000000 shm_mmap=0A=
8021c254 l     O .data	0000000c shm_vm_ops=0A=
8021c20c l     O .data	00000048 shm_file_operations=0A=
80177704 l     F .text	00000000 newseg=0A=
80177a7c l     F .text	00000000 shm_get_stat=0A=
00000000 l    df *ABS*	00000000 cp1emu.c=0A=
801f0a50 l     O .text	00000004 ieee_rm=0A=
801f0a54 l     O .text	00000020 fpucondbit=0A=
80178980 l     F .text	00000000 isBranchInstr=0A=
80178a24 l     F .text	00000000 mips_get_word=0A=
80178a74 l     F .text	00000000 mips_get_dword=0A=
80178ad0 l     F .text	00000000 mips_put_word=0A=
80178b1c l     F .text	00000000 mips_put_dword=0A=
80178b70 l     F .text	00000000 cop1Emulate=0A=
80179e1c l     F .text	00000000 fpu_emu=0A=
80179310 l     F .text	00000000 mips_dsemul=0A=
801798a8 l     F .text	00000000 fpux_emu=0A=
801f0d08 l     O .text	00000008 cmptab=0A=
80179424 l     F .text	00000000 fpemu_dp_recip=0A=
80179474 l     F .text	00000000 fpemu_dp_rsqrt=0A=
801794d0 l     F .text	00000000 fpemu_sp_recip=0A=
80179510 l     F .text	00000000 fpemu_sp_rsqrt=0A=
80179558 l     F .text	00000000 fpemu_dp_madd=0A=
801795c4 l     F .text	00000000 fpemu_dp_msub=0A=
80179630 l     F .text	00000000 fpemu_dp_nmadd=0A=
801796ac l     F .text	00000000 fpemu_dp_nmsub=0A=
80179728 l     F .text	00000000 fpemu_sp_madd=0A=
80179780 l     F .text	00000000 fpemu_sp_msub=0A=
801797d8 l     F .text	00000000 fpemu_sp_nmadd=0A=
80179840 l     F .text	00000000 fpemu_sp_nmsub=0A=
00000000 l    df *ABS*	00000000 ieee754m.c=0A=
00000000 l    df *ABS*	00000000 ieee754d.c=0A=
00000000 l    df *ABS*	00000000 ieee754dp.c=0A=
8017b3a0 l     F .text	00000000 get_rounding=0A=
00000000 l    df *ABS*	00000000 ieee754sp.c=0A=
8017bd5c l     F .text	00000000 get_rounding=0A=
00000000 l    df *ABS*	00000000 ieee754.c=0A=
00000000 l    df *ABS*	00000000 ieee754xcpt.c=0A=
801f1204 l     O .text	00000014 rtnames=0A=
00000000 l    df *ABS*	00000000 dp_frexp.c=0A=
00000000 l    df *ABS*	00000000 dp_modf.c=0A=
00000000 l    df *ABS*	00000000 dp_div.c=0A=
00000000 l    df *ABS*	00000000 dp_mul.c=0A=
00000000 l    df *ABS*	00000000 dp_sub.c=0A=
00000000 l    df *ABS*	00000000 dp_add.c=0A=
00000000 l    df *ABS*	00000000 dp_fsp.c=0A=
00000000 l    df *ABS*	00000000 dp_cmp.c=0A=
00000000 l    df *ABS*	00000000 dp_logb.c=0A=
00000000 l    df *ABS*	00000000 dp_scalb.c=0A=
00000000 l    df *ABS*	00000000 dp_simple.c=0A=
00000000 l    df *ABS*	00000000 dp_tint.c=0A=
00000000 l    df *ABS*	00000000 dp_fint.c=0A=
00000000 l    df *ABS*	00000000 dp_tlong.c=0A=
00000000 l    df *ABS*	00000000 dp_flong.c=0A=
00000000 l    df *ABS*	00000000 sp_frexp.c=0A=
00000000 l    df *ABS*	00000000 sp_modf.c=0A=
00000000 l    df *ABS*	00000000 sp_div.c=0A=
00000000 l    df *ABS*	00000000 sp_mul.c=0A=
00000000 l    df *ABS*	00000000 sp_sub.c=0A=
00000000 l    df *ABS*	00000000 sp_add.c=0A=
00000000 l    df *ABS*	00000000 sp_fdp.c=0A=
00000000 l    df *ABS*	00000000 sp_cmp.c=0A=
00000000 l    df *ABS*	00000000 sp_logb.c=0A=
00000000 l    df *ABS*	00000000 sp_scalb.c=0A=
00000000 l    df *ABS*	00000000 sp_simple.c=0A=
00000000 l    df *ABS*	00000000 sp_tint.c=0A=
00000000 l    df *ABS*	00000000 sp_fint.c=0A=
00000000 l    df *ABS*	00000000 sp_tlong.c=0A=
00000000 l    df *ABS*	00000000 sp_flong.c=0A=
00000000 l    df *ABS*	00000000 dp_sqrt.c=0A=
801f19a0 l     O .text	00000080 table=0A=
00000000 l    df *ABS*	00000000 sp_sqrt.c=0A=
00000000 l    df *ABS*	00000000 kernel_linkage.c=0A=
8021c260 l     O .data	00000004 first.0=0A=
00000000 l    df *ABS*	00000000 mem.c=0A=
80184940 l     F .text	00000000 do_write_mem=0A=
801849cc l     F .text	00000000 read_mem=0A=
80184a8c l     F .text	00000000 write_mem=0A=
80184af8 l     F .text	00000000 mmap_mem=0A=
80184bcc l     F .text	00000000 read_kmem=0A=
80184d5c l     F .text	00000000 write_kmem=0A=
80184db8 l     F .text	00000000 read_null=0A=
80184dc0 l     F .text	00000000 write_null=0A=
80184dc8 l     F .text	00000000 read_zero=0A=
80185088 l     F .text	00000000 mmap_zero=0A=
801850e0 l     F .text	00000000 write_full=0A=
801850e8 l     F .text	00000000 null_lseek=0A=
801850fc l     F .text	00000000 memory_lseek=0A=
80185160 l     F .text	00000000 open_port=0A=
8021c270 l     O .data	00000048 mem_fops=0A=
8021c2b8 l     O .data	00000048 kmem_fops=0A=
8021c300 l     O .data	00000048 null_fops=0A=
8021c348 l     O .data	00000048 zero_fops=0A=
8021c390 l     O .data	00000048 full_fops=0A=
80185190 l     F .text	00000000 memory_open=0A=
801f1ae8 l     O .text	00000070 list.0=0A=
8021c3d8 l     O .data	00000048 memory_fops=0A=
8021007c l     O .initcall.init	00000004 __initcall_chr_dev_init=0A=
00000000 l    df *ABS*	00000000 tty_io.c=0A=
80185270 l     F .text	00000000 alloc_tty_struct=0A=
801852b8 l     F .text	00000000 _tty_make_name=0A=
801f1b8c l     O .text	00000038 badmagic.0=0A=
801f1bc4 l     O .text	00000025 badtty.1=0A=
80185360 l     F .text	00000000 check_tty_count=0A=
801854e0 l     F .text	00000000 tty_set_ldisc=0A=
80185860 l     F .text	00000000 hung_up_tty_read=0A=
8018587c l     F .text	00000000 hung_up_tty_write=0A=
80185898 l     F .text	00000000 hung_up_tty_poll=0A=
801858a0 l     F .text	00000000 hung_up_tty_ioctl=0A=
8021c420 l     O .data	00000048 tty_fops=0A=
80185f10 l     F .text	00000000 tty_read=0A=
8018602c l     F .text	00000000 tty_write=0A=
80187348 l     F .text	00000000 tty_poll=0A=
80186f40 l     F .text	00000000 tty_open=0A=
80187328 l     F .text	00000000 tty_release=0A=
80187408 l     F .text	00000000 tty_fasync=0A=
8021c468 l     O .data	00000048 hung_up_tty_fops=0A=
8021c4b0 l     O .data	00000010 tty_sem=0A=
801862a8 l     F .text	00000000 down_tty_sem=0A=
801862f4 l     F .text	00000000 up_tty_sem=0A=
80186340 l     F .text	00000000 init_dev=0A=
8018854c l     F .text	00000000 initialize_tty_struct=0A=
8018689c l     F .text	00000000 release_mem=0A=
80186998 l     F .text	00000000 release_dev=0A=
80321120 l     O .bss	00000004 nr_warns.2=0A=
80187554 l     F .text	00000000 tiocsti=0A=
80187610 l     F .text	00000000 tiocgwinsz=0A=
8018766c l     F .text	00000000 tiocswinsz=0A=
80187774 l     F .text	00000000 tioccons=0A=
80187800 l     F .text	00000000 fionbio=0A=
80187858 l     F .text	00000000 tiocsctty=0A=
80187930 l     F .text	00000000 tiocgpgrp=0A=
80187978 l     F .text	00000000 tiocspgrp=0A=
80187a40 l     F .text	00000000 tiocgsid=0A=
80187a94 l     F .text	00000000 tiocttygstruct=0A=
80187aec l     F .text	00000000 tiocsetd=0A=
80187b3c l     F .text	00000000 send_break=0A=
801880f0 l     F .text	00000000 __do_SAK=0A=
80188250 l     F .text	00000000 flush_to_ldisc=0A=
8021c4c0 l     O .data	0000007c baud_table=0A=
8021c53c l     O .data	00000004 n_baud_table=0A=
80321554 l     O .bss	000000c0 dev_tty_driver=0A=
80321614 l     O .bss	000000c0 dev_syscons_driver=0A=
803216d4 l     O .bss	000000c0 dev_ptmx_driver=0A=
00000000 l    df *ABS*	00000000 n_tty.c=0A=
801889b0 l     F .text	00000000 check_unthrottle=0A=
80188a08 l     F .text	00000000 reset_buffer_flags=0A=
80188b84 l     F .text	00000000 opost=0A=
80188d70 l     F .text	00000000 opost_block=0A=
80188f7c l     F .text	00000000 echo_char=0A=
80189018 l     F .text	00000000 eraser=0A=
80189504 l     F .text	00000000 n_tty_receive_room=0A=
80189540 l     F .text	00000000 n_tty_receive_buf=0A=
8018a510 l     F .text	00000000 n_tty_set_termios=0A=
8018a9a0 l     F .text	00000000 n_tty_close=0A=
8018a9e0 l     F .text	00000000 n_tty_open=0A=
8018aa94 l     F .text	00000000 read_chan=0A=
8018b434 l     F .text	00000000 write_chan=0A=
8018b678 l     F .text	00000000 normal_poll=0A=
00000000 l    df *ABS*	00000000 tty_ioctl.c=0A=
8018b8cc l     F .text	00000000 unset_locked_termios=0A=
8018b9dc l     F .text	00000000 change_termios=0A=
8018bc30 l     F .text	00000000 set_termios=0A=
8018be84 l     F .text	00000000 get_termio=0A=
8018bf5c l     F .text	00000000 inq_canon=0A=
8018bfe0 l     F .text	00000000 get_sgflags=0A=
8018c03c l     F .text	00000000 get_sgttyb=0A=
8018c0c4 l     F .text	00000000 set_sgflags=0A=
8018c160 l     F .text	00000000 set_sgttyb=0A=
8018c24c l     F .text	00000000 get_ltchars=0A=
8018c2d4 l     F .text	00000000 set_ltchars=0A=
00000000 l    df *ABS*	00000000 raw.c=0A=
8021c580 l     O .data	00000048 raw_fops=0A=
8021c5c8 l     O .data	00000048 raw_ctl_fops=0A=
802096dc l     F .text.init	00000000 raw_init=0A=
803217a0 l     O .bss	00002000 raw_devices=0A=
80210080 l     O .initcall.init	00000004 __initcall_raw_init=0A=
8018d014 l     F .text	00000000 rw_raw_dev=0A=
00000000 l    df *ABS*	00000000 pty.c=0A=
8018d3c0 l     F .text	00000000 pty_close=0A=
8018d51c l     F .text	00000000 pty_unthrottle=0A=
8018d598 l     F .text	00000000 pty_write=0A=
8018d790 l     F .text	00000000 pty_write_room=0A=
8018d7d4 l     F .text	00000000 pty_chars_in_buffer=0A=
8018d838 l     F .text	00000000 pty_get_device_number=0A=
8018d878 l     F .text	00000000 pty_set_lock=0A=
8018d8f8 l     F .text	00000000 pty_bsd_ioctl=0A=
8018d944 l     F .text	00000000 pty_unix98_ioctl=0A=
8018d9a4 l     F .text	00000000 pty_flush_buffer=0A=
8018da14 l     F .text	00000000 pty_open=0A=
8018db28 l     F .text	00000000 pty_set_termios=0A=
80325124 l     O .bss	00000c00 pty_state=0A=
803237a0 l     O .bss	000000c0 pty_driver=0A=
80323920 l     O .bss	00000004 pty_refcount=0A=
80323924 l     O .bss	00000400 pty_table=0A=
80323d24 l     O .bss	00000400 pty_termios=0A=
80324124 l     O .bss	00000400 pty_termios_locked=0A=
80323860 l     O .bss	000000c0 pty_slave_driver=0A=
80324524 l     O .bss	00000400 ttyp_table=0A=
80324924 l     O .bss	00000400 ttyp_termios=0A=
80324d24 l     O .bss	00000400 ttyp_termios_locked=0A=
803276a4 l     O .bss	00000c00 ptm_state=0A=
803272a4 l     O .bss	00000400 pts_termios_locked=0A=
80326ea4 l     O .bss	00000400 pts_termios=0A=
80326aa4 l     O .bss	00000400 pts_table=0A=
803266a4 l     O .bss	00000400 ptm_termios_locked=0A=
803262a4 l     O .bss	00000400 ptm_termios=0A=
80325ea4 l     O .bss	00000400 ptm_table=0A=
00000000 l    df *ABS*	00000000 misc.c=0A=
8021c610 l     O .data	00000018 misc_list=0A=
8021c628 l     O .data	00000010 misc_sem=0A=
8018db50 l     F .text	00000000 misc_read_proc=0A=
8018dc6c l     F .text	00000000 misc_open=0A=
8021c638 l     O .data	00000048 misc_fops=0A=
803282b0 l     O .bss	00000004 devfs_handle.0=0A=
803282b4 l     O .bss	00000008 misc_minors=0A=
00000000 l    df *ABS*	00000000 random.c=0A=
8021c680 l     O .data	00000004 random_read_wakeup_thresh=0A=
8021c684 l     O .data	00000004 random_write_wakeup_thresh=0A=
8021c688 l     O .data	000000c0 poolinfo_table=0A=
8021c748 l     O .data	00000008 random_read_wait=0A=
8021c750 l     O .data	00000008 random_write_wait=0A=
8018e280 l     F .text	00000000 create_entropy_store=0A=
8018e3b4 l     F .text	00000000 clear_entropy_store=0A=
8018e3f0 l     F .text	00000000 free_entropy_store=0A=
801f23b0 l     O .text	00000020 twist_table.0=0A=
8018e42c l     F .text	00000000 add_entropy_words=0A=
8018e574 l     F .text	00000000 credit_entropy_store=0A=
80209e78 l     F .text.init	00000000 batch_entropy_init=0A=
80328338 l     O .bss	00000004 batch_entropy_pool=0A=
8032834c l     O .bss	00000014 batch_tqueue=0A=
8032833c l     O .bss	00000004 batch_entropy_credit=0A=
8018e6ec l     F .text	00000000 batch_entropy_process=0A=
80328340 l     O .bss	00000004 batch_max=0A=
80328348 l     O .bss	00000004 batch_tail=0A=
80328344 l     O .bss	00000004 batch_head=0A=
80328334 l     O .bss	00000004 sec_random_state=0A=
80328330 l     O .bss	00000004 random_state=0A=
8018e828 l     F .text	00000000 add_timer_randomness=0A=
803282c0 l     O .bss	00000001 last_scancode.1=0A=
80328360 l     O .bss	00000010 keyboard_timer_state=0A=
80328370 l     O .bss	00000010 mouse_timer_state=0A=
80328390 l     O .bss	00000100 irq_timer_state=0A=
80328490 l     O .bss	000003fc blkdev_timer_state=0A=
8018ea38 l     F .text	00000000 SHATransform=0A=
8018ebd0 l     F .text	00000000 extract_entropy=0A=
80328380 l     O .bss	00000010 extract_timer_state=0A=
8018eff4 l     F .text	00000000 init_std_data=0A=
8018fce4 l     F .text	00000000 sysctl_init_random=0A=
8018f18c l     F .text	00000000 random_read=0A=
8018f2ec l     F .text	00000000 urandom_read=0A=
8018f310 l     F .text	00000000 random_poll=0A=
8018f3b0 l     F .text	00000000 random_write=0A=
8018f4c4 l     F .text	00000000 random_ioctl=0A=
8018f8f4 l     F .text	00000000 change_poolsize=0A=
8018f974 l     F .text	00000000 proc_do_poolsize=0A=
8032888c l     O .bss	00000004 sysctl_poolsize=0A=
8018f9f8 l     F .text	00000000 poolsize_strategy=0A=
8018faa4 l     F .text	00000000 proc_do_uuid=0A=
8018fbd0 l     F .text	00000000 uuid_strategy=0A=
80328890 l     O .bss	00000004 min_read_thresh=0A=
80328894 l     O .bss	00000004 max_read_thresh=0A=
80328898 l     O .bss	00000004 min_write_thresh=0A=
8032889c l     O .bss	00000004 max_write_thresh=0A=
803288a0 l     O .bss	00000010 sysctl_bootid=0A=
8018fd20 l     F .text	00000000 halfMD4Transform=0A=
803282c4 l     O .bss	00000004 rekey_time.2=0A=
803282c8 l     O .bss	00000004 count.3=0A=
803282cc l     O .bss	00000030 secret.4=0A=
803282fc l     O .bss	00000004 rekey_time.5=0A=
80328300 l     O .bss	00000030 secret.6=0A=
00000000 l    df *ABS*	00000000 serial.c=0A=
8021c920 l     O .data	00000004 serial_version=0A=
8021c924 l     O .data	00000004 serial_revdate=0A=
8021c928 l     O .data	00000004 serial_name=0A=
8021c92c l     O .data	00000008 tq_serial=0A=
8021c934 l     O .data	000000b4 uart_config=0A=
8021c9e8 l     O .data	00000188 rs_table=0A=
8021cb70 l     O .data	00000010 tmp_buf_sem=0A=
801902a0 l     F .text	00000000 serial_in=0A=
801902ec l     F .text	00000000 serial_out=0A=
801903e4 l     F .text	00000000 rs_stop=0A=
801904b0 l     F .text	00000000 rs_start=0A=
8019059c l     F .text	00000000 rs_sched_event=0A=
80190684 l     F .text	00000000 receive_chars=0A=
8021cb84 l     O .data	0000002c sercons=0A=
80328c54 l     O .bss	00000004 lsr_break_flag=0A=
801908f4 l     F .text	00000000 transmit_chars=0A=
80190a44 l     F .text	00000000 check_modem_status=0A=
80190be4 l     F .text	00000000 rs_interrupt_single=0A=
80328a54 l     O .bss	00000100 IRQ_ports=0A=
80190cc0 l     F .text	00000000 do_serial_bh=0A=
80190cf4 l     F .text	00000000 do_softint=0A=
803288b0 l     O .bss	00000004 last_strobe.0=0A=
80190d74 l     F .text	00000000 rs_timer=0A=
80328a40 l     O .bss	00000014 serial_timer=0A=
80328b54 l     O .bss	00000100 IRQ_timeout=0A=
80190eec l     F .text	00000000 figure_IRQ_timeout=0A=
80190f70 l     F .text	00000000 enable_rsa=0A=
80191020 l     F .text	00000000 disable_rsa=0A=
801910e4 l     F .text	00000000 startup=0A=
80191b28 l     F .text	00000000 change_speed=0A=
801917b8 l     F .text	00000000 shutdown=0A=
8019221c l     F .text	00000000 rs_put_char=0A=
801922e8 l     F .text	00000000 rs_flush_chars=0A=
80192398 l     F .text	00000000 rs_write=0A=
80328c70 l     O .bss	00000004 tmp_buf=0A=
801926d8 l     F .text	00000000 rs_write_room=0A=
801926f4 l     F .text	00000000 rs_chars_in_buffer=0A=
8019270c l     F .text	00000000 rs_flush_buffer=0A=
801927b4 l     F .text	00000000 rs_send_xchar=0A=
801927fc l     F .text	00000000 rs_throttle=0A=
801928b4 l     F .text	00000000 rs_unthrottle=0A=
80192984 l     F .text	00000000 get_serial_info=0A=
80192a80 l     F .text	00000000 set_serial_info=0A=
80193004 l     F .text	00000000 get_lsr_info=0A=
80193118 l     F .text	00000000 get_modem_info=0A=
8019323c l     F .text	00000000 set_modem_info=0A=
80193484 l     F .text	00000000 do_autoconfig=0A=
80195414 l     F .text	00000000 autoconfig=0A=
80194e84 l     F .text	00000000 detect_uart_irq=0A=
80193558 l     F .text	00000000 rs_break=0A=
8019360c l     F .text	00000000 rs_ioctl=0A=
80193b5c l     F .text	00000000 rs_set_termios=0A=
80193d40 l     F .text	00000000 rs_close=0A=
8019406c l     F .text	00000000 rs_wait_until_sent=0A=
80194188 l     F .text	00000000 rs_hangup=0A=
80194210 l     F .text	00000000 block_til_ready=0A=
801945e8 l     F .text	00000000 get_async_struct=0A=
80194740 l     F .text	00000000 rs_open=0A=
8020fce8 l     O .data.init	0000001c serial_options=0A=
80194e34 l     F .text	00000000 show_serial_version=0A=
80195040 l     F .text	00000000 size_fifo=0A=
8019520c l     F .text	00000000 autoconfig_startech_uarts=0A=
8020a048 l     F .text.init	00000000 rs_init=0A=
803288bc l     O .bss	000000c0 serial_driver=0A=
80328a3c l     O .bss	00000004 serial_refcount=0A=
80328c58 l     O .bss	00000008 serial_table=0A=
80328c60 l     O .bss	00000008 serial_termios=0A=
80328c68 l     O .bss	00000008 serial_termios_locked=0A=
8032897c l     O .bss	000000c0 callout_driver=0A=
80210084 l     O .initcall.init	00000004 __initcall_rs_init=0A=
8021cb80 l     O .data	00000004 info.1=0A=
80328c74 l     O .bss	000000ac async_sercons=0A=
80195e04 l     F .text	00000000 serial_console_write=0A=
803288b4 l     O .bss	00000004 info.2=0A=
8019609c l     F .text	00000000 serial_console_wait_key=0A=
8019613c l     F .text	00000000 serial_console_device=0A=
803288b8 l     O .bss	00000004 info.3=0A=
8020a7b0 l     F .text.init	00000000 serial_console_setup=0A=
00000000 l    df *ABS*	00000000 ll_rw_blk.c=0A=
80196150 l     F .text	00000000 __blk_cleanup_queue=0A=
8033208c l     O .bss	00000004 request_cachep=0A=
80332090 l     O .bss	00000004 queue_nr_requests=0A=
8019625c l     F .text	00000000 ll_back_merge_fn=0A=
801962a8 l     F .text	00000000 ll_front_merge_fn=0A=
801962f4 l     F .text	00000000 ll_merge_requests_fn=0A=
80196344 l     F .text	00000000 generic_plug_device=0A=
80196484 l     F .text	00000000 blk_init_free_list=0A=
801969c8 l     F .text	00000000 __make_request=0A=
80196650 l     F .text	00000000 __get_request_wait=0A=
80332094 l     O .bss	00000004 batch_requests=0A=
80332098 l     O .bss	00001fe0 ro_bits=0A=
8019685c l     F .text	00000000 attempt_merge=0A=
00000000 l    df *ABS*	00000000 blkpg.c=0A=
00000000 l    df *ABS*	00000000 genhd.c=0A=
80210088 l     O .initcall.init	00000004 __initcall_device_init=0A=
80334084 l     O .bss	00000000 gendisk_lock=0A=
00000000 l    df *ABS*	00000000 elevator.c=0A=
80334090 l     O .bss	00000004 queue_ID.0=0A=
00000000 l    df *ABS*	00000000 rd.c=0A=
00000000 l    df *ABS*	00000000 rd.c=0A=
8020ac74 l     F .text.init	00000000 no_initrd=0A=
8020fd04 l     O .data.init	00000009 __setup_str_no_initrd=0A=
8020ffd8 l     O .setup.init	00000008 __setup_no_initrd=0A=
8020ac84 l     F .text.init	00000000 ramdisk_start_setup=0A=
8020acb0 l     F .text.init	00000000 load_ramdisk=0A=
8020ace0 l     F .text.init	00000000 prompt_ramdisk=0A=
8020ad10 l     F .text.init	00000000 ramdisk_size=0A=
8020ad3c l     F .text.init	00000000 ramdisk_size2=0A=
8020ad58 l     F .text.init	00000000 ramdisk_blocksize=0A=
8020fd10 l     O .data.init	0000000f __setup_str_ramdisk_start_setup=0A=
8020ffe0 l     O .setup.init	00000008 __setup_ramdisk_start_setup=0A=
8020fd20 l     O .data.init	0000000e __setup_str_load_ramdisk=0A=
8020ffe8 l     O .setup.init	00000008 __setup_load_ramdisk=0A=
8020fd30 l     O .data.init	00000010 __setup_str_prompt_ramdisk=0A=
8020fff0 l     O .setup.init	00000008 __setup_prompt_ramdisk=0A=
8020fd40 l     O .data.init	00000009 __setup_str_ramdisk_size=0A=
8020fff8 l     O .setup.init	00000008 __setup_ramdisk_size=0A=
8020fd4c l     O .data.init	0000000e __setup_str_ramdisk_size2=0A=
80210000 l     O .setup.init	00000008 __setup_ramdisk_size2=0A=
8020fd5c l     O .data.init	00000013 __setup_str_ramdisk_blocksize=0A=
80210008 l     O .setup.init	00000008 __setup_ramdisk_blocksize=0A=
80198a70 l     F .text	00000000 ramdisk_readpage=0A=
80198ad8 l     F .text	00000000 ramdisk_prepare_write=0A=
80198b4c l     F .text	00000000 ramdisk_commit_write=0A=
8021cbd0 l     O .data	00000024 ramdisk_aops=0A=
80198b54 l     F .text	00000000 rd_blkdev_pagecache_IO=0A=
803341bc l     O .bss	00000040 rd_bdev=0A=
80198d30 l     F .text	00000000 rd_make_request=0A=
803340b8 l     O .bss	00000040 rd_length=0A=
80198df0 l     F .text	00000000 rd_ioctl=0A=
80334178 l     O .bss	00000040 rd_kbsize=0A=
80199008 l     F .text	00000000 initrd_read=0A=
801990b0 l     F .text	00000000 initrd_release=0A=
803340b4 l     O .bss	00000004 initrd_users=0A=
8021cbf4 l     O .data	00000048 initrd_fops=0A=
8019911c l     F .text	00000000 rd_open=0A=
8021cc3c l     O .data	00000018 rd_bd_op=0A=
803340f8 l     O .bss	00000040 rd_hardsec=0A=
80334138 l     O .bss	00000040 rd_blocksizes=0A=
803341b8 l     O .bss	00000004 devfs_handle=0A=
8020af40 l     F .text.init	00000000 identify_ramdisk_image=0A=
8020b1cc l     F .text.init	00000000 rd_load_image=0A=
8020b99c l     F .text.init	00000000 crd_load=0A=
8020b6e4 l     F .text.init	00000000 rd_load_disk=0A=
801f3398 l     O .text	0000004c border=0A=
801f33e4 l     O .text	0000003e cplens=0A=
801f3424 l     O .text	0000003e cplext=0A=
801f3464 l     O .text	0000003c cpdist=0A=
801f34a0 l     O .text	0000003c cpdext=0A=
801f34dc l     O .text	00000022 mask_bits=0A=
801f3500 l     O .text	00000004 lbits=0A=
801f3504 l     O .text	00000004 dbits=0A=
801991dc l     F .text	00000000 huft_build=0A=
8020b7e0 l     F .text.init	00000000 malloc=0A=
80334228 l     O .bss	00000004 hufts=0A=
801997b4 l     F .text	00000000 huft_free=0A=
8020b7fc l     F .text.init	00000000 free=0A=
801997f0 l     F .text	00000000 inflate_codes=0A=
80334220 l     O .bss	00000004 bb=0A=
80334224 l     O .bss	00000004 bk=0A=
8033420c l     O .bss	00000004 outcnt=0A=
80334208 l     O .bss	00000004 inptr=0A=
80334204 l     O .bss	00000004 insize=0A=
803341fc l     O .bss	00000004 inbuf=0A=
80334200 l     O .bss	00000004 window=0A=
8020b8a0 l     F .text.init	00000000 flush_window=0A=
8020b828 l     F .text.init	00000000 fill_inbuf=0A=
80199dac l     F .text	00000000 inflate_stored=0A=
8019a020 l     F .text	00000000 inflate_fixed=0A=
8019a1cc l     F .text	00000000 inflate_dynamic=0A=
8020b968 l     F .text.init	00000000 error=0A=
8019a9d8 l     F .text	00000000 inflate_block=0A=
8019ab84 l     F .text	00000000 inflate=0A=
8020b818 l     F .text.init	00000000 gzip_mark=0A=
8020b820 l     F .text.init	00000000 gzip_release=0A=
801f3540 l     O .text	00000038 p.0=0A=
8019ac6c l     F .text	00000000 makecrc=0A=
8033422c l     O .bss	00000400 crc_32_tab=0A=
8033462c l     O .bss	00000004 crc=0A=
8019ad18 l     F .text	00000000 gunzip=0A=
80334214 l     O .bss	00000004 bytes_out=0A=
80334210 l     O .bss	00000004 exit_code=0A=
80334218 l     O .bss	00000004 crd_infp=0A=
8033421c l     O .bss	00000004 crd_outfp=0A=
00000000 l    df *ABS*	00000000 loop.c=0A=
8021cc60 l     O .data	00000004 max_loop=0A=
8019b5b0 l     F .text	00000000 transfer_none=0A=
8019b604 l     F .text	00000000 transfer_xor=0A=
8019b670 l     F .text	00000000 none_status=0A=
8019b684 l     F .text	00000000 xor_status=0A=
8019b69c l     F .text	00000000 compute_loop_size=0A=
8019b72c l     F .text	00000000 figure_loop_size=0A=
80334634 l     O .bss	00000004 loop_sizes=0A=
8019b774 l     F .text	00000000 lo_send=0A=
8019ba38 l     F .text	00000000 lo_read_actor=0A=
8019bb5c l     F .text	00000000 lo_receive=0A=
8019bbe8 l     F .text	00000000 do_bh_filebacked=0A=
8019bcd0 l     F .text	00000000 loop_put_buffer=0A=
8019be2c l     F .text	00000000 loop_end_io_transfer=0A=
8019bd28 l     F .text	00000000 loop_add_bh=0A=
8019bdcc l     F .text	00000000 loop_get_bh=0A=
80334630 l     O .bss	00000004 loop_dev=0A=
8019bf00 l     F .text	00000000 loop_get_buffer=0A=
8019c090 l     F .text	00000000 loop_make_request=0A=
8019c3c8 l     F .text	00000000 loop_thread=0A=
8019c6e0 l     F .text	00000000 loop_set_fd=0A=
8019c920 l     F .text	00000000 loop_release_xfer=0A=
8019c9a8 l     F .text	00000000 loop_init_xfer=0A=
8019ca40 l     F .text	00000000 loop_clr_fd=0A=
8019cbf4 l     F .text	00000000 loop_set_status=0A=
8019cdb4 l     F .text	00000000 loop_get_status=0A=
8019cf0c l     F .text	00000000 lo_ioctl=0A=
8019d1dc l     F .text	00000000 lo_open=0A=
8019d308 l     F .text	00000000 lo_release=0A=
8021ccec l     O .data	00000018 lo_fops=0A=
8033463c l     O .bss	00000004 devfs_handle=0A=
80334638 l     O .bss	00000004 loop_blksizes=0A=
8021008c l     O .initcall.init	00000004 __initcall_loop_init=0A=
8020bd38 l     F .text.init	00000000 max_loop_setup=0A=
8020fd70 l     O .data.init	0000000a __setup_str_max_loop_setup=0A=
80210010 l     O .setup.init	00000008 __setup_max_loop_setup=0A=
00000000 l    df *ABS*	00000000 Space.c=0A=
8020bd64 l     F .text.init	00000000 probe_list=0A=
8020fd7c l     O .data.init	00000008 eisa_probes=0A=
8020fd84 l     O .data.init	00000008 mca_probes=0A=
8020fd8c l     O .data.init	00000008 isa_probes=0A=
8020fd94 l     O .data.init	00000008 parport_probes=0A=
8020fd9c l     O .data.init	00000008 m68k_probes=0A=
8020fda4 l     O .data.init	00000008 sgi_probes=0A=
8020fdac l     O .data.init	00000008 mips_probes=0A=
8020be00 l     F .text.init	00000000 ethif_probe=0A=
8021cd10 l     O .data	00000130 eth7_dev=0A=
8021ce40 l     O .data	00000130 eth6_dev=0A=
8021cf70 l     O .data	00000130 eth5_dev=0A=
8021d0a0 l     O .data	00000130 eth4_dev=0A=
8021d1d0 l     O .data	00000130 eth3_dev=0A=
8021d300 l     O .data	00000130 eth2_dev=0A=
8021d430 l     O .data	00000130 eth1_dev=0A=
8021d560 l     O .data	00000130 eth0_dev=0A=
00000000 l    df *ABS*	00000000 setup.c=0A=
8020fdb4 l     O .data.init	00000008 pci_probes=0A=
8020bf04 l     F .text.init	00000000 network_probe=0A=
8020bf4c l     F .text.init	00000000 network_ldisc_init=0A=
8020bf54 l     F .text.init	00000000 special_device_init=0A=
00000000 l    df *ABS*	00000000 net_init.c=0A=
8019d5b0 l     F .text	00000000 alloc_netdev=0A=
8019d674 l     F .text	00000000 init_alloc_dev=0A=
8019d6fc l     F .text	00000000 init_netdev=0A=
8019d864 l     F .text	00000000 eth_mac_addr=0A=
8019d8a8 l     F .text	00000000 eth_change_mtu=0A=
00000000 l    df *ABS*	00000000 loopback.c=0A=
8019da60 l     F .text	00000000 loopback_xmit=0A=
8019dbc8 l     F .text	00000000 get_stats=0A=
00000000 l    df *ABS*	00000000 auto_irq.c=0A=
80334640 l     O .bss	00000004 irqs=0A=
00000000 l    df *ABS*	00000000 socket.c=0A=
8021d7d0 l     O .data	00000048 socket_file_ops=0A=
8019e42c l     F .text	00000000 sock_lseek=0A=
8019e438 l     F .text	00000000 sock_read=0A=
8019e4b8 l     F .text	00000000 sock_write=0A=
8019e748 l     F .text	00000000 sock_poll=0A=
8019e71c l     F .text	00000000 sock_ioctl=0A=
8019e780 l     F .text	00000000 sock_mmap=0A=
8019e1b4 l     F .text	00000000 sock_no_open=0A=
8019e7b8 l     F .text	00000000 sock_close=0A=
8019e80c l     F .text	00000000 sock_fasync=0A=
8019e664 l     F .text	00000000 sock_readv=0A=
8019e6c0 l     F .text	00000000 sock_writev=0A=
8019e55c l     F .text	00000000 sock_sendpage=0A=
80211960 l     O .data.cacheline_aligned	00000020 sockets_in_use=0A=
8019dd54 l     F .text	00000000 sockfs_statfs=0A=
8021d818 l     O .data	00000040 sockfs_ops=0A=
8019dd78 l     F .text	00000000 sockfs_read_super=0A=
8021d858 l     O .data	0000001c sock_fs_type=0A=
8019de58 l     F .text	00000000 sockfs_delete_dentry=0A=
8021d874 l     O .data	00000018 sockfs_dentry_operations=0A=
8019de60 l     F .text	00000000 sock_map_fd=0A=
803346e4 l     O .bss	00000004 sock_mnt=0A=
80334660 l     O .bss	00000004 warned.0=0A=
80334664 l     O .bss	00000080 net_families=0A=
8021d88c l     O .data	00000012 nargs=0A=
00000000 l    df *ABS*	00000000 sock.c=0A=
8019fd90 l     F .text	00000000 sock_set_timeout=0A=
80334700 l     O .bss	00000004 sk_cachep=0A=
801a0c78 l     F .text	00000000 sock_wait_for_wmem=0A=
801a11b0 l     F .text	00000000 sklist_destroy_timer=0A=
00000000 l    df *ABS*	00000000 skbuff.c=0A=
8021d8c4 l     O .data	00000004 count.0=0A=
80334714 l     O .bss	00000020 skb_head_pool=0A=
80334710 l     O .bss	00000004 skbuff_head_cache=0A=
801a1b08 l     F .text	00000000 skb_drop_fraglist=0A=
801a1b80 l     F .text	00000000 skb_clone_fraglist=0A=
801a1bbc l     F .text	00000000 skb_release_data=0A=
801a206c l     F .text	00000000 copy_skb_header=0A=
801a37f8 l     F .text	00000000 skb_headerinit=0A=
00000000 l    df *ABS*	00000000 iovec.c=0A=
00000000 l    df *ABS*	00000000 datagram.c=0A=
801a3ed0 l     F .text	00000000 wait_for_packet=0A=
00000000 l    df *ABS*	00000000 scm.c=0A=
801a4a70 l     F .text	00000000 scm_fp_copy=0A=
00000000 l    df *ABS*	00000000 sysctl_net_core.c=0A=
00000000 l    df *ABS*	00000000 dev.c=0A=
8021db5c l     O .data	00000004 ptype_all=0A=
8021db60 l     O .data	00000004 netdev_chain=0A=
803347a0 l     O .bss	00000040 ptype_base=0A=
803347e0 l     O .bss	00000100 dev_boot_setup=0A=
8020fdbc l     O .data.init	00000008 __setup_str_netdev_boot_setup=0A=
80210018 l     O .setup.init	00000008 __setup_netdev_boot_setup=0A=
801a5a78 l     F .text	00000000 default_rebuild_header=0A=
801a62b4 l     F .text	00000000 get_sample_stats=0A=
8021db7c l     O .data	00000000 net_bh_lock.0=0A=
801a652c l     F .text	00000000 deliver_to_old_ones=0A=
801a663c l     F .text	00000000 net_tx_action=0A=
801a67f0 l     F .text	00000000 net_rx_action=0A=
803348e0 l     O .bss	00000080 gifconf_list=0A=
801a6c14 l     F .text	00000000 dev_ifname=0A=
801a6ce4 l     F .text	00000000 dev_ifconf=0A=
801a6e28 l     F .text	00000000 sprintf_stats=0A=
801a6f58 l     F .text	00000000 dev_get_info=0A=
801a7040 l     F .text	00000000 dev_proc_stats=0A=
801a74d8 l     F .text	00000000 dev_ifsioc=0A=
80334740 l     O .bss	00000004 ifindex.1=0A=
8021db7c l     O .data	00000004 dev_boot_phase=0A=
00000000 l    df *ABS*	00000000 dev_mcast.c=0A=
801a8250 l     F .text	00000000 __dev_mc_upload=0A=
801a8710 l     F .text	00000000 dev_mc_read_proc=0A=
00000000 l    df *ABS*	00000000 dst.c=0A=
8021db80 l     O .data	00000004 dst_total=0A=
8021db84 l     O .data	00000000 dst_lock=0A=
8021db84 l     O .data	00000004 dst_gc_timer_inc=0A=
8021db88 l     O .data	00000014 dst_gc_timer=0A=
801a8920 l     F .text	00000000 dst_run_gc=0A=
80334960 l     O .bss	00000004 dst_garbage_list=0A=
80334964 l     O .bss	00000004 dst_gc_timer_expires=0A=
801a8a0c l     F .text	00000000 dst_discard=0A=
801a8a64 l     F .text	00000000 dst_blackhole=0A=
801a8dec l     F .text	00000000 dst_dev_event=0A=
00000000 l    df *ABS*	00000000 neighbour.c=0A=
8021dbb0 l     O .data	00000000 neigh_tbl_lock=0A=
801a8fe0 l     F .text	00000000 neigh_blackhole=0A=
801a9074 l     F .text	00000000 neigh_forced_gc=0A=
801a91ec l     F .text	00000000 neigh_del_timer=0A=
801a9264 l     F .text	00000000 pneigh_queue_purge=0A=
801a9df8 l     F .text	00000000 pneigh_ifdown=0A=
801a95e0 l     F .text	00000000 neigh_alloc=0A=
801aa418 l     F .text	00000000 neigh_timer_handler=0A=
80334970 l     O .bss	00000004 neigh_glbl_allocs=0A=
801aa148 l     F .text	00000000 neigh_suspect=0A=
801aa17c l     F .text	00000000 neigh_connect=0A=
801aa1b0 l     F .text	00000000 neigh_sync=0A=
801aa264 l     F .text	00000000 neigh_periodic_timer=0A=
801aaf00 l     F .text	00000000 neigh_hh_init=0A=
801ab550 l     F .text	00000000 neigh_proxy_process=0A=
80334974 l     O .bss	00000004 neigh_tables=0A=
00000000 l    df *ABS*	00000000 rtnetlink.c=0A=
00000000 l    df *ABS*	00000000 utils.c=0A=
8021e010 l     O .data	00000004 net_rand_seed=0A=
8021e01c l     O .data	00000000 ratelimit_lock.0=0A=
8021e01c l     O .data	00000004 toks.1=0A=
80334980 l     O .bss	00000004 last_msg.2=0A=
80334984 l     O .bss	00000004 missed.3=0A=
00000000 l    df *ABS*	00000000 eth.c=0A=
8020fdc4 l     O .data.init	00000007 __setup_str_netdev_boot_setup=0A=
80210020 l     O .setup.init	00000008 __setup_netdev_boot_setup=0A=
00000000 l    df *ABS*	00000000 sysctl_net_ether.c=0A=
00000000 l    df *ABS*	00000000 p8023.c=0A=
801ac4d0 l     F .text	00000000 p8023_datalink_header=0A=
00000000 l    df *ABS*	00000000 sysctl_net_802.c=0A=
00000000 l    df *ABS*	00000000 sch_generic.c=0A=
801ac6d8 l     F .text	00000000 dev_watchdog=0A=
801ac7f8 l     F .text	00000000 dev_watchdog_init=0A=
801ac888 l     F .text	00000000 dev_watchdog_up=0A=
801ac8e8 l     F .text	00000000 dev_watchdog_down=0A=
801ac974 l     F .text	00000000 noop_enqueue=0A=
801ac9cc l     F .text	00000000 noop_dequeue=0A=
801ac9d4 l     F .text	00000000 noop_requeue=0A=
801f4d04 l     O .text	00000010 prio2band=0A=
801aca4c l     F .text	00000000 pfifo_fast_enqueue=0A=
801acb28 l     F .text	00000000 pfifo_fast_dequeue=0A=
801acb98 l     F .text	00000000 pfifo_fast_requeue=0A=
801acbf8 l     F .text	00000000 pfifo_fast_reset=0A=
801acd04 l     F .text	00000000 pfifo_fast_init=0A=
8021e1c0 l     O .data	00000040 pfifo_fast_ops=0A=
00000000 l    df *ABS*	00000000 utils.c=0A=
803349a0 l     O .bss	00000012 buff.0=0A=
00000000 l    df *ABS*	00000000 route.c=0A=
801adaa0 l     F .text	00000000 rt_garbage_collect=0A=
801af2f4 l     F .text	00000000 ipv4_dst_check=0A=
801af31c l     F .text	00000000 ipv4_dst_reroute=0A=
801af324 l     F .text	00000000 ipv4_dst_destroy=0A=
801aec80 l     F .text	00000000 ipv4_negative_advice=0A=
801af3e8 l     F .text	00000000 ipv4_link_failure=0A=
801ad2b0 l     F .text	00000000 rt_cache_get_info=0A=
80334a08 l     O .bss	00000004 rt_hash_mask=0A=
80334a04 l     O .bss	00000004 rt_hash_table=0A=
801ad538 l     F .text	00000000 rt_cache_stat_get_info=0A=
803349c0 l     O .bss	00000004 rover.0=0A=
801ad610 l     F .text	00000000 rt_check_expire=0A=
80334a0c l     O .bss	00000004 rt_hash_log=0A=
803349f0 l     O .bss	00000014 rt_periodic_timer=0A=
801ad818 l     F .text	00000000 rt_run_flush=0A=
803349d8 l     O .bss	00000004 rt_deadline=0A=
8021e274 l     O .data	00000000 rt_flush_lock=0A=
803349dc l     O .bss	00000014 rt_flush_timer=0A=
8021e274 l     O .data	00000004 expire.1=0A=
803349c4 l     O .bss	00000004 last_gc.2=0A=
803349c8 l     O .bss	00000004 rover.3=0A=
803349cc l     O .bss	00000004 equilibrium.4=0A=
801adf18 l     F .text	00000000 rt_intern_hash=0A=
8021e278 l     O .data	00000000 rt_peer_lock.5=0A=
8021e278 l     O .data	00000000 ip_fb_id_lock.6=0A=
803349d0 l     O .bss	00000004 ip_fallback_id.7=0A=
801ae3ec l     F .text	00000000 ip_select_fb_ident=0A=
801ae580 l     F .text	00000000 rt_del=0A=
801aeea4 l     F .text	00000000 ip_error=0A=
8021e278 l     O .data	00000014 mtu_plateau=0A=
801af44c l     F .text	00000000 ip_rt_bug=0A=
801af630 l     F .text	00000000 rt_set_nexthop=0A=
801af748 l     F .text	00000000 ip_route_input_mc=0A=
801b0d74 l     F .text	00000000 ipv4_sysctl_rtcache_flush=0A=
80334a38 l     O .bss	00000004 flush_delay=0A=
801b0db4 l     F .text	00000000 ipv4_sysctl_rtcache_flush_strategy=0A=
00000000 l    df *ABS*	00000000 inetpeer.c=0A=
8021e5b0 l     O .data	00000028 peer_fake_node=0A=
8021e5d8 l     O .data	00000004 peer_root=0A=
8021e5dc l     O .data	00000000 peer_pool_lock=0A=
8021e5ec l     O .data	00000014 peer_periodic_timer=0A=
801b16fc l     F .text	00000000 peer_check_expire=0A=
80334a44 l     O .bss	00000004 peer_cachep=0A=
801b0e20 l     F .text	00000000 unlink_from_unused=0A=
801b0eb4 l     F .text	00000000 peer_avl_rebalance=0A=
801b1008 l     F .text	00000000 unlink_from_pool=0A=
80334a48 l     O .bss	00000004 peer_total=0A=
801b12ec l     F .text	00000000 cleanup_once=0A=
00000000 l    df *ABS*	00000000 proc.c=0A=
801b1870 l     F .text	00000000 fold_prot_inuse=0A=
801b19c0 l     F .text	00000000 fold_field=0A=
00000000 l    df *ABS*	00000000 protocol.c=0A=
8021e610 l     O .data	00000018 tcp_protocol=0A=
8021e628 l     O .data	00000018 udp_protocol=0A=
8021e640 l     O .data	00000018 icmp_protocol=0A=
00000000 l    df *ABS*	00000000 ip_input.c=0A=
801b1ff4 l     F .text	00000000 ip_run_ipprot=0A=
00000000 l    df *ABS*	00000000 ip_fragment.c=0A=
8021e66c l     O .data	00000000 ipfrag_lock=0A=
801b2810 l     F .text	00000000 ip_frag_destroy=0A=
801b292c l     F .text	00000000 ip_evictor=0A=
80334ba0 l     O .bss	00000100 ipq_hash=0A=
801b2ac8 l     F .text	00000000 ip_expire=0A=
801b2c58 l     F .text	00000000 ip_frag_intern=0A=
801b2d20 l     F .text	00000000 ip_frag_create=0A=
801b2e10 l     F .text	00000000 ip_frag_queue=0A=
801b32bc l     F .text	00000000 ip_frag_reasm=0A=
00000000 l    df *ABS*	00000000 ip_forward.c=0A=
00000000 l    df *ABS*	00000000 ip_options.c=0A=
00000000 l    df *ABS*	00000000 ip_output.c=0A=
801b4e90 l     F .text	00000000 ip_dev_loopback_xmit=0A=
801b5d08 l     F .text	00000000 ip_build_xmit_slow=0A=
801b6cf0 l     F .text	00000000 ip_reply_glue_bits=0A=
8021e688 l     O .data	00000014 ip_packet_type=0A=
00000000 l    df *ABS*	00000000 ip_sockglue.c=0A=
801b7170 l     F .text	00000000 ip_cmsg_recv_pktinfo=0A=
801b71cc l     F .text	00000000 ip_cmsg_recv_ttl=0A=
801b7204 l     F .text	00000000 ip_cmsg_recv_tos=0A=
801b7234 l     F .text	00000000 ip_cmsg_recv_opts=0A=
00000000 l    df *ABS*	00000000 tcp.c=0A=
801b98c8 l     F .text	00000000 tcp_listen_stop=0A=
801b9b8c l     F .text	00000000 wait_for_tcp_connect=0A=
801b9db4 l     F .text	00000000 wait_for_tcp_memory=0A=
801ba0a0 l     F .text	00000000 tcp_error=0A=
801bc0f8 l     F .text	00000000 tcp_recv_urg=0A=
801bc1fc l     F .text	00000000 cleanup_rbuf=0A=
801bc374 l     F .text	00000000 tcp_data_wait=0A=
801bc50c l     F .text	00000000 tcp_prequeue_process=0A=
8021e6c0 l     O .data	00000010 new_state=0A=
801bcf44 l     F .text	00000000 tcp_close_state=0A=
801be0b0 l     F .text	00000000 wait_for_connect=0A=
00000000 l    df *ABS*	00000000 tcp_input.c=0A=
801bf300 l     F .text	00000000 tcp_incr_quickack=0A=
801bf37c l     F .text	00000000 tcp_fixup_sndbuf=0A=
801bf3c0 l     F .text	00000000 __tcp_grow_window=0A=
801bf45c l     F .text	00000000 tcp_fixup_rcvbuf=0A=
801bf4c0 l     F .text	00000000 tcp_init_buffer_space=0A=
801bf608 l     F .text	00000000 tcp_clamp_window=0A=
801bf73c l     F .text	00000000 tcp_event_data_recv=0A=
801bfc90 l     F .text	00000000 tcp_init_metrics=0A=
801bfe1c l     F .text	00000000 tcp_update_reordering=0A=
801bfeac l     F .text	00000000 tcp_sacktag_write_queue=0A=
801c0778 l     F .text	00000000 tcp_check_sack_reneging=0A=
801c0894 l     F .text	00000000 tcp_time_to_recover=0A=
801c0ae0 l     F .text	00000000 tcp_check_reno_reordering=0A=
801c0b40 l     F .text	00000000 tcp_add_reno_sack=0A=
801c0bb0 l     F .text	00000000 tcp_remove_reno_sacks=0A=
801c0c40 l     F .text	00000000 tcp_mark_head_lost=0A=
801c0d6c l     F .text	00000000 tcp_update_scoreboard=0A=
801c0ecc l     F .text	00000000 tcp_cwnd_down=0A=
801c0f48 l     F .text	00000000 tcp_undo_cwr=0A=
801c0ff4 l     F .text	00000000 tcp_try_undo_recovery=0A=
801c1110 l     F .text	00000000 tcp_try_undo_dsack=0A=
801c1170 l     F .text	00000000 tcp_try_undo_partial=0A=
801c1274 l     F .text	00000000 tcp_try_undo_loss=0A=
801c1370 l     F .text	00000000 tcp_try_to_open=0A=
801c14cc l     F .text	00000000 tcp_fastretrans_alert=0A=
801c1a50 l     F .text	00000000 tcp_ack_saw_tstamp=0A=
801c1b90 l     F .text	00000000 tcp_ack_no_tstamp=0A=
801c1cc8 l     F .text	00000000 tcp_clean_rtx_queue=0A=
801c2058 l     F .text	00000000 tcp_ack_probe=0A=
801c213c l     F .text	00000000 tcp_ack_update_window=0A=
801c22a0 l     F .text	00000000 tcp_ack=0A=
801c2920 l     F .text	00000000 tcp_disordered_ack=0A=
801c29fc l     F .text	00000000 tcp_reset=0A=
801c2b50 l     F .text	00000000 tcp_fin=0A=
801c2e0c l     F .text	00000000 tcp_send_dupack=0A=
801c2f24 l     F .text	00000000 tcp_sack_maybe_coalesce=0A=
801c3024 l     F .text	00000000 tcp_sack_new_ofo_skb=0A=
801c3184 l     F .text	00000000 tcp_sack_remove=0A=
801c32a0 l     F .text	00000000 tcp_ofo_queue=0A=
801c3520 l     F .text	00000000 tcp_data_queue=0A=
801c46a4 l     F .text	00000000 tcp_prune_queue=0A=
801c416c l     F .text	00000000 tcp_collapse=0A=
801c45e0 l     F .text	00000000 tcp_collapse_ofo_queue=0A=
801c495c l     F .text	00000000 tcp_new_space=0A=
801c4a34 l     F .text	00000000 __tcp_data_snd_check=0A=
801c4b44 l     F .text	00000000 tcp_check_urg=0A=
801c4d0c l     F .text	00000000 tcp_copy_to_iovec=0A=
801c4e3c l     F .text	00000000 __tcp_checksum_complete_user=0A=
801c5888 l     F .text	00000000 tcp_rcv_synsent_state_process=0A=
00000000 l    df *ABS*	00000000 tcp_output.c=0A=
801c6ba0 l     F .text	00000000 tcp_advertise_mss=0A=
801c6bd0 l     F .text	00000000 tcp_cwnd_restart=0A=
801c7890 l     F .text	00000000 skb_split=0A=
801c7b00 l     F .text	00000000 tcp_fragment=0A=
801c83dc l     F .text	00000000 tcp_retrans_try_collapse=0A=
801ca3a4 l     F .text	00000000 tcp_xmit_probe_skb=0A=
00000000 l    df *ABS*	00000000 tcp_timer.c=0A=
801cb4f0 l     F .text	00000000 tcp_write_timer=0A=
801cadec l     F .text	00000000 tcp_delack_timer=0A=
801cb9a4 l     F .text	00000000 tcp_keepalive_timer=0A=
801ca920 l     F .text	00000000 tcp_write_err=0A=
801caa50 l     F .text	00000000 tcp_out_of_resources=0A=
801cac50 l     F .text	00000000 tcp_orphan_retries=0A=
801cac88 l     F .text	00000000 tcp_write_timeout=0A=
801cb044 l     F .text	00000000 tcp_probe_timer=0A=
801cb12c l     F .text	00000000 tcp_retransmit_timer=0A=
801cb644 l     F .text	00000000 tcp_synack_timer=0A=
00000000 l    df *ABS*	00000000 tcp_ipv4.c=0A=
8021e730 l     O .data	00000004 tcp_socket=0A=
80334d98 l     O .bss	000001d8 tcp_inode=0A=
801cbd70 l     F .text	00000000 tcp_v4_get_port=0A=
801cc228 l     F .text	00000000 tcp_v4_hash=0A=
801cc498 l     F .text	00000000 __tcp_v4_lookup_listener=0A=
801cc51c l     F .text	00000000 tcp_v4_check_established=0A=
801ccd8c l     F .text	00000000 tcp_v4_search_req=0A=
801cce58 l     F .text	00000000 tcp_v4_synq_add=0A=
801cd854 l     F .text	00000000 tcp_v4_send_reset=0A=
801cda38 l     F .text	00000000 tcp_v4_send_ack=0A=
801cdc78 l     F .text	00000000 tcp_v4_timewait_ack=0A=
801cdcf0 l     F .text	00000000 tcp_v4_or_send_ack=0A=
801cdd28 l     F .text	00000000 tcp_v4_route_req=0A=
801cde54 l     F .text	00000000 tcp_v4_send_synack=0A=
801cdf9c l     F .text	00000000 tcp_v4_or_free=0A=
80334d90 l     O .bss	00000004 warntime.0=0A=
801ce7a8 l     F .text	00000000 tcp_v4_hnd_req=0A=
801ce998 l     F .text	00000000 tcp_v4_checksum_init=0A=
801cf544 l     F .text	00000000 __tcp_v4_rehash=0A=
801cf584 l     F .text	00000000 tcp_v4_reselect_saddr=0A=
801cf8e8 l     F .text	00000000 v4_addr2sockaddr=0A=
801cfbac l     F .text	00000000 tcp_v4_init_sock=0A=
801cfca4 l     F .text	00000000 tcp_v4_destroy_sock=0A=
801cfeb4 l     F .text	00000000 get_openreq=0A=
801cff70 l     F .text	00000000 get_tcp_sock=0A=
801d0150 l     F .text	00000000 get_timewait_sock=0A=
00000000 l    df *ABS*	00000000 tcp_minisocks.c=0A=
801d0f94 l     F .text	00000000 __tcp_tw_hashdance=0A=
8021e824 l     O .data	00000004 tcp_tw_death_row_slot=0A=
8021e828 l     O .data	00000000 tw_death_lock=0A=
8021e828 l     O .data	00000014 tcp_tw_timer=0A=
801d13a0 l     F .text	00000000 tcp_twkill=0A=
80334f70 l     O .bss	00000020 tcp_tw_death_row=0A=
8021e83c l     O .data	00000004 tcp_twcal_hand=0A=
8021e840 l     O .data	00000014 tcp_twcal_timer=0A=
801d1784 l     F .text	00000000 tcp_twcal_tick=0A=
80334f94 l     O .bss	00000080 tcp_twcal_row=0A=
80334f90 l     O .bss	00000004 tcp_twcal_jiffie=0A=
00000000 l    df *ABS*	00000000 raw.c=0A=
801d2200 l     F .text	00000000 raw_v4_hash=0A=
801d22c0 l     F .text	00000000 raw_v4_unhash=0A=
801d2664 l     F .text	00000000 raw_rcv_skb=0A=
801d28b4 l     F .text	00000000 raw_getfrag=0A=
801d28d8 l     F .text	00000000 raw_getrawfrag=0A=
80335020 l     O .bss	00000004 complained.0=0A=
801d2a24 l     F .text	00000000 raw_sendmsg=0A=
801d2d7c l     F .text	00000000 raw_close=0A=
801d2db0 l     F .text	00000000 raw_bind=0A=
801d300c l     F .text	00000000 raw_init=0A=
801d3030 l     F .text	00000000 raw_seticmpfilter=0A=
801d3094 l     F .text	00000000 raw_geticmpfilter=0A=
801d3148 l     F .text	00000000 raw_setsockopt=0A=
801d31b0 l     F .text	00000000 raw_getsockopt=0A=
801d3218 l     F .text	00000000 raw_ioctl=0A=
801d32dc l     F .text	00000000 get_raw_sock=0A=
00000000 l    df *ABS*	00000000 udp.c=0A=
801d34d0 l     F .text	00000000 udp_v4_get_port=0A=
801d37d4 l     F .text	00000000 udp_v4_hash=0A=
801d3804 l     F .text	00000000 udp_v4_unhash=0A=
801d3b80 l     F .text	00000000 udp_check=0A=
801d3be4 l     F .text	00000000 udp_getfrag=0A=
801d3d34 l     F .text	00000000 udp_getfrag_nosum=0A=
801d48cc l     F .text	00000000 udp_close=0A=
801d48e8 l     F .text	00000000 udp_queue_rcv_skb=0A=
801d4a70 l     F .text	00000000 udp_v4_mcast_deliver=0A=
801d4c74 l     F .text	00000000 udp_checksum_init=0A=
801d50c8 l     F .text	00000000 get_udp_sock=0A=
00000000 l    df *ABS*	00000000 arp.c=0A=
8021e980 l     O .data	00000020 arp_generic_ops=0A=
801d567c l     F .text	00000000 arp_solicit=0A=
801d55f8 l     F .text	00000000 arp_error_report=0A=
8021e9a0 l     O .data	00000020 arp_hh_ops=0A=
8021e9c0 l     O .data	00000020 arp_direct_ops=0A=
801d5420 l     F .text	00000000 arp_hash=0A=
801d5450 l     F .text	00000000 arp_constructor=0A=
801d5ef4 l     F .text	00000000 parp_redo=0A=
801d57d8 l     F .text	00000000 arp_filter=0A=
801d5894 l     F .text	00000000 arp_set_predefined=0A=
801d6770 l     F .text	00000000 arp_state_to_flags=0A=
801d67a0 l     F .text	00000000 arp_req_get=0A=
801d6c7c l     F .text	00000000 arp_get_info=0A=
8021ebb0 l     O .data	00000014 arp_packet_type=0A=
00000000 l    df *ABS*	00000000 icmp.c=0A=
8021ec5c l     O .data	00000004 icmp_xmit_holder=0A=
801d70a0 l     F .text	00000000 icmp_xmit_lock_bh=0A=
801d70b0 l     F .text	00000000 icmp_xmit_unlock_bh=0A=
801d7128 l     F .text	00000000 icmp_out_count=0A=
8021ec60 l     O .data	00000130 icmp_pointers=0A=
801d71ac l     F .text	00000000 icmp_glue_bits=0A=
801d726c l     F .text	00000000 icmp_reply=0A=
801d78c0 l     F .text	00000000 icmp_unreach=0A=
801d7be8 l     F .text	00000000 icmp_redirect=0A=
801d7cac l     F .text	00000000 icmp_echo=0A=
801d7d14 l     F .text	00000000 icmp_timestamp=0A=
801d7e74 l     F .text	00000000 icmp_address=0A=
801d7e7c l     F .text	00000000 icmp_address_reply=0A=
801d8064 l     F .text	00000000 icmp_discard=0A=
00000000 l    df *ABS*	00000000 devinet.c=0A=
8021edc8 l     O .data	00000038 ipv4_devconf_dflt=0A=
801d82a0 l     F .text	00000000 inet_alloc_ifa=0A=
801d9fbc l     F .text	00000000 devinet_sysctl_register=0A=
801d8618 l     F .text	00000000 inetdev_destroy=0A=
801d8870 l     F .text	00000000 inet_del_ifa=0A=
801da118 l     F .text	00000000 devinet_sysctl_unregister=0A=
80335620 l     O .bss	00000004 inetaddr_chain=0A=
801d8b50 l     F .text	00000000 inet_insert_ifa=0A=
801d8e0c l     F .text	00000000 inet_set_ifa=0A=
801d9998 l     F .text	00000000 inet_gifconf=0A=
801d9c30 l     F .text	00000000 inetdev_event=0A=
801d9f1c l     F .text	00000000 devinet_sysctl_forward=0A=
8021ee0c l     O .data	000003cc devinet_sysctl=0A=
00000000 l    df *ABS*	00000000 af_inet.c=0A=
801da4c4 l     F .text	00000000 inet_autobind=0A=
801da7fc l     F .text	00000000 inet_create=0A=
801dab10 l     F .text	00000000 inet_bind=0A=
801dae88 l     F .text	00000000 inet_wait_for_connect=0A=
801db520 l     F .text	00000000 inet_getname=0A=
801db89c l     F .text	00000000 inet_ioctl=0A=
8021f278 l     O .data	00000060 inetsw_array=0A=
8020d06c l     F .text.init	00000000 inet_init=0A=
80210090 l     O .initcall.init	00000004 __initcall_inet_init=0A=
00000000 l    df *ABS*	00000000 igmp.c=0A=
801dbd40 l     F .text	00000000 ip_ma_put=0A=
801dbdbc l     F .text	00000000 ip_mc_filter_add=0A=
801dbe10 l     F .text	00000000 ip_mc_filter_del=0A=
801dbe64 l     F .text	00000000 igmp_group_dropped=0A=
801dbe98 l     F .text	00000000 igmp_group_added=0A=
801dc58c l     F .text	00000000 ip_mc_find_dev=0A=
00000000 l    df *ABS*	00000000 sysctl_net_ipv4.c=0A=
8021f2f0 l     O .data	00000004 tcp_retr1_max=0A=
8021f2f4 l     O .data	00000008 ip_local_port_range_min=0A=
8021f2fc l     O .data	00000008 ip_local_port_range_max=0A=
801dcae0 l     F .text	00000000 ipv4_sysctl_forward=0A=
801dcb50 l     F .text	00000000 ipv4_sysctl_forward_strategy=0A=
00000000 l    df *ABS*	00000000 fib_frontend.c=0A=
801dcc1c l     F .text	00000000 fib_get_procinfo=0A=
801dd340 l     F .text	00000000 fib_magic=0A=
801dd498 l     F .text	00000000 fib_add_ifaddr=0A=
801dd628 l     F .text	00000000 fib_del_ifaddr=0A=
801dd818 l     F .text	00000000 fib_disable_ip=0A=
801dd868 l     F .text	00000000 fib_inetaddr_event=0A=
801dd8f8 l     F .text	00000000 fib_netdev_event=0A=
00000000 l    df *ABS*	00000000 fib_semantics.c=0A=
8021fbf0 l     O .data	00000000 fib_info_lock=0A=
8021fbf0 l     O .data	00000068 fib_props=0A=
80335920 l     O .bss	00000004 fib_info_list=0A=
801ddbec l     F .text	00000000 fib_check_nh=0A=
8021fc58 l     O .data	00000030 type2flags.0=0A=
801de95c l     F .text	00000000 fib_flag_trans=0A=
00000000 l    df *ABS*	00000000 fib_hash.c=0A=
8021fc90 l     O .data	00000000 fib_hash_lock=0A=
801deac0 l     F .text	00000000 fn_free_node=0A=
80335930 l     O .bss	00000004 fn_hash_kmem=0A=
801deaf8 l     F .text	00000000 fn_new_zone=0A=
801decc0 l     F .text	00000000 fn_hash_lookup=0A=
8021fc90 l     O .data	00000004 fn_hash_last_dflt=0A=
801dee64 l     F .text	00000000 fib_detect_death=0A=
801def64 l     F .text	00000000 fn_hash_select_default=0A=
801df1c8 l     F .text	00000000 fn_hash_insert=0A=
801df650 l     F .text	00000000 fn_hash_delete=0A=
80335934 l     O .bss	00000004 fib_hash_zombies=0A=
801df978 l     F .text	00000000 fn_hash_flush=0A=
801dfac4 l     F .text	00000000 fn_hash_get_info=0A=
00000000 l    df *ABS*	00000000 ipconfig.c=0A=
8020fef0 l     O .data.init	00000010 user_dev_name=0A=
8020ff00 l     O .data.init	00000004 ic_proto_have_if=0A=
8021fca4 l     O .data	00000000 ic_recv_lock=0A=
8020ff04 l     O .data.init	00000004 ic_got_reply=0A=
8020ff08 l     O .data.init	00000004 ic_first_dev=0A=
8020ff0c l     O .data.init	00000004 ic_dev=0A=
8020d408 l     F .text.init	00000000 ic_open_devs=0A=
8020d700 l     F .text.init	00000000 ic_close_devs=0A=
8020d7d4 l     F .text.init	00000000 ic_dev_ioctl=0A=
8020d804 l     F .text.init	00000000 ic_route_ioctl=0A=
8020d834 l     F .text.init	00000000 ic_setup_if=0A=
8020d944 l     F .text.init	00000000 ic_setup_routes=0A=
8020da24 l     F .text.init	00000000 ic_defaults=0A=
8020ff10 l     O .data.init	00000014 bootp_packet_type=0A=
8020e10c l     F .text.init	00000000 ic_bootp_recv=0A=
801f879c l     O .text	00000004 ic_bootp_cookie=0A=
8020db80 l     F .text.init	00000000 ic_bootp_init_ext=0A=
8020dc54 l     F .text.init	00000000 ic_bootp_send_if=0A=
8020df44 l     F .text.init	00000000 ic_bootp_string=0A=
8020df9c l     F .text.init	00000000 ic_do_bootp_ext=0A=
8020e464 l     F .text.init	00000000 ic_dynamic=0A=
801dfc00 l     F .text	00000000 pnp_get_info=0A=
8020e7a8 l     F .text.init	00000000 ip_auto_config=0A=
80210094 l     O .initcall.init	00000004 __initcall_ip_auto_config=0A=
8020ea58 l     F .text.init	00000000 ic_proto_name=0A=
8020eb74 l     F .text.init	00000000 ip_auto_config_setup=0A=
8020ee48 l     F .text.init	00000000 nfsaddrs_config_setup=0A=
8020ff24 l     O .data.init	00000004 =
__setup_str_ip_auto_config_setup=0A=
80210028 l     O .setup.init	00000008 __setup_ip_auto_config_setup=0A=
8020ff28 l     O .data.init	0000000a =
__setup_str_nfsaddrs_config_setup=0A=
80210030 l     O .setup.init	00000008 __setup_nfsaddrs_config_setup=0A=
00000000 l    df *ABS*	00000000 af_unix.c=0A=
8021fcb4 l     O .data	00000004 unix_nr_socks=0A=
801dfd60 l     F .text	00000000 unix_mkname=0A=
801dfe10 l     F .text	00000000 __unix_remove_socket=0A=
801dfe80 l     F .text	00000000 __unix_insert_socket=0A=
801dff00 l     F .text	00000000 __unix_find_socket_byname=0A=
801dff90 l     F .text	00000000 unix_find_socket_byinode=0A=
801dffe4 l     F .text	00000000 unix_write_space=0A=
801e006c l     F .text	00000000 unix_dgram_disconnected=0A=
801e01ac l     F .text	00000000 unix_sock_destructor=0A=
801e0368 l     F .text	00000000 unix_release_sock=0A=
801e0670 l     F .text	00000000 unix_listen=0A=
801e0728 l     F .text	00000000 unix_create1=0A=
801e0830 l     F .text	00000000 unix_create=0A=
801e08b8 l     F .text	00000000 unix_release=0A=
8021fcb8 l     O .data	00000004 ordernum.0=0A=
801e08ec l     F .text	00000000 unix_autobind=0A=
801e0ad4 l     F .text	00000000 unix_find_other=0A=
801e0c2c l     F .text	00000000 unix_bind=0A=
801e0ff8 l     F .text	00000000 unix_dgram_connect=0A=
801e1174 l     F .text	00000000 unix_wait_for_peer=0A=
801e1244 l     F .text	00000000 unix_stream_connect=0A=
801e16e0 l     F .text	00000000 unix_socketpair=0A=
801e176c l     F .text	00000000 unix_accept=0A=
801e1870 l     F .text	00000000 unix_getname=0A=
801e1960 l     F .text	00000000 unix_detach_fds=0A=
801e19d4 l     F .text	00000000 unix_destruct_fds=0A=
801e1a38 l     F .text	00000000 unix_attach_fds=0A=
801e1ab4 l     F .text	00000000 unix_dgram_sendmsg=0A=
801e1f88 l     F .text	00000000 unix_stream_sendmsg=0A=
801e2378 l     F .text	00000000 unix_copy_addr=0A=
801e23c0 l     F .text	00000000 unix_dgram_recvmsg=0A=
801e252c l     F .text	00000000 unix_stream_data_wait=0A=
801e266c l     F .text	00000000 unix_stream_recvmsg=0A=
801e2c34 l     F .text	00000000 unix_shutdown=0A=
801e2d90 l     F .text	00000000 unix_ioctl=0A=
801e2e50 l     F .text	00000000 unix_poll=0A=
801e2f14 l     F .text	00000000 unix_read_proc=0A=
8020ff34 l     O .data.init	00000038 banner=0A=
8020ee64 l     F .text.init	00000000 af_unix_init=0A=
80210098 l     O .initcall.init	00000004 __initcall_af_unix_init=0A=
00000000 l    df *ABS*	00000000 garbage.c=0A=
8021fd60 l     O .data	00000004 gc_current=0A=
8021fd68 l     O .data	00000010 unix_gc_sem.0=0A=
00000000 l    df *ABS*	00000000 sysctl_net_unix.c=0A=
8021fdd8 l     O .data	00000058 unix_net_table=0A=
8021fe30 l     O .data	00000058 unix_root_table=0A=
80335da0 l     O .bss	00000004 unix_sysctl_header=0A=
00000000 l    df *ABS*	00000000 netsyms.c=0A=
00000000 l    df *ABS*	00000000 sysctl_net.c=0A=
00000000 l    df *ABS*	00000000 csum_partial.S=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/regdef.h=0A=
00000000 l    df *ABS*	00000000 csum_partial.S=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/asm.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/sgidefs.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/asm.h=0A=
00000000 l    df *ABS*	00000000 csum_partial.S=0A=
801e3760 l       .text	00000000 small_csumcpy=0A=
801e3d38 l       .text	00000000 out=0A=
801e383c l       .text	00000000 hword_align=0A=
801e3864 l       .text	00000000 word_align=0A=
801e3888 l       .text	00000000 dword_align=0A=
801e3cf0 l       .text	00000000 do_end_words=0A=
801e38b8 l       .text	00000000 qword_align=0A=
801e38ec l       .text	00000000 oword_align=0A=
801e3940 l       .text	00000000 begin_movement=0A=
801e3948 l       .text	00000000 move_128bytes=0A=
801e3b5c l       .text	00000000 move_64bytes=0A=
801e3c68 l       .text	00000000 move_32bytes=0A=
801e3d14 l       .text	00000000 maybe_end_cruft=0A=
801e3cf8 l       .text	00000000 end_words=0A=
801e3d18 l       .text	00000000 small_memcpy=0A=
801e3d28 l       .text	00000000 end_bytes=0A=
00000000 l    df *ABS*	00000000 csum_partial_copy.c=0A=
00000000 l    df *ABS*	00000000 rtc-no.c=0A=
80335db0 l     O .bss	00000004 called.0=0A=
801e3e50 l     F .text	00000000 shouldnt_happen=0A=
00000000 l    df *ABS*	00000000 memcpy.S=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/regdef.h=0A=
00000000 l    df *ABS*	00000000 memcpy.S=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/offset.h=0A=
00000000 l    df *ABS*	00000000 memcpy.S=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/asm.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/sgidefs.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/asm.h=0A=
00000000 l    df *ABS*	00000000 memcpy.S=0A=
801e3ea4 l       .text	00000000 __memcpy=0A=
801e3ec0 l       .text	00000000 can_align=0A=
801e41e4 l       .text	00000000 memcpy_u_src=0A=
801e41bc l       .text	00000000 small_memcpy=0A=
801e41dc l       .text	00000000 out=0A=
801e3ed0 l       .text	00000000 hword_align=0A=
801e3ef0 l       .text	00000000 word_align=0A=
801e4654 l       .text	00000000 l_fixup=0A=
801e4670 l       .text	00000000 s_fixup=0A=
801e3f10 l       .text	00000000 dword_align=0A=
801e4198 l       .text	00000000 do_end_words=0A=
801e3f3c l       .text	00000000 qword_align=0A=
801e3f64 l       .text	00000000 oword_align=0A=
801e3f9c l       .text	00000000 begin_movement=0A=
801e3fa4 l       .text	00000000 move_128bytes=0A=
801e40bc l       .text	00000000 move_64bytes=0A=
801e414c l       .text	00000000 move_32bytes=0A=
801e41b8 l       .text	00000000 maybe_end_cruft=0A=
801e41a0 l       .text	00000000 end_words=0A=
801e41c4 l       .text	00000000 end_bytes=0A=
801e458c l       .text	00000000 u_do_end_words=0A=
801e4238 l       .text	00000000 u_qword_align=0A=
801e4268 l       .text	00000000 u_oword_align=0A=
801e42b0 l       .text	00000000 u_begin_movement=0A=
801e42b8 l       .text	00000000 u_move_128bytes=0A=
801e4450 l       .text	00000000 u_move_64bytes=0A=
801e4520 l       .text	00000000 u_move_32bytes=0A=
801e45b0 l       .text	00000000 u_maybe_end_cruft=0A=
801e4594 l       .text	00000000 u_end_words=0A=
801e45b4 l       .text	00000000 u_cannot_optimize=0A=
801e45bc l       .text	00000000 u_end_bytes=0A=
801e462c l       .text	00000000 r_out=0A=
801e4634 l       .text	00000000 r_end_bytes_up=0A=
801e4614 l       .text	00000000 r_end_bytes=0A=
00000000 l    df *ABS*	00000000 memset.S=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/regdef.h=0A=
00000000 l    df *ABS*	00000000 memset.S=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/offset.h=0A=
00000000 l    df *ABS*	00000000 memset.S=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/asm.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/sgidefs.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/asm.h=0A=
00000000 l    df *ABS*	00000000 memset.S=0A=
801e4788 l       .text	00000000 small_memset=0A=
801e47a4 l       .text	00000000 first_fixup=0A=
801e471c l       .text	00000000 memset_partial=0A=
801e47ac l       .text	00000000 fwd_fixup=0A=
801e47c0 l       .text	00000000 partial_fixup=0A=
801e47d4 l       .text	00000000 last_fixup=0A=
00000000 l    df *ABS*	00000000 strlen_user.S=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/sgidefs.h=0A=
00000000 l    df *ABS*	00000000 strlen_user.S=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/regdef.h=0A=
00000000 l    df *ABS*	00000000 strlen_user.S=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/offset.h=0A=
00000000 l    df *ABS*	00000000 strlen_user.S=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/asm.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/sgidefs.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/asm.h=0A=
00000000 l    df *ABS*	00000000 strlen_user.S=0A=
801e4808 l       .text	00000000 fault=0A=
00000000 l    df *ABS*	00000000 strncpy_user.S=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/regdef.h=0A=
00000000 l    df *ABS*	00000000 strncpy_user.S=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/offset.h=0A=
00000000 l    df *ABS*	00000000 strncpy_user.S=0A=
00000000 l    df *ABS*	00000000 /opt/iDISX/src/linux/include/asm/asm.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/sgidefs.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/asm.h=0A=
00000000 l    df *ABS*	00000000 strncpy_user.S=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/linux/errno.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/errno.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/linux/errno.h=0A=
00000000 l    df *ABS*	00000000 strncpy_user.S=0A=
801e485c l       .text	00000000 fault=0A=
00000000 l    df *ABS*	00000000 strnlen_user.S=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/sgidefs.h=0A=
00000000 l    df *ABS*	00000000 strnlen_user.S=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/regdef.h=0A=
00000000 l    df *ABS*	00000000 strnlen_user.S=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/offset.h=0A=
00000000 l    df *ABS*	00000000 strnlen_user.S=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/asm.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/sgidefs.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/asm.h=0A=
00000000 l    df *ABS*	00000000 strnlen_user.S=0A=
801e48a4 l       .text	00000000 fault=0A=
00000000 l    df *ABS*	00000000 dump_tlb.c=0A=
00000000 l    df *ABS*	00000000 errno.c=0A=
00000000 l    df *ABS*	00000000 ctype.c=0A=
00000000 l    df *ABS*	00000000 string.c=0A=
00000000 l    df *ABS*	00000000 vsprintf.c=0A=
801e5698 l     F .text	00000000 skip_atoi=0A=
801e5700 l     F .text	00000000 number=0A=
00000000 l    df *ABS*	00000000 cmdline.c=0A=
00000000 l    df *ABS*	00000000 rbtree.c=0A=
801e6ac0 l     F .text	00000000 __rb_rotate_left=0A=
801e6b0c l     F .text	00000000 __rb_rotate_right=0A=
801e6c9c l     F .text	00000000 __rb_erase_color=0A=
00000000 l    df *ABS*	00000000 rwsem-spinlock.c=0A=
00000000 l    df *ABS*	00000000 idisx_int.c=0A=
00000000 l    df *ABS*	00000000 time.c=0A=
80220080 l     O .data	00000004 last_rtc_update=0A=
80220084 l     O .data	00000004 timer_tick_count=0A=
80220088 l     O .data	0000001e display_string=0A=
802200a8 l     O .data	00000004 display_count=0A=
801e7300 l     F .text	00000000 set_rtc_mmss=0A=
80335de0 l     O .bss	00000004 r4k_offset=0A=
80335de4 l     O .bss	00000004 r4k_cur=0A=
8020eefc l     F .text.init	00000000 get_mips_time=0A=
802200ac l     O .data	00000004 timerhi=0A=
802200b0 l     O .data	00000004 timerlo=0A=
802200b4 l     O .data	00000004 last_jiffies.0=0A=
802200b8 l     O .data	00000004 cached_quotient.1=0A=
801e7534 l     F .text	00000000 do_fast_gettimeoffset=0A=
00000000 l    df *ABS*	00000000 idisx_setup.c=0A=
00000000 l    df *ABS*	00000000 init.c=0A=
00000000 l    df *ABS*	00000000 memory.c=0A=
802200d0 l     O .data	0000000c mtypes=0A=
8020f448 l     F .text.init	00000000 prom_memtype_classify=0A=
00000000 l    df *ABS*	00000000 printf.c=0A=
801e7860 l     F .text	00000000 serial_in=0A=
801e78ac l     F .text	00000000 serial_out=0A=
802200e0 l     O .data	00000188 rs_table=0A=
80220268 l     O .data	000000ac prom_port_info=0A=
80335fa0 l     O .bss	00000400 buf=0A=
00000000 l    df *ABS*	00000000 display.c=0A=
00000000 l    df *ABS*	00000000 cmdline.c=0A=
00000000 l    df *ABS*	00000000 gdb_hook.c=0A=
80220320 l     O .data	00000188 rs_table=0A=
802204a8 l     O .data	000000ac kdb_port_info=0A=
00000000 l    df *ABS*	00000000 idisx_rtc.c=0A=
80220560 l     O .data	00000004 baseaddr=0A=
801e7c30 l     F .text	00000000 idisx_rtc_read_data=0A=
801e7cb4 l     F .text	00000000 idisx_rtc_write_data=0A=
801e7d50 l     F .text	00000000 idisx_rtc_bcd_mode=0A=
00000000 l    df *ABS*	00000000 reset.c=0A=
801e7d80 l     F .text	00000000 idisx_machine_restart=0A=
801e7d94 l     F .text	00000000 idisx_machine_halt=0A=
801e7da8 l     F .text	00000000 idisx_machine_power_off=0A=
00000000 l    df *ABS*	00000000 idisxIRQ.S=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/stackframe.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/linux/config.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/stackframe.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/offset.h=0A=
00000000 l    df *ABS*	00000000 /opt/iDISX/src/linux/include/asm/stackfr=
ame.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/asm.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/stackframe.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/processor.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/isadep.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/linux/config.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/isadep.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/processor.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/linux/cache.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/cache.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/linux/config.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/cache.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/linux/cache.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/linux/config.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/linux/cache.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/processor.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/linux/config.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/processor.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/stackframe.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/mipsregs.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/stackframe.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/addrspace.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/stackframe.h=0A=
00000000 l    df *ABS*	00000000 idisxIRQ.S=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/regdef.h=0A=
00000000 l    df *ABS*	00000000 idisxIRQ.S=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/mipsregs.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/linux/config.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/mipsregs.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/linux/linkage.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/linux/config.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/linux/linkage.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/mipsregs.h=0A=
00000000 l    df *ABS*	00000000 idisxIRQ.S=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/asm.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/sgidefs.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/asm/asm.h=0A=
00000000 l    df *ABS*	00000000 idisxIRQ.S=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/linux/config.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/linux/autoconf.h=0A=
00000000 l    df *ABS*	00000000 =
/opt/iDISX/src/linux/include/linux/config.h=0A=
00000000 l    df *ABS*	00000000 idisxIRQ.S=0A=
00000000 l    df *ABS*	00000000 pci.c=0A=
00000000 l    df *ABS*	00000000 mqb_int.c=0A=
802205a8 l     O .data	00000004 count.0=0A=
00000000 l    df *ABS*	00000000 ddr.c=0A=
80154ee4 g     F .text	00000000 fcntl_getlease=0A=
8019f468 g     F .text	00000000 sys_recv=0A=
8020baa0 g     F .text.init	00000000 loop_init=0A=
8011e8c8 g     F .text	00000000 is_orphaned_pgrp=0A=
80200078 g     O __ksymtab	00000008 __ksymtab_blk_queue_make_request=0A=
801595bc g     F .text	00000000 iget4=0A=
8021ba20 g     O .data	00000048 proc_kcore_operations=0A=
80148770 g     F .text	00000000 cdget=0A=
8021a0fc g     O .data	00000004 fs_overflowgid=0A=
801ffe08 g     O __ksymtab	00000008 __ksymtab_get_empty_inode=0A=
80320870 g     O .bss	00000004 core_uses_pid=0A=
801ffd18 g     O __ksymtab	00000008 __ksymtab_simple_strtoul=0A=
801db59c g     F .text	00000000 inet_recvmsg=0A=
80154088 g     F .text	00000000 posix_test_lock=0A=
8010c6d0 g     F .text	00000000 sys_pause=0A=
8021ee00 g     O .data	00000000 inetdev_lock=0A=
802004e8 g     O __ksymtab	00000008 =
__ksymtab_register_inetaddr_notifier=0A=
8012575c g     F .text	00000000 sys_getgid=0A=
802070d4 g     F .text.init	00000000 init_bootmem=0A=
8018cccc g     F .text	00000000 raw_ctl_ioctl=0A=
8019f488 g     F .text	00000000 sys_setsockopt=0A=
801ff220 g     O __ksymtab	00000008 __ksymtab_abi_defhandler_elf=0A=
80116e90 g     F .text	00000000 update_mmu_cache=0A=
801b3bd0 g     F .text	00000000 ip_options_build=0A=
8012f0c4 g     F .text	00000000 truncate_inode_pages=0A=
80335640 g     O .bss	00000058 inetsw=0A=
801568f0 g     F .text	00000000 prune_dcache=0A=
801ff950 g     O __ksymtab	00000008 __ksymtab_unlock_page=0A=
801421ec g     F .text	00000000 __invalidate_buffers=0A=
801ff5d0 g     O __ksymtab	00000008 __ksymtab___mark_inode_dirty=0A=
801fcf90 g     O .kstrtab	00000009 __kstrtab_arp_send=0A=
8017aa30 g     F .text	00000000 ieee754dp_ceil=0A=
8012b374 g     F .text	00000000 zap_page_range=0A=
8013f4b4 g     F .text	00000000 filp_open=0A=
801fad6c g     O .kstrtab	00000019 =
__kstrtab_inter_module_get_request=0A=
801541d4 g     F .text	00000000 locks_mandatory_area=0A=
801ff088 g     O __ksymtab	00000008 __ksymtab_isa_slot_offset=0A=
801faef0 g     O .kstrtab	00000011 __kstrtab_kmem_cache_alloc=0A=
801a4204 g     F .text	00000000 skb_free_datagram=0A=
801fc928 g     O .kstrtab	0000000b __kstrtab_sock_alloc=0A=
8013fb00 g     F .text	00000000 sys_close=0A=
801ff168 g     O __ksymtab	00000008 __ksymtab__flush_page_to_ram=0A=
8020ff70 g     O *ABS*	00000000 __setup_start=0A=
8021e220 g     O .data	00000004 ip_rt_error_cost=0A=
801ff720 g     O __ksymtab	00000008 __ksymtab_generic_commit_write=0A=
801fbb40 g     O .kstrtab	00000012 __kstrtab_unregister_binfmt=0A=
80147ee8 g     F .text	00000000 get_blkfops=0A=
801ff558 g     O __ksymtab	00000008 __ksymtab_dcache_lock=0A=
801fb3a4 g     O .kstrtab	00000012 __kstrtab_generic_direct_IO=0A=
8012941c g     F .text	00000000 sys_setsid=0A=
8016625c g     F .text	00000000 devfs_register_partitions=0A=
801fff80 g     O __ksymtab	00000008 __ksymtab_proc_symlink=0A=
801ff328 g     O __ksymtab	00000008 __ksymtab_in_egroup_p=0A=
8010f340 g     F .text	00000000 bust_spinlocks=0A=
801949ec g     F .text	00000000 rs_read_proc=0A=
8015ad70 g     F .text	00000000 alloc_vfsmnt=0A=
801ff5b0 g     O __ksymtab	00000008 __ksymtab___d_path=0A=
801fb088 g     O .kstrtab	0000000c __kstrtab___user_walk=0A=
801ff678 g     O __ksymtab	00000008 __ksymtab_notify_change=0A=
801ffac8 g     O __ksymtab	00000008 __ksymtab_register_sysctl_table=0A=
8017430c g     F .text	00000000 sys_msgget=0A=
801fcf3c g     O .kstrtab	00000014 __kstrtab_ip_route_output_key=0A=
801fcf0c g     O .kstrtab	00000016 __kstrtab_inet_register_protosw=0A=
8021ed90 g     O .data	00000038 ipv4_devconf=0A=
801ff538 g     O __ksymtab	00000008 __ksymtab___user_walk=0A=
801ffe98 g     O __ksymtab	00000008 __ksymtab_tasklet_hi_vec=0A=
802192d4 g     O .data	00000004 abi_defhandler_elf=0A=
8010bc08 g     F .text	00000000 sys_iopl=0A=
801fd420 g     O .kstrtab	0000000e __kstrtab_dev_mc_delete=0A=
8020f688 g     F .text.init	00000000 prom_getcmdline=0A=
801fd4b4 g     O .kstrtab	0000000e __kstrtab_qdisc_restart=0A=
803363a0 g     O .bss	00000050 arcs_cmdline=0A=
8012de04 g     F .text	00000000 find_extend_vma=0A=
8010d98c g     F .text	00000000 free_irq=0A=
801e7820 g     F .text	00000000 get_system_type=0A=
801fade8 g     O .kstrtab	00000008 __kstrtab_exit_fs=0A=
801fb150 g     O .kstrtab	00000012 __kstrtab_mark_buffer_dirty=0A=
80200320 g     O __ksymtab	00000008 __ksymtab_neigh_lookup=0A=
801abfc4 g     F .text	00000000 net_srandom=0A=
801fc060 g     O .kstrtab	00000008 __kstrtab_uts_sem=0A=
801ff358 g     O __ksymtab	00000008 __ksymtab_inter_module_register=0A=
8021a0a4 g     O .data	00000004 time_tolerance=0A=
8011e8e4 g     F .text	00000000 put_files_struct=0A=
801cb92c g     F .text	00000000 tcp_set_keepalive=0A=
8011c1ec g     F .text	00000000 inter_module_unregister=0A=
8010f91c g     F .text	00000038 r4k_clear_page_s64=0A=
801fbd10 g     O .kstrtab	00000014 __kstrtab_wait_for_completion=0A=
801ffff8 g     O __ksymtab	00000008 __ksymtab_misc_deregister=0A=
801fcfac g     O .kstrtab	00000012 __kstrtab___ip_select_ident=0A=
80162110 g     F .text	00000000 proc_match=0A=
801fffe0 g     O __ksymtab	00000008 __ksymtab_tty_unregister_devfs=0A=
801fffc0 g     O __ksymtab	00000008 __ksymtab_proc_bus=0A=
80119084 g     F .text	00000000 daemonize=0A=
801fb300 g     O .kstrtab	0000000e __kstrtab_set_blocksize=0A=
801ff7b0 g     O __ksymtab	00000008 __ksymtab_posix_unblock_lock=0A=
801444dc g     F .text	00000000 generic_block_bmap=0A=
80126ca4 g     F .text	00000000 kill_pg=0A=
8015adf0 g     F .text	00000000 free_vfsmnt=0A=
801ae488 g     F .text	00000000 __ip_select_ident=0A=
801d0204 g     F .text	00000000 tcp_get_info=0A=
801ffa90 g     O __ksymtab	00000008 __ksymtab_register_binfmt=0A=
8014c0d4 g     F .text	00000000 get_write_access=0A=
80200408 g     O __ksymtab	00000008 __ksymtab_inet_register_protosw=0A=
803164c8 g     O .bss	00000004 _flush_cache_sigtramp=0A=
801faa74 g     O .kstrtab	00000013 __kstrtab_abi_defhandler_elf=0A=
801facbc g     O .kstrtab	0000000c __kstrtab_in_egroup_p=0A=
803163e0 g     O .bss	00000004 unaligned_instructions=0A=
801fc8b4 g     O .kstrtab	0000000e __kstrtab_sock_register=0A=
801fbcfc g     O .kstrtab	00000012 __kstrtab_remove_wait_queue=0A=
8021ec50 g     O .data	00000004 sysctl_icmp_ratelimit=0A=
801214d4 g     F .text	00000000 request_resource=0A=
801c7f54 g     F .text	00000000 tcp_write_xmit=0A=
801b1878 g     F .text	00000000 afinet_get_info=0A=
801abe5c g     F .text	00000000 rtnl_unlock=0A=
801fc10c g     O .kstrtab	0000000d __kstrtab_csum_partial=0A=
803164ac g     O .bss	00000004 ___flush_cache_all=0A=
801ff3d8 g     O __ksymtab	00000008 __ksymtab___get_free_pages=0A=
801fbdc4 g     O .kstrtab	0000000c __kstrtab_lock_kiovec=0A=
801fff10 g     O __ksymtab	00000008 __ksymtab_pidhash=0A=
801fd048 g     O .kstrtab	0000000d __kstrtab_ip_cmsg_recv=0A=
801faadc g     O .kstrtab	00000007 __kstrtab_printk=0A=
801fd128 g     O .kstrtab	00000011 __kstrtab_dev_set_allmulti=0A=
80155e2c g     F .text	00000000 posix_block_lock=0A=
801ffc10 g     O __ksymtab	00000008 __ksymtab_check_resource=0A=
8010d78c g     F .text	00000000 do_IRQ=0A=
801b6fd8 g     F .text	00000000 ip_finish_output=0A=
802006d8 g     O __ksymtab	00000008 __ksymtab_noop_qdisc=0A=
801ac130 g     F .text	00000000 eth_header=0A=
801fb0d8 g     O .kstrtab	00000009 __kstrtab_d_delete=0A=
80181110 g     F .text	00000000 ieee754sp_mul=0A=
801ffd80 g     O __ksymtab	00000008 __ksymtab_csum_partial=0A=
801ffd08 g     O __ksymtab	00000008 __ksymtab_bdevname=0A=
801fcf60 g     O .kstrtab	0000000a __kstrtab_icmp_send=0A=
80157050 g     F .text	00000000 d_instantiate=0A=
801fce6c g     O .kstrtab	0000000b __kstrtab_scm_fp_dup=0A=
801663e4 g     F .text	00000000 read_dev_sector=0A=
8031d738 g     O .bss	0000000c avenrun=0A=
801ff300 g     O __ksymtab	00000008 =
__ksymtab_notifier_chain_unregister=0A=
80147c84 g     F .text	00000000 bdput=0A=
801bf34c g     F .text	00000000 tcp_enter_quickack_mode=0A=
80173c90 g     F .text	00000000 ipcperms=0A=
801ff6d8 g     O __ksymtab	00000008 __ksymtab_unlock_buffer=0A=
801fa758 g     O .kstrtab	00000012 __kstrtab_mips_io_port_base=0A=
801ff8f8 g     O __ksymtab	00000008 __ksymtab_lease_get_mtime=0A=
8018e164 g     F .text	00000000 misc_deregister=0A=
80120160 g     F .text	00000000 sys_settimeofday=0A=
80126e8c g     F .text	00000000 sys_rt_sigprocmask=0A=
8013795c g     F .text	00000000 lru_cache_del=0A=
80202af0 g     F .text.init	00000014 except_vec1_generic=0A=
80200460 g     O __ksymtab	00000008 __ksymtab_ip_fragment=0A=
801ff160 g     O __ksymtab	00000008 __ksymtab_csum_partial_copy=0A=
801fb054 g     O .kstrtab	0000000b __kstrtab_lookup_mnt=0A=
801ad068 g     F .text	00000000 dev_init_scheduler=0A=
801a6790 g     F .text	00000000 net_call_rx_atomic=0A=
801ff738 g     O __ksymtab	00000008 __ksymtab_waitfor_one_page=0A=
8011fa28 g     F .text	00000000 it_real_fn=0A=
801a9cc4 g     F .text	00000000 pneigh_delete=0A=
80172838 g     F .text	00000000 autofs4_wait_release=0A=
8013e938 g     F .text	00000000 sys_utime=0A=
80182b38 g     F .text	00000000 ieee754sp_neg=0A=
8015a9b8 g     F .text	00000000 kiobuf_wait_for_io=0A=
801b22c4 g     F .text	00000000 ip_rcv=0A=
801fbb30 g     O .kstrtab	00000010 __kstrtab_register_binfmt=0A=
80316044 g     O .bss	00000004 rows=0A=
801e6fc4 g     F .text	00000000 __down_read=0A=
801de2cc g     F .text	00000000 fib_semantic_match=0A=
8021e8f0 g     O .data	00000000 udp_hash_lock=0A=
801c0544 g     F .text	00000000 tcp_clear_retrans=0A=
8021aac0 g     O .data	00000024 bdflush_min=0A=
80158a5c g     F .text	00000000 clear_inode=0A=
801fc270 g     O .kstrtab	0000000d __kstrtab_is_bad_inode=0A=
801fd3ec g     O .kstrtab	00000009 __kstrtab_dev_base=0A=
801ff550 g     O __ksymtab	00000008 __ksymtab_sys_close=0A=
801ff1c8 g     O __ksymtab	00000008 __ksymtab_enable_irq=0A=
801ff7c8 g     O __ksymtab	00000008 __ksymtab_dput=0A=
8010b0b4 g     F .text	00000000 do_ri=0A=
8013f3e0 g     F .text	00000000 sys_lchown=0A=
801d38b8 g     F .text	00000000 udp_v4_lookup_longway=0A=
801c93d0 g     F .text	00000000 tcp_send_synack=0A=
8021a0b8 g     O .data	00000000 tqueue_lock=0A=
80159eb8 g     F .text	00000000 notify_change=0A=
801a5490 g     F .text	00000000 netdev_boot_setup_add=0A=
8011ac74 g     F .text	00000000 get_exec_domain_list=0A=
80127f10 g     F .text	00000000 notifier_chain_register=0A=
801499c0 g     F .text	00000000 open_exec=0A=
80172db4 g     F .text	00000000 autofs4_expire_run=0A=
8018892c g     F .text	00000000 tty_paranoia_check=0A=
801fff40 g     O __ksymtab	00000008 __ksymtab_set_buffer_flushtime=0A=
801e6254 g     F .text	00000000 vsprintf=0A=
8019f36c g     F .text	00000000 sys_recvfrom=0A=
80178688 g     F .text	00000000 sys_shmdt=0A=
801c74b8 g     F .text	00000000 tcp_send_skb=0A=
801afa2c g     F .text	00000000 ip_route_input_slow=0A=
80202040 g     F .text.init	00000000 name_to_kdev_t=0A=
801ff620 g     O __ksymtab	00000008 __ksymtab_invalidate_inodes=0A=
8021bb60 g     O .data	00000048 ext2_file_operations=0A=
8021a0e0 g     O .data	00000004 max_queued_signals=0A=
80116d80 g     F .text	00000000 local_flush_tlb_page=0A=
801fce1c g     O .kstrtab	0000000c __kstrtab_dst_destroy=0A=
802052d4 g     F .text.init	00000000 add_wired_entry=0A=
80211a80 g     O .data	00000000 _fdata=0A=
80183934 g     F .text	00000000 ieee754sp_tulong=0A=
801ffdd8 g     O __ksymtab	00000008 =
__ksymtab_fsync_inode_data_buffers=0A=
80205b98 g     F .text.init	00000000 init_idle=0A=
802134a0 g     F .data	000000f4 handle_ri=0A=
80200390 g     O __ksymtab	00000008 __ksymtab_dst_destroy=0A=
801fd13c g     O .kstrtab	00000014 __kstrtab_dev_set_promiscuity=0A=
80140d70 g     F .text	00000000 get_empty_filp=0A=
8010ffb4 g     F .text	0000003c pgd_init=0A=
8021326c g     F .data	00000000 handle_ibe_int=0A=
802002f8 g     O __ksymtab	00000008 __ksymtab_neigh_table_clear=0A=
80139dfc g     F .text	00000000 nr_free_buffer_pages=0A=
801ffad0 g     O __ksymtab	00000008 =
__ksymtab_unregister_sysctl_table=0A=
8020fdd8 g     O .data.init	00000004 ic_host_name_set=0A=
801886b4 g     F .text	00000000 tty_unregister_devfs=0A=
801a2fc0 g     F .text	00000000 skb_copy_bits=0A=
801e7b30 g     F .text	00000000 putDebugChar=0A=
801ac25c g     F .text	00000000 eth_rebuild_header=0A=
802051a0 g     F .text.init	00000000 ld_mmu_r4xx0=0A=
802004c8 g     O __ksymtab	00000008 __ksymtab_in_dev_finish_destroy=0A=
801fc314 g     O .kstrtab	00000007 __kstrtab_strsep=0A=
801dbcac g     F .text	00000000 inet_unregister_protosw=0A=
80200488 g     O __ksymtab	00000008 __ksymtab_ip_finish_output=0A=
801fd390 g     O .kstrtab	0000000a __kstrtab_dev_alloc=0A=
801fbca0 g     O .kstrtab	0000000a __kstrtab_del_timer=0A=
801dc08c g     F .text	00000000 ip_mc_dec_group=0A=
80163d3c g     F .text	00000000 proc_pid_read_maps=0A=
801ff6d0 g     O __ksymtab	00000008 __ksymtab_submit_bh=0A=
8016e884 g     F .text	00000000 autofs_hash_nuke=0A=
801fb618 g     O .kstrtab	00000015 __kstrtab_shrink_dcache_parent=0A=
801280f0 g     F .text	00000000 sys_setpriority=0A=
8014054c g     F .text	00000000 sys_writev=0A=
80156334 g     F .text	00000000 lock_may_read=0A=
801ffdc0 g     O __ksymtab	00000008 __ksymtab_sys_tz=0A=
80316050 g     O .bss	00000004 wait_init_idle=0A=
801fbeac g     O .kstrtab	00000010 __kstrtab_ioport_resource=0A=
801bc5fc g     F .text	00000000 tcp_recvmsg=0A=
80138668 g     F .text	00000000 try_to_free_pages=0A=
8014d188 g     F .text	00000000 set_fs_altroot=0A=
80210038 g     O *ABS*	00000000 __setup_end=0A=
8021ac90 g     O .data	00000048 rdwr_fifo_fops=0A=
801fc844 g     O .kstrtab	0000000c __kstrtab_ether_setup=0A=
8020b780 g     F .text.init	00000000 rd_load=0A=
801fba88 g     O .kstrtab	00000011 __kstrtab_tty_check_change=0A=
801ff080 g     O *ABS*	00000000 __start___dbe_table=0A=
801fcd68 g     O .kstrtab	00000016 __kstrtab_neigh_sysctl_register=0A=
80173c18 g     F .text	00000000 ipc_alloc=0A=
801af268 g     F .text	00000000 ip_rt_update_pmtu=0A=
8013ab70 g     F .text	00000000 remove_exclusive_swap_page=0A=
8010f7c0 g     F .text	00000058 r4k_clear_page_r4600_v1=0A=
80167e60 g     F .text	00000000 ext2_bg_has_super=0A=
801fb9a4 g     O .kstrtab	00000005 __kstrtab_bmap=0A=
801a09c8 g     F .text	00000000 sock_wfree=0A=
801fb048 g     O .kstrtab	0000000c __kstrtab_follow_down=0A=
801ff770 g     O __ksymtab	00000008 __ksymtab_page_hash_bits=0A=
80123f94 g     F .text	00000000 ptrace_detach=0A=
8012af40 g     F .text	00000000 __free_pte=0A=
80219210 g     O .data	00000000 lastpid_lock=0A=
80123448 g     F .text	00000000 proc_dointvec_jiffies=0A=
8021aa98 g     O .data	00000004 buffermem_pages=0A=
801b568c g     F .text	00000000 ip_queue_xmit=0A=
80200260 g     O __ksymtab	00000008 __ksymtab_skb_recv_datagram=0A=
801fb1dc g     O .kstrtab	00000009 __kstrtab_put_filp=0A=
801ff2e0 g     O __ksymtab	00000008 __ksymtab_send_sig_info=0A=
801fb928 g     O .kstrtab	00000016 __kstrtab_tty_unregister_driver=0A=
801fb5f4 g     O .kstrtab	0000000d __kstrtab_prune_dcache=0A=
801fb8dc g     O .kstrtab	00000012 __kstrtab_unregister_chrdev=0A=
801839b0 g     F .text	00000000 ieee754sp_flong=0A=
80200560 g     O __ksymtab	00000008 __ksymtab_ip_rcv=0A=
801ffc60 g     O __ksymtab	00000008 __ksymtab_sleep_on=0A=
801fd088 g     O .kstrtab	00000011 __kstrtab_inetdev_by_index=0A=
801fc768 g     O .kstrtab	00000015 __kstrtab_generic_make_request=0A=
801fae48 g     O .kstrtab	00000010 __kstrtab_get_zeroed_page=0A=
80160044 g     F .text	00000000 proc_get_inode=0A=
80129264 g     F .text	00000000 sys_setpgid=0A=
8021cbcc g     O .data	00000004 mount_initrd=0A=
8021e6a8 g     O .data	0000000c sysctl_tcp_wmem=0A=
801fc6ec g     O .kstrtab	00000016 __kstrtab_end_that_request_last=0A=
801fb7e8 g     O .kstrtab	0000000e __kstrtab_block_symlink=0A=
801fb8b4 g     O .kstrtab	0000000a __kstrtab_lock_page=0A=
801fbdd0 g     O .kstrtab	0000000e __kstrtab_unlock_kiovec=0A=
801e72ac g     F .text	00000000 idisx_hw3_irqdispatch=0A=
802005c8 g     O __ksymtab	00000008 __ksymtab_dev_get_by_name=0A=
80156400 g     F .text	00000000 lock_may_write=0A=
80209364 g     F .text.init	00000000 shm_init=0A=
801ff2c8 g     O __ksymtab	00000008 __ksymtab_notify_parent=0A=
80128be0 g     F .text	00000000 sys_setresuid=0A=
801fc3e8 g     O .kstrtab	00000010 __kstrtab_init_task_union=0A=
801dc9d8 g     F .text	00000000 ip_mc_drop_socket=0A=
802136a0 g     F .data	000000f4 handle_ov=0A=
801ff0a0 g     O __ksymtab	00000008 __ksymtab_memcmp=0A=
801ffa50 g     O __ksymtab	00000008 __ksymtab_tty_flip_buffer_push=0A=
801a5f5c g     F .text	00000000 dev_queue_xmit=0A=
80185430 g     F .text	00000000 tty_register_ldisc=0A=
802000b0 g     O __ksymtab	00000008 __ksymtab_del_gendisk=0A=
801e5648 g     F .text	00000000 simple_strtoll=0A=
8019d468 g     F .text	00000000 loop_unregister_transfer=0A=
8014839c g     F .text	00000000 blkdev_get=0A=
802000e0 g     O __ksymtab	00000008 __ksymtab_ether_setup=0A=
8012affc g     F .text	00000000 clear_page_tables=0A=
8013fdec g     F .text	00000000 sys_lseek=0A=
8012aae4 g     F .text	00000000 schedule_task=0A=
801ff420 g     O __ksymtab	00000008 __ksymtab_kmem_cache_shrink=0A=
801ff4b0 g     O __ksymtab	00000008 __ksymtab_get_super=0A=
8014fda0 g     F .text	00000000 vfs_rename=0A=
80207a30 g     F .text.init	00000000 buffer_init=0A=
8016e46c g     F .text	00000000 autofs_initialize_hash=0A=
80200418 g     O __ksymtab	00000008 __ksymtab_ip_route_output_key=0A=
801fa914 g     O .kstrtab	00000012 __kstrtab_invalid_pte_table=0A=
8017fec8 g     F .text	00000000 ieee754dp_funs=0A=
8016876c g     F .text	00000000 ext2_inode_by_name=0A=
801fae34 g     O .kstrtab	00000011 __kstrtab___get_free_pages=0A=
80155394 g     F .text	00000000 fcntl_getlk=0A=
801faa88 g     O .kstrtab	00000016 __kstrtab_abi_defhandler_lcall7=0A=
801fce60 g     O .kstrtab	0000000b __kstrtab___scm_send=0A=
801fba30 g     O .kstrtab	0000000c __kstrtab_init_buffer=0A=
801de99c g     F .text	00000000 fib_node_get_info=0A=
8017a980 g     F .text	00000000 ieee754dp_floor=0A=
801ff990 g     O __ksymtab	00000008 __ksymtab_blksize_size=0A=
802003e0 g     O __ksymtab	00000008 __ksymtab_sklist_insert_socket=0A=
801fb9f8 g     O .kstrtab	0000000e __kstrtab_ioctl_by_bdev=0A=
801fb1e8 g     O .kstrtab	0000000b __kstrtab_files_lock=0A=
80200168 g     O __ksymtab	00000008 __ksymtab_sock_getsockopt=0A=
8016c848 g     F .text	00000000 ext2_put_super=0A=
801fb438 g     O .kstrtab	00000014 __kstrtab_block_truncate_page=0A=
801708f0 g     F .text	00000000 autofs4_free_ino=0A=
80129ed0 g     F .text	00000000 exec_usermodehelper=0A=
8031610c g     O .bss	00000004 save_fp_context=0A=
8014759c g     F .text	00000000 set_blocksize=0A=
8021a2d0 g     O .data	00000004 page_cache_size=0A=
801ff2c0 g     O __ksymtab	00000008 __ksymtab_kill_sl_info=0A=
801fc2a4 g     O .kstrtab	0000000f __kstrtab_fs_overflowgid=0A=
801ff360 g     O __ksymtab	00000008 =
__ksymtab_inter_module_unregister=0A=
801fc9dc g     O .kstrtab	0000000d __kstrtab_sock_no_bind=0A=
80130f18 g     F .text	00000000 generic_file_read=0A=
8010f3a8 g     F .text	00000000 do_page_fault=0A=
8031ec98 g     O .bss	00000008 inactive_list=0A=
8013c5a4 g     F .text	00000000 get_swaphandle_info=0A=
8021a0a0 g     O .data	00000004 time_constant=0A=
8014d500 g     F .text	00000000 lookup_one_len=0A=
80118dd0 g     F .text	00000000 render_sigset_t=0A=
802053ec g     F .text.init	00000000 add_temporary_entry=0A=
80169bfc g     F .text	00000000 ext2_delete_inode=0A=
801a4f54 g     F .text	00000000 scm_detach_fds=0A=
8014d20c g     F .text	00000000 path_init=0A=
801ffed8 g     O __ksymtab	00000008 __ksymtab_do_softirq=0A=
80127f68 g     F .text	00000000 notifier_chain_unregister=0A=
80200468 g     O __ksymtab	00000008 __ksymtab_inet_family_ops=0A=
801e3820 g     F .text	00000520 csum_partial=0A=
801a0a74 g     F .text	00000000 sock_wmalloc=0A=
80129dbc g     F .text	00000000 sys_umask=0A=
801d2370 g     F .text	00000000 __raw_v4_lookup=0A=
801fcdb0 g     O .kstrtab	00000012 __kstrtab_neigh_parms_alloc=0A=
8021e820 g     O .data	00000004 tcp_tw_count=0A=
80218f64 g     O .data	00000004 EISA_bus=0A=
801fb524 g     O .kstrtab	00000010 __kstrtab_locks_init_lock=0A=
801fce28 g     O .kstrtab	0000000e __kstrtab_net_ratelimit=0A=
802004e0 g     O __ksymtab	00000008 __ksymtab_devinet_ioctl=0A=
801ffcd0 g     O __ksymtab	00000008 __ksymtab_sprintf=0A=
801e45e0 g     F .text	00000020 memmove=0A=
8018e5b0 g     F .text	00000000 batch_entropy_store=0A=
801fa9d8 g     O .kstrtab	00000008 __kstrtab_iounmap=0A=
801b54b8 g     F .text	00000000 ip_output=0A=
8013c9d0 g     F .text	00000000 oom_kill_task=0A=
8021e714 g     O .data	00000004 sysctl_tcp_synack_retries=0A=
801a7974 g     F .text	00000000 dev_ioctl=0A=
80140860 g     F .text	00000000 get_device_list=0A=
801ffd90 g     O __ksymtab	00000008 __ksymtab_copy_strings_kernel=0A=
801ffc18 g     O __ksymtab	00000008 __ksymtab___request_region=0A=
8010f740 g     F .text	00000044 r4k_clear_page_d16=0A=
8010af14 g     F .text	00000000 do_bp=0A=
8015d7fc g     F .text	00000000 seq_release=0A=
801ff498 g     O __ksymtab	00000008 __ksymtab_def_blk_fops=0A=
801fabb0 g     O .kstrtab	00000008 __kstrtab_kill_sl=0A=
801fff00 g     O __ksymtab	00000008 __ksymtab_init_task_union=0A=
801a52b0 g     F .text	00000000 dev_add_pack=0A=
8021bf88 g     O .data	00000048 autofs4_dir_operations=0A=
801ffbc8 g     O __ksymtab	00000008 __ksymtab_unlock_kiovec=0A=
80147b3c g     F .text	00000000 bdget=0A=
801e6230 g     F .text	00000000 snprintf=0A=
8016e4a4 g     F .text	00000000 autofs_hash_lookup=0A=
80200548 g     O __ksymtab	00000008 __ksymtab_dev_open=0A=
802191a4 g     O .data	00000004 init_tasks=0A=
80117f24 g     F .text	00000000 complete=0A=
801ff628 g     O __ksymtab	00000008 __ksymtab_invalidate_device=0A=
802000c0 g     O __ksymtab	00000008 __ksymtab_loop_register_transfer=0A=
801ff758 g     O __ksymtab	00000008 __ksymtab_generic_file_mmap=0A=
803164b4 g     O .bss	00000004 _flush_cache_range=0A=
80200050 g     O __ksymtab	00000008 __ksymtab_end_that_request_last=0A=
80171000 g     F .text	00000000 autofs4_get_inode=0A=
803209e0 g     O .bss	00000004 root_vfsmnt=0A=
801fb0a4 g     O .kstrtab	0000000c __kstrtab_lookup_hash=0A=
801ff6a0 g     O __ksymtab	00000008 __ksymtab_bdget=0A=
801dcbc0 g     F .text	00000000 fib_flush=0A=
8031d3a0 g     O .bss	00000280 bh_task_vec=0A=
802003f0 g     O __ksymtab	00000008 __ksymtab_inetdev_lock=0A=
801fc610 g     O .kstrtab	00000018 __kstrtab_add_keyboard_randomness=0A=
8011bf78 g     F .text	00000000 unregister_console=0A=
8017b124 g     F .text	00000000 ieee754dp_issnan=0A=
8020c0d4 g     F .text.init	00000000 sk_init=0A=
801fb18c g     O .kstrtab	00000013 __kstrtab___mark_inode_dirty=0A=
803340b0 g     O .bss	00000004 initrd_below_start_ok=0A=
80335628 g     O .bss	00000004 inet_dev_count=0A=
80132edc g     F .text	00000000 generic_file_write=0A=
8012574c g     F .text	00000000 sys_getuid=0A=
801fb1c4 g     O .kstrtab	0000000a __kstrtab_filp_open=0A=
801ff180 g     O __ksymtab	00000008 __ksymtab___down=0A=
801fb1a0 g     O .kstrtab	0000000f __kstrtab_get_empty_filp=0A=
80207064 g     F .text.init	00000000 init_bootmem_node=0A=
8010981c g     F .text	00000000 sys_rt_sigreturn=0A=
8012afd4 g     F .text	00000000 check_pgt_cache=0A=
8011fe80 g     F .text	00000000 sys_time=0A=
801ffda0 g     O __ksymtab	00000008 __ksymtab_flush_old_exec=0A=
801a1064 g     F .text	00000000 sklist_remove_socket=0A=
801c82bc g     F .text	00000000 __tcp_select_window=0A=
8018cfdc g     F .text	00000000 raw_write=0A=
8010c144 g     F .text	00000024 sys_fork=0A=
80118898 g     F .text	00000000 sys_sched_getparam=0A=
802002a0 g     O __ksymtab	00000008 __ksymtab_skb_copy_expand=0A=
80213a8c g     F .data	00000000 handle_watch_int=0A=
801e546c g     F .text	00000000 simple_strtol=0A=
801ffd60 g     O __ksymtab	00000008 __ksymtab_securebits=0A=
8015a370 g     F .text	00000000 free_fdset=0A=
8031ec70 g     O .bss	00000004 page_cluster=0A=
80140c98 g     F .text	00000000 init_special_inode=0A=
8018c374 g     F .text	00000000 send_prio_char=0A=
8020f46c g     F .text.init	00000000 prom_meminit=0A=
801fbbd8 g     O .kstrtab	0000000e __kstrtab_sysctl_string=0A=
801fc2dc g     O .kstrtab	00000011 __kstrtab_get_write_access=0A=
801faf14 g     O .kstrtab	00000008 __kstrtab_kmalloc=0A=
8020c058 g     F .text.init	00000000 sock_init=0A=
801b1414 g     F .text	00000000 inet_getpeer=0A=
8031d724 g     O .bss	00000004 time_offset=0A=
801fc944 g     O .kstrtab	00000010 __kstrtab_sock_setsockopt=0A=
80200668 g     O __ksymtab	00000008 __ksymtab_dev_base_lock=0A=
801ff5a0 g     O __ksymtab	00000008 __ksymtab_d_alloc=0A=
80145c44 g     F .text	00000000 unregister_filesystem=0A=
80207194 g     F .text.init	00000000 __alloc_bootmem=0A=
801fae88 g     O .kstrtab	0000000e __kstrtab_num_physpages=0A=
8021db64 g     O .data	00000004 netdev_nit=0A=
8021e9e0 g     O .data	00000020 arp_broken_ops=0A=
8017ff50 g     F .text	00000000 ieee754dp_tlong=0A=
80169be0 g     F .text	00000000 ext2_put_inode=0A=
801ffb70 g     O __ksymtab	00000008 __ksymtab_probe_irq_on=0A=
80200210 g     O __ksymtab	00000008 __ksymtab_sock_no_recvmsg=0A=
8017ae44 g     F .text	00000000 ieee754sp_dump=0A=
8014e3c4 g     F .text	00000000 sys_mkdir=0A=
801dde6c g     F .text	00000000 fib_create_info=0A=
80148134 g     F .text	00000000 ioctl_by_bdev=0A=
80203dac g     F .text.init	00000000 setup_arch=0A=
8021e660 g     O .data	00000004 sysctl_ipfrag_high_thresh=0A=
8019da28 g     F .text	00000000 unregister_netdev=0A=
801ffd88 g     O __ksymtab	00000008 __ksymtab_setup_arg_pages=0A=
8020f338 g     F .text.init	00000000 prom_getmdesc=0A=
801ab030 g     F .text	00000000 neigh_compat_output=0A=
8019ecec g     F .text	00000000 sys_socket=0A=
801fce84 g     O .kstrtab	0000000f __kstrtab_memcpy_toiovec=0A=
8018848c g     F .text	00000000 tty_flip_buffer_push=0A=
80118a48 g     F .text	00000000 sys_sched_get_priority_min=0A=
801ad0f4 g     F .text	00000000 dev_shutdown=0A=
801cb8d0 g     F .text	00000000 tcp_reset_keepalive_timer=0A=
801ffca8 g     O __ksymtab	00000008 __ksymtab_do_settimeofday=0A=
80321150 g     O .bss	00000400 ldiscs=0A=
801a0b14 g     F .text	00000000 sock_rmalloc=0A=
801fbcac g     O .kstrtab	0000000c __kstrtab_request_irq=0A=
8020d2b4 g     F .text.init	00000000 ip_fib_init=0A=
801fd0cc g     O .kstrtab	0000000e __kstrtab_devinet_ioctl=0A=
801fa8a8 g     O .kstrtab	0000001b =
__kstrtab___strnlen_user_nocheck_asm=0A=
80142b7c g     F .text	00000000 mark_buffer_dirty=0A=
80123a78 g     F .text	00000000 sys_capset=0A=
80149194 g     F .text	00000000 sys_lstat64=0A=
8015a1c4 g     F .text	00000000 expand_fd_array=0A=
80176634 g     F .text	00000000 semctl_down=0A=
80202b04 g     F .text.init	00000020 except_vec3_generic=0A=
801cd720 g     F .text	00000000 tcp_v4_send_check=0A=
8014922c g     F .text	00000000 sys_fstat64=0A=
80200450 g     O __ksymtab	00000008 __ksymtab___ip_select_ident=0A=
801fa76c g     O .kstrtab	00000010 __kstrtab_isa_slot_offset=0A=
80174f8c g     F .text	00000000 sys_msgrcv=0A=
801fd4d8 g     O .kstrtab	0000000b __kstrtab_noop_qdisc=0A=
80316120 g     O .bss	00000004 _machine_restart=0A=
8011a03c g     F .text	00000000 do_fork=0A=
8021a0f0 g     O .data	00000004 overflowuid=0A=
801fb364 g     O .kstrtab	0000000a __kstrtab_submit_bh=0A=
801d52e0 g     F .text	00000000 udp_v4_lookup=0A=
801facf0 g     O .kstrtab	0000000f __kstrtab_request_module=0A=
8010e8b4 g     F .text	00000000 init_irq_proc=0A=
801d2838 g     F .text	00000000 raw_rcv=0A=
801fcbc4 g     O .kstrtab	0000000e __kstrtab_skb_copy_bits=0A=
801fac48 g     O .kstrtab	0000001a =
__kstrtab_notifier_chain_unregister=0A=
80200130 g     O __ksymtab	00000008 __ksymtab___release_sock=0A=
801fb4f4 g     O .kstrtab	0000000f __kstrtab_page_hash_bits=0A=
802006d0 g     O __ksymtab	00000008 __ksymtab_qdisc_create_dflt=0A=
801fb208 g     O .kstrtab	00000015 __kstrtab___invalidate_buffers=0A=
80108c5c g     F .text	00000000 kernel_thread=0A=
801d3380 g     F .text	00000000 raw_get_info=0A=
801ff1b8 g     O __ksymtab	00000008 __ksymtab_disable_irq_nosync=0A=
801fff60 g     O __ksymtab	00000008 __ksymtab_create_empty_buffers=0A=
801fc194 g     O .kstrtab	00000014 __kstrtab_fsync_inode_buffers=0A=
801fadc0 g     O .kstrtab	0000000a __kstrtab_do_munmap=0A=
8016dd8c g     F .text	00000000 ext2_write_super=0A=
801455bc g     F .text	00000000 block_sync_page=0A=
8010d300 g     F .text	00000000 no_action=0A=
801a1348 g     F .text	00000000 sock_no_release=0A=
801fb860 g     O .kstrtab	0000000c __kstrtab_dentry_open=0A=
801ff7d0 g     O __ksymtab	00000008 __ksymtab_have_submounts=0A=
80200420 g     O __ksymtab	00000008 __ksymtab_ip_route_input=0A=
801984c4 g     F .text	00000000 get_partition_list=0A=
801fb684 g     O .kstrtab	0000000c __kstrtab_vfs_symlink=0A=
801ff2d8 g     O __ksymtab	00000008 __ksymtab_send_sig=0A=
80157a70 g     F .text	00000000 is_subdir=0A=
8019fa74 g     F .text	00000000 sys_socketcall=0A=
80127290 g     F .text	00000000 sys_rt_sigpending=0A=
80182070 g     F .text	00000000 ieee754sp_fdp=0A=
80219480 g     O .data	00000008 log_wait=0A=
801a3a08 g     F .text	00000000 memcpy_tokerneliovec=0A=
80124ac8 g     F .text	00000000 tqueue_bh=0A=
80116b90 g     F .text	00000000 local_flush_tlb_range=0A=
80206734 g     F .text.init	00000000 kmem_cpucache_init=0A=
801ff0f0 g     O __ksymtab	00000008 __ksymtab_strnlen=0A=
801ffe00 g     O __ksymtab	00000008 __ksymtab_get_hash_table=0A=
8020f758 g     F .text.init	00000000 idisx_set_aside_tlb=0A=
801ac580 g     F .text	00000000 qdisc_restart=0A=
80335dc0 g     O .bss	00000004 errno=0A=
80151578 g     F .text	00000000 kill_fasync=0A=
801ff2e8 g     O __ksymtab	00000008 __ksymtab_block_all_signals=0A=
801bd088 g     F .text	00000000 tcp_shutdown=0A=
80220564 g     O .data	0000000c idisx_rtc_ops=0A=
80200230 g     O __ksymtab	00000008 __ksymtab_sock_wfree=0A=
80334ce0 g     O .bss	00000004 tcp_openreq_cachep=0A=
801557f8 g     F .text	00000000 fcntl_getlk64=0A=
80200740 g     O *ABS*	00000000 _etext=0A=
801ff748 g     O __ksymtab	00000008 __ksymtab_do_generic_file_read=0A=
8021e604 g     O .data	00000004 inet_peer_gc_maxtime=0A=
00000000  w      *UND*	00000000 __stop___kallsyms=0A=
801fd09c g     O .kstrtab	00000016 __kstrtab_in_dev_finish_destroy=0A=
801fd004 g     O .kstrtab	00000010 __kstrtab_ip_mc_dec_group=0A=
801959cc g     F .text	00000000 register_serial=0A=
80148cf4 g     F .text	00000000 sys_newlstat=0A=
802004f0 g     O __ksymtab	00000008 =
__ksymtab_unregister_inetaddr_notifier=0A=
801dcaa4 g     F .text	00000000 ip_check_mc=0A=
80141e8c g     F .text	00000000 get_hash_table=0A=
801e4d6c g     F .text	00000000 dump_list_current=0A=
801fb118 g     O .kstrtab	00000007 __kstrtab_d_move=0A=
80142cec g     F .text	00000000 __bforget=0A=
801d5330 g     F .text	00000000 arp_mc_map=0A=
801fb804 g     O .kstrtab	0000000c __kstrtab___get_lease=0A=
8011c358 g     F .text	00000000 inter_module_get_request=0A=
801fc100 g     O .kstrtab	0000000a __kstrtab_daemonize=0A=
801b4984 g     F .text	00000000 ip_options_get=0A=
80200410 g     O __ksymtab	00000008 =
__ksymtab_inet_unregister_protosw=0A=
801ff9b0 g     O __ksymtab	00000008 __ksymtab_is_read_only=0A=
8017c410 g     F .text	00000000 ieee754_xcpt=0A=
8013494c g     F .text	00000000 sys_munlockall=0A=
80139e4c g     F .text	00000000 show_free_areas_core=0A=
8021aee4 g     O .data	00000004 lease_break_time=0A=
8014ab08 g     F .text	00000000 do_coredump=0A=
801fd544 g     O .kstrtab	0000000c __kstrtab_get_options=0A=
80200310 g     O __ksymtab	00000008 __ksymtab_neigh_update=0A=
801fd440 g     O .kstrtab	0000000e __kstrtab___kill_fasync=0A=
80200100 g     O __ksymtab	00000008 __ksymtab_autoirq_report=0A=
801ffd78 g     O __ksymtab	00000008 __ksymtab_daemonize=0A=
8010c1a4 g     F .text	00000024 sys_clone=0A=
801fa97c g     O .kstrtab	00000012 __kstrtab_reset_mqb_handler=0A=
8012ed30 g     F .text	00000000 invalidate_inode_pages=0A=
80316060 g     O .bss	00000004 Version_132112=0A=
801e7e00 g     F .text	000001b8 idisxIRQ=0A=
801fb328 g     O .kstrtab	00000006 __kstrtab_bdget=0A=
80318a68 g     O .bss	00000004 total_forks=0A=
80219000 g     O .data	00000004 cpuoptions=0A=
8021e6f4 g     O .data	00000004 sysctl_tcp_stdurg=0A=
8021e6d0 g     O .data	00000004 sysctl_tcp_timestamps=0A=
801fbf2c g     O .kstrtab	00000017 __kstrtab_interruptible_sleep_on=0A=
801ff2f0 g     O __ksymtab	00000008 __ksymtab_unblock_all_signals=0A=
8012aa14 g     F .text	00000000 dev_probe_unlock=0A=
801fbfcc g     O .kstrtab	0000000b __kstrtab_nr_running=0A=
80200550 g     O __ksymtab	00000008 __ksymtab_in_ntoa=0A=
8021c7e8 g     O .data	00000134 random_table=0A=
8017fc84 g     F .text	00000000 ieee754dp_tuns=0A=
8031e000 g     O *ABS*	00000000 _gp=0A=
801441c8 g     F .text	00000000 block_truncate_page=0A=
801410f0 g     F .text	00000000 fget=0A=
80197cdc g     F .text	00000000 del_partition=0A=
801fc09c g     O .kstrtab	00000007 __kstrtab__ctype=0A=
80102000 g     O .text	00000000 empty_bad_page=0A=
801fba74 g     O .kstrtab	00000014 __kstrtab_tty_wait_until_sent=0A=
8021b718 g     O .data	00000000 proc_alloc_map_lock=0A=
801fcb4c g     O .kstrtab	00000012 __kstrtab_skb_recv_datagram=0A=
8021f304 g     O .data	000008c4 ipv4_table=0A=
801b20b0 g     F .text	00000000 ip_local_deliver=0A=
803208b4 g     O .bss	00000004 filp_cachep=0A=
80151f18 g     F .text	00000000 sys_getdents=0A=
801fc640 g     O .kstrtab	00000019 =
__kstrtab_add_interrupt_randomness=0A=
801ff138 g     O __ksymtab	00000008 =
__ksymtab___strncpy_from_user_asm=0A=
8020f544 g     F .text.init	00000000 setup_prom_printf=0A=
801ffbe0 g     O __ksymtab	00000008 __ksymtab_request_dma=0A=
802002b8 g     O __ksymtab	00000008 __ksymtab_pskb_expand_head=0A=
80180414 g     F .text	00000000 ieee754dp_tulong=0A=
801fb3fc g     O .kstrtab	00000010 __kstrtab_block_sync_page=0A=
801193d4 g     F .text	00000000 add_wait_queue_exclusive=0A=
801fb6f4 g     O .kstrtab	0000000a __kstrtab_no_llseek=0A=
801e47f0 g     O .text	00000000 __strlen_user_nocheck_asm=0A=
801fc30c g     O .kstrtab	00000007 __kstrtab_strspn=0A=
80118374 g     F .text	00000000 sleep_on=0A=
801fbdec g     O .kstrtab	00000013 __kstrtab_kiobuf_wait_for_io=0A=
801e62a0 g     F .text	00000000 vsscanf=0A=
801b96e0 g     F .text	00000000 tcp_listen_start=0A=
801fab60 g     O .kstrtab	0000000a __kstrtab_force_sig=0A=
801ff290 g     O __ksymtab	00000008 __ksymtab_force_sig_info=0A=
801ffa00 g     O __ksymtab	00000008 __ksymtab_register_disk=0A=
801ffa40 g     O __ksymtab	00000008 __ksymtab_tty_check_change=0A=
8021009c g     O *ABS*	00000000 __initcall_end=0A=
8019eb84 g     F .text	00000000 sock_create=0A=
801ff928 g     O __ksymtab	00000008 __ksymtab_filemap_nopage=0A=
8011ab4c g     F .text	00000000 __set_personality=0A=
80140b00 g     F .text	00000000 unregister_chrdev=0A=
80128834 g     F .text	00000000 sys_setreuid=0A=
801ff2d0 g     O __ksymtab	00000008 __ksymtab_recalc_sigpending=0A=
801fd2ec g     O .kstrtab	00000019 =
__kstrtab_netdev_finish_unregister=0A=
8012c644 g     F .text	00000000 vmtruncate=0A=
80117000 g     F .text	00000180 handle_tlbl=0A=
8021db70 g     O .data	00000004 no_cong=0A=
80175814 g     F .text	00000000 sys_semget=0A=
801fc2f0 g     O .kstrtab	0000000e __kstrtab_get_fast_time=0A=
8010bb78 g     F .text	00000000 syscall_trace=0A=
801bd3a0 g     F .text	00000000 tcp_close=0A=
801fb294 g     O .kstrtab	0000000f __kstrtab_fsync_no_super=0A=
801685a0 g     F .text	00000000 ext2_find_entry=0A=
801e4820 g     O .text	00000000 __strncpy_from_user_nocheck_asm=0A=
8013b4f4 g     F .text	00000000 sys_swapoff=0A=
8010f300 g     F .text	00000000 iounmap=0A=
80207cfc g     F .text.init	00000000 mount_root=0A=
80118440 g     F .text	00000000 sleep_on_timeout=0A=
803163f0 g     O .bss	00000004 irq_err_count=0A=
8010e314 g     F .text	00000000 i8259A_irq_pending=0A=
801a3a9c g     F .text	00000000 memcpy_fromiovec=0A=
80200720 g     O __ksymtab	00000008 __ksymtab___down_read=0A=
801d210c g     F .text	00000000 tcp_child_process=0A=
8014936c g     F .text	00000000 sys_uselib=0A=
801e4a58 g     F .text	00000000 dump_tlb_wired=0A=
80200218 g     O __ksymtab	00000008 __ksymtab_sock_no_mmap=0A=
8013eb4c g     F .text	00000000 sys_access=0A=
801b73b0 g     F .text	00000000 ip_cmsg_send=0A=
80157a98 g     F .text	00000000 d_genocide=0A=
80316400 g     O .bss	00000004 vced_count=0A=
801fa7e0 g     O .kstrtab	00000008 __kstrtab_strpbrk=0A=
8021e20c g     O .data	00000004 ip_rt_gc_interval=0A=
80200248 g     O __ksymtab	00000008 __ksymtab_skb_linearize=0A=
80208f20 g     F .text.init	00000000 proc_misc_init=0A=
801fceac g     O .kstrtab	00000015 __kstrtab_sklist_insert_socket=0A=
801fb330 g     O .kstrtab	00000006 __kstrtab_bdput=0A=
80108afc g     F .text	00000000 dump_fpu=0A=
801ffe60 g     O __ksymtab	00000008 __ksymtab_kill_fasync=0A=
8021e860 g     O .data	00000084 raw_prot=0A=
801fa7f8 g     O .kstrtab	00000008 __kstrtab_strrchr=0A=
8021c1f0 g     O .data	00000010 sem_ctls=0A=
801e7308 g     F .text	00000000 idisx_timer_interrupt=0A=
8012e810 g     F .text	00000000 exit_mmap=0A=
801ffc58 g     O __ksymtab	00000008 __ksymtab_wake_up_process=0A=
80161f50 g     F .text	00000000 proc_pid_readdir=0A=
80334cc0 g     O .bss	00000004 tcp_bucket_cachep=0A=
801fffd8 g     O __ksymtab	00000008 __ksymtab_tty_register_devfs=0A=
8017bb00 g     F .text	00000000 ieee754sp_class=0A=
801a1420 g     F .text	00000000 sock_no_sendmsg=0A=
801d0ac0 g     F .text	00000000 tcp_timewait_kill=0A=
80200280 g     O __ksymtab	00000008 =
__ksymtab_skb_copy_and_csum_datagram_iovec=0A=
8020fdf0 g     O .data.init	00000100 root_server_path=0A=
801fd39c g     O .kstrtab	0000000f __kstrtab_dev_alloc_name=0A=
801ff240 g     O __ksymtab	00000008 __ksymtab_abi_fake_utsname=0A=
801ff428 g     O __ksymtab	00000008 __ksymtab_kmem_cache_alloc=0A=
802195c0 g     O .data	00000048 proc_sys_file_operations=0A=
801fbf0c g     O .kstrtab	00000009 __kstrtab_sleep_on=0A=
801182a0 g     F .text	00000000 interruptible_sleep_on_timeout=0A=
8016e1a0 g     F .text	00000000 autofs_expire=0A=
8021b0ac g     O .data	00000010 mounts_op=0A=
801fd1f8 g     O .kstrtab	00000009 __kstrtab_arp_find=0A=
803209f4 g     O .bss	00000004 nr_free_dquots=0A=
8013ffa8 g     F .text	00000000 sys_read=0A=
801002b8 g     F .text	000001b4 ejtag_debug_handler=0A=
801ff0b0 g     O __ksymtab	00000008 __ksymtab_memcpy=0A=
80331c90 g     O .bss	000003fc max_sectors=0A=
8020fdec g     O .data.init	00000004 root_server_addr=0A=
801b4270 g     F .text	00000000 ip_options_compile=0A=
801269b0 g     F .text	00000000 kill_pg_info=0A=
801ffbc0 g     O __ksymtab	00000008 __ksymtab_lock_kiovec=0A=
801a9384 g     F .text	00000000 neigh_ifdown=0A=
8021e718 g     O .data	00000004 sysctl_tcp_keepalive_time=0A=
802081f4 g     F .text.init	00000000 bdev_cache_init=0A=
8016b8f4 g     F .text	00000000 ext2_write_inode=0A=
801720e0 g     F .text	00000000 autofs4_catatonic_mode=0A=
80126744 g     F .text	00000000 send_sig_info=0A=
8019fcb8 g     F .text	00000000 sock_unregister=0A=
8021bcc0 g     O .data	00000040 ext2_fast_symlink_inode_operations=0A=
801fa960 g     O .kstrtab	0000000a __kstrtab_get_wchan=0A=
801b1be0 g     F .text	00000000 netstat_get_info=0A=
801ff5f8 g     O __ksymtab	00000008 __ksymtab_put_filp=0A=
801fc6b0 g     O .kstrtab	00000012 __kstrtab_unregister_serial=0A=
801fbc08 g     O .kstrtab	0000000e __kstrtab_proc_dostring=0A=
801ac414 g     F .text	00000000 eth_header_cache=0A=
801fb5d4 g     O .kstrtab	0000000d __kstrtab_d_find_alias=0A=
801fb87c g     O .kstrtab	0000000d __kstrtab_filemap_sync=0A=
8015ac54 g     F .text	00000000 __inode_dir_notify=0A=
8010fa54 g     F .text	000000a0 r4k_copy_page_d32=0A=
801a587c g     F .text	00000000 dev_alloc_name=0A=
80135a14 g     F .text	00000000 vmalloc_area_pages=0A=
801a2a08 g     F .text	00000000 ___pskb_trim=0A=
801be4c8 g     F .text	00000000 tcp_setsockopt=0A=
801fbe74 g     O .kstrtab	00000011 __kstrtab___request_region=0A=
8015c6f4 g     F .text	00000000 sys_mount=0A=
8019ef2c g     F .text	00000000 sys_listen=0A=
8012a500 g     F .text	00000000 request_module=0A=
8021a280 g     O .data	00000008 pgt_cache_water=0A=
80184850 g     F .text	00000000 fpu_emulator_save_context=0A=
801857d0 g     F .text	00000000 tty_check_change=0A=
801fbc18 g     O .kstrtab	0000000e __kstrtab_proc_dointvec=0A=
801faf2c g     O .kstrtab	0000000a __kstrtab___vmalloc=0A=
801fc8e0 g     O .kstrtab	0000000f __kstrtab___release_sock=0A=
8014c088 g     F .text	00000000 permission=0A=
8010d138 g     F .text	000000bc lazy_fpu_switch=0A=
801fd368 g     O .kstrtab	0000000d __kstrtab_dev_add_pack=0A=
801ffa58 g     O __ksymtab	00000008 __ksymtab_tty_get_baud_rate=0A=
801e3ea0 g     F .text	0000073c memcpy=0A=
801fbb8c g     O .kstrtab	00000010 __kstrtab_remove_arg_zero=0A=
80126e70 g     F .text	00000000 notify_parent=0A=
801ff148 g     O __ksymtab	00000008 __ksymtab___strlen_user_asm=0A=
8010e3e4 g     F .text	00000000 mask_and_ack_8259A=0A=
8019fce0 g     F .text	00000000 socket_get_info=0A=
80211820 g     O .data.cacheline_aligned	00000020 tasklet_vec=0A=
80126cfc g     F .text	00000000 kill_proc=0A=
80167314 g     F .text	00000000 ext2_new_block=0A=
8013a2fc g     F .text	00000000 delete_from_swap_cache=0A=
801fc12c g     O .kstrtab	00000014 __kstrtab_copy_strings_kernel=0A=
801187c4 g     F .text	00000000 sys_sched_setscheduler=0A=
801fb220 g     O .kstrtab	00000010 __kstrtab_invalidate_bdev=0A=
80335dd0 g     O .bss	00000004 ___strtok=0A=
801ff098 g     O __ksymtab	00000008 __ksymtab_EISA_bus=0A=
801bf9d8 g     F .text	00000000 tcp_update_metrics=0A=
801fa8c4 g     O .kstrtab	00000013 __kstrtab___strnlen_user_asm=0A=
801ffad8 g     O __ksymtab	00000008 __ksymtab_sysctl_string=0A=
8010f818 g     F .text	00000084 r4k_clear_page_r4600_v2=0A=
8014c3b4 g     F .text	00000000 follow_up=0A=
801ff798 g     O __ksymtab	00000008 __ksymtab_posix_lock_file=0A=
8015ae34 g     F .text	00000000 set_devname=0A=
801fac94 g     O .kstrtab	0000001b =
__kstrtab_unregister_reboot_notifier=0A=
8021d8a8 g     O .data	00000004 sysctl_wmem_default=0A=
80145524 g     F .text	00000000 wakeup_bdflush=0A=
80320a1c g     O .bss	00000004 proc_root_driver=0A=
8015943c g     F .text	00000000 iunique=0A=
80131a54 g     F .text	00000000 filemap_sync=0A=
801ff800 g     O __ksymtab	00000008 __ksymtab_find_inode_number=0A=
80205a84 g     F .text.init	00000058 except_vec0_nevada=0A=
80136e74 g     F .text	00000000 kfree=0A=
801d425c g     F .text	00000000 udp_ioctl=0A=
8014aa90 g     F .text	00000000 set_binfmt=0A=
802132a0 g     F .data	000000f4 handle_dbe=0A=
801417b0 g     F .text	00000000 sync_buffers=0A=
801d6a44 g     F .text	00000000 arp_ioctl=0A=
801ff8d0 g     O __ksymtab	00000008 __ksymtab_page_follow_link=0A=
801ff728 g     O __ksymtab	00000008 __ksymtab_block_truncate_page=0A=
801ffe40 g     O __ksymtab	00000008 __ksymtab_brw_page=0A=
80316324 g     O .bss	00000001 aux_device_present=0A=
801e7b7c g     F .text	00000000 rs_putDebugChar=0A=
801dbb74 g     F .text	00000000 inet_register_protosw=0A=
8020ad84 g     F .text.init	00000000 rd_init=0A=
801ff308 g     O __ksymtab	00000008 __ksymtab_notifier_call_chain=0A=
801faa34 g     O .kstrtab	00000017 __kstrtab_unregister_exec_domain=0A=
80154628 g     F .text	00000000 posix_lock_file=0A=
80132d00 g     F .text	00000000 read_cache_page=0A=
801a344c g     F .text	00000000 skb_copy_and_csum_bits=0A=
801fbba8 g     O .kstrtab	00000016 __kstrtab_register_sysctl_table=0A=
801a72a8 g     F .text	00000000 dev_set_promiscuity=0A=
80213bc0 g     F .data	000000f4 handle_reserved=0A=
801ff7b8 g     O __ksymtab	00000008 __ksymtab_posix_locks_deadlock=0A=
8012ec50 g     F .text	00000000 remove_inode_page=0A=
801356e4 g     F .text	00000000 __vmalloc=0A=
801ff090 g     O __ksymtab	00000008 __ksymtab_mips_machtype=0A=
8013a0d8 g     F .text	00000000 add_to_swap_cache=0A=
801ff4b8 g     O __ksymtab	00000008 __ksymtab_drop_super=0A=
801a7eac g     F .text	00000000 netdev_finish_unregister=0A=
8010daa8 g     F .text	00000000 probe_irq_on=0A=
801d4838 g     F .text	00000000 udp_disconnect=0A=
801fb578 g     O .kstrtab	00000013 __kstrtab_posix_unblock_lock=0A=
8010d698 g     F .text	00000000 enable_irq=0A=
801a5760 g     F .text	00000000 dev_getbyhwaddr=0A=
8012cec0 g     F .text	00000000 __pmd_alloc=0A=
8011c038 g     F .text	00000000 tty_write_message=0A=
801ff948 g     O __ksymtab	00000008 __ksymtab_lock_page=0A=
8021386c g     F .data	00000000 handle_tr_int=0A=
801597b0 g     F .text	00000000 iput=0A=
80321550 g     O .bss	00000004 tty_drivers=0A=
801ffcb8 g     O __ksymtab	00000008 __ksymtab_kstat=0A=
801fcb88 g     O .kstrtab	00000018 __kstrtab_skb_copy_datagram_iovec=0A=
80200140 g     O __ksymtab	00000008 __ksymtab_memcpy_tokerneliovec=0A=
8021ec58 g     O .data	00000004 icmp_socket=0A=
802001f8 g     O __ksymtab	00000008 __ksymtab_sock_no_getsockopt=0A=
801d8fec g     F .text	00000000 inet_ifa_byprefix=0A=
80108eb8 g     F .text	00000024 sys_sigsuspend=0A=
801fb984 g     O .kstrtab	0000000d __kstrtab_is_read_only=0A=
8012f5c0 g     F .text	00000000 generic_buffer_fdatasync=0A=
8021d8ac g     O .data	00000004 sysctl_rmem_default=0A=
80200240 g     O __ksymtab	00000008 __ksymtab_sock_rmalloc=0A=
80212da4 g     O .data	00000004 loops_per_jiffy=0A=
801fff50 g     O __ksymtab	00000008 __ksymtab_get_unused_buffer_head=0A=
8016b910 g     F .text	00000000 ext2_sync_inode=0A=
8010abf4 g     F .text	00000000 __declare_dbe_table=0A=
801fa798 g     O .kstrtab	00000007 __kstrtab_memcmp=0A=
80200110 g     O __ksymtab	00000008 __ksymtab_skb_under_panic=0A=
801e3700 g     F .text	00000000 unix_sysctl_register=0A=
80182cfc g     F .text	00000000 ieee754sp_abs=0A=
801ff968 g     O __ksymtab	00000008 __ksymtab_register_blkdev=0A=
80316378 g     O .bss	00000050 saved_command_line=0A=
80158e5c g     F .text	00000000 prune_icache=0A=
8021ff70 g     O .data	0000000c no_rtc_ops=0A=
8021e21c g     O .data	00000004 ip_rt_redirect_silence=0A=
801ff9b8 g     O __ksymtab	00000008 __ksymtab_set_device_ro=0A=
8015d654 g     F .text	00000000 seq_lseek=0A=
801c8be0 g     F .text	00000000 tcp_xmit_retransmit_queue=0A=
801ff450 g     O __ksymtab	00000008 __ksymtab___vmalloc=0A=
8010b14c g     F .text	00000000 do_cpu=0A=
8013e1e8 g     F .text	00000000 sys_truncate=0A=
80200608 g     O __ksymtab	00000008 __ksymtab_skb_copy=0A=
8015229c g     F .text	00000000 __pollwait=0A=
801a8cb0 g     F .text	00000000 dst_destroy=0A=
80155e48 g     F .text	00000000 posix_unblock_lock=0A=
801ffba8 g     O __ksymtab	00000008 __ksymtab_expand_kiobuf=0A=
80146ed8 g     F .text	00000000 kill_super=0A=
801a4258 g     F .text	00000000 skb_copy_datagram=0A=
80119360 g     F .text	00000000 add_wait_queue=0A=
80127d64 g     F .text	00000000 sys_sgetmask=0A=
801fffe8 g     O __ksymtab	00000008 __ksymtab_n_tty_ioctl=0A=
80200158 g     O __ksymtab	00000008 __ksymtab_sock_release=0A=
801fb6b4 g     O .kstrtab	0000000b __kstrtab_vfs_rename=0A=
8020bf88 g     F .text.init	00000000 loopback_init=0A=
801ff458 g     O __ksymtab	00000008 __ksymtab_mem_map=0A=
8014c4c4 g     F .text	00000000 follow_down=0A=
801fad58 g     O .kstrtab	00000011 __kstrtab_inter_module_get=0A=
801fc688 g     O .kstrtab	00000015 __kstrtab_generate_random_uuid=0A=
8021e814 g     O .data	00000004 sysctl_tcp_max_tw_buckets=0A=
80200678 g     O __ksymtab	00000008 __ksymtab_dev_mc_add=0A=
8012576c g     F .text	00000000 sys_gettid=0A=
801ffd40 g     O __ksymtab	00000008 __ksymtab_machine_power_off=0A=
8011de1c g     F .text	00000000 find_module=0A=
80318a64 g     O .bss	00000004 max_threads=0A=
801fb00c g     O .kstrtab	00000006 __kstrtab_igrab=0A=
8016b930 g     F .text	00000000 ext2_ioctl=0A=
801fc180 g     O .kstrtab	00000007 __kstrtab_sys_tz=0A=
801fd1c0 g     O .kstrtab	00000009 __kstrtab_dev_open=0A=
802005a0 g     O __ksymtab	00000008 __ksymtab_unregister_netdevice=0A=
8012db04 g     F .text	00000000 get_unmapped_area=0A=
801ffe30 g     O __ksymtab	00000008 __ksymtab_is_bad_inode=0A=
8010f8e0 g     F .text	0000003c r4k_clear_page_s32=0A=
80334a50 g     O .bss	00000080 inet_protos=0A=
8021ae90 g     O .data	00000048 def_fifo_fops=0A=
80200480 g     O __ksymtab	00000008 __ksymtab_ip_mc_dec_group=0A=
801fbeec g     O .kstrtab	0000000f __kstrtab___wake_up_sync=0A=
8013d970 g     F .text	00000000 shmem_lock=0A=
803164bc g     O .bss	00000004 _flush_page_to_ram=0A=
801e7610 g     F .text	00000000 do_gettimeofday=0A=
801fb5e4 g     O .kstrtab	00000010 __kstrtab_d_prune_aliases=0A=
80121070 g     F .text	00000000 remove_bh=0A=
80204918 g     F .text.init	00000000 loadmmu=0A=
801e372c g     F .text	00000000 unix_sysctl_unregister=0A=
801aa9cc g     F .text	00000000 neigh_update=0A=
801ff540 g     O __ksymtab	00000008 __ksymtab_lookup_one_len=0A=
801ddb68 g     F .text	00000000 fib_nh_match=0A=
801abdcc g     F .text	00000000 neigh_sysctl_unregister=0A=
8015aeb4 g     F .text	00000000 lookup_mnt=0A=
801ff0c0 g     O __ksymtab	00000008 __ksymtab_simple_strtol=0A=
80335914 g     O .bss	00000004 main_table=0A=
8013a08c g     F .text	00000000 show_swap_cache_info=0A=
801d87f8 g     F .text	00000000 inet_addr_onlink=0A=
801ad924 g     F .text	00000000 rt_cache_flush=0A=
801a1358 g     F .text	00000000 sock_no_connect=0A=
802005b8 g     O __ksymtab	00000008 __ksymtab_dev_get_by_index=0A=
801ff680 g     O __ksymtab	00000008 __ksymtab_set_blocksize=0A=
8012bd5c g     F .text	00000000 zeromap_page_range=0A=
8019dc40 g     F .text	00000000 move_addr_to_kernel=0A=
801ff870 g     O __ksymtab	00000008 __ksymtab_no_llseek=0A=
80202314 g     F .text.init	00000000 calibrate_delay=0A=
801ffac0 g     O __ksymtab	00000008 __ksymtab_set_binfmt=0A=
801a14e0 g     F .text	00000000 sock_def_error_report=0A=
802004c0 g     O __ksymtab	00000008 __ksymtab_inetdev_by_index=0A=
8012f8e4 g     F .text	00000000 add_to_page_cache_locked=0A=
801fb75c g     O .kstrtab	00000017 __kstrtab_grab_cache_page_nowait=0A=
801fb7b4 g     O .kstrtab	00000011 __kstrtab_page_follow_link=0A=
8019f850 g     F .text	00000000 sys_recvmsg=0A=
8021e200 g     O .data	00000004 ip_rt_min_delay=0A=
801fcb18 g     O .kstrtab	0000000e __kstrtab_skb_linearize=0A=
80316128 g     O .bss	00000004 _machine_power_off=0A=
8031ec60 g     O .bss	00000004 max_low_pfn=0A=
80154c28 g     F .text	00000000 __get_lease=0A=
801fc9fc g     O .kstrtab	00000013 __kstrtab_sock_no_socketpair=0A=
8021aee8 g     O .data	00000008 file_lock_list=0A=
801ffe18 g     O __ksymtab	00000008 __ksymtab_remove_inode_hash=0A=
802006e0 g     O __ksymtab	00000008 __ksymtab_qdisc_tree_lock=0A=
801fb40c g     O .kstrtab	00000013 __kstrtab_cont_prepare_write=0A=
8012cd6c g     F .text	00000000 handle_mm_fault=0A=
801fc600 g     O .kstrtab	00000010 __kstrtab_misc_deregister=0A=
801ff4e8 g     O __ksymtab	00000008 __ksymtab_iunique=0A=
801abff0 g     F .text	00000000 net_ratelimit=0A=
801fb630 g     O .kstrtab	00000012 __kstrtab_find_inode_number=0A=
801ffc00 g     O __ksymtab	00000008 __ksymtab_release_resource=0A=
80200338 g     O __ksymtab	00000008 __ksymtab_neigh_ifdown=0A=
80184440 g     F .text	00000000 ieee754sp_sqrt=0A=
8018e984 g     F .text	00000000 add_interrupt_randomness=0A=
802093b4 g     F .text.init	00000000 memory_devfs_register=0A=
803363f4 g     O .bss	00000004 generic_getDebugChar=0A=
801fc260 g     O .kstrtab	0000000f __kstrtab_make_bad_inode=0A=
8020c83c g     F .text.init	00000000 inet_initpeers=0A=
80157138 g     F .text	00000000 d_lookup=0A=
802000f0 g     O __ksymtab	00000008 __ksymtab_unregister_netdev=0A=
80316040 g     O .bss	00000004 real_root_dev=0A=
801fc750 g     O .kstrtab	00000017 __kstrtab_blk_queue_make_request=0A=
801faae4 g     O .kstrtab	00000014 __kstrtab_acquire_console_sem=0A=
80117bd0 g     F .text	00000000 __wake_up=0A=
801d5f18 g     F .text	00000000 arp_rcv=0A=
80139d74 g     F .text	00000000 free_pages=0A=
801fd27c g     O .kstrtab	00000014 __kstrtab_netdev_state_change=0A=
801fd3ac g     O .kstrtab	00000015 __kstrtab___netdev_watchdog_up=0A=
8031ec30 g     O .bss	00000004 vmlist=0A=
801e469c g     F .text	00000000 __bzero=0A=
801fad00 g     O .kstrtab	0000000e __kstrtab_schedule_task=0A=
801fcd14 g     O .kstrtab	0000000d __kstrtab_neigh_create=0A=
80200628 g     O __ksymtab	00000008 __ksymtab_dev_get=0A=
80125754 g     F .text	00000000 sys_geteuid=0A=
8021a0ac g     O .data	00000004 time_maxerror=0A=
801fba4c g     O .kstrtab	0000000c __kstrtab_max_sectors=0A=
80185c40 g     F .text	00000000 tty_hangup=0A=
801fd168 g     O .kstrtab	00000009 __kstrtab_rtnl_sem=0A=
8010c560 g     F .text	00000000 _sys_sysmips=0A=
80200060 g     O __ksymtab	00000008 __ksymtab_blk_get_queue=0A=
8012e4d8 g     F .text	00000000 sys_munmap=0A=
801fa7b8 g     O .kstrtab	0000000e __kstrtab_simple_strtol=0A=
801fbff4 g     O .kstrtab	00000007 __kstrtab_sscanf=0A=
801e5be8 g     F .text	00000000 vsnprintf=0A=
802003f8 g     O __ksymtab	00000008 __ksymtab_inet_add_protocol=0A=
80200540 g     O __ksymtab	00000008 __ksymtab_ipv4_config=0A=
80173da8 g     F .text	00000000 ipc64_perm_to_ipc_perm=0A=
8012f44c g     F .text	00000000 waitfor_one_page=0A=
801fc5f0 g     O .kstrtab	0000000e __kstrtab_misc_register=0A=
80183c90 g     F .text	00000000 ieee754dp_sqrt=0A=
8010bcbc g     F .text	00000000 __down=0A=
8020c2a8 g     F .text.init	00000000 net_dev_init=0A=
8019d548 g     F .text	00000000 loop_exit=0A=
80198630 g     F .text	00000000 elevator_linus_merge=0A=
80145bd4 g     F .text	00000000 register_filesystem=0A=
80316080 g     O .bss	00000004 ibe_board_handler=0A=
8021e81c g     O .data	00000004 sysctl_tcp_abort_on_overflow=0A=
801fb310 g     O .kstrtab	00000007 __kstrtab_getblk=0A=
801887c4 g     F .text	00000000 tty_unregister_driver=0A=
801fbbc0 g     O .kstrtab	00000018 __kstrtab_unregister_sysctl_table=0A=
8020eed0 g     F .text.init	00000000 init_IRQ=0A=
80200700 g     O __ksymtab	00000008 __ksymtab_memparse=0A=
80135df0 g     F .text	00000000 kmem_cache_create=0A=
801fc068 g     O .kstrtab	00000010 __kstrtab_machine_restart=0A=
80200598 g     O __ksymtab	00000008 __ksymtab_register_netdevice=0A=
801fc5b8 g     O .kstrtab	00000013 __kstrtab_tty_register_devfs=0A=
801fc0e0 g     O .kstrtab	00000009 __kstrtab_cap_bset=0A=
80171d88 g     F .text	00000000 is_autofs4_dentry=0A=
801acfbc g     F .text	00000000 dev_deactivate=0A=
8020fdd0 g     O .data.init	00000004 ic_enable=0A=
801fcc14 g     O .kstrtab	0000000d __kstrtab____pskb_trim=0A=
80200018 g     O __ksymtab	00000008 __ksymtab_add_blkdev_randomness=0A=
801a154c g     F .text	00000000 sock_def_readable=0A=
801ff6c0 g     O __ksymtab	00000008 __ksymtab___bforget=0A=
8014ea14 g     F .text	00000000 vfs_unlink=0A=
802002a8 g     O __ksymtab	00000008 __ksymtab____pskb_trim=0A=
801191f0 g     F .text	00000000 get_dma_list=0A=
80151adc g     F .text	00000000 dcache_readdir=0A=
80167d38 g     F .text	00000000 ext2_count_free_blocks=0A=
801faffc g     O .kstrtab	00000005 __kstrtab_fput=0A=
801fbd24 g     O .kstrtab	00000009 __kstrtab_complete=0A=
80335900 g     O .bss	0000000c ipv4_config=0A=
801ffb40 g     O __ksymtab	00000008 __ksymtab_irq_stat=0A=
8020ac38 g     F .text.init	00000000 device_init=0A=
801e6b58 g     F .text	00000000 rb_insert_color=0A=
8010ade0 g     F .text	00000000 do_dbe=0A=
8019e118 g     F .text	00000000 sock_alloc=0A=
801485f8 g     F .text	00000000 blkdev_close=0A=
801fb320 g     O .kstrtab	00000006 __kstrtab_cdput=0A=
80116ac0 g     F .text	00000000 local_flush_tlb_mm=0A=
801a710c g     F .text	00000000 netdev_set_master=0A=
801fcdc4 g     O .kstrtab	00000014 __kstrtab_neigh_parms_release=0A=
801fb460 g     O .kstrtab	00000011 __kstrtab_waitfor_one_page=0A=
801fb794 g     O .kstrtab	00000010 __kstrtab_vfs_follow_link=0A=
801ab848 g     F .text	00000000 neigh_parms_alloc=0A=
801fba08 g     O .kstrtab	00000010 __kstrtab_grok_partitions=0A=
801ffd48 g     O __ksymtab	00000008 __ksymtab__ctype=0A=
8021fcbc g     O .data	00000044 unix_stream_ops=0A=
80200570 g     O __ksymtab	00000008 __ksymtab_arp_tbl=0A=
801ff8e0 g     O __ksymtab	00000008 __ksymtab_block_symlink=0A=
80100280 g     F .text	00000028 except_vec2_generic=0A=
801ff3e0 g     O __ksymtab	00000008 __ksymtab_get_zeroed_page=0A=
80200150 g     O __ksymtab	00000008 __ksymtab_sock_alloc=0A=
801fb138 g     O .kstrtab	00000009 __kstrtab_d_lookup=0A=
801fb7c8 g     O .kstrtab	0000001e =
__kstrtab_page_symlink_inode_operations=0A=
801ffd28 g     O __ksymtab	00000008 __ksymtab_uts_sem=0A=
8021e5ec g     O .data	00000000 inet_peer_unused_lock=0A=
8021e014 g     O .data	00000004 net_msg_cost=0A=
801ff7e8 g     O __ksymtab	00000008 __ksymtab_prune_dcache=0A=
801fa9a4 g     O .kstrtab	0000000c __kstrtab_disable_irq=0A=
801ff370 g     O __ksymtab	00000008 =
__ksymtab_inter_module_get_request=0A=
80109384 g     F .text	00000000 sys_sigaltstack=0A=
80316194 g     O .bss	00000004 isa_slot_offset=0A=
8018e91c g     F .text	00000000 add_keyboard_randomness=0A=
80200528 g     O __ksymtab	00000008 __ksymtab_rtnl_unlock=0A=
8018cc00 g     F .text	00000000 raw_release=0A=
8021b2c4 g     O .data	00000050 proc_root=0A=
803340a0 g     O .bss	00000004 rd_doload=0A=
801411b0 g     F .text	00000000 file_move=0A=
802002c0 g     O __ksymtab	00000008 __ksymtab_pskb_copy=0A=
8015b9c4 g     F .text	00000000 umount_tree=0A=
801ff3c0 g     O __ksymtab	00000008 __ksymtab__alloc_pages=0A=
801a59d8 g     F .text	00000000 netdev_state_change=0A=
80128ea0 g     F .text	00000000 sys_setresgid=0A=
801da494 g     F .text	00000000 inet_getsockopt=0A=
80209524 g     F .text.init	00000000 tty_init=0A=
801fac64 g     O .kstrtab	00000014 __kstrtab_notifier_call_chain=0A=
801a4284 g     F .text	00000000 skb_copy_datagram_iovec=0A=
8010bc10 g     F .text	00000000 machine_restart=0A=
801a562c g     F .text	00000000 __dev_get_by_name=0A=
801fd0f8 g     O .kstrtab	0000001d =
__kstrtab_unregister_inetaddr_notifier=0A=
8021a098 g     O .data	00000004 time_state=0A=
80197404 g     F .text	00000000 submit_bh=0A=
801276b4 g     F .text	00000000 sys_kill=0A=
801ff820 g     O __ksymtab	00000008 __ksymtab_vfs_mkdir=0A=
8019d8c8 g     F .text	00000000 ether_setup=0A=
80125764 g     F .text	00000000 sys_getegid=0A=
80205a30 g     F .text.init	00000054 except_vec0_r4600=0A=
80159b30 g     F .text	00000000 inode_change_ok=0A=
8010a958 g     F .text	00000000 show_regs=0A=
8016c7e4 g     F .text	00000000 ext2_update_dynamic_rev=0A=
801848c8 g     F .text	00000000 fpu_emulator_restore_context=0A=
8021e6dc g     O .data	00000004 sysctl_tcp_fack=0A=
8012183c g     F .text	00000000 __release_region=0A=
80183460 g     F .text	00000000 ieee754sp_tlong=0A=
801ff2a8 g     O __ksymtab	00000008 __ksymtab_kill_proc=0A=
801fafe4 g     O .kstrtab	00000008 __kstrtab_getname=0A=
801ca6b4 g     F .text	00000000 tcp_send_probe0=0A=
80320a10 g     O .bss	00000004 proc_root_fs=0A=
801ffdb8 g     O __ksymtab	00000008 __ksymtab_si_meminfo=0A=
801fa7c8 g     O .kstrtab	00000007 __kstrtab_strcat=0A=
801fffd0 g     O __ksymtab	00000008 __ksymtab_tty_register_ldisc=0A=
8021fbdc g     O .data	0000000c fib_netdev_notifier=0A=
80207858 g     F .text.init	00000000 free_area_init=0A=
801ffb68 g     O __ksymtab	00000008 __ksymtab_complete=0A=
801fca88 g     O .kstrtab	00000013 __kstrtab_sock_no_setsockopt=0A=
8011c2c4 g     F .text	00000000 inter_module_get=0A=
8014932c g     F .text	00000000 unregister_binfmt=0A=
801fa78c g     O .kstrtab	00000009 __kstrtab_EISA_bus=0A=
802004d0 g     O __ksymtab	00000008 __ksymtab_ip_defrag=0A=
80148d8c g     F .text	00000000 sys_fstat=0A=
80200680 g     O __ksymtab	00000008 __ksymtab_dev_mc_delete=0A=
8010ae04 g     F .text	00000000 do_ov=0A=
801601bc g     F .text	00000000 proc_read_super=0A=
80125c84 g     F .text	00000000 exit_sighand=0A=
80128248 g     F .text	00000000 sys_getpriority=0A=
80125d94 g     F .text	00000000 block_all_signals=0A=
801fc990 g     O .kstrtab	00000008 __kstrtab_sk_free=0A=
801fd1e0 g     O .kstrtab	00000007 __kstrtab_ip_rcv=0A=
80173d6c g     F .text	00000000 kernel_to_ipc64_perm=0A=
80156df8 g     F .text	00000000 shrink_dcache_parent=0A=
801a25d0 g     F .text	00000000 pskb_expand_head=0A=
8020c180 g     F .text.init	00000000 skb_init=0A=
801fcec4 g     O .kstrtab	0000000f __kstrtab_scm_detach_fds=0A=
801fcf80 g     O .kstrtab	00000010 __kstrtab_ip_options_undo=0A=
80127c90 g     F .text	00000000 sys_rt_sigaction=0A=
80156830 g     F .text	00000000 d_prune_aliases=0A=
801fa894 g     O .kstrtab	00000012 __kstrtab___strlen_user_asm=0A=
801fd180 g     O .kstrtab	0000000c __kstrtab_rtnl_unlock=0A=
8021be38 g     O .data	00000040 autofs_root_inode_operations=0A=
801ddb04 g     F .text	00000000 ip_fib_check_default=0A=
802003d8 g     O __ksymtab	00000008 __ksymtab_sklist_destroy_socket=0A=
8021a108 g     O .data	00000000 notifier_lock=0A=
801ace34 g     F .text	00000000 qdisc_destroy=0A=
80335944 g     O .bss	00000040 ic_domain=0A=
801fb358 g     O .kstrtab	0000000c __kstrtab_ll_rw_block=0A=
80185dc8 g     F .text	00000000 stop_tty=0A=
801fcbec g     O .kstrtab	00000016 __kstrtab_skb_copy_and_csum_dev=0A=
80173b24 g     F .text	00000000 ipc_rmid=0A=
801fb8f0 g     O .kstrtab	00000010 __kstrtab_register_blkdev=0A=
8010fe98 g     F .text	0000011c r4k_copy_page_s128=0A=
801a4e48 g     F .text	00000000 put_cmsg=0A=
801fb604 g     O .kstrtab	00000011 __kstrtab_shrink_dcache_sb=0A=
80119124 g     F .text	00000000 wake_up_process=0A=
8012aaa4 g     F .text	00000000 current_is_keventd=0A=
801d6528 g     F .text	00000000 arp_req_set=0A=
8016c560 g     F .text	00000000 ext2_error=0A=
80121c50 g     F .text	00000000 do_sysctl_strategy=0A=
8014e28c g     F .text	00000000 vfs_mkdir=0A=
801fa9bc g     O .kstrtab	0000000f __kstrtab_probe_irq_mask=0A=
80159164 g     F .text	00000000 get_empty_inode=0A=
801988a8 g     F .text	00000000 blkelvget_ioctl=0A=
801ff478 g     O __ksymtab	00000008 __ksymtab_vmtruncate=0A=
801ff1c0 g     O __ksymtab	00000008 __ksymtab_disable_irq=0A=
80166298 g     F .text	00000000 grok_partitions=0A=
801fba18 g     O .kstrtab	0000000e __kstrtab_register_disk=0A=
801ff218 g     O __ksymtab	00000008 __ksymtab_abi_defhandler_coff=0A=
8021cbc4 g     O .data	00000004 rd_blocksize=0A=
801fbee0 g     O .kstrtab	0000000a __kstrtab___wake_up=0A=
803164a4 g     O .bss	00000004 _copy_page=0A=
801ff380 g     O __ksymtab	00000008 __ksymtab_try_inc_mod_count=0A=
8021fbd0 g     O .data	0000000c fib_inetaddr_notifier=0A=
801fbe98 g     O .kstrtab	00000011 __kstrtab___release_region=0A=
80206524 g     F .text.init	00000000 kmem_cache_init=0A=
801bdcb0 g     F .text	00000000 tcp_disconnect=0A=
8031d760 g     O .bss	00000004 prof_shift=0A=
80198918 g     F .text	00000000 blkelvset_ioctl=0A=
8017a7ec g     F .text	00000000 fpu_emulator_cop1Handler=0A=
80200590 g     O __ksymtab	00000008 __ksymtab_loopback_dev=0A=
80317a44 g     O .bss	00000004 nr_threads=0A=
801faec8 g     O .kstrtab	00000013 __kstrtab_kmem_cache_destroy=0A=
801fbebc g     O .kstrtab	0000000f __kstrtab_iomem_resource=0A=
8031ecc4 g     O .bss	00000004 nr_swapfiles=0A=
801ffd00 g     O __ksymtab	00000008 __ksymtab_kdevname=0A=
801fcaec g     O .kstrtab	0000000b __kstrtab_sock_wfree=0A=
801fbe50 g     O .kstrtab	00000012 __kstrtab_allocate_resource=0A=
801e800c g     F .text	00000000 idisx_set_int_handler=0A=
80158fb4 g     F .text	00000000 shrink_icache_memory=0A=
801ff788 g     O __ksymtab	00000008 __ksymtab_locks_init_lock=0A=
80117300 g     F .text	0000017c handle_mod=0A=
80325d24 g     O .bss	000000c0 ptm_driver=0A=
802130a0 g     F .data	00000100 handle_ades=0A=
801886ac g     F .text	00000000 tty_register_devfs=0A=
8017b33c g     F .text	00000000 ieee754dp_bestnan=0A=
801804d0 g     F .text	00000000 ieee754dp_flong=0A=
801ff688 g     O __ksymtab	00000008 __ksymtab_getblk=0A=
801ff780 g     O __ksymtab	00000008 __ksymtab_file_lock_list=0A=
80162ca8 g     F .text	00000000 create_proc_entry=0A=
803164cc g     O .bss	00000004 _flush_icache_all=0A=
8017074c g     F .text	00000000 autofs_wait_release=0A=
801da160 g     F .text	00000000 inet_sock_destruct=0A=
801fb1b0 g     O .kstrtab	00000012 __kstrtab_init_private_file=0A=
801ff598 g     O __ksymtab	00000008 __ksymtab_d_instantiate=0A=
8013df30 g     F .text	00000000 vfs_statfs=0A=
8017f5dc g     F .text	00000000 ieee754dp_abs=0A=
801a0dbc g     F .text	00000000 sock_alloc_send_skb=0A=
801fbe64 g     O .kstrtab	0000000f __kstrtab_check_resource=0A=
801ffc38 g     O __ksymtab	00000008 __ksymtab_iomem_resource=0A=
80140a5c g     F .text	00000000 register_chrdev=0A=
80200350 g     O __ksymtab	00000008 __ksymtab_pneigh_enqueue=0A=
801ac2d4 g     F .text	00000000 eth_type_trans=0A=
801dbed4 g     F .text	00000000 ip_mc_inc_group=0A=
801e3250 g     F .text	00000000 unix_gc=0A=
8011ba54 g     F .text	00000000 acquire_console_sem=0A=
801fb9b8 g     O .kstrtab	0000001a =
__kstrtab_devfs_register_partitions=0A=
80130ea4 g     F .text	00000000 file_read_actor=0A=
801ff430 g     O __ksymtab	00000008 __ksymtab_kmem_cache_free=0A=
801ba124 g     F .text	00000000 do_tcp_sendpages=0A=
801fb950 g     O .kstrtab	0000000d __kstrtab_blksize_size=0A=
801ff1e8 g     O __ksymtab	00000008 __ksymtab__dma_cache_wback_inv=0A=
801ffb90 g     O __ksymtab	00000008 __ksymtab_tq_immediate=0A=
801a0b98 g     F .text	00000000 sock_kmalloc=0A=
80126c84 g     F .text	00000000 force_sig=0A=
8020fde0 g     O .data.init	00000004 ic_netmask=0A=
801fb024 g     O .kstrtab	00000005 __kstrtab_iput=0A=
80200438 g     O __ksymtab	00000008 __ksymtab_ip_options_undo=0A=
802006e8 g     O __ksymtab	00000008 __ksymtab_register_gifconf=0A=
80317a48 g     O .bss	00000004 last_pid=0A=
801ff310 g     O __ksymtab	00000008 =
__ksymtab_register_reboot_notifier=0A=
801540ec g     F .text	00000000 posix_locks_deadlock=0A=
802001a0 g     O __ksymtab	00000008 __ksymtab_sock_init_data=0A=
801fa96c g     O .kstrtab	00000010 __kstrtab_set_mqb_handler=0A=
801fb094 g     O .kstrtab	0000000f __kstrtab_lookup_one_len=0A=
803164c0 g     O .bss	00000004 _flush_icache_range=0A=
801a1808 g     F .text	00000000 skb_under_panic=0A=
801fb0fc g     O .kstrtab	00000009 __kstrtab_d_rehash=0A=
801ff488 g     O __ksymtab	00000008 __ksymtab_get_unmapped_area=0A=
80200318 g     O __ksymtab	00000008 __ksymtab_neigh_create=0A=
80318e94 g     O .bss	00000004 panic_notifier_list=0A=
80128574 g     F .text	00000000 sys_setregid=0A=
8012d1ac g     F .text	00000000 unlock_vma_mappings=0A=
801093b8 g     F .text	00000000 restore_sigcontext=0A=
80200300 g     O __ksymtab	00000008 __ksymtab_neigh_resolve_output=0A=
8011bae8 g     F .text	00000000 release_console_sem=0A=
80173608 g     F .text	00000000 devpts_read_super=0A=
801fd430 g     O .kstrtab	0000000e __kstrtab_dev_mc_upload=0A=
8013e3fc g     F .text	00000000 sys_ftruncate=0A=
80145fe0 g     F .text	00000000 drop_super=0A=
80135554 g     F .text	00000000 get_vm_area=0A=
801fd460 g     O .kstrtab	00000010 __kstrtab_sysctl_wmem_max=0A=
8020bf5c g     F .text.init	00000000 net_device_init=0A=
801fd470 g     O .kstrtab	00000010 __kstrtab_sysctl_rmem_max=0A=
8012e794 g     F .text	00000000 build_mmap_rb=0A=
801fff58 g     O __ksymtab	00000008 __ksymtab_set_bh_page=0A=
8021c1d8 g     O .data	00000004 msg_ctlmni=0A=
801fc50c g     O .kstrtab	0000000d __kstrtab_proc_symlink=0A=
8021bdf0 g     O .data	00000048 autofs_root_operations=0A=
801fce10 g     O .kstrtab	0000000b __kstrtab___dst_free=0A=
8021d8b4 g     O .data	00000000 net_big_sklist_lock=0A=
80205d38 g     F .text.init	00000000 proc_caches_init=0A=
801ff518 g     O __ksymtab	00000008 __ksymtab_lookup_mnt=0A=
801fbf70 g     O .kstrtab	00000011 __kstrtab_schedule_timeout=0A=
801d1570 g     F .text	00000000 tcp_tw_schedule=0A=
801b02d8 g     F .text	00000000 ip_route_output_slow=0A=
801ff698 g     O __ksymtab	00000008 __ksymtab_cdput=0A=
80108988 g     F .text	00000000 copy_thread=0A=
80316410 g     O .bss	00000004 empty_zero_page=0A=
8017681c g     F .text	00000000 sys_semctl=0A=
801ff648 g     O __ksymtab	00000008 __ksymtab_fsync_no_super=0A=
80200708 g     O __ksymtab	00000008 __ksymtab_get_option=0A=
801295b8 g     F .text	00000000 in_group_p=0A=
801ff750 g     O __ksymtab	00000008 __ksymtab_generic_file_write=0A=
8013f1c4 g     F .text	00000000 sys_chmod=0A=
801ffb60 g     O __ksymtab	00000008 __ksymtab_wait_for_completion=0A=
80118530 g     F .text	00000000 sys_nice=0A=
80200430 g     O __ksymtab	00000008 __ksymtab_ip_options_compile=0A=
8021e208 g     O .data	00000004 ip_rt_gc_timeout=0A=
8011c470 g     F .text	00000000 sys_create_module=0A=
801ce4ac g     F .text	00000000 tcp_v4_syn_recv_sock=0A=
801ff668 g     O __ksymtab	00000008 __ksymtab_inode_change_ok=0A=
8021e264 g     O .data	00000010 ip_tos2prio=0A=
801ae664 g     F .text	00000000 ip_rt_redirect=0A=
801fb88c g     O .kstrtab	00000012 __kstrtab_filemap_fdatasync=0A=
80200500 g     O __ksymtab	00000008 __ksymtab_dev_set_allmulti=0A=
80188aa8 g     F .text	00000000 n_tty_flush_buffer=0A=
80152490 g     F .text	00000000 do_select=0A=
8031ebf8 g     O .bss	00000004 high_memory=0A=
8012977c g     F .text	00000000 sys_gethostname=0A=
801ff7d8 g     O __ksymtab	00000008 __ksymtab_d_find_alias=0A=
80198990 g     F .text	00000000 elevator_init=0A=
802000f8 g     O __ksymtab	00000008 __ksymtab_autoirq_setup=0A=
801b93a0 g     F .text	00000000 tcp_write_space=0A=
80142ad0 g     F .text	00000000 balance_dirty=0A=
801ffb00 g     O __ksymtab	00000008 __ksymtab_proc_dointvec_jiffies=0A=
801db040 g     F .text	00000000 inet_stream_connect=0A=
801ff2b0 g     O __ksymtab	00000008 __ksymtab_kill_proc_info=0A=
801fd450 g     O .kstrtab	0000000d __kstrtab_if_port_text=0A=
80200630 g     O __ksymtab	00000008 __ksymtab_dev_alloc=0A=
80159a60 g     F .text	00000000 force_delete=0A=
802082bc g     F .text.init	00000000 cdev_cache_init=0A=
801fb960 g     O .kstrtab	0000000e __kstrtab_hardsect_size=0A=
801fcf6c g     O .kstrtab	00000013 __kstrtab_ip_options_compile=0A=
8021e810 g     O .data	00000004 sysctl_tcp_tw_recycle=0A=
8031eba4 g     O .bss	00000004 nr_queued_signals=0A=
801ff570 g     O __ksymtab	00000008 __ksymtab_dget_locked=0A=
80316404 g     O .bss	00000004 vcei_count=0A=
801a9ad0 g     F .text	00000000 pneigh_lookup=0A=
801fbde0 g     O .kstrtab	0000000b __kstrtab_brw_kiovec=0A=
801fc244 g     O .kstrtab	0000001a =
__kstrtab_buffer_insert_inode_queue=0A=
8021e160 g     O .data	00000060 noqueue_qdisc=0A=
8020973c g     F .text.init	00000000 pty_init=0A=
8010d348 g     F .text	00000000 get_irq_list=0A=
801fd1cc g     O .kstrtab	00000008 __kstrtab_in_ntoa=0A=
802006b8 g     O __ksymtab	00000008 __ksymtab_qdisc_destroy=0A=
801fffb8 g     O __ksymtab	00000008 __ksymtab_proc_net=0A=
8020fde4 g     O .data.init	00000004 ic_gateway=0A=
801755bc g     F .text	00000000 pipelined_send=0A=
8014726c g     F .text	00000000 do_kern_mount=0A=
801f1108 g     O .text	00000018 ieee754_cname=0A=
80117634 g     F .text	00000000 schedule_timeout=0A=
80117744 g     F .text	00000000 schedule=0A=
80200718 g     O __ksymtab	00000008 __ksymtab_init_rwsem=0A=
8012c7e8 g     F .text	00000000 swapin_readahead=0A=
8010d8a4 g     F .text	00000000 request_irq=0A=
801ff278 g     O __ksymtab	00000008 __ksymtab_dequeue_signal=0A=
80141910 g     F .text	00000000 fsync_no_super=0A=
802004f8 g     O __ksymtab	00000008 __ksymtab_ip_statistics=0A=
8021a424 g     O .data	00000008 kswapd_wait=0A=
801fc0c0 g     O .kstrtab	00000011 __kstrtab_get_random_bytes=0A=
8010bf20 g     F .text	00000000 r4k_wait=0A=
80144114 g     F .text	00000000 generic_commit_write=0A=
8021e71c g     O .data	00000004 sysctl_tcp_keepalive_probes=0A=
801ffbf0 g     O __ksymtab	00000008 __ksymtab_dma_spin_lock=0A=
8017d7d0 g     F .text	00000000 ieee754dp_sub=0A=
80200090 g     O __ksymtab	00000008 __ksymtab_generic_unplug_device=0A=
8010d240 g     F .text	00000050 restore_fp=0A=
8019fc48 g     F .text	00000000 sock_register=0A=
801c0564 g     F .text	00000000 tcp_enter_loss=0A=
80170110 g     F .text	00000000 autofs_catatonic_mode=0A=
801fac78 g     O .kstrtab	00000019 =
__kstrtab_register_reboot_notifier=0A=
801fb6e0 g     O .kstrtab	00000014 __kstrtab_generic_file_llseek=0A=
801fc1dc g     O .kstrtab	00000013 __kstrtab_init_special_inode=0A=
801ff730 g     O __ksymtab	00000008 __ksymtab_generic_block_bmap=0A=
80140be0 g     F .text	00000000 kdevname=0A=
80334a10 g     O .bss	00000028 rt_cache_stat=0A=
8010b26c g     F .text	00000000 do_watch=0A=
801559dc g     F .text	00000000 fcntl_setlk64=0A=
801ff960 g     O __ksymtab	00000008 __ksymtab_unregister_chrdev=0A=
80200010 g     O __ksymtab	00000008 =
__ksymtab_add_interrupt_randomness=0A=
80123870 g     F .text	00000000 sys_capget=0A=
801e4dd0 g     F .text	00000000 dump16=0A=
801422b4 g     F .text	00000000 init_buffer=0A=
801ff9c8 g     O __ksymtab	00000008 __ksymtab_sync_dev=0A=
802005d0 g     O __ksymtab	00000008 __ksymtab___dev_get_by_name=0A=
801a5e44 g     F .text	00000000 skb_checksum_help=0A=
801a4934 g     F .text	00000000 datagram_poll=0A=
801ac3e8 g     F .text	00000000 eth_header_parse=0A=
80101000 g     O .text	00000000 swapper_pg_dir=0A=
8020b79c g     F .text.init	00000000 rd_load_secondary=0A=
801fb3b8 g     O .kstrtab	00000016 __kstrtab_block_write_full_page=0A=
801d5934 g     F .text	00000000 arp_find=0A=
8031d354 g     O .bss	00000004 pps_freq=0A=
802070b8 g     F .text.init	00000000 free_all_bootmem_node=0A=
80125244 g     F .text	00000000 timer_bh=0A=
80334760 g     O .bss	00000040 netdev_rx_stat=0A=
801ff1f0 g     O __ksymtab	00000008 __ksymtab__dma_cache_wback=0A=
80200238 g     O __ksymtab	00000008 __ksymtab_sock_wmalloc=0A=
803208bc g     O .bss	00000004 bh_cachep=0A=
8015c554 g     F .text	00000000 do_mount=0A=
801404a4 g     F .text	00000000 sys_readv=0A=
80121ee0 g     F .text	00000000 unregister_sysctl_table=0A=
80139c18 g     F .text	00000000 __get_free_pages=0A=
801ff378 g     O __ksymtab	00000008 __ksymtab_inter_module_put=0A=
80219040 g     O .data	00000000 i8259A_lock=0A=
801b91c8 g     F .text	00000000 tcp_rfree=0A=
801088c0 g     F .text	00000000 exit_thread=0A=
801ac49c g     F .text	00000000 eth_header_cache_update=0A=
8021a420 g     O .data	00000004 swap_mm=0A=
80200200 g     O __ksymtab	00000008 __ksymtab_sock_no_setsockopt=0A=
801e47e0 g     F .text	00000028 __strlen_user_asm=0A=
80168718 g     F .text	00000000 ext2_dotdot=0A=
80182ae0 g     F .text	00000000 ieee754sp_finite=0A=
8012e1c4 g     F .text	00000000 do_munmap=0A=
801ff3a0 g     O __ksymtab	00000008 __ksymtab_exit_mm=0A=
801fbd30 g     O .kstrtab	0000000d __kstrtab_probe_irq_on=0A=
801213b8 g     F .text	00000000 get_resource_list=0A=
8019eea0 g     F .text	00000000 sys_bind=0A=
801fca20 g     O .kstrtab	00000010 __kstrtab_sock_no_getname=0A=
801ffbd8 g     O __ksymtab	00000008 __ksymtab_kiobuf_wait_for_io=0A=
801fc230 g     O .kstrtab	00000012 __kstrtab_remove_inode_hash=0A=
8021e5e8 g     O .data	00000004 inet_peer_unused_tailp=0A=
80162ff4 g     F .text	00000000 proc_pid_status=0A=
80197798 g     F .text	00000000 end_that_request_first=0A=
80335e10 g     O .bss	00000004 prom_argc=0A=
80119bd0 g     F .text	00000000 copy_fs_struct=0A=
801453a0 g     F .text	00000000 try_to_free_buffers=0A=
801bed34 g     F .text	00000000 tcp_getsockopt=0A=
8014337c g     F .text	00000000 create_empty_buffers=0A=
80316160 g     O .bss	00000034 screen_info=0A=
80200188 g     O __ksymtab	00000008 __ksymtab_sk_free=0A=
80124fb0 g     F .text	00000000 update_one_process=0A=
80196254 g     F .text	00000000 blk_queue_make_request=0A=
8014f17c g     F .text	00000000 sys_link=0A=
80128014 g     F .text	00000000 register_reboot_notifier=0A=
80156e8c g     F .text	00000000 d_alloc=0A=
801fb8a0 g     O .kstrtab	00000012 __kstrtab_filemap_fdatawait=0A=
801756a0 g     F .text	00000000 convert_mode=0A=
801210b8 g     F .text	00000000 __run_task_queue=0A=
801ff3b8 g     O __ksymtab	00000008 __ksymtab_exit_sighand=0A=
801443c4 g     F .text	00000000 block_write_full_page=0A=
8014864c g     F .text	00000000 bdevname=0A=
80212dc0 g     O .data	00000186 system_utsname=0A=
801fb3e8 g     O .kstrtab	00000014 __kstrtab_block_prepare_write=0A=
80200000 g     O __ksymtab	00000008 =
__ksymtab_add_keyboard_randomness=0A=
801fd350 g     O .kstrtab	00000009 __kstrtab_skb_copy=0A=
80200648 g     O __ksymtab	00000008 __ksymtab_dev_load=0A=
801ffe20 g     O __ksymtab	00000008 =
__ksymtab_buffer_insert_inode_queue=0A=
802044f8 g     F .text.init	00000000 init_i8259_irqs=0A=
801363a4 g     F .text	00000000 kmem_cache_shrink=0A=
80144d00 g     F .text	00000000 block_symlink=0A=
801fb7f8 g     O .kstrtab	0000000c __kstrtab_vfs_readdir=0A=
801a9828 g     F .text	00000000 neigh_create=0A=
801abf90 g     F .text	00000000 net_random=0A=
801c7ecc g     F .text	00000000 tcp_sync_mss=0A=
8015a3e4 g     F .text	00000000 expand_fdset=0A=
801fafa0 g     O .kstrtab	0000000d __kstrtab_def_blk_fops=0A=
801d088c g     F .text	00000000 tcp_v4_lookup=0A=
803164b0 g     O .bss	00000004 _flush_cache_mm=0A=
8021b820 g     O .data	00000048 proc_kmsg_operations=0A=
80209438 g     F .text.init	00000000 console_init=0A=
8016df5c g     F .text	00000000 ext2_statfs=0A=
8031ec20 g     O .bss	00000004 page_hash_bits=0A=
80131d3c g     F .text	00000000 generic_file_mmap=0A=
8031631c g     O .bss	00000004 fd_ops=0A=
801fcb08 g     O .kstrtab	0000000d __kstrtab_sock_rmalloc=0A=
801e5014 g     F .text	00000000 strnlen=0A=
801d9c08 g     F .text	00000000 unregister_inetaddr_notifier=0A=
801fb01c g     O .kstrtab	00000006 __kstrtab_iget4=0A=
801ffb50 g     O __ksymtab	00000008 =
__ksymtab_add_wait_queue_exclusive=0A=
801ff0f8 g     O __ksymtab	00000008 __ksymtab_strrchr=0A=
80200040 g     O __ksymtab	00000008 __ksymtab_io_request_lock=0A=
80137630 g     F .text	00000000 slabinfo_read_proc=0A=
801ffc28 g     O __ksymtab	00000008 __ksymtab___release_region=0A=
8013fa44 g     F .text	00000000 sys_creat=0A=
801fa7e8 g     O .kstrtab	00000008 __kstrtab_strncat=0A=
801fc0ec g     O .kstrtab	00000011 __kstrtab_reparent_to_init=0A=
80200108 g     O __ksymtab	00000008 __ksymtab_skb_over_panic=0A=
80213b8c g     F .data	00000000 handle_mcheck_int=0A=
8010c2f4 g     F .text	00000000 sys_olduname=0A=
8021a2dc g     O .data	00000000 pagecache_lock=0A=
80206100 g     F .text.init	00000000 softirq_init=0A=
801fc1f0 g     O .kstrtab	0000000b __kstrtab_read_ahead=0A=
801ca2a4 g     F .text	00000000 tcp_send_ack=0A=
801fc628 g     O .kstrtab	00000015 __kstrtab_add_mouse_randomness=0A=
8021a2d8 g     O .data	00000004 vm_min_readahead=0A=
8021afd0 g     O .data	00000004 dir_notify_enable=0A=
8021a0c0 g     O .data	00000018 root_user=0A=
801534e4 g     F .text	00000000 locks_init_lock=0A=
80166bc0 g     F .text	00000000 ext2_get_group_desc=0A=
8018b7f0 g     F .text	00000000 tty_wait_until_sent=0A=
8011aaac g     F .text	00000000 register_exec_domain=0A=
801cbd00 g     F .text	00000000 tcp_bucket_create=0A=
801fd204 g     O .kstrtab	0000001c =
__kstrtab_register_netdevice_notifier=0A=
801fbda4 g     O .kstrtab	00000010 __kstrtab_map_user_kiobuf=0A=
801fb03c g     O .kstrtab	0000000a __kstrtab_follow_up=0A=
8015aab0 g     F .text	00000000 fcntl_dirnotify=0A=
801daa9c g     F .text	00000000 inet_release=0A=
80124428 g     F .text	00000000 access_process_vm=0A=
80138b40 g     F .text	00000000 rw_swap_page=0A=
801fae58 g     O .kstrtab	00000013 __kstrtab_page_cache_release=0A=
80208d64 g     F .text.init	00000000 proc_root_init=0A=
8014847c g     F .text	00000000 blkdev_put=0A=
80182aa0 g     F .text	00000000 ieee754sp_ldexp=0A=
801ff1f8 g     O __ksymtab	00000008 __ksymtab__dma_cache_inv=0A=
8021a09c g     O .data	00000004 time_status=0A=
801447ec g     F .text	00000000 brw_kiovec=0A=
80200710 g     O __ksymtab	00000008 __ksymtab_get_options=0A=
80109060 g     F .text	00000024 sys_rt_sigsuspend=0A=
8012869c g     F .text	00000000 sys_setgid=0A=
8021e744 g     O .data	00000014 or_ipv4=0A=
8010046c g     F .text	00000040 kernel_entry=0A=
801a15b8 g     F .text	00000000 sock_def_write_space=0A=
801fc874 g     O .kstrtab	0000000e __kstrtab_autoirq_setup=0A=
801a3954 g     F .text	00000000 memcpy_toiovec=0A=
80219570 g     O .data	00000000 global_bh_lock=0A=
8031e780 g     O .bss	00000004 wall_jiffies=0A=
80204384 g     F .text.init	00000000 fpu_disable=0A=
802001f0 g     O __ksymtab	00000008 __ksymtab_sock_no_shutdown=0A=
801ffa78 g     O __ksymtab	00000008 __ksymtab_kern_mount=0A=
801ff408 g     O __ksymtab	00000008 =
__ksymtab_kmem_find_general_cachep=0A=
80321124 g     O .bss	00000028 tty_std_termios=0A=
8010e598 g     F .text	00000000 i8259_do_irq=0A=
8031d2b8 g     O .bss	00000080 console_cmdline=0A=
801ff348 g     O __ksymtab	00000008 __ksymtab_schedule_task=0A=
80200610 g     O __ksymtab	00000008 __ksymtab_netif_rx=0A=
8011cf68 g     F .text	00000000 try_inc_mod_count=0A=
801ff8c8 g     O __ksymtab	00000008 __ksymtab_page_readlink=0A=
80139d1c g     F .text	00000000 __free_pages=0A=
8021fd00 g     O .data	00000044 unix_dgram_ops=0A=
801fcae0 g     O .kstrtab	0000000b __kstrtab_sock_rfree=0A=
801fb97c g     O .kstrtab	00000008 __kstrtab_blk_dev=0A=
801fb078 g     O .kstrtab	0000000d __kstrtab_path_release=0A=
801413d0 g     F .text	00000000 end_buffer_io_sync=0A=
801fbefc g     O .kstrtab	00000010 __kstrtab_wake_up_process=0A=
8010fcb4 g     F .text	000000a8 r4k_copy_page_s16=0A=
8021c540 g     O .data	00000040 tty_ldisc_N_TTY=0A=
8021b1a0 g     O .data	00000018 script_format=0A=
801ff250 g     O __ksymtab	00000008 __ksymtab_acquire_console_sem=0A=
801ff410 g     O __ksymtab	00000008 __ksymtab_kmem_cache_create=0A=
801fbae0 g     O .kstrtab	00000014 __kstrtab_register_filesystem=0A=
8010de54 g     F .text	00000000 probe_irq_off=0A=
8012ffbc g     F .text	00000000 __find_get_page=0A=
80335420 g     O .bss	00000004 sysctl_icmp_echo_ignore_all=0A=
80127ac4 g     F .text	00000000 sys_sigprocmask=0A=
801369a0 g     F .text	00000000 kmem_cache_alloc=0A=
80177b3c g     F .text	00000000 sys_shmctl=0A=
8031d75c g     O .bss	00000004 prof_len=0A=
801ffa30 g     O __ksymtab	00000008 __ksymtab_tty_hangup=0A=
801ff2b8 g     O __ksymtab	00000008 __ksymtab_kill_sl=0A=
80140ed0 g     F .text	00000000 init_private_file=0A=
801fff08 g     O __ksymtab	00000008 __ksymtab_tasklist_lock=0A=
801ff9f8 g     O __ksymtab	00000008 __ksymtab_grok_partitions=0A=
801ffc50 g     O __ksymtab	00000008 __ksymtab___wake_up_sync=0A=
802139c0 g     F .data	000000f4 handle_watch=0A=
801ffe58 g     O __ksymtab	00000008 __ksymtab_fasync_helper=0A=
801fb178 g     O .kstrtab	00000014 __kstrtab___mark_buffer_dirty=0A=
801fd578 g     O .kstrtab	0000000a __kstrtab___up_read=0A=
802192dc g     O .data	00000004 abi_defhandler_libcso=0A=
801e4f94 g     F .text	00000000 strrchr=0A=
8031ec80 g     O .bss	00000004 pgdat_list=0A=
80202b24 g     F .text.init	0000007c except_vec3_r4000=0A=
801217ec g     F .text	00000000 __check_region=0A=
80334cd8 g     O .bss	00000004 tcp_sockets_allocated=0A=
80155c1c g     F .text	00000000 locks_remove_posix=0A=
8013a9bc g     F .text	00000000 swap_free=0A=
8021a0f4 g     O .data	00000004 overflowgid=0A=
802005c0 g     O __ksymtab	00000008 __ksymtab___dev_get_by_index=0A=
801fc824 g     O .kstrtab	0000000e __kstrtab_init_etherdev=0A=
801fc860 g     O .kstrtab	00000012 __kstrtab_unregister_netdev=0A=
803340a4 g     O .bss	00000004 rd_image_start=0A=
8021f224 g     O .data	00000044 inet_dgram_ops=0A=
801ff500 g     O __ksymtab	00000008 __ksymtab_force_delete=0A=
80200490 g     O __ksymtab	00000008 __ksymtab_inet_stream_ops=0A=
8013a5a0 g     F .text	00000000 get_swap_page=0A=
8017bb7c g     F .text	00000000 ieee754sp_issnan=0A=
801f6d00 g     O .text	00000020 timer_bug_msg=0A=
8018867c g     F .text	00000000 tty_default_put_char=0A=
8019022c g     F .text	00000000 secure_ip_id=0A=
80197988 g     F .text	00000000 blkdev_release_request=0A=
80172eb0 g     F .text	00000000 autofs4_expire_multi=0A=
8021a2d4 g     O .data	00000004 vm_max_readahead=0A=
80200080 g     O __ksymtab	00000008 __ksymtab_generic_make_request=0A=
801555b8 g     F .text	00000000 fcntl_setlk=0A=
80119764 g     F .text	00000000 mm_alloc=0A=
801fc528 g     O .kstrtab	0000000b __kstrtab_proc_mkdir=0A=
801ffe80 g     O __ksymtab	00000008 __ksymtab_strnicmp=0A=
8013e7c4 g     F .text	00000000 sys_ftruncate64=0A=
803352c0 g     O .bss	00000004 udp_port_rover=0A=
801fc174 g     O .kstrtab	0000000b __kstrtab_si_meminfo=0A=
8020ab1c g     F .text.init	00000000 blk_dev_init=0A=
8013f450 g     F .text	00000000 sys_fchown=0A=
801fb4d8 g     O .kstrtab	00000019 =
__kstrtab_generic_buffer_fdatasync=0A=
801ffa38 g     O __ksymtab	00000008 __ksymtab_tty_wait_until_sent=0A=
80142948 g     F .text	00000000 invalidate_inode_buffers=0A=
8015bea4 g     F .text	00000000 graft_tree=0A=
80169764 g     F .text	00000000 ext2_new_inode=0A=
801440dc g     F .text	00000000 block_commit_write=0A=
803192a0 g     O .bss	00000004 oops_in_progress=0A=
801a3860 g     F .text	00000000 verify_iovec=0A=
802194c8 g     O .data	00000060 kernel_module=0A=
801a28f4 g     F .text	00000000 skb_copy_expand=0A=
80125624 g     F .text	00000000 do_timer=0A=
8031ec24 g     O .bss	00000004 page_hash_table=0A=
80204608 g     F .text.init	00000000 mem_init=0A=
8010046c g     O .text	00000000 stext=0A=
8016e668 g     F .text	00000000 autofs_hash_delete=0A=
801abb78 g     F .text	00000000 neigh_table_clear=0A=
801703dc g     F .text	00000000 autofs_wait=0A=
801244f4 g     F .text	00000000 ptrace_readdata=0A=
801fcd04 g     O .kstrtab	0000000d __kstrtab_neigh_update=0A=
801ff768 g     O __ksymtab	00000008 =
__ksymtab_generic_buffer_fdatasync=0A=
8012dc6c g     F .text	00000000 find_vma=0A=
8010ed90 g     F .text	00000000 free_initmem=0A=
80200208 g     O __ksymtab	00000008 __ksymtab_sock_no_sendmsg=0A=
801ffc80 g     O __ksymtab	00000008 __ksymtab_schedule=0A=
8020c59c g     F .text.init	00000000 dst_init=0A=
801e4d8c g     F .text	00000000 vtop=0A=
8021e050 g     O .data	0000002c e802_table=0A=
801ff460 g     O __ksymtab	00000008 __ksymtab_remap_page_range=0A=
801ffa98 g     O __ksymtab	00000008 __ksymtab_unregister_binfmt=0A=
801a17a0 g     F .text	00000000 skb_over_panic=0A=
801fcc80 g     O .kstrtab	00000009 __kstrtab_put_cmsg=0A=
8031ec8c g     O .bss	00000004 nr_inactive_pages=0A=
801815f0 g     F .text	00000000 ieee754sp_sub=0A=
801fb004 g     O .kstrtab	00000005 __kstrtab_fget=0A=
8020f59c g     F .text.init	00000000 prom_printf=0A=
801fbb7c g     O .kstrtab	0000000e __kstrtab_compute_creds=0A=
8010a660 g     F .text	00000014 spurious_interrupt=0A=
801c9048 g     F .text	00000000 tcp_send_fin=0A=
80147440 g     F .text	00000000 kern_mount=0A=
801fcbd4 g     O .kstrtab	00000017 __kstrtab_skb_copy_and_csum_bits=0A=
8021dbb0 g     O .data	00000450 neigh_sysctl_template=0A=
801ccf0c g     F .text	00000000 tcp_v4_err=0A=
80141aa4 g     F .text	00000000 sys_fsync=0A=
80141f38 g     F .text	00000000 buffer_insert_inode_queue=0A=
80335320 g     O .bss	00000100 icmp_statistics=0A=
801fb6c0 g     O .kstrtab	0000000b __kstrtab_vfs_statfs=0A=
8010dd30 g     F .text	00000000 probe_irq_mask=0A=
801ff930 g     O __ksymtab	00000008 __ksymtab_filemap_sync=0A=
801e7830 g     F .text	00000000 prom_getenv=0A=
802005f0 g     O __ksymtab	00000008 __ksymtab_alloc_skb=0A=
8021ac00 g     O .data	00000048 read_fifo_fops=0A=
8021e22c g     O .data	00000004 ip_rt_mtu_expires=0A=
801fcef8 g     O .kstrtab	00000012 __kstrtab_inet_del_protocol=0A=
80197940 g     F .text	00000000 blk_get_queue=0A=
801fb5a4 g     O .kstrtab	00000015 __kstrtab_locks_mandatory_area=0A=
801fc8d4 g     O .kstrtab	0000000c __kstrtab___lock_sock=0A=
801245d0 g     F .text	00000000 ptrace_writedata=0A=
8021e204 g     O .data	00000004 ip_rt_max_delay=0A=
8011c648 g     F .text	00000000 sys_init_module=0A=
80334cdc g     O .bss	00000004 tcp_memory_pressure=0A=
801fb108 g     O .kstrtab	0000000d __kstrtab_d_invalidate=0A=
801fbf64 g     O .kstrtab	00000009 __kstrtab_schedule=0A=
801fa8ec g     O .kstrtab	00000013 __kstrtab__flush_page_to_ram=0A=
801572c0 g     F .text	00000000 d_validate=0A=
802002d8 g     O __ksymtab	00000008 __ksymtab_put_cmsg=0A=
801fcff4 g     O .kstrtab	00000010 __kstrtab_ip_mc_inc_group=0A=
80147d64 g     F .text	00000000 bd_acquire=0A=
801a9038 g     F .text	00000000 neigh_rand_reach_time=0A=
801e48b0 g     F .text	00000000 dump_tlb=0A=
801e7dbc g     F .text	00000000 idisx_reboot_setup=0A=
80219528 g     O .data	00000004 module_list=0A=
802043a4 g     F .text.init	00000000 init_generic_irq=0A=
8021d8a0 g     O .data	00000004 sysctl_wmem_max=0A=
801fc7cc g     O .kstrtab	0000000c __kstrtab_add_gendisk=0A=
802005a8 g     O __ksymtab	00000008 __ksymtab_netdev_state_change=0A=
801cf904 g     F .text	00000000 tcp_v4_remember_stamp=0A=
801fb564 g     O .kstrtab	00000011 __kstrtab_posix_block_lock=0A=
8013f910 g     F .text	00000000 sys_open=0A=
801ff5d8 g     O __ksymtab	00000008 __ksymtab_get_empty_filp=0A=
801847f0 g     F .text	00000000 fpu_emulator_init_fpu=0A=
801ff100 g     O __ksymtab	00000008 __ksymtab_strstr=0A=
80200458 g     O __ksymtab	00000008 __ksymtab_ip_send_check=0A=
80200588 g     O __ksymtab	00000008 =
__ksymtab_unregister_netdevice_notifier=0A=
801466f4 g     F .text	00000000 get_unnamed_dev=0A=
801ff248 g     O __ksymtab	00000008 __ksymtab_printk=0A=
801fbfa4 g     O .kstrtab	00000010 __kstrtab_do_settimeofday=0A=
801e7fc0 g     F .text	00000000 dummy_handler=0A=
802205a4 g     O .data	00000004 dummy_context=0A=
80127d6c g     F .text	00000000 sys_ssetmask=0A=
8020b7b8 g     F .text.init	00000000 initrd_load=0A=
801ffa08 g     O __ksymtab	00000008 __ksymtab_tq_disk=0A=
80316414 g     O .bss	00000004 zero_page_mask=0A=
801ffb08 g     O __ksymtab	00000008 __ksymtab_proc_dointvec_minmax=0A=
8021a7d0 g     O .data	00000008 shmem_inodes=0A=
8010bef0 g     F .text	00000000 r3081_wait=0A=
803340a8 g     O .bss	00000004 initrd_start=0A=
80108500 g     F .text	00000000 __compute_return_epc=0A=
801ff830 g     O __ksymtab	00000008 __ksymtab_vfs_symlink=0A=
8021366c g     F .data	00000000 handle_cpu_int=0A=
801fd3f8 g     O .kstrtab	0000000e __kstrtab_dev_base_lock=0A=
801dd9b0 g     F .text	00000000 free_fib_info=0A=
80200290 g     O __ksymtab	00000008 __ksymtab_skb_copy_and_csum_bits=0A=
8010a510 g     O .text	00000000 ret_from_exception=0A=
801fd35c g     O .kstrtab	00000009 __kstrtab_netif_rx=0A=
801fc45c g     O .kstrtab	00000012 __kstrtab_generic_file_open=0A=
803210f0 g     O .bss	0000001c fpuemuprivate=0A=
801ff6e0 g     O __ksymtab	00000008 __ksymtab___wait_on_buffer=0A=
801ff578 g     O __ksymtab	00000008 __ksymtab_d_validate=0A=
80182450 g     F .text	00000000 ieee754sp_cmp=0A=
8021d8a4 g     O .data	00000004 sysctl_rmem_max=0A=
801429e0 g     F .text	00000000 getblk=0A=
801fcfec g     O .kstrtab	00000008 __kstrtab_in_aton=0A=
8021f1e0 g     O .data	00000044 inet_stream_ops=0A=
80104000 g     O .text	00000000 invalid_pte_table=0A=
802004a8 g     O __ksymtab	00000008 __ksymtab_inet_addr_type=0A=
80135968 g     F .text	00000000 vread=0A=
80200088 g     O __ksymtab	00000008 __ksymtab_blkdev_release_request=0A=
801ff3d0 g     O __ksymtab	00000008 __ksymtab_alloc_pages_node=0A=
80148000 g     F .text	00000000 unregister_blkdev=0A=
801ffa20 g     O __ksymtab	00000008 __ksymtab_max_sectors=0A=
801fc040 g     O .kstrtab	0000000f __kstrtab_simple_strtoul=0A=
801256ec g     F .text	00000000 sys_alarm=0A=
8013c2e8 g     F .text	00000000 si_swapinfo=0A=
80169cc0 g     F .text	00000000 ext2_discard_prealloc=0A=
8021a290 g     O .data	00000040 protection_map=0A=
8012803c g     F .text	00000000 unregister_reboot_notifier=0A=
80125c60 g     F .text	00000000 flush_signals=0A=
801fb474 g     O .kstrtab	00000012 __kstrtab_generic_file_read=0A=
8012d5b0 g     F .text	00000000 do_mmap_pgoff=0A=
80197f18 g     F .text	00000000 blk_ioctl=0A=
8019f34c g     F .text	00000000 sys_send=0A=
8021e818 g     O .data	00000004 sysctl_tcp_syncookies=0A=
801ff610 g     O __ksymtab	00000008 __ksymtab___invalidate_buffers=0A=
801ff158 g     O __ksymtab	00000008 __ksymtab___strnlen_user_asm=0A=
801ff258 g     O __ksymtab	00000008 __ksymtab_console_print=0A=
80120ee8 g     F .text	00000000 tasklet_kill=0A=
801fc2b4 g     O .kstrtab	0000000e __kstrtab_fasync_helper=0A=
8021db74 g     O .data	00000004 lo_cong=0A=
801fc4b8 g     O .kstrtab	0000000c __kstrtab_set_bh_page=0A=
801b7be4 g     F .text	00000000 ip_recv_error=0A=
801ffe10 g     O __ksymtab	00000008 __ksymtab_insert_inode_hash=0A=
8021e5dc g     O .data	00000004 inet_peer_threshold=0A=
8021376c g     F .data	00000000 handle_ov_int=0A=
801e4ec8 g     F .text	00000000 strcat=0A=
803164d8 g     O .bss	00000004 _dma_cache_inv=0A=
8010fd5c g     F .text	000000a0 r4k_copy_page_s32=0A=
80162be0 g     F .text	00000000 proc_mknod=0A=
801a5b00 g     F .text	00000000 dev_open=0A=
80130624 g     F .text	00000000 mark_page_accessed=0A=
80200328 g     O __ksymtab	00000008 __ksymtab___neigh_event_send=0A=
801ff280 g     O __ksymtab	00000008 __ksymtab_flush_signals=0A=
801d5ba4 g     F .text	00000000 arp_bind_neighbour=0A=
801ff828 g     O __ksymtab	00000008 __ksymtab_vfs_mknod=0A=
80173a4c g     F .text	00000000 ipc_addid=0A=
80174c34 g     F .text	00000000 sys_msgsnd=0A=
801b9140 g     F .text	00000000 __tcp_mem_reclaim=0A=
8031d380 g     O .bss	00000020 irq_stat=0A=
801454f8 g     F .text	00000000 show_buffers=0A=
801fff68 g     O __ksymtab	00000008 __ksymtab_try_to_free_buffers=0A=
801fb9ec g     O .kstrtab	0000000b __kstrtab_blkdev_put=0A=
80218f4c g     O .data	00000004 kstack_depth_to_print=0A=
80205d14 g     F .text.init	00000000 fork_init=0A=
801ff448 g     O __ksymtab	00000008 __ksymtab_vfree=0A=
8031d368 g     O .bss	00000008 sys_tz=0A=
801ac508 g     F .text	00000000 make_8023_client=0A=
801fd1a0 g     O .kstrtab	00000012 __kstrtab_move_addr_to_user=0A=
801fc578 g     O .kstrtab	00000009 __kstrtab_proc_net=0A=
8013000c g     F .text	00000000 find_trylock_page=0A=
80139db4 g     F .text	00000000 nr_free_pages=0A=
801fd068 g     O .kstrtab	00000011 __kstrtab_inet_select_addr=0A=
8021fcb0 g     O .data	00000004 sysctl_unix_max_dgram_qlen=0A=
801ffc20 g     O __ksymtab	00000008 __ksymtab___check_region=0A=
801a1390 g     F .text	00000000 sock_no_shutdown=0A=
801a82fc g     F .text	00000000 dev_mc_delete=0A=
8011eda4 g     F .text	00000000 exit_mm=0A=
801fb554 g     O .kstrtab	00000010 __kstrtab_posix_test_lock=0A=
8010f9ac g     F .text	000000a8 r4k_copy_page_d16=0A=
80200658 g     O __ksymtab	00000008 __ksymtab_dev_queue_xmit=0A=
801222a4 g     F .text	00000000 proc_dostring=0A=
801fb690 g     O .kstrtab	00000009 __kstrtab_vfs_link=0A=
801fb44c g     O .kstrtab	00000013 __kstrtab_generic_block_bmap=0A=
8021ab18 g     O .data	00000000 sb_lock=0A=
801ff268 g     O __ksymtab	00000008 __ksymtab_register_console=0A=
801a0c30 g     F .text	00000000 sock_kfree_s=0A=
801fcfc0 g     O .kstrtab	0000000e __kstrtab_ip_send_check=0A=
8021a4b4 g     O .data	00000310 contig_page_data=0A=
80316048 g     O .bss	00000004 cols=0A=
8021d690 g     O .data	00000130 loopback_dev=0A=
802003e8 g     O __ksymtab	00000008 __ksymtab_scm_detach_fds=0A=
801fcd34 g     O .kstrtab	00000013 __kstrtab___neigh_event_send=0A=
8016ddf4 g     F .text	00000000 ext2_remount=0A=
8011c3a8 g     F .text	00000000 inter_module_put=0A=
801a5944 g     F .text	00000000 dev_alloc=0A=
8013dd30 g     F .text	00000000 shmem_file_setup=0A=
801facc8 g     O .kstrtab	00000014 __kstrtab_exec_usermodehelper=0A=
80142c9c g     F .text	00000000 __brelse=0A=
80334ae0 g     O .bss	000000c0 ip_statistics=0A=
801fd568 g     O .kstrtab	0000000d __kstrtab___down_write=0A=
801ff238 g     O __ksymtab	00000008 __ksymtab_abi_traceflg=0A=
801fa810 g     O .kstrtab	0000000c __kstrtab__clear_page=0A=
801e79b8 g     F .text	00000000 idisx_display_word=0A=
801737c8 g     F .text	00000000 devpts_pty_new=0A=
80219534 g     O .data	00000010 ksyms_op=0A=
80181b70 g     F .text	00000000 ieee754sp_add=0A=
8021e66c g     O .data	00000004 ip_frag_nqueues=0A=
802091c4 g     F .text.init	00000000 ipc_init=0A=
8017b1e4 g     F .text	00000000 ieee754dp_nanxcpt=0A=
80121520 g     F .text	00000000 check_resource=0A=
801ffe48 g     O __ksymtab	00000008 __ksymtab_fs_overflowuid=0A=
8011f13c g     F .text	00000000 do_exit=0A=
801e4a88 g     F .text	00000000 dump_tlb_addr=0A=
801fca50 g     O .kstrtab	0000000f __kstrtab_sock_no_listen=0A=
80318e98 g     O .bss	00000004 panic_timeout=0A=
8019ef94 g     F .text	00000000 sys_accept=0A=
8010eb68 g     F .text	00000000 show_mem=0A=
801a56f0 g     F .text	00000000 __dev_get_by_index=0A=
80127e4c g     F .text	00000000 kill_proc_info=0A=
8021ad20 g     O .data	00000048 write_pipe_fops=0A=
80108b60 g     F .text	00000000 dump_thread=0A=
80211840 g     O .data.cacheline_aligned	00000020 tasklet_hi_vec=0A=
8031ec00 g     O .bss	00000004 highmem_start_page=0A=
8013a240 g     F .text	00000000 __delete_from_swap_cache=0A=
801209b4 g     F .text	00000000 raise_softirq=0A=
80152148 g     F .text	00000000 sys_getdents64=0A=
801fcd24 g     O .kstrtab	0000000d __kstrtab_neigh_lookup=0A=
801fcd48 g     O .kstrtab	0000000f __kstrtab_neigh_event_ns=0A=
801fbf18 g     O .kstrtab	00000011 __kstrtab_sleep_on_timeout=0A=
801fbd40 g     O .kstrtab	0000000e __kstrtab_probe_irq_off=0A=
8020889c g     F .text.init	00000000 mnt_init=0A=
801d4d80 g     F .text	00000000 udp_rcv=0A=
80131194 g     F .text	00000000 sys_sendfile=0A=
80141f7c g     F .text	00000000 buffer_insert_inode_data_queue=0A=
801ffbf8 g     O __ksymtab	00000008 __ksymtab_request_resource=0A=
801fc4c4 g     O .kstrtab	00000015 __kstrtab_create_empty_buffers=0A=
8010a510 g     F .text	00000000 ret_from_irq=0A=
801fbcb8 g     O .kstrtab	00000009 __kstrtab_free_irq=0A=
80166830 g     F .text	00000000 msdos_partition=0A=
80140f58 g     F .text	00000000 fput=0A=
801fd0b4 g     O .kstrtab	0000000a __kstrtab_ip_defrag=0A=
801ff650 g     O __ksymtab	00000008 __ksymtab_permission=0A=
801b418c g     F .text	00000000 ip_options_fragment=0A=
801ff368 g     O __ksymtab	00000008 __ksymtab_inter_module_get=0A=
801a14a8 g     F .text	00000000 sock_def_wakeup=0A=
801db358 g     F .text	00000000 inet_accept=0A=
8014d590 g     F .text	00000000 __user_walk=0A=
801ff880 g     O __ksymtab	00000008 __ksymtab_poll_freewait=0A=
803340ac g     O .bss	00000004 initrd_end=0A=
801ff0c8 g     O __ksymtab	00000008 __ksymtab_strcat=0A=
80121274 g     F .text	00000000 cpu_raise_softirq=0A=
8021acd8 g     O .data	00000048 read_pipe_fops=0A=
80139664 g     F .text	00000000 _alloc_pages=0A=
801fb644 g     O .kstrtab	0000000a __kstrtab_is_subdir=0A=
801ff508 g     O __ksymtab	00000008 __ksymtab_follow_up=0A=
80200688 g     O __ksymtab	00000008 __ksymtab_dev_mc_upload=0A=
80156af8 g     F .text	00000000 shrink_dcache_sb=0A=
801fc0d4 g     O .kstrtab	0000000b __kstrtab_securebits=0A=
801fbe3c g     O .kstrtab	00000011 __kstrtab_release_resource=0A=
8021e0c0 g     O .data	00000060 noop_qdisc=0A=
8014c140 g     F .text	00000000 path_release=0A=
80200400 g     O __ksymtab	00000008 __ksymtab_inet_del_protocol=0A=
8021cc64 g     O .data	0000001c none_funcs=0A=
801fce94 g     O .kstrtab	00000016 __kstrtab_sklist_destroy_socket=0A=
80211980 g     O .data.cacheline_aligned	00000020 softnet_data=0A=
801b6df4 g     F .text	00000000 ip_send_reply=0A=
8032114c g     O .bss	00000004 redirect=0A=
80140b74 g     F .text	00000000 chrdev_open=0A=
801fd290 g     O .kstrtab	0000000e __kstrtab_dev_new_index=0A=
80155dac g     F .text	00000000 locks_remove_flock=0A=
801facb0 g     O .kstrtab	0000000b __kstrtab_in_group_p=0A=
8011dc28 g     F .text	00000000 sys_get_kernel_syms=0A=
803164a0 g     O .bss	00000004 _clear_page=0A=
801e7164 g     F .text	00000000 __up_write=0A=
8012fdfc g     F .text	00000000 unlock_page=0A=
801ffba0 g     O __ksymtab	00000008 __ksymtab_free_kiovec=0A=
801ceb74 g     F .text	00000000 tcp_v4_do_rcv=0A=
8013f370 g     F .text	00000000 sys_chown=0A=
80320a00 g     O .bss	00000004 proc_mnt=0A=
801fc088 g     O .kstrtab	00000012 __kstrtab_machine_power_off=0A=
80134780 g     F .text	00000000 sys_munlock=0A=
8010f18c g     F .text	00000000 __ioremap=0A=
80145ec0 g     F .text	00000000 get_filesystem_list=0A=
802003c8 g     O __ksymtab	00000008 __ksymtab_files_stat=0A=
8012f6b4 g     F .text	00000000 fail_writepage=0A=
8031ec88 g     O .bss	00000004 nr_active_pages=0A=
801ff3f8 g     O __ksymtab	00000008 __ksymtab_free_pages=0A=
8021aba0 g     O .data	00000048 def_blk_fops=0A=
801e7104 g     F .text	00000000 __up_read=0A=
80219490 g     O .data	00000004 minimum_console_loglevel=0A=
8010bf08 g     F .text	00000000 r39xx_wait=0A=
80148c5c g     F .text	00000000 sys_lstat=0A=
8020fdcc g     O .data.init	00000004 ic_set_manually=0A=
801b7960 g     F .text	00000000 ip_local_error=0A=
801fd0dc g     O .kstrtab	0000001b =
__kstrtab_register_inetaddr_notifier=0A=
801ffa28 g     O __ksymtab	00000008 __ksymtab_max_readahead=0A=
801fc4fc g     O .kstrtab	0000000e __kstrtab_proc_sys_root=0A=
801d0ba4 g     F .text	00000000 tcp_timewait_state_process=0A=
80166f08 g     F .text	00000000 ext2_free_blocks=0A=
801ffaf0 g     O __ksymtab	00000008 __ksymtab_proc_dostring=0A=
801d23d4 g     F .text	00000000 raw_v4_input=0A=
8011bc5c g     F .text	00000000 console_conditional_schedule=0A=
8014a0c4 g     F .text	00000000 prepare_binprm=0A=
801291e4 g     F .text	00000000 sys_times=0A=
801d2e80 g     F .text	00000000 raw_recvmsg=0A=
801ff338 g     O __ksymtab	00000008 __ksymtab_call_usermodehelper=0A=
8021a990 g     O .data	00000048 generic_ro_fops=0A=
801fced4 g     O .kstrtab	0000000d __kstrtab_inetdev_lock=0A=
801a1004 g     F .text	00000000 __release_sock=0A=
80123418 g     F .text	00000000 proc_doulongvec_ms_jiffies_minmax=0A=
8021955c g     O .data	00000004 pps_stabil=0A=
80118950 g     F .text	00000000 sys_sched_yield=0A=
80147e24 g     F .text	00000000 bd_forget=0A=
801fd308 g     O .kstrtab	00000012 __kstrtab_netdev_set_master=0A=
801169b0 g     F .text	00000000 local_flush_tlb_all=0A=
80120840 g     F .text	00000000 do_softirq=0A=
801e5320 g     F .text	00000000 memchr=0A=
801fbf94 g     O .kstrtab	00000010 __kstrtab_do_gettimeofday=0A=
8021bb18 g     O .data	00000048 ext2_dir_operations=0A=
801ff330 g     O __ksymtab	00000008 __ksymtab_exec_usermodehelper=0A=
801fd498 g     O .kstrtab	0000000e __kstrtab_qdisc_destroy=0A=
801fc974 g     O .kstrtab	0000000d __kstrtab_sock_recvmsg=0A=
801400d0 g     F .text	00000000 sys_write=0A=
8010e1e0 g     F .text	00000000 disable_8259A_irq=0A=
8011b494 g     F .text	00000000 sys_syslog=0A=
80185c5c g     F .text	00000000 tty_vhangup=0A=
80197224 g     F .text	00000000 generic_make_request=0A=
801fb340 g     O .kstrtab	00000009 __kstrtab___brelse=0A=
80150a70 g     F .text	00000000 sys_dup2=0A=
801ff520 g     O __ksymtab	00000008 __ksymtab_path_init=0A=
8015897c g     F .text	00000000 generic_osync_inode=0A=
801fb58c g     O .kstrtab	00000015 __kstrtab_posix_locks_deadlock=0A=
80148ebc g     F .text	00000000 sys_readlink=0A=
80123724 g     F .text	00000000 sysctl_jiffies=0A=
8021fca0 g     O .data	00000004 ic_nameserver=0A=
801fb380 g     O .kstrtab	00000011 __kstrtab___wait_on_buffer=0A=
801fca10 g     O .kstrtab	0000000f __kstrtab_sock_no_accept=0A=
80316140 g     O .bss	00000020 cpu_data=0A=
8021a0a8 g     O .data	00000004 time_precision=0A=
801ffbb8 g     O __ksymtab	00000008 __ksymtab_unmap_kiobuf=0A=
8013d910 g     F .text	00000000 shmem_nopage=0A=
8012475c g     F .text	00000000 add_timer=0A=
8013da78 g     F .text	00000000 shmem_get_inode=0A=
801ffae0 g     O __ksymtab	00000008 __ksymtab_sysctl_intvec=0A=
801fb4c8 g     O .kstrtab	00000010 __kstrtab_generic_ro_fops=0A=
801fc6d4 g     O .kstrtab	00000017 __kstrtab_end_that_request_first=0A=
801fafec g     O .kstrtab	0000000d __kstrtab_names_cachep=0A=
8019f258 g     F .text	00000000 sys_sendto=0A=
8017e040 g     F .text	00000000 ieee754dp_add=0A=
8016b02c g     F .text	00000000 ext2_read_inode=0A=
8021e28c g     O .data	00000318 ipv4_route_table=0A=
801ff8e8 g     O __ksymtab	00000008 __ksymtab_vfs_readdir=0A=
801d460c g     F .text	00000000 udp_connect=0A=
8031d350 g     O .bss	00000004 pps_offset=0A=
8021c1d0 g     O .data	00000004 msg_ctlmax=0A=
801fd414 g     O .kstrtab	0000000b __kstrtab_dev_mc_add=0A=
801ff228 g     O __ksymtab	00000008 __ksymtab_abi_defhandler_lcall7=0A=
801fc9cc g     O .kstrtab	00000010 __kstrtab_sock_no_release=0A=
801acd2c g     F .text	00000000 qdisc_create_dflt=0A=
80316418 g     O .bss	0000007c mmu_gathers=0A=
80146270 g     F .text	00000000 get_super=0A=
802003c0 g     O __ksymtab	00000008 __ksymtab_scm_fp_dup=0A=
801ffda8 g     O __ksymtab	00000008 __ksymtab_kernel_read=0A=
8031d358 g     O .bss	00000004 pps_jitcnt=0A=
8021f2e0 g     O .data	00000004 sysctl_igmp_max_memberships=0A=
801ff9c0 g     O __ksymtab	00000008 __ksymtab_bmap=0A=
80209308 g     F .text.init	00000000 sem_init=0A=
8021e8f0 g     O .data	00000084 udp_prot=0A=
80103000 g     O .text	00000000 empty_bad_page_table=0A=
80180900 g     F .text	00000000 ieee754sp_modf=0A=
80200370 g     O __ksymtab	00000008 __ksymtab_neigh_rand_reach_time=0A=
8018f8ac g     F .text	00000000 generate_random_uuid=0A=
801248f8 g     F .text	00000000 mod_timer=0A=
80152220 g     F .text	00000000 poll_freewait=0A=
8012a8ac g     F .text	00000000 call_usermodehelper=0A=
80335624 g     O .bss	00000004 inet_ifa_count=0A=
80334cd4 g     O .bss	00000004 tcp_memory_allocated=0A=
80120ed0 g     F .text	00000000 tasklet_init=0A=
80200250 g     O __ksymtab	00000008 __ksymtab_skb_checksum=0A=
801fccec g     O .kstrtab	00000017 __kstrtab_neigh_connected_output=0A=
801ffcc8 g     O __ksymtab	00000008 __ksymtab_panic=0A=
801a536c g     F .text	00000000 dev_remove_pack=0A=
8021e6a0 g     O .data	00000004 sysctl_tcp_fin_timeout=0A=
801fd4a8 g     O .kstrtab	0000000c __kstrtab_qdisc_reset=0A=
80187bb0 g     F .text	00000000 tty_ioctl=0A=
801ff418 g     O __ksymtab	00000008 __ksymtab_kmem_cache_destroy=0A=
80147f5c g     F .text	00000000 register_blkdev=0A=
8010df78 g     F .text	00000000 setup_irq=0A=
80161c58 g     F .text	00000000 proc_pid_lookup=0A=
801fb514 g     O .kstrtab	0000000f __kstrtab_file_lock_list=0A=
803192a4 g     O .bss	00000004 console_drivers=0A=
801fcaac g     O .kstrtab	00000010 __kstrtab_sock_no_recvmsg=0A=
803208b8 g     O .bss	00000004 dquot_cachep=0A=
8013b834 g     F .text	00000000 get_swaparea_info=0A=
80100000 g     O .text	00000000 _ftext=0A=
80125d28 g     F .text	00000000 flush_signal_handlers=0A=
801fb534 g     O .kstrtab	00000010 __kstrtab_locks_copy_lock=0A=
801fc034 g     O .kstrtab	00000009 __kstrtab_cdevname=0A=
801fd220 g     O .kstrtab	0000001e =
__kstrtab_unregister_netdevice_notifier=0A=
801b1cd0 g     F .text	00000000 inet_add_protocol=0A=
8019f130 g     F .text	00000000 sys_getsockname=0A=
801fc904 g     O .kstrtab	00000015 __kstrtab_memcpy_tokerneliovec=0A=
801fbc58 g     O .kstrtab	00000022 =
__kstrtab_proc_doulongvec_ms_jiffies_minmax=0A=
8010bbf0 g     F .text	00000000 sys_vm86=0A=
801fb7a4 g     O .kstrtab	0000000e __kstrtab_page_readlink=0A=
801fbf44 g     O .kstrtab	0000001f =
__kstrtab_interruptible_sleep_on_timeout=0A=
801db670 g     F .text	00000000 inet_shutdown=0A=
801d5c60 g     F .text	00000000 arp_send=0A=
80126cd0 g     F .text	00000000 kill_sl=0A=
801a5724 g     F .text	00000000 dev_get_by_index=0A=
801fba9c g     O .kstrtab	0000000e __kstrtab_tty_hung_up_p=0A=
8021e758 g     O .data	00000030 ipv4_specific=0A=
801b9468 g     F .text	00000000 tcp_ioctl=0A=
80335e18 g     O .bss	00000004 prom_envp=0A=
802055a8 g     F .text.init	00000000 temp_set_aside_tlb=0A=
8019032c g     F .text	00000000 serial_icr_write=0A=
80200650 g     O __ksymtab	00000008 __ksymtab_dev_ioctl=0A=
801a096c g     F .text	00000000 sk_free=0A=
80200048 g     O __ksymtab	00000008 __ksymtab_end_that_request_first=0A=
801fd52c g     O .kstrtab	00000009 __kstrtab_memparse=0A=
801e5288 g     F .text	00000000 strstr=0A=
8018f118 g     F .text	00000000 rand_initialize_blkdev=0A=
801faab8 g     O .kstrtab	0000000d __kstrtab_abi_traceflg=0A=
8019eab8 g     F .text	00000000 sock_wake_async=0A=
8010a564 g     F .text	00000000 restore_all=0A=
8021e5b0 g     O .data	00000000 inet_peer_idlock=0A=
80200258 g     O __ksymtab	00000008 __ksymtab_skb_checksum_help=0A=
801fb230 g     O .kstrtab	00000012 __kstrtab_invalidate_inodes=0A=
8021cbc0 g     O .data	00000004 rd_size=0A=
801ff438 g     O __ksymtab	00000008 __ksymtab_kmalloc=0A=
80200578 g     O __ksymtab	00000008 __ksymtab_arp_find=0A=
80200180 g     O __ksymtab	00000008 __ksymtab_sk_alloc=0A=
8021306c g     F .data	00000000 handle_adel_int=0A=
801ff998 g     O __ksymtab	00000008 __ksymtab_hardsect_size=0A=
801a1368 g     F .text	00000000 sock_no_accept=0A=
8017f110 g     F .text	00000000 ieee754dp_scalb=0A=
801ffb20 g     O __ksymtab	00000008 __ksymtab_add_timer=0A=
801ff548 g     O __ksymtab	00000008 __ksymtab_lookup_hash=0A=
801989e8 g     F .text	00000000 bh_rq_in_between=0A=
801faac8 g     O .kstrtab	00000011 __kstrtab_abi_fake_utsname=0A=
801ffd30 g     O __ksymtab	00000008 __ksymtab_machine_restart=0A=
8013aaa0 g     F .text	00000000 can_share_swap_page=0A=
801ff188 g     O __ksymtab	00000008 __ksymtab___down_interruptible=0A=
8031d764 g     O .bss	00000004 time_adjust_step=0A=
801a5c08 g     F .text	00000000 dev_close=0A=
801fc4f0 g     O .kstrtab	0000000a __kstrtab_bh_cachep=0A=
801fc32c g     O .kstrtab	0000000c __kstrtab_tasklet_vec=0A=
801ff128 g     O __ksymtab	00000008 __ksymtab___bzero=0A=
8021af00 g     O .data	00000000 dcache_lock=0A=
801e4600 g     F .text	00000054 __rmemcpy=0A=
801ff530 g     O __ksymtab	00000008 __ksymtab_path_release=0A=
801fb544 g     O .kstrtab	00000010 __kstrtab_posix_lock_file=0A=
8019011c g     F .text	00000000 secure_tcp_sequence_number=0A=
8011f454 g     F .text	00000000 sys_wait4=0A=
801fa7b0 g     O .kstrtab	00000008 __kstrtab_memmove=0A=
8031ebf4 g     O .bss	00000004 num_physpages=0A=
801412d0 g     F .text	00000000 __wait_on_buffer=0A=
801ff580 g     O __ksymtab	00000008 __ksymtab_d_rehash=0A=
80205eb8 g     F .text.init	00000000 console_setup=0A=
8019dbf4 g     F .text	00000000 autoirq_report=0A=
801ff260 g     O __ksymtab	00000008 __ksymtab_console_unblank=0A=
801ff710 g     O __ksymtab	00000008 __ksymtab_block_sync_page=0A=
8010ccb0 g     F .text	00000014 sys_sysmips=0A=
801ff208 g     O __ksymtab	00000008 __ksymtab_unregister_exec_domain=0A=
8010ae60 g     F .text	00000000 do_fpe=0A=
801ff9a0 g     O __ksymtab	00000008 __ksymtab_blk_size=0A=
8021e6e8 g     O .data	00000004 sysctl_tcp_dsack=0A=
801faaf8 g     O .kstrtab	0000000e __kstrtab_console_print=0A=
801fc34c g     O .kstrtab	0000000a __kstrtab_remove_bh=0A=
80202000 g     O *ABS*	00000000 __init_begin=0A=
80136d5c g     F .text	00000000 kmem_cache_free=0A=
8021e6fc g     O .data	00000004 sysctl_tcp_max_orphans=0A=
801fcd80 g     O .kstrtab	0000000e __kstrtab_pneigh_lookup=0A=
801ffbd0 g     O __ksymtab	00000008 __ksymtab_brw_kiovec=0A=
801fbc94 g     O .kstrtab	0000000a __kstrtab_add_timer=0A=
8017bd30 g     F .text	00000000 ieee754sp_bestnan=0A=
8017aae0 g     F .text	00000000 ieee754dp_trunc=0A=
80180728 g     F .text	00000000 ieee754dp_fulong=0A=
801fbecc g     O .kstrtab	00000012 __kstrtab_complete_and_exit=0A=
801a6bec g     F .text	00000000 register_gifconf=0A=
80200268 g     O __ksymtab	00000008 __ksymtab_skb_free_datagram=0A=
801fbad8 g     O .kstrtab	00000007 __kstrtab_do_SAK=0A=
80212d00 g     O .data	00000004 root_mountflags=0A=
801a1388 g     F .text	00000000 sock_no_listen=0A=
80123650 g     F .text	00000000 sysctl_intvec=0A=
80200278 g     O __ksymtab	00000008 =
__ksymtab_skb_copy_datagram_iovec=0A=
801ffc98 g     O __ksymtab	00000008 __ksymtab_xtime=0A=
8015a318 g     F .text	00000000 alloc_fdset=0A=
801fcf50 g     O .kstrtab	0000000f __kstrtab_ip_route_input=0A=
801ff140 g     O __ksymtab	00000008 =
__ksymtab___strlen_user_nocheck_asm=0A=
8021e668 g     O .data	00000004 sysctl_ipfrag_time=0A=
801fb0e4 g     O .kstrtab	0000000c __kstrtab_dget_locked=0A=
801fc3a8 g     O .kstrtab	00000012 __kstrtab_cpu_raise_softirq=0A=
802135a0 g     F .data	000000f4 handle_cpu=0A=
801cc070 g     F .text	00000000 tcp_put_port=0A=
80318a70 g     O .bss	00000004 abi_fake_utsname=0A=
8031d364 g     O .bss	00000004 pps_stbcnt=0A=
801fbfe0 g     O .kstrtab	00000008 __kstrtab_sprintf=0A=
8014f32c g     F .text	00000000 vfs_rename_dir=0A=
801fc15c g     O .kstrtab	0000000c __kstrtab_kernel_read=0A=
80159730 g     F .text	00000000 insert_inode_hash=0A=
80200298 g     O __ksymtab	00000008 __ksymtab_skb_copy_and_csum_dev=0A=
80200228 g     O __ksymtab	00000008 __ksymtab_sock_rfree=0A=
8017bddc g     F .text	00000000 ieee754sp_format=0A=
802131a0 g     F .data	000000f4 handle_ibe=0A=
801fae6c g     O .kstrtab	0000000d __kstrtab___free_pages=0A=
801fd55c g     O .kstrtab	0000000c __kstrtab___down_read=0A=
801ab3e4 g     F .text	00000000 neigh_connected_output=0A=
80157504 g     F .text	00000000 d_move=0A=
80218f54 g     O .data	00000000 die_lock=0A=
80206428 g     F .text.init	00000000 page_cache_init=0A=
80335430 g     O .bss	000001d8 icmp_inode=0A=
8016e910 g     F .text	00000000 autofs_say=0A=
8021d7c0 g     O .data	00000004 dev_base=0A=
801faa0c g     O .kstrtab	0000000f __kstrtab__dma_cache_inv=0A=
801fb120 g     O .kstrtab	0000000e __kstrtab_d_instantiate=0A=
801ff858 g     O __ksymtab	00000008 __ksymtab_vfs_statfs=0A=
801fd550 g     O .kstrtab	0000000b __kstrtab_init_rwsem=0A=
801ffcd8 g     O __ksymtab	00000008 __ksymtab_snprintf=0A=
802191d0 g     O .data	00000000 dma_spin_lock=0A=
8021a0bc g     O .data	00000000 xtime_lock=0A=
8010fbb4 g     F .text	00000100 r4k_copy_page_r4600_v2=0A=
80151398 g     F .text	00000000 fasync_helper=0A=
8019d97c g     F .text	00000000 register_netdev=0A=
801fc7b0 g     O .kstrtab	0000000a __kstrtab_blk_ioctl=0A=
801233ec g     F .text	00000000 proc_doulongvec_minmax=0A=
801fc808 g     O .kstrtab	00000019 =
__kstrtab_loop_unregister_transfer=0A=
801ff5e0 g     O __ksymtab	00000008 __ksymtab_init_private_file=0A=
801ff838 g     O __ksymtab	00000008 __ksymtab_vfs_link=0A=
801fca40 g     O .kstrtab	0000000e __kstrtab_sock_no_ioctl=0A=
8016e6d4 g     F .text	00000000 autofs_hash_enum=0A=
801fb2e0 g     O .kstrtab	00000010 __kstrtab_write_inode_now=0A=
803209f0 g     O .bss	00000004 nr_dquots=0A=
8020aaf8 g     F .text.init	00000000 serial_console_init=0A=
801ff1b0 g     O __ksymtab	00000008 __ksymtab_reset_mqb_handler=0A=
801ff6f8 g     O __ksymtab	00000008 __ksymtab_block_write_full_page=0A=
80149714 g     F .text	00000000 copy_strings_kernel=0A=
8011da30 g     F .text	00000000 sys_query_module=0A=
80200030 g     O __ksymtab	00000008 __ksymtab_register_serial=0A=
801e6e84 g     F .text	00000000 rb_erase=0A=
80129b14 g     F .text	00000000 getrusage=0A=
801ff8b8 g     O __ksymtab	00000008 __ksymtab_vfs_readlink=0A=
801e4bd0 g     F .text	00000000 dump_list_process=0A=
801fd118 g     O .kstrtab	0000000e __kstrtab_ip_statistics=0A=
801ff848 g     O __ksymtab	00000008 __ksymtab_vfs_unlink=0A=
801ffd58 g     O __ksymtab	00000008 __ksymtab_get_random_bytes=0A=
8014bf2c g     F .text	00000000 vfs_permission=0A=
8021346c g     F .data	00000000 handle_bp_int=0A=
801fb66c g     O .kstrtab	0000000a __kstrtab_vfs_mkdir=0A=
8013017c g     F .text	00000000 __find_lock_page=0A=
802002d0 g     O __ksymtab	00000008 __ksymtab_datagram_poll=0A=
8020f2c8 g     F .text.init	00000000 prom_init=0A=
8012e9a4 g     F .text	00000000 __insert_vm_struct=0A=
80120a98 g     F .text	00000000 __tasklet_schedule=0A=
801fa860 g     O .kstrtab	00000018 __kstrtab___strncpy_from_user_asm=0A=
80109214 g     F .text	00000000 sys_sigaction=0A=
80325de4 g     O .bss	000000c0 pts_driver=0A=
8021bbf0 g     O .data	00000024 ext2_aops=0A=
80188afc g     F .text	00000000 n_tty_chars_in_buffer=0A=
801dda5c g     F .text	00000000 fib_release_info=0A=
802006f0 g     O __ksymtab	00000008 __ksymtab_net_call_rx_atomic=0A=
802001b0 g     O __ksymtab	00000008 __ksymtab_sock_no_bind=0A=
802004b0 g     O __ksymtab	00000008 __ksymtab_inet_select_addr=0A=
8021a11c g     O .data	0000000c uts_sem=0A=
801504f4 g     F .text	00000000 page_readlink=0A=
801ffce0 g     O __ksymtab	00000008 __ksymtab_sscanf=0A=
80165fc8 g     F .text	00000000 add_gd_partition=0A=
80176ad0 g     F .text	00000000 sys_semop=0A=
80142600 g     F .text	00000000 fsync_inode_data_buffers=0A=
801fc738 g     O .kstrtab	00000015 __kstrtab_blk_queue_headactive=0A=
801fb3d0 g     O .kstrtab	00000015 __kstrtab_block_read_full_page=0A=
801ff9f0 g     O __ksymtab	00000008 __ksymtab_ioctl_by_bdev=0A=
801fb0f0 g     O .kstrtab	0000000b __kstrtab_d_validate=0A=
801302f0 g     F .text	00000000 grab_cache_page=0A=
80180b40 g     F .text	00000000 ieee754sp_div=0A=
801a51f0 g     F .text	00000000 scm_fp_dup=0A=
801a2288 g     F .text	00000000 skb_linearize=0A=
801ff638 g     O __ksymtab	00000008 __ksymtab_truncate_inode_pages=0A=
8019f540 g     F .text	00000000 sys_getsockopt=0A=
801a8650 g     F .text	00000000 dev_mc_discard=0A=
801644cc g     F .text	00000000 proc_tty_unregister_driver=0A=
801ff3f0 g     O __ksymtab	00000008 __ksymtab___free_pages=0A=
8013fba4 g     F .text	00000000 sys_vhangup=0A=
801fb0b0 g     O .kstrtab	0000000a __kstrtab_sys_close=0A=
802000b8 g     O __ksymtab	00000008 __ksymtab_get_gendisk=0A=
8010e8c0 g     F .text	00000000 search_exception_table=0A=
8021a104 g     O .data	00000004 cad_pid=0A=
80142ea0 g     F .text	00000000 get_unused_buffer_head=0A=
8021a2dc g     O .data	00000000 pagemap_lru_lock=0A=
801ff4e0 g     O __ksymtab	00000008 __ksymtab_igrab=0A=
801ffaf8 g     O __ksymtab	00000008 __ksymtab_proc_dointvec=0A=
801fadb0 g     O .kstrtab	0000000e __kstrtab_do_mmap_pgoff=0A=
8021316c g     F .data	00000000 handle_ades_int=0A=
801e3d40 g     F .text	00000000 csum_partial_copy=0A=
801fb830 g     O .kstrtab	0000000f __kstrtab_lock_may_write=0A=
801fce04 g     O .kstrtab	0000000a __kstrtab_dst_alloc=0A=
801fbc7c g     O .kstrtab	00000017 __kstrtab_proc_doulongvec_minmax=0A=
8014d760 g     F .text	00000000 open_namei=0A=
8010ab10 g     F .text	00000000 __die=0A=
801b5204 g     F .text	00000000 ip_mc_output=0A=
801e78ec g     F .text	00000000 putPromChar=0A=
801fd058 g     O .kstrtab	0000000f __kstrtab_inet_addr_type=0A=
8011eb8c g     F .text	00000000 exit_fs=0A=
80200620 g     O __ksymtab	00000008 __ksymtab_dev_remove_pack=0A=
801626f0 g     F .text	00000000 proc_readdir=0A=
80318a58 g     O .bss	00000004 files_cachep=0A=
801faddc g     O .kstrtab	0000000b __kstrtab_exit_files=0A=
801fc8c4 g     O .kstrtab	00000010 __kstrtab_sock_unregister=0A=
801fcaf8 g     O .kstrtab	0000000d __kstrtab_sock_wmalloc=0A=
8012d1a4 g     F .text	00000000 lock_vma_mappings=0A=
801ff390 g     O __ksymtab	00000008 __ksymtab_do_munmap=0A=
8010bee0 g     F .text	00000000 __down_trylock=0A=
802065e8 g     F .text.init	00000000 kmem_cache_sizes_init=0A=
80320980 g     O .bss	0000001c inodes_stat=0A=
80150bd4 g     F .text	00000000 sys_dup=0A=
801314e8 g     F .text	00000000 sys_readahead=0A=
801fd378 g     O .kstrtab	00000010 __kstrtab_dev_remove_pack=0A=
8021c208 g     O .data	00000004 shm_ctlmni=0A=
8011ad70 g     F .text	00000000 panic=0A=
801fb144 g     O .kstrtab	00000009 __kstrtab___d_path=0A=
801fc850 g     O .kstrtab	00000010 __kstrtab_register_netdev=0A=
8021af88 g     O .data	00000040 bad_inode_ops=0A=
801fad28 g     O .kstrtab	00000016 __kstrtab_inter_module_register=0A=
801bd0e0 g     F .text	00000000 tcp_destroy_sock=0A=
801fcb28 g     O .kstrtab	0000000d __kstrtab_skb_checksum=0A=
801570d0 g     F .text	00000000 d_alloc_root=0A=
8021db6c g     O .data	00000004 no_cong_thresh=0A=
801d9128 g     F .text	00000000 devinet_ioctl=0A=
801fffa8 g     O __ksymtab	00000008 __ksymtab_proc_root=0A=
801fad88 g     O .kstrtab	00000011 __kstrtab_inter_module_put=0A=
8020c95c g     F .text.init	00000000 tcp_init=0A=
801c9b70 g     F .text	00000000 tcp_connect=0A=
801dc684 g     F .text	00000000 ip_mc_join_group=0A=
8013e5b8 g     F .text	00000000 sys_truncate64=0A=
8019e240 g     F .text	00000000 sock_sendmsg=0A=
80130198 g     F .text	00000000 find_or_create_page=0A=
801fafc0 g     O .kstrtab	0000000c __kstrtab_get_fs_type=0A=
801ff5b8 g     O __ksymtab	00000008 __ksymtab_mark_buffer_dirty=0A=
8013a478 g     F .text	00000000 read_swap_cache_async=0A=
80213cb4 g     O .data	00000000 sys_call_table=0A=
801a1870 g     F .text	00000000 alloc_skb=0A=
8021bc20 g     O .data	00000040 ext2_dir_inode_operations=0A=
801fc584 g     O .kstrtab	00000009 __kstrtab_proc_bus=0A=
801fa7d0 g     O .kstrtab	00000007 __kstrtab_strchr=0A=
801fb900 g     O .kstrtab	00000012 __kstrtab_unregister_blkdev=0A=
80207080 g     F .text.init	00000000 reserve_bootmem_node=0A=
8010adbc g     F .text	00000000 do_ibe=0A=
801fd3c4 g     O .kstrtab	00000009 __kstrtab_dev_load=0A=
8017f3c4 g     F .text	00000000 ieee754dp_neg=0A=
8017b0fc g     F .text	00000000 ieee754dp_isnan=0A=
801e512c g     F .text	00000000 strtok=0A=
80200690 g     O __ksymtab	00000008 __ksymtab___kill_fasync=0A=
801586bc g     F .text	00000000 write_inode_now=0A=
80129054 g     F .text	00000000 sys_setfsuid=0A=
801fb2a4 g     O .kstrtab	0000000b __kstrtab_permission=0A=
8017bb58 g     F .text	00000000 ieee754sp_isnan=0A=
80198448 g     F .text	00000000 del_gendisk=0A=
8021e860 g     O .data	00000000 raw_v4_lock=0A=
80139c9c g     F .text	00000000 page_cache_release=0A=
801ff7f0 g     O __ksymtab	00000008 __ksymtab_shrink_dcache_sb=0A=
801d9ad8 g     F .text	00000000 inet_select_addr=0A=
802006a0 g     O __ksymtab	00000008 __ksymtab_sysctl_wmem_max=0A=
801a47e4 g     F .text	00000000 skb_copy_and_csum_datagram_iovec=0A=
8012b9f4 g     F .text	00000000 mark_dirty_kiobuf=0A=
80173de4 g     F .text	00000000 ipc_parse_version=0A=
801e522c g     F .text	00000000 memcmp=0A=
80200440 g     O __ksymtab	00000008 __ksymtab_arp_send=0A=
801ffeb0 g     O __ksymtab	00000008 __ksymtab_init_bh=0A=
80200448 g     O __ksymtab	00000008 __ksymtab_arp_broken_ops=0A=
801fafb0 g     O .kstrtab	0000000d __kstrtab_update_atime=0A=
80200020 g     O __ksymtab	00000008 __ksymtab_batch_entropy_store=0A=
801de39c g     F .text	00000000 __fib_res_prefsrc=0A=
8015766c g     F .text	00000000 __d_path=0A=
801ff658 g     O __ksymtab	00000008 __ksymtab_vfs_permission=0A=
8021e5e4 g     O .data	00000004 inet_peer_maxttl=0A=
802000e8 g     O __ksymtab	00000008 __ksymtab_register_netdev=0A=
802000c8 g     O __ksymtab	00000008 =
__ksymtab_loop_unregister_transfer=0A=
8021a074 g     O .data	00000000 task_capability_lock=0A=
801fccc0 g     O .kstrtab	00000012 __kstrtab_neigh_table_clear=0A=
8021a084 g     O .data	00000004 tickadj=0A=
801ffea0 g     O __ksymtab	00000008 __ksymtab_tasklet_vec=0A=
80335924 g     O .bss	00000004 fib_info_cnt=0A=
801687a8 g     F .text	00000000 ext2_set_link=0A=
801ff8f0 g     O __ksymtab	00000008 __ksymtab___get_lease=0A=
801e8064 g     F .text	00000000 reset_mqb_handler=0A=
80168e48 g     F .text	00000000 ext2_empty_dir=0A=
8014c5d0 g     F .text	00000000 link_path_walk=0A=
80123474 g     F .text	00000000 sysctl_string=0A=
8015bc5c g     F .text	00000000 sys_umount=0A=
801282fc g     F .text	00000000 sys_reboot=0A=
801dcdfc g     F .text	00000000 inet_addr_type=0A=
801fcdf0 g     O .kstrtab	00000014 __kstrtab_neigh_compat_output=0A=
8021e214 g     O .data	00000004 ip_rt_redirect_number=0A=
80200308 g     O __ksymtab	00000008 __ksymtab_neigh_connected_output=0A=
80118a84 g     F .text	00000000 sys_sched_rr_get_interval=0A=
801a2420 g     F .text	00000000 pskb_copy=0A=
80157458 g     F .text	00000000 d_rehash=0A=
801e3da8 g     F .text	00000000 csum_partial_copy_from_user=0A=
801ffee0 g     O __ksymtab	00000008 __ksymtab_raise_softirq=0A=
80129148 g     F .text	00000000 sys_setfsgid=0A=
801fae7c g     O .kstrtab	0000000b __kstrtab_free_pages=0A=
8010bc58 g     F .text	00000000 machine_power_off=0A=
801e68bc g     F .text	00000000 sscanf=0A=
801a1350 g     F .text	00000000 sock_no_bind=0A=
801fc998 g     O .kstrtab	00000010 __kstrtab_sock_wake_async=0A=
80211000 g     O *ABS*	00000000 __init_end=0A=
8011b804 g     F .text	00000000 printk=0A=
8021d8d0 g     O .data	00000268 core_table=0A=
80128a54 g     F .text	00000000 sys_setuid=0A=
80316198 g     O .bss	00000184 boot_mem_map=0A=
801c4f10 g     F .text	00000000 tcp_rcv_established=0A=
802002f0 g     O __ksymtab	00000008 __ksymtab_neigh_table_init=0A=
80145e3c g     F .text	00000000 sys_sysfs=0A=
801fca30 g     O .kstrtab	0000000d __kstrtab_sock_no_poll=0A=
8012dce4 g     F .text	00000000 find_vma_prev=0A=
801fcb60 g     O .kstrtab	00000012 __kstrtab_skb_free_datagram=0A=
80318a74 g     O .bss	00000004 abi_traceflg=0A=
80141998 g     F .text	00000000 sync_dev=0A=
8021aa9c g     O .data	00000024 bdf_prm=0A=
801fbdb4 g     O .kstrtab	0000000d __kstrtab_unmap_kiobuf=0A=
801ff4d0 g     O __ksymtab	00000008 __ksymtab_fput=0A=
801ff718 g     O __ksymtab	00000008 __ksymtab_cont_prepare_write=0A=
80142c80 g     F .text	00000000 refile_buffer=0A=
8021e6a0 g     O .data	00000000 ip_ra_lock=0A=
8021aee0 g     O .data	00000004 leases_enable=0A=
801fbbe8 g     O .kstrtab	0000000e __kstrtab_sysctl_intvec=0A=
801ff1d8 g     O __ksymtab	00000008 __ksymtab___ioremap=0A=
80148074 g     F .text	00000000 check_disk_change=0A=
801ffb28 g     O __ksymtab	00000008 __ksymtab_del_timer=0A=
80335e14 g     O .bss	00000004 prom_argv=0A=
801692d0 g     F .text	00000000 ext2_free_inode=0A=
8021a080 g     O .data	00000004 tick=0A=
801883cc g     F .text	00000000 tty_get_baud_rate=0A=
801dc308 g     F .text	00000000 ip_mc_up=0A=
80108850 g     F .text	00000000 cpu_idle=0A=
801ffc30 g     O __ksymtab	00000008 __ksymtab_ioport_resource=0A=
801f1120 g     O .text	00000088 __ieee754dp_spcvals=0A=
801e6fb0 g     F .text	00000000 init_rwsem=0A=
801ffbe8 g     O __ksymtab	00000008 __ksymtab_free_dma=0A=
801833f0 g     F .text	00000000 ieee754sp_funs=0A=
801e68f0 g     F .text	00000000 get_option=0A=
8013bac8 g     F .text	00000000 is_swap_partition=0A=
8021ac48 g     O .data	00000048 write_fifo_fops=0A=
801ff910 g     O __ksymtab	00000008 __ksymtab_dcache_readdir=0A=
80129918 g     F .text	00000000 sys_getrlimit=0A=
801e4f08 g     F .text	00000000 strncat=0A=
802006c0 g     O __ksymtab	00000008 __ksymtab_qdisc_reset=0A=
80219534 g     O .data	00000000 modlist_lock=0A=
801fc884 g     O .kstrtab	0000000f __kstrtab_autoirq_report=0A=
801ff618 g     O __ksymtab	00000008 __ksymtab_invalidate_bdev=0A=
8018821c g     F .text	00000000 do_SAK=0A=
801fd388 g     O .kstrtab	00000008 __kstrtab_dev_get=0A=
801fbcd0 g     O .kstrtab	0000000f __kstrtab_add_wait_queue=0A=
801fd480 g     O .kstrtab	00000016 __kstrtab_sysctl_ip_default_ttl=0A=
8021aa70 g     O .data	0000000c files_stat=0A=
8015ad60 g     F .text	00000000 sys_nfsservctl=0A=
801c86d4 g     F .text	00000000 tcp_simple_retransmit=0A=
8021e700 g     O .data	00000004 sysctl_tcp_retrans_collapse=0A=
801ff170 g     O __ksymtab	00000008 __ksymtab__flush_cache_all=0A=
801ab120 g     F .text	00000000 neigh_resolve_output=0A=
8013f74c g     F .text	00000000 get_unused_fd=0A=
80149d34 g     F .text	00000000 flush_old_exec=0A=
8011fe5c g     F .text	00000000 get_fast_time=0A=
801ff608 g     O __ksymtab	00000008 __ksymtab_check_disk_change=0A=
801fc3d0 g     O .kstrtab	00000016 __kstrtab___tasklet_hi_schedule=0A=
8020fdd4 g     O .data.init	00000004 ic_proto_enabled=0A=
801ff5f0 g     O __ksymtab	00000008 __ksymtab_filp_close=0A=
8010e9b0 g     F .text	00000000 sys_cacheflush=0A=
801fb9ac g     O .kstrtab	00000009 __kstrtab_sync_dev=0A=
8014a710 g     F .text	00000000 do_execve=0A=
802004a0 g     O __ksymtab	00000008 __ksymtab_ip_cmsg_recv=0A=
80211800 g     O .data.cacheline_aligned	00000000 tasklist_lock=0A=
8013a3f0 g     F .text	00000000 lookup_swap_cache=0A=
803209f8 g     O .bss	00000004 max_dquots=0A=
801c9578 g     F .text	00000000 tcp_make_synack=0A=
801fca74 g     O .kstrtab	00000013 __kstrtab_sock_no_getsockopt=0A=
801fff18 g     O __ksymtab	00000008 __ksymtab_vm_max_readahead=0A=
801ffab8 g     O __ksymtab	00000008 __ksymtab_remove_arg_zero=0A=
801fc0a4 g     O .kstrtab	0000001b =
__kstrtab_secure_tcp_sequence_number=0A=
8020f694 g     F .text.init	00000000 prom_init_cmdline=0A=
801988a0 g     F .text	00000000 elevator_noop_merge_req=0A=
801419d4 g     F .text	00000000 file_fsync=0A=
8010c29c g     F .text	00000000 sys_uname=0A=
801fbb6c g     O .kstrtab	0000000f __kstrtab_prepare_binprm=0A=
801d3dac g     F .text	00000000 udp_sendmsg=0A=
801ff790 g     O __ksymtab	00000008 __ksymtab_locks_copy_lock=0A=
801ffec8 g     O __ksymtab	00000008 __ksymtab_tasklet_kill=0A=
80127fa0 g     F .text	00000000 notifier_call_chain=0A=
8021ff80 g     O .data	00000100 _ctype=0A=
80117480 g     F .text	00000000 scheduling_functions_start_here=0A=
801a08f4 g     F .text	00000000 sk_alloc=0A=
801ffb98 g     O __ksymtab	00000008 __ksymtab_alloc_kiovec=0A=
8014be50 g     F .text	00000000 getname=0A=
8011af50 g     F .text	00000000 do_syslog=0A=
8021e6ec g     O .data	00000004 sysctl_tcp_app_win=0A=
8020c928 g     F .text.init	00000000 ip_init=0A=
801ffa70 g     O __ksymtab	00000008 __ksymtab_unregister_filesystem=0A=
802003b0 g     O __ksymtab	00000008 __ksymtab___scm_destroy=0A=
801d1944 g     F .text	00000000 tcp_create_openreq_child=0A=
801fd1d4 g     O .kstrtab	0000000c __kstrtab_xrlim_allow=0A=
801de8ac g     F .text	00000000 fib_sync_down=0A=
8021a0b0 g     O .data	00000004 time_esterror=0A=
80320a14 g     O .bss	00000004 proc_net=0A=
80125774 g     F .text	00000000 sys_nanosleep=0A=
801fa8d8 g     O .kstrtab	00000012 __kstrtab_csum_partial_copy=0A=
801ff130 g     O __ksymtab	00000008 =
__ksymtab___strncpy_from_user_nocheck_asm=0A=
801fc51c g     O .kstrtab	0000000b __kstrtab_proc_mknod=0A=
80219170 g     O .data	00000010 cpuinfo_op=0A=
801ff080 g     O *ABS*	00000000 __stop___ex_table=0A=
801ae2b4 g     F .text	00000000 rt_bind_peer=0A=
801fbfd8 g     O .kstrtab	00000006 __kstrtab_panic=0A=
8021e684 g     O .data	00000004 sysctl_ip_default_ttl=0A=
801d14d0 g     F .text	00000000 tcp_tw_deschedule=0A=
801fff98 g     O __ksymtab	00000008 __ksymtab_create_proc_entry=0A=
801b4acc g     F .text	00000000 ip_forward_options=0A=
8031d72c g     O .bss	00000004 time_adj=0A=
8011bcbc g     F .text	00000000 console_unblank=0A=
801ffa48 g     O __ksymtab	00000008 __ksymtab_tty_hung_up_p=0A=
801fc1d0 g     O .kstrtab	0000000a __kstrtab____strtok=0A=
801fd2b4 g     O .kstrtab	00000013 __kstrtab___dev_get_by_index=0A=
8013fd3c g     F .text	00000000 default_llseek=0A=
801fbfe8 g     O .kstrtab	00000009 __kstrtab_snprintf=0A=
8021af08 g     O .data	00000018 dentry_stat=0A=
8018cfa4 g     F .text	00000000 raw_read=0A=
801fc2c4 g     O .kstrtab	0000000c __kstrtab_kill_fasync=0A=
801aae20 g     F .text	00000000 neigh_event_ns=0A=
801fb1d0 g     O .kstrtab	0000000b __kstrtab_filp_close=0A=
8013ee10 g     F .text	00000000 sys_fchdir=0A=
80316088 g     O .bss	00000004 ll_bit=0A=
801ff398 g     O __ksymtab	00000008 __ksymtab_do_brk=0A=
8015a760 g     F .text	00000000 free_kiobuf_bhs=0A=
80219550 g     O .data	00000004 do_get_fast_time=0A=
80200568 g     O __ksymtab	00000008 __ksymtab_arp_rcv=0A=
801807c0 g     F .text	00000000 ieee754sp_frexp=0A=
8021e6b4 g     O .data	0000000c sysctl_tcp_rmem=0A=
801fd4c4 g     O .kstrtab	00000012 __kstrtab_qdisc_create_dflt=0A=
80162c44 g     F .text	00000000 proc_mkdir=0A=
801ff690 g     O __ksymtab	00000008 __ksymtab_cdget=0A=
80157eec g     F .text	00000000 sync_inodes_sb=0A=
801b634c g     F .text	00000000 ip_build_xmit=0A=
8021cc9c g     O .data	00000050 xfer_funcs=0A=
801fff48 g     O __ksymtab	00000008 __ksymtab_put_unused_buffer_head=0A=
801fa948 g     O .kstrtab	0000000f __kstrtab___down_trylock=0A=
80132ba8 g     F .text	00000000 sys_mincore=0A=
8031d750 g     O .bss	00000008 xtime=0A=
801ff958 g     O __ksymtab	00000008 __ksymtab_register_chrdev=0A=
8011f848 g     F .text	00000000 sys_waitpid=0A=
801e7bd0 g     F .text	00000000 rs_getDebugChar=0A=
80200698 g     O __ksymtab	00000008 __ksymtab_if_port_text=0A=
8021a088 g     O .data	00000008 tq_timer=0A=
802137a0 g     F .data	000000f4 handle_tr=0A=
801cf764 g     F .text	00000000 tcp_v4_rebuild_header=0A=
801fc5a4 g     O .kstrtab	00000013 __kstrtab_tty_register_ldisc=0A=
801fd408 g     O .kstrtab	0000000a __kstrtab_dev_close=0A=
803363f0 g     O .bss	00000004 generic_putDebugChar=0A=
801ff4f0 g     O __ksymtab	00000008 __ksymtab_iget4=0A=
801ffb78 g     O __ksymtab	00000008 __ksymtab_probe_irq_off=0A=
802133a0 g     F .data	000000f4 handle_bp=0A=
80167d44 g     F .text	00000000 ext2_group_sparse=0A=
801fb840 g     O .kstrtab	0000000f __kstrtab_dcache_readdir=0A=
8015173c g     F .text	00000000 sys_ioctl=0A=
8021db40 g     O .data	0000001c if_port_text=0A=
801a11d0 g     F .text	00000000 sklist_destroy_socket=0A=
8021e6f8 g     O .data	00000004 sysctl_tcp_rfc1337=0A=
801fbb24 g     O .kstrtab	0000000b __kstrtab_may_umount=0A=
8017ab30 g     F .text	00000000 ieee754dp_dump=0A=
8010d02c g     F .text	00000050 _restore_fp_context=0A=
8031d734 g     O .bss	00000004 time_adjust=0A=
801c7738 g     F .text	00000000 tcp_push_one=0A=
801ffde8 g     O __ksymtab	00000008 __ksymtab____strtok=0A=
801a31c8 g     F .text	00000000 skb_checksum=0A=
801d806c g     F .text	00000000 icmp_rcv=0A=
801fa958 g     O .kstrtab	00000005 __kstrtab___up=0A=
801ff888 g     O __ksymtab	00000008 __ksymtab_ROOT_DEV=0A=
802001e8 g     O __ksymtab	00000008 __ksymtab_sock_no_listen=0A=
801827d0 g     F .text	00000000 ieee754sp_logb=0A=
801ff210 g     O __ksymtab	00000008 __ksymtab___set_personality=0A=
8012e544 g     F .text	00000000 do_brk=0A=
801a1360 g     F .text	00000000 sock_no_socketpair=0A=
80219470 g     O .data	00000004 tainted=0A=
80219570 g     O .data	0000001c ioport_resource=0A=
8017c398 g     F .text	00000000 ieee754di_xcpt=0A=
80131748 g     F .text	00000000 filemap_nopage=0A=
80316000 g     O *ABS*	00000000 __bss_start=0A=
801fc050 g     O .kstrtab	0000000f __kstrtab_system_utsname=0A=
801fd3d0 g     O .kstrtab	0000000a __kstrtab_dev_ioctl=0A=
801fb9e0 g     O .kstrtab	0000000b __kstrtab_blkdev_get=0A=
801fd174 g     O .kstrtab	0000000a __kstrtab_rtnl_lock=0A=
801ca800 g     F .text	00000000 tcp_init_xmit_timers=0A=
801099a0 g     F .text	00000000 do_signal=0A=
80131ee0 g     F .text	00000000 sys_msync=0A=
801b7270 g     F .text	00000000 ip_cmsg_recv_retopts=0A=
8020fddc g     O .data.init	00000004 ic_myaddr=0A=
80124afc g     F .text	00000000 immediate_bh=0A=
801ffe68 g     O __ksymtab	00000008 __ksymtab_disk_name=0A=
801ffde0 g     O __ksymtab	00000008 __ksymtab_clear_inode=0A=
8010b570 g     F .text	00000000 ptrace_disable=0A=
801e4680 g     F .text	00000124 memset=0A=
8021c0d0 g     O .data	00000048 devpts_root_operations=0A=
801ffaa0 g     O __ksymtab	00000008 __ksymtab_search_binary_handler=0A=
801dc218 g     F .text	00000000 ip_mc_down=0A=
801ff0d0 g     O __ksymtab	00000008 __ksymtab_strchr=0A=
801b36e0 g     F .text	00000000 ip_defrag=0A=
801738ec g     F .text	00000000 devpts_pty_kill=0A=
8011ecc0 g     F .text	00000000 start_lazy_tlb=0A=
00000000  w      *UND*	00000000 __start___kallsyms=0A=
801ff400 g     O __ksymtab	00000008 __ksymtab_num_physpages=0A=
801fc5e4 g     O .kstrtab	0000000c __kstrtab_n_tty_ioctl=0A=
801fabf8 g     O .kstrtab	0000000e __kstrtab_send_sig_info=0A=
802003b8 g     O __ksymtab	00000008 __ksymtab___scm_send=0A=
802000d0 g     O __ksymtab	00000008 __ksymtab_init_etherdev=0A=
801ff908 g     O __ksymtab	00000008 __ksymtab_lock_may_write=0A=
801294ec g     F .text	00000000 sys_setgroups=0A=
801e4a30 g     F .text	00000000 dump_tlb_all=0A=
801fb940 g     O .kstrtab	00000010 __kstrtab_tty_std_termios=0A=
80154168 g     F .text	00000000 locks_mandatory_locked=0A=
801facdc g     O .kstrtab	00000014 __kstrtab_call_usermodehelper=0A=
801ffdf0 g     O __ksymtab	00000008 __ksymtab_init_special_inode=0A=
8013bb1c g     F .text	00000000 sys_swapon=0A=
801fc014 g     O .kstrtab	00000008 __kstrtab_vsscanf=0A=
801fc078 g     O .kstrtab	0000000d __kstrtab_machine_halt=0A=
8021a7d8 g     O .data	00000004 shmem_nrpages=0A=
801967e8 g     F .text	00000000 set_device_ro=0A=
8017e820 g     F .text	00000000 ieee754dp_fsp=0A=
801ff1e0 g     O __ksymtab	00000008 __ksymtab_iounmap=0A=
801ff938 g     O __ksymtab	00000008 __ksymtab_filemap_fdatasync=0A=
801ff4a0 g     O __ksymtab	00000008 __ksymtab_update_atime=0A=
801ff6f0 g     O __ksymtab	00000008 __ksymtab_generic_direct_IO=0A=
8017b47c g     F .text	00000000 ieee754dp_format=0A=
8021c080 g     O .data	00000040 autofs4_symlink_inode_operations=0A=
801fbe00 g     O .kstrtab	0000000c __kstrtab_request_dma=0A=
8010d0a0 g     F .text	00000098 resume=0A=
801ff270 g     O __ksymtab	00000008 __ksymtab_unregister_console=0A=
80154fd4 g     F .text	00000000 fcntl_setlease=0A=
801ff918 g     O __ksymtab	00000008 __ksymtab_default_llseek=0A=
8010b578 g     F .text	00000000 sys_ptrace=0A=
801ffa18 g     O __ksymtab	00000008 __ksymtab_refile_buffer=0A=
801fb318 g     O .kstrtab	00000006 __kstrtab_cdget=0A=
80202744 g     F .text.init	00000000 start_kernel=0A=
80335424 g     O .bss	00000004 sysctl_icmp_echo_ignore_broadcasts=0A=
8017c9c0 g     F .text	00000000 ieee754dp_div=0A=
8031ecc0 g     O .bss	00000004 total_swap_pages=0A=
8021a2f0 g     O .data	00000000 vmlist_lock=0A=
8018df54 g     F .text	00000000 misc_register=0A=
801fff90 g     O __ksymtab	00000008 __ksymtab_proc_mkdir=0A=
801399dc g     F .text	00000000 __alloc_pages=0A=
80200530 g     O __ksymtab	00000008 __ksymtab_move_addr_to_kernel=0A=
801fc590 g     O .kstrtab	00000011 __kstrtab_proc_root_driver=0A=
801783d0 g     F .text	00000000 sys_shmat=0A=
801d2508 g     F .text	00000000 raw_err=0A=
8021e228 g     O .data	00000004 ip_rt_gc_elasticity=0A=
801fc7d8 g     O .kstrtab	0000000c __kstrtab_del_gendisk=0A=
8014ebf8 g     F .text	00000000 sys_unlink=0A=
801296a4 g     F .text	00000000 sys_sethostname=0A=
8021d8b0 g     O .data	00000004 sysctl_optmem_max=0A=
80334d80 g     O .bss	00000004 sysctl_tcp_orphan_retries=0A=
801ffa68 g     O __ksymtab	00000008 __ksymtab_register_filesystem=0A=
801ff318 g     O __ksymtab	00000008 =
__ksymtab_unregister_reboot_notifier=0A=
801fcba0 g     O .kstrtab	00000021 =
__kstrtab_skb_copy_and_csum_datagram_iovec=0A=
8017eb30 g     F .text	00000000 ieee754dp_cmp=0A=
801c264c g     F .text	00000000 tcp_parse_options=0A=
8017b148 g     F .text	00000000 ieee754dp_xcpt=0A=
80149ad8 g     F .text	00000000 kernel_read=0A=
801180b8 g     F .text	00000000 wait_for_completion=0A=
80335024 g     O .bss	00000080 raw_v4_htable=0A=
801ff8a0 g     O __ksymtab	00000008 __ksymtab_grab_cache_page=0A=
801fae20 g     O .kstrtab	00000011 __kstrtab_alloc_pages_node=0A=
80217eb4 g     O .data	00000000 sys_narg_table=0A=
801fd264 g     O .kstrtab	00000015 __kstrtab_unregister_netdevice=0A=
801fffc8 g     O __ksymtab	00000008 __ksymtab_proc_root_driver=0A=
80316110 g     O .bss	00000004 restore_fp_context=0A=
8031d730 g     O .bss	00000004 time_reftime=0A=
80127190 g     F .text	00000000 do_sigpending=0A=
80147e5c g     F .text	00000000 get_blkdev_list=0A=
8016ab98 g     F .text	00000000 ext2_truncate=0A=
8031ec10 g     O .bss	00000004 sysctl_overcommit_memory=0A=
801a1428 g     F .text	00000000 sock_no_recvmsg=0A=
80200358 g     O __ksymtab	00000008 __ksymtab_neigh_destroy=0A=
8031d720 g     O .bss	00000004 event=0A=
8021f268 g     O .data	00000010 inet_family_ops=0A=
801ffc70 g     O __ksymtab	00000008 __ksymtab_interruptible_sleep_on=0A=
80317a4c g     O .bss	00000004 mmlist_nr=0A=
801faf84 g     O .kstrtab	00000012 __kstrtab_get_unmapped_area=0A=
80148848 g     F .text	00000000 cdput=0A=
801fff70 g     O __ksymtab	00000008 __ksymtab_bh_cachep=0A=
80158420 g     F .text	00000000 sync_inodes=0A=
801ff080 g     O __ksymtab	00000008 __ksymtab_mips_io_port_base=0A=
801ff9e8 g     O __ksymtab	00000008 __ksymtab_blkdev_put=0A=
80200330 g     O __ksymtab	00000008 __ksymtab_neigh_event_ns=0A=
801e7240 g     F .text	00000000 idisx_hw0_irqdispatch=0A=
8021e238 g     O .data	0000002c ipv4_dst_ops=0A=
801e31d0 g     F .text	00000000 unix_notinflight=0A=
8031ec64 g     O .bss	00000004 min_low_pfn=0A=
801fcdd8 g     O .kstrtab	00000016 __kstrtab_neigh_rand_reach_time=0A=
801ff840 g     O __ksymtab	00000008 __ksymtab_vfs_rmdir=0A=
80200538 g     O __ksymtab	00000008 __ksymtab_move_addr_to_user=0A=
801ffff0 g     O __ksymtab	00000008 __ksymtab_misc_register=0A=
801fce50 g     O .kstrtab	0000000e __kstrtab___scm_destroy=0A=
8013d204 g     F .text	00000000 shmem_unuse=0A=
8021e224 g     O .data	00000004 ip_rt_error_burst=0A=
801a1430 g     F .text	00000000 sock_no_mmap=0A=
8012ba80 g     F .text	00000000 unmap_kiobuf=0A=
801fb370 g     O .kstrtab	0000000e __kstrtab_unlock_buffer=0A=
8021bd00 g     O .data	00000048 autofs_dir_operations=0A=
80317a50 g     O .bss	00001000 pidhash=0A=
802119a0 g     O .data.cacheline_aligned	000000c0 tcp_hashinfo=0A=
801fd32c g     O .kstrtab	0000000a __kstrtab_alloc_skb=0A=
801bae74 g     F .text	00000000 tcp_sendmsg=0A=
80335910 g     O .bss	00000004 local_table=0A=
801e3ea4 g     O .text	00000000 __copy_user=0A=
801a2bec g     F .text	00000000 __pskb_pull_tail=0A=
8021c1d4 g     O .data	00000004 msg_ctlmnb=0A=
80118514 g     F .text	00000000 scheduling_functions_end_here=0A=
8013fea4 g     F .text	00000000 sys_llseek=0A=
8011e610 g     F .text	00000000 release_task=0A=
801fc3f8 g     O .kstrtab	0000000e __kstrtab_tasklist_lock=0A=
8010e9d8 g     F .text	00000000 do_check_pgt_cache=0A=
000f4101 g       *ABS*	00000000 _binary_ramdisk_gz_size=0A=
802001e0 g     O __ksymtab	00000008 __ksymtab_sock_no_ioctl=0A=
8021e120 g     O .data	00000040 noqueue_qdisc_ops=0A=
801fc288 g     O .kstrtab	00000009 __kstrtab_brw_page=0A=
80315101 g       .data	00000000 _binary_ramdisk_gz_end=0A=
801b38d0 g     F .text	00000000 ip_forward=0A=
802192d0 g     O .data	00000004 abi_defhandler_coff=0A=
801fcc58 g     O .kstrtab	00000015 __kstrtab_skb_realloc_headroom=0A=
8012bfd4 g     F .text	00000000 remap_page_range=0A=
803356a0 g     O .bss	00000240 net_statistics=0A=
8021a4b0 g     O .data	00000004 numnodes=0A=
8013e060 g     F .text	00000000 sys_fstatfs=0A=
801d10a8 g     F .text	00000000 tcp_time_wait=0A=
801fb02c g     O .kstrtab	0000000d __kstrtab_force_delete=0A=
8021e728 g     O .data	00000004 sysctl_tcp_retries2=0A=
80148e24 g     F .text	00000000 sys_newfstat=0A=
80142004 g     F .text	00000000 invalidate_bdev=0A=
80200730 g     O __ksymtab	00000008 __ksymtab___up_read=0A=
801456f0 g     F .text	00000000 bdflush=0A=
801fbd94 g     O .kstrtab	0000000e __kstrtab_expand_kiobuf=0A=
801fc488 g     O .kstrtab	00000017 __kstrtab_put_unused_buffer_head=0A=
80120218 g     F .text	00000000 do_adjtimex=0A=
801a1438 g     F .text	00000000 sock_no_sendpage=0A=
801d70c0 g     F .text	00000000 xrlim_allow=0A=
80331498 g     O .bss	000003fc hardsect_size=0A=
8010ecc4 g     F .text	00000000 free_initrd_mem=0A=
801a6338 g     F .text	00000000 netif_rx=0A=
801276f4 g     F .text	00000000 sys_rt_sigqueueinfo=0A=
801ffed0 g     O __ksymtab	00000008 __ksymtab___run_task_queue=0A=
8021e6d8 g     O .data	00000004 sysctl_tcp_sack=0A=
801fc954 g     O .kstrtab	00000010 __kstrtab_sock_getsockopt=0A=
80198410 g     F .text	00000000 add_gendisk=0A=
80213c8c g     F .data	00000000 handle_reserved_int=0A=
8012947c g     F .text	00000000 sys_getgroups=0A=
8021ad68 g     O .data	00000048 rdwr_pipe_fops=0A=
801ff8a8 g     O __ksymtab	00000008 __ksymtab_grab_cache_page_nowait=0A=
8014d410 g     F .text	00000000 lookup_hash=0A=
802005e0 g     O __ksymtab	00000008 __ksymtab_netdev_set_master=0A=
801573b8 g     F .text	00000000 d_delete=0A=
8021ab7c g     O .data	00000024 def_blk_aops=0A=
8014f9dc g     F .text	00000000 vfs_rename_other=0A=
80206318 g     F .text.init	00000000 sysctl_init=0A=
8020c5c0 g     F .text.init	00000000 ip_rt_init=0A=
801fa7f0 g     O .kstrtab	00000008 __kstrtab_strnlen=0A=
801b72f4 g     F .text	00000000 ip_cmsg_recv=0A=
801a8468 g     F .text	00000000 dev_mc_add=0A=
80142f68 g     F .text	00000000 set_bh_page=0A=
801fb660 g     O .kstrtab	0000000b __kstrtab_vfs_create=0A=
801ff940 g     O __ksymtab	00000008 __ksymtab_filemap_fdatawait=0A=
801fb130 g     O .kstrtab	00000008 __kstrtab_d_alloc=0A=
802192a4 g     O .data	0000002c default_exec_domain=0A=
801fc11c g     O .kstrtab	00000010 __kstrtab_setup_arg_pages=0A=
802091f0 g     F .text.init	00000000 ipc_init_ids=0A=
8021e664 g     O .data	00000004 sysctl_ipfrag_low_thresh=0A=
801963fc g     F .text	00000000 generic_unplug_device=0A=
801fd538 g     O .kstrtab	0000000b __kstrtab_get_option=0A=
801ff5a8 g     O __ksymtab	00000008 __ksymtab_d_lookup=0A=
8019f5ec g     F .text	00000000 sys_shutdown=0A=
801fb164 g     O .kstrtab	00000014 __kstrtab_set_buffer_async_io=0A=
8017f7f0 g     F .text	00000000 ieee754dp_tint=0A=
8021a410 g     O .data	0000000c pager_daemon=0A=
801ffa10 g     O __ksymtab	00000008 __ksymtab_init_buffer=0A=
8012d1b4 g     F .text	00000000 sys_brk=0A=
801fff88 g     O __ksymtab	00000008 __ksymtab_proc_mknod=0A=
801aa6a8 g     F .text	00000000 __neigh_event_send=0A=
801858bc g     F .text	00000000 do_tty_hangup=0A=
801a4b7c g     F .text	00000000 __scm_destroy=0A=
8020c55c g     F .text.init	00000000 dev_mcast_init=0A=
8031d728 g     O .bss	00000004 time_phase=0A=
80144074 g     F .text	00000000 block_prepare_write=0A=
8018f0a0 g     F .text	00000000 rand_initialize_irq=0A=
8019dbd0 g     F .text	00000000 autoirq_setup=0A=
801b4c84 g     F .text	00000000 ip_options_rcv_srr=0A=
801fc704 g     O .kstrtab	0000000f __kstrtab_blk_init_queue=0A=
8021e658 g     O .data	00000004 inet_protocol_base=0A=
801470f0 g     F .text	00000000 do_remount_sb=0A=
801d9ec0 g     F .text	00000000 inet_forward_change=0A=
802006b0 g     O __ksymtab	00000008 __ksymtab_sysctl_ip_default_ttl=0A=
80221000 g     O .data	00000000 __rd_start=0A=
801dade8 g     F .text	00000000 inet_dgram_connect=0A=
80119874 g     F .text	00000000 mm_release=0A=
8014e5ac g     F .text	00000000 vfs_rmdir=0A=
80200428 g     O __ksymtab	00000008 __ksymtab_icmp_send=0A=
80221000 g       .data	00000000 _binary_ramdisk_gz_start=0A=
801ff108 g     O __ksymtab	00000008 __ksymtab_strtok=0A=
801fd584 g     O .kstrtab	0000000b __kstrtab___up_write=0A=
801455f4 g     F .text	00000000 sys_bdflush=0A=
801987d4 g     F .text	00000000 elevator_linus_merge_req=0A=
801fbd5c g     O .kstrtab	00000009 __kstrtab_tq_timer=0A=
8012936c g     F .text	00000000 sys_getpgid=0A=
802003a0 g     O __ksymtab	00000008 __ksymtab_net_random=0A=
801fadd4 g     O .kstrtab	00000008 __kstrtab_exit_mm=0A=
801aefb4 g     F .text	00000000 ip_rt_frag_needed=0A=
801ffc40 g     O __ksymtab	00000008 __ksymtab_complete_and_exit=0A=
80200058 g     O __ksymtab	00000008 __ksymtab_blk_init_queue=0A=
8010abc4 g     F .text	00000000 __die_if_kernel=0A=
801fb69c g     O .kstrtab	0000000a __kstrtab_vfs_rmdir=0A=
8010d1f4 g     F .text	0000004c save_fp=0A=
801ffc08 g     O __ksymtab	00000008 __ksymtab_allocate_resource=0A=
801fc534 g     O .kstrtab	00000012 __kstrtab_create_proc_entry=0A=
80336400 g     O .bss	00000004 mqb_handler=0A=
801fba68 g     O .kstrtab	0000000b __kstrtab_tty_hangup=0A=
8019f64c g     F .text	00000000 sys_sendmsg=0A=
80200148 g     O __ksymtab	00000008 __ksymtab_sock_create=0A=
801fce38 g     O .kstrtab	0000000b __kstrtab_net_random=0A=
80142b28 g     F .text	00000000 __mark_buffer_dirty=0A=
801ffb30 g     O __ksymtab	00000008 __ksymtab_request_irq=0A=
801ffc78 g     O __ksymtab	00000008 =
__ksymtab_interruptible_sleep_on_timeout=0A=
8018e95c g     F .text	00000000 add_mouse_randomness=0A=
8015d9d0 g     F .text	00000000 sys_quotactl=0A=
801fb2f0 g     O .kstrtab	0000000e __kstrtab_notify_change=0A=
801ffe38 g     O __ksymtab	00000008 __ksymtab_event=0A=
80200388 g     O __ksymtab	00000008 __ksymtab___dst_free=0A=
8018e9c4 g     F .text	00000000 add_blkdev_randomness=0A=
80145a68 g     F .text	00000000 set_buffer_async_io=0A=
8011a8b8 g     F .text	00000000 __mmdrop=0A=
80143200 g     F .text	00000000 try_to_release_page=0A=
8014194c g     F .text	00000000 fsync_dev=0A=
801fd250 g     O .kstrtab	00000013 __kstrtab_register_netdevice=0A=
801fbfb4 g     O .kstrtab	00000010 __kstrtab_loops_per_jiffy=0A=
803349d4 g     O .bss	00000004 ip_rt_max_size=0A=
801fb5bc g     O .kstrtab	00000005 __kstrtab_dput=0A=
8020d330 g     F .text.init	00000000 fib_hash_init=0A=
80205adc g     F .text.init	00000060 except_vec0_r45k_bvahwbug=0A=
801fcfdc g     O .kstrtab	00000010 __kstrtab_inet_family_ops=0A=
80117718 g     F .text	00000000 schedule_tail=0A=
80159d14 g     F .text	00000000 inode_setattr=0A=
801ffc48 g     O __ksymtab	00000008 __ksymtab___wake_up=0A=
801de3c4 g     F .text	00000000 fib_convert_rtentry=0A=
80133730 g     F .text	00000000 remove_suid=0A=
801a1c80 g     F .text	00000000 kfree_skbmem=0A=
801fbb9c g     O .kstrtab	0000000b __kstrtab_set_binfmt=0A=
80335e20 g     O .bss	00000180 mdesc=0A=
80317a40 g     O .bss	00000004 nr_running=0A=
8021aae4 g     O .data	00000024 bdflush_max=0A=
8014b9e8 g     F .text	00000000 do_pipe=0A=
8021e6d4 g     O .data	00000004 sysctl_tcp_window_scaling=0A=
801ca18c g     F .text	00000000 tcp_send_delayed_ack=0A=
801fb850 g     O .kstrtab	0000000f __kstrtab_default_llseek=0A=
801ff2a0 g     O __ksymtab	00000008 __ksymtab_kill_pg_info=0A=
801a5d08 g     F .text	00000000 unregister_netdevice_notifier=0A=
80126a60 g     F .text	00000000 kill_sl_info=0A=
801d8fa4 g     F .text	00000000 inetdev_by_index=0A=
80185770 g     F .text	00000000 get_tty_driver=0A=
80198898 g     F .text	00000000 elevator_noop_merge_cleanup=0A=
8031d744 g     O .bss	00000004 jiffies=0A=
801a1378 g     F .text	00000000 sock_no_poll=0A=
801fabd8 g     O .kstrtab	00000012 __kstrtab_recalc_sigpending=0A=
8011f900 g     F .text	00000000 do_getitimer=0A=
802002e0 g     O __ksymtab	00000008 __ksymtab_sock_kmalloc=0A=
801577e8 g     F .text	00000000 sys_getcwd=0A=
80197b30 g     F .text	00000000 add_partition=0A=
801faedc g     O .kstrtab	00000012 __kstrtab_kmem_cache_shrink=0A=
801fc300 g     O .kstrtab	00000009 __kstrtab_strnicmp=0A=
801ff2f8 g     O __ksymtab	00000008 =
__ksymtab_notifier_chain_register=0A=
801fa82c g     O .kstrtab	0000000c __kstrtab___copy_user=0A=
80152d94 g     F .text	00000000 sys_poll=0A=
801fab2c g     O .kstrtab	00000013 __kstrtab_unregister_console=0A=
80316124 g     O .bss	00000004 _machine_halt=0A=
8015a7ac g     F .text	00000000 alloc_kiovec=0A=
8021ab08 g     O .data	00000008 bdflush_wait=0A=
80164444 g     F .text	00000000 proc_tty_register_driver=0A=
80170828 g     F .text	00000000 autofs4_init_ino=0A=
8031ecc8 g     O .bss	00000680 swap_info=0A=
8012ecb0 g     F .text	00000000 set_page_dirty=0A=
801dcd1c g     F .text	00000000 ip_dev_find=0A=
801a8ba0 g     F .text	00000000 __dst_free=0A=
801ffdb0 g     O __ksymtab	00000008 __ksymtab_open_exec=0A=
80219010 g     O .data	00000020 no_irq_type=0A=
802092b0 g     F .text.init	00000000 msg_init=0A=
801a5d30 g     F .text	00000000 dev_queue_xmit_nit=0A=
80219488 g     O .data	00000004 console_loglevel=0A=
801ab97c g     F .text	00000000 neigh_parms_release=0A=
8020ce68 g     F .text.init	00000000 arp_init=0A=
8012d100 g     F .text	00000000 vm_enough_memory=0A=
801ffee8 g     O __ksymtab	00000008 __ksymtab_cpu_raise_softirq=0A=
801fa9cc g     O .kstrtab	0000000a __kstrtab___ioremap=0A=
801a8abc g     F .text	00000000 dst_alloc=0A=
801d1d24 g     F .text	00000000 tcp_check_req=0A=
80172420 g     F .text	00000000 autofs4_wait=0A=
801ff7f8 g     O __ksymtab	00000008 __ksymtab_shrink_dcache_parent=0A=
8019d428 g     F .text	00000000 loop_register_transfer=0A=
80141bac g     F .text	00000000 sys_fdatasync=0A=
80200160 g     O __ksymtab	00000008 __ksymtab_sock_setsockopt=0A=
80132870 g     F .text	00000000 sys_madvise=0A=
801fb6a8 g     O .kstrtab	0000000b __kstrtab_vfs_unlink=0A=
801216a4 g     F .text	00000000 allocate_resource=0A=
801bfc20 g     F .text	00000000 tcp_init_cwnd=0A=
802001c8 g     O __ksymtab	00000008 __ksymtab_sock_no_accept=0A=
801fcb38 g     O .kstrtab	00000012 __kstrtab_skb_checksum_help=0A=
8016c76c g     F .text	00000000 ext2_warning=0A=
8010ee80 g     F .text	00000000 si_meminfo=0A=
80118f3c g     F .text	00000000 reparent_to_init=0A=
801fa878 g     O .kstrtab	0000001a =
__kstrtab___strlen_user_nocheck_asm=0A=
801fbb18 g     O .kstrtab	00000009 __kstrtab___mntput=0A=
801ff0e8 g     O __ksymtab	00000008 __ksymtab_strncat=0A=
802001c0 g     O __ksymtab	00000008 __ksymtab_sock_no_socketpair=0A=
801fa77c g     O .kstrtab	0000000e __kstrtab_mips_machtype=0A=
801d82fc g     F .text	00000000 in_dev_finish_destroy=0A=
8015d008 g     F .text	00000000 seq_read=0A=
801fc438 g     O .kstrtab	0000000f __kstrtab_fail_writepage=0A=
8021e6a4 g     O .data	00000004 tcp_orphan_count=0A=
80207924 g     F .text.init	00000000 free_area_init_node=0A=
801fcee4 g     O .kstrtab	00000012 __kstrtab_inet_add_protocol=0A=
8021bba8 g     O .data	00000040 ext2_file_inode_operations=0A=
801fb70c g     O .kstrtab	0000000e __kstrtab_poll_freewait=0A=
8021e740 g     O .data	00000004 sysctl_max_syn_backlog=0A=
801fc91c g     O .kstrtab	0000000c __kstrtab_sock_create=0A=
80205b3c g     F .text.init	0000005c except_vec0_r4k_250MHZhwbug=0A=
80218fa8 g     O .data	00000058 mips_cpu=0A=
801002a8 g     F .text	00000008 except_vec4=0A=
801a2828 g     F .text	00000000 skb_realloc_headroom=0A=
8021a070 g     O .data	00000004 cap_bset=0A=
8031ebf0 g     O .bss	00000004 max_mapnr=0A=
801e6278 g     F .text	00000000 sprintf=0A=
801fd028 g     O .kstrtab	00000010 __kstrtab_inet_stream_ops=0A=
8021ba70 g     O .data	00000004 warn_no_part=0A=
801987f0 g     F .text	00000000 elevator_noop_merge=0A=
801ff6c8 g     O __ksymtab	00000008 __ksymtab_ll_rw_block=0A=
801fccac g     O .kstrtab	00000011 __kstrtab_neigh_table_init=0A=
8010d290 g     F .text	00000060 init_fpu=0A=
801fd07c g     O .kstrtab	0000000c __kstrtab_ip_dev_find=0A=
80335df0 g     O .bss	00000014 serial_console=0A=
8021a0b8 g     O .data	00000000 timerlist_lock=0A=
801a56d0 g     F .text	00000000 dev_get=0A=
8015b9a8 g     F .text	00000000 may_umount=0A=
801ffb48 g     O __ksymtab	00000008 __ksymtab_add_wait_queue=0A=
80218f60 g     O .data	00000004 cpu_wait=0A=
80129620 g     F .text	00000000 sys_newuname=0A=
801ff660 g     O __ksymtab	00000008 __ksymtab_inode_setattr=0A=
801a0a50 g     F .text	00000000 sock_rfree=0A=
801fc410 g     O .kstrtab	00000011 __kstrtab_vm_max_readahead=0A=
801a0f28 g     F .text	00000000 __lock_sock=0A=
801faaa0 g     O .kstrtab	00000016 __kstrtab_abi_defhandler_libcso=0A=
801ac814 g     F .text	00000000 __netdev_watchdog_up=0A=
801ff4f8 g     O __ksymtab	00000008 __ksymtab_iput=0A=
8021e734 g     O .data	00000008 sysctl_local_port_range=0A=
8021aa8c g     O .data	00000000 files_lock=0A=
8013c4c4 g     F .text	00000000 swap_count=0A=
8015a110 g     F .text	00000000 alloc_fd_array=0A=
80108924 g     F .text	00000000 flush_thread=0A=
8011ea38 g     F .text	00000000 exit_files=0A=
801fc8a4 g     O .kstrtab	00000010 __kstrtab_skb_under_panic=0A=
80173940 g     F .text	00000000 ipc_findkey=0A=
801fcabc g     O .kstrtab	0000000d __kstrtab_sock_no_mmap=0A=
80209f2c g     F .text.init	00000000 rand_initialize=0A=
801fcfd0 g     O .kstrtab	0000000c __kstrtab_ip_fragment=0A=
801dced4 g     F .text	00000000 fib_validate_source=0A=
8021336c g     F .data	00000000 handle_dbe_int=0A=
80141250 g     F .text	00000000 unlock_buffer=0A=
801cc130 g     F .text	00000000 tcp_listen_wlock=0A=
801ffea8 g     O __ksymtab	00000008 __ksymtab_bh_task_vec=0A=
8014d000 g     F .text	00000000 path_walk=0A=
8010b2b0 g     F .text	00000000 do_reserved=0A=
80173c5c g     F .text	00000000 ipc_free=0A=
80167ea0 g     F .text	00000000 ext2_bg_num_gdb=0A=
8014ed8c g     F .text	00000000 vfs_symlink=0A=
80151090 g     F .text	00000000 sys_fcntl64=0A=
801a3b5c g     F .text	00000000 memcpy_fromiovecend=0A=
80176f3c g     F .text	00000000 sem_exit=0A=
801a1130 g     F .text	00000000 sklist_insert_socket=0A=
801faf98 g     O .kstrtab	00000008 __kstrtab_init_mm=0A=
801fb6cc g     O .kstrtab	00000011 __kstrtab_generic_read_dir=0A=
801fcd90 g     O .kstrtab	0000000f __kstrtab_pneigh_enqueue=0A=
801272ac g     F .text	00000000 sys_rt_sigtimedwait=0A=
8021bf40 g     O .data	00000048 autofs4_root_operations=0A=
801fc714 g     O .kstrtab	0000000e __kstrtab_blk_get_queue=0A=
801fbf84 g     O .kstrtab	00000008 __kstrtab_jiffies=0A=
801a4bec g     F .text	00000000 __scm_send=0A=
80129984 g     F .text	00000000 sys_old_getrlimit=0A=
801ffae8 g     O __ksymtab	00000008 __ksymtab_sysctl_jiffies=0A=
8017bc0c g     F .text	00000000 ieee754sp_nanxcpt=0A=
801fb728 g     O .kstrtab	00000010 __kstrtab___find_get_page=0A=
80149744 g     F .text	00000000 put_dirty_page=0A=
80151290 g     F .text	00000000 send_sigio=0A=
801ff560 g     O __ksymtab	00000008 __ksymtab_d_alloc_root=0A=
8012eba4 g     F .text	00000000 __remove_inode_page=0A=
80321110 g     O .bss	00000004 ieee754_csr=0A=
801ff810 g     O __ksymtab	00000008 __ksymtab_get_unused_fd=0A=
801dd1ac g     F .text	00000000 ip_rt_ioctl=0A=
801fc724 g     O .kstrtab	00000012 __kstrtab_blk_cleanup_queue=0A=
8014182c g     F .text	00000000 fsync_super=0A=
80142884 g     F .text	00000000 osync_inode_data_buffers=0A=
80149528 g     F .text	00000000 copy_strings=0A=
8011927c g     F .text	00000000 request_dma=0A=
80159500 g     F .text	00000000 igrab=0A=
801b1da0 g     F .text	00000000 inet_del_protocol=0A=
801fb784 g     O .kstrtab	0000000d __kstrtab_vfs_readlink=0A=
80200740 g     O *ABS*	00000000 __stop___ksymtab=0A=
80183c04 g     F .text	00000000 ieee754sp_fulong=0A=
80142440 g     F .text	00000000 fsync_inode_buffers=0A=
801ff198 g     O __ksymtab	00000008 __ksymtab___up=0A=
801fcc8c g     O .kstrtab	0000000d __kstrtab_sock_kmalloc=0A=
80182920 g     F .text	00000000 ieee754sp_scalb=0A=
801fb994 g     O .kstrtab	0000000e __kstrtab_set_device_ro=0A=
80140c28 g     F .text	00000000 cdevname=0A=
801fbaac g     O .kstrtab	00000015 __kstrtab_tty_flip_buffer_push=0A=
801fa838 g     O .kstrtab	00000008 __kstrtab___bzero=0A=
80212db0 g     O .data	00000004 child_reaper=0A=
80318a54 g     O .bss	00000004 mm_cachep=0A=
80125dec g     F .text	00000000 unblock_all_signals=0A=
801fc780 g     O .kstrtab	00000017 __kstrtab_blkdev_release_request=0A=
801a9eb8 g     F .text	00000000 neigh_destroy=0A=
801e4870 g     F .text	00000034 __strnlen_user_asm=0A=
8021db9c g     O .data	0000000c dst_dev_notifier=0A=
80200378 g     O __ksymtab	00000008 __ksymtab_neigh_compat_output=0A=
80168fa0 g     F .text	00000000 ext2_sync_file=0A=
80207170 g     F .text.init	00000000 free_all_bootmem=0A=
80200038 g     O __ksymtab	00000008 __ksymtab_unregister_serial=0A=
80135644 g     F .text	00000000 vfree=0A=
80142d40 g     F .text	00000000 bread=0A=
8021bd48 g     O .data	00000040 autofs_dir_inode_operations=0A=
801fb2d0 g     O .kstrtab	00000010 __kstrtab_inode_change_ok=0A=
8013fc40 g     F .text	00000000 generic_read_dir=0A=
8015fd20 g     F .text	00000000 de_get=0A=
801fbce0 g     O .kstrtab	00000019 =
__kstrtab_add_wait_queue_exclusive=0A=
801d3994 g     F .text	00000000 udp_err=0A=
8021ae30 g     O .data	00000040 page_symlink_inode_operations=0A=
80156cec g     F .text	00000000 have_submounts=0A=
801fb71c g     O .kstrtab	00000009 __kstrtab_ROOT_DEV=0A=
801ff8d8 g     O __ksymtab	00000008 =
__ksymtab_page_symlink_inode_operations=0A=
801377d4 g     F .text	00000000 lru_cache_add=0A=
801fb5c4 g     O .kstrtab	0000000f __kstrtab_have_submounts=0A=
801fd2c8 g     O .kstrtab	00000010 __kstrtab_dev_get_by_name=0A=
801197b4 g     F .text	00000000 mmput=0A=
801fc424 g     O .kstrtab	00000011 __kstrtab_vm_min_readahead=0A=
8010a748 g     F .text	00000000 show_trace=0A=
8017f370 g     F .text	00000000 ieee754dp_copysign=0A=
801fc008 g     O .kstrtab	0000000a __kstrtab_vsnprintf=0A=
8010bc80 g     F .text	00000000 __up=0A=
8012bca4 g     F .text	00000000 unlock_kiovec=0A=
802002e8 g     O __ksymtab	00000008 __ksymtab_sock_kfree_s=0A=
801fbe28 g     O .kstrtab	00000011 __kstrtab_request_resource=0A=
8031d360 g     O .bss	00000004 pps_errcnt=0A=
801744ac g     F .text	00000000 sys_msgctl=0A=
801ff700 g     O __ksymtab	00000008 __ksymtab_block_read_full_page=0A=
8021ab10 g     O .data	00000008 super_blocks=0A=
801fcd58 g     O .kstrtab	0000000d __kstrtab_neigh_ifdown=0A=
801987a4 g     F .text	00000000 elevator_linus_merge_cleanup=0A=
80200478 g     O __ksymtab	00000008 __ksymtab_ip_mc_inc_group=0A=
80200170 g     O __ksymtab	00000008 __ksymtab_sock_sendmsg=0A=
801ff0d8 g     O __ksymtab	00000008 __ksymtab_strlen=0A=
8020cd74 g     F .text.init	00000000 tcp_v4_init=0A=
801e51d4 g     F .text	00000000 strsep=0A=
80316000 g     O .bss	00000040 root_device_name=0A=
8020d00c g     F .text.init	00000000 devinet_init=0A=
8010bc00 g     F .text	00000000 sys_ioperm=0A=
80162d60 g     F .text	00000000 free_proc_entry=0A=
801fff78 g     O __ksymtab	00000008 __ksymtab_proc_sys_root=0A=
8010a4e0 g     O .text	00000000 ret_from_fork=0A=
80120a78 g     F .text	00000000 open_softirq=0A=
802005b0 g     O __ksymtab	00000008 __ksymtab_dev_new_index=0A=
8013c6d0 g     F .text	00000000 valid_swaphandles=0A=
801259d4 g     F .text	00000000 alloc_uid=0A=
802002b0 g     O __ksymtab	00000008 __ksymtab___pskb_pull_tail=0A=
801e803c g     F .text	00000000 set_mqb_handler=0A=
801fca60 g     O .kstrtab	00000011 __kstrtab_sock_no_shutdown=0A=
801ff320 g     O __ksymtab	00000008 __ksymtab_in_group_p=0A=
8017ef60 g     F .text	00000000 ieee754dp_logb=0A=
801a3c38 g     F .text	00000000 csum_partial_copy_fromiovecend=0A=
8021cbb8 g     O .data	00000000 io_request_lock=0A=
801ff3a8 g     O __ksymtab	00000008 __ksymtab_exit_files=0A=
801ff630 g     O __ksymtab	00000008 __ksymtab_invalidate_inode_pages=0A=
801ffb58 g     O __ksymtab	00000008 __ksymtab_remove_wait_queue=0A=
80146758 g     F .text	00000000 put_unnamed_dev=0A=
801ff6a8 g     O __ksymtab	00000008 __ksymtab_bdput=0A=
801fca9c g     O .kstrtab	00000010 __kstrtab_sock_no_sendmsg=0A=
801db5f8 g     F .text	00000000 inet_sendmsg=0A=
801ffdf8 g     O __ksymtab	00000008 __ksymtab_read_ahead=0A=
8020c1e8 g     F .text.init	00000000 netdev_boot_setup=0A=
80208e64 g     F .text.init	00000000 proc_tty_init=0A=
801ff3e8 g     O __ksymtab	00000008 __ksymtab_page_cache_release=0A=
8015a90c g     F .text	00000000 expand_kiobuf=0A=
801ff440 g     O __ksymtab	00000008 __ksymtab_kfree=0A=
803208b0 g     O .bss	00000004 names_cachep=0A=
802063dc g     F .text.init	00000000 signals_init=0A=
80150188 g     F .text	00000000 vfs_readlink=0A=
801ffcc0 g     O __ksymtab	00000008 __ksymtab_nr_running=0A=
8013cae4 g     F .text	00000000 out_of_memory=0A=
8021cbc8 g     O .data	00000004 rd_prompt=0A=
801886bc g     F .text	00000000 tty_register_driver=0A=
80218f6c g     O .data	00000004 mips_machgroup=0A=
8014df00 g     F .text	00000000 vfs_mknod=0A=
801fba3c g     O .kstrtab	0000000e __kstrtab_refile_buffer=0A=
80145f50 g     F .text	00000000 get_fs_type=0A=
8012797c g     F .text	00000000 do_sigaltstack=0A=
802002c8 g     O __ksymtab	00000008 __ksymtab_skb_realloc_headroom=0A=
801d7078 g     F .text	00000000 arp_ifdown=0A=
80144bb4 g     F .text	00000000 brw_page=0A=
801277a8 g     F .text	00000000 do_sigaction=0A=
801348a8 g     F .text	00000000 sys_mlockall=0A=
801ff0b8 g     O __ksymtab	00000008 __ksymtab_memmove=0A=
801fc934 g     O .kstrtab	0000000d __kstrtab_sock_release=0A=
801ff868 g     O __ksymtab	00000008 __ksymtab_generic_file_llseek=0A=
801a7ca8 g     F .text	00000000 dev_new_index=0A=
8015a6a8 g     F .text	00000000 alloc_kiobuf_bhs=0A=
801ffd98 g     O __ksymtab	00000008 __ksymtab_do_execve=0A=
8017fd30 g     F .text	00000000 ieee754dp_fint=0A=
801ff388 g     O __ksymtab	00000008 __ksymtab_do_mmap_pgoff=0A=
801fccd4 g     O .kstrtab	00000015 __kstrtab_neigh_resolve_output=0A=
801fd038 g     O .kstrtab	0000000f __kstrtab_inet_dgram_ops=0A=
8013e108 g     F .text	00000000 do_truncate=0A=
8021ec54 g     O .data	00000004 sysctl_icmp_ratemask=0A=
801ffc90 g     O __ksymtab	00000008 __ksymtab_jiffies=0A=
801be274 g     F .text	00000000 tcp_accept=0A=
80142e84 g     F .text	00000000 put_unused_buffer_head=0A=
80197e1c g     F .text	00000000 blkpg_ioctl=0A=
80315101 g     O .data	00000000 __rd_end=0A=
801250f4 g     F .text	00000000 update_process_times=0A=
801e3150 g     F .text	00000000 unix_inflight=0A=
80316500 g     O .bss	00001534 kstat=0A=
801e7b58 g     F .text	00000000 getDebugChar=0A=
8021e6e4 g     O .data	00000004 sysctl_tcp_ecn=0A=
801fb288 g     O .kstrtab	0000000a __kstrtab_fsync_dev=0A=
801faf04 g     O .kstrtab	00000010 __kstrtab_kmem_cache_free=0A=
80331894 g     O .bss	000003fc max_readahead=0A=
8021e080 g     O .data	00000000 qdisc_tree_lock=0A=
801492d0 g     F .text	00000000 register_binfmt=0A=
8019d80c g     F .text	00000000 init_etherdev=0A=
801e4e30 g     F .text	00000000 strnicmp=0A=
8013f51c g     F .text	00000000 dentry_open=0A=
8021fd80 g     O .data	00000058 unix_table=0A=
801fc294 g     O .kstrtab	0000000f __kstrtab_fs_overflowuid=0A=
801fb014 g     O .kstrtab	00000008 __kstrtab_iunique=0A=
801fb258 g     O .kstrtab	00000017 __kstrtab_invalidate_inode_pages=0A=
801ff6e8 g     O __ksymtab	00000008 __ksymtab____wait_on_page=0A=
801ff178 g     O __ksymtab	00000008 __ksymtab_invalid_pte_table=0A=
80200270 g     O __ksymtab	00000008 __ksymtab_skb_copy_datagram=0A=
801ff480 g     O __ksymtab	00000008 __ksymtab_find_vma=0A=
801514c0 g     F .text	00000000 __kill_fasync=0A=
801fbd88 g     O .kstrtab	0000000c __kstrtab_free_kiovec=0A=
8032911c g     O .bss	00007b84 blk_dev=0A=
8016c6c4 g     F .text	00000000 ext2_panic=0A=
8015679c g     F .text	00000000 d_find_alias=0A=
801a7338 g     F .text	00000000 dev_set_allmulti=0A=
801fac30 g     O .kstrtab	00000018 __kstrtab_notifier_chain_register=0A=
80320c44 g     O .bss	00000004 proc_root_kcore=0A=
8012f370 g     F .text	00000000 invalidate_inode_pages2=0A=
80150230 g     F .text	00000000 vfs_follow_link=0A=
801ff0e0 g     O __ksymtab	00000008 __ksymtab_strpbrk=0A=
8011f9a8 g     F .text	00000000 sys_getitimer=0A=
80200558 g     O __ksymtab	00000008 __ksymtab_xrlim_allow=0A=
801a4040 g     F .text	00000000 skb_recv_datagram=0A=
801ff118 g     O __ksymtab	00000008 __ksymtab_kernel_thread=0A=
801fd344 g     O .kstrtab	0000000a __kstrtab_skb_clone=0A=
8013fa64 g     F .text	00000000 filp_close=0A=
8021c200 g     O .data	00000004 shm_ctlmax=0A=
80143b38 g     F .text	00000000 block_read_full_page=0A=
8012ae70 g     F .text	00000000 flush_scheduled_tasks=0A=
801d5190 g     F .text	00000000 udp_get_info=0A=
8010cce0 g     F .text	00000000 do_ade=0A=
801ff6b8 g     O __ksymtab	00000008 __ksymtab___brelse=0A=
801fb2b0 g     O .kstrtab	0000000f __kstrtab_vfs_permission=0A=
80197a1c g     F .text	00000000 drive_stat_acct=0A=
8015bd5c g     F .text	00000000 sys_oldumount=0A=
801b485c g     F .text	00000000 ip_options_undo=0A=
802004d8 g     O __ksymtab	00000008 __ksymtab_ip_rt_ioctl=0A=
80156738 g     F .text	00000000 dget_locked=0A=
8010b2cc g     F .text	00000000 cache_parity_error=0A=
801432a0 g     F .text	00000000 discard_bh_page=0A=
801ab6e0 g     F .text	00000000 pneigh_enqueue=0A=
801d0804 g     F .text	00000000 tcp_inherit_port=0A=
801fb650 g     O .kstrtab	0000000e __kstrtab_get_unused_fd=0A=
801fb678 g     O .kstrtab	0000000a __kstrtab_vfs_mknod=0A=
80200120 g     O __ksymtab	00000008 __ksymtab_sock_unregister=0A=
801cc840 g     F .text	00000000 tcp_v4_hash_connecting=0A=
8021e720 g     O .data	00000004 sysctl_tcp_keepalive_intvl=0A=
8012fa90 g     F .text	00000000 add_to_page_cache_unique=0A=
801fab40 g     O .kstrtab	0000000f __kstrtab_dequeue_signal=0A=
801e6980 g     F .text	00000000 get_options=0A=
801faba0 g     O .kstrtab	0000000f __kstrtab_kill_proc_info=0A=
8020458c g     F .text.init	00000000 paging_init=0A=
80334d00 g     O .bss	00000080 tcp_statistics=0A=
80133f38 g     F .text	00000000 sys_mprotect=0A=
80200728 g     O __ksymtab	00000008 __ksymtab___down_write=0A=
8010bc34 g     F .text	00000000 machine_halt=0A=
80200738 g     O __ksymtab	00000008 __ksymtab___up_write=0A=
8021d7c4 g     O .data	00000000 dev_base_lock=0A=
801ff190 g     O __ksymtab	00000008 __ksymtab___down_trylock=0A=
80151018 g     F .text	00000000 sys_fcntl=0A=
8021c7a0 g     O .data	00000048 urandom_fops=0A=
801fb338 g     O .kstrtab	00000006 __kstrtab_bread=0A=
80127aa8 g     F .text	00000000 sys_sigpending=0A=
80129a1c g     F .text	00000000 sys_setrlimit=0A=
801ff230 g     O __ksymtab	00000008 __ksymtab_abi_defhandler_libcso=0A=
80162dc8 g     F .text	00000000 remove_proc_entry=0A=
801aba74 g     F .text	00000000 neigh_table_init=0A=
80123ce0 g     F .text	00000000 ptrace_check_attach=0A=
801fab6c g     O .kstrtab	0000000f __kstrtab_force_sig_info=0A=
801ffa60 g     O __ksymtab	00000008 __ksymtab_do_SAK=0A=
80219560 g     O .data	00000004 pps_valid=0A=
80212fa0 g     F .data	00000100 handle_adel=0A=
80149868 g     F .text	00000000 setup_arg_pages=0A=
801a1674 g     F .text	00000000 sock_def_destruct=0A=
803164c4 g     O .bss	00000004 _flush_icache_page=0A=
80129840 g     F .text	00000000 sys_setdomainname=0A=
80185334 g     F .text	00000000 tty_name=0A=
801fff38 g     O __ksymtab	00000008 __ksymtab_generic_file_open=0A=
801fc4a0 g     O .kstrtab	00000017 __kstrtab_get_unused_buffer_head=0A=
801ff9d0 g     O __ksymtab	00000008 =
__ksymtab_devfs_register_partitions=0A=
801a1370 g     F .text	00000000 sock_no_getname=0A=
801fa990 g     O .kstrtab	00000013 __kstrtab_disable_irq_nosync=0A=
80200398 g     O __ksymtab	00000008 __ksymtab_net_ratelimit=0A=
801ff1a0 g     O __ksymtab	00000008 __ksymtab_get_wchan=0A=
80318a50 g     O .bss	00000004 vm_area_cachep=0A=
8021db78 g     O .data	00000004 mod_cong=0A=
801fc1a8 g     O .kstrtab	00000019 =
__kstrtab_fsync_inode_data_buffers=0A=
80168cd0 g     F .text	00000000 ext2_make_empty=0A=
8010c06c g     F .text	00000000 sys_mmap2=0A=
801fb1f4 g     O .kstrtab	00000012 __kstrtab_check_disk_change=0A=
801a5ce0 g     F .text	00000000 register_netdevice_notifier=0A=
801ff760 g     O __ksymtab	00000008 __ksymtab_generic_ro_fops=0A=
801e9170 g     O .text	00000004 mips_io_port_base=0A=
802089dc g     F .text.init	00000000 change_root=0A=
80170d80 g     F .text	00000000 autofs4_read_super=0A=
80210038 g     O *ABS*	00000000 __initcall_start=0A=
80219494 g     O .data	00000004 default_console_loglevel=0A=
8015d950 g     F .text	00000000 seq_printf=0A=
801ff6b0 g     O __ksymtab	00000008 __ksymtab_bread=0A=
80316084 g     O .bss	00000004 dbe_board_handler=0A=
8021a4a0 g     O .data	00000000 swaplock=0A=
8021e6e0 g     O .data	00000004 sysctl_tcp_reordering=0A=
801fcacc g     O .kstrtab	00000011 __kstrtab_sock_no_sendpage=0A=
8019e318 g     F .text	00000000 sock_recvmsg=0A=
801fc8f0 g     O .kstrtab	00000011 __kstrtab_memcpy_fromiovec=0A=
801246d0 g     F .text	00000000 init_timervecs=0A=
80200368 g     O __ksymtab	00000008 __ksymtab_neigh_parms_release=0A=
8011c0a0 g     F .text	00000000 inter_module_register=0A=
80334ca0 g     O .bss	00000004 ip_ra_chain=0A=
802005f8 g     O __ksymtab	00000008 __ksymtab___kfree_skb=0A=
802001d8 g     O __ksymtab	00000008 __ksymtab_sock_no_poll=0A=
801ffd20 g     O __ksymtab	00000008 __ksymtab_system_utsname=0A=
801761f4 g     F .text	00000000 semctl_main=0A=
801564c0 g     F .text	00000000 dput=0A=
801ff970 g     O __ksymtab	00000008 __ksymtab_unregister_blkdev=0A=
801ffcf0 g     O __ksymtab	00000008 __ksymtab_vsnprintf=0A=
8021e680 g     O .data	00000004 sysctl_ip_dynaddr=0A=
801b6f50 g     F .text	00000000 ip_send_check=0A=
801fd51c g     O .kstrtab	0000000d __kstrtab_softnet_data=0A=
8010b294 g     F .text	00000000 do_mcheck=0A=
8019f0a0 g     F .text	00000000 sys_connect=0A=
8020350c g     F .text.init	00000000 check_bugs=0A=
801fc6c4 g     O .kstrtab	00000010 __kstrtab_io_request_lock=0A=
80211800 g     O .data.cacheline_aligned	00000000 runqueue_lock=0A=
801ff288 g     O __ksymtab	00000008 __ksymtab_force_sig=0A=
801ffb10 g     O __ksymtab	00000008 =
__ksymtab_proc_doulongvec_ms_jiffies_minmax=0A=
80167ef0 g     F .text	00000000 ext2_count_free=0A=
8019ed44 g     F .text	00000000 sys_socketpair=0A=
80134bc8 g     F .text	00000000 do_mremap=0A=
8021396c g     F .data	00000000 handle_fpe_int=0A=
801ffe70 g     O __ksymtab	00000008 __ksymtab_get_write_access=0A=
8011fc70 g     F .text	00000000 sys_sysinfo=0A=
801ff988 g     O __ksymtab	00000008 __ksymtab_tty_std_termios=0A=
80108cc8 g     F .text	00000000 get_wchan=0A=
801ff5c0 g     O __ksymtab	00000008 __ksymtab_set_buffer_async_io=0A=
801ffeb8 g     O __ksymtab	00000008 __ksymtab_remove_bh=0A=
801fc398 g     O .kstrtab	0000000e __kstrtab_raise_softirq=0A=
801fa7a8 g     O .kstrtab	00000007 __kstrtab_memcpy=0A=
8021c118 g     O .data	00000040 devpts_root_inode_operations=0A=
801ff670 g     O __ksymtab	00000008 __ksymtab_write_inode_now=0A=
801ff920 g     O __ksymtab	00000008 __ksymtab_dentry_open=0A=
802000a0 g     O __ksymtab	00000008 __ksymtab_gendisk_head=0A=
80117180 g     F .text	00000180 handle_tlbs=0A=
8013a01c g     F .text	00000000 show_free_areas=0A=
801ffef0 g     O __ksymtab	00000008 __ksymtab___tasklet_schedule=0A=
801fd590 g     O *ABS*	00000000 __start___ex_table=0A=
801a2150 g     F .text	00000000 skb_copy=0A=
801fc448 g     O .kstrtab	00000011 __kstrtab_shmem_file_setup=0A=
80212f60 g     O .data	00000004 last_task_used_math=0A=
80144510 g     F .text	00000000 generic_direct_IO=0A=
801e5360 g     F .text	00000000 simple_strtoul=0A=
801a5694 g     F .text	00000000 dev_get_by_name=0A=
801a1e4c g     F .text	00000000 skb_clone=0A=
801fc358 g     O .kstrtab	0000000d __kstrtab_tasklet_init=0A=
801181d4 g     F .text	00000000 interruptible_sleep_on=0A=
801b74dc g     F .text	00000000 ip_ra_control=0A=
801f11a8 g     O .text	00000044 __ieee754sp_spcvals=0A=
801ffd68 g     O __ksymtab	00000008 __ksymtab_cap_bset=0A=
801fc14c g     O .kstrtab	0000000f __kstrtab_flush_old_exec=0A=
801405f4 g     F .text	00000000 sys_pread=0A=
80145a90 g     F .text	00000000 __mark_dirty=0A=
80200190 g     O __ksymtab	00000008 __ksymtab_sock_wake_async=0A=
801fc470 g     O .kstrtab	00000015 __kstrtab_set_buffer_flushtime=0A=
80318a60 g     O .bss	00000004 sigact_cachep=0A=
8012f724 g     F .text	00000000 filemap_fdatasync=0A=
801552b0 g     F .text	00000000 sys_flock=0A=
801ff0a8 g     O __ksymtab	00000008 __ksymtab_memset=0A=
801ff510 g     O __ksymtab	00000008 __ksymtab_follow_down=0A=
801ff7c0 g     O __ksymtab	00000008 __ksymtab_locks_mandatory_area=0A=
8017f350 g     F .text	00000000 ieee754dp_finite=0A=
8014a240 g     F .text	00000000 compute_creds=0A=
801ffd70 g     O __ksymtab	00000008 __ksymtab_reparent_to_init=0A=
80120780 g     F .text	00000000 sys_adjtimex=0A=
801ad1b0 g     F .text	00000000 in_ntoa=0A=
80148430 g     F .text	00000000 blkdev_open=0A=
801fc548 g     O .kstrtab	00000012 __kstrtab_remove_proc_entry=0A=
8017b080 g     F .text	00000000 ieee754dp_class=0A=
801da464 g     F .text	00000000 inet_setsockopt=0A=
801d7460 g     F .text	00000000 icmp_send=0A=
801fab94 g     O .kstrtab	0000000a __kstrtab_kill_proc=0A=
8031604c g     O .bss	00000004 execute_command=0A=
801fab18 g     O .kstrtab	00000011 __kstrtab_register_console=0A=
8021a0b4 g     O .data	00000004 time_freq=0A=
801fcc9c g     O .kstrtab	0000000d __kstrtab_sock_kfree_s=0A=
801ff980 g     O __ksymtab	00000008 __ksymtab_tty_unregister_driver=0A=
801974e8 g     F .text	00000000 ll_rw_block=0A=
80218f68 g     O .data	00000004 mips_machtype=0A=
8021e218 g     O .data	00000004 ip_rt_redirect_load=0A=
8021cc80 g     O .data	0000001c xor_funcs=0A=
801ff470 g     O __ksymtab	00000008 __ksymtab_high_memory=0A=
801ff200 g     O __ksymtab	00000008 __ksymtab_register_exec_domain=0A=
80316000 g     O *ABS*	00000000 _edata=0A=
80143e18 g     F .text	00000000 cont_prepare_write=0A=
8015a874 g     F .text	00000000 free_kiovec=0A=
8012d044 g     F .text	00000000 make_pages_present=0A=
801b67d0 g     F .text	00000000 ip_fragment=0A=
801fb914 g     O .kstrtab	00000014 __kstrtab_tty_register_driver=0A=
8013dfa8 g     F .text	00000000 sys_statfs=0A=
801a044c g     F .text	00000000 sock_getsockopt=0A=
801ff7e0 g     O __ksymtab	00000008 __ksymtab_d_prune_aliases=0A=
801fa900 g     O .kstrtab	00000011 __kstrtab__flush_cache_all=0A=
801fbd68 g     O .kstrtab	0000000d __kstrtab_tq_immediate=0A=
8012b0e4 g     F .text	00000000 copy_page_range=0A=
801ff978 g     O __ksymtab	00000008 __ksymtab_tty_register_driver=0A=
801fc9a8 g     O .kstrtab	00000014 __kstrtab_sock_alloc_send_skb=0A=
801a36f8 g     F .text	00000000 skb_copy_and_csum_dev=0A=
801faf78 g     O .kstrtab	00000009 __kstrtab_find_vma=0A=
801fad10 g     O .kstrtab	00000016 __kstrtab_flush_scheduled_tasks=0A=
801fc344 g     O .kstrtab	00000008 __kstrtab_init_bh=0A=
8019e1bc g     F .text	00000000 sock_release=0A=
801262b0 g     F .text	00000000 bad_signal=0A=
80336420 g     O .bss	00000000 _end=0A=
801ffe90 g     O __ksymtab	00000008 __ksymtab_strsep=0A=
801fb504 g     O .kstrtab	00000010 __kstrtab_page_hash_table=0A=
80157b28 g     F .text	00000000 find_inode_number=0A=
801bad04 g     F .text	00000000 tcp_sendpage=0A=
8031ec84 g     O .bss	00000004 nr_swap_pages=0A=
801346c4 g     F .text	00000000 sys_mlock=0A=
801ff120 g     O __ksymtab	00000008 __ksymtab___copy_user=0A=
801fc894 g     O .kstrtab	0000000f __kstrtab_skb_over_panic=0A=
801fcc04 g     O .kstrtab	00000010 __kstrtab_skb_copy_expand=0A=
8011ad18 g     F .text	00000000 sys_personality=0A=
801e7068 g     F .text	00000000 __down_write=0A=
8013fd30 g     F .text	00000000 no_llseek=0A=
801419b4 g     F .text	00000000 sys_sync=0A=
8021a090 g     O .data	00000008 tq_immediate=0A=
80200518 g     O __ksymtab	00000008 __ksymtab_rtnl_sem=0A=
8011bc94 g     F .text	00000000 console_print=0A=
801faeb4 g     O .kstrtab	00000012 __kstrtab_kmem_cache_create=0A=
801fabc8 g     O .kstrtab	0000000e __kstrtab_notify_parent=0A=
80212f48 g     O .data	00000004 linux_banner=0A=
8011fa88 g     F .text	00000000 do_setitimer=0A=
801ffd10 g     O __ksymtab	00000008 __ksymtab_cdevname=0A=
801ff4a8 g     O __ksymtab	00000008 __ksymtab_get_fs_type=0A=
80120b64 g     F .text	00000000 __tasklet_hi_schedule=0A=
8021e000 g     O .data	00000010 rtnl_sem=0A=
8016d4e0 g     F .text	00000000 ext2_read_super=0A=
8031ec90 g     O .bss	00000008 active_list=0A=
8021fd64 g     O .data	00000004 unix_tot_inflight=0A=
801490fc g     F .text	00000000 sys_stat64=0A=
801e7264 g     F .text	00000000 idisx_hw1_irqdispatch=0A=
8021ea00 g     O .data	000001b0 arp_tbl=0A=
801cdfc4 g     F .text	00000000 tcp_v4_conn_request=0A=
8013fbf4 g     F .text	00000000 generic_file_open=0A=
801293c8 g     F .text	00000000 sys_getsid=0A=
801ff1d0 g     O __ksymtab	00000008 __ksymtab_probe_irq_mask=0A=
801306a0 g     F .text	00000000 do_generic_file_read=0A=
801fc798 g     O .kstrtab	00000016 __kstrtab_generic_unplug_device=0A=
801ff7a0 g     O __ksymtab	00000008 __ksymtab_posix_test_lock=0A=
8021a0f8 g     O .data	00000004 fs_overflowuid=0A=
80185c78 g     F .text	00000000 tty_hung_up_p=0A=
801abe10 g     F .text	00000000 rtnl_lock=0A=
80200098 g     O __ksymtab	00000008 __ksymtab_blk_ioctl=0A=
8031d35c g     O .bss	00000004 pps_calcnt=0A=
801ced10 g     F .text	00000000 tcp_v4_rcv=0A=
80128064 g     F .text	00000000 sys_ni_syscall=0A=
80200008 g     O __ksymtab	00000008 __ksymtab_add_mouse_randomness=0A=
8014fe70 g     F .text	00000000 sys_rename=0A=
801ff568 g     O __ksymtab	00000008 __ksymtab_d_delete=0A=
8010c6c8 g     F .text	00000000 sys_cachectl=0A=
80182af8 g     F .text	00000000 ieee754sp_copysign=0A=
801096b0 g     F .text	00000000 sys_sigreturn=0A=
801778b8 g     F .text	00000000 sys_shmget=0A=
801fac08 g     O .kstrtab	00000012 __kstrtab_block_all_signals=0A=
801002b0 g     F .text	00000008 except_vec_ejtag_debug=0A=
801fbbf8 g     O .kstrtab	0000000f __kstrtab_sysctl_jiffies=0A=
801ff8b0 g     O __ksymtab	00000008 __ksymtab_read_cache_page=0A=
801e79c0 g     F .text	00000000 rs_kgdb_hook=0A=
8021e724 g     O .data	00000004 sysctl_tcp_retries1=0A=
80197890 g     F .text	00000000 end_that_request_last=0A=
802005e8 g     O __ksymtab	00000008 __ksymtab_eth_type_trans=0A=
801411e4 g     F .text	00000000 fs_may_remount_ro=0A=
8015a160 g     F .text	00000000 free_fd_array=0A=
801a13a8 g     F .text	00000000 sock_no_fcntl=0A=
80121038 g     F .text	00000000 init_bh=0A=
80203c18 g     F .text.init	00000000 add_memory_region=0A=
801fc3bc g     O .kstrtab	00000013 __kstrtab___tasklet_schedule=0A=
8010faf4 g     F .text	000000c0 r4k_copy_page_r4600_v1=0A=
801633dc g     F .text	00000000 proc_pid_stat=0A=
801faf40 g     O .kstrtab	00000011 __kstrtab_remap_page_range=0A=
8031fc10 g     O .bss	00000002 ROOT_DEV=0A=
801fd31c g     O .kstrtab	0000000f __kstrtab_eth_type_trans=0A=
80166264 g     F .text	00000000 register_disk=0A=
801ff7a8 g     O __ksymtab	00000008 __ksymtab_posix_block_lock=0A=
801ff468 g     O __ksymtab	00000008 __ksymtab_max_mapnr=0A=
80120064 g     F .text	00000000 do_sys_settimeofday=0A=
8015a0f8 g     F .text	00000000 is_bad_inode=0A=
80159794 g     F .text	00000000 remove_inode_hash=0A=
80334080 g     O .bss	00000004 gendisk_head=0A=
8014113c g     F .text	00000000 put_filp=0A=
801c8890 g     F .text	00000000 tcp_retransmit_skb=0A=
801ffc88 g     O __ksymtab	00000008 __ksymtab_schedule_timeout=0A=
8016e568 g     F .text	00000000 autofs_hash_insert=0A=
801fb774 g     O .kstrtab	00000010 __kstrtab_read_cache_page=0A=
803352e0 g     O .bss	00000040 udp_statistics=0A=
80200510 g     O __ksymtab	00000008 __ksymtab_sklist_remove_socket=0A=
80122a4c g     F .text	00000000 proc_dointvec=0A=
80119444 g     F .text	00000000 remove_wait_queue=0A=
80118a0c g     F .text	00000000 sys_sched_get_priority_max=0A=
8021e670 g     O .data	00000004 ip_frag_mem=0A=
802043e4 g     F .text.init	00000000 init_8259A=0A=
801fbb0c g     O .kstrtab	0000000b __kstrtab_kern_mount=0A=
8010c214 g     F .text	00000000 sys_execve=0A=
80200128 g     O __ksymtab	00000008 __ksymtab___lock_sock=0A=
801fbd50 g     O .kstrtab	0000000a __kstrtab_mod_timer=0A=
801ffca0 g     O __ksymtab	00000008 __ksymtab_do_gettimeofday=0A=
802060c0 g     F .text.init	00000000 init_modules=0A=
802093d0 g     F .text.init	00000000 chr_dev_init=0A=
80136b64 g     F .text	00000000 kmalloc=0A=
80183208 g     F .text	00000000 ieee754sp_tuns=0A=
801a1380 g     F .text	00000000 sock_no_ioctl=0A=
801ffb18 g     O __ksymtab	00000008 __ksymtab_proc_doulongvec_minmax=0A=
80200508 g     O __ksymtab	00000008 __ksymtab_dev_set_promiscuity=0A=
801fc834 g     O .kstrtab	0000000f __kstrtab_alloc_etherdev=0A=
8011ab08 g     F .text	00000000 unregister_exec_domain=0A=
801fb8cc g     O .kstrtab	00000010 __kstrtab_register_chrdev=0A=
801dc898 g     F .text	00000000 ip_mc_leave_group=0A=
801fadcc g     O .kstrtab	00000007 __kstrtab_do_brk=0A=
801ca440 g     F .text	00000000 tcp_write_wakeup=0A=
8013ea58 g     F .text	00000000 sys_utimes=0A=
801fcc4c g     O .kstrtab	0000000a __kstrtab_pskb_copy=0A=
80125970 g     F .text	00000000 free_uid=0A=
801fc4dc g     O .kstrtab	00000014 __kstrtab_try_to_free_buffers=0A=
801fabb8 g     O .kstrtab	0000000d __kstrtab_kill_sl_info=0A=
80200340 g     O __ksymtab	00000008 __ksymtab_neigh_sysctl_register=0A=
80209dfc g     F .text.init	00000000 misc_init=0A=
8011ece8 g     F .text	00000000 end_lazy_tlb=0A=
8017f310 g     F .text	00000000 ieee754dp_ldexp=0A=
801ffaa8 g     O __ksymtab	00000008 __ksymtab_prepare_binprm=0A=
8021c758 g     O .data	00000048 random_fops=0A=
8011f440 g     F .text	00000000 sys_exit=0A=
8010cc20 g     F .text	00000090 mips_atomic_set=0A=
801ffdc8 g     O __ksymtab	00000008 __ksymtab_file_fsync=0A=
801c5ee0 g     F .text	00000000 tcp_rcv_state_process=0A=
801ad204 g     F .text	00000000 in_aton=0A=
802072ec g     F .text.init	00000000 free_area_init_core=0A=
80316320 g     O .bss	00000004 rtc_ops=0A=
801e4ba8 g     F .text	00000000 dump_tlb_nonwired=0A=
801fc9bc g     O .kstrtab	0000000f __kstrtab_sock_init_data=0A=
80150568 g     F .text	00000000 page_follow_link=0A=
8010f784 g     F .text	0000003c r4k_clear_page_d32=0A=
801fd2a0 g     O .kstrtab	00000011 __kstrtab_dev_get_by_index=0A=
801ff490 g     O __ksymtab	00000008 __ksymtab_init_mm=0A=
80320a20 g     O .bss	00000004 proc_sys_root=0A=
803350c0 g     O .bss	00000200 udp_hash=0A=
801b0d58 g     F .text	00000000 ip_rt_multicast_event=0A=
80175f60 g     F .text	00000000 semctl_nolock=0A=
801ffec0 g     O __ksymtab	00000008 __ksymtab_tasklet_init=0A=
80129de4 g     F .text	00000000 sys_prctl=0A=
802003a8 g     O __ksymtab	00000008 __ksymtab_net_srandom=0A=
8021a464 g     O .data	00000030 swapper_space=0A=
801fc01c g     O .kstrtab	00000009 __kstrtab_kdevname=0A=
80207118 g     F .text.init	00000000 reserve_bootmem=0A=
801ff708 g     O __ksymtab	00000008 __ksymtab_block_prepare_write=0A=
80130310 g     F .text	00000000 grab_cache_page_nowait=0A=
80183280 g     F .text	00000000 ieee754sp_fint=0A=
8013c3b4 g     F .text	00000000 swap_duplicate=0A=
801ff818 g     O __ksymtab	00000008 __ksymtab_vfs_create=0A=
803164d0 g     O .bss	00000004 _dma_cache_wback_inv=0A=
80200118 g     O __ksymtab	00000008 __ksymtab_sock_register=0A=
8013dea8 g     F .text	00000000 shmem_zero_setup=0A=
8018ef80 g     F .text	00000000 get_random_bytes=0A=
8015d830 g     F .text	00000000 seq_escape=0A=
8010bf78 g     F .text	00000000 old_mmap=0A=
801fbc40 g     O .kstrtab	00000015 __kstrtab_proc_dointvec_minmax=0A=
8021356c g     F .data	00000000 handle_ri_int=0A=
8011bd28 g     F .text	00000000 register_console=0A=
801b1ef0 g     F .text	00000000 ip_call_ra_chain=0A=
801fb34c g     O .kstrtab	0000000a __kstrtab___bforget=0A=
801fc338 g     O .kstrtab	0000000c __kstrtab_bh_task_vec=0A=
801fc9ec g     O .kstrtab	00000010 __kstrtab_sock_no_connect=0A=
80117d68 g     F .text	00000000 __wake_up_sync=0A=
801a13a0 g     F .text	00000000 sock_no_getsockopt=0A=
801ac550 g     F .text	00000000 destroy_8023_client=0A=
801fab7c g     O .kstrtab	00000008 __kstrtab_kill_pg=0A=
8010afdc g     F .text	00000000 do_tr=0A=
80200198 g     O __ksymtab	00000008 __ksymtab_sock_alloc_send_skb=0A=
801a5558 g     F .text	00000000 netdev_boot_setup_check=0A=
8012f9d8 g     F .text	00000000 add_to_page_cache=0A=
8021948c g     O .data	00000004 default_message_loglevel=0A=
8011e7c8 g     F .text	00000000 session_of_pgrp=0A=
801d078c g     F .text	00000000 __tcp_put_port=0A=
801fb488 g     O .kstrtab	00000015 __kstrtab_do_generic_file_read=0A=
80200288 g     O __ksymtab	00000008 __ksymtab_skb_copy_bits=0A=
80138c40 g     F .text	00000000 rw_swap_page_nolock=0A=
80106000 g     O .text	00002000 init_task_union=0A=
8020cef0 g     F .text.init	00000000 icmp_init=0A=
801b4f4c g     F .text	00000000 ip_build_and_send_pkt=0A=
8017c450 g     F .text	00000000 ieee754dp_frexp=0A=
801fd18c g     O .kstrtab	00000014 __kstrtab_move_addr_to_kernel=0A=
801d68c0 g     F .text	00000000 arp_req_delete=0A=
80126c5c g     F .text	00000000 send_sig=0A=
80135300 g     F .text	00000000 vmfree_area_pages=0A=
8011ffa8 g     F .text	00000000 sys_gettimeofday=0A=
80182eb0 g     F .text	00000000 ieee754sp_tint=0A=
801ffe78 g     O __ksymtab	00000008 __ksymtab_get_fast_time=0A=
80128e14 g     F .text	00000000 sys_getresuid=0A=
801fadf0 g     O .kstrtab	0000000d __kstrtab_exit_sighand=0A=
801fc964 g     O .kstrtab	0000000d __kstrtab_sock_sendmsg=0A=
80158dd8 g     F .text	00000000 invalidate_device=0A=
801ff5c8 g     O __ksymtab	00000008 __ksymtab___mark_buffer_dirty=0A=
8012ea48 g     F .text	00000000 insert_vm_struct=0A=
80219558 g     O .data	00000004 pps_jitter=0A=
801792fc g     F .text	00000000 do_dsemulret=0A=
801fd240 g     O .kstrtab	0000000d __kstrtab_loopback_dev=0A=
8013f118 g     F .text	00000000 sys_fchmod=0A=
801187ec g     F .text	00000000 sys_sched_setparam=0A=
801388c8 g     F .text	00000000 kswapd=0A=
80168fc0 g     F .text	00000000 ext2_fsync_inode=0A=
803164a8 g     O .bss	00000004 _flush_cache_all=0A=
8020f53c g     F .text.init	00000000 prom_free_prom_memory=0A=
801fbd78 g     O .kstrtab	0000000d __kstrtab_alloc_kiovec=0A=
801fbf8c g     O .kstrtab	00000006 __kstrtab_xtime=0A=
801ffd50 g     O __ksymtab	00000008 =
__ksymtab_secure_tcp_sequence_number=0A=
801fcc38 g     O .kstrtab	00000011 __kstrtab_pskb_expand_head=0A=
8014f018 g     F .text	00000000 vfs_link=0A=
801e4810 g     F .text	0000004c __strncpy_from_user_asm=0A=
80152730 g     F .text	00000000 sys_select=0A=
8010bd98 g     F .text	00000000 __down_interruptible=0A=
801ff9e0 g     O __ksymtab	00000008 __ksymtab_blkdev_get=0A=
8011cfac g     F .text	00000000 sys_delete_module=0A=
8021fd44 g     O .data	00000010 unix_family_ops=0A=
801fcb74 g     O .kstrtab	00000012 __kstrtab_skb_copy_datagram=0A=
801fb420 g     O .kstrtab	00000015 __kstrtab_generic_commit_write=0A=
801fce78 g     O .kstrtab	0000000b __kstrtab_files_stat=0A=
801fa81c g     O .kstrtab	0000000e __kstrtab_kernel_thread=0A=
8010e278 g     F .text	00000000 enable_8259A_irq=0A=
8011fec4 g     F .text	00000000 sys_stime=0A=
80135274 g     F .text	00000000 sys_mremap=0A=
801fa7d8 g     O .kstrtab	00000007 __kstrtab_strlen=0A=
80219564 g     O .data	00000004 pps_shift=0A=
8011fb90 g     F .text	00000000 sys_setitimer=0A=
801d83cc g     F .text	00000000 inetdev_init=0A=
801378bc g     F .text	00000000 __lru_cache_del=0A=
80200070 g     O __ksymtab	00000008 __ksymtab_blk_queue_headactive=0A=
801a1398 g     F .text	00000000 sock_no_setsockopt=0A=
8017c330 g     F .text	00000000 ieee754si_xcpt=0A=
801faf54 g     O .kstrtab	0000000a __kstrtab_max_mapnr=0A=
801ff9a8 g     O __ksymtab	00000008 __ksymtab_blk_dev=0A=
801fb810 g     O .kstrtab	00000010 __kstrtab_lease_get_mtime=0A=
8015cf80 g     F .text	00000000 seq_open=0A=
801fb0bc g     O .kstrtab	0000000c __kstrtab_dcache_lock=0A=
801d9be0 g     F .text	00000000 register_inetaddr_notifier=0A=
8012fd30 g     F .text	00000000 ___wait_on_page=0A=
801fb86c g     O .kstrtab	0000000f __kstrtab_filemap_nopage=0A=
801fb270 g     O .kstrtab	00000015 __kstrtab_truncate_inode_pages=0A=
801c48a8 g     F .text	00000000 tcp_cwnd_application_limited=0A=
80140728 g     F .text	00000000 sys_pwrite=0A=
80336410 g     O .bss	00000008 kernelsp=0A=
802006a8 g     O __ksymtab	00000008 __ksymtab_sysctl_rmem_max=0A=
8033109c g     O .bss	000003fc blksize_size=0A=
8011aec0 g     F .text	00000000 print_tainted=0A=
801fd1f0 g     O .kstrtab	00000008 __kstrtab_arp_tbl=0A=
801fb738 g     O .kstrtab	00000011 __kstrtab___find_lock_page=0A=
801a447c g     F .text	00000000 skb_copy_and_csum_datagram=0A=
8019fa34 g     F .text	00000000 sock_fcntl=0A=
801fc20c g     O .kstrtab	00000010 __kstrtab_get_empty_inode=0A=
80148bc4 g     F .text	00000000 sys_newstat=0A=
801ffbb0 g     O __ksymtab	00000008 __ksymtab_map_user_kiobuf=0A=
801af514 g     F .text	00000000 ip_rt_get_source=0A=
801fd1e8 g     O .kstrtab	00000008 __kstrtab_arp_rcv=0A=
80212c80 g     O .data	0000007c init_mm=0A=
80330ca0 g     O .bss	000003fc blk_size=0A=
801ffa88 g     O __ksymtab	00000008 __ksymtab_may_umount=0A=
801fc65c g     O .kstrtab	00000016 __kstrtab_add_blkdev_randomness=0A=
80169bd4 g     F .text	00000000 ext2_count_free_inodes=0A=
801ff808 g     O __ksymtab	00000008 __ksymtab_is_subdir=0A=
801fc140 g     O .kstrtab	0000000a __kstrtab_do_execve=0A=
8010e3a0 g     F .text	00000000 make_8259A_irq=0A=
8021e710 g     O .data	00000004 sysctl_tcp_syn_retries=0A=
8017c600 g     F .text	00000000 ieee754dp_modf=0A=
80207144 g     F .text.init	00000000 free_bootmem=0A=
801561e4 g     F .text	00000000 get_locks_status=0A=
8020709c g     F .text.init	00000000 free_bootmem_node=0A=
801fb060 g     O .kstrtab	0000000a __kstrtab_path_init=0A=
8021e210 g     O .data	00000004 ip_rt_gc_min_interval=0A=
8014a428 g     F .text	00000000 search_binary_handler=0A=
801b7ed8 g     F .text	00000000 ip_setsockopt=0A=
8019f1c4 g     F .text	00000000 sys_getpeername=0A=
80168b84 g     F .text	00000000 ext2_delete_entry=0A=
801e7730 g     F .text	00000000 do_settimeofday=0A=
802004b8 g     O __ksymtab	00000008 __ksymtab_ip_dev_find=0A=
801fbb54 g     O .kstrtab	00000016 __kstrtab_search_binary_handler=0A=
8031608c g     O .bss	00000080 exception_handlers=0A=
8018c9f0 g     F .text	00000000 raw_open=0A=
80219190 g     O .data	00000004 bcops=0A=
80129d80 g     F .text	00000000 sys_getrusage=0A=
80208698 g     F .text.init	00000000 inode_init=0A=
80158d30 g     F .text	00000000 invalidate_inodes=0A=
8010f954 g     F .text	00000058 r4k_clear_page_s128=0A=
801fb244 g     O .kstrtab	00000012 __kstrtab_invalidate_device=0A=
801ff3b0 g     O __ksymtab	00000008 __ksymtab_exit_fs=0A=
8010e0cc g     F .text	00000000 disable_irq_nosync=0A=
8031d758 g     O .bss	00000004 prof_buffer=0A=
8021c010 g     O .data	00000040 autofs4_dir_inode_operations=0A=
801abc2c g     F .text	00000000 neigh_sysctl_register=0A=
80151d88 g     F .text	00000000 old_readdir=0A=
80162610 g     F .text	00000000 proc_lookup=0A=
8011881c g     F .text	00000000 sys_sched_getscheduler=0A=
801ffe50 g     O __ksymtab	00000008 __ksymtab_fs_overflowgid=0A=
8010c3bc g     F .text	00000000 sys_syscall=0A=
80200498 g     O __ksymtab	00000008 __ksymtab_inet_dgram_ops=0A=
801fcc24 g     O .kstrtab	00000011 __kstrtab___pskb_pull_tail=0A=
80205c74 g     F .text.init	00000000 sched_init=0A=
801fff28 g     O __ksymtab	00000008 __ksymtab_fail_writepage=0A=
80161eb0 g     F .text	00000000 proc_pid_delete_inode=0A=
801ffc68 g     O __ksymtab	00000008 __ksymtab_sleep_on_timeout=0A=
801e5054 g     F .text	00000000 strspn=0A=
801ffe28 g     O __ksymtab	00000008 __ksymtab_make_bad_inode=0A=
8014c104 g     F .text	00000000 deny_write_access=0A=
8021e080 g     O .data	00000040 noop_qdisc_ops=0A=
8010aab0 g     F .text	00000000 show_registers=0A=
8012f834 g     F .text	00000000 filemap_fdatawait=0A=
801fbac4 g     O .kstrtab	00000012 __kstrtab_tty_get_baud_rate=0A=
801ace04 g     F .text	00000000 qdisc_reset=0A=
801295ec g     F .text	00000000 in_egroup_p=0A=
80159a80 g     F .text	00000000 bmap=0A=
801b0b74 g     F .text	00000000 ip_route_output_key=0A=
8010cfd0 g     F .text	0000005c _save_fp_context=0A=
8019e5c8 g     F .text	00000000 sock_readv_writev=0A=
801fbcc4 g     O .kstrtab	00000009 __kstrtab_irq_stat=0A=
801376b0 g     F .text	00000000 activate_page=0A=
801ffb80 g     O __ksymtab	00000008 __ksymtab_mod_timer=0A=
801fd2d8 g     O .kstrtab	00000012 __kstrtab___dev_get_by_name=0A=
8013acc8 g     F .text	00000000 free_swap_and_cache=0A=
80334cc8 g     O .bss	0000000c sysctl_tcp_mem=0A=
80121504 g     F .text	00000000 release_resource=0A=
802001a8 g     O __ksymtab	00000008 __ksymtab_sock_no_release=0A=
8010046c g     O .text	00000000 _stext=0A=
8021bfd0 g     O .data	00000040 autofs4_root_inode_operations=0A=
801fb820 g     O .kstrtab	0000000e __kstrtab_lock_may_read=0A=
8012ff7c g     F .text	00000000 lock_page=0A=
801b91f8 g     F .text	00000000 tcp_poll=0A=
801581a4 g     F .text	00000000 sync_unlocked_inodes=0A=
801192d8 g     F .text	00000000 free_dma=0A=
801ff4d8 g     O __ksymtab	00000008 __ksymtab_fget=0A=
801fae00 g     O .kstrtab	0000000d __kstrtab__alloc_pages=0A=
801e4ff0 g     F .text	00000000 strlen=0A=
80162b38 g     F .text	00000000 proc_symlink=0A=
801fc368 g     O .kstrtab	0000000d __kstrtab_tasklet_kill=0A=
801ffa80 g     O __ksymtab	00000008 __ksymtab___mntput=0A=
8021958c g     O .data	0000001c iomem_resource=0A=
803358e0 g     O .bss	00000004 sysctl_ip_nonlocal_bind=0A=
801fb4a0 g     O .kstrtab	00000013 __kstrtab_generic_file_write=0A=
8020a6cc g     F .text.init	00000000 early_serial_setup=0A=
8011ea64 g     F .text	00000000 put_fs_struct=0A=
801ff3c8 g     O __ksymtab	00000008 __ksymtab___alloc_pages=0A=
801fb74c g     O .kstrtab	00000010 __kstrtab_grab_cache_page=0A=
80124a58 g     F .text	00000000 del_timer=0A=
801fcc70 g     O .kstrtab	0000000e __kstrtab_datagram_poll=0A=
801ff528 g     O __ksymtab	00000008 __ksymtab_path_walk=0A=
8010bf30 g     F .text	00000000 sys_pipe=0A=
801c6cb4 g     F .text	00000000 tcp_transmit_skb=0A=
8020f21c g     F .text.init	00000000 idisx_setup=0A=
8021fe90 g     O .data	000000dc net_table=0A=
801ff600 g     O __ksymtab	00000008 __ksymtab_files_lock=0A=
801fbe88 g     O .kstrtab	0000000f __kstrtab___check_region=0A=
80108dd0 g     F .text	00000000 copy_siginfo_to_user=0A=
8014e888 g     F .text	00000000 sys_rmdir=0A=
801b7728 g     F .text	00000000 ip_icmp_error=0A=
801376a0 g     F .text	00000000 slabinfo_write_proc=0A=
801b86f8 g     F .text	00000000 ip_getsockopt=0A=
801fc5cc g     O .kstrtab	00000015 __kstrtab_tty_unregister_devfs=0A=
8010c54c g     F .text	00000000 bad_stack=0A=
801fa808 g     O .kstrtab	00000007 __kstrtab_strtok=0A=
8021e5e0 g     O .data	00000004 inet_peer_minttl=0A=
8019d838 g     F .text	00000000 alloc_etherdev=0A=
802000a8 g     O __ksymtab	00000008 __ksymtab_add_gendisk=0A=
801d4328 g     F .text	00000000 udp_recvmsg=0A=
8010f89c g     F .text	00000044 r4k_clear_page_s16=0A=
8010c700 g     F .text	00000000 sys_ipc=0A=
80207224 g     F .text.init	00000000 __alloc_bootmem_node=0A=
8010a8c0 g     F .text	00000000 show_code=0A=
8019679c g     F .text	00000000 is_read_only=0A=
801e79b0 g     F .text	00000000 idisx_display_message=0A=
801fabec g     O .kstrtab	00000009 __kstrtab_send_sig=0A=
80146318 g     F .text	00000000 sys_ustat=0A=
802035b4 g     F .text.init	00000000 init_arch=0A=
8016ede4 g     F .text	00000000 autofs_read_super=0A=
801e72d0 g     F .text	00000000 idisx_hw4_irqdispatch=0A=
801faf24 g     O .kstrtab	00000006 __kstrtab_vfree=0A=
802192d8 g     O .data	00000004 abi_defhandler_lcall7=0A=
801fafcc g     O .kstrtab	0000000a __kstrtab_get_super=0A=
801b19e8 g     F .text	00000000 snmp_get_info=0A=
80334a40 g     O .bss	00000004 inet_peer_unused_head=0A=
801fd338 g     O .kstrtab	0000000c __kstrtab___kfree_skb=0A=
802001b8 g     O __ksymtab	00000008 __ksymtab_sock_no_connect=0A=
8017d0b0 g     F .text	00000000 ieee754dp_mul=0A=
80148b2c g     F .text	00000000 sys_stat=0A=
80198498 g     F .text	00000000 get_gendisk=0A=
801fc31c g     O .kstrtab	0000000f __kstrtab_tasklet_hi_vec=0A=
8014eec0 g     F .text	00000000 sys_symlink=0A=
8021a100 g     O .data	00000004 C_A_D=0A=
80151970 g     F .text	00000000 vfs_readdir=0A=
801ffb38 g     O __ksymtab	00000008 __ksymtab_free_irq=0A=
801fa840 g     O .kstrtab	00000020 =
__kstrtab___strncpy_from_user_nocheck_asm=0A=
801acec4 g     F .text	00000000 dev_activate=0A=
801ff900 g     O __ksymtab	00000008 __ksymtab_lock_may_read=0A=
801fac1c g     O .kstrtab	00000014 __kstrtab_unblock_all_signals=0A=
801faf1c g     O .kstrtab	00000006 __kstrtab_kfree=0A=
801ff640 g     O __ksymtab	00000008 __ksymtab_fsync_dev=0A=
80213ac0 g     F .data	000000f4 handle_mcheck=0A=
801fa9f8 g     O .kstrtab	00000011 __kstrtab__dma_cache_wback=0A=
801c92e8 g     F .text	00000000 tcp_send_active_reset=0A=
8021e788 g     O .data	00000084 tcp_prot=0A=
801ff590 g     O __ksymtab	00000008 __ksymtab_d_move=0A=
80202ba0 g     F .text.init	00000000 trap_init=0A=
8017bb98 g     F .text	00000000 ieee754sp_xcpt=0A=
801ff350 g     O __ksymtab	00000008 __ksymtab_flush_scheduled_tasks=0A=
80200470 g     O __ksymtab	00000008 __ksymtab_in_aton=0A=
80205738 g     F .text.init	00000000 r4k_tlb_init=0A=
8021fcb4 g     O .data	00000000 unix_table_lock=0A=
801fce44 g     O .kstrtab	0000000c __kstrtab_net_srandom=0A=
801faa60 g     O .kstrtab	00000014 __kstrtab_abi_defhandler_coff=0A=
8010c940 g     F .text	000002e0 handle_sys=0A=
80335428 g     O .bss	00000004 =
sysctl_icmp_ignore_bogus_error_responses=0A=
8021a130 g     O .data	00000100 modprobe_path=0A=
801fba28 g     O .kstrtab	00000008 __kstrtab_tq_disk=0A=
801faf6c g     O .kstrtab	0000000b __kstrtab_vmtruncate=0A=
80154ea4 g     F .text	00000000 lease_get_mtime=0A=
80218f48 g     O .data	00000001 watch_available=0A=
80121e24 g     F .text	00000000 register_sysctl_table=0A=
802191a0 g     O .data	00000004 securebits=0A=
801fd0c0 g     O .kstrtab	0000000c __kstrtab_ip_rt_ioctl=0A=
801fa928 g     O .kstrtab	00000007 __kstrtab___down=0A=
801e4f5c g     F .text	00000000 strchr=0A=
801ffdd0 g     O __ksymtab	00000008 __ksymtab_fsync_inode_buffers=0A=
801a7f74 g     F .text	00000000 unregister_netdevice=0A=
8021e234 g     O .data	00000004 ip_rt_min_advmss=0A=
801ff4c8 g     O __ksymtab	00000008 __ksymtab_names_cachep=0A=
801ffd38 g     O __ksymtab	00000008 __ksymtab_machine_halt=0A=
801ff4c0 g     O __ksymtab	00000008 __ksymtab_getname=0A=
801e6a10 g     F .text	00000000 memparse=0A=
801fd1b4 g     O .kstrtab	0000000c __kstrtab_ipv4_config=0A=
80185e4c g     F .text	00000000 start_tty=0A=
80200520 g     O __ksymtab	00000008 __ksymtab_rtnl_lock=0A=
8013ef64 g     F .text	00000000 sys_chroot=0A=
801e7288 g     F .text	00000000 idisx_hw2_irqdispatch=0A=
801ffef8 g     O __ksymtab	00000008 __ksymtab___tasklet_hi_schedule=0A=
80320a18 g     O .bss	00000004 proc_bus=0A=
8031ebfc g     O .bss	00000004 mem_map=0A=
8015669c g     F .text	00000000 d_invalidate=0A=
8014acc0 g     F .text	00000000 pipe_wait=0A=
8010d4b8 g     F .text	00000000 handle_IRQ_event=0A=
801fb4b4 g     O .kstrtab	00000012 __kstrtab_generic_file_mmap=0A=
8012609c g     F .text	00000000 dequeue_signal=0A=
801ff080 g     O *ABS*	00000000 __start___ksymtab=0A=
801da390 g     F .text	00000000 inet_sock_release=0A=
80157d9c g     F .text	00000000 __mark_inode_dirty=0A=
801cc39c g     F .text	00000000 tcp_unhash=0A=
802005d8 g     O __ksymtab	00000008 =
__ksymtab_netdev_finish_unregister=0A=
8018c408 g     F .text	00000000 n_tty_ioctl=0A=
801fbe18 g     O .kstrtab	0000000e __kstrtab_dma_spin_lock=0A=
801fbfc4 g     O .kstrtab	00000006 __kstrtab_kstat=0A=
801ff9d8 g     O __ksymtab	00000008 __ksymtab_blkdev_open=0A=
80123860 g     F .text	00000000 sys_acct=0A=
801ff850 g     O __ksymtab	00000008 __ksymtab_vfs_rename=0A=
801ff860 g     O __ksymtab	00000008 __ksymtab_generic_read_dir=0A=
8010b4d8 g     F .text	00000000 set_except_vector=0A=
8021d8c0 g     O .data	00000004 sysctl_hot_list_len=0A=
801e7950 g     F .text	00000000 getPromChar=0A=
801ffcf8 g     O __ksymtab	00000008 __ksymtab_vsscanf=0A=
8021ee00 g     O .data	0000000c ip_netdev_notifier=0A=
8013fc48 g     F .text	00000000 generic_file_llseek=0A=
8019e078 g     F .text	00000000 sockfd_lookup=0A=
801fbc28 g     O .kstrtab	00000016 __kstrtab_proc_dointvec_jiffies=0A=
801fb394 g     O .kstrtab	00000010 __kstrtab____wait_on_page=0A=
801fba58 g     O .kstrtab	0000000e __kstrtab_max_readahead=0A=
801ffce8 g     O __ksymtab	00000008 __ksymtab_vsprintf=0A=
801fc7f0 g     O .kstrtab	00000017 __kstrtab_loop_register_transfer=0A=
8015b1fc g     F .text	00000000 __mntput=0A=
8012a9c8 g     F .text	00000000 dev_probe_lock=0A=
801fc028 g     O .kstrtab	00000009 __kstrtab_bdevname=0A=
8015a0c0 g     F .text	00000000 make_bad_inode=0A=
801ca858 g     F .text	00000000 tcp_clear_xmit_timers=0A=
80200068 g     O __ksymtab	00000008 __ksymtab_blk_cleanup_queue=0A=
801fab50 g     O .kstrtab	0000000e __kstrtab_flush_signals=0A=
801fb06c g     O .kstrtab	0000000a __kstrtab_path_walk=0A=
801fa9e0 g     O .kstrtab	00000015 __kstrtab__dma_cache_wback_inv=0A=
80200360 g     O __ksymtab	00000008 __ksymtab_neigh_parms_alloc=0A=
801fcf9c g     O .kstrtab	0000000f __kstrtab_arp_broken_ops=0A=
801da678 g     F .text	00000000 inet_listen=0A=
801ff740 g     O __ksymtab	00000008 __ksymtab_generic_file_read=0A=
80126da8 g     F .text	00000000 do_notify_parent=0A=
80125738 g     F .text	00000000 sys_getpid=0A=
8011de78 g     F .text	00000000 free_module=0A=
802138a0 g     F .data	00000108 handle_fpe=0A=
801fcf24 g     O .kstrtab	00000018 __kstrtab_inet_unregister_protosw=0A=
801ff8c0 g     O __ksymtab	00000008 __ksymtab_vfs_follow_link=0A=
80335990 g     O .bss	00000404 unix_socket_table=0A=
8012bb18 g     F .text	00000000 lock_kiovec=0A=
801ffe88 g     O __ksymtab	00000008 __ksymtab_strspn=0A=
801a738c g     F .text	00000000 dev_change_flags=0A=
801cb880 g     F .text	00000000 tcp_delete_keepalive_timer=0A=
801fc2d0 g     O .kstrtab	0000000a __kstrtab_disk_name=0A=
802205a0 g     O .data	00000004 mqb_cookie=0A=
801ff150 g     O __ksymtab	00000008 =
__ksymtab___strnlen_user_nocheck_asm=0A=
801ff5e8 g     O __ksymtab	00000008 __ksymtab_filp_open=0A=
802003d0 g     O __ksymtab	00000008 __ksymtab_memcpy_toiovec=0A=
8021a4a0 g     O .data	00000008 swap_list=0A=
80318a5c g     O .bss	00000004 fs_cachep=0A=
801218d0 g     F .text	00000000 do_sysctl=0A=
8016e160 g     F .text	00000000 autofs_update_usage=0A=
801fa800 g     O .kstrtab	00000007 __kstrtab_strstr=0A=
801fd4e4 g     O .kstrtab	00000010 __kstrtab_qdisc_tree_lock=0A=
801ff298 g     O __ksymtab	00000008 __ksymtab_kill_pg=0A=
801fc378 g     O .kstrtab	00000011 __kstrtab___run_task_queue=0A=
801fab08 g     O .kstrtab	00000010 __kstrtab_console_unblank=0A=
8015fd48 g     F .text	00000000 de_put=0A=
80125740 g     F .text	00000000 sys_getppid=0A=
80200638 g     O __ksymtab	00000008 __ksymtab_dev_alloc_name=0A=
80118ec4 g     F .text	00000000 show_state=0A=
801fc280 g     O .kstrtab	00000006 __kstrtab_event=0A=
803164b8 g     O .bss	00000004 _flush_cache_page=0A=
8020859c g     F .text.init	00000000 vfs_caches_init=0A=
80159ab8 g     F .text	00000000 update_atime=0A=
801fc55c g     O .kstrtab	0000000a __kstrtab_proc_root=0A=
801fffa0 g     O __ksymtab	00000008 __ksymtab_remove_proc_entry=0A=
80200178 g     O __ksymtab	00000008 __ksymtab_sock_recvmsg=0A=
8015ca54 g     F .text	00000000 sys_pivot_root=0A=
801961e0 g     F .text	00000000 blk_cleanup_queue=0A=
801fd150 g     O .kstrtab	00000015 __kstrtab_sklist_remove_socket=0A=
8010ca40 g     O .text	00000000 o32_ret_from_sys_call=0A=
80211000 g     O .data.cacheline_aligned	00000800 irq_desc=0A=
801faf38 g     O .kstrtab	00000008 __kstrtab_mem_map=0A=
801fc1fc g     O .kstrtab	0000000f __kstrtab_get_hash_table=0A=
801fb970 g     O .kstrtab	00000009 __kstrtab_blk_size=0A=
80126874 g     F .text	00000000 force_sig_info=0A=
8021db68 g     O .data	00000004 netdev_max_backlog=0A=
801dc3f0 g     F .text	00000000 ip_mc_destroy_dev=0A=
801ff898 g     O __ksymtab	00000008 __ksymtab___find_lock_page=0A=
801ffb88 g     O __ksymtab	00000008 __ksymtab_tq_timer=0A=
801b3e08 g     F .text	00000000 ip_options_echo=0A=
8013ec8c g     F .text	00000000 sys_chdir=0A=
801fb9d4 g     O .kstrtab	0000000c __kstrtab_blkdev_open=0A=
801fc188 g     O .kstrtab	0000000b __kstrtab_file_fsync=0A=
80211820 g     O .data.cacheline_aligned	00000000 mmlist_lock=0A=
801fb2c0 g     O .kstrtab	0000000e __kstrtab_inode_setattr=0A=
801abea8 g     F .text	00000000 rtattr_parse=0A=
8021e018 g     O .data	00000004 net_msg_burst=0A=
80200640 g     O __ksymtab	00000008 __ksymtab___netdev_watchdog_up=0A=
801b0120 g     F .text	00000000 ip_route_input=0A=
8020fde8 g     O .data.init	00000004 ic_servaddr=0A=
8014a3bc g     F .text	00000000 remove_arg_zero=0A=
80335940 g     O .bss	00000004 ic_proto_used=0A=
8010a680 g     F .text	00000000 show_stack=0A=
801a1d4c g     F .text	00000000 __kfree_skb=0A=
801fad40 g     O .kstrtab	00000018 __kstrtab_inter_module_unregister=0A=
8011f418 g     F .text	00000000 complete_and_exit=0A=
8021e73c g     O .data	00000004 tcp_port_rover=0A=
8012cf30 g     F .text	00000000 pte_alloc=0A=
8012b708 g     F .text	00000000 map_user_kiobuf=0A=
801688d0 g     F .text	00000000 ext2_add_link=0A=
801aed58 g     F .text	00000000 ip_rt_send_redirect=0A=
8011dfd0 g     F .text	00000000 get_module_list=0A=
80200670 g     O __ksymtab	00000008 __ksymtab_dev_close=0A=
80316000 g     O *ABS*	00000000 _fbss=0A=
801fc408 g     O .kstrtab	00000008 __kstrtab_pidhash=0A=
8013a380 g     F .text	00000000 free_page_and_swap_cache=0A=
8021be90 g     O .data	00000040 autofs_symlink_inode_operations=0A=
80190374 g     F .text	00000000 serial_icr_read=0A=
80139c54 g     F .text	00000000 get_zeroed_page=0A=
801fae10 g     O .kstrtab	0000000e __kstrtab___alloc_pages=0A=
80156e38 g     F .text	00000000 shrink_dcache_memory=0A=
801ffab0 g     O __ksymtab	00000008 __ksymtab_compute_creds=0A=
801fd4f4 g     O .kstrtab	00000011 __kstrtab_register_gifconf=0A=
8021ebd0 g     O .data	00000080 icmp_err_convert=0A=
8019fe70 g     F .text	00000000 sock_setsockopt=0A=
802006c8 g     O __ksymtab	00000008 __ksymtab_qdisc_restart=0A=
80336418 g     O .bss	00000008 pgd_current=0A=
80200660 g     O __ksymtab	00000008 __ksymtab_dev_base=0A=
801427c0 g     F .text	00000000 osync_inode_buffers=0A=
80128528 g     F .text	00000000 ctrl_alt_del=0A=
80136f94 g     F .text	00000000 kmem_find_general_cachep=0A=
80136fe4 g     F .text	00000000 kmem_cache_reap=0A=
801cfa84 g     F .text	00000000 tcp_v4_tw_remember_stamp=0A=
801fc7bc g     O .kstrtab	0000000d __kstrtab_gendisk_head=0A=
8019dcb0 g     F .text	00000000 move_addr_to_user=0A=
80185d98 g     F .text	00000000 wait_for_keypress=0A=
80185c90 g     F .text	00000000 disassociate_ctty=0A=
80123d2c g     F .text	00000000 ptrace_attach=0A=
801a169c g     F .text	00000000 sock_init_data=0A=
8021c204 g     O .data	00000004 shm_ctlall=0A=
801fa930 g     O .kstrtab	00000015 __kstrtab___down_interruptible=0A=
801fc6a0 g     O .kstrtab	00000010 __kstrtab_register_serial=0A=
801fffb0 g     O __ksymtab	00000008 __ksymtab_proc_root_fs=0A=
80200028 g     O __ksymtab	00000008 __ksymtab_generate_random_uuid=0A=
801ff1a8 g     O __ksymtab	00000008 __ksymtab_set_mqb_handler=0A=
802200c0 g     O .data	00000004 init_debug=0A=
8015a5e0 g     F .text	00000000 end_kio_request=0A=
8031d370 g     O .bss	00000004 hardpps_ptr=0A=
801a829c g     F .text	00000000 dev_mc_upload=0A=
801a5a10 g     F .text	00000000 dev_load=0A=
801fcda0 g     O .kstrtab	0000000e __kstrtab_neigh_destroy=0A=
801fc674 g     O .kstrtab	00000014 __kstrtab_batch_entropy_store=0A=
80200600 g     O __ksymtab	00000008 __ksymtab_skb_clone=0A=
801fd508 g     O .kstrtab	00000013 __kstrtab_net_call_rx_atomic=0A=
801cca04 g     F .text	00000000 tcp_v4_connect=0A=
8013c780 g     F .text	00000000 alloc_pages_node=0A=
801ff890 g     O __ksymtab	00000008 __ksymtab___find_get_page=0A=
8010a530 g     O .text	00000000 ret_from_sys_call=0A=
801fbe0c g     O .kstrtab	00000009 __kstrtab_free_dma=0A=
801b8ea0 g     F .text	00000000 tcp_mem_schedule=0A=
80121a00 g     F .text	00000000 sys_sysctl=0A=
8021e6f0 g     O .data	00000004 sysctl_tcp_adv_win_scale=0A=
801fa9b0 g     O .kstrtab	0000000b __kstrtab_enable_irq=0A=
8010fdfc g     F .text	0000009c r4k_copy_page_s64=0A=
801fc568 g     O .kstrtab	0000000d __kstrtab_proc_root_fs=0A=
801fab84 g     O .kstrtab	0000000d __kstrtab_kill_pg_info=0A=
8021e600 g     O .data	00000004 inet_peer_gc_mintime=0A=
8012aef8 g     F .text	00000000 start_context_thread=0A=
8020673c g     F .text.init	00000000 bootmem_bootmap_pages=0A=
80122a78 g     F .text	00000000 proc_dointvec_bset=0A=
80200580 g     O __ksymtab	00000008 =
__ksymtab_register_netdevice_notifier=0A=
801fc1c4 g     O .kstrtab	0000000c __kstrtab_clear_inode=0A=
801fb700 g     O .kstrtab	0000000b __kstrtab___pollwait=0A=
8021cbb0 g     O .data	00000008 tq_disk=0A=
801ff340 g     O __ksymtab	00000008 __ksymtab_request_module=0A=
80121720 g     F .text	00000000 __request_region=0A=
80165d60 g     F .text	00000000 disk_name=0A=
801fff20 g     O __ksymtab	00000008 __ksymtab_vm_min_readahead=0A=
8010a8a4 g     F .text	00000000 show_trace_task=0A=
8019624c g     F .text	00000000 blk_queue_headactive=0A=
802001d0 g     O __ksymtab	00000008 __ksymtab_sock_no_getname=0A=
8014b84c g     F .text	00000000 pipe_new=0A=
80328d20 g     O .bss	000003fc read_ahead=0A=
80128fc8 g     F .text	00000000 sys_getresgid=0A=
802059dc g     F .text.init	00000054 except_vec0_r4000=0A=
8016e814 g     F .text	00000000 autofs_hash_dputall=0A=
802000d8 g     O __ksymtab	00000008 __ksymtab_alloc_etherdev=0A=
801faf60 g     O .kstrtab	0000000c __kstrtab_high_memory=0A=
80200220 g     O __ksymtab	00000008 __ksymtab_sock_no_sendpage=0A=
8015357c g     F .text	00000000 locks_copy_lock=0A=
802006f8 g     O __ksymtab	00000008 __ksymtab_softnet_data=0A=
801a9728 g     F .text	00000000 neigh_lookup=0A=
801fc984 g     O .kstrtab	00000009 __kstrtab_sk_alloc=0A=
801faa1c g     O .kstrtab	00000015 __kstrtab_register_exec_domain=0A=
801faa4c g     O .kstrtab	00000012 __kstrtab___set_personality=0A=
8013640c g     F .text	00000000 kmem_cache_destroy=0A=
801ff878 g     O __ksymtab	00000008 __ksymtab___pollwait=0A=
801d06e0 g     F .text	00000000 tcp_v4_lookup_listener=0A=
80195d1c g     F .text	00000000 unregister_serial=0A=
80141fd8 g     F .text	00000000 inode_has_buffers=0A=
801fd3dc g     O .kstrtab	0000000f __kstrtab_dev_queue_xmit=0A=
801ffcb0 g     O __ksymtab	00000008 __ksymtab_loops_per_jiffy=0A=
801e50cc g     F .text	00000000 strpbrk=0A=
80334cc4 g     O .bss	00000004 tcp_timewait_cachep=0A=
80207270 g     F .text.init	00000000 swap_setup=0A=
801fbaf4 g     O .kstrtab	00000016 __kstrtab_unregister_filesystem=0A=
80200618 g     O __ksymtab	00000008 __ksymtab_dev_add_pack=0A=
801fb0c8 g     O .kstrtab	0000000d __kstrtab_d_alloc_root=0A=
801ff080 g     O *ABS*	00000000 __stop___dbe_table=0A=
80200380 g     O __ksymtab	00000008 __ksymtab_dst_alloc=0A=
801fc38c g     O .kstrtab	0000000b __kstrtab_do_softirq=0A=
80146090 g     F .text	00000000 sync_supers=0A=
801fae98 g     O .kstrtab	00000019 =
__kstrtab_kmem_find_general_cachep=0A=
801fafd8 g     O .kstrtab	0000000b __kstrtab_drop_super=0A=
8014e094 g     F .text	00000000 sys_mknod=0A=
801fa7a0 g     O .kstrtab	00000007 __kstrtab_memset=0A=
8018a4b8 g     F .text	00000000 is_ignored=0A=
801fb8c0 g     O .kstrtab	0000000c __kstrtab_unlock_page=0A=
8010d5b4 g     F .text	00000000 disable_irq=0A=
80142bd8 g     F .text	00000000 set_buffer_flushtime=0A=
801fc7e4 g     O .kstrtab	0000000c __kstrtab_get_gendisk=0A=
801e4880 g     F .text	00000000 __strnlen_user_nocheck_asm=0A=
80163924 g     F .text	00000000 proc_pid_statm=0A=
80145828 g     F .text	00000000 kupdate=0A=
801ff778 g     O __ksymtab	00000008 __ksymtab_page_hash_table=0A=
8019657c g     F .text	00000000 blk_init_queue=0A=
801e54ac g     F .text	00000000 simple_strtoull=0A=
801fc21c g     O .kstrtab	00000012 __kstrtab_insert_inode_hash=0A=
801293c0 g     F .text	00000000 sys_getpgrp=0A=
80200138 g     O __ksymtab	00000008 __ksymtab_memcpy_fromiovec=0A=
803164d4 g     O .bss	00000004 _dma_cache_wback=0A=
801fff30 g     O __ksymtab	00000008 __ksymtab_shmem_file_setup=0A=
8020f114 g     F .text.init	00000000 time_init=0A=
80200348 g     O __ksymtab	00000008 __ksymtab_pneigh_lookup=0A=
8014d624 g     F .text	00000000 vfs_create=0A=
8021e020 g     O .data	0000002c ether_table=0A=
801fd014 g     O .kstrtab	00000011 __kstrtab_ip_finish_output=0A=
801fbffc g     O .kstrtab	00000009 __kstrtab_vsprintf=0A=
801fc168 g     O .kstrtab	0000000a __kstrtab_open_exec=0A=
801ff110 g     O __ksymtab	00000008 __ksymtab__clear_page=0A=
8021e230 g     O .data	00000004 ip_rt_min_pmtu=0A=
801fad9c g     O .kstrtab	00000012 __kstrtab_try_inc_mod_count=0A=
801ff588 g     O __ksymtab	00000008 __ksymtab_d_invalidate=0A=
801a7d04 g     F .text	00000000 register_netdevice=0A=
80122ae0 g     F .text	00000000 proc_dointvec_minmax=0A=
=0A=
=0A=

------_=_NextPart_000_01C268BE.F60BF950--

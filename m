Received:  by oss.sgi.com id <S42515AbQJFH5Z>;
	Fri, 6 Oct 2000 00:57:25 -0700
Received: from saturn.mikemac.com ([216.99.199.88]:40205 "EHLO
        saturn.mikemac.com") by oss.sgi.com with ESMTP id <S42513AbQJFH47>;
	Fri, 6 Oct 2000 00:56:59 -0700
Received: from Saturn (localhost [127.0.0.1])
	by saturn.mikemac.com (8.9.3/8.9.3) with ESMTP id UAA21853
	for <linux-mips@oss.sgi.com>; Thu, 5 Oct 2000 20:40:17 -0700
Message-Id: <200010060340.UAA21853@saturn.mikemac.com>
To:     linux-mips@oss.sgi.com
Subject: Linux-VR test7 hangs when execing init
Date:   Thu, 05 Oct 2000 20:40:17 -0700
From:   Mike McDonald <mikemac@mikemac.com>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing


  Recently the Linux-VR tree synced up with the SGI tree at test7
(from test4). As a result of this updating of the Linux-VR tree, my
kernels either hang or Oops while execing init. A minimal kernel will
hang and a normally config'd kernel will Oops. Does anyone know of any
changes in the ELF code or the ext2 filesystem that might be the cause
fo this? Any other ideas as to the cause or how to go about tracking
it down?

  Thanks,

  Mike McDonald
  mikemac@mikemac.com

----minimal kernel---------------------------------------------
Detected 32MB of memory.  Will use 32MB of it.
Loading R4000 MMU routines.
CPU revision is: 00000c70
Primary instruction cache 32kb, linesize 32 bytes.
Primary data cache 16kb, linesize 16 bytes.
Secondary cache: none
Linux version 2.4.0-test7 (mikemac@Uranus) (gcc version egcs-2.90.29 980515 (egcs-1.0.3 release)) 
#15 Thu Oct 5 20:25:31 PDT 2000
On node 0 totalpages: 8192
zone(0): 8192 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: root=/dev/ram0 ip=192.5.213.64::::::
Calibrating delay loop... 128.61 BogoMIPS
Memory: 30496k/32768k available (686k kernel code, 2272k reserved, 793k data, 36k init)
Dentry-cache hash table entries: 4096 (order: 3, 32768 bytes)
Buffer-cache hash table entries: 1024 (order: 0, 4096 bytes)
Page-cache hash table entries: 8192 (order: 3, 32768 bytes)
Inode-cache hash table entries: 2048 (order: 2, 16384 bytes)
Checking for 'wait' instruction...  unavailable.
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Starting kswapd v1.7
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
RAMDISK: Compressed image found at block 0
VR41xx Serial driver version 0.3 (10-Sep-2000)
ttyS00 at 0xaf000800 (irq = 17) is a 16550A
EXT2-fs warning: maximal mount count reached, running e2fsck is recommended
VFS: Mounted root (ext2 filesystem).
Freeing unused kernel memory: 36k freed
(Hung!)

-------normal kernel--------------------------------------------------
VFS: Mounted root (ext2 filesystem).
Freeing unused kernel memory: 76k freed
Unable to handle kernel paging request at virtual address 00000088, epc == 8006f97c, ra == 8006f97
4
Oops in fault.c:do_page_fault, line 158:
$0 : 00000000 10007e00 3020901e 00000000
$4 : 3020901e 00000000 00000010 80024000
$8 : fffffffe ffff00ff 80175818 8017581c
$12: 00000200 00000000 803f3d88 81e72d40
$16: 00000000 80179334 00000000 00000080
$20: 00000003 803f3ef8 803f3ef8 00008000
$24: 00000000 00000000
$28: 803f2000 803f3bd8 00000000 8006f974
epc   : 8006f97c
Status: 10007e03
Cause : 00008008
Process sh (pid: 1, stackpage=803f2000)
Stack: 8006f578 8004b6b0 81e6a360 800b452c 803f3cb0 81e72db0 803f3db8 00000000
       80081f48 80081bbc 00000008 81e68000 80178000 0001fff4 803f3eb0 80047094
       803ce600 81e8b3e0 464c457f 00010101 00000000 00000000 00080002 00000001
       00406720 00000034 0004df18 00000003 00200034 00280003 000e000f 0000000d
       803f3e04 00000ff4 803f3e04 00000ff4 802e6a00 80028638 80180f04 00002000
       00000000 ...
Call Trace: [<8006f578>] [<8004b6b0>] [<800b452c>] [<80081f48>] [<80081bbc>] [<80047094>] [<800286
38>] [<800686a4>] [<8006ef58>] [<80081a44>] [<8006fe38>] [<8006f4dc>] [<800702c8>] [<800a7dcc>] [<
80028134>] [<8002e7ac>] [<80077d04>] [<8013a3a8>] [<8002b348>] [<8002b348>] [<8013a3a8>] [<8013a3a
8>] [<8013c644>] [<8005d158>] [<80030418>] [<8002814c>] [<800282f4>] [<8002a154>] [<8002a144>]
Code: af8203f0  8f9303a4  26520001 <8e620008> 00128940  0222102b  1040002b  00001021  8e62000c 

----------

Uranus=>kernel_btrace 
Ready for call trace list.  <ctrl-d> on a blank line when done.

[<8006f97c>]
Call Trace: [<8006f578>] [<8004b6b0>] [<800b452c>] [<80081f48>] [<80081bbc>] [<80047094>] [<800286
38>] [<800686a4>] [<8006ef58>] [<80081a44>] [<8006fe38>] [<8006f4dc>] [<800702c8>] [<800a7dcc>] [<
80028134>] [<8002e7ac>] [<80077d04>] [<8013a3a8>] [<8002b348>] [<8002b348>] [<8013a3a8>] [<8013a3a
8>] [<8013c644>] [<8005d158>] [<80030418>] [<8002814c>] [<800282f4>] [<8002a154>] [<8002a144>]
Code: af8203f0  8f9303a4  26520001 <8e620008> 00128940  0222102b  1040002b  00001021  8e62000c 


Processing...

Address         Function

8006f97c        flush_old_exec
8006f578        kernel_read
8004b6b0        timer_bh
800b452c        generic_make_request
80081f48        load_elf_binary
80081bbc        load_elf_binary
80047094        bh_action
80028638        handle_softirq
800686a4        block_sync_page
8006ef58        copy_strings
80081a44        load_elf_binary
8006fe38        search_binary_handler
8006f4dc        open_exec
800702c8        do_execve
800a7dcc        change_speed
80028134        init
8002e7ac        sys_execve
80077d04        sys_dup
8013a3a8        sprintf
8002b348        stack_done
8002b348        stack_done
8013a3a8        sprintf
8013a3a8        sprintf
8013c644        sprintf
8005d158        __free_pages
80030418        free_initmem
8002814c        init
800282f4        init
8002a154        kernel_thread
8002a144        kernel_thread

Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Sep 2003 06:42:45 +0100 (BST)
Received: from smtp803.mail.sc5.yahoo.com ([IPv6:::ffff:66.163.168.182]:55376
	"HELO smtp803.mail.sc5.yahoo.com") by linux-mips.org with SMTP
	id <S8225370AbTIKFmm>; Thu, 11 Sep 2003 06:42:42 +0100
Received: from adsl-67-122-220-86.dsl.snfc21.pacbell.net (HELO localhost) (narendrasankar@67.122.220.86 with login)
  by smtp-sbc-v1.mail.vip.sc5.yahoo.com with SMTP; 11 Sep 2003 05:42:38 -0000
Date: Wed, 10 Sep 2003 22:42:37 -0700
From: Narendra Sankar <narendrasankar@yahoo.com>
To: linux-mips@linux-mips.org
Subject: Porting Question - new board. Need some help.
Message-Id: <20030910224237.6bedc0bc.narendrasankar@yahoo.com>
X-Mailer: Sylpheed version 0.9.4claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <narendrasankar@yahoo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3160
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: narendrasankar@yahoo.com
Precedence: bulk
X-list: linux-mips

Hi everyone
I am helping a friend port the kernel to a new board that he has built
with a PMC R5231A cpu. The system controller is a custom design (it has
a standard 16550A uart and the interrupts are directly routed to the
cpu). I am currently working off linux_2_4_21 checked out from CVS.
Following the instructions from Jun Sun
(http://linux.junsun.net/porting-howto/) I get to the following point
where things seem to break -

-----------------------------------------------------------
CPU revision is: 00002831
FPU revision is: 00002830
Primary instruction cache 32kB, physically tagged, 2-way, linesize 32
bytes. 
Primary data cache 32kB 2-way, linesize 32 bytes.
Linux version 2.4.21 (naren@laptop) (gcc version 2.95.4 20010319
(prerelease)) 3 
Determined physical RAM map:
 memory: 04000000 @ 00000000 (usable)
Initial ramdisk at: 0x80276000 (1765376 bytes)
On node 0 totalpages: 16384
zone(0): 16384 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: console=ttyS0,115200 kgdb=ttyS0,115200
ramdisk_size=8192 root=/dev/ram*
Calibrating delay loop... 748.74 BogoMIPS 
Memory: 61092k/65536k available (705k kernel code, 4444k reserved, 1848k
data, ) 
Dentry cache hash table entries: 8192 (order: 4, 65536 bytes)
Inode cache hash table entries: 4096 (order: 3, 32768 bytes) 
Mount cache hash table entries: 512 (order: 0, 4096 bytes) 
Buffer-cache hash table entries: 4096 (order: 2, 16384 bytes) 
Page-cache hash table entries: 16384 (order: 4, 65536 bytes) 
Checking for 'wait' instruction... available. 
POSIX conformance testing by UNIFIX 
Linux NET4.0 for Linux 2.4 Based upon Swansea University Computer
Society NET3.039 
Starting kswapd 
pty: 256 Unix98 ptys configured 
Serial driver version 5.05c(2001-07-08) with no serial options enabled
Generic MIPS RTC Driver v1.0 
RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
loop: loaded (max 8 devices) 
RAMDISK: Compressed image found at block 0
Freeing initrd memory: 1724k freed 
VFS: Mounted root (ext2 filesystem) readonly. 
Freeing unused kernel memory: 48k freed 
EXT2-fs warning: mounting unchecked fs, running e2fsck is recommended
-------------------------------------------------------

I am using the big-endian ramdisk from the debian mips distribution for
test purposes. However I do not get to any sort of console prompt. The
system just seems to hang at that point. (Using the QED ITE board, I get
to the point where the debian setup starts.)

The toolchain used to build the kernel is the mips-linux toolchain from
ftp.linux-mips.org-

Reading specs from /usr/lib/gcc-lib/mips-linux/2.95.4/specs
gcc version 2.95.4 20010319 (prerelease)

Trying to debug using kgdb, I can break right before the execve of
/sbin/init. However I cannot step or debug beyond that point. (Using gdb
5.3 built with target=mips-linux). So I know that I get to the exec of
init. However beyond that I do not know what is happening. Using printks
I determined that the system at least enters load_elf_binary.

Anyone have any ideas where I can look for what is going wrong? Also I
am wondering why I cannot use gdb to step into execve? I followed the
porting guide instructions in order to set up kgdb. I can break and step
before the call to init but nothing after that.


Thanks a lot for any help

Naren Sankar

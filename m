Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Sep 2002 15:25:26 +0200 (CEST)
Received: from [203.199.83.247] ([203.199.83.247]:63917 "HELO
	mailweb34.rediffmail.com") by linux-mips.org with SMTP
	id <S1122977AbSICNZZ>; Tue, 3 Sep 2002 15:25:25 +0200
Received: (qmail 23993 invoked by uid 510); 3 Sep 2002 13:25:04 -0000
Date: 3 Sep 2002 13:25:04 -0000
Message-ID: <20020903132504.23992.qmail@mailweb34.rediffmail.com>
Received: from unknown (202.54.89.72) by rediffmail.com via HTTP; 03 Sep 2002 13:25:04 -0000
MIME-Version: 1.0
From: "atul srivastava" <atulsrivastava9@rediffmail.com>
Reply-To: "atul srivastava" <atulsrivastava9@rediffmail.com>
To: linux-mips@linux-mips.org
Subject: MIPS-IDT with ramdisk...? 
Content-type: text/plain;
	format=flowed
Content-Disposition: inline
Return-Path: <atulsrivastava9@rediffmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: atulsrivastava9@rediffmail.com
Precedence: bulk
X-list: linux-mips

Has anybody got MIPS-IDT Big Endian linux port booting with a 
Ramdisk filesystem..

I have got linux up on this board.
also NFS mounting works fine but never Ramdisk support , got 
working.

i have done bacis checks..

1.checksum on ramdisk ..correct
2.uncompression is o.k.
3.filesystem mounted (root=/dev/ram) o.k

whenever i tried to booth with a ramdisk
it goes to execing /bin/sh or so and then
fails in load_elf_binary() at,

/* First of all, some simple consistency checks. */
  if(elf_ex.e_type != ET_EXEC && elf_ex.e_type != ET_DYN)

for me e_type always reported to be 0x200..and there  it fails.

while if after mounting ramdisk with command
#mount -o loop arch/mips/ramdisk/ramdisk /mnt  , and then
  #file /mnt/bin/sh
gives o/p as expected ,

/mnt/bin/sh: ELF 32-bit MSB mips-1 executable, MIPS R3000_BE, 
version 1, dynamically linked (uses shared libs), stripped


MY boot messages pasted below
------------------------------

Determined physical RAM map:
  memory: 8000fc00 @ 80000400 (usable)
  memory: 00ed4210 @ 0012bdf0 (usable)
Initial ramdisk at: 0x80103000 (46022 bytes)
On node 0 totalpages: 4096
zone(0): 4096 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: root=/dev/ram console=ttys0,115200n8 
init=/bin/sh rw
CPU frequency 132.00 MHz
Calibrating delay loop... 131.48 BogoMIPS
Memory: 14904k/15184k available (748k kernel code, 280k reserved, 
107k data, 160k init)
Dentry-cache hash table entries: 2048 (order: 2, 16384 bytes)
Buffer-cache hash table entries: 1024 (order: 0, 4096 bytes)
Page-cache hash table entries: 4096 (order: 2, 16384 bytes)
Inode-cache hash table entries: 1024 (order: 1, 8192 bytes)
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Starting kswapd v1.8
block: queued sectors max/low 9834kB/3278kB, 64 slots per queue
RAMDISK driver initialized: 16 RAM disks of 2048K size 1024 
blocksize
RAMDISK: Compressed image found at block 0
gunzip DEBUG:Orig CRC: 3ccbe06c, Computed CRC: 3ccbe06c
gunzip DEBUG:Orig len: 147851, Computed len: 147851,
RAMDISK: Un-compressed the ramdisk - result: 0
Freeing initrd memory: 44k freed
loop: loaded (max 8 devices)
Serial driver version 5.05 (2000-12-13) with MANY_PORTS SHARE_IRQ 
SERIAL_PCI enabled
ttyS00 at 0x0000 (irq = 0) is a 16550A
ttyS01 at 0x0000 (irq = 0) is a 16550A
physmap flash device: 400000 at b4000000
Physically mapped flash: Found no CFI device at location zero
VFS: Mounted root (ext2 filesystem).
Freeing unused kernel memory: 160k freed
DEBUG: Opening the file /dev/ttyS0
DEBUG: File descriptor returned is -2
Warning: unable to open an initial console.

also it is unable to open a /dev/ttyS0 but this is included in my 
ramdisk image.

I have taken a precompiled ramdisk image (root.bin) from
debian's FTP site.
I don't know what to doubt for....

Best Regards,
Ashish Anand









__________________________________________________________
Give your Company an email address like
ravi @ ravi-exports.com.  Sign up for Rediffmail Pro today!
Know more. http://www.rediffmailpro.com/signup/

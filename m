Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fB803AX28427
	for linux-mips-outgoing; Fri, 7 Dec 2001 16:03:10 -0800
Received: from mail.ivivity.com (user-vc8ftn3.biz.mindspring.com [216.135.246.227])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fB8030o28424
	for <linux-mips@oss.sgi.com>; Fri, 7 Dec 2001 16:03:00 -0800
Received: by ATLOPS with Internet Mail Service (5.5.2448.0)
	id <QMJC3D6P>; Fri, 7 Dec 2001 18:02:53 -0500
Message-ID: <25369470B6F0D41194820002B328BDD2195AD3@ATLOPS>
From: Marc Karasek <marc_karasek@ivivity.com>
To: "'balaji.ramalingam@philips.com '" <balaji.ramalingam@philips.com>,
   "'linux-mips@oss.sgi.com '" <linux-mips@oss.sgi.com>
Subject: RE: not getting the kernel prompt
Date: Fri, 7 Dec 2001 18:02:52 -0500 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2448.0)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

 It looks like your ramdisk is too large.  Is it over 4096 (4k) in size?

-----Original Message-----
From: balaji.ramalingam@philips.com
To: linux-mips@oss.sgi.com
Sent: 12/7/01 2:36 PM
Subject: not getting the kernel prompt



Hello,

I had been trying to get the linux kernel 2.4.3 on our
latest mips core which is mips32 ISA complient.

Finally I was able to boot the kernel after facing a lot of
issues. But I was not able to get a  kernel prompt.
I got the below messages

########################################################################
##################

Detected 32MB of memory
Loading MIPS32 MMU routines.
CPU revision is: 00061200
Primary instruction cache 16kb, linesize 32 bytes (2 ways)
Primary data cache 16kb, linesize 32 bytes (4 ways)
Number of TLB entries 32.
Linux version 2.4.3-MIPS-01.01 (ramaling@svlhp106.sv.sc.philips.com)
(gcc version 3.0 2001042
2 (prerelease)) #11 Wed Nov 28 19:45:33 PST 2001
Determined physical RAM map:
 memory: 02000000 @ 00000000 (usable)
Initial ramdisk at: 0x8010e000 (1916920 bytes)
On node 0 totalpages: 8192
zone(0): 8192 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: root=/dev/ram rw console=ttyS0
calculating viper_offset... 00001200(4608)
CPU frequency in quickturn 0.46 MHz
Memory: 29184k/32768k available (603k kernel code, 3584k reserved, 1923k
data, 36k init)
Dentry-cache hash table entries: 4096 (order: 3, 32768 bytes)
Buffer-cache hash table entries: 1024 (order: 0, 4096 bytes)
Page-cache hash table entries: 8192 (order: 3, 32768 bytes)
Inode-cache hash table entries: 2048 (order: 2, 16384 bytes)
Checking for 'wait' instruction...  available.
POSIX conformance testing by UNIFIX
Based upon Swansea University Computer Society NET3.039
Starting kswapd v1.8
block: queued sectors max/low 19333kB/6444kB, 64 slots per queue
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
RAMDISK: Compressed image found at block 0
crc errorFreeing initrd memory:  1871k freed
VFS:  Mounted root (ext2 filesystem) .
Freeing unused kernel memory:  36k freed
Warning:  unable to open an initial console.
attempt to access beyond end of device
01:00: rw=0, want=7771, limit=4096

########################################################################
##################

I played around the ramdisk image and made sure that the /etc has fstab
file
with /dev/ram entry in it. Also there is a inittab file with
/sbin/agetty entry to take
care of the console ttyS0.

I'm using the ttyS00 device (COM1) for both printing the debug messages
as well
as getting the kernel prompt. I dont know where I'm messing up.

PLEASE give me some tips.
Any help would be greatly appreciated.

regards,
Balaji









Finished kernel_thread; Going to do unlock and cpu_idle

Linux NET4.0 for Linux 2.4

Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fB7KaCX22075
	for linux-mips-outgoing; Fri, 7 Dec 2001 12:36:12 -0800
Received: from gw-nl4.philips.com (gw-nl4.philips.com [212.153.190.6])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fB7Ka3o22065
	for <linux-mips@oss.sgi.com>; Fri, 7 Dec 2001 12:36:03 -0800
Received: from smtpscan-nl2.philips.com (localhost.philips.com [127.0.0.1])
          by gw-nl4.philips.com with ESMTP id UAA22246
          for <linux-mips@oss.sgi.com>; Fri, 7 Dec 2001 20:36:01 +0100 (CET)
          (envelope-from balaji.ramalingam@philips.com)
From: balaji.ramalingam@philips.com
Received: from smtpscan-nl2.philips.com(130.139.36.22) by gw-nl4.philips.com via mwrap (4.0a)
	id xma022244; Fri, 7 Dec 01 20:36:01 +0100
Received: from smtprelay-us1.philips.com (localhost [127.0.0.1]) 
	by smtpscan-nl2.philips.com (8.9.3/8.8.5-1.2.2m-19990317) with ESMTP id UAA11846
	for <linux-mips@oss.sgi.com>; Fri, 7 Dec 2001 20:36:00 +0100 (MET)
Received: from arj001soh.diamond.philips.com (amsoh01.diamond.philips.com [161.88.79.212]) 
	by smtprelay-us1.philips.com (8.9.3/8.8.5-1.2.2m-19990317) with ESMTP id NAA04775
	for <linux-mips@oss.sgi.com>; Fri, 7 Dec 2001 13:35:59 -0600 (CST)
Subject: not getting the kernel prompt
To: linux-mips@oss.sgi.com
Date: Fri, 7 Dec 2001 11:36:43 -0800
Message-ID: <OFBC8C65B4.81E473E6-ON08256B1B.006A7240@diamond.philips.com>
X-MIMETrack: Serialize by Router on arj001soh/H/SERVER/PHILIPS(Release 5.0.5 |September
 22, 2000) at 07/12/2001 13:39:56
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk



Hello,

I had been trying to get the linux kernel 2.4.3 on our
latest mips core which is mips32 ISA complient.

Finally I was able to boot the kernel after facing a lot of
issues. But I was not able to get a  kernel prompt.
I got the below messages

##########################################################################################

Detected 32MB of memory
Loading MIPS32 MMU routines.
CPU revision is: 00061200
Primary instruction cache 16kb, linesize 32 bytes (2 ways)
Primary data cache 16kb, linesize 32 bytes (4 ways)
Number of TLB entries 32.
Linux version 2.4.3-MIPS-01.01 (ramaling@svlhp106.sv.sc.philips.com) (gcc version 3.0 2001042
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
Memory: 29184k/32768k available (603k kernel code, 3584k reserved, 1923k data, 36k init)
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

##########################################################################################

I played around the ramdisk image and made sure that the /etc has fstab file
with /dev/ram entry in it. Also there is a inittab file with /sbin/agetty entry to take
care of the console ttyS0.

I'm using the ttyS00 device (COM1) for both printing the debug messages as well
as getting the kernel prompt. I dont know where I'm messing up.

PLEASE give me some tips.
Any help would be greatly appreciated.

regards,
Balaji









Finished kernel_thread; Going to do unlock and cpu_idle

Linux NET4.0 for Linux 2.4

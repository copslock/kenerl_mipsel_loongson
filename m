Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fBB4wV803205
	for linux-mips-outgoing; Mon, 10 Dec 2001 20:58:31 -0800
Received: from gw-us4.philips.com (gw-us4.philips.com [63.114.235.90])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fBB4wNo03202
	for <linux-mips@oss.sgi.com>; Mon, 10 Dec 2001 20:58:23 -0800
Received: from smtpscan-us1.philips.com (localhost.philips.com [127.0.0.1])
          by gw-us4.philips.com with ESMTP id VAA15368
          for <linux-mips@oss.sgi.com>; Mon, 10 Dec 2001 21:58:21 -0600 (CST)
          (envelope-from balaji.ramalingam@philips.com)
From: balaji.ramalingam@philips.com
Received: from smtpscan-us1.philips.com(167.81.233.25) by gw-us4.philips.com via mwrap (4.0a)
	id xma015364; Mon, 10 Dec 01 21:58:21 -0600
Received: from smtprelay-us1.philips.com (localhost [127.0.0.1]) 
	by smtpscan-us1.philips.com (8.9.3/8.8.5-1.2.2m-19990317) with ESMTP id VAA07505
	for <linux-mips@oss.sgi.com>; Mon, 10 Dec 2001 21:58:20 -0600 (CST)
Received: from arj001soh.diamond.philips.com (amsoh01.diamond.philips.com [161.88.79.212]) 
	by smtprelay-us1.philips.com (8.9.3/8.8.5-1.2.2m-19990317) with ESMTP id VAA28446
	for <linux-mips@oss.sgi.com>; Mon, 10 Dec 2001 21:58:20 -0600 (CST)
Subject: no kernel prompt
To: linux-mips@oss.sgi.com
Date: Mon, 10 Dec 2001 19:59:06 -0800
Message-ID: <OF8FA79526.74430292-ON08256B1F.00136CCF@diamond.philips.com>
X-MIMETrack: Serialize by Router on arj001soh/H/SERVER/PHILIPS(Release 5.0.5 |September
 22, 2000) at 10/12/2001 22:02:15
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk



Hello guys,

I was able to sort out the console issue and know I think the kernel is
able to open /dev/console and I 'm not getting that error message from the kernel saying
unable to open console blau blau..

I also inserted some printk's in the init/main.c before and after the kernel executing /sbin/init.
So I thing the kernel can execute the sbin/init. I replace the init fiel with a simple
shell script which echo the "hello world" message.

But still I cant see the hello message or kernel prompt on my screen apart from the
below kernel messages. I'm using console=ttyS0 (com1).
Can I use the same srial port (COM1 in my case)  for both kernel debug messages
as well as the console. Because my uart is fine.
I also have the console, tty0, ttyS0 devices in the /dev in my ramdisk.
I also have the /etc/fstab file which has the ramdisk entry and agetty in /etc/inittab.
Still I dont get a kernel prompt. I'm running out of options.

Is there a simple test which I can do to confirm that I dont have any issue with
the console or with my ramdisk image?

Please give me some tips and I would really appreciate it.

regards,
Balaji


##########################################################################################

Detected 32MB of memory
Loading MIPS32 MMU routines.
CPU revision is: 00061200
Primary instruction cache 16kb, linesize 32 bytes (2 ways)
Primary data cache 16kb, linesize 32 bytes (4 ways)
Number of TLB entries 32.
Linux version 2.4.3-MIPS-01.01 (ramaling@svlhp106.sv.sc.philips.com) (gcc version 3.0 2001042
2 (prerelease)) #1 Mon Dec 10 18:48:41 PST 2001
Determined physical RAM map:
 memory: 02000000 @ 00000000 (usable)
Initial ramdisk at: 0x8010c000 ( 482280 bytes)
On node 0 totalpages: 8192
zone(0): 8192 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: root=/dev/ram rw console=ttyS0
calculating viper_offset... 00001200(4608)
CPU frequency in quickturn 0.46 MHz
Memory: 30592k/32768k available (600k kernel code, 2176k reserved, 515k data, 36k init)
Dentry-cache hash table entries: 4096 (order: 3, 32768 bytes)
Buffer-cache hash table entries: 1024 (order: 0, 4096 bytes)
Page-cache hash table entries: 8192 (order: 3, 32768 bytes)
Inode-cache hash table entries: 2048 (order: 2, 16384 bytes)
Checking for 'wait' instruction...  available.
POSIX conformance testing by UNIFIX
Based upon Swansea University Computer Society NET3.039
Starting kswapd v1.8
SCC2691/ProMIPS Serial Driver, version 0.01
ttyS00 at 0xb0800000 (irq = 1)
block: queued sectors max/low 20272kB/6757kB, 64 slots per queue
RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
RAMDISK: Compressed image found at block 0
Freeing initrd memory: 470k freed
VFS:  Mounted root (ext2 filesystem) .
Freeing unused kernel memory:  36k freed

##########################################################################################

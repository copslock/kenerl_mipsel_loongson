Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fBB5abt03903
	for linux-mips-outgoing; Mon, 10 Dec 2001 21:36:37 -0800
Received: from mail.ivivity.com (user-vc8ftn3.biz.mindspring.com [216.135.246.227])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fBB5aSo03900
	for <linux-mips@oss.sgi.com>; Mon, 10 Dec 2001 21:36:28 -0800
Received: by ATLOPS with Internet Mail Service (5.5.2448.0)
	id <QMJC31QY>; Mon, 10 Dec 2001 23:36:21 -0500
Message-ID: <25369470B6F0D41194820002B328BDD2195AD9@ATLOPS>
From: Marc Karasek <marc_karasek@ivivity.com>
To: "'balaji.ramalingam@philips.com '" <balaji.ramalingam@philips.com>,
   "'linux-mips@oss.sgi.com '" <linux-mips@oss.sgi.com>
Subject: RE: no kernel prompt
Date: Mon, 10 Dec 2001 23:36:20 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2448.0)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

I ran across something like this before.  Whatever you are using for
yourinit is it dynamically linked?  If so try to statically link it.  I was
seeing something similar happen and it was because of a problem in the
dynamic linking.  It was failing to find the proper lib to continue, but
could not dump any output to the terminal to tell me.  It was a bear to find
... :-) 

-----Original Message-----
From: balaji.ramalingam@philips.com
To: linux-mips@oss.sgi.com
Sent: 12/10/01 10:59 PM
Subject: no kernel prompt



Hello guys,

I was able to sort out the console issue and know I think the kernel is
able to open /dev/console and I 'm not getting that error message from
the kernel saying
unable to open console blau blau..

I also inserted some printk's in the init/main.c before and after the
kernel executing /sbin/init.
So I thing the kernel can execute the sbin/init. I replace the init fiel
with a simple
shell script which echo the "hello world" message.

But still I cant see the hello message or kernel prompt on my screen
apart from the
below kernel messages. I'm using console=ttyS0 (com1).
Can I use the same srial port (COM1 in my case)  for both kernel debug
messages
as well as the console. Because my uart is fine.
I also have the console, tty0, ttyS0 devices in the /dev in my ramdisk.
I also have the /etc/fstab file which has the ramdisk entry and agetty
in /etc/inittab.
Still I dont get a kernel prompt. I'm running out of options.

Is there a simple test which I can do to confirm that I dont have any
issue with
the console or with my ramdisk image?

Please give me some tips and I would really appreciate it.

regards,
Balaji


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
Memory: 30592k/32768k available (600k kernel code, 2176k reserved, 515k
data, 36k init)
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

########################################################################
##################

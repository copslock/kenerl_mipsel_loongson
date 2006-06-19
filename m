Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Jun 2006 05:24:43 +0100 (BST)
Received: from [220.76.242.187] ([220.76.242.187]:60069 "EHLO
	localhost.localdomain") by ftp.linux-mips.org with ESMTP
	id S8127208AbWFSEYd (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 19 Jun 2006 05:24:33 +0100
Received: from mrv ([192.168.11.157])
	by localhost.localdomain (8.12.8/8.12.8) with SMTP id k5J4PrBb007255
	for <linux-mips@linux-mips.org>; Mon, 19 Jun 2006 13:25:57 +0900
Message-ID: <002a01c69358$414cb8b0$9d0ba8c0@mrv>
From:	"Roman Mashak" <mrv@corecom.co.kr>
To:	<linux-mips@linux-mips.org>
Subject: PMC-sierra and 2.6.12 kernel
Date:	Mon, 19 Jun 2006 13:24:25 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="koi8-r";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2869
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2869
FL-Build: Fidolook 2002 (SL) 6.0.2800.86 - 14/6/2003 22:16:25
Return-Path: <mrv@corecom.co.kr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11760
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mrv@corecom.co.kr
Precedence: bulk
X-list: linux-mips

Hello!

We have problem enabling second gigabit ethernet interface on PMC-sierra 
"Sequoia" board. Here's boot log:

Loading file: tftp://192.168.11.43/vmlinux (elf)
0x80100000/2293894 + 0x80330086/114586(z) + 4011 syms|
Linux version 2.6.12-rc3 (root@ecb-test32.corecom.local) (gcc version 
3.3-mips64linux-031001) #8 Fri Jun 2 20:08:34 KST 2006
PMON reports memory size 256MB
cpu_clock set to 900000000
CPU revision is: 000034c1
FPU revision is: 00003420
PMC-Sierra Sequoia Board Setup
32-bit support
Determined physical RAM map:
 memory: 20000000 @ 00000000 (usable)
User-defined physical RAM map:
 memory: 10000000 @ 00000000 (usable)
Built 1 zonelists
Kernel command line: tftp://192.168.11.43/vmlinux root=/dev/nfs 
nfsroot=192.168.11.43:/export/linux/mips-fs-be ip=192.168.11.42:::::eth0 
mem=256M noirqdebug pci=noacpi
Unknown boot option `tftp://192.168.11.43/vmlinux': ignoring
IRQ lockup detection disabled
PCI: Unknown option `noacpi'
Primary instruction cache 16kB, physically tagged, 4-way, linesize 32 bytes.
Primary data cache 16kB, 4-way, linesize 32 bytes.
Secondary cache size 256K, linesize 32 bytes.
Synthesized TLB refill handler (27 instructions).
Synthesized TLB load handler fastpath (39 instructions).
Synthesized TLB store handler fastpath (39 instructions).
Synthesized TLB modify handler fastpath (38 instructions).
PID hash table entries: 2048 (order: 11, 32768 bytes)
Using 450.000 MHz high precision timer.
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Memory: 256128k/262144k available (1553k kernel code, 5860k reserved, 342k 
data, 344k init, 0k highmem)
CompactFlash ATA Support for PMC-Sierra Sequoia
 <6>Internal UART Support for PMC-Sierra Sequoia
 <7>Calibrating delay loop... 897.02 BogoMIPS (lpj=448512)
Mount-cache hash table entries: 512
Checking for 'wait' instruction...  available.
NET: Registered protocol family 16
PCI: Failed to allocate mem resource #2:20000000@e0000000 for 0000:00:01.0
PCI: Failed to allocate mem resource #2:20000000@e8000000 for 0000:01:01.0
Generic RTC Driver v1.07
Serial: 8250/16550 driver $Revision: 1.1.1.1 $ 4 ports, IRQ sharing disabled
ttyS0 at MMIO 0x0 (irq = 0) is a 16550A
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
PMC-Sierra MSP85x0 10/100/1000 Ethernet Driver
Device Id : 206014,  Version : 0
: port 0 with MAC address 00:e0:04:00:02:4e
Rx NAPI supported, Tx Coalescing ON
: port 1 with MAC address 00:e0:04:00:02:4f
Rx NAPI supported, Tx Coalescing ON
NET: Registered protocol family 2
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP established hash table entries: 16384 (order: 5, 131072 bytes)
TCP bind hash table entries: 16384 (order: 4, 65536 bytes)
TCP: Hash tables configured (established 16384 bind 16384)
NET: Registered protocol family 1
NET: Registered protocol family 17
Assigned IRQ 5 to port 0
IP-Config: Guessing netmask 255.255.255.0
IP-Config: Complete:
      device=eth0, addr=192.168.11.42, mask=255.255.255.0, 
gw=255.255.255.255,
     host=192.168.11.42, domain=, nis-domain=(none),
     bootserver=255.255.255.255, rootserver=192.168.11.43, rootpath=
Looking up port of RPC 100003/2 on 192.168.11.43
Looking up port of RPC 100005/1 on 192.168.11.43
VFS: Mounted root (nfs filesystem) readonly.
Freeing unused kernel memory: 344k freed
INIT: version 2.78 booting
Activating swap...
Checking all file systems...
Parallelizing fsck version 1.22 (22-Jun-2001)
Calculating module dependencies... depmod: QM_MODULES: Function not 
implemented

done.
Loading modules:
modprobe: QM_MODULES: Function not implemented

mkdir: cannot create directory `/dev/pts': File exists
Mounting local filesystems...
nothing was mounted
Cleaning: /etc/network/ifstate.
Setting up IP spoofing protection: rp_filter.
Disable TCP/IP Explicit Congestion Notification: done.
Configuring network interfaces: Don't seem to be have all the variables for 
eth0/inet.
done.
Starting portmap daemon: portmap.
Cleaning: /tmp /var/lock /var/run.
INIT: Entering runlevel: 3
Starting system log daemon: klogd.
Starting internet superserver: inetd.

Here I'm trying to enable interface:
root@192.168.11.42:~# ifconfig eth1 up
Assigned IRQ 6 to port 1
XDMA currently has 64 Rx descriptors
eth1: Error opening interface
SIOCSIFFLAGS: Device or resource busy
root@192.168.11.42:~#

Interrrupts:
root@192.168.11.42:~# cat /proc/interrupts
           CPU0
  5:       8985            MIPS  eth0
  7:     692504            MIPS  timer

ERR:          0
root@192.168.11.42:~#

With best regards, Roman Mashak.  E-mail: mrv@corecom.co.kr 

Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 May 2003 11:10:04 +0100 (BST)
Received: from bay1-f62.bay1.hotmail.com ([IPv6:::ffff:65.54.245.62]:64006
	"EHLO hotmail.com") by linux-mips.org with ESMTP
	id <S8225236AbTEHKKC>; Thu, 8 May 2003 11:10:02 +0100
Received: from mail pickup service by hotmail.com with Microsoft SMTPSVC;
	 Thu, 8 May 2003 03:09:53 -0700
Received: from 4.35.224.219 by by1fd.bay1.hotmail.msn.com with HTTP;
	Thu, 08 May 2003 10:09:53 GMT
X-Originating-IP: [4.35.224.219]
X-Originating-Email: [michaelanburaj@hotmail.com]
From: "Michael Anburaj" <michaelanburaj@hotmail.com>
To: linux-mips@linux-mips.org
Subject: Re: Linux for MIPS Atlas 4Kc board
Date: Thu, 08 May 2003 03:09:53 -0700
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <BAY1-F62WlX0MGOV6T000004f80@hotmail.com>
X-OriginalArrivalTime: 08 May 2003 10:09:53.0319 (UTC) FILETIME=[F7F2DB70:01C31549]
Return-Path: <michaelanburaj@hotmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2295
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: michaelanburaj@hotmail.com
Precedence: bulk
X-list: linux-mips

Hi all,

Finally I got the Atlas 4Kc board running YAMON to talk to Host PC running 
RedHat Linux 9 & download vmlinux.rec throught tftp. I have set-up NFS 
export in the same PC under /export/RedHat7.1

After the vmlinux.rec got downloaded, I issued the following command on the 
YAMON (MIPS tartget) prompt to start the downloaded linux kernel:

go . nsfroot=4.42.102.7:/export/RedHat7.1

while the Linux kernel was booting up, I  monitored the tcp/ip traffic on 
the host PC using 'tcpdump -n'. The Linux did not send any packets. why?

YAMON console dump of Linux kernel start-up messages:
------------------------------------------------------------------------------

YAMON> load tftp:
About to load tftp://4.42.102.7/vmlinux.rec
Press Ctrl-C to break
........................................
........................................
........................................
........................................
......................................
Start = 0x8024a040, range = (0x80100000,0x8028dfff), format = SREC
YAMON> go . nfsroot=4.42.102.7:/export/RedHat7.1

LINUX started...
Config serial console: ttyS0,115200
CPU revision is: 00018001
Primary instruction cache 16kB, physically tagged, 4-way, linesize 16 bytes.
Primary data cache 16kB 4-way, linesize 16 bytes.
Linux version 2.4.21-pre4 (root@localhost.localdomain) (gcc version 
egcs-2.91.63Determined physical RAM map:
memory: 00001000 @ 00000000 (reserved)
memory: 000ef000 @ 00001000 (ROM data)
memory: 00010000 @ 000f0000 (ROM data)
memory: 001a4000 @ 00100000 (reserved)
memory: 03d5c000 @ 002a4000 (usable)
On node 0 totalpages: 16384
zone(0): 16384 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: nfsroot=4.42.102.7:/export/RedHat7.1
calculating r4koff... 00061a87(400007)
CPU frequency 80.00 MHz
Calibrating delay loop... 79.66 BogoMIPS
Memory: 62120k/62832k available (1308k kernel code, 712k reserved, 164k 
data, 1)Dentry cache hash table entries: 8192 (order: 4, 65536 bytes)
Inode cache hash table entries: 4096 (order: 3, 32768 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer-cache hash table entries: 4096 (order: 2, 16384 bytes)
Page-cache hash table entries: 16384 (order: 4, 65536 bytes)
Checking for 'wait' instruction...  available.
POSIX conformance testing by UNIFIX
PCI: Probing PCI hardware on host bus 0.
PCI: device 01:02.0 has unknown header type 7f, ignoring.
PCI: device 01:06.0 has unknown header type 7f, ignoring.
PCI: device 01:18.0 has unknown header type 7f, ignoring.
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ 
SERIAL_PCI edttyS00 at 0x1f000900 (irq = 0) is a 16550A
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
Found SAA9730 (PCI) at 0x10800000, irq 16.
SCSI subsystem driver Revision: 1.00
ncr53c8xx: at PCI bus 0, device 16, function 0
ncr53c8xx: 53c810a detected
ncr53c810a-0: rev 0x12 on pci bus 0 device 16 function 0 irq 17
ncr53c810a-0: ID 7, Fast-10, Parity Checking
scsi0 : ncr53c8xx-3.4.3b-20010512
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 4096 bind 4096)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Looking up port of RPC 100003/2 on 4.42.102.7
RPC: sendmsg returned error 128
portmap: RPC call returned error 128
Root-NFS: Unable to get nfsd port number from server, using default
Looking up port of RPC 100005/1 on 4.42.102.7
RPC: sendmsg returned error 128
portmap: RPC call returned error 128
Root-NFS: Unable to get mountd port number from server, using default
RPC: sendmsg returned error 128
mount: RPC call returned error 128
Root-NFS: Server returned error -128 while mounting /export/RedHat7.1
VFS: Unable to mount root fs via NFS, trying floppy.
VFS: Cannot open root device "" or 02:00
Please append a correct "root=" boot option
Kernel panic: VFS: Unable to mount root fs on 02:00



Please let me know if you have any clues on this...

Thanks a lot,
-Mike.

_________________________________________________________________
Protect your PC - get McAfee.com VirusScan Online  
http://clinic.mcafee.com/clinic/ibuy/campaign.asp?cid=3963

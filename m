Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Mar 2004 07:12:55 +0000 (GMT)
Received: from webmail-outgoing.us4.outblaze.com ([IPv6:::ffff:205.158.62.67]:50821
	"EHLO webmail-outgoing.us4.outblaze.com") by linux-mips.org
	with ESMTP id <S8225213AbUCRHMu>; Thu, 18 Mar 2004 07:12:50 +0000
Received: from wfilter.us4.outblaze.com (wfilter.us4.outblaze.com [205.158.62.180])
	by webmail-outgoing.us4.outblaze.com (Postfix) with QMQP id 6245F1800918
	for <linux-mips@linux-mips.org>; Thu, 18 Mar 2004 07:12:41 +0000 (GMT)
X-OB-Received: from unknown (205.158.62.156)
  by wfilter.us4.outblaze.com; 18 Mar 2004 07:12:10 -0000
Received: by ws5-7.us4.outblaze.com (Postfix, from userid 1001)
	id 348842B2B57; Thu, 18 Mar 2004 07:12:41 +0000 (GMT)
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
Received: from [203.197.141.34] by ws5-7.us4.outblaze.com with http for
    xavier_prabhu@linuxmail.org; Thu, 18 Mar 2004 15:12:40 +0800
From: "xavier prabhu" <xavier_prabhu@linuxmail.org>
To: linux-mips@linux-mips.org
Cc: dan@embeddededge.com
Date: Thu, 18 Mar 2004 15:12:40 +0800
Subject: Au1550 Boot  Issue
X-Originating-Ip: 203.197.141.34
X-Originating-Server: ws5-7.us4.outblaze.com
Message-Id: <20040318071241.348842B2B57@ws5-7.us4.outblaze.com>
Return-Path: <xavier_prabhu@linuxmail.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4573
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: xavier_prabhu@linuxmail.org
Precedence: bulk
X-list: linux-mips

Hi Dan,

I had used the kernel source from embedded edge (http://embeddededge.com/downloads/amd-alchemy/)
to boot Au1550 based board. It can boot well and no TLB exceptions.
But I've another issue during the boot. The kernel couldn't mount the filesystem (cramfs).
It panics with the message "cramfs wrong magic".

Please help me to solve this issue. I had listed below the boot message.

Thanks and Regards,
Xavier.


YAMON ROM Monitor, Revision 02.20PB1550.
Copyright (c) 1999-2000 MIPS Technologies, Inc. - All Rights Reserved.

For a list of available commands, type 'help'.

Compilation time =            Dec 11 2003  08:34:31
MAC address =                 0a.01.00.00.00.0f
Processor Company ID =        0x03
Processor ID/revision =       0x02 / 0x00
Endianness =                  Little
CPU =                         396 MHz
Flash memory size =           128 MByte
SDRAM size =                  128 MByte
First free SDRAM address =    0x8008d484

Environment variable 'start' exists. After 2 seconds
it will be interpreted as a YAMON command and executed.
Press Ctrl-C to bypass this.

YAMON> erase
what...
The following area will be erased:
Start address = 0x18000000
Size          = 0x07c00000
Confirm ? (y/n) y
Erasing...Done
YAMON> load -r tftp://10.145.2.248/cramfsimage.srec
About to load tftp://10.145.2.248/cramfsimage.srec
Press Ctrl-C to break
........................................
........................................
........................................
........................................
........................................
........................................
........................................
........................................
........................................
........................................
........................................
........................................
........................................
........................................
........................................
........................................
........................................
........................................
........................
Start = 0xbf100000, range = (0xbf100000,0xbf6cdfff), format = SREC
YAMON> load -r tftp://10.145.2.248/zImage.srec
About to load tftp://10.145.2.248/zImage.srec
Press Ctrl-C to break
........................................
........................................
...........................
Start = 0xbf000000, range = (0xbf000000,0xbf0d5fff), format = SREC
YAMON> go bf000000 root=/dev/mtdblock1
loaded at:     BF000000 BF0D6000
relocated to:  81000000 810D6000
zimage at:     81006540 810D504D
Uncompressing Linux at load address 80100000
Now booting the kernel
CPU revision is: 03030200
Primary instruction cache 16kB, physically tagged, 4-way, linesize 32 bytes.
Primary data cache 16kB 4-way, linesize 32 bytes.
Linux version 2.4.25 (root@homenet2) (gcc version 2.95.3 20010315 (release/Monta
Vista)) #3 Thu Mar 18 11:24:15 IST 2004
AMD Alchemy Pb1550 Board
Au1550 AA (PRId 03030200) @ 396MHZ
BCLK switching enabled!
Determined physical RAM map:
 memory: 08000000 @ 00000000 (usable)
On node 0 totalpages: 32768
zone(0): 32768 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: root=/dev/mtdblock1 console=ttyS0,115200
calculating r4koff... 003c6cc0(3960000)
CPU frequency 396.00 MHz
Console: colour dummy device 80x25
Calibrating delay loop... 395.67 BogoMIPS
Memory: 126304k/131072k available (1684k kernel code, 4768k reserved, 216k data,
 276k init, 0k highmem)
Dentry cache hash table entries: 16384 (order: 5, 131072 bytes)
Inode cache hash table entries: 8192 (order: 4, 65536 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer cache hash table entries: 8192 (order: 3, 32768 bytes)
Page-cache hash table entries: 32768 (order: 5, 131072 bytes)
Checking for 'wait' instruction...  unavailable.
POSIX conformance testing by UNIFIX
Autoconfig PCI channel 0x80324138
Scanning bus 00, I/O 0x00000300:0x00100000, Mem 0x40000000:0x50000000
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
pty: 256 Unix98 ptys configured
Serial driver version 1.01 (2001-02-08) with no serial options enabled
ttyS00 at 0xb1100000 (irq = 0) is a 16550
ttyS01 at 0xb1200000 (irq = 1) is a 16550
ttyS02 at 0xb1300000 (irq = 2) is a 16550
ttyS03 at 0xb1400000 (irq = 3) is a 16550
loop: loaded (max 8 devices)
au1000eth.c:1.4 ppopov@mvista.com
eth0: Au1x Ethernet found at 0xb0500000, irq 27
eth0: AMD 79C874 10/100 BaseT PHY at phy address 31
eth0: Using AMD 79C874 10/100 BaseT PHY as default
eth1: Au1x Ethernet found at 0xb0510000, irq 28
eth1: AMD 79C874 10/100 BaseT PHY at phy address 31
eth1: Using AMD 79C874 10/100 BaseT PHY as default
Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
ide: Assuming 50MHz system bus speed for PIO modes; override with idebus=xx
Au1550 psc audio: DAC: DMA16, ADC: DMA17
ac97_codec: AC97 Audio codec, id: 0x8384:0x7652 (SigmaTel STAC9752/53)
Au1550 psc audio: AC'97 Base/Extended ID = 6a90/0a05
Pb1550 MTD: boot:swap 0
Pb1550 flash: probing 32-bit flash bus
Pb1550 flash: Found 2 x16 devices at 0x4000000 in 32-bit mode
 Amd/Fujitsu Extended Query Table v1.3 at 0x0040
number of CFI chips: 2
Creating 3 MTD partitions on "Pb1550 flash":
0x00000000-0x07c00000 : "User FS"
0x07c00000-0x07d00000 : "yamon"
0x07d00000-0x07fc0000 : "raw kernel"
mice: PS/2 mouse device common for all mice
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 1024 buckets, 8Kbytes
TCP: Hash tables configured (established 8192 bind 8192)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
cramfs: wrong magic :
Kernel panic: VFS: Unable to mount root fs on 1f:01

-- 
______________________________________________
Check out the latest SMS services @ http://www.linuxmail.org 
This allows you to send and receive SMS through your mailbox.


Powered by Outblaze

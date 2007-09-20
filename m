Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Sep 2007 16:28:46 +0100 (BST)
Received: from an-out-0708.google.com ([209.85.132.250]:24202 "EHLO
	an-out-0708.google.com") by ftp.linux-mips.org with ESMTP
	id S20022973AbXITP2h convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 20 Sep 2007 16:28:37 +0100
Received: by an-out-0708.google.com with SMTP id d26so82682and
        for <linux-mips@linux-mips.org>; Thu, 20 Sep 2007 08:28:19 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:mime-version:content-disposition:content-type:content-transfer-encoding:message-id;
        bh=AtUfM9rL0g1EP37DZ8nfWM5YqqB1qm9xweDYXn1+rrI=;
        b=somr99G7oq9Mi097W157t3hCGbTWLilPCddI5QRT+9msMJPolvQ5YstI1UMBajfDf5Ytq0Urp+TGSj6XcAy+Bt4uUFlv5l1UpdIVhhIImNxzsbuu+jhoWAwCc8AnHLgSS0A+j22MAwao3f9HbN1yNwZDwc0Im0TZ0C/UAH0jvXU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-disposition:content-type:content-transfer-encoding:message-id;
        b=KtvU9c/AIpW2152/F+aqQZy69LKwaTFh+H4WbHwiGRNiQq9donkPTUNqVc750vLRyiI+kjQ5AUu9AZUoORGZvCZgfBNQUqKj7lB6LZReALB7MTiatKgBlDxmg107XymuMl78K6JaC0CFiH7NuK/c67dnl6G3PC9PnPdvd2Gj1jU=
Received: by 10.100.143.11 with SMTP id q11mr3944983and.1190302098832;
        Thu, 20 Sep 2007 08:28:18 -0700 (PDT)
Received: from ?192.168.0.3? ( [87.6.117.29])
        by mx.google.com with ESMTPS id s40sm1418803hsb.2007.09.20.08.28.14
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 20 Sep 2007 08:28:17 -0700 (PDT)
From:	Matteo Croce <technoboy85@gmail.com>
To:	linux-mips@linux-mips.org
Subject: [PATCH][MIPS][0/7] AR7: 4th effort
Date:	Thu, 20 Sep 2007 17:28:10 +0200
User-Agent: KMail/1.9.6 (enterprise 0.20070907.709405)
Cc:	nico@openwrt.org, nbd@openwrt.org, florian@openwrt.org,
	openwrt-devel@lists.openwrt.org,
	Andrew Morton <akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Message-Id: <200709201728.10866.technoboy85@gmail.com>
Return-Path: <technoboy85@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16583
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: technoboy85@gmail.com
Precedence: bulk
X-list: linux-mips

These are patch for the AR7 router board:
core, serial hack, mtd partition map, ethernet, gpio pins, watchdog and leds

Here is a live session log:

ADAM2 Revision 0.22.12
(C) Copyright 1996-2003 Texas Instruments Inc. All Rights Reserved.
(C) Copyright 2003 Telogy Networks, Inc.
Usage: setmfreq [-d] [-s sys_freq, in MHz] [cpu_freq, in MHz]
Memory optimization Complete!

mac_init(): Find mac [00:13:10:01:C5:2A] in location 1
Find mac [00:13:10:01:C5:2A] in location 1
mac_value:00:13:10:01:C5:2A
tftpserver initialized

Adam2_AR7WRD > 
Press any key to abort OS load, or wait 5 seconds for OS to boot...
Linux version 2.6.22.4 (matteo@raver) (gcc version 4.2.1) #1 Thu Sep 20 16:41:39 CEST 2007
CPU revision is: 00018448
TI AR7 (TNETD7300), ID: 0x0005, Revision: 0x02
Determined physical RAM map:
 memory: 01000000 @ 14000000 (usable)
Built 1 zonelists.  Total pages: 4064
Kernel command line: init=/etc/preinit rootfstype=squashfs,jffs2, console=ttyS0,38400n8r
Primary instruction cache 16kB, physically tagged, 4-way, linesize 16 bytes.
Primary data cache 16kB, 4-way, linesize 16 bytes.
Synthesized TLB refill handler (20 instructions).
Synthesized TLB load handler fastpath (32 instructions).
Synthesized TLB store handler fastpath (32 instructions).
Synthesized TLB modify handler fastpath (31 instructions).
PID hash table entries: 64 (order: 6, 256 bytes)
Using 75.000 MHz high precision timer.
Dentry cache hash table entries: 2048 (order: 1, 8192 bytes)
Inode-cache hash table entries: 1024 (order: 0, 4096 bytes)
Memory: 12228k/16384k available (2315k kernel code, 4156k reserved, 423k data, 112k init, 0k highmem)
SLUB: Genslabs=17, HWalign=32, Order=0-1, MinObjects=4, CPUs=1, Nodes=1
Mount-cache hash table entries: 512
NET: Registered protocol family 16
vlynq0: regs 0x08611800, irq 29, mem 0x04000000
vlynq1: regs 0x08611c00, irq 33, mem 0x0c000000
vlynq-pci: attaching device TI TNETW1130 at vlynq0
registering PCI controller with io_map_base unset
Generic PHY: Registered new driver
NET: Registered protocol family 8
NET: Registered protocol family 20
Time: MIPS clocksource has been installed.
NET: Registered protocol family 2
IP route cache hash table entries: 1024 (order: 0, 4096 bytes)
TCP established hash table entries: 512 (order: 0, 4096 bytes)
TCP bind hash table entries: 512 (order: -1, 2048 bytes)
TCP: Hash tables configured (established 512 bind 512)
TCP reno registered
squashfs: version 3.0 (2006/03/15) Phillip Lougher
Registering mini_fo version $Id$
JFFS2 version 2.2. (NAND) (SUMMARY)  © 2001-2006 Red Hat, Inc.
io scheduler noop registered
io scheduler deadline registered (default)
ar7_wdt: timer margin 59 seconds (prescale 65535, change 57180, freq 62500000)
Serial: 8250/16550 driver $Revision: 1.90 $ 2 ports, IRQ sharing disabled
serial8250: ttyS0 at MMIO 0x8610e00 (irq = 15) is a TI-AR7
console handover: boot [early0] -> real [ttyS0]
serial8250: ttyS1 at MMIO 0x8610f00 (irq = 16) is a TI-AR7
Fixed PHY: Registered new driver
PPP generic driver version 2.4.2
cpmac-mii: probed
cpmac: device eth0 (regs: 08612800, irq: 41, phy: fixed@100:1, mac: 00:13:10:01:c5:2a)
cpmac: device eth1 (regs: 08610000, irq: 27, phy: 0:1f, mac: 00:13:10:01:c5:2a)
physmap platform flash device: 00800000 at 10000000
physmap-flash.0: Found 1 x16 devices at 0x0 in 16-bit bank
 Amd/Fujitsu Extended Query Table at 0x0040
physmap-flash.0: Swapping erase regions for broken CFI table.
number of CFI chips: 1
cfi_cmdset_0002: Disabling erase-suspend-program due to code brokenness.
cmdlinepart partition parsing not available
RedBoot partition parsing not available
Parsing AR7 partition map...
4 ar7part partitions found on MTD device physmap-flash.0
Creating 4 MTD partitions on "physmap-flash.0":
0x00000000-0x00010000 : "loader"
0x003f0000-0x00400000 : "config"
0x00020000-0x003f0000 : "linux"
0x0010008e-0x003f0000 : "rootfs"
mtd: partition "rootfs" doesn't start on an erase block boundary -- force read-only
mtd: partition "rootfs" set to be root filesystem
mtd: partition "rootfs_data" created automatically, ofs=280000, len=170000 
0x00280000-0x003f0000 : "rootfs_data"
Registered led device: ar7:status
u32 classifier
    Actions configured 
nf_conntrack version 0.5.0 (128 buckets, 1024 max)
ip_tables: (C) 2000-2006 Netfilter Core Team
TCP cubic registered
NET: Registered protocol family 1
NET: Registered protocol family 10
IPv6 over IPv4 tunneling driver
NET: Registered protocol family 17
VFS: Mounted root (squashfs filesystem) readonly.
Freeing unused kernel memory: 112k freed
Warning: unable to open an initial console.
Algorithmics/MIPS FPU Emulator v1.5
mini_fo: using base directory: /
mini_fo: using storage directory: /tmp/root
init started:  BusyBox v1.4.2 (2007-09-16 03:20:09 CEST) multi-call binary
PHY: fixed@100:1 - Link is Up - 10/Half
registered device TI Avalanche SAR
Sangam detected
requesting firmware image "ar0700xx.bin"
Creating new root folder avalanche in the proc for the driver stats 
Texas Instruments ATM driver: version:[7.02.01.00]
jffs2_scan_eraseblock(): End of filesystem marker found at 0x0
jffs2_build_filesystem(): unlocking the mtd device... done.
jffs2_build_filesystem(): erasing all blocks after the end marker... done.
eth0: no IPv6 routers present
mini_fo: using base directory: /
mini_fo: using storage directory: /jffs
[/]# uname -a
Linux OpenWrt 2.6.22.4 #1 Thu Sep 20 16:41:39 CEST 2007 mips unknown
[/]# cat /proc/cpuinfo
system type             : TI AR7 (TNETD7300)
processor               : 0
cpu model               : MIPS 4KEc V4.8
BogoMIPS                : 149.50
wait instruction        : yes
microsecond timers      : yes
tlb_entries             : 16
extra interrupt vector  : yes
hardware watchpoint     : yes
ASEs implemented        :
VCED exceptions         : not available
VCEI exceptions         : not available

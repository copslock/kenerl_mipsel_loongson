Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Aug 2008 05:19:54 +0100 (BST)
Received: from ws02.shaidc.com ([218.78.208.152]:38637 "HELO ws01.shaidc.com")
	by ftp.linux-mips.org with SMTP id S20023167AbYHGETq convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 7 Aug 2008 05:19:46 +0100
X-Lasthop: 222.66.84.134
Received: from unknown (helo GHOST-E2417EF88)(unknown@222.66.84.134)
	by ws01.shaidc.com with SMTP; Thu, 07 Aug 2008 04:40:46 +0000
From:	"maowy" <maowy@avit.org.cn>
To:	borasah@netone.com.tr <borasah@netone.com.tr>
CC:	linux-mips-bounce@linux-mips.org <linux-mips-bounce@linux-mips.org>,
 linux-mips@linux-mips.org <linux-mips@linux-mips.org>
Subject: Au1550 Nandflash
X-mailer: Foxmail 4.2 [cn]
Mime-Version: 1.0
Content-Type: text/plain;
      charset="GB2312"
Content-Transfer-Encoding: 8BIT
Date:	Thu, 7 Aug 2008 12:16:19 +0800
Message-Id: <S20023167AbYHGETq/20080807041946Z+558223@ftp.linux-mips.org>
Return-Path: <maowy@avit.org.cn>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20140
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: maowy@avit.org.cn
Precedence: bulk
X-list: linux-mips

borasah，您好！
	I have the same problem with you when using nandflash.
    Our kernel can recognize nandflash but it seems to be all bad block.
	How dou you successfully solve this problem of  nandflash .
	Can you tell how to solve this problem.
	Hope to receive your letter as soon as possible.Thanks.
	

our platform:AU1550
OS:linux-2.6.13

Our kernel information is following:
	

Kernel command line: root=/dev/nfs rw nfsroot=192.168.15.6:/nfs noinitrd init=/linuxrc ip=192.168.15.4::192.168.15.254:255.255.255.0:DVR:eth0:off console=ttyS0,115200
Primary instruction cache 16kB, physically tagged, 4-way, linesize 32 bytes.
Primary data cache 16kB, 4-way, linesize 32 bytes.
Synthesized TLB refill handler (17 instructions).
Synthesized TLB load handler fastpath (34 instructions).
Synthesized TLB store handler fastpath (34 instructions).
Synthesized TLB modify handler fastpath (33 instructions).
PID hash table entries: 512 (order: 9, 8192 bytes)
calculating r4koff... 00060ae0(396000)
Using 396.000 MHz high precision timer.
Console: colour dummy device 80x25
Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
Memory: 59520k/65536k available (3296k kernel code, 5948k reserved, 704k data, 148k init, 0k highmem)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
Checking for 'wait' instruction...  unavailable.
NET: Registered protocol family 16
virt_io_addr = 0xc0000000
mhd : start AUTO SCAN !!!!!!!!!!!!!!!!!!!!!!!!!
mhd : test is test by mhd!
Autoconfig PCI channel 0x804c1f5c
Scanning bus 00, I/O 0x00001000:0x00100000, Mem 0x40000000:0x50000000
MHD : Scanning  bus 00 ....
Liqiang: pci configuration space read devfn = 00, vendor id = ffff
Liqiang: pci configuration space read devfn = 08, vendor id = ffff
Liqiang: pci configuration space read devfn = 10, vendor id = ffff
Liqiang: pci configuration space read devfn = 18, vendor id = ffff
Liqiang: pci configuration space read devfn = 20, vendor id = ffff
Liqiang: pci configuration space read devfn = 28, vendor id = ffff
Liqiang: pci configuration space read devfn = 30, vendor id = ffff
Liqiang: pci configuration space read devfn = 38, vendor id = ffff
Liqiang: pci configuration space read devfn = 40, vendor id = ffff
Liqiang: pci configuration space read devfn = 48, vendor id = ffff
Liqiang: pci configuration space read devfn = 50, vendor id = ffff
Liqiang: pci configuration space read devfn = 58, vendor id = ffff
Liqiang: pci configuration space read devfn = 60, vendor id = 16f4
00:0c.0 Class 0400: 16f4:8000
        Mem at 0x40000000 [size=0x20000]
        Mem at 0x40020000 [size=0x1000]
        Mem at 0x40021000 [size=0x1000]
Liqiang: pci configuration space read devfn = 68, vendor id = ffff
Liqiang: pci configuration space read devfn = 70, vendor id = ffff
Liqiang: pci configuration space read devfn = 78, vendor id = ffff
Liqiang: pci configuration space read devfn = 80, vendor id = ffff
Liqiang: pci configuration space read devfn = 88, vendor id = ffff
Liqiang: pci configuration space read devfn = 90, vendor id = ffff
mhd : AUTO SCAN FINISHED!!!!!!!!!!!!!!!!!!!!!!!!!
Scanning bus 00
Found 00:60 [16f4/8000] 000400 00
Fixups for bus 00
Bus scan for 00 returning with max=00
mhd : pin=0x1, slot=0xc
PCI fixup irq: (0000:00:0c.0) got 1
Au1XXX Real Time Clock Driver v1.0
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
JFFS2 version 2.2. (C) 2001-2003 Red Hat, Inc.
SGI XFS with no debug enabled
yaffs Jul 30 2008 15:35:27 Installing. 
Initializing Cryptographic API
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
i2c /dev entries driver
Au1550 I2C: <7>i2c_adapter i2c-0: Registered as minor 0
Au1550 I2C initialized.
Serial: Au1x00 driver
ttyS0 at I/O 0xb1100000 (irq = 0) is a AU1X00_UART
ttyS1 at I/O 0xb1200000 (irq = 8) is a AU1X00_UART
ttyS2 at I/O 0xb1400000 (irq = 9) is a AU1X00_UART
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize
loop: loaded (max 8 devices)
au1000eth version 1.5 Pete Popov <ppopov@embeddedalley.com>
eth0: Au1x Ethernet found at 0xb0500000, irq 27
mhd: get PHY ID = 0 8201 
eth0: REALTEK RTL8201CP 10/1000 BaseT PHY at phy address 1

 begin to init the network-mac0 and mac1
Mac0_MII_CONTROL_phy_addr: 00000001 
Mac0_MII_CONTROL_val_before_write: 00003100 
Mac0_MII_CONTROL_value_after_write: 00002100 
Mac0_10/100 and Half/Full duplex val_before wrtie: 000001e1 
Mac0_10/100 and Half/Full duplex val_after write: 000001e1 
Mac0_Restart auto-negotiatio val before  berfore write: 00002100 
Mac0_Restart auto-negotiatio val before write: 00002100 
Mac0_Restart auto-negotiation val_after write: 00002100 
eth0: Using REALTEK RTL8201CP 10/1000 BaseT PHY as default
eth1: Au1x Ethernet found at 0xb0510000, irq 28
mhd: get PHY ID = 0 8201 
eth1: REALTEK RTL8201CP 10/1000 BaseT PHY at phy address 2

 begin to init the network-mac0 and mac1
Mac0_MII_CONTROL_phy_addr: 00000002 
Mac0_MII_CONTROL_val_before_write: 00003000 
Mac0_MII_CONTROL_value_after_write: 00002000 
Mac0_10/100 and Half/Full duplex val_before wrtie: 000001e1 
Mac0_10/100 and Half/Full duplex val_after write: 000001e1 
Mac0_Restart auto-negotiatio val before  berfore write: 00002000 
Mac0_Restart auto-negotiatio val before write: 00002100 
Mac0_Restart auto-negotiation val_after write: 00002100 
eth1: Using REALTEK RTL8201CP 10/1000 BaseT PHY as default
INFTL: inftlcore.c $Revision: 1.18 $, inftlmount.c $Revision: 1.16 $
mhd MTD: probing 32-bit flash bus
Db1550 Flash: Found 2 x16 devices at 0x0 in 32-bit bank
 Amd/Fujitsu Extended Query Table at 0x0040
Db1550 Flash: CFI does not contain boot bank location. Assuming top.
number of CFI chips: 1
cfi_cmdset_0002: Disabling erase-suspend-program due to code brokenness.
Creating 5 MTD partitions on "Db1550 Flash":
0x00000000-0x00600000 : "Kernel"
0x00600000-0x01600000 : "Ramdisk"
0x01600000-0x01b00000 : "User Fs"
0x01b00000-0x01c00000 : "Fs Bak"
0x01c00000-0x02000000 : "YAMON Bootloader"
NAND device: Manufacturer ID: 0xec, Chip ID: 0xd3 (Samsung NAND 1GiB 3,3V 8-bit)
Scanning device for bad blocks
Bad eraseblock 0 at 0x00000000
Bad eraseblock 1 at 0x00020000
Bad eraseblock 2 at 0x00040000
Bad eraseblock 3 at 0x00060000
Bad eraseblock 4 at 0x00080000
Bad eraseblock 5 at 0x000a0000
Bad eraseblock 6 at 0x000c0000
Bad eraseblock 7 at 0x000e0000
........



	

　　　　　　　　致
礼！
 				

maowy
maowy@avit.org.cn
2008-08-07
*******************************************
maowy(毛伟勇)

上海精视信息技术有限责任公司
Shanghai Accurate Video Info_Tech Co.,Ltd.

地址:上海市徐汇区乐山路33号1号楼306室
ADD:Room 306,No.1 Building,No.33 Leshan Rd.,Shanghai
邮编:200030

电话:021-51556408/09转17分机
传真:021-51556407
Mail:maowy@avit.org.cn

网址:http://www.avit.org.cn
********************************************

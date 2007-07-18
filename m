Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Jul 2007 10:50:38 +0100 (BST)
Received: from ms-smtp-03.socal.rr.com ([66.75.162.135]:24488 "EHLO
	ms-smtp-03.socal.rr.com") by ftp.linux-mips.org with ESMTP
	id S20021563AbXGRJug (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 18 Jul 2007 10:50:36 +0100
Received: from h264dev.qualcomm.com (cpe-75-85-175-87.san.res.rr.com [75.85.175.87])
	by ms-smtp-03.socal.rr.com (8.13.6/8.13.6) with ESMTP id l6I9oFBZ006453
	for <linux-mips@linux-mips.org>; Wed, 18 Jul 2007 02:50:18 -0700 (PDT)
Message-Id: <5.1.0.14.2.20070718023126.0367b5f0@unixmail.qualcomm.com>
X-Sender: techtom@pop3.netzero.net
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date:	Wed, 18 Jul 2007 02:50:03 -0700
To:	linux-mips@linux-mips.org
From:	Scott S <techtom@netzero.net>
Subject: Help with BCM7038 Ethernet driver
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
X-Virus-Scanned: Symantec AntiVirus Scan Engine
Return-Path: <techtom@netzero.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15799
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: techtom@netzero.net
Precedence: bulk
X-list: linux-mips

Hello,
    I'm trying to get the ethernet interface to work on a broadcom 97398 
reference platform.  Thanks to the linux-mips site I have successfully 
built the cross compiler,built the linux-2.4.31-echostar kernel 
source,  and merged in the ethernet drivers from the tivo 8.3-linux-2.4 
source tree.

I verified with Ethereal, the ethernet driver can send packets, but the 
7038 acts as if interrupts are disabled.  I verified that interrupt 23 is 
enabled, but no interrupts occur.  The uart and the ide/sata interface work 
fine, so the MIPS int 2 is working fine.  I know there is nothing wrong 
with the ethernet interface because I use it to boot the kernel in CFE. 
(see boot below)

suggestions?

Thanks,

-Scott





CFE> boot -elf 192.168.10.24:new
Loader:elf Filesys:tftp Dev:eth0 File:192.168.10.24:new Options:(null)
Loading: 0x80001000/1941504 0x801db000/149072 Entry address is 0x80001794
total=  bytes
Closing network.
Starting program at 0x80001794
RUN!

CPU revision is: 0001810b
FPU revision is: 0003810b
Primary instruction cache 32kB, physically tagged, 2-way, linesize 32 bytes.
Primary data cache 32kB, 2-way, linesize 32 bytes.
$$$$$$$$$$7041 dev id ffffffff
$$$$$$$$$$3250 dev id ffffffff
$$$$$$$$$$external dev id ffffffff
$$$$$$$$$$SATA dev id 02421166
Linux version 2.4.31-echostar (@) () #0
Determined physical RAM map:
  memory: 03c00000 @ 00000000 (usable)
On node 0 totalpages: 15360
zone(0): 15360 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: root=/dev/hda1 rw
Enable the cache parity protection for MIPS 5KC CPUs.
mips_counter_frequency = 148000000 from Calibration, = 148500000 from 
header(CP)
Using 148.500 MHz high precision timer.
brcm timer int
Calibrating delay loop... 296.55 BogoMIPS
Memory: 58724k/61440k available (1527k kernel code, 2716k reserved, 100k 
data, )
Dentry cache hash table entries: 8192 (order: 4, 65536 bytes)
Inode cache hash table entries: 4096 (order: 3, 32768 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer cache hash table entries: 1024 (order: 0, 4096 bytes)
Page-cache hash table entries: 16384 (order: 4, 65536 bytes)
Checking for 'wait' instruction...  available.
POSIX conformance testing by UNIFIX
Autoconfig PCI channel 0x801dac40
Scanning bus 00, I/O 0x00000000:0x00600001, Mem 0xd0000000:0xd8000001
Autoconfig PCI channel 0x801dac54
Scanning bus 01, I/O 0x00000000:0x00010001, Mem 0xb0510000:0xb0520001
01:00.0 Class 0101: 1166:0242
         I/O at 0x00000000 [size=0x8]
         I/O at 0x00000008 [size=0x4]
         I/O at 0x00000010 [size=0x8]
         I/O at 0x00000018 [size=0x4]
         I/O at 0x00000020 [size=0x20]
         Mem at 0xb0510000 [size=0x2000]
$$$$$$$$$$$$$$$ dev=242, vendor=1166, did=2421166
Setting up SATA controller, VD Rev=00000520, pll_war=0, sata2_war=0, sata2_on=1
SATA: Primary Bus Master Status Register offset = b0520000 + 00000300 = 
b0520300
SATA: before init Primary Bus Master Status reg = 0x00000000.
SATA: after init Primary Bus Master Status reg = 0x00000020.
SATA: Secondary Bus Master Status Register offset = b0520000 + 00000300 = 
b05200
SATA: before init Secondary Bus Master Status reg = 0x00000000.
SATA: after init Secondary Bus Master Status reg = 0x00000060.
Turning on SIMR and SERR
SATA: SIMR = 0x6bfaffff.
SATA: SCR1 = 0x04050000.
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
Journalled Block Device driver loaded
pty: 256 Unix98 ptys configured
bcmemacenet: bcmemac_module_init
bcmemacenet: bcmemac_net_probe probed=0
Broadcom BCM7038E4 Ethernet Network Device
Broadcom BCM7038E4 Ethernet Network Device v1.0TGC Jul 18 2007 01:51:50
bcmemacenet: bcmemac_init_dev DMA_BASE=b0082400, RX=0, TX=1
bcmemacenet: bcmemac_init_dev &rxDMA=b0082500, &txDma=b0082580
bcmemacenet: init_buffers
bcmemacenet: init_dma
init_dma: txDMA.startAddr=10082200, virt=b0082200
init_dma: rxDMA.startAddr=10082000, virt=b0082000
bcmemacenet: init_emac
-->clear_mib
<-- clear_mib
mii_AutoConfigure
mii_GetConfig
BCMINTMAC: 100 MB Full-Duplex (auto-neg)
enabling irq 23
request_irq returned 0
bcmemacenet: bcmemac_net_probe dev 0x810f4400
eth0: MAC Address: 00:10:18:C0:53:0A
Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Broadcom BCM7038 SATA IDE: IDE controller at PCI slot 01:00.0
Broadcom BCM7038 SATA IDE: chipset revision 0
Broadcom BCM7038 SATA IDE: 100% native mode on irq 40
g|s_dma_base: hwif->mmio = 0, dma_base=0
No dma_base on hw->mate
setting dma_base for 242=300
     ide0: BM-DMA at 0x0300-0x0307, BIOS settings: hda:DMA, hdb:pio
g|s_dma_base: hwif->mmio = 0, dma_base=0
hwif->mate->dma_base = 300
setting dma_base for 242=308
     ide1: BM-DMA at 0x0308-0x030f, BIOS settings: hdc:DMA, hdd:DMA
hda: WDC WD1200JS-00MHB0, ATA DISK drive
blk: queue 801fb560, I/O limit 4095Mb (mask 0xffffffff)
enabling irq 40
ide0 at 0x200-0x207,0x242 on irq 40
hda: attached ide-disk driver.
hda: host protected area => 1
hda: 234441648 sectors (120034 MB) w/8192KiB Cache, CHS=14593/255/63
Partition check:
  hda: hda1 hda2 hda3 hda4
SCSI subsystem driver Revision: 1.00
kmod: failed to exec /sbin/modprobe -s -k scsi_hostadapter, errno = 2
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
ehci_hcd EHCI-Direct: BRCM-EHCI
enabling irq 60
ehci_hcd EHCI-Direct: irq 60, pci mem b04c0300
usb.c: new USB bus registered, assigned bus number 1
ehci_hcd EHCI-Direct: USB 0.0 enabled, EHCI 1.00, driver 2003-Dec-29/2.4
hub.c: USB hub found
hub.c: 2 ports detected
host/../host/brcmusb.h: Modified for BRCM USB Host Controller
usb.c: registered new driver serial
usbserial.c: USB Serial support registered for Generic
usbserial.c: USB Serial Driver core v1.4
Initializing USB Mass Storage driver...
usb.c: registered new driver usb-storage
USB Mass Storage support registered.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 4096 bind 8192)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Broadcom serial driver version 1.00 (2000-11-09) with SERIAL_PCI enabled
ttyS00 at 0x0000 (irq = 63) is a <NULL>
ttyS01 at 0x0000 (irq = 64) is a <NULL>
kjournald starting.  Commit interval 5 seconds
EXT3-fs warning: maximal mount count reached, running e2fsck is recommended
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,1), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem).
Freeing unused kernel memory: 248k freed
Mount /proc fs
Mount /dev/pts
kjournald starting.  Commit interval 5 seconds
EXT3-fs warning: maximal mount count reached, running e2fsck is recommended
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,3), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
ext3: No journal on filesystem on ide0(3,4)
EXT2-fs warning: mounting unchecked fs, running e2fsck is recommended
Cleaning up utmp and wtmp
Start syslog daemon
Configure Network interface
dhcpcd -Hd eth0
start services
eth0: bcmemac_net_open, EMACConf=0, &RxDMA=810c78b8, rxDma.cfg=1
enable_irq(23) unbalanced from 800a9aec
eth0 Link UP.
eth0: bcm_set_multicast_list: 00000023
eth0: bcm_set_multicast_list: 00000023
bcmemac_net_xmit, txCfg=00000000, txIntStat=00000000
bcmemac_net_xmit, txCfg=00000000, txIntStat=00000007
bcmemac_net_xmit, txCfg=00000000, txIntStat=00000007
bcmemac_net_xmit, txCfg=00000000, txIntStat=00000007
bcmemac_net_xmit, txCfg=00000000, txIntStat=00000007
bcmemac_net_xmit, txCfg=00000000, txIntStat=00000007
bcmemac_net_xmit, txCfg=00000000, txIntStat=00000007
bcmemac_net_xmit, txCfg=00000000, txIntStat=00000007
bcmemac_net_xmit, txCfg=00000000, txIntStat=00000007
bcmemac_net_xmit, txCfg=00000000, txIntStat=00000007
bcmemac_net_xmit, txCfg=00000000, txIntStat=00000007
eth0: bcm_set_multicast_list: 00000023
eth0: bcm_set_multicast_list: 00000003
eth0: bcmemac_net_close

bcm97938 login: root
#
# ifconfig eth0
eth0      Link encap:Ethernet  HWaddr 00:10:18:C0:53:0A
           BROADCAST  MTU:1500  Metric:1
           RX packets:0 errors:0 dropped:0 overruns:0 frame:0
           TX packets:11 errors:0 dropped:0 overruns:0 carrier:0
           collisions:0 txqueuelen:1000
           Interrupt:23

#

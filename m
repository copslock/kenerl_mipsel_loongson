Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Jul 2008 05:08:16 +0100 (BST)
Received: from kuber.nabble.com ([216.139.236.158]:7620 "EHLO kuber.nabble.com")
	by ftp.linux-mips.org with ESMTP id S20031390AbYGPEIO (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 16 Jul 2008 05:08:14 +0100
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <lists@nabble.com>)
	id 1KIyJI-0006HM-1Q
	for linux-mips@linux-mips.org; Tue, 15 Jul 2008 21:08:12 -0700
Message-ID: <18470529.post@talk.nabble.com>
Date:	Tue, 15 Jul 2008 21:08:12 -0700 (PDT)
From:	saran1484 <saravanakumar.s@teclever.com>
To:	linux-mips@linux-mips.org
Subject: Re: Alchemy DB1200
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Nabble-From: saravanakumar.s@teclever.com
Return-Path: <lists@nabble.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19839
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: saravanakumar.s@teclever.com
Precedence: bulk
X-list: linux-mips



abhiruchi.g wrote:
> 
> I am trying to build kernel for DB1200 board.
> but kernel hangs after the following output:
> 
> Image Loaded Successfully.
> ---------------------------------------------
> Program Entry Point: 80536000
> Executing Application
> Linux version 2.6.22 (abhi@linux-3s9p) (gcc version 4.2.1) #75 PREEMPT Mon
> Apr 8
> CPU revision is: 04030201
> AMD Alchemy Db1200 Board
> (PRId 04030201) @ 396MHZ
> Determined physical RAM map:
> memory: 08000000 @ 00000000 (usable)
> User-defined physical RAM map:
> memory: 08000000 @ 00000000 (usable)
> Initrd not found or empty - disabling initrd
> Built 1 zonelists.  Total pages: 32512
> Kernel command line: rootdelay=10 rootfstype=ext2 mem=128M root=/dev/sda1  
> vid0
> Primary instruction cache 16kB, physically tagged, 4-way, linesize 32
> bytes.
> Primary data cache 16kB, 4-way, linesize 32 bytes.
> Synthesized TLB refill handler (17 instructions).
> Synthesized TLB load handler fastpath (34 instructions).
> Synthesized TLB store handler fastpath (34 instructions).
> Synthesized TLB modify handler fastpath (33 instructions).
> PID hash table entries: 512 (order: 9, 2048 bytes)
> calculating r4koff... 00060ae0(396000)
> CPU frequency 396.00 MHz
> Console: colour dummy device 80x25
> Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
> Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
> Memory: 124032k/131072k available (3069k kernel code, 6904k reserved,
> 1238k dat)
> Mount-cache hash table entries: 512
> NET: Registered protocol family 16
> SCSI subsystem initialized
> usbcore: registered new interface driver usbfs
> usbcore: registered new interface driver hub
> usbcore: registered new device driver usb
> Bluetooth: Core ver 2.11
> NET: Registered protocol family 31
> Bluetooth: HCI device and connection manager initialized
> Bluetooth: HCI socket layer initialized
> Time: MIPS clocksource has been installed.
> NET: Registered protocol family 2
> IP route cache hash table entries: 1024 (order: 0, 4096 bytes)
> TCP established hash table entries: 4096 (order: 3, 32768 bytes)
> TCP bind hash table entries: 4096 (order: 2, 16384 bytes)
> TCP: Hash tables configured (established 4096 bind 4096)
> TCP reno registered
> JFS: nTxBlock = 970, nTxLock = 7760
> io scheduler noop registered
> io scheduler anticipatory registered
> io scheduler deadline registered
> io scheduler cfq registered (default)
> au1200fb: LCD controller driver for AU1200 processors
> au1200fb: Panel 0 QVGA_320x240
> au1200fb: Win 2 0-FS gfx, 1-video, 2-ovly gfx, 3-ovly gfx
> Panel(QVGA_320x240), 320x240
> 
> 
> 
> 
> Console: switching to colour frame buffer device 40x30
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
> serial8250.9: ttyS0 at MMIO 0x11100000 (irq = 0) is a 16550A
> serial8250.9: ttyS1 at MMIO 0x11200000 (irq = 8) is a 16550A
> RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
> loop: module loaded
> nbd: registered device at major 43
> Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
> ide: Assuming 50MHz system bus speed for PIO modes; override with
> idebus=xx
> Au1xxx IDE(builtin) configured for PIO+DDMA(offload)
> au1xxx-ehci au1xxx-ehci.0: Au1xxx EHCI
> au1xxx-ehci au1xxx-ehci.0: new USB bus registered, assigned bus number 1
> au1xxx-ehci au1xxx-ehci.0: irq 29, io mem 0x14020200
> au1xxx-ehci au1xxx-ehci.0: USB 0.0 started, EHCI 1.00, driver 10 Dec 2004
> usb usb1: configuration #1 chosen from 1 choice
> hub 1-0:1.0: USB hub found
> hub 1-0:1.0: 2 ports detected
> au1xxx-ohci au1xxx-ohci.0: Au1xxx OHCI
> au1xxx-ohci au1xxx-ohci.0: new USB bus registered, assigned bus number 2
> au1xxx-ohci au1xxx-ohci.0: irq 29, io mem 0x14020100
> usb usb2: configuration #1 chosen from 1 choice
> hub 2-0:1.0: USB hub found
> hub 2-0:1.0: 2 ports detected
> usb 1-1: new high speed USB device using au1xxx-ehci and address 2
> Initializing USB Mass Storage driver...
> usb 1-1: configuration #1 chosen from 1 choice
> hub 1-1:1.0: USB hub found
> hub 1-1:1.0: 4 ports detected
> usb 1-1.2: new high speed USB device using au1xxx-ehci and address 3
> usb 1-1.2: configuration #1 chosen from 1 choice
> scsi0 : SCSI emulation for USB Mass Storage devices
> usbcore: registered new interface driver usb-storage
> USB Mass Storage support registered.
> mice: PS/2 mouse device common for all mice
> 
> After this i cant get the following message i want to know whether i need
> to change the kernel configuration
> Bluetooth: HCI USB driver ver 2.9
> usbcore: registered new interface driver hci_usb
> usbcore: registered new interface driver hiddev
> usbcore: registered new interface driver usbhid
> drivers/hid/usbhid/hid-core.c: v2.6:USB HID core driver
> TCP cubic registered
> NET: Registered protocol family 17
> Bluetooth: L2CAP ver 2.8
> Bluetooth: L2CAP socket layer initialized
> Bluetooth: SCO (Voice Link) ver 0.5
> Bluetooth: SCO socket layer initialized
> Bluetooth: HIDP (Human Interface Emulation) ver 1.2
> ieee80211: 802.11 data/management/control stack, git-1.1.13
> ieee80211: Copyright (C) 2004-2005 Intel Corporation
> <jketreno@linux.intel.com>
> drivers/rtc/hctosys.c: unable to open rtc device (rtc0)
> Waiting 10sec before mounting root device...
> 
>  i want my kernle to wait 
> 
> scsi 0:0:0:0: Direct-Access     Ut163    USB2FlashStorage 0.00 PQ: 0 ANSI:
> 2
> sd 0:0:0:0: [sda] 983808 512-byte hardware sectors (504 MB)
> sd 0:0:0:0: [sda] Write Protect is off
> sd 0:0:0:0: [sda] Assuming drive cache: write through
> sd 0:0:0:0: [sda] 983808 512-byte hardware sectors (504 MB)
> sd 0:0:0:0: [sda] Write Protect is off
> sd 0:0:0:0: [sda] Assuming drive cache: write through
> sda:<7>usb-storage: queuecommand called
> sda1
> sd 0:0:0:0: [sda] Attached SCSI removable disk
> sd 0:0:0:0: Attached scsi generic sg0 type 0
> VFS: Mounted root (ext2 filesystem) readonly.
> mount_block_root: name=/dev/root fs=ext2 flags=32769
> Freeing unused kernel memory: 164k freed
> Warning: unable to open an initial console.
> Algorithmics/MIPS FPU Emulator v1.5
> 
> 
> 
> 
> what could be the problem?
> Is this creating any problem?
> sda:<7>usb-storage: queuecommand called
> 
> 
> 
> 
> 
> 

-- 
View this message in context: http://www.nabble.com/Alchemy-DB1200-tp17121656p18470529.html
Sent from the linux-mips main mailing list archive at Nabble.com.

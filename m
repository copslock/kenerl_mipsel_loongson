Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Jan 2010 15:55:33 +0100 (CET)
Received: from bby1mta02.pmc-sierra.com ([216.241.235.117]:39840 "EHLO
        bby1mta02.pmc-sierra.bc.ca" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492569Ab0ASOz1 convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 19 Jan 2010 15:55:27 +0100
Received: from bby1mta02.pmc-sierra.bc.ca (localhost.pmc-sierra.bc.ca [127.0.0.1])
        by localhost (Postfix) with SMTP id 365738E0051;
        Tue, 19 Jan 2010 06:55:14 -0800 (PST)
Received: from bby1exg02.pmc_nt.nt.pmc-sierra.bc.ca (BBY1EXG02.pmc-sierra.bc.ca [216.241.231.167])
        by bby1mta02.pmc-sierra.bc.ca (Postfix) with SMTP id 1C8848E004F;
        Tue, 19 Jan 2010 06:55:14 -0800 (PST)
Received: from BBY1EXM11.pmc_nt.nt.pmc-sierra.bc.ca ([216.241.231.159]) by bby1exg02.pmc_nt.nt.pmc-sierra.bc.ca with Microsoft SMTPSVC(6.0.3790.3959);
         Tue, 19 Jan 2010 06:55:32 -0800
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
        charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: RE: Help in enabling HIGHMEM support  / 64 bit support 
Date:   Tue, 19 Jan 2010 06:55:12 -0800
Message-ID: <A7DEA48C84FD0B48AAAE33F328C020140474AF40@BBY1EXM11.pmc_nt.nt.pmc-sierra.bc.ca>
In-Reply-To: <A7DEA48C84FD0B48AAAE33F328C020140474ADC8@BBY1EXM11.pmc_nt.nt.pmc-sierra.bc.ca>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Help in enabling HIGHMEM support  / 64 bit support 
Thread-Index: Acp848y7wxTUpEk6QWCQk4x5wrla0wbbQfEgADDtgLA=
References: <Pine.LNX.4.64.0912131240100.24267@ask.diku.dk> <A7DEA48C84FD0B48AAAE33F328C020140457EE41@BBY1EXM11.pmc_nt.nt.pmc-sierra.bc.ca> <20091214173509.GB15067@linux-mips.org> <A7DEA48C84FD0B48AAAE33F328C020140474ADC8@BBY1EXM11.pmc_nt.nt.pmc-sierra.bc.ca>
From:   "Anoop P.A." <Anoop_P.A@pmc-sierra.com>
To:     "Ralf Baechle" <ralf@linux-mips.org>
Cc:     <linux-mips@linux-mips.org>
X-OriginalArrivalTime: 19 Jan 2010 14:55:32.0966 (UTC) FILETIME=[73357060:01CA9917]
X-archive-position: 25611
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Anoop_P.A@pmc-sierra.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 12563

OK I have made a bit of progress with 64 bit kernel. I have added a
small hack in uart driver and I am getting prints from 64 bit kernel.

When I fix mem=512M from command line my kernel boots all the way.

#################################Log
Starts#################################
 PMON> g mem=512Mehci_shutdown: stopping the HC
ohci_shutdown: stopping the HC
ohci_shutdown: stopping the HC
Halting rme1
Halting rme0
<5>Linux version 2.6.18 (paanoop1@blr-sw65.pmc-sierra.bc.ca) (gcc
version 3.4.5) #61 Tue Jan 19 19:45:51 IST 2010
<4>MIPS 64-bit support for PMC-Sierra Sequoia
<4>memory size 1024MB
<4>cpu_clock set to 600000000
<4>CPU revision is: 000034c1
<4>FPU revision is: 00003420
<4>PMC-Sierra PM74100 Board Setup
<4>64-bit support 90000000FF080508
<4>Determined physical RAM map:
<4> memory: 0000000040000000 @ 0000000000000000 (usable)
<4>User-defined physical RAM map:
<4> memory: 0000000020000000 @ 0000000000000000 (usable)
<7>On node 0 totalpages: 131072
<7>  DMA zone: 131072 pages, LIFO batch:31
<4>Built 1 zonelists.  Total pages: 131072
<5>Kernel command line: mem=512M
<4>Primary instruction cache 16kB, physically tagged, 4-way, linesize 32
bytes.
<4>Primary data cache 16kB, 4-way, linesize 32 bytes.
<6>Secondary cache size 256K, linesize 32 bytes.
<6>Synthesized TLB refill handler (39 instructions).
<6>Synthesized TLB load handler fastpath (51 instructions).
<6>Synthesized TLB store handler fastpath (51 instructions).
<6>Synthesized TLB modify handler fastpath (50 instructions).
<4>PID hash table entries: 4096 (order: 12, 32768 bytes)
<4>Using 300.000 MHz high precision timer.
<4>Dentry cache hash table entries: 65536 (order: 7, 524288 bytes)
<4>Inode-cache hash table entries: 32768 (order: 6, 262144 bytes)
<6>Memory: 508928k/524288k available (3860k kernel code, 15032k
reserved, 1724k data, 224k init, 0k highmem)
<6>Debug prints
<4> <6>TITAN_GE_BASE=FF080000 TITAN_GE_SIZE=10000
<4>RM9150_LOCALBUS_DCR=FF070000 RM9150_LOCALBUS_SIZE=10000
<4> <6>
<4>BOOT_FLASH_BASE=FC000000 BOOT_FLASH_SIZE=800000
<4>RTC_BASE=FC200000,
<4>FPGA_BASE=FC210000 FPGA_SIZE=10000
<6>titan_ge_base=90000000FF080000
<4>rm9150_pci0_base=90000000FF000000
<4>rm9150_pci1_base=90000000FF010000
<4>rm9150_dma_base=90000000FF040000
<4>rm9150_localbus_base=90000000FF070000
<4>sequoia_fpga_base=90000000FC210000
<4> <6>Internal UART Support for PMC-Sierra Sequoia
<4>You are using the Dallas DS1501 RTC.
<4>UDI: initializing
<7>Calibrating delay loop... 598.01 BogoMIPS (lpj=1196032)
<4>Mount-cache hash table entries: 256
<4>Checking for 'wait' instruction...  available.
<4>Checking for the multiply/shift bug... no.
<4>Checking for the daddi bug... no.
<4>Checking for the daddiu bug... no.
<7>Registering sysdev class '<NULL>'
<6>NET: Registered protocol family 16
<5>SCSI subsystem initialized
<6>usbcore: registered new driver usbfs
<6>usbcore: registered new driver hub
<3>PCI: Failed to allocate mem resource #2:20000000@e0000000 for
0000:00:01.0
<3>PCI: Failed to allocate mem resource #2:20000000@100000000 for
0000:01:01.0
<6>NET: Registered protocol family 2
<4>IP route cache hash table entries: 16384 (order: 5, 131072 bytes)
<4>TCP established hash table entries: 65536 (order: 7, 524288 bytes)
<4>TCP bind hash table entries: 32768 (order: 6, 262144 bytes)
<6>TCP: Hash tables configured (established 65536 bind 32768)
<6>TCP reno registered
<7>Registering sysdev class '<NULL>'
<7>Registering sys device 'timekeeping0'
<7>Registering sysdev class '<NULL>'
<7>Registering sys device 'clocksource0'
<5>VFS: Disk quotas dquot_6.5.1
<4>Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
<6>squashfs: version 3.1 (2006/08/19) Phillip Lougher
<6>Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
<6>NTFS driver 2.1.27 [Flags: R/O].
<6>JFFS2 version 2.2. (NAND) (C) 2001-2006 Red Hat, Inc.
<6>SGI XFS with ACLs, large block/inode numbers, no debug enabled
<6>SGI XFS Quota Management subsystem
<6>Initializing Cryptographic API
<6>io scheduler noop registered
<6>io scheduler anticipatory registered
<6>io scheduler deadline registered
<6>io scheduler cfq registered (default)
<6>Generic RTC Driver v1.07
<6>Serial: 8250/16550 driver $Revision: 1.6 $ 4 ports, IRQ sharing
disabled
<6>serial8250: ttyS0 at MMIO 0x90000000ff080000 (irq = 0) is a 16550A
<6>serial8250: ttyS1 at MMIO 0x90000000ff080030 (irq = 0) is a 16550A
<6>loop: loaded (max 8 devices)
<5>PMC-Sierra MSP85x0 10/100/1000 Ethernet Driver
<5>Device Id : 206014, Version : 0
<6>MSP85x0 GE Driver version 1.4
<4>PHY OUI: 32 Model: 11 Rev: 2
<5>Rx NAPI supported, Tx Coalescing ON
<5>eth0: port 0 with MAC address 00:e0:04:00:05:04
<4>PHY OUI: 32 Model: 11 Rev: 2
<5>Rx NAPI supported, Tx Coalescing ON
<5>eth1: port 1 with MAC address 00:e0:04:00:05:05
<6>ehci_hcd 0000:01:02.2: EHCI Host Controller
<6>ehci_hcd 0000:01:02.2: new USB bus registered, assigned bus number 1
<6>ehci_hcd 0000:01:02.2: irq 13, io mem 0xe8802000
<6>ehci_hcd 0000:01:02.2: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
<6>usb usb1: configuration #1 chosen from 1 choice
<6>hub 1-0:1.0: USB hub found
<6>hub 1-0:1.0: 5 ports detected
<7>ohci_hcd: 2005 April 22 USB 1.1 'Open' Host Controller (OHCI) Driver
(PCI)
<6>ohci_hcd 0000:01:02.0: OHCI Host Controller
<6>ohci_hcd 0000:01:02.0: new USB bus registered, assigned bus number 2
<6>ohci_hcd 0000:01:02.0: irq 13, io mem 0xe8800000
<6>usb usb2: configuration #1 chosen from 1 choice
<6>hub 2-0:1.0: USB hub found
<6>hub 2-0:1.0: 3 ports detected
<6>ohci_hcd 0000:01:02.1: OHCI Host Controller
<6>ohci_hcd 0000:01:02.1: new USB bus registered, assigned bus number 3
<6>ohci_hcd 0000:01:02.1: irq 13, io mem 0xe8801000
<6>usb 1-1: new high speed USB device using ehci_hcd and address 2
<6>usb usb3: configuration #1 chosen from 1 choice
<6>hub 3-0:1.0: USB hub found
<6>hub 3-0:1.0: 2 ports detected
<6>usb 1-1: configuration #1 chosen from 1 choice
<6>Initializing USB Mass Storage driver...
<6>usb 1-2: new high speed USB device using ehci_hcd and address 3
<6>usb 1-2: configuration #1 chosen from 1 choice
<6>scsi0 : SCSI emulation for USB Mass Storage devices
<7>usb-storage: device found at 2
<7>usb-storage: waiting for device to settle before scanning
<5>  Vendor: USBest    Model: USB2FlashStorage  Rev: 0.00
<5>  Type:   Direct-Access                      ANSI SCSI revision: 02
<5>scsiglue: Trying to match USB boot device params:
<5>  Parent device number: [1]
<5>  Parent device port: [0]
<5>  Device bus number: [1]
<5>  Device state: [7]
<5>  Device speed: [3]
<5>scsiglue: Got USB boot device match!
<5>  Device name:
<5>  Device manufacturer:
<5>  Device serial:
<5>  Device bus: 1
<5>  Device bus name: [0000:01:02.2]
<5>sd: Hooray! Discovered SCSI boot device!
<5>  host_no [0], channel [0], id [0], lun [0]
<5>sd 0:0:0:0: Attached scsi removable disk scsibd
<5>sd 0:0:0:0: Attached scsi generic sg0 type 0
<7>usb-storage: device scan complete
<6>scsi1 : SCSI emulation for USB Mass Storage devices
<7>usb-storage: device found at 3
<7>usb-storage: waiting for device to settle before scanning
<5>  Vendor: Generic   Model: USB Flash Disk    Rev: 0.00
<5>  Type:   Direct-Access                      ANSI SCSI revision: 02
<5>scsiglue: Already have USB boot device, doing nothing.
<5>SCSI device sdb: 7897040 512-byte hdwr sectors (4043 MB)
<5>sdb: Write Protect is off
<7>sdb: Mode Sense: 00 00 00 00
<3>sdb: assuming drive cache: write through
<5>SCSI device sdb: 7897040 512-byte hdwr sectors (4043 MB)
<5>sdb: Write Protect is off
<7>sdb: Mode Sense: 00 00 00 00
<3>sdb: assuming drive cache: write through
<6> sdb: sdb1 sdb2 sdb3 sdb4
<5>sd 1:0:0:0: Attached scsi removable disk sdb
<5>sd 1:0:0:0: Attached scsi generic sg1 type 0
<7>usb-storage: device scan complete
<6>usbcore: registered new driver usb-storage
<6>USB Mass Storage support registered.
<6>usbcore: registered new driver hiddev
<6>usbcore: registered new driver usbhid
<6>drivers/usb/input/hid-core.c: v2.6:USB HID core driver
<6>DS15x1 NVRAM driver v1.0
<6>i2c /dev entries driver
<6>md: linear personality registered for level -1
<6>md: raid0 personality registered for level 0
<6>md: raid1 personality registered for level 1
<6>md: raid10 personality registered for level 10
<4>raid6: int64x1    243 MB/s
<4>raid6: int64x2    289 MB/s
<4>raid6: int64x4    408 MB/s
<4>raid6: int64x8    293 MB/s
<4>raid6: using algorithm int64x4 (408 MB/s)
<6>md: raid6 personality registered for level 6
<6>md: raid5 personality registered for level 5
<6>md: raid4 personality registered for level 4
<6>raid5: measuring checksumming speed
<4>   8regs     :   882.000 MB/sec
<4>   8regs_prefetch:   842.000 MB/sec
<4>   32regs    :  1471.000 MB/sec
<4>   32regs_prefetch:  1362.000 MB/sec
<4>raid5: using function: 32regs (1471.000 MB/sec)
<6>md: md driver 0.90.3 MAX_MD_DEVS=256, MD_SB_DISKS=27
<6>md: bitmap version 4.39
<6>device-mapper: ioctl: 4.7.0-ioctl (2006-06-24) initialised:
dm-devel@redhat.com
<4>ip_tables: (C) 2000-2006 Netfilter Core Team
<6>TCP bic registered
<6>NET: Registered protocol family 1
<6>NET: Registered protocol family 17
<6>802.1Q VLAN Support v1.8 Ben Greear <greearb@candelatech.com>
<6>All bugs added by David S. Miller <davem@redhat.com>
<4>drivers/rtc/hctosys.c: unable to open rtc device (rtc0)
<6>md: Skipping autodetection of RAID arrays.
<6>md: md0 stopped.
<3>Root-NFS: No NFS server available, giving up.
#################################Log
Ends###################################




How ever when I don't limit memory ( ie system will use whole detected
memory ie 1024 MB) I am getting data bus error 

#################################Log
Starts#################################
5>Linux version 2.6.18 (paanoop1@blr-sw65.pmc-sierra.bc.ca) (gcc version
3.4.5) #61 Tue Jan 19 19:45:51 IST 2010
<4>MIPS 64-bit support for PMC-Sierra Sequoia
<4>memory size 1024MB
<4>cpu_clock set to 600000000
<4>CPU revision is: 000034c1
<4>FPU revision is: 00003420
<4>PMC-Sierra PM74100 Board Setup
<4>64-bit support 90000000FF080508
<4>Determined physical RAM map:
<4> memory: 0000000040000000 @ 0000000000000000 (usable)
<7>On node 0 totalpages: 262144
<7>  DMA zone: 262144 pages, LIFO batch:31
<4>Built 1 zonelists.  Total pages: 262144
<5>Kernel command line:
<4>Primary instruction cache 16kB, physically tagged, 4-way, linesize 32
bytes.
<4>Primary data cache 16kB, 4-way, linesize 32 bytes.
<6>Secondary cache size 256K, linesize 32 bytes.
<6>Synthesized TLB refill handler (39 instructions).
<6>Synthesized TLB load handler fastpath (51 instructions).
<6>Synthesized TLB store handler fastpath (51 instructions).
<6>Synthesized TLB modify handler fastpath (50 instructions).
<4>PID hash table entries: 4096 (order: 12, 32768 bytes)
<4>Using 300.000 MHz high precision timer.
<4>Dentry cache hash table entries: 131072 (order: 8, 1048576 bytes)
<4>Inode-cache hash table entries: 65536 (order: 7, 524288 bytes)
<6>Memory: 1025280k/1048576k available (3860k kernel code, 22976k
reserved, 1724k data, 224k init, 0k highmem)
<4> <6>TITAN_GE_BASE=FF080000 TITAN_GE_SIZE=10000
<4>RM9150_LOCALBUS_DCR=FF070000 RM9150_LOCALBUS_SIZE=10000
<4> <6>Debug prints
<4>BOOT_FLASH_BASE=FC000000 BOOT_FLASH_SIZE=800000
<4>RTC_BASE=FC200000,
<4>FPGA_BASE=FC210000 FPGA_SIZE=10000
<6>titan_ge_base=90000000FF080000
<4>rm9150_pci0_base=90000000FF000000
<4>rm9150_pci1_base=90000000FF010000
<4>rm9150_dma_base=90000000FF040000
<4>rm9150_localbus_base=90000000FF070000
<4>sequoia_fpga_base=90000000FC210000
<4> <6>Internal UART Support for PMC-Sierra Sequoia
<4>You are using the Dallas DS1501 RTC.
<4>UDI: initializing
<7>Calibrating delay loop... 598.01 BogoMIPS (lpj=1196032)
<4>Mount-cache hash table entries: 256
<4>Checking for 'wait' instruction...  available.
<4>Checking for the multiply/shift bug... no.
<4>Checking for the daddi bug... no.
<4>Checking for the daddiu bug... no.
<7>Registering sysdev class '<NULL>'
<6>NET: Registered protocol family 16
<5>SCSI subsystem initialized
<6>usbcore: registered new driver usbfs
<6>usbcore: registered new driver hub
<3>PCI: Failed to allocate mem resource #2:20000000@e0000000 for
0000:00:01.0
<3>PCI: Failed to allocate mem resource #2:20000000@100000000 for
0000:01:01.0
<6>NET: Registered protocol family 2
<4>IP route cache hash table entries: 32768 (order: 6, 262144 bytes)
<1>Data bus error, epc == ffffffff80354940, ra == ffffffff8069dd50
<4>Oops[#1]:
<4>Cpu 0
<4>$ 0   : 0000000000000000 ffffffff806d0000 980000003fc00000
0000000000000000
<4>$ 4   : 980000003fc00040 0000000000000000 0000000000040000
000000000000000a
<4>$ 8   : fffffffffffffff6 0000000000000005 ffffffffffffffff
ffffffff806b1d4a
<4>$12   : 0000000000000000 980000003fc40000 ffffffff806b2110
0000000000000000
<4>$16   : ffffffff80604060 ffffffff80604060 0000000000000000
0000000000000000
<4>$20   : 0000000000000000 0000000000000000 0000000000000000
0000000000000000
<4>$24   : 0000000000000000 ffffffff804d9d30
<4>$28   : 9800000001fc4000 9800000001fc7f30 0000000000000000
ffffffff8069dd50
<4>Hi    : 0000000000000002
<4>Lo    : 0000000000000000
<4>epc   : ffffffff80354940 __bzero+0x3c/0x60     Not tainted
<4>ra    : ffffffff8069dd50 ip_rt_init+0x1d4/0x538
<4>Status: 940080e3    KX SX UX KERNEL EXL IE
<4>Cause : 0000001c
<4>PrId  : 000034c1
<4>Modules linked in:
<4>Process swapper (pid: 1, threadinfo=9800000001fc4000,
task=9800000001fc1848)
<4>Stack : ffffffff8069e2b0 ffffffff80604060 ffffffff8069ef90
ffffffff8069ef88
<4>        ffffffff806a9200 0000000000000000 ffffffff801005fc
ffffffff801005fc
<4>        0000000000000000 0000000000000000 0000000000000000
0000000000000000
<4>        9800000001fc4000 9800000001fc7fe0 0000000000000001
0000000000000000
<4>        0000000000000000 0000000000000000 0000000000000000
ffffffff80104c40
<4>        0000000000000000 ffffffff80104c30 ffffffffffffffff
ffffffffffffffff
<4>        ffffffffffffffff ffffffffffffffff
<4>Call Trace:
<4>[<ffffffff80354940>] __bzero+0x3c/0x60
<4>[<ffffffff8069dd50>] ip_rt_init+0x1d4/0x538
<4>[<ffffffff8069e2b0>] ip_init+0x10/0x1c
<4>[<ffffffff8069ef90>] inet_init+0x218/0x7e8
<4>[<ffffffff801005fc>] init+0x128/0x4ec
<4>[<ffffffff80104c40>] kernel_thread_helper+0x10/0x18
<4>
<4>
<4>Code: 01a4682d  64840040  fc85ffc0 <fc85ffc8> fc85ffd0  fc85ffd8
fc85ffe0  fc85ffe8  fc85fff0
<0>Kernel panic - not syncing: Attempted to kill init!
#################################Log
Ends###################################

I have tried booting with different mem values above 512 MB and most of
the times got data bus error with different stack trace. So I assume
error lies in some address translation code.

It will be great if any of you can give some pointers to debug this.

Thanks
Anoop

-----Original Message-----
From: linux-mips-bounce@linux-mips.org
[mailto:linux-mips-bounce@linux-mips.org] On Behalf Of Anoop P.A.
Sent: Monday, January 18, 2010 9:27 PM
To: Ralf Baechle
Cc: linux-mips@linux-mips.org
Subject: RE: Help in enabling HIGHMEM support / 64 bit support 

List 

I am working on enabling Highmem support and 64 Bit support

1. 64 Bit support

As Ralf suggested I have tried enabling 64 bit support. I have reached
up to a point where I can boot the kernel with 512MB memory (logs
attached). How ever if I increase mem above > 512 I am not even getting
single print from kernel. 
I am blocked at this point. I will appreciate if any body can point me
to a most likely issue that I am hitting. BTW I am running kernel 2.6.18

2. Highmem 

I have tried enabling highmem. And I could boot till mounting root file
system. I have tried mounting RFS from a usb disk as well as NFS mount.
Both the cases fails (attaching logs). 

Let me know if you guys need any further info for giving me some
pointers

Regards
Anoop

-----Original Message-----
From: Ralf Baechle [mailto:ralf@linux-mips.org] 
Sent: Monday, December 14, 2009 11:05 PM
To: Anoop P.A.
Cc: linux-mips@linux-mips.org
Subject: Re: Help in enabling HIGHMEM support

On Mon, Dec 14, 2009 at 05:34:13AM -0800, Anoop P.A. wrote:

> We have a requirement to use a bigger RAM (1 GB / 2GB) with a RM9000
> based SOC. I thought of going with HIGHMEM path rather than enabling
> 64bit support thinking it will be easier.

This sounds like sawing off 32 legs just to be able to make use of a
free [1] wheelchair.

> I have tried enabling HIGMEM in kernel. Board boots fine with a 512 MB
> RAM plugged in. But if I connect a 1 GB RAM kernel will not boot. I am
> not even getting single print from kernel. I am using linux-2.6.18
> kernel.
> 
> It will be great if get any pointers suggestions in debugging this?

With this amount of RAM, use a 64-bit kernel if you can.  You'll be
happy not to know about all the headaches you will never encounter.

  Ralf

[1] Conditions apply.

Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Sep 2004 14:17:21 +0100 (BST)
Received: from imfep01.dion.ne.jp ([IPv6:::ffff:210.174.120.145]:20639 "EHLO
	imfep01.dion.ne.jp") by linux-mips.org with ESMTP
	id <S8224834AbUIBNRO>; Thu, 2 Sep 2004 14:17:14 +0100
Received: from mb.neweb.ne.jp ([211.126.90.1]) by imfep01.dion.ne.jp
          (InterMail vM.4.01.03.31 201-229-121-131-20020322) with ESMTP
          id <20040902131709.NBFA1125.imfep01.dion.ne.jp@mb.neweb.ne.jp>
          for <linux-mips@linux-mips.org>; Thu, 2 Sep 2004 22:17:09 +0900
Date: Thu, 2 Sep 2004 22:17:08 +0900
Subject: Re: Reset of USB
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v553)
From: ichinoh@mb.neweb.ne.jp
To: linux-mips@linux-mips.org
Content-Transfer-Encoding: 7bit
In-Reply-To: <4134F061.5080502@mvista.com>
Message-Id: <649795CC-FCE2-11D8-BFE9-000A956B2316@mb.neweb.ne.jp>
X-Mailer: Apple Mail (2.553)
Return-Path: <ichinoh@mb.neweb.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5772
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ichinoh@mb.neweb.ne.jp
Precedence: bulk
X-list: linux-mips

Thank you for advice.

I solved by setting up Frequency Control 0 register (FE2, FS2)
and setting 100 to a Clock Source Control register (MIR).

However, in U-BOOT and YAMON,
behavior of a kernel differs about USB-KEYBOARD.

A kernel is started using U-BOOT:
   USB-KEYBOARD is not recognized.

A kernel is started using YAMON:
   USB-KEYBOARD is recognized.

I am investigating this phenomenon now.


---------------- U-BOOT dmesg ---------------------
memsize=67108864
initrd_start=0xa0000000
initrd_size=0
CPU revision is: 02030204
Primary instruction cache 16kB, physically tagged, 4-way, linesize 32 
bytes.
Primary data cache 16kB 4-way, linesize 32 bytes.
Linux version 2.4.21-p4b1 (root@localhost.localdomain) (gcc version 
3.2.3) #1 Wed Sep 1 18:31:23 JST
  2004
AMD Alchemy Au1100/Db1100 Board
Determined physical RAM map:
User-defined physical RAM map:
  memory: 04000000 @ 00000000 (usable)
Initial ramdisk at: 0x802fb000 (819200 bytes)
On node 0 totalpages: 16384
zone(0): 16384 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: root=/dev/hda2 video=au1100fb:panel:s10,nohwcurs  
mem=67108864 au1000_audio=vra
  usb_ohci=base:0x10100000,len:0x100000,irq:26
au1100fb: Panel 9 800x600_16
calculating r4koff... 003c6de5(3960293)
CPU frequency 396.03 MHz
Console: colour dummy device 80x25
Calibrating delay loop... 395.67 BogoMIPS
Memory: 59976k/65536k available (1809k kernel code, 5560k reserved, 
916k data, 80k init, 0k highmem)
Dentry cache hash table entries: 8192 (order: 4, 65536 bytes)
Inode cache hash table entries: 4096 (order: 3, 32768 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer-cache hash table entries: 4096 (order: 2, 16384 bytes)
Page-cache hash table entries: 16384 (order: 4, 65536 bytes)
Checking for 'wait' instruction...  available.
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
Journalled Block Device driver loaded
Console: switching to colour frame buffer device 100x37
fb0: Au1100 LCD frame buffer device
initialize_kbd: Keyboard failed self test
pty: 256 Unix98 ptys configured
keyboard: Timeout - AT keyboard not present?(ed)
keyboard: Timeout - AT keyboard not present?(f4)
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
au1000eth.c:1.1 ppopov@mvista.com
eth0: Au1xxx ethernet found at 0xb0500000, irq 28
eth0: No mac address found
eth0: AMD 79C874 10/100 BaseT PHY at phy address 31
eth0: Using AMD 79C874 10/100 BaseT PHY as default
Uniform Multi-Platform E-IDE driver Revision: 7.00beta-2.4
ide: Assuming 50MHz system bus speed for PIO modes; override with 
idebus=xx
ide0: ports already in use, skipping probe
ide1: ports already in use, skipping probe
ide2: ports already in use, skipping probe
ide3: ports already in use, skipping probe
ide4: ports already in use, skipping probe
ide5: ports already in use, skipping probe
Au1000 audio: stevel@mvista.com, built 18:34:06 on Sep  1 2004
Au1000 audio: DAC: DMA0/IRQ6, ADC: DMA1/IRQ7
ac97_codec: AC97 Audio codec, id: 0x8384:0x7652 (SigmaTel STAC9752/53)
Au1000 audio: AC'97 Base/Extended ID = 6a90/0a05
Db1xxx flash: probing 32-bit flash bus
  Amd/Fujitsu Extended Query Table v1.3 at 0x0040
number of CFI chips: 1
cfi_cmdset_0002: Disabling fast programming due to code brokenness.
Creating 2 MTD partitions on "Db1x00 flash":
0x00000000-0x00e00000 : "User FS"
0x00e00000-0x01000000 : "raw kernel"
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
usb-ohci.c: USB OHCI at membase 0xb0100000, IRQ 26
usb-ohci.c: usb-builtin, non-PCI OHCI
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 2 ports detected
usb.c: registered new driver hid
hid-core.c: v1.8.1 Andreas Gal, Vojtech Pavlik <vojtech@suse.cz>
hid-core.c: USB HID support drivers
mice: PS/2 mouse device common for all mice
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 4096 bind 8192)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Serial driver version 1.01 (2001-02-08) with no serial options enabled
ttyS00 at 0xb1100000 (irq = 0) is a 16550
ttyS01 at 0xb1200000 (irq = 1) is a 16550
ttyS02 at 0xb1300000 (irq = 2) is a 16550
ttyS03 at 0xb1400000 (irq = 3) is a 16550
RAMDISK: Compressed image found at block 0
Freeing initrd memory: 800k freed
VFS: Mounted root (ext2 filesystem).
Algorithmics/MIPS FPU Emulator v1.5
hub.c: new USB device builtin-2, assigned address 2
usb.c: USB device not accepting new address=2 (error=-145)
Linux Kernel Card Services 3.1.22
   options:  [pci]

Au1x00 PCMCIA (CS release 3.1.22)
hub.c: new USB device builtin-2, assigned address 3
usb.c: USB device not accepting new address=3 (error=-145)
eth0: link up
eth0: going to full duplex
Trying to free nonexistent resource <c0010000-c001000f>
hda: HMS360404D5CF00, CFA DISK drive
ide1: ports already in use, skipping probe
ide2: ports already in use, skipping probe
ide3: ports already in use, skipping probe
ide4: ports already in use, skipping probe
ide5: ports already in use, skipping probe
ide0 at 0xc0010000-0xc0010007,0xc001000e on irq 34
hda: task_no_data_intr: status=0x51 { DriveReady SeekComplete Error }
hda: task_no_data_intr: error=0x04 { DriveStatusError }
hda: 7999488 sectors (4096 MB) w/128KiB Cache, CHS=7936/16/63
Partition check:
  hda:<6> [PTBL] [992/128/63] hda1 hda2 hda3
ide_cs: hda: Vcc = 3.3, Vpp = 0.0
  hda: hda1 hda2 hda3
  hda: hda1 hda2 hda3
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Trying to move old root to /initrd ... okay
Freeing unused kernel memory: 80k freed
EXT3-fs warning: maximal mount count reached, running e2fsck is 
recommended
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,2), internal journal

----------------- YAMON dmesg ---------------------
CPU revision is: 02030204
Primary instruction cache 16kB, physically tagged, 4-way, linesize 32 
bytes.
Primary data cache 16kB 4-way, linesize 32 bytes.
Linux version 2.4.21-p4b1 (root@localhost.localdomain) (gcc version 
3.2.3) #1 Fri Aug 27 22:45:11 JS
T 2004
AMD Alchemy Au1100/Db1100 Board
Determined physical RAM map:
  memory: 04000000 @ 00000000 (usable)
Initial ramdisk at: 0x802fb000 (819200 bytes)
On node 0 totalpages: 16384
zone(0): 16384 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: root=/dev/hda2 video=au1100fb:panel:s10,nohwcurs 
au1000_audio=vra usb_ohci=base
:0x10100000,len:0x100000,irq:26
au1100fb: Panel 6 NEON_640x480_16
calculating r4koff... 003c6de6(3960294)
CPU frequency 396.03 MHz
Console: colour dummy device 80x25
Calibrating delay loop... 395.67 BogoMIPS
Memory: 59976k/65536k available (1809k kernel code, 5560k reserved, 
916k data, 80k init, 0k highmem)
Dentry cache hash table entries: 8192 (order: 4, 65536 bytes)
Inode cache hash table entries: 4096 (order: 3, 32768 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer-cache hash table entries: 4096 (order: 2, 16384 bytes)
Page-cache hash table entries: 16384 (order: 4, 65536 bytes)
Checking for 'wait' instruction...  available.
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
Journalled Block Device driver loaded
Console: switching to colour frame buffer device 100x37
fb0: Au1100 LCD frame buffer device
initialize_kbd: Keyboard failed self test
pty: 256 Unix98 ptys configured
keyboard: Timeout - AT keyboard not present?(ed)
keyboard: Timeout - AT keyboard not present?(f4)
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
au1000eth.c:1.1 ppopov@mvista.com
eth0: Au1xxx ethernet found at 0xb0500000, irq 28
eth0: AMD 79C874 10/100 BaseT PHY at phy address 31
eth0: Using AMD 79C874 10/100 BaseT PHY as default
Uniform Multi-Platform E-IDE driver Revision: 7.00beta-2.4
ide: Assuming 50MHz system bus speed for PIO modes; override with 
idebus=xx
ide0: ports already in use, skipping probe
ide1: ports already in use, skipping probe
ide2: ports already in use, skipping probe
ide3: ports already in use, skipping probe
ide4: ports already in use, skipping probe
ide5: ports already in use, skipping probe
Au1000 audio: stevel@mvista.com, built 22:47:51 on Aug 27 2004
Au1000 audio: DAC: DMA0/IRQ6, ADC: DMA1/IRQ7
ac97_codec: AC97 Audio codec, id: 0x8384:0x7652 (SigmaTel STAC9752/53)
Au1000 audio: AC'97 Base/Extended ID = 6a90/0a05
Db1xxx flash: probing 32-bit flash bus
  Amd/Fujitsu Extended Query Table v1.3 at 0x0040
number of CFI chips: 1
cfi_cmdset_0002: Disabling fast programming due to code brokenness.
Creating 2 MTD partitions on "Db1x00 flash":
0x00000000-0x00e00000 : "User FS"
0x00e00000-0x01000000 : "raw kernel"
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
usb-ohci.c: USB OHCI at membase 0xb0100000, IRQ 26
usb-ohci.c: usb-builtin, non-PCI OHCI
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 2 ports detected
usb.c: registered new driver hid
hid-core.c: v1.8.1 Andreas Gal, Vojtech Pavlik <vojtech@suse.cz>
hid-core.c: USB HID support drivers
mice: PS/2 mouse device common for all mice
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 4096 bind 8192)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Serial driver version 1.01 (2001-02-08) with no serial options enabled
ttyS00 at 0xb1100000 (irq = 0) is a 16550
ttyS01 at 0xb1200000 (irq = 1) is a 16550
ttyS02 at 0xb1300000 (irq = 2) is a 16550
ttyS03 at 0xb1400000 (irq = 3) is a 16550
RAMDISK: Compressed image found at block 0
Freeing initrd memory: 800k freed
VFS: Mounted root (ext2 filesystem).
Algorithmics/MIPS FPU Emulator v1.5
hub.c: new USB device builtin-2, assigned address 2
input0: USB HID v1.00 Keyboard [  USB Multimedia Keyboard ] on usb1:2.0
input1: USB HID v1.00 Pointer [  USB Multimedia Keyboard ] on usb1:2.1
Linux Kernel Card Services 3.1.22
   options:  [pci]

Au1x00 PCMCIA (CS release 3.1.22)
eth0: link up
eth0: going to full duplex
Trying to free nonexistent resource <c0010000-c001000f>
hda: HMS360404D5CF00, CFA DISK drive
ide1: ports already in use, skipping probe
ide2: ports already in use, skipping probe
ide3: ports already in use, skipping probe
ide4: ports already in use, skipping probe
ide5: ports already in use, skipping probe
ide0 at 0xc0010000-0xc0010007,0xc001000e on irq 34
hda: task_no_data_intr: status=0x51 { DriveReady SeekComplete Error }
hda: task_no_data_intr: error=0x04 { DriveStatusError }
hda: 7999488 sectors (4096 MB) w/128KiB Cache, CHS=7936/16/63
Partition check:
  hda:<6> [PTBL] [992/128/63] hda1 hda2 hda3
ide_cs: hda: Vcc = 3.3, Vpp = 0.0
  hda: hda1 hda2 hda3
  hda: hda1 hda2 hda3
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Trying to move old root to /initrd ... okay
Freeing unused kernel memory: 80k freed
EXT3-fs warning: maximal mount count reached, running e2fsck is 
recommended
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,2), internal journal

Nyauyama

On 2004.9.1, at 06:40  AM, Pete Popov wrote:

> ichinoh@mb.neweb.ne.jp wrote:
>
>> Hello ,
>>
>> I invoked the Linux kernel on ALCHEMY DBAU1100 by U-BOOT.
>>
>> The processing which resets USB-OHCI of the head of a kernel is not 
>> completed. (refer to *)
>>
>> Au1100 does not indicate "reset is completed."
>> Is this phenomenon experienced?
>>
>> In addition,
>> this phenomenon is not encountered when starting a kernel by YAMON.
>
> Yamon initializes the CPU and then Linux doesn't have to touch too 
> many registers. I'm guessing u-boot doesn't setup the clocking 
> correctly, or at all, and that might be your problem. The Yamon code 
> for these boards is available and it's easy to read the initialization 
> code.  Take a look at it and that should solve your problem.
>
> Pete
>
>>
>>
>> *:
>> arch/mips/au1000/common/setup.c
>>
>> #ifdef CONFIG_USB_OHCI
>>     // enable host controller and wait for reset done
>>     au_writel(0x08, USB_HOST_CONFIG);
>>     udelay(1000);
>>     au_writel(0x0E, USB_HOST_CONFIG);
>>     udelay(1000);
>>     au_readl(USB_HOST_CONFIG); // throw away first read
>>     while (!(au_readl(USB_HOST_CONFIG) & 0x10))
>>         au_readl(USB_HOST_CONFIG);
>> #endif
>>
>> Best regards,
>> Nyauyama
>>
>>
>

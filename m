Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Sep 2010 17:58:10 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:4456 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491099Ab0IOP6C (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 15 Sep 2010 17:58:02 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4c90ed240000>; Wed, 15 Sep 2010 08:58:28 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Wed, 15 Sep 2010 08:57:57 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Wed, 15 Sep 2010 08:57:57 -0700
Message-ID: <4C90ECFF.8010903@caviumnetworks.com>
Date:   Wed, 15 Sep 2010 08:57:51 -0700
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.11) Gecko/20100720 Fedora/3.0.6-1.fc12 Thunderbird/3.0.6
MIME-Version: 1.0
To:     Gregory Giraud <gregory.giraud@ymail.com>
CC:     mlistz@gmail.com, linux-mips@linux-mips.org
Subject: Re: cavium reference board, sdk 1.9.0 and the latest linux kernel
References: <490843.51422.qm@web28307.mail.ukl.yahoo.com>
In-Reply-To: <490843.51422.qm@web28307.mail.ukl.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 15 Sep 2010 15:57:57.0394 (UTC) FILETIME=[C3CA0F20:01CB54EE]
X-archive-position: 27754
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 11937

On 09/15/2010 05:15 AM, Gregory Giraud wrote:
> Hi,
>
> I found your post on
> http://www.linux-mips.org/archives/linux-mips/2010-02/msg00005.html.
> I have the same problem on CN31xx with updating kernel to 2.6.29.
>
> Have you solve it?
>

Yes.

The root filesystem binaries (including init) that come as part of the 
Octeon SDK are not compatible with generic Linux kernels.  Any attempt 
to use the binaries of the SDK rootfs with a generic kernel will result 
in the behavior you observe.

You need to use root filesystem binaries that are compatible with the 
standard MIPS Linux ABIs.  I would suggest Debian as a starting point.

David Daney


> Thx
>
> Grégory GIRAUD
>
>
>
>
>
>
> Hi,
>
> Currently I am working on a cavium CN56xx reference board using cavium
> sdk 1.9.0. the linux kernel bundled in sdk is 2.6.27. which works fine
> on the reference board.
>
> but while i am trying to use the latest linux kernel, ie. 2.6.31,
> 2.6.32, 2.6.33-rc4, i encountered the same problem: "Kernel panic -
> not syncing: Attempted to kill init!".
>
> here is the boot log (initramfs is compiled into the kernel, the linux
> config file is attached to this mail):
>
> Bytes transferred = 66099593 (3f09989 hex), 1965 Kbytes/sec
> argv[2]: root=/dev/ram0
> argv[3]: rw
> argv[4]: panic=1
> argv[5]: init=/linuxrc
> argv[6]: coremask=0xfff
> argv[7]: console=ttyS1,115200
> ELF file is 64 bit
> Attempting to allocate memory for ELF segment: addr:
> 0xffffffff81100000 (adjusted to: 0x0000000001100000), size 0x25e6e30
> Allocated memory for ELF segment: addr: 0xffffffff81100000, size 0x25e6e30
> Processing PHDR 0
>    Loading 25b5a80 bytes at ffffffff81100000
>    Clearing 313b0 bytes at ffffffff836b5a80
> ## Loading Linux kernel with entry point: 0xffffffff81105f10 ...
> Bootloader: Done loading app on coremask: 0xfff
> Linux version 2.6.31 (root@R710) (gcc version 4.3.3 (Cavium Networks
> Version: 1_9_0 build 80) ) #17 SMP PREEMPT Tue Jan 19 01:19:220
> CVMSEG size: 2 cache lines (256 bytes)
> CPU revision is: 000d0409 (Cavium Octeon)
> Checking for the multiply/shift bug... no.
> Checking for the daddiu bug... no.
> Determined physical RAM map:
>   memory: 00000000022ce000 @ 00000000013e8000 (usable)
>   memory: 000000000c800000 @ 0000000003700000 (usable)
>   memory: 0000000011800000 @ 0000000020000000 (usable)
> Wasting 326144 bytes for tracking 5096 unused pages
> Initrd not found or empty - disabling initrd
> Zone PFN ranges:
>    Normal   0x000013e8 ->  0x00031800
> Movable zone start PFN for each node
> early_node_map[3] active PFN ranges
>      0: 0x000013e8 ->  0x000036b6
>      0: 0x00003700 ->  0x0000ff00
>      0: 0x00020000 ->  0x00031800
> Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 128701
> Kernel command line:  bootoctlinux 0x20000000 root=/dev/ram0 rw
> panic=1 init=/linuxrc coremask=0xfff console=ttyS1,115200
> PID hash table entries: 2048 (order: 11, 16384 bytes)
> Dentry cache hash table entries: 65536 (order: 7, 524288 bytes)
> Inode-cache hash table entries: 32768 (order: 6, 262144 bytes)
> Primary instruction cache 32kB, virtually tagged, 4 way, 64 sets,
> linesize 128 bytes.
> Primary data cache 16kB, 64-way, 2 sets, linesize 128 bytes.
> Memory: 477572k/527160k available (2185k kernel code, 49004k reserved,
> 788k data, 35640k init, 0k highmem)
> NR_IRQS:152
> console [ttyS1] enabled
> Calibrating delay using timer specific routine.. 1602.37 BogoMIPS (lpj=3204755)
> Security Framework initialized
> Mount-cache hash table entries: 256
> Checking for the daddi bug... no.
> SMP: Booting CPU01 (CoreId  1)...
> CPU revision is: 000d0409 (Cavium Octeon)
> Calibrating delay using timer specific routine.. 1601.69 BogoMIPS (lpj=3203395)
> SMP: Booting CPU02 (CoreId  2)...
> CPU revision is: 000d0409 (Cavium Octeon)
> Calibrating delay using timer specific routine.. 1601.80 BogoMIPS (lpj=3203612)
> SMP: Booting CPU03 (CoreId  3)...
> CPU revision is: 000d0409 (Cavium Octeon)
> Calibrating delay using timer specific routine.. 1601.68 BogoMIPS (lpj=3203378)
> SMP: Booting CPU04 (CoreId  4)...
> CPU revision is: 000d0409 (Cavium Octeon)
> Calibrating delay using timer specific routine.. 1601.80 BogoMIPS (lpj=3203610)
> SMP: Booting CPU05 (CoreId  5)...
> CPU revision is: 000d0409 (Cavium Octeon)
> Calibrating delay using timer specific routine.. 1601.68 BogoMIPS (lpj=3203375)
> SMP: Booting CPU06 (CoreId  6)...
> CPU revision is: 000d0409 (Cavium Octeon)
> Calibrating delay using timer specific routine.. 1601.80 BogoMIPS (lpj=3203606)
> SMP: Booting CPU07 (CoreId  7)...
> CPU revision is: 000d0409 (Cavium Octeon)
> Calibrating delay using timer specific routine.. 1601.68 BogoMIPS (lpj=3203376)
> SMP: Booting CPU08 (CoreId  8)...
> CPU revision is: 000d0409 (Cavium Octeon)
> Calibrating delay using timer specific routine.. 1601.80 BogoMIPS (lpj=3203607)
> SMP: Booting CPU09 (CoreId  9)...
> CPU revision is: 000d0409 (Cavium Octeon)
> Calibrating delay using timer specific routine.. 1601.68 BogoMIPS (lpj=3203376)
> SMP: Booting CPU10 (CoreId 10)...
> CPU revision is: 000d0409 (Cavium Octeon)
> Calibrating delay using timer specific routine.. 1601.80 BogoMIPS (lpj=3203605)
> SMP: Booting CPU11 (CoreId 11)...
> CPU revision is: 000d0409 (Cavium Octeon)
> Calibrating delay using timer specific routine.. 1601.61 BogoMIPS (lpj=3203229)
> Brought up 12 CPUs
> NET: Registered protocol family 16
> bio: create slab<bio-0>  at 0
> NET: Registered protocol family 2
> IP route cache hash table entries: 16384 (order: 5, 131072 bytes)
> TCP established hash table entries: 65536 (order: 8, 1048576 bytes)
> TCP bind hash table entries: 65536 (order: 9, 2097152 bytes)
> TCP: Hash tables configured (established 65536 bind 65536)
> TCP reno registered
> NET: Registered protocol family 1
> msgmni has been set to 933
> alg: No test for stdrng (krng)
> io scheduler noop registered
> io scheduler anticipatory registered
> io scheduler deadline registered
> io scheduler cfq registered (default)
> Serial: 8250/16550 driver, 2 ports, IRQ sharing disabled
> serial8250.0: ttyS1 at MMIO 0x1180000000c00 (irq = 59) is a OCTEON
> brd: module loaded
> loop: module loaded
> TCP cubic registered
> NET: Registered protocol family 17
> Bootbus flash: Setting flash for 64MB flash at 0x1bc00000
> drivers/mtd/chips/cfi_probe.c:166
> phys_mapped_flash: Found 1 x16 devices at 0x0 in 16-bit bank
>   Amd/Fujitsu Extended Query Table at 0x0040
> phys_mapped_flash: CFI does not contain boot bank location. Assuming top.
> number of CFI chips: 1
> cfi_cmdset_0002: Disabling erase-suspend-program due to code brokenness.
> Creating 4 MTD partitions on "phys_mapped_flash":
> 0x000000080000-0x000000680000 : "O60H BOOT"
> 0x000000680000-0x000003f80000 : "O60H ROOT"
> 0x000000000000-0x000000080000 : "U-BOOT"
> 0x000003f80000-0x000004000000 : "U-BOOT(env)"
> Freeing unused kernel memory: 35640k freed
> Kernel panic - not syncing: Attempted to kill init!
> Rebooting in 1 seconds..
>
> U-Boot 1.1.1 (Development build) (Build time: May 25 2009 - 16:32:17)
>
> EBH5600 board revision major:1, minor:0
> OCTEON CN5650-NSP pass 2.1, Core clock: 800 MHz, DDR clock: 400 MHz
> (800 Mhz data rate)
> Warning: Board descriptor tuple not found in eeprom, using defaults
> DRAM:  4096 MB
> Flash: 64 MB
> Clearing DRAM........ done
> BIST check passed.
>
>
> My question is, what is the current status of octeon plus cn56xx
> support in official linux kernel release? Is cavium cn56xx reference
> board supported? If the answer is 'yes', how can I make the latest
> kernel and boot it successfully on the reference board?
>
> Thanks very much. I will be glad to provide more information if required.
>
> Zhuang Yuyao
>
>
>
>

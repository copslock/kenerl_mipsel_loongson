Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 03 Jun 2017 13:33:17 +0200 (CEST)
Received: from eth2015.qld.adsl.internode.on.net ([150.101.176.226]:57391 "EHLO
        atomos.longlandclan.id.au" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991672AbdFCLdJ7cqHo (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 3 Jun 2017 13:33:09 +0200
Received: from [IPv6:2001:44b8:21ac:7053:a64e:31ff:fe53:99cc] (rikishi.local [IPv6:2001:44b8:21ac:7053:a64e:31ff:fe53:99cc])
        by atomos.longlandclan.id.au (Postfix) with ESMTPSA id 2A96F208B28D
        for <linux-mips@linux-mips.org>; Sat,  3 Jun 2017 21:32:57 +1000 (EST)
To:     linux-mips@linux-mips.org
From:   Stuart Longland <stuartl@longlandclan.id.au>
Subject: QEMU Malta emulation using I6400: runaway loop modprobe binfmt-464c
Openpgp: id=BCA11879F4F93BE3DB0DEE72F954BBBB7948D546;
 url=https://stuartl.longlandclan.id.au/key.asc
Message-ID: <996c275d-d969-508e-6b4e-bef22d8e7385@longlandclan.id.au>
Date:   Sat, 3 Jun 2017 21:32:43 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.6.0
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="rVufPFSh42VWxExhETP4wplqluBcqUWvd"
Return-Path: <stuartl@longlandclan.id.au>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58184
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: stuartl@longlandclan.id.au
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--rVufPFSh42VWxExhETP4wplqluBcqUWvd
Content-Type: multipart/mixed; boundary="R21d4NKmdRk9q8v5hJqgUA9eVfKfE2Cx5"
From: Stuart Longland <stuartl@longlandclan.id.au>
To: linux-mips@linux-mips.org
Message-ID: <996c275d-d969-508e-6b4e-bef22d8e7385@longlandclan.id.au>
Subject: QEMU Malta emulation using I6400: runaway loop modprobe binfmt-464c

--R21d4NKmdRk9q8v5hJqgUA9eVfKfE2Cx5
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi all,

This is a silly question=E2=80=A6 I am in the process of bootstrapping a =
n64
build of Gentoo inside a QEMU VM.  Now, I've been grinding away at this
for a few weeks now, and I'm nearly there, and I'm getting impatient. ;-)=


Prior to this evening, I've been using QEMU in uniprocessor mode with an
emulated little-endian MIPS64r2-generic CPU and 2GB RAM.  The host is a
AMD Phenom IIx6 (6-core CPU) with 8GB RAM and I am running QEMU 2.9.50.

With one MIPS64r2 CPU, and compiling for that environment, it works.
Performance is not stellar, and it is annoying having 5 CPU cores just
twiddling their metaphoric thumbs while one gets pummelled by the VM,
but it does work.

It is better than trying to do this on the little Yeeloong in so far as
I have double the RAM.  It's debatable as to whether the emulated CPU is
faster than a Loongson 2F.

I stumbled upon this article, which describes how to get QEMU to emulate
an octo-core I6400-based system, so I figured I'd give this a try:

https://www.imgtec.com/blog/how-to-run-smp-linux-in-qemu-on-a-mips64-rele=
ase-6-cpu/

Setting the relevant options in the kernel .config (which I'll happily
supply) and re-building, I now get this:

QEMU invocation (line breaks added for readability):

/usr/bin/qemu-system-mips64el -cpu I6400 -smp 8 -m 2G \
    -spice disable-ticketing,port=3D5900 \
    -M malta -kernel /home/stuartl/kernels/qemu-mips/vmlinux \
    -hda /var/lib/libvirt/images/gentoo-mips64el.raw \
    -append 'mem=3D256m@0x0 mem=3D1792m@0x90000000 \
         root=3D/dev/sda1 console=3DttyS0,115200' \
    -chardev socket,id=3Dchar0,port=3D65223,host=3D::1,server,telnet \
    -chardev socket,id=3Dchar1,port=3D65224,host=3D::1,server,telnet,nowa=
it \
    -serial chardev:char0 -mon chardev=3Dchar1,mode=3Dreadline \
    -net nic -net bridge,helper=3D/usr/libexec/qemu-bridge-helper,br=3Dbr=
0

> Linux version 4.10.0-qemu-mipsel-smp-06476-gbc49a7831b11 (stuartl@beast=
) (gcc version 5.4.0 (Gentoo 5.4.0-r3) ) #3 SMP Sat Jun 3 20:50:35 EST 20=
17
> earlycon: uart8250 at I/O port 0x3f8 (options '38400n8')
> bootconsole [uart8250] enabled
> CPU0 revision is: 0001a900 (MIPS I6400)
> FPU revision is: 20f30300
> MSA revision is: 00000300
> MIPS: machine is mti,malta
> Software DMA cache coherency enabled
> Determined physical RAM map:
>  memory: 0000000010000000 @ 0000000000000000 (usable)
>  memory: 0000000070000000 @ 0000000090000000 (usable)
> User-defined physical RAM map:
>  memory: 0000000010000000 @ 0000000000000000 (usable)
>  memory: 0000000070000000 @ 0000000090000000 (usable)
>  memory: 0000000090000000 @ 0000000000000000 (reserved)
> VP topology {8} total 8
> Primary instruction cache 64kB, VIPT, 4-way, linesize 64 bytes.
> Primary data cache 64kB, 4-way, PIPT, no aliases, linesize 64 bytes
> Zone ranges:
>   DMA      [mem 0x0000000000000000-0x0000000000ffffff]
>   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
>   Normal   empty
> Movable zone start for each node
> Early memory node ranges
>   node   0: [mem 0x0000000000000000-0x00000000ffffffff]
> Initmem setup node 0 [mem 0x0000000000000000-0x00000000ffffffff]
> percpu: Embedded 6 pages/cpu @a80000000200c000 s60512 r8192 d29600 u983=
04
> Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 26=
1120
> Kernel command line: mem=3D256m@0x0 mem=3D1792m@0x90000000 root=3D/dev/=
sda1 console=3DttyS0,115200
> log_buf_len individual max cpu contribution: 4096 bytes
> log_buf_len total cpu_extra contributions: 28672 bytes
> log_buf_len min size: 32768 bytes
> log_buf_len: 65536 bytes
> early log buf free: 30032(91%)
> PID hash table entries: 4096 (order: 1, 32768 bytes)
> Dentry cache hash table entries: 524288 (order: 8, 4194304 bytes)
> Inode-cache hash table entries: 262144 (order: 7, 2097152 bytes)
> Cache parity protection disabled
> MAAR configuration:
>   [0]: 0x0000000000000000-0x000000000fffffff speculate
>   [1]: 0x0000000090000000-0x00000000ffffffff speculate
>   [2]: disabled
>   [3]: disabled
>   [4]: disabled
>   [5]: disabled
>   [6]: disabled
>   [7]: disabled
> Memory: 2062176K/4194304K available (7328K kernel code, 744K rwdata, 15=
76K rodata, 432K init, 362K bss, 2132128K reserved, 0K cma-reserved)
> Hierarchical RCU implementation.
>         RCU debugfs-based tracing is enabled.
>         Build-time adjustment of leaf fanout to 64.
> NR_IRQS:256
> CPU frequency 200.00 MHz
> GIC frequency 100.00 MHz
> clocksource: GIC: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns:=
 19112886379 ns
> GIC timer IRQ 25 setup failed: -22
> clocksource: MIPS: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns=
: 19112652819 ns
> sched_clock: 32 bits at 99MHz, resolution 10ns, wraps every 21474890746=
ns
> Console: colour dummy device 80x25
> Calibrating delay loop... 1179.64 BogoMIPS (lpj=3D5898240)
> pid_max: default: 32768 minimum: 301
> Mount-cache hash table entries: 8192 (order: 2, 65536 bytes)
> Mountpoint-cache hash table entries: 8192 (order: 2, 65536 bytes)
> Performance counters: No available PMU.
> smp: Bringing up secondary CPUs ...
> Primary instruction cache 64kB, VIPT, 4-way, linesize 64 bytes.
> Primary data cache 64kB, 4-way, PIPT, no aliases, linesize 64 bytes
> CPU1 revision is: 0001a900 (MIPS I6400)
> FPU revision is: 20f30300
> MSA revision is: 00000300
> Synchronize counters for CPU 1: done.
> Primary instruction cache 64kB, VIPT, 4-way, linesize 64 bytes.
> Primary data cache 64kB, 4-way, PIPT, no aliases, linesize 64 bytes
> CPU2 revision is: 0001a900 (MIPS I6400)
> FPU revision is: 20f30300
> MSA revision is: 00000300
> Synchronize counters for CPU 2: done.
> Primary instruction cache 64kB, VIPT, 4-way, linesize 64 bytes.
> Primary data cache 64kB, 4-way, PIPT, no aliases, linesize 64 bytes
> CPU3 revision is: 0001a900 (MIPS I6400)
> FPU revision is: 20f30300
> MSA revision is: 00000300
> Synchronize counters for CPU 3: done.
> Primary instruction cache 64kB, VIPT, 4-way, linesize 64 bytes.
> Primary data cache 64kB, 4-way, PIPT, no aliases, linesize 64 bytes
> CPU4 revision is: 0001a900 (MIPS I6400)
> FPU revision is: 20f30300
> MSA revision is: 00000300
> Synchronize counters for CPU 4: done.
> Primary instruction cache 64kB, VIPT, 4-way, linesize 64 bytes.
> Primary data cache 64kB, 4-way, PIPT, no aliases, linesize 64 bytes
> CPU5 revision is: 0001a900 (MIPS I6400)
> FPU revision is: 20f30300
> MSA revision is: 00000300
> Synchronize counters for CPU 5: done.
> Primary instruction cache 64kB, VIPT, 4-way, linesize 64 bytes.
> Primary data cache 64kB, 4-way, PIPT, no aliases, linesize 64 bytes
> CPU6 revision is: 0001a900 (MIPS I6400)
> FPU revision is: 20f30300
> MSA revision is: 00000300
> Synchronize counters for CPU 6: done.
> Primary instruction cache 64kB, VIPT, 4-way, linesize 64 bytes.
> Primary data cache 64kB, 4-way, PIPT, no aliases, linesize 64 bytes
> CPU7 revision is: 0001a900 (MIPS I6400)
> FPU revision is: 20f30300
> MSA revision is: 00000300
> Synchronize counters for CPU 7: done.
> smp: Brought up 1 node, 8 CPUs
> devtmpfs: initialized
> clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle=
_ns: 19112604462750000 ns
> futex hash table entries: 2048 (order: 3, 131072 bytes)
> xor: measuring software checksum speed
>    8regs     :  1363.200 MB/sec
>    8regs_prefetch:  1248.000 MB/sec
> random: fast init done
>    32regs    :  1299.200 MB/sec
>    32regs_prefetch:   993.600 MB/sec
> xor: using function: 8regs (1363.200 MB/sec)=20
> NET: Registered protocol family 16
> pm-cps: CPC does not support clock gating
> raid6: int64x1  gen()   585 MB/s
> raid6: int64x1  xor()   383 MB/s
> raid6: int64x2  gen()   885 MB/s
> raid6: int64x2  xor()   466 MB/s
> raid6: int64x4  gen()   632 MB/s
> raid6: int64x4  xor()   414 MB/s
> raid6: int64x8  gen()   310 MB/s
> raid6: int64x8  xor()   236 MB/s
> raid6: using algorithm int64x2 gen() 885 MB/s
> raid6: .... xor() 466 MB/s, rmw enabled
> raid6: using intx1 recovery algorithm
> vgaarb: loaded
> SCSI subsystem initialized
> PCI host bridge to bus 0000:00
> pci_bus 0000:00: root bus resource [mem 0x10000000-0x17ffffff]
> pci_bus 0000:00: root bus resource [io  0x1000-0x1fffff]
> pci_bus 0000:00: root bus resource [??? 0x00000000 flags 0x0]
> pci_bus 0000:00: No busn resource found for root bus, will use [bus 00-=
ff]
> pci 0000:00:00.0: [Firmware Bug]: reg 0x14: invalid BAR (can't size)
> pci 0000:00:00.0: [Firmware Bug]: reg 0x18: invalid BAR (can't size)
> pci 0000:00:00.0: [Firmware Bug]: reg 0x1c: invalid BAR (can't size)
> pci 0000:00:00.0: [Firmware Bug]: reg 0x20: invalid BAR (can't size)
> pci 0000:00:00.0: [Firmware Bug]: reg 0x24: invalid BAR (can't size)
> pci 0000:00:0a.1: legacy IDE quirk: reg 0x10: [io  0x01f0-0x01f7]
> pci 0000:00:0a.1: legacy IDE quirk: reg 0x14: [io  0x03f6]
> pci 0000:00:0a.1: legacy IDE quirk: reg 0x18: [io  0x0170-0x0177]
> pci 0000:00:0a.1: legacy IDE quirk: reg 0x1c: [io  0x0376]
> pci 0000:00:0a.3: quirk: [io  0x1000-0x103f] claimed by PIIX4 ACPI
> pci 0000:00:0a.3: quirk: [io  0x1100-0x110f] claimed by PIIX4 SMB
> pci 0000:00:12.0: vgaarb: VGA device added: decodes=3Dio+mem,owns=3Dnon=
e,locks=3Dnone
> pci 0000:00:12.0: BAR 0: assigned [mem 0x10000000-0x11ffffff pref]
> pci 0000:00:0b.0: BAR 6: assigned [mem 0x12000000-0x1203ffff pref]
> pci 0000:00:12.0: BAR 6: assigned [mem 0x12040000-0x1204ffff pref]
> pci 0000:00:12.0: BAR 1: assigned [mem 0x12050000-0x12050fff]
> pci 0000:00:0a.2: BAR 4: assigned [io  0x1040-0x105f]
> pci 0000:00:0b.0: BAR 0: assigned [io  0x1060-0x107f]
> pci 0000:00:0b.0: BAR 1: assigned [mem 0x12051000-0x1205101f]
> pci 0000:00:0a.1: BAR 4: assigned [io  0x1080-0x108f]
> clocksource: Switched to clocksource GIC
> VFS: Disk quotas dquot_6.6.0
> VFS: Dquot-cache hash table entries: 2048 (order 0, 16384 bytes)
> NET: Registered protocol family 2
> TCP established hash table entries: 32768 (order: 4, 262144 bytes)
> TCP bind hash table entries: 32768 (order: 5, 524288 bytes)
> TCP: Hash tables configured (established 32768 bind 32768)
> UDP hash table entries: 2048 (order: 2, 65536 bytes)
> UDP-Lite hash table entries: 2048 (order: 2, 65536 bytes)
> NET: Registered protocol family 1
> RPC: Registered named UNIX socket transport module.
> RPC: Registered udp transport module.
> RPC: Registered tcp transport module.
> RPC: Registered tcp NFSv4.1 backchannel transport module.
> workingset: timestamp_bits=3D46 max_order=3D17 bucket_order=3D0
> Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
> Block layer SCSI generic (bsg) driver version 0.4 loaded (major 253)
> io scheduler noop registered
> io scheduler deadline registered
> io scheduler cfq registered (default)
> io scheduler mq-deadline registered
> PCI: Enabling device 0000:00:12.0 (0000 -> 0002)
> cirrusfb 0000:00:12.0: Cirrus Logic chipset on PCI bus, RAM (4096 kB) a=
t 0x10000000
> Console: switching to colour frame buffer device 80x30
> hrtimer: interrupt took 139982644 ns
> Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
> console [ttyS0] disabled
> serial8250.0: ttyS0 at I/O 0x3f8 (irq =3D 4, base_baud =3D 115200) is a=
 16550A
> console [ttyS0] enabled
> console [ttyS0] enabled
> bootconsole [uart8250] disabled
> bootconsole [uart8250] disabled
> serial8250.0: ttyS1 at I/O 0x2f8 (irq =3D 3, base_baud =3D 115200) is a=
 16550A
> serial8250.0: ttyS2 at MMIO 0x1f000900 (irq =3D 20, base_baud =3D 23040=
0) is a 16550A
> cacheinfo: Failed to find cpu0 device node  =20
> cacheinfo: Unable to detect cache hierarchy for CPU 0
> brd: module loaded
> Uniform Multi-Platform E-IDE driver
> ide-gd driver 1.18
> ide-cd driver 5.00
> PCI: Enabling device 0000:00:0a.1 (0000 -> 0001)
> scsi host0: ata_piix
> scsi host1: ata_piix
> ata1: PATA max UDMA/33 cmd 0x1f0 ctl 0x3f6 bmdma 0x1080 irq 14
> ata2: PATA max UDMA/33 cmd 0x170 ctl 0x376 bmdma 0x1088 irq 15
> pcnet32: pcnet32.c:v1.35 21.Apr.2008 tsbogend@alpha.franken.de
> PCI: Enabling device 0000:00:0b.0 (0000 -> 0003)
> pcnet32: PCnet/PCI II 79C970A at 0x1060, 52:54:00:12:34:56 assigned IRQ=
 10
> pcnet32: eth0: registered as PCnet/PCI II 79C970A
> pcnet32: 1 cards_found
> mousedev: PS/2 mouse device common for all mice
> rtc_cmos 70.rtc: rtc core: registered rtc_cmos as rtc0
> rtc_cmos 70.rtc: alarms up to one day, 242 bytes nvram
> NET: Registered protocol family 10
> Segment Routing with IPv6
> sit: IPv6, IPv4 and MPLS over IPv4 tunneling driver
> NET: Registered protocol family 17
> NET: Registered protocol family 15
> Btrfs loaded, crc32c=3Dcrc32c-generic
> rtc_cmos 70.rtc: setting system clock to 2017-06-03 10:52:12 UTC (14964=
87132)
> ata1.00: ATA-7: QEMU HARDDISK, 2.5+, max UDMA/100
> ata1.00: 33554432 sectors, multi 16: LBA48  =20
> ata1.00: configured for UDMA/33
> ata2.00: ATAPI: QEMU DVD-ROM, 2.5+, max UDMA/100
> ata2.00: configured for UDMA/33
> scsi 0:0:0:0: Direct-Access     ATA      QEMU HARDDISK    2.5+ PQ: 0 AN=
SI: 5
> sd 0:0:0:0: [sda] 33554432 512-byte logical blocks: (17.2 GB/16.0 GiB)
> sd 0:0:0:0: [sda] Write Protect is off
> scsi 1:0:0:0: CD-ROM            QEMU     QEMU DVD-ROM     2.5+ PQ: 0 AN=
SI: 5
> sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't su=
pport DPO or FUA
>  sda: sda1
> sd 0:0:0:0: [sda] Attached SCSI disk
> sr 1:0:0:0: [sr0] scsi3-mmc drive: 4x/4x cd/rw xa/form2 tray
> cdrom: Uniform CD-ROM driver Revision: 3.20 =20
> EXT4-fs (sda1): couldn't mount as ext3 due to feature incompatibilities=

> EXT4-fs (sda1): mounted filesystem with ordered data mode. Opts: (null)=

> VFS: Mounted root (ext4 filesystem) readonly on device 8:1.
> Freeing unused kernel memory: 432K
> This architecture does not have kernel memory protection.
> request_module: runaway loop modprobe binfmt-464c
> Starting init: /sbin/init exists but couldn't execute it (error -8)
> request_module: runaway loop modprobe binfmt-464c
> Starting init: /bin/sh exists but couldn't execute it (error -8)
> Kernel panic - not syncing: No working init found.  Try passing init=3D=
 option to kernel. See Linux Documentation/admin-guide/init.rst for guida=
nce.
> ---[ end Kernel panic - not syncing: No working init found.  Try passin=
g init=3D option to kernel. See Linux Documentation/admin-guide/init.rst =
for guidance.

Best I can tell, errno -8 is Exec format error (ENOEXEC).  The binaries
are n64 compiled for MIPS III ISA:

> /sbin/init: ELF 64-bit LSB executable, MIPS, MIPS-III version 1 (SYSV),=
 dynamically linked, interpreter /lib64/ld.so.1, for GNU/Linux 3.2.0, str=
ipped, with debug_info

Relevant kernel options:
> #
> # Machine selection
> #
> CONFIG_MIPS_MALTA=3Dy
> # CONFIG_CPU_BIG_ENDIAN is not set
> CONFIG_CPU_LITTLE_ENDIAN=3Dy
> CONFIG_SYS_SUPPORTS_BIG_ENDIAN=3Dy
> CONFIG_SYS_SUPPORTS_LITTLE_ENDIAN=3Dy
> # CONFIG_CPU_MIPS32_R1 is not set
> # CONFIG_CPU_MIPS32_R2 is not set
> # CONFIG_CPU_MIPS32_R6 is not set
> # CONFIG_CPU_MIPS64_R1 is not set
> # CONFIG_CPU_MIPS64_R2 is not set
> CONFIG_CPU_MIPS64_R6=3Dy
> # CONFIG_CPU_NEVADA is not set
> # CONFIG_CPU_RM7000 is not set

> #
> # Executable file formats
> #
> CONFIG_BINFMT_ELF=3Dy
> CONFIG_ARCH_BINFMT_ELF_STATE=3Dy
> CONFIG_ELFCORE=3Dy
> CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS=3Dy
> CONFIG_BINFMT_SCRIPT=3Dy
> # CONFIG_HAVE_AOUT is not set
> # CONFIG_BINFMT_MISC is not set
> CONFIG_COREDUMP=3Dy
> CONFIG_MIPS32_COMPAT=3Dy
> CONFIG_COMPAT=3Dy
> CONFIG_SYSVIPC_COMPAT=3Dy
> CONFIG_MIPS32_O32=3Dy
> CONFIG_MIPS32_N32=3Dy
> CONFIG_BINFMT_ELF32=3Dy

Now, on a single-processor MIPS64r2 VM, this same root filesystem works.
 It won't work though for a 8-core I6400 system.  If I try to run a SMP
MIPS64r2 VM, I get "unable to proceed without a CM", so clearly there is
a feature in the I6400 that doesn't exist in the MIPS64r2.

Adding mipsr2emu=3D1 to the kernel command line (with
CONFIG_MIPSR2_TO_R6_EMULATOR=3Dy) doesn't help here either.  It just adds=

a message to say the emulator is enabled (great, emulators within
emulators, just need Java now for a tur-duck-en style computing
experience), but seemingly still does not like my binaries.

Is there something I've missed?
--=20
Stuart Longland (aka Redhatter, VK4MSL)

I haven't lost my mind...
  ...it's backed up on a tape somewhere.


--R21d4NKmdRk9q8v5hJqgUA9eVfKfE2Cx5--

--rVufPFSh42VWxExhETP4wplqluBcqUWvd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJZMp5gAAoJEPlUu7t5SNVGj2sP/1qUkWp8pj8gfmSz/cGGEsfq
HlKEXxoA1YUUyl+WUi3c22BuyaEY7+Nqo0PJT+MbTdul11325g0FX28y1bdzTe9S
SdMnTG+l7Ce/H1A6dwUY28DYlSEvLa57afkhfWaZ4yoD3nvQtRAw+m3jh6PGuYMi
2pYRy2skeKpVDneb8j0wMZscnH+tca2w72cARGW4zgOL4B1XiCkprKlFobHAi21m
NkgSwC/1xawiiNzkPQeMtlfTyqLIc9e2BnXp9ZJ/erv0unWffzpYbUwPg53uow3r
R59Esstv8URdvLalTBlI07qB/q8rUJ92yU+/ZHlg59rqN95Q5nuo7M7rXH+2crtM
EdcpJV4P3prPCQ0CEIwNGWOK4MSzS7YSdn9wVHD2MV/7mmoHs0Nfd/pMklmhBi2v
eBxpV61RCEYDMXcWOwYktjLgG/EVxuqUOr/z2bl5aHDPlD0sZu1uTsptUDXP8Sds
srDjv+RP/UwDbeKGx1OZ2bMjC/XNgX4m3emnWdBUmt1zX+Q9oVmo6LHmlBEg+bF1
6231nJJM3M+CfKaxCXjErAx2LqtJHegoV8YJwmS6h2qY3sMEZ/EzID+jxswB3Sy0
jOSVtrOxgZYMUHMefffKAaylKX+GQ+c15xr99YzpCL43UXcqyU4zsdCvRQEdNDaq
K/Loz9b+3nUYUCT68dxn
=X/7K
-----END PGP SIGNATURE-----

--rVufPFSh42VWxExhETP4wplqluBcqUWvd--

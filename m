Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 May 2009 17:59:12 +0100 (BST)
Received: from apfelkorn.psychaos.be ([195.144.77.38]:49830 "EHLO
	apfelkorn.psychaos.be" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S20025209AbZEHQ7H (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 8 May 2009 17:59:07 +0100
Received: from p2 by apfelkorn.psychaos.be with local (Exim 4.69)
	(envelope-from <p2@psychaos.be>)
	id 1M2TPd-0001EN-5K
	for linux-mips@linux-mips.org; Fri, 08 May 2009 19:59:05 +0300
Date:	Fri, 8 May 2009 19:59:05 +0300
From:	Peter 'p2' De Schrijver <p2@debian.org>
To:	linux-mips@linux-mips.org
Subject: kernel boot failure on swarm
Message-ID: <20090508165905.GL1835@apfelkorn>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="mYCpIKhGyMATD0i+"
Content-Disposition: inline
X-Unexpected-Header: The spanish inquisition !
X-mate:	Mate, mann gewohnt sich an alles
X-Paddo: Munch, Munch
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <p2@psychaos.be>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22671
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: p2@debian.org
Precedence: bulk
X-list: linux-mips


--mYCpIKhGyMATD0i+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

I'm trying to boot 2.6.29 on swarm (BE) but it seems to panic in the ide driver.
Log attached.

Cheers,

Peter.

--mYCpIKhGyMATD0i+
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: attachment; filename=swarm-log
Content-Transfer-Encoding: quoted-printable

CFE version 1.0.40 for SWARM (64bit,MP,BE,MIPS)=0D
Build Date: Tue Jan 13 14:33:32 PST 2004 (mpl@lc-sj1-092.sj.broadcom.com)=0D
Copyright (C) 2000,2001,2002,2003 Broadcom Corporation.=0D
=0D
Initializing Arena.=0D
Initializing PCI. [normal]=0D
PCI bus 0 slot 1/0: Warning: SipReady already set=0D
HyperTransport not initialized: InitDone not set=0D
PCI bus 0 slot 0/0: SiByte, Inc. BCM1250 PCI Host Bridge (host bridge, rev =
0x02)=0D
PCI bus 0 slot 5/0: unknown vendor 0x3388 product 0x0021 (PCI bridge, rev 0=
x15)=0D
PCI bus 0 slot 7/0: Opti RM861HA (USB serial bus, interface 0x10, rev 0x10)=
=0D
PCI bus 1 slot 8/0: NEC USB Host Controller (USB serial bus, interface 0x10=
, rev 0x41)=0D
PCI bus 1 slot 8/1: NEC USB Host Controller (USB serial bus, interface 0x10=
, rev 0x41)=0D
PCI bus 1 slot 8/2: NEC product 0x00e0 (USB serial bus, interface 0x20, rev=
 0x02)=0D
PCI bus 1 slot 9/0: VIA Technologies product 0x3044 (Firewire serial bus, i=
nterface 0x10, rev 0x46)=0D
PCI bus 1 slot 10/0: CMD Technology product 0x0680 (RAID mass storage, rev =
0x02)=0D
Initializing Devices.=0D
SWARM board revision 3=0D
PCIIDE: 0 controllers found=0D
Config switch: 2=0D
CPU: BCM1250 B2=0D
L2 Cache Status: OK=0D
Wafer ID:   0x17326019  [Lot 1484, Wafer 19]=0D
Manuf Test: Bin A [2CPU_FI_FD_F2 (OK)] =0D
SysCfg: 0000000028DB0800 [PLL_DIV: 16, IOB0_DIV: CPUCLK/4, IOB1_DIV: CPUCLK=
/3]=0D
Initializing USB.=0D
PCI bus 0 slot 7/0: OHCI USB controller found at 61000000=0D
USB: Locating Class 09 Vendor 0000 Product 0000: USB Hub=0D
PCI bus 1 slot 8/0: OHCI USB controller found at 61181000=0D
USB: Locating Class 09 Vendor 0000 Product 0000: USB Hub=0D
PCI bus 1 slot 8/1: OHCI USB controller found at 61180000=0D
USB: Locating Class 09 Vendor 0000 Product 0000: USB Hub=0D
CPU type 0x1040102: 800MHz=0D
Total memory: 0x10000000 bytes (256MB)=0D
=0D
Total memory used by CFE:  0x8FE489C0 - 0x90000000 (1799744)=0D
Initialized Data:          0x8FE489C0 - 0x8FE54A60 (49312)=0D
BSS Area:                  0x8FE54A60 - 0x8FE55E70 (5136)=0D
Local Heap:                0x8FE55E70 - 0x8FF55E70 (1048576)=0D
Stack Area:                0x8FF55E70 - 0x8FF57E70 (8192)=0D
Text (code) segment:       0x8FF57E80 - 0x8FFFFFB8 (688440)=0D
Boot area (physical):      0x0FE07000 - 0x0FE47000=0D
Relocation Factor:         I:F0357E80 - D:0DF489C0=0D
=0D
CFE> ifconfig -auto eth0=0D
=0Deth0: Link speed: 100BaseT FDX=1B[J=0D=0D
Device eth0:  hwaddr 00-02-4C-FE-0D-72, ipaddr 192.168.1.22, mask 255.255.2=
55.0=0D
        gateway 192.168.1.254, nameserver 192.168.1.19, domain elisa-laajak=
aista.fi=0D
*** command status =3D 0=0D
CFE> boot -=08 =08192.168.1.138:sibyl=0D
Loader:raw Filesys:tftp Dev:eth0 File:192.168.1.138:sibyl Options:(null)=0D
Loading: ....... 130116 bytes read=0D
Entry at 0x0000000020000000=0D
Closing network.=0D
Starting program at 0x0000000020000000=0D
SiByte Loader, version 2.4.2=0D
Built on Oct  4 2005=0D
Network device 'eth0' configured=0D
Getting configuration file tftp:192.168.1.138:sibyl.conf...=0D
Config file retrieved.=0D
Default configuration deb doesn't exist.  Using deb-tftp instead=0D
Available configurations:=0D
  deb-tftp=0D
Boot which configuration [deb-tftp]: =0D
Loading kernel (ELF64):=0D
    4910016@0x80100000=0D
done=0D
Set up command line arguments to: root=3D/dev/hdc1 console=3Dduart0=0D
Setting up initial prom_init arguments=0D
Cleaning up state...=0D
Transferring control to the kernel.=0D
Kernel entry point is at 0x80105cd0=0D
[    0.000000] Initializing cgroup subsys cpuset=0D
[    0.000000] Initializing cgroup subsys cpu=0D
[    0.000000] Linux version 2.6.29-2-sb1-bcm91250a (Debian 2.6.29-5) (dann=
f@debian.org) (gcc version 4.1.3 20080420 (prerelease) (Debian 4.1.2-22)) #=
1 SMP Fri May 8 09:17:14 UTC 2009=0D
[    0.000000] console [early0] enabled=0D
[    0.000000] CPU revision is: 01040102 (SiByte SB1)=0D
[    0.000000] FPU revision is: 000f0102=0D
[    0.000000] Checking for the multiply/shift bug... no.=0D
[    0.000000] Checking for the daddiu bug... no.=0D
[    0.000000] Broadcom SiByte BCM1250 B2 @ 800 MHz (SB1 rev 2)=0D
[    0.000000] Board type: SiByte BCM91250A (SWARM)=0D
[    0.000000] This kernel optimized for board runs with CFE=0D
[    0.000000] Determined physical RAM map:=0D
[    0.000000]  memory: 000000000fe47e00 @ 0000000000000000 (usable)=0D
[    0.000000] Initrd not found or empty - disabling initrd=0D
[    0.000000] Zone PFN ranges:=0D
[    0.000000]   DMA32    0x00000000 -> 0x00100000=0D
[    0.000000]   Normal   0x00100000 -> 0x00100000=0D
[    0.000000] Movable zone start PFN for each node=0D
[    0.000000] early_node_map[1] active PFN ranges=0D
[    0.000000]     0: 0x00000000 -> 0x0000fe47=0D
[    0.000000] Detected 1 available secondary CPU(s)=0D
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Tota=
l pages: 64205=0D
[    0.000000] Kernel command line: root=3D/dev/hdc1 console=3Dduart0=0D
[    0.000000] Primary instruction cache 32kB, VIVT, 4-way, linesize 32 byt=
es.=0D
[    0.000000] Primary data cache 32kB, 4-way, PIPT, no aliases, linesize 3=
2 bytes=0D
[    0.000000] PID hash table entries: 1024 (order: 10, 8192 bytes)=0D
[17179569.184000] Console: colour dum=B7=15=BA=8A=BA=CA=AA=B2=CAr=8A=C2=A2=
=82=EA=81=8D=BD=B9=CD=BD=B1=95=81=A1=85=B9=91=BD=D9=95=C9=E9=81=12=BD=BD=D1=
=81m=95=85=C9=B1=E5=C1u=81=B5=F2=02=92=95=85=B1=81m=91=D5=85=C9=D1=C1u5)=DA=
=C5=DD=8A=BA=CA=AA=B2=CAr=EA=81=95=B9=D1=C9=E5=81=8D=85=8D=A1=95=81=A1=85=
=CD=A1=81=D1=85=89=B1=95=81=95=B9=D1=C9=A5=95=CD=E9=81=9A=92=BA=B2=C2=02Bz=
=C9=91=95=C9=E9=81=B2b=02=92=B2=92=8A=A2=A2=02=12=E5=D15R=FE[17179569.19600=
0] Inode-cache hash table entries: 16384 (order: 5, 131072 bytes)=0D
[17179569.232000] Memory: 249796k/260380k available (3453k kernel code, 103=
72k reserved, 1124k data, 216k init, 0k highmem)=0D
[17179569.236000] Calibrating delay loop... 532.48 BogoMIPS (lpj=3D1064960)=
=0D
[17179569.340000] Security Framework initialized=0D
[17179569.344000] SELinux:  Disabled at boot.=0D
[17179569.348000] Mount-cache hash table entries: 256=0D
[17179569.356000] Initializing cgroup subsys ns=0D
[17179569.360000] Initializing cgroup subsys cpuacct=0D
[17179569.364000] Initializing cgroup subsys devices=0D
[17179569.368000] Initializing cgroup subsys freezer=0D
[17179569.372000] Initializing cgroup subsys net_cls=0D
[17179569.376000] Checking for the daddi bug... no.=0D
[17179569.384000] CPU revision is: 03040102 (SiByte SB1)=0D
[17179569.384000] FPU revision is: 000f0102=0D
[17179569.384000] Primary instruction cache 32kB, VIVT, 4-way, linesize 32 =
bytes.=0D
[17179569.384000] Primary data cache 32kB, 4-way, PIPT, no aliases, linesiz=
e 32 bytes=0D
[17179569.384000] Calibrating delay loop... 532.48 BogoMIPS (lpj=3D1064960)=
=0D
[17179569.484000] Brought up 2 CPUs=0D
[17179569.488000] net_namespace: 1888 bytes=0D
[17179569.492000] regulator: core version 0.5=0D
[17179569.496000] NET: Registered protocol family 16=0D
[17179569.508000] bio: create slab <bio-0> at 0=0D
[17179569.512000] pci 0000:00:05.0: PME# supported from D0 D1 D2 D3hot=0D
[17179569.516000] pci 0000:00:05.0: PME# disabled=0D
[17179569.520000] pci 0000:01:08.0: PME# supported from D0 D1 D2 D3hot=0D
[17179569.524000] pci 0000:01:08.0: PME# disabled=0D
[17179569.528000] pci 0000:01:08.1: PME# supported from D0 D1 D2 D3hot=0D
[17179569.532000] pci 0000:01:08.1: PME# disabled=0D
[17179569.536000] pci 0000:01:08.2: PME# supported from D0 D1 D2 D3hot=0D
[17179569.540000] pci 0000:01:08.2: PME# disabled=0D
[17179569.544000] pci 0000:01:09.0: PME# supported from D2 D3hot D3cold=0D
[17179569.548000] pci 0000:01:09.0: PME# disabled=0D
[17179569.576000] NET: Registered protocol family 2=0D
[17179569.632000] IP route cache hash table entries: 2048 (order: 2, 16384 =
bytes)=0D
[17179569.640000] TCP established hash table entries: 8192 (order: 5, 13107=
2 bytes)=0D
[17179569.644000] TCP bind hash table entries: 8192 (order: 5, 131072 bytes=
)=0D
[17179569.652000] TCP: Hash tables configured (established 8192 bind 8192)=
=0D
[17179569.660000] TCP reno registered=0D
[17179569.676000] NET: Registered protocol family 1=0D
[17179569.680000] pata-swarm: PATA interface at GenBus slot 4=0D
[17179569.684000] audit: initializing netlink socket (disabled)=0D
[17179569.692000] type=3D2000 audit(1241801739.509:1): initialized=0D
[17179569.696000] VFS: Disk quotas dquot_6.5.2=0D
[17179569.700000] Dquot-cache hash table entries: 512 (order 0, 4096 bytes)=
=0D
[17179569.708000] msgmni has been set to 488=0D
[17179569.712000] alg: No test for stdrng (krng)=0D
[17179569.720000] Block layer SCSI generic (bsg) driver version 0.4 loaded =
(major 253)=0D
[17179569.724000] io scheduler noop registered=0D
[17179569.728000] io scheduler anticipatory registered=0D
[17179569.736000] io scheduler deadline registered=0D
[17179569.740000] io scheduler cfq registered (default)=0D
[17179569.756000] duart0 at MMIO 0x10060100 (irq =3D 8) is a SB1250 DUART=0D
[17179569.760000] duart1 at MMIO 0x10060200 (irq =3D 9) is a SB1250 DUART=0D
[17179569.772000] brd: module loaded=0D
[17179569.776000] Uniform Multi-Platform E-IDE driver=0D
[17179569.780000] ide_generic: please use "probe_mask=3D0x3f" module parame=
ter for probing all legacy ISA IDE ports=0D
[17179569.792000] DBE physical address: 00dc0001e0=0D
[17179569.792000] Data bus error, epc =3D=3D ffffffff80373234, ra =3D=3D ff=
ffffff80371a34=0D
[17179569.792000] Oops[#1]:=0D
[17179569.792000] Cpu 0=0D
[17179569.792000] $ 0   : 0000000000000000 0000000014001fe0 00000000000000f=
f 90000000dc0001f7=0D
[17179569.792000] $ 4   : 90000000dc000000 00000000000088b8 fffffffffffffff=
f 0000000000001f6d=0D
[17179569.792000] $ 8   : 0000000000001f6d 0000000000000037 ffffffffffff9f6=
d ffffffff805c0000=0D
[17179569.792000] $12   : ffffffff805c0000 ffffffff805c0000 000000000000000=
0 00000000000001f5=0D
[17179569.792000] $16   : 3ffffffffffffc78 0000000000000001 a80000000f2bb80=
0 00000000000088b8=0D
[17179569.792000] $20   : ffffffff805b1320 00000000000000ff a80000000f83fc0=
8 0000000014001fe1=0D
[17179569.792000] $24   : 0000000000000000 ffffffff8010eae8                =
                  =0D
[17179569.792000] $28   : a80000000f83c000 a80000000f83fb00 000000000000000=
e ffffffff80371a34=0D
[17179569.792000] Hi    : 0000000000040fff=0D
[17179569.792000] Lo    : ffffffffc69e0000=0D
[17179569.792000] epc   : ffffffff80373234 ide_read_status+0x3c/0x48=0D
[17179569.792000]     Not tainted=0D
[17179569.792000] ra    : ffffffff80371a34 ide_wait_not_busy+0xac/0x130=0D
[17179569.792000] Status: 14001fe3    KX SX UX KERNEL EXL IE =0D
[17179569.792000] Cause : 8080801c=0D
[17179569.792000] PrId  : 01040102 (SiByte SB1)=0D
[17179569.792000] Modules linked in:=0D
[17179569.792000] Process swapper (pid: 1, threadinfo=3Da80000000f83c000, t=
ask=3Da80000000f839798, tls=3D0000000000000000)=0D
[17179569.792000] Stack : 7ffffffffffff8f0 0000000000000000 000000000000000=
0 ffffffff805b0000=0D
[17179569.792000]         a80000000f2bb800 a80000000f2bb818 ffffffff8037561=
c 00000000000001f3=0D
[17179569.792000]         a80000000f2bb800 0000000000000000 000000000000000=
0 0000000000000004=0D
[17179569.792000]         0000000000000000 a80000000f2539e0 a80000000f83fc0=
8 ffffffff80540000=0D
[17179569.792000]         0000000000000000 ffffffff80376d88 000000000000000=
0 a80000000f83fc08=0D
[17179569.792000]         a80000000f2539e0 fffffffffffffff4 000000000000000=
0 ffffffff80510000=0D
[17179569.792000]         ffffffff80620000 ffffffff803772ac 00000000000001f=
0 0000000000000000=0D
[17179569.792000]         ffffffff80491eb0 ffffffff80491ec0 00000000000003f=
6 ffffffff805935f0=0D
[17179569.792000]         a80000000f0f5000 a80000000f83fc28 000000000000000=
0 0000000000000000=0D
[17179569.792000]         0000000000000000 00000000000001f0 00000000000001f=
1 00000000000001f2=0D
[17179569.792000]         ...=0D
[17179569.792000] Call Trace:=0D
[17179569.792000] [<ffffffff80373234>] ide_read_status+0x3c/0x48=0D
[17179569.792000] [<ffffffff80371a34>] ide_wait_not_busy+0xac/0x130=0D
[17179569.792000] [<ffffffff8037561c>] ide_probe_port+0xd4/0x678=0D
[17179569.792000] [<ffffffff80376d88>] ide_host_register+0x2c8/0x7a0=0D
[17179569.792000] [<ffffffff803772ac>] ide_host_add+0x4c/0xb8=0D
[17179569.792000] [<ffffffff805935f0>] ide_generic_init+0x2d0/0x3d0=0D
[17179569.792000] [<ffffffff8010e084>] __kprobes_text_end+0x34/0x1a0=0D
[17179569.792000] [<ffffffff805797ac>] kernel_init+0x21c/0x290=0D
[17179569.792000] [<ffffffff80110468>] kernel_thread_helper+0x10/0x18=0D
[17179569.792000] =0D
[17179569.792000] =0D
[17179569.792000] Code: dc448060  0064182d  90620000 <03e00008> 304200ff  0=
0000000  67bdff90  00052800  ffb40050 =0D
[17179570.076000] Kernel panic - not syncing: Attempted to kill init!=0D
[17179570.084000] Rebooting in 5 seconds..Passing control back to CFE...=0D
=0D
=0D
CFE version 1.0.40 for SWARM (64bit,MP,BE,MIPS)=0D
Build Date: Tue Jan 13 14:33:32 PST 2004 (mpl@lc-sj1-092.sj.broadcom.com)=0D
Copyright (C) 2000,2001,2002,2003 Broadcom Corporation.=0D
=0D
Initializing Arena.=0D
Initializing PCI. [normal]=0D
PCI bus 0 slot 1/0: Warning: SipReady already set=0D
HyperTransport not initialized: InitDone not set=0D
PCI bus 0 slot 0/0: SiByte, Inc. BCM1250 PCI Host Bridge (host bridge, rev =
0x02)=0D
PCI bus 0 slot 5/0: unknown vendor 0x3388 product 0x0021 (PCI bridge, rev 0=
x15)=0D
PCI bus 0 slot 7/0: Opti RM861HA (USB serial bus, interface 0x10, rev 0x10)=
=0D
PCI bus 1 slot 8/0: NEC USB Host Controller (USB serial bus, interface 0x10=
, rev 0x41)=0D
PCI bus 1 slot 8/1: NEC USB Host Controller (USB serial bus, interface 0x10=
, rev 0x41)=0D
PCI bus 1 slot 8/2: NEC product 0x00e0 (USB serial bus, interface 0x20, rev=
 0x02)=0D
PCI bus 1 slot 9/0: VIA Technologies product 0x3044 (Firewire serial bus, i=
nterface 0x10, rev 0x46)=0D
PCI bus 1 slot 10/0: CMD Technology product 0x0680 (RAID mass storage, rev =
0x02)=0D
Initializing Devices.=0D
SWARM board revision 3=0D
PCIIDE: 0 controllers found=0D
Config switch: 2=0D
CPU: BCM1250 B2=0D
L2 Cache Status: OK=0D
Wafer ID:   0x17326019  [Lot 1484, Wafer 19]=0D
Manuf Test: Bin A [2CPU_FI_FD_F2 (OK)] =0D
SysCfg: 0000000028DB0800 [PLL_DIV: 16, IOB0_DIV: CPUCLK/4, IOB1_DIV: CPUCLK=
/3]=0D
Initializing USB.=0D
PCI bus 0 slot 7/0: OHCI USB controller found at 61000000=0D
USB: Locating Class 09 Vendor 0000 Product 0000: USB Hub=0D
PCI bus 1 slot 8/0: OHCI USB controller found at 61181000=0D
USB: Locating Class 09 Vendor 0000 Product 0000: USB Hub=0D
PCI bus 1 slot 8/1: OHCI USB controller found at 61180000=0D
USB: Locating Class 09 Vendor 0000 Product 0000: USB Hub=0D
CPU type 0x1040102: 800MHz=0D
Total memory: 0x10000000 bytes (256MB)=0D
=0D
Total memory used by CFE:  0x8FE489C0 - 0x90000000 (1799744)=0D
Initialized Data:          0x8FE489C0 - 0x8FE54A60 (49312)=0D
BSS Area:                  0x8FE54A60 - 0x8FE55E70 (5136)=0D
Local Heap:                0x8FE55E70 - 0x8FF55E70 (1048576)=0D
Stack Area:                0x8FF55E70 - 0x8FF57E70 (8192)=0D
Text (code) segment:       0x8FF57E80 - 0x8FFFFFB8 (688440)=0D
Boot area (physical):      0x0FE07000 - 0x0FE47000=0D
Relocation Factor:         I:F0357E80 - D:0DF489C0=0D
=0D
CFE> =0D

--mYCpIKhGyMATD0i+--

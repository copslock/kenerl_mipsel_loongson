Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Feb 2015 20:46:29 +0100 (CET)
Received: from smtp.gentoo.org ([140.211.166.183]:47801 "EHLO smtp.gentoo.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27006526AbbBSTq1W2Lc5 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 19 Feb 2015 20:46:27 +0100
Received: from vapier (localhost [127.0.0.1])
        by smtp.gentoo.org (Postfix) with SMTP id 902CA34088B
        for <linux-mips@linux-mips.org>; Thu, 19 Feb 2015 19:46:17 +0000 (UTC)
Date:   Thu, 19 Feb 2015 14:46:17 -0500
From:   Mike Frysinger <vapier@gentoo.org>
To:     linux-mips@linux-mips.org
Subject: custom kernel on lemote-3a-itx (Loongson-3A) crashes in userspace
Message-ID: <20150219194617.GT544@vapier>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="LvvJQ0mOwKOuU4xd"
Content-Disposition: inline
Return-Path: <vapier@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45867
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vapier@gentoo.org
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


--LvvJQ0mOwKOuU4xd
Content-Type: multipart/mixed; boundary="iUdyFHenu1vPh/Ml"
Content-Disposition: inline


--iUdyFHenu1vPh/Ml
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

i've got a lemote desktop with a quad core Loongson-3A in it:
http://www.lemote.com/products/computer/fulong/348.html

i'm trying to build my own kernel for it, but userspace just crashes on me =
:(.

the current kernel is a precompiled one from lemote themselves, and things =
are=20
compiling/running fine with it.  but it's a bit stale and missing features =
i=20
want (like namespaces & seccomp).
$ uname -a
Linux lemote 3.5.0-9.lemote #1465 SMP PREEMPT Mon Aug 26 14:23:38 CST 2013 =
mips64 ICT Loongson-3A V0.5 FPU V0.1 lemote-3a-itx-a1101 GNU/Linux

the userland is Gentoo.  it's an o32/n32/n64 multilib with n32 as the defau=
lt. =20
most (if not all) of userland has been built with gcc-4.8.2 using
"-O2 -march=3Dmips64 -mplt -pipe".
$ file /bin/bash
/bin/bash: ELF 32-bit LSB executable, MIPS, N32 MIPS64 version 1 (SYSV), dy=
namically linked, interpreter /lib32/ld.so.1, for GNU/Linux 2.6.16, stripped
$ /lib/libc.so.6=20
GNU C Library (Gentoo 2.19-r1 p3) stable release version 2.19, by Roland Mc=
Grath et al.
Copyright (C) 2014 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.
There is NO warranty; not even for MERCHANTABILITY or FITNESS FOR A
PARTICULAR PURPOSE.
Compiled by GNU CC version 4.8.2.
Compiled on a Linux 3.14.0 system on 2014-09-09.
Available extensions:
        C stubs add-on version 2.1.2
        crypt add-on version 2.1 by Michael Glad and others
        GNU Libidn by Simon Josefsson
        Native POSIX Threads Library by Ulrich Drepper et al
        BIND-8.2.3-T5B
libc ABIs: MIPS_PLT UNIQUE
For bug reporting instructions, please see:
<http://bugs.gentoo.org/>.

i first tried lemote's sources, which i grabbed their git tree from=20
dev.lemote.com.  i started at the same git tag (3.5.0-9.lemote) and used th=
e=20
same .config as their precompiled kernel.  once it booted, most userland pr=
ogs=20
would crash.  some would survive (like simple ones), but most would crash.

i moved up to vanilla linux-3.18, starting with the same config, but got th=
e=20
same behavior.

i tried booting with the nofpu command line, but that didn't help.  i also=
=20
tried manually setting cpu_has_fpu to 0 in=20
arch/mips/include/asm/mach-loongson/cpu-feature-overrides.h, but that didn'=
t=20
help.

i tried gcc-4.7.4, gcc-4.8.4, and gcc-4.9.2, but none of that helped.

i enabled the debugging in arch/mips/mm/fault.c, and you can see the attach=
ed=20
dmesg with some of the example crashes.  when i looked at proc maps from ot=
her=20
binaries, it looks like those crashing addresses are close to real ones, bu=
t=20
slightly off (like a byte shift?).  i'm just guessing since i'm not actuall=
y=20
looking at the crashing app itself ... just assuming the maps are largely s=
table=20
(since they seem to be in other ones).

i tried to use strace/gdb to narrow things down, but those both crash early=
, so=20
couldn't get anywhere :).

any pointers ?
-mike

--iUdyFHenu1vPh/Ml
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment; filename=dmesg-crash
Content-Transfer-Encoding: quoted-printable

[    0.296875] pci_bus 0000:00: No busn resource found for root bus, will u=
se [bus 00-ff]
[    0.300781] pci 0000:00:00.0: [1022:9600] type 00 class 0x060000
[    0.300781] pci 0000:00:01.0: [1022:9602] type 01 class 0x060400
[    0.300781] pci 0000:00:02.0: [1022:9603] type 01 class 0x060400
[    0.300781] pci 0000:00:02.0: PME# supported from D0 D3hot D3cold
[    0.300781] pci 0000:00:03.0: [1022:960b] type 01 class 0x060400
[    0.300781] pci 0000:00:03.0: PME# supported from D0 D3hot D3cold
[    0.300781] pci 0000:00:04.0: [1022:9604] type 01 class 0x060400
[    0.300781] pci 0000:00:04.0: PME# supported from D0 D3hot D3cold
[    0.300781] pci 0000:00:09.0: [1022:9608] type 01 class 0x060400
[    0.300781] pci 0000:00:09.0: PME# supported from D0 D3hot D3cold
[    0.300781] pci 0000:00:0a.0: [1022:9609] type 01 class 0x060400
[    0.300781] pci 0000:00:0a.0: PME# supported from D0 D3hot D3cold
[    0.300781] pci 0000:00:11.0: [1002:4390] type 00 class 0x01018f
[    0.300781] pci 0000:00:11.0: reg 0x10: [io  0xb058-0xb05f]
[    0.300781] pci 0000:00:11.0: reg 0x14: [io  0xb050-0xb053]
[    0.300781] pci 0000:00:11.0: reg 0x18: [io  0xb048-0xb04f]
[    0.300781] pci 0000:00:11.0: reg 0x1c: [io  0xb040-0xb043]
[    0.300781] pci 0000:00:11.0: reg 0x20: [io  0xb010-0xb01f]
[    0.300781] pci 0000:00:11.0: reg 0x24: [mem 0x48709000-0x487093ff]
[    0.300781] pci 0000:00:11.0: set SATA to AHCI mode
[    0.300781] pci 0000:00:12.0: [1002:4397] type 00 class 0x0c0310
[    0.300781] pci 0000:00:12.0: reg 0x10: [mem 0x48708000-0x48708fff]
[    0.300781] pci 0000:00:12.1: [1002:4398] type 00 class 0x0c0310
[    0.300781] pci 0000:00:12.1: reg 0x10: [mem 0x48707000-0x48707fff]
[    0.300781] pci 0000:00:12.2: [1002:4396] type 00 class 0x0c0320
[    0.300781] pci 0000:00:12.2: reg 0x10: [mem 0x00000000-0x000000ff]
[    0.300781] pci 0000:00:12.2: supports D1 D2
[    0.300781] pci 0000:00:12.2: PME# supported from D0 D1 D2 D3hot
[    0.300781] pci 0000:00:13.0: [1002:4397] type 00 class 0x0c0310
[    0.300781] pci 0000:00:13.0: reg 0x10: [mem 0x48706000-0x48706fff]
[    0.300781] pci 0000:00:13.1: [1002:4398] type 00 class 0x0c0310
[    0.300781] pci 0000:00:13.1: reg 0x10: [mem 0x48705000-0x48705fff]
[    0.304687] pci 0000:00:13.2: [1002:4396] type 00 class 0x0c0320
[    0.304687] pci 0000:00:13.2: reg 0x10: [mem 0x00000000-0x000000ff]
[    0.304687] pci 0000:00:13.2: supports D1 D2
[    0.304687] pci 0000:00:13.2: PME# supported from D0 D1 D2 D3hot
[    0.304687] pci 0000:00:14.0: [1002:4385] type 00 class 0x0c0500
[    0.304687] pci 0000:00:14.1: [1002:439c] type 00 class 0x01018a
[    0.304687] pci 0000:00:14.1: reg 0x10: [io  0xb038-0xb03f]
[    0.304687] pci 0000:00:14.1: reg 0x14: [io  0xb030-0xb033]
[    0.304687] pci 0000:00:14.1: reg 0x18: [io  0xb028-0xb02f]
[    0.304687] pci 0000:00:14.1: reg 0x1c: [io  0xb020-0xb023]
[    0.304687] pci 0000:00:14.1: reg 0x20: [io  0xb000-0xb00f]
[    0.304687] pci 0000:00:14.1: legacy IDE quirk: reg 0x10: [io  0x01f0-0x=
01f7]
[    0.304687] pci 0000:00:14.1: legacy IDE quirk: reg 0x14: [io  0x03f6]
[    0.304687] pci 0000:00:14.1: legacy IDE quirk: reg 0x18: [io  0x0170-0x=
0177]
[    0.304687] pci 0000:00:14.1: legacy IDE quirk: reg 0x1c: [io  0x0376]
[    0.304687] pci 0000:00:14.2: [1002:4383] type 00 class 0x040300
[    0.304687] pci 0000:00:14.2: reg 0x10: [mem 0x48700000-0x48703fff 64bit]
[    0.304687] pci 0000:00:14.2: PME# supported from D0 D3hot D3cold
[    0.304687] pci 0000:00:14.3: [1002:439d] type 00 class 0x060100
[    0.304687] pci 0000:00:14.4: [1002:4384] type 01 class 0x060401
[    0.304687] pci 0000:00:14.5: [1002:4399] type 00 class 0x0c0310
[    0.304687] pci 0000:00:14.5: reg 0x10: [mem 0x48704000-0x48704fff]
[    0.304687] pci 0000:01:05.0: [1002:9615] type 00 class 0x030000
[    0.304687] pci 0000:01:05.0: reg 0x10: [mem 0x40000000-0x47ffffff pref]
[    0.304687] pci 0000:01:05.0: reg 0x14: [io  0xa000-0xa0ff]
[    0.304687] pci 0000:01:05.0: reg 0x18: [mem 0x48000000-0x4800ffff]
[    0.304687] pci 0000:01:05.0: supports D1 D2
[    0.304687] vgaarb: setting as boot device: PCI:0000:01:05.0
[    0.304687] vgaarb: device added: PCI:0000:01:05.0,decodes=3Dio+mem,owns=
=3Dio+mem,locks=3Dnone
[    0.304687] pci_bus 0000:01: busn_res: [bus 01-ff] end is updated to 01
[    0.304687] pci_bus 0000:02: busn_res: [bus 02-ff] end is updated to 02
[    0.304687] pci_bus 0000:03: busn_res: [bus 03-ff] end is updated to 03
[    0.304687] pci 0000:04:00.0: [10ec:8168] type 00 class 0x020000
[    0.304687] pci 0000:04:00.0: reg 0x10: [io  0x7000-0x70ff]
[    0.304687] pci 0000:04:00.0: reg 0x18: [mem 0x48424000-0x48424fff 64bit]
[    0.308593] pci 0000:04:00.0: reg 0x20: [mem 0x48420000-0x48423fff 64bit=
 pref]
[    0.308593] pci 0000:04:00.0: reg 0x30: [mem 0x48400000-0x4841ffff pref]
[    0.308593] pci 0000:04:00.0: supports D1 D2
[    0.308593] pci 0000:04:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.316406] pci_bus 0000:04: busn_res: [bus 04-ff] end is updated to 04
[    0.316406] pci_bus 0000:05: busn_res: [bus 05-ff] end is updated to 05
[    0.316406] pci_bus 0000:06: busn_res: [bus 06-ff] end is updated to 06
[    0.316406] pci_bus 0000:07: busn_res: [bus 07-ff] end is updated to 07
[    0.316406] pci_bus 0000:00: busn_res: [bus 00-ff] end is updated to 07
[    0.316406] pci 0000:00:01.0: BAR 8: assigned [mem 0x40000000-0x4bffffff]
[    0.316406] pci 0000:00:04.0: BAR 8: assigned [mem 0x4c000000-0x4c0fffff]
[    0.316406] pci 0000:00:04.0: BAR 9: assigned [mem 0x4c100000-0x4c1fffff=
 pref]
[    0.316406] pci 0000:00:14.2: BAR 0: assigned [mem 0x4c200000-0x4c203fff=
 64bit]
[    0.316406] pci 0000:00:01.0: BAR 7: assigned [io  0x4000-0x4fff]
[    0.316406] pci 0000:00:04.0: BAR 7: assigned [io  0x5000-0x5fff]
[    0.316406] pci 0000:00:12.0: BAR 0: assigned [mem 0x4c204000-0x4c204fff]
[    0.316406] pci 0000:00:12.1: BAR 0: assigned [mem 0x4c205000-0x4c205fff]
[    0.316406] pci 0000:00:13.0: BAR 0: assigned [mem 0x4c206000-0x4c206fff]
[    0.316406] pci 0000:00:13.1: BAR 0: assigned [mem 0x4c207000-0x4c207fff]
[    0.316406] pci 0000:00:14.5: BAR 0: assigned [mem 0x4c208000-0x4c208fff]
[    0.316406] pci 0000:00:11.0: BAR 5: assigned [mem 0x4c209000-0x4c2093ff]
[    0.316406] pci 0000:00:12.2: BAR 0: assigned [mem 0x4c209400-0x4c2094ff]
[    0.316406] pci 0000:00:13.2: BAR 0: assigned [mem 0x4c209500-0x4c2095ff]
[    0.316406] pci 0000:00:11.0: BAR 4: assigned [io  0x6000-0x600f]
[    0.316406] pci 0000:00:14.1: BAR 4: assigned [io  0x6010-0x601f]
[    0.316406] pci 0000:00:11.0: BAR 0: assigned [io  0x6020-0x6027]
[    0.316406] pci 0000:00:11.0: BAR 2: assigned [io  0x6028-0x602f]
[    0.316406] pci 0000:00:11.0: BAR 1: assigned [io  0x6030-0x6033]
[    0.316406] pci 0000:00:11.0: BAR 3: assigned [io  0x6034-0x6037]
[    0.316406] pci 0000:01:05.0: BAR 0: assigned [mem 0x40000000-0x47ffffff=
 pref]
[    0.316406] pci 0000:01:05.0: BAR 2: assigned [mem 0x48000000-0x4800ffff]
[    0.316406] pci 0000:01:05.0: BAR 1: assigned [io  0x4000-0x40ff]
[    0.316406] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.316406] pci 0000:00:01.0:   bridge window [io  0x4000-0x4fff]
[    0.316406] pci 0000:00:01.0:   bridge window [mem 0x40000000-0x4bffffff]
[    0.316406] pci 0000:00:02.0: PCI bridge to [bus 02]
[    0.316406] pci 0000:00:03.0: PCI bridge to [bus 03]
[    0.316406] pci 0000:04:00.0: BAR 6: assigned [mem 0x4c100000-0x4c11ffff=
 pref]
[    0.316406] pci 0000:04:00.0: BAR 4: assigned [mem 0x4c120000-0x4c123fff=
 64bit pref]
[    0.316406] pci 0000:04:00.0: BAR 2: assigned [mem 0x4c000000-0x4c000fff=
 64bit]
[    0.316406] pci 0000:04:00.0: BAR 0: assigned [io  0x5000-0x50ff]
[    0.316406] pci 0000:00:04.0: PCI bridge to [bus 04]
[    0.316406] pci 0000:00:04.0:   bridge window [io  0x5000-0x5fff]
[    0.316406] pci 0000:00:04.0:   bridge window [mem 0x4c000000-0x4c0fffff]
[    0.316406] pci 0000:00:04.0:   bridge window [mem 0x4c100000-0x4c1fffff=
 pref]
[    0.316406] pci 0000:00:09.0: PCI bridge to [bus 05]
[    0.316406] pci 0000:00:0a.0: PCI bridge to [bus 06]
[    0.316406] pci 0000:00:14.4: PCI bridge to [bus 07]
[    0.316406] pci 0000:00:02.0: Device 1022:9603, irq 0
[    0.316406] pci 0000:00:11.0: Device 1002:4390, irq 4
[    0.316406] pci 0000:00:12.0: Device 1002:4397, irq 6
[    0.316406] pci 0000:00:12.1: Device 1002:4398, irq 6
[    0.316406] pci 0000:00:12.2: Device 1002:4396, irq 6
[    0.316406] pci 0000:00:13.0: Device 1002:4397, irq 6
[    0.316406] pci 0000:00:13.1: Device 1002:4398, irq 6
[    0.316406] pci 0000:00:13.2: Device 1002:4396, irq 6
[    0.316406] pci 0000:00:14.1: Device 1002:439c, irq 0
[    0.316406] pci 0000:00:14.2: Device 1002:4383, irq 5
[    0.316406] pci 0000:00:14.5: Device 1002:4399, irq 6
[    0.316406] pci 0000:01:05.0: Device 1002:9615, irq 6
[    0.316406] pci 0000:04:00.0: Device 10ec:8168, irq 3
[    0.320312] Switched to clocksource MIPS
[    0.332031] NET: Registered protocol family 2
[    0.335937] TCP established hash table entries: 16384 (order: 3, 131072 =
bytes)
[    0.335937] TCP bind hash table entries: 16384 (order: 4, 262144 bytes)
[    0.335937] TCP: Hash tables configured (established 16384 bind 16384)
[    0.335937] TCP: reno registered
[    0.335937] UDP hash table entries: 1024 (order: 1, 32768 bytes)
[    0.335937] UDP-Lite hash table entries: 1024 (order: 1, 32768 bytes)
[    0.335937] NET: Registered protocol family 1
[    0.335937] PCI: Enabling device 0000:00:12.0 (0140 -> 0142)
[    0.390625] PCI: Enabling device 0000:00:12.1 (0140 -> 0142)
[    0.445312] PCI: Enabling device 0000:00:12.2 (0000 -> 0002)
[    0.445312] PCI: Enabling device 0000:00:13.0 (0140 -> 0142)
[    0.500000] PCI: Enabling device 0000:00:13.1 (0140 -> 0142)
[    0.554687] PCI: Enabling device 0000:00:13.2 (0000 -> 0002)
[    0.554687] pci 0000:01:05.0: BAR 6: assigned [??? 0xffffffff80104268-0x=
ffffffff80144267 flags 0x4] for Radeon ROM
[    0.554687] PCI: CLS 32 bytes, default 32
[    0.554687] futex hash table entries: 1024 (order: 1, 32768 bytes)
[    0.566406] msgmni has been set to 3892
[    0.566406] Block layer SCSI generic (bsg) driver version 0.4 loaded (ma=
jor 251)
[    0.566406] io scheduler noop registered
[    0.566406] io scheduler cfq registered (default)
[    0.570312] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
[    0.574218] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    0.574218] mach_irq_dispatch : spurious interrupt
[    0.593750] serial8250 serial8250.0: ttyS0 at MMIO 0x0 (irq =3D 58, base=
_baud =3D 1562500) is a 16550A
[    0.593750] [drm] Initialized drm 1.1.0 20060810
[    0.593750] [drm] radeon kernel modesetting enabled.
[    0.597656] [drm] initializing kernel modesetting (RS780 0x1002:0x9615 0=
x1002:0x0000).
[    0.597656] radeon: No suitable DMA available.
[    0.597656] [drm] register mmio base: 0x48000000
[    0.597656] [drm] register mmio size: 65536
[    0.597656] ATOM BIOS: BR041389
[    0.597656] radeon 0000:01:05.0: VRAM: 128M 0x0000000040000000 - 0x00000=
00047FFFFFF (128M used)
[    0.597656] radeon 0000:01:05.0: GTT: 512M 0x0000000048000000 - 0x000000=
0067FFFFFF
[    0.597656] [drm:rs690_pm_info] *ERROR* No integrated system info for yo=
ur GPU, using safe default
[    0.597656] [drm:radeon_atombios_sideport_present] *ERROR* Unsupported I=
GP table: 1 4
[    0.597656] [drm] Detected VRAM RAM=3D128M, BAR=3D128M
[    0.597656] [drm] RAM width 32bits DDR
[    0.597656] [TTM] Zone  kernel: Available graphics memory: 996592 kiB
[    0.597656] [TTM] Initializing pool allocator
[    0.597656] [TTM] Initializing DMA pool allocator
[    0.597656] [drm] radeon: 128M of VRAM memory ready
[    0.597656] [drm] radeon: 512M of GTT memory ready.
[    0.597656] [drm] Loading RS780 Microcode
[    0.597656] radeon 0000:01:05.0: Direct firmware load for radeon/RS780_u=
vd.bin failed with error -2
[    0.597656] radeon 0000:01:05.0: radeon_uvd: Can't load firmware "radeon=
/RS780_uvd.bin"
[    0.601562] [drm] GART: num cpu pages 32768, num gpu pages 131072
[    0.609375] [drm] PCIE GART of 512M enabled (table at 0x0000000040040000=
).
[    0.609375] radeon 0000:01:05.0: WB enabled
[    0.609375] radeon 0000:01:05.0: fence driver on ring 0 use gpu addr 0x0=
000000048000c00 and cpu addr 0x980000000f018c00
[    0.609375] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[    0.609375] [drm] Driver supports precise vblank timestamp query.
[    0.609375] radeon 0000:01:05.0: radeon: MSI limited to 32-bit
[    0.609375] [drm] radeon: irq initialized.
[    0.644531] [drm] ring test on 0 succeeded in 0 usecs
[    0.648437] [drm] ib test on ring 0 succeeded in 0 usecs
[    0.648437] [drm] Radeon Display Connectors
[    0.648437] [drm] Connector 0:
[    0.648437] [drm]   VGA-1
[    0.652343] [drm]   DDC: 0x7e40 0x7e40 0x7e44 0x7e44 0x7e48 0x7e48 0x7e4=
c 0x7e4c
[    0.652343] [drm]   Encoders:
[    0.652343] [drm]     CRT1: INTERNAL_KLDSCP_DAC1
[    0.652343] [drm] Connector 1:
[    0.652343] [drm]   DVI-I-1
[    0.652343] [drm]   HPD3
[    0.652343] [drm]   DDC: 0x7e50 0x7e50 0x7e54 0x7e54 0x7e58 0x7e58 0x7e5=
c 0x7e5c
[    0.652343] [drm]   Encoders:
[    0.652343] [drm]     DFP1: INTERNAL_KLDSCP_LVTMA
[    0.980468] [drm] fb mappable at 0x40144000
[    0.980468] [drm] vram apper at 0x40000000
[    0.980468] [drm] size 8306688
[    0.980468] [drm] fb depth is 24
[    0.980468] [drm]    pitch is 7680
[    1.582031] Console: switching to colour frame buffer device 240x67
[    2.136718] radeon 0000:01:05.0: fb0: radeondrmfb frame buffer device
[    2.136718] radeon 0000:01:05.0: registered panic notifier
[    2.167968] [drm] Initialized radeon 2.40.0 20080528 for 0000:01:05.0 on=
 minor 0
[    2.175781] brd: module loaded
[    2.183593] loop: module loaded
[    2.183593] megaraid cmm: 2.20.2.7 (Release Date: Sun Jul 16 00:01:03 ES=
T 2006)
[    2.187500] megaraid: 2.20.5.1 (Release Date: Thu Nov 16 15:32:35 EST 20=
06)
[    2.191406] megasas: 06.805.06.00-rc1 Thu. Sep. 4 17:00:00 PDT 2014
[    2.195312] ahci 0000:00:11.0: version 3.0
[    2.195312] ahci 0000:00:11.0: AHCI 0001.0100 32 slots 4 ports 3 Gbps 0x=
f impl SATA mode
[    2.199218] ahci 0000:00:11.0: flags: 64bit ncq sntf ilck pm led clo pmp=
 pio slum part ccc=20
[    2.203125] scsi host0: ahci
[    2.207031] scsi host1: ahci
[    2.207031] scsi host2: ahci
[    2.210937] scsi host3: ahci
[    2.210937] ata1: SATA max UDMA/133 abar m1024@0x4c209000 port 0x4c20910=
0 irq 4
[    2.214843] ata2: SATA max UDMA/133 abar m1024@0x4c209000 port 0x4c20918=
0 irq 4
[    2.218750] ata3: SATA max UDMA/133 abar m1024@0x4c209000 port 0x4c20920=
0 irq 4
[    2.218750] ata4: SATA max UDMA/133 abar m1024@0x4c209000 port 0x4c20928=
0 irq 4
[    2.226562] scsi host4: pata_atiixp
[    2.226562] scsi host5: pata_atiixp
[    2.230468] ata5: PATA max UDMA/100 cmd 0x1f0 ctl 0x3f6 bmdma 0x6010 irq=
 14
[    2.230468] ata6: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0x6018 irq=
 15
[    2.234375] e1000: Intel(R) PRO/1000 Network Driver - version 7.3.21-k8-=
NAPI
[    2.238281] e1000: Copyright (c) 1999-2006 Intel Corporation.
[    2.242187] e1000e: Intel(R) PRO/1000 Network Driver - 2.3.2-k
[    2.242187] e1000e: Copyright(c) 1999 - 2014 Intel Corporation.
[    2.246093] igb: Intel(R) Gigabit Ethernet Network Driver - version 5.2.=
15-k
[    2.250000] igb: Copyright (c) 2007-2014 Intel Corporation.
[    2.250000] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    2.253906] ehci-pci: EHCI PCI platform driver
[    2.257812] ehci-pci 0000:00:12.2: EHCI Host Controller
[    2.257812] ehci-pci 0000:00:12.2: new USB bus registered, assigned bus =
number 1
[    2.261718] ehci-pci 0000:00:12.2: applying AMD SB700/SB800/Hudson-2/3 E=
HCI dummy qh workaround
[    2.265625] ehci-pci 0000:00:12.2: debug port 1
[    2.265625] ehci-pci 0000:00:12.2: irq 6, io mem 0x4c209400
[    2.281250] ehci-pci 0000:00:12.2: USB 2.0 started, EHCI 1.00
[    2.281250] hub 1-0:1.0: USB hub found
[    2.375000] hub 1-0:1.0: 6 ports detected
[    2.468750] ehci-pci 0000:00:13.2: EHCI Host Controller
[    2.542968] ata4: SATA link down (SStatus 0 SControl 300)
[    2.542968] ata1: SATA link down (SStatus 0 SControl 300)
[    2.542968] ata2: SATA link down (SStatus 0 SControl 300)
[    2.714843] ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    2.714843] ata3.00: ATA-8: WDC WD3200BPVT-26JJ5T0, 01.01A01, max UDMA/1=
33
[    2.714843] ata3.00: 625142448 sectors, multi 16: LBA48 NCQ (depth 31/32=
), AA
[    2.714843] ata3.00: configured for UDMA/133
[    2.718750] scsi 2:0:0:0: Direct-Access     ATA      WDC WD3200BPVT-2 1A=
01 PQ: 0 ANSI: 5
[    2.718750] sd 2:0:0:0: [sda] 625142448 512-byte logical blocks: (320 GB=
/298 GiB)
[    2.718750] sd 2:0:0:0: [sda] 4096-byte physical blocks
[    2.718750] sd 2:0:0:0: Attached scsi generic sg0 type 0
[    2.718750] sd 2:0:0:0: [sda] Write Protect is off
[    2.718750] sd 2:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    2.718750] sd 2:0:0:0: [sda] Write cache: enabled, read cache: enabled,=
 doesn't support DPO or FUA
[    2.750000]  sda: sda1 sda2 sda3 sda4
[    2.750000] sd 2:0:0:0: [sda] Attached SCSI disk
[    3.964843] ehci-pci 0000:00:13.2: new USB bus registered, assigned bus =
number 2
[    4.066406] ehci-pci 0000:00:13.2: applying AMD SB700/SB800/Hudson-2/3 E=
HCI dummy qh workaround
[    4.167968] ehci-pci 0000:00:13.2: debug port 1
[    4.265625] ehci-pci 0000:00:13.2: irq 6, io mem 0x4c209500
[    4.378906] ehci-pci 0000:00:13.2: USB 2.0 started, EHCI 1.00
[    4.480468] hub 2-0:1.0: USB hub found
[    4.582031] hub 2-0:1.0: 6 ports detected
[    4.683593] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    4.785156] ohci-pci: OHCI PCI platform driver
[    4.890625] ohci-pci 0000:00:12.0: OHCI PCI host controller
[    4.992187] ohci-pci 0000:00:12.0: new USB bus registered, assigned bus =
number 3
[    5.093750] ohci-pci 0000:00:12.0: irq 6, io mem 0x4c204000
[    5.253906] hub 3-0:1.0: USB hub found
[    5.355468] hub 3-0:1.0: 3 ports detected
[    5.453125] ohci-pci 0000:00:12.1: OHCI PCI host controller
[    5.554687] ohci-pci 0000:00:12.1: new USB bus registered, assigned bus =
number 4
[    5.652343] ohci-pci 0000:00:12.1: irq 6, io mem 0x4c205000
[    5.808593] hub 4-0:1.0: USB hub found
[    5.902343] hub 4-0:1.0: 3 ports detected
[    6.000000] ohci-pci 0000:00:13.0: OHCI PCI host controller
[    6.101562] ohci-pci 0000:00:13.0: new USB bus registered, assigned bus =
number 5
[    6.203125] ohci-pci 0000:00:13.0: irq 6, io mem 0x4c206000
[    6.363281] hub 5-0:1.0: USB hub found
[    6.464843] hub 5-0:1.0: 3 ports detected
[    6.566406] ohci-pci 0000:00:13.1: OHCI PCI host controller
[    6.671875] ohci-pci 0000:00:13.1: new USB bus registered, assigned bus =
number 6
[    6.773437] ohci-pci 0000:00:13.1: irq 6, io mem 0x4c207000
[    6.937500] hub 6-0:1.0: USB hub found
[    7.039062] hub 6-0:1.0: 3 ports detected
[    7.144531] usb 5-2: new low-speed USB device number 2 using ohci-pci
[    7.160156] ohci-pci 0000:00:14.5: OHCI PCI host controller
[    7.355468] ohci-pci 0000:00:14.5: new USB bus registered, assigned bus =
number 7
[    7.460937] ohci-pci 0000:00:14.5: irq 6, io mem 0x4c208000
[    7.625000] hub 7-0:1.0: USB hub found
[    7.726562] hub 7-0:1.0: 2 ports detected
[    8.347656] i8042: i8042 controller selftest timeout
[    8.449218] mousedev: PS/2 mouse device common for all mice
[    8.554687] rtc_cmos rtc_cmos: rtc core: registered rtc_cmos as rtc0
[    8.656250] rtc_cmos rtc_cmos: alarms up to one day, 114 bytes nvram
[    8.761718] i2c /dev entries driver
[    8.863281] piix4_smbus 0000:00:14.0: SMBus Host Controller at 0x1000, r=
evision 0
[    8.976562] input: Primax HP USB Keyboard as /devices/pci0000:00/0000:00=
:13.0/usb5/5-2/5-2:1.0/0003:03F0:064A.0001/input/input0
[    9.085937] hid-generic 0003:03F0:064A.0001: input: USB HID v1.10 Keyboa=
rd [Primax HP USB Keyboard] on usb-0000:00:13.0-2/input0
[    9.203125] input: Primax HP USB Keyboard as /devices/pci0000:00/0000:00=
:13.0/usb5/5-2/5-2:1.1/0003:03F0:064A.0002/input/input1
[    9.320312] hid-generic 0003:03F0:064A.0002: input: USB HID v1.10 Device=
 [Primax HP USB Keyboard] on usb-0000:00:13.0-2/input1
[    9.437500] usbcore: registered new interface driver usbhid
[    9.558593] usbhid: USB HID core driver
[    9.675781] TCP: cubic registered
[    9.792968] Initializing XFRM netlink socket
[    9.917968] NET: Registered protocol family 10
[   10.039062] NET: Registered protocol family 17
[   10.156250] NET: Registered protocol family 15
[   10.273437] Key type dns_resolver registered
[   10.390625] rtc_cmos rtc_cmos: setting system clock to 2015-02-05 07:18:=
00 UTC (1423120680)
[   10.871093] EXT4-fs (sda4): mounted filesystem with ordered data mode. O=
pts: (null)
[   10.992187] VFS: Mounted root (ext4 filesystem) on device 8:4.
[   11.160156] random: nonblocking pool is initialized
[   11.281250] devtmpfs: mounted
[   11.402343] Freeing unused kernel memory: 256K (ffffffff80a40000 - fffff=
fff80a80000)
[   12.707031] do_page_fault() #2: sending SIGSEGV to cp for invalid write =
access to
0000000010050afc (epc =3D=3D 0000000077330310, ra =3D=3D 00000000773306d8)
[   13.683593] do_page_fault() #2: sending SIGSEGV to awk for invalid write=
 access to
00000000100a0004 (epc =3D=3D 0000000077a3c7e0, ra =3D=3D 0000000077a3c7a8)
[   14.644531] do_page_fault() #2: sending SIGSEGV to systemd-udevd for inv=
alid write access to
000000007fba8d38 (epc =3D=3D 00000000771fde9c, ra =3D=3D 0000000077233bac)
[   14.644531] do_page_fault() #2: sending SIGSEGV to systemd-udevd for inv=
alid write access to
000000007fba8d28 (epc =3D=3D 000000007730abac, ra =3D=3D 0000000077233af0)
[   14.789062] BUG: Bad rss-counter state mm:980000017f367900 idx:1 val:1
[   16.898437] do_page_fault() #2: sending SIGSEGV to fsck for invalid read=
 access from
0000000010017234 (epc =3D=3D 0000000076fc2788, ra =3D=3D 0000000076fc2898)
[   17.945312] do_page_fault() #2: sending SIGSEGV to fsck for invalid read=
 access from
0000000010017234 (epc =3D=3D 000000007725e788, ra =3D=3D 000000007725e898)
[   18.792968] do_page_fault() #2: sending SIGSEGV to ls for invalid write =
access to
0000000010030004 (epc =3D=3D 00000000771f47e0, ra =3D=3D 00000000771f47a8)
[   19.511718] do_page_fault() #2: sending SIGSEGV to bash for invalid writ=
e access to
00000000100c0004 (epc =3D=3D 0000000077a347e0, ra =3D=3D 0000000077a347a8)
[   19.558593] do_page_fault() #2: sending SIGSEGV to bash for invalid writ=
e access to
00000000100c0004 (epc =3D=3D 000000007759c7e0, ra =3D=3D 000000007759c7a8)
[   19.605468] do_page_fault() #2: sending SIGSEGV to bash for invalid writ=
e access to
00000000100c0004 (epc =3D=3D 00000000770b47e0, ra =3D=3D 00000000770b47a8)
[   19.652343] do_page_fault() #2: sending SIGSEGV to bash for invalid writ=
e access to
00000000100c0004 (epc =3D=3D 0000000077d447e0, ra =3D=3D 0000000077d447a8)
[   19.695312] do_page_fault() #2: sending SIGSEGV to bash for invalid writ=
e access to
00000000100c0004 (epc =3D=3D 0000000077a547e0, ra =3D=3D 0000000077a547a8)
[   19.742187] do_page_fault() #2: sending SIGSEGV to bash for invalid writ=
e access to
00000000100c0004 (epc =3D=3D 00000000778347e0, ra =3D=3D 00000000778347a8)
[   19.785156] do_page_fault() #2: sending SIGSEGV to bash for invalid writ=
e access to
00000000100c0004 (epc =3D=3D 00000000773307e0, ra =3D=3D 00000000773307a8)
[   19.828125] do_page_fault() #2: sending SIGSEGV to bash for invalid writ=
e access to
00000000100c0004 (epc =3D=3D 00000000778387e0, ra =3D=3D 00000000778387a8)
[   19.875000] do_page_fault() #2: sending SIGSEGV to bash for invalid writ=
e access to
00000000100c0004 (epc =3D=3D 00000000776e47e0, ra =3D=3D 00000000776e47a8)
[   19.921875] do_page_fault() #2: sending SIGSEGV to bash for invalid writ=
e access to
00000000100c0004 (epc =3D=3D 00000000777c07e0, ra =3D=3D 00000000777c07a8)
[  136.812500] do_page_fault() #2: sending SIGSEGV to bash for invalid writ=
e access to
00000000100c0004 (epc =3D=3D 0000000077bdc7e0, ra =3D=3D 0000000077bdc7a8)

--iUdyFHenu1vPh/Ml--

--LvvJQ0mOwKOuU4xd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJU5j2JAAoJEEFjO5/oN/WBvn8P/i8tu9iBM2us2gaZxQuPinn1
HPoImc6lIVgY8FlEBLr3gEZHtXGyjoJF/VGyAG6HobwfeiEW5JBirxY/gzSSHy0/
2pJIYnpfWY3zOAywIcOFJjOdeybTJ+3hOXEACYOAM38NhLPhSXaChxy12joRI6f6
oEzU2GZ6472SMQAZDCyNUzD9Ak+J/SOQaJiL5fmGmuQlnelg4KL6glEd59LP0xWN
6/exGnXUnPHxZSvsgXzS01K1pn6VNFkZ4Sfl+slLJ2Rn5wHGvHCIX2ClOKc1X1DL
Zq7FGWP77V//nrcbsqHwoxnUZFrKu5cokvthk96LKX9wi+7Qh8AeRVFS+K2FFiAZ
B12QhoXqkADxLL1zv9/ma3v1sqP7Lu/fOCHTf+FnLEI9JBVX4uUo1nzrUxDSLj2w
7Ve+iLeCAcojth0HHvSKcNT1s/EX+mJHPc1t5XlUCN9gXAO+EBAnjHMDefuZg5pf
znkaeRd+Y2nOI6vOC6v5akp3DtVOQcSS5VaNAhT3XbqEF+EkGCdrtmuOfRSNI3ke
q1/YWgmSgm1esvGZ4QYwfj9lk8p5upvzR7BGBpRUSfsxD+JK9gHKs4KILNTRvBJm
4ya7bloBO4bs+St795hWSrA1tQh0D572MwXx2pSQzX6bwgBJt7fsgEjv0aI2th/X
BE9ar6/UJasx5jf/iexG
=nvvp
-----END PGP SIGNATURE-----

--LvvJQ0mOwKOuU4xd--

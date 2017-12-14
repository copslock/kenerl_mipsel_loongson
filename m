Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 Dec 2017 16:23:12 +0100 (CET)
Received: from 9pmail.ess.barracuda.com ([64.235.150.225]:43632 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990398AbdLNPXEa0Beq (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 14 Dec 2017 16:23:04 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx3.ess.sfj.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Thu, 14 Dec 2017 15:22:48 +0000
Received: from localhost (192.168.154.110) by MIPSMAIL01.mipstec.com
 (10.20.43.31) with Microsoft SMTP Server (TLS) id 14.3.361.1; Thu, 14 Dec
 2017 07:21:40 -0800
Date:   Thu, 14 Dec 2017 15:21:38 +0000
From:   James Hogan <james.hogan@mips.com>
To:     Yuri Frolov <crashing.kernel@gmail.com>
CC:     <linux-mips@linux-mips.org>, <paul.burton@mips.com>
Subject: Re: [P5600 && EVA memory caching question] PCI region
Message-ID: <20171214152138.GV5027@jhogan-linux.mipstec.com>
References: <6132c323-32a7-1d38-b77c-a191be22faa4@gmail.com>
 <20171206114611.GM5027@jhogan-linux.mipstec.com>
 <330a5200-531f-fcfa-674a-c81fb3144e92@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="iRaAnoDFBoP0sW/E"
Content-Disposition: inline
In-Reply-To: <330a5200-531f-fcfa-674a-c81fb3144e92@gmail.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
X-Originating-IP: [192.168.154.110]
X-BESS-ID: 1513264967-298554-6819-42369-3
X-BESS-VER: 2017.14-r1710272128
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 1.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.187972
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
        1.00 BSF_SC0_MV0240         BODY: Custom rule MV0240 
X-BESS-Outbound-Spam-Status: SCORE=1.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND, BSF_SC0_MV0240
X-BESS-BRTS-Status: 1
Return-Path: <James.Hogan@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61468
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@mips.com
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

--iRaAnoDFBoP0sW/E
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Yuri,

On Thu, Dec 14, 2017 at 06:03:11PM +0300, Yuri Frolov wrote:
> Hi, James.
>=20
> Do I understand correctly, that in case of CONFIG_EVA=3Dy, any logical=20
> address from 0x00000000 - 0xBFFFFFFF (3G) range accessed from the kernel=
=20
> space is:
> 1) Unmapped (no TLB translations)
> 2) Is mapped 1:1 to physical addresses? E.g, readl from 0x20000000 is,=20
> in fact a read from physical address 0x20000000? I mean, in legacy=20
> memory mapping scheme, logical addresses 0x80000000 - 0xBFFFFFFF in=20
> kernel space were being translated to the physical addresses from the=20
> low 512Mb (phys 0x00000000 - 0x20000000), no such bits stripping or=20
> something for EVA, the mapping is 1:1?

That depends on the EVA configuration. The hardware is fairly flexible
(which is both useful and painful - making supporting EVA from
multiplatform kernels particularly awkward), but that is one possible
configuration.

E.g. ideally you probably want to keep seg5 (0x00000000..0x3FFFFFFF)
MUSK (TLB mapped for user & kernel) so that null dereferences from
kernel code are safely caught, but that costs you 1GB of directly
accessible physical address space from kernel mode.

>=20
> As for userspace addresses, the addresses from the 0x00000000 -=20
> 0xBFFFFFFF range are:
> 1) Overlayed with the range which is directly accessible from the kernel=
=20
> space

Yes. Userland accesses access through tlb, kernel direct, and kernel eva
accesses (LWE/SWE etc) access through tlb from kernel

> 2) These addresses are mapped in userland, so, read from logical address=
=20
> 0x20000000 in userland may result in read from any physical address=20
> located in range 0x00000000 - 0xBFFFFFFF as defined by TLB for that=20
> particular userland thread?

Yes, though it could in theory be any physical address mapped by the
TLB, not just that range.

Cheers
James

>=20
> TIA,
> Yuri
>=20
> On 12/06/2017 02:46 PM, James Hogan wrote:
> > Hi Yuri,
> >
> > On Wed, Dec 06, 2017 at 01:36:48PM +0300, Yuri Frolov wrote:
> >> Hi,
> >>
> >> I'm trying to expand PCI mapped region using EVA addressing scheme for
> >> 'Baikal' P5600-based family of boards.
> >>
> >> Currently, we've got only one PCIe mapped region, 0x08000000 -
> >> 0x1BDBFFFF (~330Mb).
> >>
> >> This window is unsufficient for some PCIe cards, so I'm trying to expa=
nd
> >> (or add one more) PCIe mapped region by moving 'Hi Memory DRAM block'
> >> from 0x20000000 to 0x40000000 (dts changed, BAIKAL_HIGHMEM_START and
> >> HIGHMEM_START are changed in
> >> arch/mips/include/asm/mach-baikal/hardware.h
> >> /arch/mips/include/asm/mach-baikal/spaces.h respectively) and and
> >> allocating this region for PCIe.
> >>
> >> So far, PCI subsystem is initialized during the boot successfully (as
> >> far as I can see):
> >>
> >> dw_pcie_init: DEV_ID_VEND_ID=3D0x80601d39 CLASS_CODE_REV_ID=3D0x1
> >> dw_pcie_init: PCIe error code =3D 0x0
> >> dw_pcie_init: PCIe link speed GEN1
> >> device: 'pci0000:01': device_add
> >> PM: Adding info for No Bus:pci0000:01
> >> device: '0000:01': device_add
> >> PM: Adding info for No Bus:0000:01
> >> PCI host bridge to bus 0000:01
> >> pci_bus 0000:01: root bus resource [mem 0x20000000-0x37ffffff]
> >> pci_bus 0000:01: root bus resource [io=C2=A0 0x18020000-0x1bdaffff]
> >> pci_bus 0000:01: root bus resource [bus 01-ff]
> >> pci_bus 0000:01: scanning bus
> >> pci 0000:01:00.0: [8086:10d3] type 00 class 0x020000
> >> pci 0000:01:00.0: calling quirk_f0_vpd_link+0x0/0x98
> >> pci 0000:01:00.0: reg 0x10: [mem 0x00000000-0x0001ffff]
> >> pci 0000:01:00.0: reg 0x14: [mem 0x00000000-0x0007ffff]
> >> pci 0000:01:00.0: reg 0x18: [io=C2=A0 0x0000-0x001f]
> >> pci 0000:01:00.0: reg 0x1c: [mem 0x00000000-0x00003fff]
> >> pci 0000:01:00.0: reg 0x30: [mem 0x00000000-0x0003ffff pref]
> >> pci 0000:01:00.0: PME# supported from D0 D3hot D3cold
> >>
> >> pci 0000:01:00.0: PME# disabled
> >> device: '0000:01:00.0': device_add
> >> bus: 'pci': add device 0000:01:00.0
> >> PM: Adding info for pci:0000:01:00.0
> >> pci_bus 0000:01: fixups for bus
> >> pci_bus 0000:01: bus scan returning with max=3D01
> >> pci 0000:01:00.0: BAR 1: assigned [mem 0x20000000-0x2007ffff]
> >> pci 0000:01:00.0: BAR 6: assigned [mem 0x20080000-0x200bffff pref]
> >> pci 0000:01:00.0: BAR 0: assigned [mem 0x200c0000-0x200dffff]
> >> pci 0000:01:00.0: BAR 3: assigned [mem 0x200e0000-0x200e3fff]
> >> pci 0000:01:00.0: BAR 2: assigned [io=C2=A0 0x18020000-0x1802001f]
> >> pci 0000:01:00.0: calling quirk_e100_interrupt+0x0/0x20c
> >> pci 0000:01:00.0: calling baikal_t1_pcie_link_speed_fixup+0x0/0x228
> >> pci 0000:01:00.0: Link Capability is GEN1, x1
> >>
> >> but PCIe networking card (e1000e) driver fails to load:
> >>
> >> bus: 'pci': driver_probe_device: matched device 0000:01:00.0 with driv=
er
> >> e1000e
> >> bus: 'pci': really_probe: probing driver e1000e with device 0000:01:00=
=2E0
> >> devices_kset: Moving 0000:01:00.0 to end of list
> >> PCI: Enabling device 0000:01:00.0 (0000 -> 0002)
> >> e1000e 0000:01:00.0: enabling bus mastering
> >> e1000_probe:7054 mmio_start 0x200c0000 mmio_len 0x20000
> >>
> >> e1000e 0000:01:00.0: Interrupt Throttling Rate (ints/sec) set to dynam=
ic
> >> conservative mode
> >>
> >> PCI MSI: setup hwirq:0=C2=A0 virq:51
> >> PCI MSI: setup hwirq:1=C2=A0 virq:52
> >> PCI MSI: setup hwirq:2=C2=A0 virq:53
> >>
> >> e1000_get_phy_id_82571:444 ret_val =3D e1e_rphy(hw, MII_PHYSID1, &phy_=
id);
> >> ret_val =3D -2
> >>
> >> It turns out, that PHY ID can't be read from the memory, mapped on
> >> driver initialization function by ioremap.
> >>
> >>   =C2=A0__ioremap (arch/mips/mm/ioremap.c) considers all the memory ab=
ove the
> >> low 512Mb as DRAM and maps the physical addresses 0x20000000 -
> >> 0x3FFFFFFF to logical addresses starting from c0000000 and higher.
> >>
> >> arch/mips/include/asm/mach-baikal/kernel-entry-init.h defines EVA memo=
ry
> >> map with virtual addresses range 0xc0000000 - 0xdfffffff as 'MK (kseg2=
)'
> >> i.e. "mapped kernel" with cashing segment attributes defined in SegCtl=
0,
> >> Cfg1: "cacheable, coherent, write-back, write-allocate, read misses
> >> request shared attribute".
> >>
> >> I've tried to change the caching attribute (bits 16:18 in SegCtl0) to
> >> 0x2 ("uncached, not coherent"), but
> >>
> >> this hasn't yield any visible effect on PCIe e1000e initialization.
> > Mapped kernel segments don't use the CCA in SegCtl. Each page mapping
> > has its own CCA specified in the TLB, which would have been loaded from
> > page tables set up by e.g. remap_area_pte(), and the ioremap() macro
> > does pass _CACHE_UNCACHED as the flags argument. I would recommend
> > checking the phys_addr and flags coming in to remap_area_pte().
> >
> > If that all looks correct you could also try:
> > - Dump the TLB contents straight after accessing that address to check
> >    they are loaded correctly, i.e. call dump_tlb_all() from
> >    <asm/tlbdebug.h>.
> > - If the TLB contents look wrong, try disabling hardware page table
> >    walker to determine whether that is misconfigured (add nohtw to kern=
el
> >    command line).
> >
> > Hope that helps
> >
> > Cheers
> > James
>=20

--iRaAnoDFBoP0sW/E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAloylvsACgkQbAtpk944
dnqJSw/+NbRHAzOmGhsNDdo3fkg9FKMIluc+FXsWC+JCwOCrCrJbe9Dwr3Z/bOaF
GfxFY/quqP9PKa5N8nbdrUt0h+ARXseFXLHEIaVkt5OtysEOA277vWXOn/ENXp0f
imnZm6IrnalvPSnlbZYD70WKxpFL741LIK/8sIRjRR+lT+77VefwM3/WtU5vz6U0
xbQZFBxF2AU2kPYbRCFchJvelmN6dKEqCGYsUsvs1v68yH7xqTSEmdXCUx4bkk3p
ovu0XL/SR9UmkVIt0CYHd94FQLhXJUXPF92ShmuQ9fsCdx+Y1WQC7LKvvDsMqD34
HJpbPSMUWwDYeubbgBQ0OLzgFZFpkIgBktb+v3W4ten8SKCL+TqNziSaj31tuzZ5
RBL/olvgkWR5yHJmFx5PpwmgxfP9nMAybjZuUWTvR2p1yI3vAqoZyRkeET4Nfiu3
GlBzNDFxuWPOmuCSvcoKqBmK7aF7JfJ0UhgzsWLQWeTk0X8KO9aIM001nluxLT3s
ZQwfdeOlO6Xs++9nQmNdNsuYfXs5gbwaZrS0fgOdcrPS7jopJKVmuvgQw+cGKRsh
rrA1uQUN0UGbI1ayDINM5NbRlSbLTwE7z0u1hEFSsU8/jfl0tVAHh8ZsScp/4DDU
BltVTWjzLWd2zwWua+64HCzlBDyVof3VKhBUCpTGcUXv13ip1Bk=
=Wert
-----END PGP SIGNATURE-----

--iRaAnoDFBoP0sW/E--

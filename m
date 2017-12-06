Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Dec 2017 12:47:02 +0100 (CET)
Received: from 9pmail.ess.barracuda.com ([64.235.154.211]:32965 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990402AbdLFLqz63qk6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 6 Dec 2017 12:46:55 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx1401.ess.rzc.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Wed, 06 Dec 2017 11:46:41 +0000
Received: from localhost (192.168.154.110) by MIPSMAIL01.mipstec.com
 (10.20.43.31) with Microsoft SMTP Server (TLS) id 14.3.361.1; Wed, 6 Dec 2017
 03:46:13 -0800
Date:   Wed, 6 Dec 2017 11:46:11 +0000
From:   James Hogan <james.hogan@mips.com>
To:     Yuri Frolov <crashing.kernel@gmail.com>
CC:     <linux-mips@linux-mips.org>, <paul.burton@mips.com>
Subject: Re: [P5600 && EVA memory caching question] PCI region
Message-ID: <20171206114611.GM5027@jhogan-linux.mipstec.com>
References: <6132c323-32a7-1d38-b77c-a191be22faa4@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="PY8tzLeNxmyMVNR3"
Content-Disposition: inline
In-Reply-To: <6132c323-32a7-1d38-b77c-a191be22faa4@gmail.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
X-Originating-IP: [192.168.154.110]
X-BESS-ID: 1512560800-321457-11056-59866-12
X-BESS-VER: 2017.14-r1710272128
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 1.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.187673
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
X-archive-position: 61319
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

--PY8tzLeNxmyMVNR3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Yuri,

On Wed, Dec 06, 2017 at 01:36:48PM +0300, Yuri Frolov wrote:
> Hi,
>=20
> I'm trying to expand PCI mapped region using EVA addressing scheme for=20
> 'Baikal' P5600-based family of boards.
>=20
> Currently, we've got only one PCIe mapped region, 0x08000000 -=20
> 0x1BDBFFFF (~330Mb).
>=20
> This window is unsufficient for some PCIe cards, so I'm trying to expand=
=20
> (or add one more) PCIe mapped region by moving 'Hi Memory DRAM block'=20
> from 0x20000000 to 0x40000000 (dts changed, BAIKAL_HIGHMEM_START and=20
> HIGHMEM_START are changed in=20
> arch/mips/include/asm/mach-baikal/hardware.h=20
> /arch/mips/include/asm/mach-baikal/spaces.h respectively) and and=20
> allocating this region for PCIe.
>=20
> So far, PCI subsystem is initialized during the boot successfully (as=20
> far as I can see):
>=20
> dw_pcie_init: DEV_ID_VEND_ID=3D0x80601d39 CLASS_CODE_REV_ID=3D0x1
> dw_pcie_init: PCIe error code =3D 0x0
> dw_pcie_init: PCIe link speed GEN1
> device: 'pci0000:01': device_add
> PM: Adding info for No Bus:pci0000:01
> device: '0000:01': device_add
> PM: Adding info for No Bus:0000:01
> PCI host bridge to bus 0000:01
> pci_bus 0000:01: root bus resource [mem 0x20000000-0x37ffffff]
> pci_bus 0000:01: root bus resource [io=C2=A0 0x18020000-0x1bdaffff]
> pci_bus 0000:01: root bus resource [bus 01-ff]
> pci_bus 0000:01: scanning bus
> pci 0000:01:00.0: [8086:10d3] type 00 class 0x020000
> pci 0000:01:00.0: calling quirk_f0_vpd_link+0x0/0x98
> pci 0000:01:00.0: reg 0x10: [mem 0x00000000-0x0001ffff]
> pci 0000:01:00.0: reg 0x14: [mem 0x00000000-0x0007ffff]
> pci 0000:01:00.0: reg 0x18: [io=C2=A0 0x0000-0x001f]
> pci 0000:01:00.0: reg 0x1c: [mem 0x00000000-0x00003fff]
> pci 0000:01:00.0: reg 0x30: [mem 0x00000000-0x0003ffff pref]
> pci 0000:01:00.0: PME# supported from D0 D3hot D3cold
>=20
> pci 0000:01:00.0: PME# disabled
> device: '0000:01:00.0': device_add
> bus: 'pci': add device 0000:01:00.0
> PM: Adding info for pci:0000:01:00.0
> pci_bus 0000:01: fixups for bus
> pci_bus 0000:01: bus scan returning with max=3D01
> pci 0000:01:00.0: BAR 1: assigned [mem 0x20000000-0x2007ffff]
> pci 0000:01:00.0: BAR 6: assigned [mem 0x20080000-0x200bffff pref]
> pci 0000:01:00.0: BAR 0: assigned [mem 0x200c0000-0x200dffff]
> pci 0000:01:00.0: BAR 3: assigned [mem 0x200e0000-0x200e3fff]
> pci 0000:01:00.0: BAR 2: assigned [io=C2=A0 0x18020000-0x1802001f]
> pci 0000:01:00.0: calling quirk_e100_interrupt+0x0/0x20c
> pci 0000:01:00.0: calling baikal_t1_pcie_link_speed_fixup+0x0/0x228
> pci 0000:01:00.0: Link Capability is GEN1, x1
>=20
> but PCIe networking card (e1000e) driver fails to load:
>=20
> bus: 'pci': driver_probe_device: matched device 0000:01:00.0 with driver=
=20
> e1000e
> bus: 'pci': really_probe: probing driver e1000e with device 0000:01:00.0
> devices_kset: Moving 0000:01:00.0 to end of list
> PCI: Enabling device 0000:01:00.0 (0000 -> 0002)
> e1000e 0000:01:00.0: enabling bus mastering
> e1000_probe:7054 mmio_start 0x200c0000 mmio_len 0x20000
>=20
> e1000e 0000:01:00.0: Interrupt Throttling Rate (ints/sec) set to dynamic=
=20
> conservative mode
>=20
> PCI MSI: setup hwirq:0=C2=A0 virq:51
> PCI MSI: setup hwirq:1=C2=A0 virq:52
> PCI MSI: setup hwirq:2=C2=A0 virq:53
>=20
> e1000_get_phy_id_82571:444 ret_val =3D e1e_rphy(hw, MII_PHYSID1, &phy_id)=
;=20
> ret_val =3D -2
>=20
> It turns out, that PHY ID can't be read from the memory, mapped on=20
> driver initialization function by ioremap.
>=20
>  =C2=A0__ioremap (arch/mips/mm/ioremap.c) considers all the memory above =
the=20
> low 512Mb as DRAM and maps the physical addresses 0x20000000 -=20
> 0x3FFFFFFF to logical addresses starting from c0000000 and higher.
>=20
> arch/mips/include/asm/mach-baikal/kernel-entry-init.h defines EVA memory=
=20
> map with virtual addresses range 0xc0000000 - 0xdfffffff as 'MK (kseg2)'=
=20
> i.e. "mapped kernel" with cashing segment attributes defined in SegCtl0,=
=20
> Cfg1: "cacheable, coherent, write-back, write-allocate, read misses=20
> request shared attribute".
>=20
> I've tried to change the caching attribute (bits 16:18 in SegCtl0) to=20
> 0x2 ("uncached, not coherent"), but
>=20
> this hasn't yield any visible effect on PCIe e1000e initialization.

Mapped kernel segments don't use the CCA in SegCtl. Each page mapping
has its own CCA specified in the TLB, which would have been loaded from
page tables set up by e.g. remap_area_pte(), and the ioremap() macro
does pass _CACHE_UNCACHED as the flags argument. I would recommend
checking the phys_addr and flags coming in to remap_area_pte().

If that all looks correct you could also try:
- Dump the TLB contents straight after accessing that address to check
  they are loaded correctly, i.e. call dump_tlb_all() from
  <asm/tlbdebug.h>.
- If the TLB contents look wrong, try disabling hardware page table
  walker to determine whether that is misconfigured (add nohtw to kernel
  command line).

Hope that helps

Cheers
James

--PY8tzLeNxmyMVNR3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlon2HEACgkQbAtpk944
dnpZHhAAp9p5Jm4Kep6oqtY6V/8QbNC5TOmG8NgWnOeKX0BS7d/sG4pi3sMaUMVI
tdXcnt11EvbQFHlTyCUkG6jE1WyLdvQ0kTz2R8uwM/zrRsoJor8MOrZuAud41wCM
oQX7+vuJothqiUDGn2xsapJ85mFdnA1QBe3DCAkh3lgA1H8N5TPZt/QKXqau5bL3
/mWml33dgyMJA0Az2uc6ta7q0ZwizCcEVb2VmUFawEwSmxYXKsj7216pNDA3oHXJ
K9HKe2lCL1kNjXJhW9JAPnU5OODky5q3bwB85QnTSVoZZjjwlMfTr5yxM6YuKwRc
SDIjUKIE9QIyJa1SN/bvAVBsIudE5ehUYUjy+ZZMlZfHMorTnaE03/QtTzow7LjH
i/Bnur6W+iWXE7OomQ+vbfqTQPxktg+Y/TPUajpufhRsWNOtMPSVJftMGMA81+yz
dn5OTWJ2TegI9WIrkWzwm46S37fHWdWvO2H9E2mcxVZzJgk3yNa55DKTrsNC1rPE
R+QMkYtI130JkAoEsHuDJurIGTis6bjsIkDKDSWcnN6UjknHPGIGV2YqNY0PeXVN
0IePcEcO0Kwav+nvcpcNJcEgyylabZbS0Tomvl6l9SY9QYVdQ3CJazoxsPuB1py3
VBUTsGH6GI7Aqhmf5qUlus3Pd4wXNZ51I0NPdiVc1bejF54ZTrk=
=vm7a
-----END PGP SIGNATURE-----

--PY8tzLeNxmyMVNR3--

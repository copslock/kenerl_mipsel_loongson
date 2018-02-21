Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Feb 2018 12:14:26 +0100 (CET)
Received: from 9pmail.ess.barracuda.com ([64.235.154.210]:37195 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990405AbeBULOTZShVK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 21 Feb 2018 12:14:19 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx1412.ess.rzc.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Wed, 21 Feb 2018 11:13:56 +0000
Received: from localhost (192.168.154.110) by MIPSMAIL01.mipstec.com
 (10.20.43.31) with Microsoft SMTP Server (TLS) id 14.3.361.1; Wed, 21 Feb
 2018 03:13:46 -0800
Date:   Wed, 21 Feb 2018 11:13:45 +0000
From:   James Hogan <james.hogan@mips.com>
To:     "Maciej W. Rozycki" <macro@mips.com>
CC:     Huacai Chen <chenhc@lemote.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        "Steven J . Hill" <Steven.Hill@cavium.com>,
        <linux-mips@linux-mips.org>, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>
Subject: Re: [PATCH V2 08/12] MIPS: Align kernel load address to 64KB
Message-ID: <20180221111344.GH29460@jhogan-linux.mipstec.com>
References: <1517022752-3053-1-git-send-email-chenhc@lemote.com>
 <1517023336-17575-1-git-send-email-chenhc@lemote.com>
 <1517023336-17575-2-git-send-email-chenhc@lemote.com>
 <20180219230719.GC6245@saruman>
 <alpine.DEB.2.00.1802202206490.3553@tp.orcam.me.uk>
 <20180220222542.GF29460@jhogan-linux.mipstec.com>
 <alpine.DEB.2.00.1802202249410.3553@tp.orcam.me.uk>
 <20180220225845.GG29460@jhogan-linux.mipstec.com>
 <alpine.DEB.2.00.1802202313480.3553@tp.orcam.me.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Rn7IEEq3VEzCw+ji"
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1802202313480.3553@tp.orcam.me.uk>
User-Agent: Mutt/1.7.2 (2016-11-26)
X-Originating-IP: [192.168.154.110]
X-BESS-ID: 1519211635-452060-16012-68305-12
X-BESS-VER: 2018.2.1-r1802152107
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.01
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.190258
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.01 BSF_SC0_SA_TO_FROM_DOMAIN_MATCH META: Sender 
        Domain Matches Recipient Domain 
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.01 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_SC0_SA_TO_FROM_DOMAIN_MATCH, BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Return-Path: <James.Hogan@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62669
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

--Rn7IEEq3VEzCw+ji
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 20, 2018 at 11:38:26PM +0000, Maciej W. Rozycki wrote:
> On Tue, 20 Feb 2018, James Hogan wrote:
>=20
> > >  As I say, I'm missing bits of context.  If you say that a 64kiB-page=
=20
> > > kernel loads a 4kiB-page kernel, then the alignment for the latter is=
=20
> > > obviously 4kiB.  So I repeat my question: why hardcode the alignment =
to=20
> > > 64kiB while we only need 4kiB in this case?
> >=20
> > Because its the 1st kernel which is doing the kexec'ing of the 2nd
> > kernel. The 2nd kernel might not even have kexec enabled, but you still
> > might want to boot it using kexec.
>=20
>  Forgive my dumbness, but I don't understand what's preventing the 1st=20
> kernel from getting the alignment of the 2nd kernel (regardless of=20
> whether the 2nd kernel has kexec enabled).  What prevents the 1st kernel=
=20
> from interpreting the `p_align' value from the relevant program header=20
> of the 2nd kernel before loading the segment the header describes?  It=20
> has to load the header anyway or it wouldn't know how much data to load=
=20
> and where from into the file, and how much BSS space to initialise.

The kernel doesn't always get an elf through kexec_load(2), but rather a
list of load segments. In any case though its not about knowing the
page size of 2nd kernel, its about kexec working with page size chunks.
See the comment in sanity_check_segment_list().

>=20
>  Here's an example program header dump from `vmlinux':
>=20
> $ readelf -l vmlinux

Yeh but its not a vmlinux, its a vmlinuz. Thats the whole point. Though
it sounds like you'd have the same problem with vmlinux too if you tried
reducing the page size, so perhaps its fine for compressed kernels to
just align to the page size of the 2nd kernel, so they're no worse than
vmlinux.

>=20
> Elf file type is EXEC (Executable file)
> Entry point 0x80506e70
> There are 3 program headers, starting at offset 52
>=20
> Program Headers:
>   Type           Offset   VirtAddr   PhysAddr   FileSiz MemSiz  Flg Align
>   ABIFLAGS       0x4b02e8 0x805ac2e8 0x805ac2e8 0x00018 0x00018 R   0x8
>   LOAD           0x004000 0x80100000 0x80100000 0x534650 0x569710 RWE 0x4=
000
>   NOTE           0x4145a8 0x805105a8 0x805105a8 0x00024 0x00024 R   0x4
>=20
>  Section to Segment mapping:
>   Segment Sections...
>    00     .MIPS.abiflags
>    01     .text __ex_table .notes .rodata .MIPS.abiflags .pci_fixup __ksy=
mtab __ksymtab_gpl __kcrctab __kcrctab_gpl __ksymtab_strings __param __modv=
er .data .init.text .init.data .exit.text .bss
>    02     .notes
> $=20
>=20
> As you can see there's only one loadable segment (the usual case) and=20
> its alignment is 0x4000, that is 16kiB.  So this kernel uses a page size=
=20
> of 16kiB.

For malta_defconfig *vmlinuz* however (CONFIG_PAGE_SIZE_16KB=3Dy), I get
this:
  LOAD           0x008320 0x80828320 0x80828320 0x35e580 0x8605a0 RWE 0x100=
00

Cheers
James

--Rn7IEEq3VEzCw+ji
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlqNVGIACgkQbAtpk944
dnoCDRAAsZr3xNGuCnT4jKMlg2pHDB9ZuemRY+6PRkCLqaPBXKJPHgYW7nOU2+0r
RSjHTPZ/FqMiVHUz0XElgn6nouBpNpmrZSZ8zMrL0M4ar97Ixeg7DQJFRJ6CLlcr
uQsb09hVe61YKrSBUeB5TO7mAXBxZtZpfxn+sL2/h3+AsEzSMk8ooTu7v6pHTi4I
ZA8QAhh7wiwXfnDruw4iKCggDGiq7YzYNwc4aGnEaVGlZIsngWDDSv2qUYZVuOlW
/U3XwNA8aI0oSvdrqcbDpoHFG3yWXSqmezst+oCZ4xWa46iuJoWYeiGshJN6z5az
GJPXuE/gT1Phh6D0m29dwFGhoHTsiOn7bvyFrm2f8yWZB/p8d33pcqJwa58xsw2+
mR6/PqWe4ZpmlB+w43Xcq6qWdC7WmqUcB6w+Zsxlqn9Xt66tGDtRCQm9DKmSa3jO
u4CfAjIGzfr4LZaYfBHdzi5XoRLnXcBIoX3VAB6fTNYgDGJI9DH6v+7nc5mVlbgV
+z1/79vJGwAXcIHm7yuD2/tqW1GJ9CSKa9IWXiSVsdDPVLEQww7w/5XLgZaWuFD5
+6MzkmWehPL2e2Smh15JX79PkRN3HdAP5etPVYi50xEt+chn40dWsbjqa5X8HBu2
X7h/Q92jJzMSpK33V5iHcWMPOFUrN+88sfswY9r8gv5c2AJYY4U=
=VtFU
-----END PGP SIGNATURE-----

--Rn7IEEq3VEzCw+ji--

Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Mar 2018 23:22:26 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.99]:40790 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994773AbeCHWWSfEvX0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 8 Mar 2018 23:22:18 +0100
Received: from saruman (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B3C60205F4;
        Thu,  8 Mar 2018 22:22:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3C60205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date:   Thu, 8 Mar 2018 22:22:07 +0000
From:   James Hogan <jhogan@kernel.org>
To:     "Maciej W. Rozycki" <macro@mips.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>, linux-mips@linux-mips.org
Subject: Re: [PATCH v2] MIPS: Set ISA bit in entry-y for microMIPS kernels
Message-ID: <20180308222206.GB24558@saruman>
References: <alpine.DEB.2.00.1708212102200.17596@tp.orcam.me.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="DKU6Jbt7q3WqK7+M"
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1708212102200.17596@tp.orcam.me.uk>
User-Agent: Mutt/1.7.2 (2016-11-26)
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62860
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jhogan@kernel.org
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


--DKU6Jbt7q3WqK7+M
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 21, 2017 at 09:20:38PM +0100, Maciej W. Rozycki wrote:
> In order to fetch the correct entry point with the ISA bit included, for=
=20
> use by non-ELF boot loaders, parse the output of `objdump -f' for the=20
> start address recorded in the kernel executable itself, rather than=20
> using `nm' to get the value of the `kernel_entry' symbol.
>=20
> Sign-extend the address retrieved if 32-bit, so that execution is=20
> correctly started on 64-bit processors as well.  The tool always prints=
=20
> the entry point using either 8 or 16 hexadecimal digits, matching the=20
> address width (aka class) of the ELF file, even in the presence of=20
> leading zeros.
>=20
> Signed-off-by: Maciej W. Rozycki <macro@imgtec.com>
> ---
> Ralf,
>=20
>  As you requested, here's v2 rebased as a replacement for 5fc9484f5e41,
> with the heading reused.
>=20
>  Please apply.
>=20
>   Maciej
>=20
> ---
>  arch/mips/Makefile |    8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>=20
> linux-mips-start-address.diff
> Index: linux-sfr-usead/arch/mips/Makefile
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-sfr-usead.orig/arch/mips/Makefile	2017-08-21 20:48:38.000000000=
 +0100
> +++ linux-sfr-usead/arch/mips/Makefile	2017-08-21 17:47:16.802753000 +0100
> @@ -243,8 +243,12 @@ include arch/mips/Kbuild.platforms
>  ifdef CONFIG_PHYSICAL_START
>  load-y					=3D $(CONFIG_PHYSICAL_START)
>  endif
> -entry-y				=3D 0x$(shell $(NM) vmlinux 2>/dev/null \
> -					| grep "\bkernel_entry\b" | cut -f1 -d \ )
> +
> +# Sign-extend the entry point to 64 bits if retrieved as a 32-bit number.
> +entry-y		=3D $(shell $(OBJDUMP) -f vmlinux 2>/dev/null \
> +			| sed -n '/^start address / { \
> +				s/^.*0x\([0-7].......\)$$/0x00000000\1/; \
> +				s/^.*0x\(........\)$$/0xffffffff\1/; p }')

This leaves the "start address " on the beginning if the address is
already 64 bits wide, e.g.:

VMLINUX_LOAD_ADDRESS=3D0xffffffff80100000 VMLINUX_ENTRY_ADDRESS=3Dstart add=
ress 0xffffffff80832720 ...

The following seems to work, to drop the "start address " first then
work purely on the hex value (i.e. no need for .* at the front of the
sign extension regexes any more):

+entry-y		=3D $(shell $(OBJDUMP) -f vmlinux 2>/dev/null \
+			| sed -n '/^start address / { \
+				s/^.* //; \
+				s/^0x\([0-7].......\)$$/0x00000000\1/; \
+				s/^0x\(........\)$$/0xffffffff\1/; p }')

Look reasonable? Is there a cleaner way?

Cheers
James

--DKU6Jbt7q3WqK7+M
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlqht4gACgkQbAtpk944
dnpW/A//YyP5GLp6S4vDxFmX6UHqh3afpjR6gWW7Rx34WxNzFLUVi9syMqGKFcIj
B9VmfqgRdEV0ZqxMFimFCSsrFdRaI4dpACXBXXKF6FbPVItuVEJYLxyt+bW5H1UM
Juw07WrMGfALi2Q6RKu63jXUtmVkzt4zRkfl9+/7Wu+db+azoJUwCV3/oPNRSqoE
PaTy9BmNLDQuxMX+FW0VSnOBb3Dw2yEAbTBZTadVFfchI9mB8z+mBRoFp593iutE
JI6oHdKE8J7VEoKH9Dnt21ZTo+GlL5sId6Q4tMoNb3bE87gnUNeIKsSVmC7nE5Gr
lpxq489UO2J0N72ecpzQwrtA+L1bXsDauC9w+UWSwGG2/74vU4bPNg4nRorT6CqW
PcyFzv7NjLmSvB4cqSmESxEtb84yn+aJim7cDwdgbSCrQ7F9mbUovbw1LeO1UvE6
JVu8SCsuxR5kz+Kmz6uZHZCPm3ta9PX9YYKrO7lBhkAGAR7sdzMTpf7ka7v1m3SX
IJfL56bAafilXXalKSipKJWuiXqfQJaSpidCcFKJxkFdmys6JExapGKOoNgrSnb9
k0eZiSQwbl75e2WqNogEX5eS2MImZKYLlIVSUqTWr8mqa5yU3w+SVGv2ONSFOxYR
lAWMnIwSb6GhsDlpXedMVNAE5P3/wETsyj7O+FB3R3695FszXLs=
=QjW0
-----END PGP SIGNATURE-----

--DKU6Jbt7q3WqK7+M--

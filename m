Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Mar 2018 11:31:11 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.99]:55342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994553AbeCWKa7yhd26 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 23 Mar 2018 11:30:59 +0100
Received: from saruman (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AA43C2177B;
        Fri, 23 Mar 2018 10:30:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA43C2177B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date:   Fri, 23 Mar 2018 10:30:49 +0000
From:   James Hogan <jhogan@kernel.org>
To:     "Maciej W. Rozycki" <macro@mips.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>, linux-mips@linux-mips.org
Subject: Re: [PATCH v3] MIPS: Use the entry point from the ELF file header
Message-ID: <20180323103048.GB11796@saruman>
References: <alpine.DEB.2.00.1803221611430.2163@tp.orcam.me.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="0eh6TmSyL6TZE2Uz"
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1803221611430.2163@tp.orcam.me.uk>
User-Agent: Mutt/1.7.2 (2016-11-26)
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63168
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


--0eh6TmSyL6TZE2Uz
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 22, 2018 at 04:30:41PM +0000, Maciej W. Rozycki wrote:
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
> Signed-off-by: Maciej W. Rozycki <macro@mips.com>
> ---
> Changes in v3:
>=20
> - renamed from "MIPS: Set ISA bit in entry-y for microMIPS kernels", to=
=20
>   avoid confusion with commit 5fc9484f5e41,
>=20
> - fixed the `sed' program to correctly pass through 64-bit values.

Thanks, applied for 4.17.

Cheers
James

--0eh6TmSyL6TZE2Uz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlq011gACgkQbAtpk944
dnomHxAAvwpAj6JzkczBbf76vOwBVWgTG271ADnxpe6RV/Pnn1wp+Zi5V7Gmviea
feNq69J79sEPq2rk14/nlal9SCuX+yQRrwAlDLNgtniyaas9Z5mfQpfg6O226dj3
V0k8j8G2NdNn362HMb/FAEryQGO6j2RLncVuhdIwq0w9JtWBeFYEjsMcRcaMGZG4
63aYBs2YBU99OzJmT/HpYBMo9kTuLEbcBdZSU+Xpx95NPPDbyTi/BZD5/8q/nGgm
TGLkSxfAqMch/uNhR7doYWfddPeMo0Z7XAFPAColxRSJaFI26qEHdXXCNUztGAag
02mNgkG8GJuKYY4sYw+hYhAHtgrrHDmgbIs1/ODFMHfljTV9PEBJCmQENXrlt0cb
TAjKbCP43V6QPyDCoufotHM+pPZdqa7LpLCA37Db3E5Z9rX5xVdWrKCbgkfqM1UY
TpM8MHnaDSqUUw/pJaM0XApDllEo8hfvpDqV0U2KOU+MZuAr44CinQ3Y1AnAmE6X
rE8YI/zhkg2AZuUMGhqqaYm6HugDUtxEJdvquhdpL/M4+QAkiwv7WgLaBZQQ5LRI
bszMc7hCnQUwEPAt/vhGr+WkCJRhK7D2UTyL87E122YoW/3521DOIh4mfExJ4Njb
dw3nlTGMwY1GONes4J8W33T6AA7Ey5/7ExCHgsvudOatGTPiQ/o=
=bAPH
-----END PGP SIGNATURE-----

--0eh6TmSyL6TZE2Uz--

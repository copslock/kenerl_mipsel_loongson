Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 01 Feb 2018 17:04:07 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.99]:36618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994834AbeBAQD7lxrMz (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 1 Feb 2018 17:03:59 +0100
Received: from saruman (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3BB9A217A0;
        Thu,  1 Feb 2018 16:03:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BB9A217A0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date:   Thu, 1 Feb 2018 16:03:47 +0000
From:   James Hogan <jhogan@kernel.org>
To:     Mathieu Malaterre <malat@debian.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        "Maciej W. Rozycki" <macro@mips.com>,
        Ingo Molnar <mingo@kernel.org>,
        Paul Burton <paul.burton@mips.com>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] MIPS: Use proper Return keyword
Message-ID: <20180201160346.GK7637@saruman>
References: <20171226105532.23452-1-malat@debian.org>
 <20171227110755.25788-1-malat@debian.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="KjX7LgAomYr70Ka9"
Content-Disposition: inline
In-Reply-To: <20171227110755.25788-1-malat@debian.org>
User-Agent: Mutt/1.7.2 (2016-11-26)
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62398
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


--KjX7LgAomYr70Ka9
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 27, 2017 at 12:07:53PM +0100, Mathieu Malaterre wrote:
> For reference:
> * https://www.kernel.org/doc/html/latest/doc-guide/kernel-doc.html#functi=
on-documentation
>=20
> Fix non-fatal warning:
>=20
> arch/mips/kernel/branch.c:418: warning: Excess function parameter 'return=
s' description in '__compute_return_epc_for_insn'
>=20
> Signed-off-by: Mathieu Malaterre <malat@debian.org>

Applied to my 4.16 branch,

Thanks
James

> ---
> v2: Actually use the correct keyword
>=20
>  arch/mips/kernel/branch.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/mips/kernel/branch.c b/arch/mips/kernel/branch.c
> index b79ed9af9886..e48f6c0a9e4a 100644
> --- a/arch/mips/kernel/branch.c
> +++ b/arch/mips/kernel/branch.c
> @@ -399,7 +399,7 @@ int __MIPS16e_compute_return_epc(struct pt_regs *regs)
>   *
>   * @regs:	Pointer to pt_regs
>   * @insn:	branch instruction to decode
> - * @returns:	-EFAULT on error and forces SIGILL, and on success
> + * Return:	-EFAULT on error and forces SIGILL, and on success
>   *		returns 0 or BRANCH_LIKELY_TAKEN as appropriate after
>   *		evaluating the branch.
>   *
> --=20
> 2.11.0
>=20
>=20

--KjX7LgAomYr70Ka9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlpzOmIACgkQbAtpk944
dnrAkBAAg/MXpXIzQaF8IqIWEwUq/QF2oNenKWFTW/WH7L2AYBv8cqGBuz55VfjF
n3CHdMrMcmW7O3MDlQKVDGt3nngDVkFkIFS4+1tnPljZtjhxQOKORen2fjnLUkBa
NQH4VcNvdfGZ/JFaR8VnVTd46UFz9ch+BECgC8LGP9+Q7jY/tct37UG7UMChPCUC
LoJST0my72bmUqSq+cADOrnNgvxIGgqWg5ch0wYE/pl8B+5W+4s0Le13yrXL0jLB
/KJE3saHRkkA4BHni43Dv04pXERtShSgyUN/r7ysJKDfv8zgH2/0CwyTM7Q26rth
zPlA7NBpnwafycPzUMLgdsM0cVuQeELrjfO8P00CU1JHxbSX6Z+pqcR3TkI3A5hT
M2ajqGhSiQdN5KkyF7tvwespoLkksRei/8FS1w97bdFOsdPS+5SAJqgLNNHqUArQ
uBI/BF6BEiVAbDH2lpyWuOnXxWquMrk2pelWqWOcsoz2PbyDB8V7YrM24BqJQpEp
pkNEwb0B36bf1//H8Vzp3+pLDc5t982gxTyeRWihQ2jwMvoQ7ulAuyY52QjFAN6O
kwjt5h8tVbOU+oX6ma6uRgzMbuhwV904zZeEw+kefveZkstZjL+xk+tW5tck9dWn
MEemwDvvT40M+r5CmVzDnEOMgYEY0uVfWXYShMb7KOHmSo5adWA=
=DleG
-----END PGP SIGNATURE-----

--KjX7LgAomYr70Ka9--

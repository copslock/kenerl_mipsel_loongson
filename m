Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 01 Feb 2018 13:03:50 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.99]:36390 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994833AbeBAMDnY0ccN (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 1 Feb 2018 13:03:43 +0100
Received: from saruman (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7E6CE21748;
        Thu,  1 Feb 2018 12:03:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E6CE21748
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date:   Thu, 1 Feb 2018 12:03:06 +0000
From:   James Hogan <jhogan@kernel.org>
To:     Mathieu Malaterre <malat@debian.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS: ftrace: Remove pointer comparison to 0 in
 prepare_ftrace_return
Message-ID: <20180201120306.GH7637@saruman>
References: <20180117113157.25768-1-malat@debian.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="j2AXaZ4YhVcLc+PQ"
Content-Disposition: inline
In-Reply-To: <20180117113157.25768-1-malat@debian.org>
User-Agent: Mutt/1.7.2 (2016-11-26)
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62394
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


--j2AXaZ4YhVcLc+PQ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 17, 2018 at 12:31:57PM +0100, Mathieu Malaterre wrote:
> Replace pointer comparison to 0 with NULL in prepare_ftrace_return
> to improve code readability. Identified with coccinelle script
> 'badzero.cocci'.
>=20
> Signed-off-by: Mathieu Malaterre <malat@debian.org>

I've applied to my 4.16 branch,

Thanks
James

> ---
>  arch/mips/kernel/ftrace.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/mips/kernel/ftrace.c b/arch/mips/kernel/ftrace.c
> index 99285be0e088..7f3dfdbc3657 100644
> --- a/arch/mips/kernel/ftrace.c
> +++ b/arch/mips/kernel/ftrace.c
> @@ -361,7 +361,7 @@ void prepare_ftrace_return(unsigned long *parent_ra_a=
ddr, unsigned long self_ra,
>  	 * If fails when getting the stack address of the non-leaf function's
>  	 * ra, stop function graph tracer and return
>  	 */
> -	if (parent_ra_addr =3D=3D 0)
> +	if (parent_ra_addr =3D=3D NULL)
>  		goto out;
>  #endif
>  	/* *parent_ra_addr =3D return_hooker; */
> --=20
> 2.11.0
>=20
>=20

--j2AXaZ4YhVcLc+PQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlpzAfkACgkQbAtpk944
dnrhQQ/9FJfs6Jryq+qC61qbYP6a7SwG53uTSZseQ/wngdpe4jcmX/L5PKDyLCfL
0ILvV3oRsqsdUUl7uRCBO3MNPB0VvVreRy6mUXie3SiAnIqKfqVmGTzE27kUhHMD
P7+/0YTTYpliOTIw2eOInRcCrR3TtPCCOXSJTnvROzO5OcqPRR2qTk+mVWK5trC8
Ohf4cjfiFwj0SC0Iy5LtTS0isKPrc9/ipv6m4MoseE4/Tav1p6S6xt18f/CJqMfT
guRJdjNBYgi6fGTeQjJ6Ug2/DgEyD6ZjjHTD4VeGvmkwnQ+tuOXrzzmlh8vo0vfD
d79jKCtmZPsVRUhNP4zKQ7X1ME89XX0GsxXwDSC9xAs6piiUXxwshCrXuu2d+mRP
G5XJ/gRq7PRm+aGBlPJLkYKk3+HmnvcEP7V+fcZIRJ0k4ljHJMSNN7J1RiAdfS1Q
vmru+L9jXMkQV2AjgTjp01bMn51HgIXgcnAGeNyXtNwdJ15+b99eGBKc0/4R113i
kHIFwf5BeaYxNaO47HKqMTBs+jimBvoidCsrJ87ZT2CZGbIdZN64UUp6EWirGMIM
64/yRi/aoAvZeDzbQkaFRkT8ATxY7sqlpRiOCgGBqLBvjvSOSqM1GDFmCXs7egLX
l9hzBPMyxGKT3oSZrD5pnnr+ukLZqOFRnREnB2UP1BfmrRdSsEw=
=X1Q3
-----END PGP SIGNATURE-----

--j2AXaZ4YhVcLc+PQ--

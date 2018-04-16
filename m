Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Apr 2018 00:14:00 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.99]:32818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990723AbeDPWNxRBAeu (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 17 Apr 2018 00:13:53 +0200
Received: from saruman (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B899421838;
        Mon, 16 Apr 2018 22:13:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B899421838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date:   Mon, 16 Apr 2018 23:13:41 +0100
From:   James Hogan <jhogan@kernel.org>
To:     Matt Redfearn <matt.redfearn@mips.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] MIPS: memset.S: Fix return of __clear_user from
 Lpartial_fixup
Message-ID: <20180416221340.GB23881@saruman>
References: <1522315704-31641-1-git-send-email-matt.redfearn@mips.com>
 <1522315704-31641-3-git-send-email-matt.redfearn@mips.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="hHWLQfXTYDoKhP50"
Content-Disposition: inline
In-Reply-To: <1522315704-31641-3-git-send-email-matt.redfearn@mips.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63571
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


--hHWLQfXTYDoKhP50
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 29, 2018 at 10:28:24AM +0100, Matt Redfearn wrote:
> The __clear_user function is defined to return the number of bytes that
> could not be cleared. From the underlying memset / bzero implementation
> this means setting register a2 to that number on return. Currently if a
> page fault is triggered within the memset_partial block, the value
> loaded into a2 on return is meaningless.
>=20
> The label .Lpartial_fixup\@ is jumped to on page fault. Currently it
> masks the remaining count of bytes (a2) with STORMASK, meaning that the
> least significant 2 (32bit) or 3 (64bit) bits of the remaining count are
> always clear.

Are you sure about that. It seems to do that *to ensure those bits are
set correctly*...

> Secondly, .Lpartial_fixup\@ expects t1 to contain the end address of the
> copy. This is set up by the initial block:
> 	PTR_ADDU	t1, a0			/* end address */
> However, the .Lmemset_partial\@ block then reuses register t1 to
> calculate a jump through a block of word copies. This leaves it no
> longer containing the end address of the copy operation if a page fault
> occurs, and the remaining bytes calculation is incorrect.
>=20
> Fix these issues by removing the and of a2 with STORMASK, and replace t1
> with register t2 in the .Lmemset_partial\@ block.
>=20
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Signed-off-by: Matt Redfearn <matt.redfearn@mips.com>
> ---
>=20
>  arch/mips/lib/memset.S | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
>=20
> diff --git a/arch/mips/lib/memset.S b/arch/mips/lib/memset.S
> index 90bcdf1224ee..3257dca58cad 100644
> --- a/arch/mips/lib/memset.S
> +++ b/arch/mips/lib/memset.S
> @@ -161,19 +161,19 @@
> =20
>  .Lmemset_partial\@:
>  	R10KCBARRIER(0(ra))
> -	PTR_LA		t1, 2f			/* where to start */
> +	PTR_LA		t2, 2f			/* where to start */
>  #ifdef CONFIG_CPU_MICROMIPS
>  	LONG_SRL	t7, t0, 1

Hmm, on microMIPS t7 isn't on the clobber list for __bzero, and nor is
t8...

>  #endif
>  #if LONGSIZE =3D=3D 4
> -	PTR_SUBU	t1, FILLPTRG
> +	PTR_SUBU	t2, FILLPTRG
>  #else
>  	.set		noat
>  	LONG_SRL	AT, FILLPTRG, 1
> -	PTR_SUBU	t1, AT
> +	PTR_SUBU	t2, AT
>  	.set		at
>  #endif
> -	jr		t1
> +	jr		t2
>  	PTR_ADDU	a0, t0			/* dest ptr */

^^^ note this...

> =20
>  	.set		push
> @@ -250,7 +250,6 @@
> =20
>  .Lpartial_fixup\@:
>  	PTR_L		t0, TI_TASK($28)
> -	andi		a2, STORMASK

=2E.. this isn't right.

If I read correctly, t1 (after the above change stops clobbering it) is
the end of the full 64-byte blocks, i.e. the start address of the final
partial block.


The .Lfwd_fixup calculation (for full blocks) appears to be:

  a2 =3D ((len & 0x3f) + start_of_partial) - badvaddr

which is spot on. (len & 0x3f) is the partial block and remaining bytes
that haven't been set yet, add start_of_partial to get end of the full
range, subtract bad address to find how much didn't copy.


The calculation for .Lpartial_fixup however appears to (currently) do:

  a2 =3D ((len & STORMASK) + start_of_partial) - badvaddr

Which might make sense if start_of_partial (t1) was replaced with
end_of_partial, which does seem to be calculated as noted above, and put
in a0 ready for the final few bytes to be set.

>  	LONG_L		t0, THREAD_BUADDR(t0)
>  	LONG_ADDU	a2, t1

^^ So I think either it needs to just s/t1/a0/ here and not bother
preserving t1 above (smaller change and probably the original intent),
or preserve t1 and mask 0x3f instead of STORMASK like .Lfwd_fixup does
(which would work but seems needlessly complicated to me).

Does that make any sense or have I misunderstood some subtlety?

Cheers
James

>  	jr		ra
> --=20
> 2.7.4
>=20

--hHWLQfXTYDoKhP50
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlrVIA4ACgkQbAtpk944
dnoWXBAArNfISUljj95eR82szfld+rgWP02B0CaLUr5ejxZxOUMvnfejNuBgSzy3
laUh6DnqSGzctNW3thqWf8h2gza59gkQQiRwQqsLiKCoAhSBW61diHULCOz/iFu7
DiLvZyZLVgsqai/ViX+r47OqdKiOXtNHC34oTKl7oUCGVQ0XASJ/320X/hDKiHFO
sewfLn0ml781THlksW5bTMpAQFwCcZS4qda8T7dAlfpm1uZu1Tev/fwQZrxTwpUf
E8pRyuagFkyZMe9a3OXWzahk8kakqhucYcmvAWPWtgz/Q0ue/hBtH8JKm07W7Fql
dBFEkNM8NE0RSQsEqBhCs7rhxw85owtDjpZz4XQB80Al1zpRUgDlVgSJxPypDvia
gGmqKT5gOPo7v2+KWkdizF0bF0nfRrgz+Y2LVYdEdCFDGpWFe6qt8Tny5NdxlNFQ
pHNVGSJSnHCKxXHzoSM0IqpChuVL2LgqdILwlE837vjTxRwnn5UuwPsmN+TmoA7O
7T+Xs870vZW/B/u+/wMjtjeezkEHU+BCnB4HgOqhpnFM3qPAMW12/1TsUGWt1l5y
TADIRkp92dOL424FM22JLis0Y8ll8Iacys/5mwYy/XC+BKsJSl4XYOXdT44tgIJi
62rQ4IoBp8c3g4UKObxxjP57y7Qh161cOUNVulk2CCnQkxdtZkw=
=w2/e
-----END PGP SIGNATURE-----

--hHWLQfXTYDoKhP50--

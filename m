Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Nov 2017 00:52:31 +0100 (CET)
Received: from 19pmail.ess.barracuda.com ([64.235.150.244]:43215 "EHLO
        19pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991940AbdJaXwXjpkRU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 1 Nov 2017 00:52:23 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx28.ess.sfj.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Tue, 31 Oct 2017 23:52:06 +0000
Received: from localhost (192.168.154.110) by MIPSMAIL01.mipstec.com
 (10.20.43.31) with Microsoft SMTP Server (TLS) id 14.3.361.1; Tue, 31 Oct
 2017 16:51:33 -0700
Date:   Tue, 31 Oct 2017 23:52:19 +0000
From:   James Hogan <james.hogan@mips.com>
To:     Paul Burton <paul.burton@mips.com>
CC:     <linux-mips@linux-mips.org>,
        Matt Redfearn <matt.redfearn@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH] MIPS: Fix CM region target definitions
Message-ID: <20171031235219.GE15260@jhogan-linux>
References: <20171031220922.14931-1-paul.burton@mips.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="gE7i1rD7pdK0Ng3j"
Content-Disposition: inline
In-Reply-To: <20171031220922.14931-1-paul.burton@mips.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
X-Originating-IP: [192.168.154.110]
X-BESS-ID: 1509493926-637138-27156-361285-1
X-BESS-VER: 2017.12-r1710252241
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.51
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.186465
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.50 BSF_RULE7568M          META: Custom Rule 7568M 
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
        0.01 BSF_SC0_SA_TO_FROM_DOMAIN_MATCH META: Sender Domain Matches Recipient Domain 
X-BESS-Outbound-Spam-Status: SCORE=0.51 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_RULE7568M, BSF_BESS_OUTBOUND, BSF_SC0_SA_TO_FROM_DOMAIN_MATCH
X-BESS-BRTS-Status: 1
Return-Path: <James.Hogan@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60626
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

--gE7i1rD7pdK0Ng3j
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 31, 2017 at 03:09:22PM -0700, Paul Burton wrote:
> The default CM target field in the GCR_BASE register is encoded with 0
> meaning memory & 1 being reserved. However the definitions we use for
> those bits effectively get these two values backwards - likely because
> they were copied from the definitions for the CM regions where the
> target is encoded differently. This results in use setting up GCR_BASE
> with the reserved target value by default, rather than targeting memory
> as intended. Although we currently seem to get away with this it's not a
> great idea to rely upon.
>=20
> Fix this by changing our macros to match the documentated target values.
>=20
> The incorrect encoding became used as of commit 9f98f3dd0c51 ("MIPS: Add
> generic CM probe & access code") in the Linux v3.15 cycle, and was
> likely carried forwards from older but unused code introduced by
> commit 39b8d5254246 ("[MIPS] Add support for MIPS CMP platform.") in the
> v2.6.26 cycle.
>=20
> Signed-off-by: Paul Burton <paul.burton@mips.com>
> Reported-by: Matt Redfearn <matt.redfearn@mips.com>
> Cc: Matt Redfearn <matt.redfearn@mips.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: linux-mips@linux-mips.org
> Cc: <stable@vger.kernel.org> # v3.15+

Reviewed-by: James Hogan <jhogan@kernel.org>

Cheers
James

> ---
>=20
>  arch/mips/include/asm/mips-cm.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/mips/include/asm/mips-cm.h b/arch/mips/include/asm/mips=
-cm.h
> index f6231b91b724..c6aaabd7cfd1 100644
> --- a/arch/mips/include/asm/mips-cm.h
> +++ b/arch/mips/include/asm/mips-cm.h
> @@ -142,8 +142,8 @@ GCR_ACCESSOR_RO(64, 0x000, config)
>  GCR_ACCESSOR_RW(64, 0x008, base)
>  #define CM_GCR_BASE_GCRBASE			GENMASK_ULL(47, 15)
>  #define CM_GCR_BASE_CMDEFTGT			GENMASK(1, 0)
> -#define  CM_GCR_BASE_CMDEFTGT_DISABLED		0
> -#define  CM_GCR_BASE_CMDEFTGT_MEM		1
> +#define  CM_GCR_BASE_CMDEFTGT_MEM		0
> +#define  CM_GCR_BASE_CMDEFTGT_RESERVED		1
>  #define  CM_GCR_BASE_CMDEFTGT_IOCU0		2
>  #define  CM_GCR_BASE_CMDEFTGT_IOCU1		3
> =20
> --=20
> 2.15.0
>=20
>=20

--gE7i1rD7pdK0Ng3j
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAln5DLMACgkQbAtpk944
dnoOag//aX0DaDsvnM+pRWG+7pwYZJIqD4usrz1x48cag+WMRrn6oKudsSruSgih
08j3cbQAocp5nMYFr4irZdONpRibi1SHBMlotCYnQiwBzmakKgf+FPXTUtFKOOk3
jWYSrSeYi7Z2wbUDuhUcYGUhS1vep/S9iM1nXTjRhjrArECrmK4jHLXsXee1PRRt
5ZcPHQmaYQDXlMblWtHIxfnhbRMzY8rHkSd7EReSDHRh2VSNYI8i/24+yMGyG5bP
iRQlauOnNZOc3dp8NZ3kSgNNnlYH8z/BUmKPxWq4aGRsfU3zbuF7reTkCzuxY0FR
3/RzYKS2cLCWxXrz/HJ7mBtxFbeXCTRtNncq6tIq+tBLwLjWYM9t7xJ6NnN4e2xJ
YJ9hydOBi7hRMyouH+iqBcijB8wlTQdynzK/t/uLNnpxPpPaS4ZIL0ppfNzDLN36
LiVNJFH77oCavVYEGDZSPvDzE0/IlhGGna+gNpogDvp7ikC3aYHrq7iuEfpt1Ij/
cG9IeRIMPLn7lTxjvr/luhON09UBgGvZvSNmUQrjs1Hcxi+jsUSvuyhK0MEaEfQd
dCaiTqg0ITr89glvFr5Q+e4q7lULDjAItWQ06gWEX2KxUAj/AKj7Pm9whBRUhKZG
FYzIwqAef2rs3/WpJpUwrPb7FcglKqZFXRBzsHKfOedHXIjUaOk=
=Z8Jl
-----END PGP SIGNATURE-----

--gE7i1rD7pdK0Ng3j--

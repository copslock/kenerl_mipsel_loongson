Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Nov 2017 13:55:00 +0100 (CET)
Received: from 19pmail.ess.barracuda.com ([64.235.154.231]:39419 "EHLO
        19pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990757AbdKIMyvdsdBH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 9 Nov 2017 13:54:51 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx1401.ess.rzc.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Thu, 09 Nov 2017 12:54:35 +0000
Received: from localhost (192.168.154.110) by MIPSMAIL01.mipstec.com
 (10.20.43.31) with Microsoft SMTP Server (TLS) id 14.3.361.1; Thu, 9 Nov 2017
 04:54:34 -0800
Date:   Thu, 9 Nov 2017 12:54:32 +0000
From:   James Hogan <james.hogan@mips.com>
To:     Allen Pais <allen.lkml@gmail.com>
CC:     <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
Subject: Re: mips: use setup_timer() helper.
Message-ID: <20171109125432.GT15260@jhogan-linux>
References: <1506080615-6137-1-git-send-email-allen.lkml@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="kLVKJMuKEUFaIs8+"
Content-Disposition: inline
In-Reply-To: <1506080615-6137-1-git-send-email-allen.lkml@gmail.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
X-Originating-IP: [192.168.154.110]
X-BESS-ID: 1510232075-321457-5697-58991-4
X-BESS-VER: 2017.12-r1710252241
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.186752
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Return-Path: <James.Hogan@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60801
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

--kLVKJMuKEUFaIs8+
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 22, 2017 at 05:13:35PM +0530, Allen Pais wrote:
> Use setup_timer function instead of initializing timer with the
>    function and data fields.
>=20
> Signed-off-by: Allen Pais <allen.lkml@gmail.com>

Thanks, applied for 4.15.

Cheers
James

> ---
>  arch/mips/lasat/picvue_proc.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/arch/mips/lasat/picvue_proc.c b/arch/mips/lasat/picvue_proc.c
> index dd292dc..a8103f6 100644
> --- a/arch/mips/lasat/picvue_proc.c
> +++ b/arch/mips/lasat/picvue_proc.c
> @@ -197,8 +197,7 @@ static int __init pvc_proc_init(void)
>  	if (proc_entry =3D=3D NULL)
>  		goto error;
> =20
> -	init_timer(&timer);
> -	timer.function =3D pvc_proc_timerfunc;
> +	setup_timer(&timer, pvc_proc_timerfunc, 0UL);
> =20
>  	return 0;
>  error:

--kLVKJMuKEUFaIs8+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAloEUAEACgkQbAtpk944
dnqhzBAAgrgHZe0Kdhinq8tOHGeUut9cQrPJVm9Mb5qFtz9coJxlL2CzW/o7JSWI
bQO+hyvJ2xGPWrnhrimh1J3VPQmaTVObQnB3+q/p0FNnD1to0HvhHCQEIMi30ehJ
x27C1o7G3Qc9bGZacjjXvl6ot7TkC4x+PYymiAeSZmylDWL5GMz0Yy/APRgemus0
0Nx86H4uJMeyJ7aVBJLj8ruPhxRdpwS+f8vvMJSC4CEZ8M2Sdtyrdu5HOLx2+VMj
Sc8MEsJmcR9nlv6UyODf8r19K/Ts56qtbSihE5tos+5n7KQo3pKs4Sn8g1QWGfUi
0zPRUBJVAj347K8jjkd0nlg3T1B7be386DFRQvvEpxDTLkzOymyHLu/fStfXORFN
hGPvuf7mgviTO1DsEfKf5d5gCGkxEvrSln76kUvn2QjIq4mOU/azBO6HgYM0zi5J
uUAf80u3eNsMbZaoVGICZiOgAx1XOhPltf+6lee436lOc0nZeArh9qCfwI13ryAz
UDjbOVIjKdzqvWRJuEgNkks0ciisMq+oVb4kjOeMSSe1MgFTy8HdbweXwplSAmn7
VrDupp01H6BG3T39g5moPOb8pBp8jpMbKuO8Z58yfhfwW9B5d+AyTp2t979bcQ4c
FYyF95OT44nbMMDZK2/06xKhCxBoa5/VBFyJXklLuHi7noToSG8=
=rlzs
-----END PGP SIGNATURE-----

--kLVKJMuKEUFaIs8+--

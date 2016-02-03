Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Feb 2016 15:59:07 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:50966 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27012294AbcBCO7FoeqS3 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 3 Feb 2016 15:59:05 +0100
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id 53A1241F8DA8;
        Wed,  3 Feb 2016 14:59:00 +0000 (GMT)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Wed, 03 Feb 2016 14:59:00 +0000
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Wed, 03 Feb 2016 14:59:00 +0000
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email Security Gateway with ESMTPS id CA4C1139562AE;
        Wed,  3 Feb 2016 14:58:57 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Wed, 3 Feb 2016 14:58:59 +0000
Received: from localhost (192.168.154.110) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Wed, 3 Feb
 2016 14:58:59 +0000
Date:   Wed, 3 Feb 2016 14:58:59 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     Paul Burton <paul.burton@imgtec.com>
CC:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>,
        "Matt Redfearn" <matt.redfearn@imgtec.com>,
        <linux-kernel@vger.kernel.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        Markos Chandras <markos.chandras@imgtec.com>
Subject: Re: [PATCH 06/15] MIPS: CM: Fix mips_cm_max_vp_width for UP kernels
Message-ID: <20160203145858.GH5464@jhogan-linux.le.imgtec.org>
References: <1454469335-14778-1-git-send-email-paul.burton@imgtec.com>
 <1454469335-14778-7-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="IbVRjBtIbJdbeK1C"
Content-Disposition: inline
In-Reply-To: <1454469335-14778-7-git-send-email-paul.burton@imgtec.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: 56f439c
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51695
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
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

--IbVRjBtIbJdbeK1C
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 03, 2016 at 03:15:26AM +0000, Paul Burton wrote:
> Fix mips_cm_max_vp_width for UP kernels where it previously referenced
> smp_num_siblings, which is not declared for UP kernels. This led to
> build errors such as the following:
>=20
>   drivers/built-in.o: In function `$L446':
>   irq-mips-gic.c:(.text+0x1994): undefined reference to `smp_num_siblings'
>   drivers/built-in.o:irq-mips-gic.c:(.text+0x199c): more undefined refere=
nces to `smp_num_siblings' follow
>=20
> On UP kernels simply return 1, leaving the reference to smp_num_siblings
> in place only for SMP kernels.
>=20
> Signed-off-by: Paul Burton <paul.burton@imgtec.com>

Need tagging for stable v4.3+?

I do wonder if this should be handled in the header files though...

Cheers
James

> ---
>=20
>  arch/mips/include/asm/mips-cm.h | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/mips/include/asm/mips-cm.h b/arch/mips/include/asm/mips=
-cm.h
> index 1395bbc..3fdb6c9 100644
> --- a/arch/mips/include/asm/mips-cm.h
> +++ b/arch/mips/include/asm/mips-cm.h
> @@ -462,7 +462,10 @@ static inline unsigned int mips_cm_max_vp_width(void)
>  	if (mips_cm_revision() >=3D CM_REV_CM3)
>  		return read_gcr_sys_config2() & CM_GCR_SYS_CONFIG2_MAXVPW_MSK;
> =20
> -	return smp_num_siblings;
> +	if (config_enabled(CONFIG_SMP))
> +		return smp_num_siblings;
> +
> +	return 1;
>  }
> =20
>  /**
> --=20
> 2.7.0
>=20
>=20

--IbVRjBtIbJdbeK1C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWshWyAAoJEGwLaZPeOHZ67DQP/3Y5RL1+CwHuU9GpPQXTJhmH
cArxyVQMcBKxUpvuXXP7Uya6hU2IYuyz1ahGfLNUNJlFF9WKW06FV5a+DdsoYTG7
2mzFk4S7CEiyihlwiXbeCNmunnq64y4+PC5TDSZmLhH2QuEkph/8Z/z6RLAy5dzR
Jnuz3GsrvGQVKPt01F7Y+AeJDJDvKkUHTg/fBZ+8mLxwb7H0TrQWbMUX2SZrFkUa
QiOVFfF510LE54b4DJyyXmSbKD5Hmb9c9TCCEb49tev+f21nEYV5j/1atMW93vl5
HjVEu/Id3n/CTUjRmw2RafZZIKDWtoG4WzLLNvfAqpGmGKjSECmOUMN3t7ZJDHiC
l+/5ZxdfwPj68Jo/G6NsO8ertHzFX2UA6SFhtRP99n/a8tj7lO7KyU2xhfu4oCVN
sZARJp0KrGes48SbEKJOzRA/IztycyKeeE3SLH2Kaa9dW4a93PswmfgC9PIUbkGi
9ACQ2CHtmAHO39H3A/J8UYcw+FB4NNbs4fT6U1xoJax9GFiw6aVnu0o1Gbxg06/L
hskKuel8oHKjdDc5KIY0ciYe0pjKrWS0TwNXQobM6T8FnFiboTYrCKHOi51TZQ3J
1flSG2rKfsmwZURm1NcZL1QH4JwOrcn2hcthC2PKwMZydavDQYnGye866TVAH5Ov
GJoNUGcI/T1akaGCrN1Z
=sywA
-----END PGP SIGNATURE-----

--IbVRjBtIbJdbeK1C--

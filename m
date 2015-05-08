Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 May 2015 16:17:35 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:63408 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27012817AbbEHORdS0nuJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 8 May 2015 16:17:33 +0200
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id B917241F8E1F;
        Fri,  8 May 2015 15:17:29 +0100 (BST)
Received: from mailapp01.imgtec.com ([10.100.180.242])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Fri, 08 May 2015 15:17:29 +0100
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Fri, 08 May 2015 15:17:29 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id F074095289AD;
        Fri,  8 May 2015 15:17:26 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Fri, 8 May 2015 15:16:24 +0100
Received: from [192.168.154.110] (192.168.154.110) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Fri, 8 May
 2015 15:16:24 +0100
Message-ID: <554CC530.20906@imgtec.com>
Date:   Fri, 8 May 2015 15:16:16 +0100
From:   James Hogan <james.hogan@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
MIME-Version: 1.0
To:     Nicholas Mc Guire <hofrat@osadl.org>,
        Gleb Natapov <gleb@kernel.org>
CC:     Paolo Bonzini <pbonzini@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>, <kvm@vger.kernel.org>,
        <linux-mips@linux-mips.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] MIPS: KVM: do not sign extend on unsigned MMIO load
References: <1431002870-30098-1-git-send-email-hofrat@osadl.org>
In-Reply-To: <1431002870-30098-1-git-send-email-hofrat@osadl.org>
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature";
        boundary="4TxPvu4HkAHppA9S3Lc6EsaAl9OuAmtwq"
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: b93fcccb
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47281
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

--4TxPvu4HkAHppA9S3Lc6EsaAl9OuAmtwq
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 07/05/15 13:47, Nicholas Mc Guire wrote:
> Fix possible unintended sign extension in unsigned MMIO loads by castin=
g
> to uint16_t in the case of mmio_needed !=3D 2.
>=20
> Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>

Looks good to me. I wrote an MMIO test to reproduce the issue, and this
fixes it.

Reviewed-by: James Hogan <james.hogan@imgtec.com>
Tested-by: James Hogan <james.hogan@imgtec.com>

It looks suitable for stable too (3.10+).

Cheers
James

> ---
>=20
> Thanks to James Hogan <james.hogan@imgtec.com> for the explaination of =

> mmio_needed (there is not really any helpful comment in the code on thi=
s)
> in this case (mmio_needed!=3D2) it should be unsigned.
>=20
> Patch was only compile tested msp71xx_defconfig + CONFIG_KVM=3Dm
>=20
> Patch is against 4.1-rc2 (localversion-next is -next-20150506)
>=20
>  arch/mips/kvm/emulate.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/mips/kvm/emulate.c b/arch/mips/kvm/emulate.c
> index 6230f37..2f0fc60 100644
> --- a/arch/mips/kvm/emulate.c
> +++ b/arch/mips/kvm/emulate.c
> @@ -2415,7 +2415,7 @@ enum emulation_result kvm_mips_complete_mmio_load=
(struct kvm_vcpu *vcpu,
>  		if (vcpu->mmio_needed =3D=3D 2)
>  			*gpr =3D *(int16_t *) run->mmio.data;
>  		else
> -			*gpr =3D *(int16_t *) run->mmio.data;
> +			*gpr =3D *(uint16_t *)run->mmio.data;
> =20
>  		break;
>  	case 1:
>=20


--4TxPvu4HkAHppA9S3Lc6EsaAl9OuAmtwq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJVTMU4AAoJEGwLaZPeOHZ67k0QAJPO9DMmHX3BH3vhjAcm2Qkm
RFKiVTkXqyypH14iYaCy6fpuQdIqzm4cqLnT9qZK/eSGovblhSpvIUcaxAPfAEqw
bsBV9ksQoONQIPrhlEXwiBW8TJa4V3ljBH9/Zx+lZuOgS79XREbrwtAH3/MhmVfF
BNamNA0S3Onjh+B4uExFMROaONb+vVbQID+FBS+T/USfwrNP+QcP6RCUNtDsjhGr
jj+LUn50miN1zWThm6V8fmUhgVaf6Ehcs7bUM04q5wgPV1r1xU12fsPkbZH5SbeI
N+D4KkX/YS0Q/DiNy2KCMKd7DpGil9Uu9RL34WmtV4a3cfmJZJ3GWdsrQinh2PL5
R/xdGrQ/wQJZxhZ9Q2Da7FniqXoHfVFtnk/58fFVP+kD4R2BKfNp2i81dHb3zUQF
FBxiBqLe/w+2gg1hrpYq0SfXGBXhc78y4qHxgbG+6f8kAJUGA6wmSULNofM1L1pO
3z8ckKDTJUnsD2Wb8RzliU2czeM94wnQE3N4MxSBndKkZ3h0YNKXO5SDKt9CxMhO
66nyZmXDi3VPmOhbE2cAimMsutpemgmIzYBTplfr2S3kNPe7UsbcbHXhjEZNCH4v
QOdRCeD8QgAe6ZOmDukRcWGftq1s4WmwkXFXd/BXSH50FwsjPy3C1bCBiZ8CvwLu
KDNcwhetO1VV3ufMs8s1
=aOsa
-----END PGP SIGNATURE-----

--4TxPvu4HkAHppA9S3Lc6EsaAl9OuAmtwq--

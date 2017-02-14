Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Feb 2017 11:11:55 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:4696 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23993866AbdBNKLrkc52h (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 14 Feb 2017 11:11:47 +0100
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id 3ED3D41F8EB7;
        Tue, 14 Feb 2017 11:15:37 +0000 (GMT)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Tue, 14 Feb 2017 11:15:37 +0000
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Tue, 14 Feb 2017 11:15:37 +0000
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id A483ECE1F196C;
        Tue, 14 Feb 2017 10:11:37 +0000 (GMT)
Received: from localhost (192.168.154.110) by hhmail02.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Tue, 14 Feb
 2017 10:11:39 +0000
Date:   Tue, 14 Feb 2017 10:11:39 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     Marcin Nowakowski <marcin.nowakowski@imgtec.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-mips@linux-mips.org>,
        Michal Marek <mmarek@suse.com>
Subject: Re: [PATCH RESEND] Kbuild: add cpp_its_S in ksym_dep_filter
Message-ID: <20170214101139.GS24226@jhogan-linux.le.imgtec.org>
References: <1486980956-4733-1-git-send-email-marcin.nowakowski@imgtec.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="U7F658e60E1K4csu"
Content-Disposition: inline
In-Reply-To: <1486980956-4733-1-git-send-email-marcin.nowakowski@imgtec.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: 1b7d744b
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56804
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

--U7F658e60E1K4csu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 13, 2017 at 11:15:56AM +0100, Marcin Nowakowski wrote:
> Add a new command cpp_its_S introduced in:
> cf2a5e0bb4c6 ("MIPS: Support generating Flattened Image Trees (.itb)")
> to ksym_dep_filter handler - otherwise a warning is produced during the
> build of MIPS platforms (when vmlinux.*.itb target is chosen)
>=20
> Signed-off-by: Marcin Nowakowski <marcin.nowakowski@imgtec.com>

Applied (to MIPS tree)

Thanks
James

> ---
>  scripts/Kbuild.include | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/scripts/Kbuild.include b/scripts/Kbuild.include
> index 1792198..d6ca649 100644
> --- a/scripts/Kbuild.include
> +++ b/scripts/Kbuild.include
> @@ -284,7 +284,7 @@ ksym_dep_filter =3D                                  =
                          \
>  	    $(CPP) $(call flags_nodeps,c_flags) -D__KSYM_DEPS__ $< ;;        \
>  	  as_*_S|cpp_s_S)                                                    \
>  	    $(CPP) $(call flags_nodeps,a_flags) -D__KSYM_DEPS__ $< ;;        \
> -	  boot*|build*|*cpp_lds_S|dtc|host*|vdso*) : ;;                      \
> +	  boot*|build*|cpp_its_S|*cpp_lds_S|dtc|host*|vdso*) : ;;            \
>  	  *) echo "Don't know how to preprocess $(1)" >&2; false ;;          \
>  	esac | tr ";" "\n" | sed -rn 's/^.*=3D=3D=3D __KSYM_(.*) =3D=3D=3D.*$$/=
KSYM_\1/p'
> =20
> --=20
> 2.7.4
>=20
>=20

--U7F658e60E1K4csu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYotfbAAoJEGwLaZPeOHZ6VAAP/R7hXPtQ+ppRe26eiiOqGv1e
7TgKoorgVQKawZEQ0b3AubhQeymbPMD/O6Kj9VisPuzpFh/zEtn6ya+O8FNQqPcS
LcHe/ZPFK9ZJjouXeuqjUaMce3FegcmeFdCKssEQ6FR7ogQrSCwhUpJ4FLRz19mi
L4vlq5arIOf0cj3yYJX1T7flZH8ABGaeSExn/hiTn6zZwC7BT0/vHhbXhy5tH4Z5
bb7y3Ydnuj4mVHHdyPu/HgWR+quQIqWGPSGLy9yhP3v6T0tCIzsJDCvRSu6jqbLF
x4DqgoZ1JxvE5LxVzKSpHUVpo+ntCqEtHliZwO+R7FJDQsEwd05eNwCApxy8/9ve
GTpM/h1S6btfjOY0VVqWmU1kmmXUIiU21W7cYLMZ3xQRIgncM58mSsMOv0oRvv5a
k8s1wqjJ5pkNq7s22yyTn+XGt34+7BSj9AzF9QiHYFqVNOCZYxQToVXsUuhqH0nK
J6Uf3SmIIWMMxACi06JANI3wLvhyUZEthYGjgEs7Q12M8dbDduaSehLwYkSbNXQ3
4iXFBNxFx0jo+uX3ldHrLDW3GgPjCinf/hWfP7gOCBn49yOA7MUa68xlbXpXME/f
8pSqr5IkWxEPQwnMolg2PhBC7lqpQrGNbX8OdMKEalvJcmK0aQZVSNMhJfiTiyg2
nZ4iTpn5Uzx39o9BJ6Ii
=t4R9
-----END PGP SIGNATURE-----

--U7F658e60E1K4csu--

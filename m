Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 Mar 2018 11:03:31 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.99]:44954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994661AbeCEKDUROKtp (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 5 Mar 2018 11:03:20 +0100
Received: from saruman (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9AD2A20856;
        Mon,  5 Mar 2018 10:03:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AD2A20856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date:   Mon, 5 Mar 2018 10:03:07 +0000
From:   James Hogan <jhogan@kernel.org>
To:     Huacai Chen <chenhc@lemote.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        "Steven J . Hill" <Steven.Hill@cavium.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>
Subject: Re: [PATCH V2 1/2] MIPS: Loongson64: Select
 ARCH_MIGHT_HAVE_PC_PARPORT
Message-ID: <20180305100306.GF4197@saruman>
References: <1519871862-14624-1-git-send-email-chenhc@lemote.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="VuQYccsttdhdIfIP"
Content-Disposition: inline
In-Reply-To: <1519871862-14624-1-git-send-email-chenhc@lemote.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62806
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


--VuQYccsttdhdIfIP
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 01, 2018 at 10:37:41AM +0800, Huacai Chen wrote:
> Commit a211a0820d3c8e7a ("MIPS: Push ARCH_MIGHT_HAVE_PC_PARPORT down to
> platform level") moves the global MIPS ARCH_MIGHT_HAVE_PC_PARPORT
> select down to various platforms, but doesn't add it to Loongson64
> platforms which need it, so add the selects to these platforms too.
>=20
> Fixes: a211a0820d3c8e7a ("MIPS: Push ARCH_MIGHT_HAVE_PC_PARPORT down to p=
latform level")
> Signed-off-by: Huacai Chen <chenhc@lemote.com>

Thanks, both patches applied for 4.16.

Cheers
James

--VuQYccsttdhdIfIP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlqdFdoACgkQbAtpk944
dnr9QA/9EjbcGlINhpyfbEiKdRx6pzR43abHojUDnW3B7CPe72E9z8yItnfkpbpb
GngHjdGEfxoXlMWT8E2kxX/42mkiQWgGaJyf+xdAf/EvYFJovRO74PjCxu7nPT2i
efHpvFGPuKZ6FLji6I0iuvHCJoikKHjzkDGdyujl49oc9CIsdY0zlpdhYw9a3n0C
rmK+3nx1YbSsieuwUwTk3RhiYRgJMtUp29pwi6CcZCRlJRu/nRdnH5bc7Q5wbxeF
FCg1XBIezE/gRoc2eyyfC+OnrEHSMHk6LuEBl7cT4n7EBDzFxnDjmOW3I1onxLwf
7fomYbsgT4CaM9KOWW1AdkrfmX5WaNAOV1xXo3rkfup6hijioK03Vz5g3SS2nVDo
VhqPxGFoCp2W3zdnOKPVdPapCL00ILEtnNV//ut+O/OwhZXOAhuBrez1FMrKgvMy
Phj5c8vdi8ZPzj2DDQBflFInX/BruP+mOB0GHbMiWpYtqhegtLX/lxHrDyAMZpzI
9fGgRJ5wF2wBacNcPIEdi2H6kg0XOF7PbIiDVXGnYxeXusGtDa+eajHEBujao0vq
oHym9yWENOnpGIiNYGpFn0ok1Yt+ctF4plZO15VDsorzQr8Nz8Epxwul+np2Aakj
QM7NK02JsEgvBHNROZztyctKV4++6UdnhVTDpc9uJBgHJQlUgjw=
=KaG7
-----END PGP SIGNATURE-----

--VuQYccsttdhdIfIP--

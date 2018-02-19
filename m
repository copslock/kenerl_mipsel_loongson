Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Feb 2018 00:07:41 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.99]:60270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994664AbeBSXHbo2FJh (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 20 Feb 2018 00:07:31 +0100
Received: from saruman (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B91462177B;
        Mon, 19 Feb 2018 23:07:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B91462177B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date:   Mon, 19 Feb 2018 23:07:20 +0000
From:   James Hogan <jhogan@kernel.org>
To:     Huacai Chen <chenhc@lemote.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        "Steven J . Hill" <Steven.Hill@cavium.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>
Subject: Re: [PATCH V2 08/12] MIPS: Align kernel load address to 64KB
Message-ID: <20180219230719.GC6245@saruman>
References: <1517022752-3053-1-git-send-email-chenhc@lemote.com>
 <1517023336-17575-1-git-send-email-chenhc@lemote.com>
 <1517023336-17575-2-git-send-email-chenhc@lemote.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="da4uJneut+ArUgXk"
Content-Disposition: inline
In-Reply-To: <1517023336-17575-2-git-send-email-chenhc@lemote.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62627
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


--da4uJneut+ArUgXk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 27, 2018 at 11:22:15AM +0800, Huacai Chen wrote:
> KEXEC assume kernel align to PAGE_SIZE, and 64KB is the largest
> PAGE_SIZE.

Please expand, maybe referring to sanity_check_segment_list() which does
the actual check. Maybe something like this:

 Kexec needs the new kernel's load address to be aligned on a page
 boundary (see sanity_check_segment_list()), but on MIPS the default
 vmlinuz load address is only explicitly aligned to 16 bytes.

 Since the largest PAGE_SIZE supported by MIPS kernels is 64KB, increase
 the alignment calculated by calc_vmlinuz_load_addr to 64KB.


I suppose it'd be a bit ugly for the kexec userland code to increase the
size of the load segment downwards to make it page aligned...

>=20
> Signed-off-by: Huacai Chen <chenhc@lemote.com>
> ---
>  arch/mips/boot/compressed/calc_vmlinuz_load_addr.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>=20
> diff --git a/arch/mips/boot/compressed/calc_vmlinuz_load_addr.c b/arch/mi=
ps/boot/compressed/calc_vmlinuz_load_addr.c
> index 37fe58c..1dcaef4 100644
> --- a/arch/mips/boot/compressed/calc_vmlinuz_load_addr.c
> +++ b/arch/mips/boot/compressed/calc_vmlinuz_load_addr.c
> @@ -45,11 +45,10 @@ int main(int argc, char *argv[])
>  	vmlinuz_load_addr =3D vmlinux_load_addr + vmlinux_size;
> =20
>  	/*
> -	 * Align with 16 bytes: "greater than that used for any standard data
> -	 * types by a MIPS compiler." -- See MIPS Run Linux (Second Edition).
> +	 * Align with 64KB: KEXEC assume kernel align to PAGE_SIZE

"Align to 64KB: kexec needs load sections to be aligned to PAGE_SIZE,
which may be as large as 64KB depending on the kernel configuration".

>  	 */
> =20
> -	vmlinuz_load_addr +=3D (16 - vmlinux_size % 16);
> +	vmlinuz_load_addr +=3D (65536 - vmlinux_size % 65536);

Personally I find (64 * 1024) (or even SZ_64K) easier to read, but no
big deal.

Thanks
James

--da4uJneut+ArUgXk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlqLWKcACgkQbAtpk944
dnqMfQ//QMrdugVsYDFS+FByrY6qnvU0u/rNP8JV3c8vDnDy0YK+ZNxSRXxCchh2
h/iY6TNHQb2VG9fLoCnzXEyT8dAYDPpr3jWqdTrVx2mmtm6utQatWY+rAgYb4cw9
cJKi8Cz6zhHchyTumdaoFMhnjx2RJB4Ijg6uYCqyWGh9qNgZblKSFRy3Jf7EM9lW
ZqrDriAHrj1TfscUAf2pkmnJ0rgG9eGR6azmaEJzBeuKBgvWmzO5N112nxclvfxW
Dd05IeyoOpzdsM6AAeedGrMjzyh0Hp8iew4gK8twtwst12ydsIaW9uC9eX+mkPcs
VXr6+5oy23zaWmMcd2+BMrkaw5IOY9LW7J/Ib8fi77+NOtoAgSVr205egw0VRj7+
BnAL5ctSDukq6NsbgHhKe9e+wuMQcATQ5xZcLTAefk6QmwdWF8VkF60BkPmj7fL8
thUNeQTJWCvMsXrS2jf+u8NN9JH/2qDFHBd9Saku4K1czk3QZvYj4ZJlsS06NpQP
3geCwkYZqX8/wyDeJ47rOVw+o8+gRQ0asq0bZLQVx8V+5WPhiau5EHZDrPF8o5OX
Iwlxge2nzqJyzAlRpoWiCx65FEN5bQkLIXOeKwEakYs5915oFcffeyRauAz71UOu
/AJk7fX3wIsUsL4xxiClNTuFIOCDH2ueuGdh1kQ8tPlMVDan/FE=
=tFvT
-----END PGP SIGNATURE-----

--da4uJneut+ArUgXk--

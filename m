Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Apr 2018 23:42:39 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.99]:43434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993945AbeDEVmbgTsHD (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 5 Apr 2018 23:42:31 +0200
Received: from saruman (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 33384204EF;
        Thu,  5 Apr 2018 21:42:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33384204EF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date:   Thu, 5 Apr 2018 22:42:19 +0100
From:   James Hogan <jhogan@kernel.org>
To:     Matt Redfearn <matt.redfearn@mips.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Alban Bedel <albeu@free.fr>,
        Antony Pavlov <antonynpavlov@gmail.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS: vmlinuz: Fix compiler intrinsics location and
 build directly
Message-ID: <20180405214219.GA31336@saruman>
References: <20180403160728.GB3275@saruman>
 <1522833502-28007-1-git-send-email-matt.redfearn@mips.com>
 <b05a0ec9-d052-49c7-3e8f-2ba233d84f03@mips.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7JfCtLOvnd9MIVvH"
Content-Disposition: inline
In-Reply-To: <b05a0ec9-d052-49c7-3e8f-2ba233d84f03@mips.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63418
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


--7JfCtLOvnd9MIVvH
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 05, 2018 at 11:13:14AM +0100, Matt Redfearn wrote:
> Actually, this patch would be better inserted as patch 3 in the series=20
> since it can pull in the generic ashldi3 before the MIPS one is removed=
=20
> in the final patch. Here's an updated commit message:

Thanks Matt, applied.

Cheers
James

--7JfCtLOvnd9MIVvH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlrGmDoACgkQbAtpk944
dnpc4xAAoHemdzlAjARKsk/B0Bh7hUe9ZdFAnuN/ecqtHp0WXGJKrYq4sF5JgNqo
yEGmmIJJ0E7lgvc1x5L6acJTaJmeEw59qiW8Ihit4zho7WNSZt0+N9Z7bN7TE96l
Gi+VGM+HqAPeMqNoVISRpiqFy8gzsYJqq/7tzXmBLi7+wtJPJ2pxMWmNh5WZp7Sc
tpgBgLJO78B1tcopDCQzwT6vijhj3SIW5cH2tc7YAXmS9KtZZ8SprjTETWUHcmtK
6Nw5n7jeda4I/ZABMJh+EfXwlmDA0yETftNvl7VClXEoHiEyorY/ekZK0VeNyIwy
eJEvPsFvMZlnPAEe2Dtr+Lr6V9RHlx4ZfvVWi6kzQtdChWxP6XE5yYi42LEBnp7o
cfhwqP1KaW/179xMxI4qK7HlQ49dsLVTUk9/tfuVvQ4A4HmUe8YkuQVW/XBOOClE
EcQC8dvOLJtVpkVD0gAB/McmP6S2tUxsYNRD0DyMlD/oUA9JuClxCwaLuaESFx7n
F0jGd2rk4lTaDVYmty+y53EGj1VvJK2ySC6nopP+HEHWdpb+p1VLT68IiatLInPy
S0sJY0OKjtwozVv6zRWPK0JTNgwwz3qPU5PiOkUTiiwQ+e66w49VdkeYJlsQ+Cfs
sk3dXuBoNPN4qSFMZLeYgRr+si9cs2YVGJ70ICjn38lGbjfWz9g=
=uUCf
-----END PGP SIGNATURE-----

--7JfCtLOvnd9MIVvH--

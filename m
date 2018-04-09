Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Apr 2018 22:05:50 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.99]:57346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992009AbeDIUFmUlD6v (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 9 Apr 2018 22:05:42 +0200
Received: from saruman (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B8B021785;
        Mon,  9 Apr 2018 20:05:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B8B021785
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date:   Mon, 9 Apr 2018 21:05:30 +0100
From:   James Hogan <jhogan@kernel.org>
To:     Sasha Levin <Alexander.Levin@microsoft.com>
Cc:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: [PATCH AUTOSEL for 4.14 041/161] MIPS: Fix clean of
 vmlinuz.{32,ecoff,bin,srec}
Message-ID: <20180409200529.GA17347@saruman>
References: <20180409001936.162706-1-alexander.levin@microsoft.com>
 <20180409001936.162706-41-alexander.levin@microsoft.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="YiEDa0DAkWCtVeE4"
Content-Disposition: inline
In-Reply-To: <20180409001936.162706-41-alexander.levin@microsoft.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63475
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


--YiEDa0DAkWCtVeE4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Sasha,

On Mon, Apr 09, 2018 at 12:20:18AM +0000, Sasha Levin wrote:
> From: James Hogan <jhogan@kernel.org>
>=20
> [ Upstream commit 5f2483eb2423152445b39f2db59d372f523e664e ]
>=20
> Make doesn't expand shell style "vmlinuz.{32,ecoff,bin,srec}" to the 4
> separate files, so none of these files get cleaned up by make clean.
> List the files separately instead.
>=20
> Fixes: ec3352925b74 ("MIPS: Remove all generated vmlinuz* files on "make =
clean"")
> Signed-off-by: James Hogan <jhogan@kernel.org>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: linux-mips@linux-mips.org
> Patchwork: https://patchwork.linux-mips.org/patch/18491/
> Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>

Perhaps you're already on top of it, but this would appear to be equally
relevant to the older stable branches too?

Thanks
James

--YiEDa0DAkWCtVeE4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlrLx4MACgkQbAtpk944
dnq0FQ/9FSWP4uX0NBOiTuxYiENIbp6bvpM84Na7BB1P4K0lE6NiQZQ4oMYkH5Zw
bNxuuDK8BDD/zbzPP5sO78DzdLY/CHFr9Wzg/TjEClAfjV0o3kEL533VMX1o7AIY
TqodazVNp2e7v0APNA5B+SGu34A99TM9pSko2tcqAH7ehpFufbOXOLkD+QEtsE9E
o13OR3H0F5yzyUWQTwOKKhWeg2QFWHo7WE/cAgr5aJ0MgtFd7IiDmjtzKQKBTRVL
3WY1fguf27T6//dA+pB/9ORbpEUE1ThBJ8chbUmB9wQqlhTEIFhrblEQ6MSsO2DL
EYbiTVjZZuXGycspeTNB+srFhI3uNnp2dmATFBt1QqeDD65X9nCI/7vJrEJbWTeS
bqZAlhjzinvVqTvb4fH6iSh9M282p4F/GIJlHkAEcw3+kOwdbuG/pKcxNx/SSnlr
IX1iZq1NsyGYLfzV8d4aMTbfhLbtf9OhjxLiN0GZ74Gd9wkOoAJZLXSM7dSojsNT
D/oe5ymheW/mrjjYNvCWSmC4RVW+khOHtTf2GIrTcdHApZ151mpWsaX0a2cDyKBl
hpuNn5JnCj8hJe4XZhpvsFif1pT2c/M51PC7riAMn2MZ3ucgYWflAGCByiznsuJE
b5KLLvDa/559Ss5CVtLLyIooyrckQCO3gD7m/5+D3tgSWDw49bw=
=ZjxP
-----END PGP SIGNATURE-----

--YiEDa0DAkWCtVeE4--

Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 Feb 2015 21:32:12 +0100 (CET)
Received: from smtp.gentoo.org ([140.211.166.183]:42277 "EHLO smtp.gentoo.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27007655AbbB0UcG6gFo5 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 27 Feb 2015 21:32:06 +0100
Received: from vapier (localhost [127.0.0.1])
        by smtp.gentoo.org (Postfix) with SMTP id 4BC86340AC6;
        Fri, 27 Feb 2015 20:31:59 +0000 (UTC)
Date:   Fri, 27 Feb 2015 15:31:59 -0500
From:   Mike Frysinger <vapier@gentoo.org>
To:     Huacai Chen <chenhuacai@gmail.com>
Cc:     Linux MIPS Mailing List <linux-mips@linux-mips.org>
Subject: Re: custom kernel on lemote-3a-itx (Loongson-3A) crashes in userspace
Message-ID: <20150227203159.GS29461@vapier>
References: <20150219194617.GT544@vapier>
 <CAAhV-H5+kQm_qAz7DLV4Rk9EqB4xJjmu1NV7kKd46aneKFZO-A@mail.gmail.com>
 <20150226081425.GR6655@vapier>
 <CAAhV-H7vm61G1TP53GpskhLxC6LFEUkhiVzTFDRTiXSt9-zuvg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="G9m07da55tKJni3T"
Content-Disposition: inline
In-Reply-To: <CAAhV-H7vm61G1TP53GpskhLxC6LFEUkhiVzTFDRTiXSt9-zuvg@mail.gmail.com>
Return-Path: <vapier@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46052
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vapier@gentoo.org
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


--G9m07da55tKJni3T
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 27 Feb 2015 21:37, Huacai Chen wrote:
> We have also built good kernels with native GCC-4.6.4/4.7.2/4.8.3 (o32
> binaries).

do you have the source for those versions available ?  that way i can see i=
f=20
there's any patches we should pick up in Gentoo for mips.

> So maybe this is an N32-related problems.

that would not surprise me :).  we like to push the envelope in Gentoo.
-mike

--G9m07da55tKJni3T
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJU8NQ/AAoJEEFjO5/oN/WB9hYP/0vpxkLImz9XN389GNuyxGFf
6nl6nJiGtBnlEPTM2XgEOigBBhsfdHRpf1UXo5QIX7DbNzO9idbBACi72URSDvv2
1FgRPC3WUXqWzF8rOOPKI+8QSP2D7uTHm5FnBDsrkggxTmOLvq/OLGfYqi5FGsq2
Aw1RIRL1jtTiGCAJfYzhjzPeX87F1mAt339Z9Q41rWnEWtkF4kaW5cqszFuCxeQY
9nMcl/E1aySHzSl3A6dgklNr1rIAjzGAPWjN8w6FcDONIr/QjFbyvJ0bAGNhuAvz
OtfkeWNwYpV4Jt8p1JHfLmtUMq2aNrG6J8yVT97t+cnIfZd5oVoqrZHVwhmO8CrN
ovts5pe8SYA+7arCBxFzluILO+hJQbATifqANkquR3BVoLWbeJnE2MTq4OwqHBo3
RLeNcrN5zQeYZ1+SPkymH05JU0Ey7uwMbfK2XSE5s/skZ1BoURc+jHZ4AazZO3TS
1CaCxavAO4Ph63RrDVG7bssm8os6iD1udcUz6cWSdLnpTldBvrnwbkojhN+CBqCx
kx5x5bn3011/rDEgVYCV/LioEhNyQ4KaJFyOXxTjONvyNFkqg0eommxe5Rrp5/Rb
zchpcfY6c+KHSvGeKVJsiWHgCMWnDoz/REPqJN5kfYJcYcLJDQHpuBt154YkLRdL
RckkWqO6b9BZ2wXQbN+6
=CiGr
-----END PGP SIGNATURE-----

--G9m07da55tKJni3T--

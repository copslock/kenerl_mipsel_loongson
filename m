Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Apr 2018 10:52:29 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.99]:58308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993124AbeDCIwV30uxO (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 3 Apr 2018 10:52:21 +0200
Received: from saruman (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EB3A12178F;
        Tue,  3 Apr 2018 08:52:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB3A12178F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date:   Tue, 3 Apr 2018 09:52:10 +0100
From:   James Hogan <jhogan@kernel.org>
To:     r@hev.cc
Cc:     ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: Avoid to cause watchpoint exception in kernel mode
Message-ID: <20180403085209.GB31222@saruman>
References: <20180330091721.11712-1-r@hev.cc>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="TRYliJ5NKNqkz5bu"
Content-Disposition: inline
In-Reply-To: <20180330091721.11712-1-r@hev.cc>
User-Agent: Mutt/1.7.2 (2016-11-26)
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63384
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


--TRYliJ5NKNqkz5bu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 30, 2018 at 05:17:21PM +0800, r@hev.cc wrote:
> From: Heiher <r@hev.cc>
>=20
> The following program cause an endless loop in kernel space:
>=20
> 	#include <stdio.h>
> 	#include <unistd.h>
> 	#include <signal.h>
>=20
> 	int
> 	main (int argc, char *argv[])
> 	{
> 		char buf[16];
>=20
> 		printf ("%p\n", buf);
> 		raise (SIGINT);
>=20
> 		write (1, buf, 16);
>=20
> 		return 0;
> 	}
>=20
> 	# gcc -O0 -o t t.c
> 	# gdb ./t
> 	(gdb) r
> 	(gdb) watch *<printed buf address>
> 	(gdb) c

Please add more explanation so that a future reader can see what the
problem was and how you fixed it.

Thanks
James

--TRYliJ5NKNqkz5bu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlrDQLkACgkQbAtpk944
dnoFzQ/6Aj77ROXSmdunuPpFB+MO6f1x08DZneVsceXX+b96KBSj/Bf0FRj+f6ie
wUVaw8Zp9MZX522oOCjWod8mpGlZyxmd8+5lWTEWPBv1qJDQboTiffYwAktCdOJj
CtviASmn3YfQJQdxUx2V//w+BUSqQAWbpuTeAS29WO5Tmi4eK3rsGslM2BOkQiL7
+Fnl5Bgb5nmK84dMDAigC+0kohQUJ6ea1W7SuEG7KyrtAaDNS2eWmq9PS3X+fiv+
uS503pOGJvDVBN3sxGK0V7cwxiAkhWfdii3NQDGUuKLY6GBM/wm+bbeJC6SRyqVK
VXdKOkWttUO07AwkQfGrVJ4krLu7/V+a2kx53TUoD7+XdlY21NoYclHYfT+wPZI9
LBvcjzfeNmkGIRG2qWDnx07Bz88WG4VExTTOL1PPA8MqK0aXG6N22fF6iyCXhFfw
fn1o3bS1LUHME4y+PVJSKzPCyiOQAeT1ME4FlXDoPviSMKhsHOKUiKTjbuIbUSKN
wzMR7SKXxz1iqnODXOrIwEZJkdODCZysFlbtyqjv+VjCDcSIegMUTT4QDvd3bhq7
uZZABtWxChS/Ft6inx6yf/k6u0eQUWMCZrlGdMRDjnddOvf0GBu8Z6uRe9n/uA7V
N9+vDdbs9ZhsCb1qOqyHrvN01/4g8TQn/E+BmKWWT1OtVD50wCA=
=k/Gn
-----END PGP SIGNATURE-----

--TRYliJ5NKNqkz5bu--

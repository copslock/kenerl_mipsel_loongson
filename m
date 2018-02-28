Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Feb 2018 11:04:34 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.99]:33920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990498AbeB1KE2QvNRr (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 28 Feb 2018 11:04:28 +0100
Received: from saruman (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D4D3B21782;
        Wed, 28 Feb 2018 10:04:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4D3B21782
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date:   Wed, 28 Feb 2018 10:03:54 +0000
From:   James Hogan <jhogan@kernel.org>
To:     Huacai Chen <chenhc@lemote.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        "Steven J . Hill" <Steven.Hill@cavium.com>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>
Subject: Re: [PATCH V2 00/12] MIPS: Loongson: new features and improvements
Message-ID: <20180228100353.GP6245@saruman>
References: <1517022752-3053-1-git-send-email-chenhc@lemote.com>
 <20180215110506.GH3986@saruman>
 <CAAhV-H7RMmtcc6BW7dCnZ617dx5ZZrzvbFTUekGSgLYCkZfZEw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ga5bsqHr1s/xcZEm"
Content-Disposition: inline
In-Reply-To: <CAAhV-H7RMmtcc6BW7dCnZ617dx5ZZrzvbFTUekGSgLYCkZfZEw@mail.gmail.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62734
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


--ga5bsqHr1s/xcZEm
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 28, 2018 at 10:23:09AM +0800, Huacai Chen wrote:
> Hi, James,
>=20
> I really don't want send many patches in a seris. But in practise, my
> single patch in linux-mips usually be ignored (even they are very
> simple and well described)....

Then please feel free to reply to the patch and ask if anybody has
feedback, stating how important the patch is for you, so it can be
prioritised. Resends as part of other series just adds to the noise.

>=20
> For example:
> https://patchwork.linux-mips.org/patch/17723/

Yes, that one needs a proper look.

> https://patchwork.linux-mips.org/patch/18587/

This one apparently knowingly breaks the feature on other platforms, so
can't really be applied as is. I think Matt Redfearn & I were thinking
his single IPI stuff could potentially be helpful there too.

> https://patchwork.linux-mips.org/patch/18682/

You sent that this morning so its hardly had time to be ignored, and I
had already spotted it on my phone and intended to apply it today. Also
I disagree that "Commit x breaks Loongson64 platforms, so fix it" counts
as well described, even if it is simple, and obvious (to me at least)
what you're talking about.

E.g. a better description would along the lines of:

Commit 7a407aa5e0d3 ("MIPS: Push ARCH_MIGHT_HAVE_PC_SERIO down to
platform level") moves the global MIPS ARCH_MIGHT_HAVE_PC_SERIO select
down to various platforms, but doesn't add it to Loongson64 platforms
which need it, so add the selects to these platforms too.

>=20
> Anyway, thank you for your susggestions, I will rework other patches.

Thank you.

Cheers
James

--ga5bsqHr1s/xcZEm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlqWfoMACgkQbAtpk944
dnqVWhAAhEIZw6k4regI0CfdpEN6Voo2JM9yBjoAXL7tJAPNoW+flKGmGVxSjMFo
6xExXGk1m+B5K78vIKWC8DVN3sPGHIBy0Wgq9xkBKdomyVmFWdw6jznvHFNtZhot
advdTYCp0jcWoeSM6jYUJuC8fZeMHTPvUrHFhE0hZCfm4tyOnTaBoiGgG609IvAy
UY1F085hiWF9jHMy58tTLxQYDVHXPx95RVQn95riDn6lscR4hCs0K6YHxv+LpV98
AAVFhBeRU1WCm/OnjmqgL9ALx7Tr2RqgorYBgj6yjahlQcmOyes/H+62TRs3dBqb
b2R3iTdgeoSeW9qH5TjbaqCq4vkit+EFi6oJd2WqJaDjAtTlwJkt8qRettCVfd4W
3iK1+aJZ3NU5NJw4SCbvLvW5pKPap6eux1KiULYavsWm9QAxxW3/ljl+vPTfpJ0j
oz4/bExKWZ23sziNxchZHYGQoV6YZOQCOZzyzsQzXC/5hvYa4RtCcT0ZFvPTH6GE
5jRgu6FeJJgmqDapWjX0sog6FojgVJoYdS9dzdD3Mzlt1e0fEsWBJcFhm1KOC08v
+KSgvwySxs8AT4pP57RdqJ2SHG7iHeK0tmMg3dVHTU7i3dujRYd+IqgTWrFRkKxj
NZImom/Q29w9T+YVH88wW3bx9SsVMmAPTprORTJZ25rkz1dQuFk=
=CGAu
-----END PGP SIGNATURE-----

--ga5bsqHr1s/xcZEm--

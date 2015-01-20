Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Jan 2015 10:14:24 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:37758 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27011100AbbATJOWVHFTr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 20 Jan 2015 10:14:22 +0100
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id EE67A41F8D6A;
        Tue, 20 Jan 2015 09:14:16 +0000 (GMT)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Tue, 20 Jan 2015 09:14:16 +0000
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Tue, 20 Jan 2015 09:14:16 +0000
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id F2EA5CBA7FC5;
        Tue, 20 Jan 2015 09:14:14 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Tue, 20 Jan 2015 09:14:16 +0000
Received: from localhost (192.168.154.110) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Tue, 20 Jan
 2015 09:14:14 +0000
Date:   Tue, 20 Jan 2015 09:14:15 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     "Maciej W. Rozycki" <macro@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>,
        <linux-mips@linux-mips.org>,
        Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
Subject: Re: [PATCH RFC v2 27/70] MIPS: kernel: cevt-r4k: Add MIPS R6 to the
 c0_compare_interrupt handler
Message-ID: <20150120091414.GA23188@jhogan-linux.le.imgtec.org>
References: <1421405389-15512-1-git-send-email-markos.chandras@imgtec.com>
 <1421405389-15512-28-git-send-email-markos.chandras@imgtec.com>
 <alpine.LFD.2.11.1501200110040.28301@eddie.linux-mips.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="LZvS9be/3tNcYl/X"
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.11.1501200110040.28301@eddie.linux-mips.org>
User-Agent: Mutt/1.5.22 (2013-10-16)
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: da4c5968
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45356
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

--LZvS9be/3tNcYl/X
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Maciej,

On Tue, Jan 20, 2015 at 01:22:24AM +0000, Maciej W. Rozycki wrote:
> On Fri, 16 Jan 2015, Markos Chandras wrote:
>=20
> > From: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
> >=20
> > Just like MIPS R2, in MIPS R6 it is possible to determine if a
> > timer interrupt has happened or not.
> >=20
> > Signed-off-by: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
> > Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
> > ---
>=20
>  While a preexisting bug, this is simply not true, there's CP0.Cause.TI t=
o=20
> examine for a timer interrupt pending.  Please fix your change to use=20
> `c0_compare_int_pending' instead and synchronise with stuff posted by=20
> James (cc-ed) at <http://patchwork.linux-mips.org/patch/8900/>.

I'm not sure I follow what you mean. This change makes it treat r6 like
it treats r2 (i.e. there is still a Cause.TI bit), which sounds correct
to me. I'm guessing cpu_has_mips_r6 doesn't imply cpu_has_mips_r2.

Cheers
James

--LZvS9be/3tNcYl/X
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUvhxmAAoJEGwLaZPeOHZ6M5wQAL2xVd0LYrRgejVtBm0vtWQE
CVWI1ab+ERiMzyVCD4a9vMrvgUnwENDs8qLDRMjw2Swbk3y5EiP8tj0Xd2mlWRIn
YuYHO65xP1z0HtIQ2carhA68WquemUh+K8ZUa3Gj/aBlTxAQailmbtSAlBsbFZ0w
eB/K1CikZRkfOv/3+s2iwTlL0P9To63FA4/ZQvgUPsOj8/hkmPbz1/Abfserfi97
83TH7vt7rjwZMbXdSOsHPzxydQXwQm9evBVQvftPF0UQT5TRKDCNLLJCXHndA3kP
0aTsfH2gPNB06Gn1gecZY5JZhz3ppRB1hMvt69TBGZ+F2WvOoGV/yZ87/KdWqXe3
6j1eUYr8bGQm9YW7fflF9Z7Jx9PqyDbKlpsc8XcW1XTdNW6pwMQcKr9tvQpyNE0A
5fclY1ndkSY5EMYZmKmp4Fm5Zl9elw88FwSzjJz0VtVrPVMo+rieucaIlSBikPre
tHI9dg0rMJmxnh4/1oLYjZ42R0CmsUk2dhLhooa4Iv9VcUuTe0ML74E1lbcf1Q20
Mzoyu69a4I4c9IZGRLIatd7jvcOAlpQcIpqQP5AL6ym8uLnOfveHdmlvwB0QT0Rf
bwgjJyGpmUgOhhroceSw7G6t1nayeSpUEzkgxzR7U9RSvKbDSSYHV8Me6lH4JFC2
Q4Hlg8aS9O3ezA2/us/O
=V5u6
-----END PGP SIGNATURE-----

--LZvS9be/3tNcYl/X--

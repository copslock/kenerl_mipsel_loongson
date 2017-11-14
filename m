Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Nov 2017 22:45:35 +0100 (CET)
Received: from 19pmail.ess.barracuda.com ([64.235.154.231]:39602 "EHLO
        19pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990765AbdKNVp16U0ov (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 14 Nov 2017 22:45:27 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx1403.ess.rzc.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Tue, 14 Nov 2017 21:44:56 +0000
Received: from localhost (192.168.154.110) by MIPSMAIL01.mipstec.com
 (10.20.43.31) with Microsoft SMTP Server (TLS) id 14.3.361.1; Tue, 14 Nov
 2017 13:44:01 -0800
Date:   Tue, 14 Nov 2017 21:43:59 +0000
From:   James Hogan <james.hogan@mips.com>
To:     Dave Taht <dave.taht@gmail.com>
CC:     <netdev@vger.kernel.org>, <linux-next@vger.kernel.org>,
        <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [net-next,1/3] netem: convert to qdisc_watchdog_schedule_ns
Message-ID: <20171114214359.GI15235@jhogan-linux>
References: <1510088376-5527-2-git-send-email-dave.taht@gmail.com>
 <20171114211112.GA28794@jhogan-linux.mipstec.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="yQrIXZbGokyKU1X6"
Content-Disposition: inline
In-Reply-To: <20171114211112.GA28794@jhogan-linux.mipstec.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
X-Originating-IP: [192.168.154.110]
X-BESS-ID: 1510695895-321459-2387-26865-2
X-BESS-VER: 2017.14-r1710272128
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.186930
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Return-Path: <James.Hogan@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60938
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@mips.com
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

--yQrIXZbGokyKU1X6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 14, 2017 at 09:11:12PM +0000, James Hogan wrote:
> On Tue, Nov 07, 2017 at 12:59:34PM -0800, Dave Taht wrote:
> > diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
> > index db0228a..443a75d 100644
> > --- a/net/sched/sch_netem.c
> > +++ b/net/sched/sch_netem.c
>=20
> ...
>=20
> > @@ -305,11 +305,11 @@ static bool loss_event(struct netem_sched_data *q)
> >   * std deviation sigma.  Uses table lookup to approximate the desired
> >   * distribution, and a uniformly-distributed pseudo-random source.
> >   */
> > -static psched_tdiff_t tabledist(psched_tdiff_t mu, psched_tdiff_t sigm=
a,
> > -				struct crndstate *state,
> > -				const struct disttable *dist)
> > +static s64 tabledist(s64 mu, s64 sigma,
>=20
> sigma is used in a modulo operation in this function, which results in
> this error on a bunch of MIPS configs once it is made 64-bits wide:
>=20
> net/sched/sch_netem.o In function `tabledist':
> net/sched/sch_netem.c:330: undefined reference to `__moddi3'
>=20
> Should that code not be using <linux/math64.h>, i.e. div_s64_rem() now
> that it is 64bit?

For the record, Dave has kindly pointed me at:
https://patchwork.ozlabs.org/project/netdev/list/?series=3D13554

which fixes the MIPS builds.

Cheers
James

--yQrIXZbGokyKU1X6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAloLY54ACgkQbAtpk944
dnq0QRAAkHn5lPXmd6rYgKNJteDly4FsWam1JD8LsCZ433WAjDs4D7T/2vO6kAS2
F3slScj5FuIe61pQEGRMSPEqjF6FaE6gHnhKB0dpAzyYwDAS+pp76cldzJYu0xXU
Uyapaw4C+eaMSYT9/XVTaFBfke1O2GbXzYwTaCcM549fvqQ2ZRB4AIwoukuCyya6
+0Cmkeq0R0zfE5IpIvxC8QAVVVAPb5rSDzBRCsQrxYVQKiZtzKdz0xv43WMnmD1R
Ge4XX4nh1GpAM5G9ZR5lc898dRS+7Swfo/zbaCVcXWs1IoNrW/Q4KmNC8zB4Yq6z
BJ/QGzjzi3jCj0d7V4rwVbmSa9BWz3P6CCmYvt6fWn+/AEWhgUoRszEaaLJo3yY6
r0z8tXMxBlzBH/ObhSzqPo7pfeUyCx/UOKxlHPSQDtZXFkN88xcnJ9W88BntVE0a
S583Y5jM+LPZnJ3R4i1ivZ48L9hFjxcrSqCLd0EUFlCPbkGzyroZRunjLmfPgY+j
lo2MVnTeLh09NBxPoYsLVa7E6aYdl5NNx2xIb1nYbRlEJhUK9sLqJsfUppsDprLY
vO6HYyIlxP6GieMxfC99vcXwbN1QMGliGmpv8F1syIWZZJ9hwJFoOngtaIgkStCj
Bx9OKtBv6fwcdZ/FQoh+v6ENhMiCIv+GBlEXqHxX481QxJh4aXk=
=lRir
-----END PGP SIGNATURE-----

--yQrIXZbGokyKU1X6--

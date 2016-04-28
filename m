Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Apr 2016 18:36:54 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:19531 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27027451AbcD1Qgwg0Wv8 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 28 Apr 2016 18:36:52 +0200
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id 27B3E41F8E9D;
        Thu, 28 Apr 2016 17:36:44 +0100 (BST)
Received: from mailapp01.imgtec.com ([10.100.180.242])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Thu, 28 Apr 2016 17:36:44 +0100
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Thu, 28 Apr 2016 17:36:44 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Websense Email with ESMTPS id 54220BF326861;
        Thu, 28 Apr 2016 17:36:40 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 HHMAIL01.hh.imgtec.org (10.100.10.19) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Thu, 28 Apr 2016 17:36:43 +0100
Received: from localhost (192.168.154.110) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.266.1; Thu, 28 Apr
 2016 17:36:43 +0100
Date:   Thu, 28 Apr 2016 17:36:43 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     "Maciej W. Rozycki" <macro@imgtec.com>, <linux-mips@linux-mips.org>
Subject: Re: [PATCH 3/4] MIPS: malta-time: Don't use PIT timer for cevt/csrc
Message-ID: <20160428163643.GD2467@jhogan-linux.le.imgtec.org>
References: <1461345557-2763-1-git-send-email-james.hogan@imgtec.com>
 <1461345557-2763-4-git-send-email-james.hogan@imgtec.com>
 <alpine.DEB.2.00.1604221951290.21846@tp.orcam.me.uk>
 <20160422192312.GM7859@jhogan-linux.le.imgtec.org>
 <20160422192906.GO24051@linux-mips.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="TybLhxa8M7aNoW+V"
Content-Disposition: inline
In-Reply-To: <20160422192906.GO24051@linux-mips.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: ebfc6934
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53245
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

--TybLhxa8M7aNoW+V
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 22, 2016 at 09:29:07PM +0200, Ralf Baechle wrote:
> On Fri, Apr 22, 2016 at 08:23:12PM +0100, James Hogan wrote:
>=20
> > >  Not everyone uses virtualisation, so it's a functional regression fo=
r=20
> > > them.  Can't you lower the priority for the timer instead so that it =
is=20
> > > not selected by default, just as it's done with other platforms provi=
ding=20
> > > a choice of timers?
> >=20
> > I'll look into that. Looking back at my IRC logs I suspect I meant to
> > check why the PIT was taking priority before submitting upstream, but
> > forgot.
>=20
> The PIT already has a very low rating and should only be used if everythi=
ng
> else fails.  Clock scaling for example would make the cycle counter
> unusable, there might be no GIC available etc.  Otoh with SMP the PIT is
> only usable as a clock source but not clock event device.

I can't even reproduce the problem any longer. Even with the PIT drivers
loaded and a message in the log about PIT clocksource it doesn't seem to
be used, so we can just drop this one anyway. I've marked this patch as
rejected in patchwork. Sorry for the noise.

Thanks
James

--TybLhxa8M7aNoW+V
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXIjwbAAoJEGwLaZPeOHZ6WYQP/3twJUaDi0YbVzaFxfWqOAGI
EAuIU+Js0pi0XibTh74riAInmXPU7W7L/h6hZsDXIp/zLZ8WphPilAs39A2qy4cO
AhJvxbI4MXt598BVlOjNPIdCl9vjndrl3/BclZlsDT3bWiPKvwevvs9BNQzljp+J
0T+3c9GDSTuymzfUTS49faToKlkvwWSVcbgqD0ltkvtve1W59UCGX48qXjrEeJvQ
CZ4wXPIxjbyvuKbLCgFTcgfU7R2JqA7e/6GFn88a3rniNSGiG6H4crAFMpX/CYj6
a1TCchOVxQ2KjJLX3KR9BlcwrdicSoSlP+en5EnbESdfJgJDyBEva9jZkpuSZfpb
X59s3KRsDqLu7tK/a+EBW45n0H7cnHuiL9FGFbVL2Hvvz6rHdr+OvD5/sJc4SsXZ
jDFrYgbEw1w0dzbqEYAlUmO5WGrnz+wfhQVvqqDTcsQPjF1UqoIl82Y/1h/uTu/b
cKq63DWJ2zt6Ff8hLaVQMTI19T10m0BzyYlD8HoyLgH/j6DemI0SENn+9awNWVsU
0RVEzsAgawJKTWtSlutAYyp/ggIljSldsLPr8QNf6JG+sztQdEHvYmdAym6UCvZi
cQhGeOUcQRJHxqm9Q2sS1/MsBXSIgBcQMJVilE2utzIR1KO4Lx0ba6MuU1lhs9Ox
vnKiSgHHTtf/XYPgRCnh
=j4rr
-----END PGP SIGNATURE-----

--TybLhxa8M7aNoW+V--

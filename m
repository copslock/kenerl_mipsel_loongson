Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Feb 2017 19:34:48 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:14908 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23993177AbdBISejT8bFY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 9 Feb 2017 19:34:39 +0100
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id 2B1C641F8E7D;
        Thu,  9 Feb 2017 19:38:18 +0000 (GMT)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Thu, 09 Feb 2017 19:38:18 +0000
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Thu, 09 Feb 2017 19:38:18 +0000
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id EB05CACC8502B;
        Thu,  9 Feb 2017 18:34:29 +0000 (GMT)
Received: from localhost (192.168.154.110) by hhmail02.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Thu, 9 Feb
 2017 18:34:33 +0000
Date:   Thu, 9 Feb 2017 18:34:33 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     "Maciej W. Rozycki" <macro@imgtec.com>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>,
        <linux-mips@linux-mips.org>
Subject: Re: [PATCH v2] MIPS: Fix protected_cache(e)_op() for microMIPS
Message-ID: <20170209183433.GA24226@jhogan-linux.le.imgtec.org>
References: <20170209140453.26188-1-james.hogan@imgtec.com>
 <alpine.DEB.2.00.1702091724300.26999@tp.orcam.me.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="jRHKVT23PllUwdXP"
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1702091724300.26999@tp.orcam.me.uk>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: 1b7d744b
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56747
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

--jRHKVT23PllUwdXP
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 09, 2017 at 05:28:39PM +0000, Maciej W. Rozycki wrote:
> On Thu, 9 Feb 2017, James Hogan wrote:
>=20
> > Ralf: This fixes microMIPS build since a patch that is already merged
> > into kvm/next. I was going to send you a pull request for those patches
> > anyway, so it probably makes sense if I just append to that branch first
> > and let the fix get upstream via the MIPS tree.
> >=20
> > Changes in v2:
> > - Correct description, its the .section, not any following assembly
> >   which triggers the issue (Maciej)
>=20
> Reviewed-by: Maciej W. Rozycki <macro@imgtec.com>

Thanks Maciej,

Cheers
James

--jRHKVT23PllUwdXP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYnLYPAAoJEGwLaZPeOHZ6TIIP/RuwYq88jlHyms971J5D1FXo
bAsae8GNPYK7iWi0rGNNQGlEdcccGCXRbSzcYTGc/XVT6/ZnuabNczxVZEd1HDt9
/Fk9Walkp+FJsq1GA/z8Sd/aQa2KfPqLzYFx5BmoBBNIOLSDRyaq8H4ivZ4bP6RU
6wRD5DTY08M2gvk3OBC2lAXOEVN5ykM+wW1J1hPgdiyJ0KbD1+odHKV8tQJTlFv/
h74S6nnhmeUnsEeABwX7oNeXfmUk2YIZMKazQYAwYJIhpdD4J1auZdiRGySABQiT
qKkAXGWLgXwsRbt3lLGLtcBFmBQKw6ZHeTENm4wRb14sHjSv4HW7UjR1WpDFapke
+m7tsmtfUwCXwSPtJl3GFfjqotdsISnQqfvppoGJ8QPGZZyZDw3e7f63bgrVZsJs
jgizZpOOVbGowg0VL2mw9Yan2CxgU3umVFyihWEP2ThaY/B9qtBYyI0txNzhamWX
ZMCBlbSQm2WPR137ES9S8aWFw4gBVhMaxI0bKX+eWa5DB+hSbhrkWIkiWrltJ6DU
UYC9I6ktvtx+sCvTX6nootLKWrPQu54AKd4XX2QfTO1Tgw+tPo9QS2Nc03rPMRDb
MeV860gDbK5wdozw424O+Bu0XB8ycrO3b5C0UpBMKp4acNvSRVzmg9dlAK0LKtiK
m4bOLqS0+gDTwH0oBCL2
=Z6lw
-----END PGP SIGNATURE-----

--jRHKVT23PllUwdXP--

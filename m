Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Oct 2016 21:27:29 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:51311 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23993040AbcJTT1DQB8FP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 20 Oct 2016 21:27:03 +0200
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id 8ECB241F8EB6;
        Thu, 20 Oct 2016 20:26:27 +0100 (BST)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Thu, 20 Oct 2016 20:26:27 +0100
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Thu, 20 Oct 2016 20:26:27 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 21658F59F3558;
        Thu, 20 Oct 2016 20:26:53 +0100 (IST)
Received: from localhost (192.168.154.110) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Thu, 20 Oct
 2016 20:26:57 +0100
Date:   Thu, 20 Oct 2016 20:26:57 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
CC:     Paolo Bonzini <pbonzini@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        <linux-mips@linux-mips.org>, <kvm@vger.kernel.org>
Subject: Re: [GIT PULL] MIPS KVM fix for v4.9-rc2
Message-ID: <20161020192657.GN7370@jhogan-linux.le.imgtec.org>
References: <1476971554-1215-1-git-send-email-james.hogan@imgtec.com>
 <20161020180449.GC8569@potion>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="gBYU9MM4gf8jKg2V"
Content-Disposition: inline
In-Reply-To: <20161020180449.GC8569@potion>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: 1b7d744b
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55528
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

--gBYU9MM4gf8jKg2V
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 20, 2016 at 08:04:50PM +0200, Radim Kr=C4=8Dm=C3=A1=C5=99 wrote:
> 2016-10-20 14:52+0100, James Hogan:
> > Hi Radim, Paolo,
> >=20
> > The following changes since commit 1001354ca34179f3db924eb66672442a1731=
47dc:
> >=20
> >   Linux 4.9-rc1 (2016-10-15 12:17:50 -0700)
> >=20
> > are available in the git repository at:
> >=20
> >   git://git.kernel.org/pub/scm/linux/kernel/git/jhogan/kvm-mips.git tag=
s/kvm_mips_4.9_2
> >=20
> > for you to fetch changes up to d852b5f35e84e60c930589eeb14a6df21ea9b1cb:
> >=20
> >   KVM: MIPS: Add missing uaccess.h include (2016-10-19 00:37:05 +0100)
> >=20
> > I'd already based this on v4.9-rc1 rather than the kvm next branch which
> > isn't up to v4.9-rc1 yet. If thats a problem I can easily rebase, or
> > feel free to apply the patch directly.
>=20
> Not a problem, I would have done that anyway.
>=20
> Pulled, thanks.
>=20
> Btw. patches for -rc2+ kernels ought to be based on kvm/master.
> It doesn't matter now, but kvm/master and kvm/next will diverge at -rc3
> (max 4), when patches intended for 4.10 are going to be applied to
> kvm/next.  And kvm/next isn't rebased, so it will stay on -rc[34] until
> Linus pulls in the 4.10 merge window.

Okay cool, thanks for the info.

What is the queue branch for?

Cheers
James

--gBYU9MM4gf8jKg2V
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYCRqAAAoJEGwLaZPeOHZ6NwMQAJ5l+kOs+oghf3gHe4DQy9ZY
QN9cuhUrEXOIPDG84hjIlhTG8cUuRlbz+2aCQp3wnr28DwLIi9OJDs8cRuzpLhhf
1cWRiIT+oGJOs1LENIGOPtEfKmubEnYy1y1HK+7OQAKg7xjm7sBJLy5HUPfa2H3y
MmD8+BcA2DzoteUk+FdF/P617yhR1Pb2K1zelQPW9VURwjJlNUXeul0ITUHFriVu
1oj6DufcRhzt7rRf2ChOlkPV17D8pFmMBcllrvnQHmtyg7ttZK2lu0iiDDlPd7e6
JcbE9e1xq+WwlzS0zYIgBKnxZ6rVD7iDa7sVOBQdNmavqV/Hmlp4sel8hm/ng6+5
xsAuajTGNODY53EgRvQPh3xEODVnAkyN+hfbEIpseNlKhM+NGhggP8rpLjiL6ICG
Gzy+v8vcqySYPiW4omdos7dK6uR79flWOdesNoX6VT8k68PUqpOU0PjPSyNoixW/
8CfEzetnYE2xIAOEb2hb18EBYCPOchm/sCJdIX65wn0aZ7xjaq1Pgsza5HiDiTSI
FcpDECbx18v2T1PgZPjppw/0mK+NJRLhJaRcs+GKLXxauseKFFFtwHYd/Gy0+AgK
HbGJu9qp1O5nvOTr4oeAfKm60EXguk19dPKuJTOsXoldErmzGZJPkCmj6twhF5K1
kgh3urzTmeGb1bHjl1R6
=7pBO
-----END PGP SIGNATURE-----

--gBYU9MM4gf8jKg2V--

Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 10 Mar 2016 21:50:15 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:54719 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27007691AbcCJUuLpyEj4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 10 Mar 2016 21:50:11 +0100
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id 541B141F8E05;
        Thu, 10 Mar 2016 20:50:05 +0000 (GMT)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Thu, 10 Mar 2016 20:50:05 +0000
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Thu, 10 Mar 2016 20:50:05 +0000
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Websense Email Security Gateway with ESMTPS id D7D57956F65FD;
        Thu, 10 Mar 2016 20:50:01 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 HHMAIL01.hh.imgtec.org (10.100.10.19) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Thu, 10 Mar 2016 20:50:04 +0000
Received: from localhost (192.168.154.110) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.266.1; Thu, 10 Mar
 2016 20:50:04 +0000
Date:   Thu, 10 Mar 2016 20:50:04 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>
CC:     Ralf Baechle <ralf@linux-mips.org>, Michal Marek <mmarek@suse.com>,
        "Andi Kleen" <ak@linux.intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "Michael S. Tsirkin" <mst@redhat.com>, <linux-mips@linux-mips.org>,
        <linux-kbuild@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <stable@vger.kernel.org>
Subject: Re: [PATCH] ld-version: Fix awk regex compile failure
Message-ID: <20160310205004.GB31414@jhogan-linux.le.imgtec.org>
References: <1457455673-12219-1-git-send-email-james.hogan@imgtec.com>
 <56E1B3C5.7040204@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="EH85xkKza2NXtwkF"
Content-Disposition: inline
In-Reply-To: <56E1B3C5.7040204@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: 56f439c
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52571
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

--EH85xkKza2NXtwkF
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 10, 2016 at 11:19:57PM +0530, Sudip Mukherjee wrote:
> On Tuesday 08 March 2016 10:17 PM, James Hogan wrote:
> > The ld-version.sh script fails on some versions of awk with the
> > following error, resulting in build failures for MIPS:
> >
> > awk: scripts/ld-version.sh: line 4: regular expression compile failed (=
missing '(')
> >
> > This is due to the regular expression ".*)", meant to strip off the
> > beginning of the ld version string up to the close bracket, however
> > brackets have a meaning in regular expressions, so lets escape it so
> > that awk doesn't expect a corresponding open bracket.
> >
> > Fixes: ccbef1674a15 ("Kbuild, lto: add ld-version and ld-ifversion ...")
> > Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> > Signed-off-by: James Hogan <james.hogan@imgtec.com>
>=20
> This error was only coming in my gitlab builds but was not showing in=20
> the build of travis-ci. Maybe it depends on the version of awk also.
> Build log at: https://gitlab.com/sudipm/linux-next/builds/839573
>=20
> Tested-by: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>

Great, that looks pretty conclusive. Thanks for testing Sudip and
Michael.

Ralf: is it too late to get this into v4.5 via MIPS tree?

Cheers
James

--EH85xkKza2NXtwkF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJW4d38AAoJEGwLaZPeOHZ64ysP/RVG0eQAAPvheI/yCFhjWUDo
Tor55GMAMBF8Wd/XExW77EVSRSpPBGc/UWaIv1LHXdCRciNIvU/awY7J4rEKYQTL
tpQIfoIwUG5oXneWFQGKVtt0W93KYOAtTQooIaBJ+tPvY4sjqLvrtI02hdbHnVzg
mzpK9Xdxy1C0aAjtZMyL9+0gAdL/ijCet2TUmvK478KvMNPp2VbFOgocMIYpC60S
MGY91pvNY8uHhMKnz30KgRFy1f/YGxkH6zcSKmW99xhUNh03PtE501Fagp8mH+24
aMI0s6qYGJxA66l28QCurZzt2l41gBGDl3DSx2MnYJp9xmTcciTJRFdrasgfF3mR
MFStIDJ2c8ilEpiVLWRKmE9HuVEbFav/mGtQYs0Y7KI2smO9CTV9AmLL86eXnD2B
wSBTOwEteCjDNrdwx8pAQp7ZwkTV0sAxkODZUXvWdEB9nJRIX2GhUNmCziBu8Tpw
X8gs7h4KFeSSgByRF+mE7sZdPwYNSf9QywX4OIOPTN43OrusrSvo/MYr18oorClm
dqLolsgo6zXLzsJiM8RaQ3XCT6ZeaVvAjq1bRH7rmJpeipDJZBte6XRqPnyvoqCi
Q5MCONCaad3K+ZqGnQTRBZPHqe/96MsQPrdlIOtYOc7w8IQBsjrIkAyHvRINIxFT
+nsPpa1GjHKeEJ5G2s9E
=FOWj
-----END PGP SIGNATURE-----

--EH85xkKza2NXtwkF--

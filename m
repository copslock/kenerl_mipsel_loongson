Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 11 Feb 2017 00:44:52 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:56368 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23992123AbdBJXonqKRHW (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 11 Feb 2017 00:44:43 +0100
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id 996C541F8D9E;
        Sat, 11 Feb 2017 00:48:25 +0000 (GMT)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Sat, 11 Feb 2017 00:48:25 +0000
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Sat, 11 Feb 2017 00:48:25 +0000
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id EC8B72553EDB4;
        Fri, 10 Feb 2017 23:44:32 +0000 (GMT)
Received: from localhost (192.168.154.110) by hhmail02.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Fri, 10 Feb
 2017 23:44:37 +0000
Date:   Fri, 10 Feb 2017 23:44:37 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     Justin Chen <justin.chen@broadcom.com>
CC:     <linux-mips@linux-mips.org>, Guenter Roeck <linux@roeck-us.net>,
        Ralf Baechle <ralf@linux-mips.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        <bcm-kernel-feedback-list@broadcom.com>
Subject: Re: [PATCH] MIPS: Fix cacheinfo overflow
Message-ID: <20170210234437.GB9246@jhogan-linux.le.imgtec.org>
References: <20170208234523.GA13263@roeck-us.net>
 <20170210230120.21588-1-james.hogan@imgtec.com>
 <d63e0019-5861-ccca-7959-631916e6c882@broadcom.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="gj572EiMnwbLXET9"
Content-Disposition: inline
In-Reply-To: <d63e0019-5861-ccca-7959-631916e6c882@broadcom.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: 1b7d744b
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56769
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

--gj572EiMnwbLXET9
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Justin,

On Fri, Feb 10, 2017 at 03:10:47PM -0800, Justin Chen wrote:
> I actually submitted a v2 of the patch sometime back located here:
> https://patchwork.linux-mips.org/patch/15107/
>=20
> The v2 had some code review changes from Matt Redfearn. These changes=20
> indirectly got rid of the error, which was why I wasn't running into the=
=20
> crash.

Ah yes. It looks like Ralf applied the original patch on January 3rd,
before the last 3 submissions of the patch.

Incidentally, in future I'd recommend incrementing the patch version
number each time you submit a new version, and mentioning what has
changed in a comment at the bottom of the commit message (anything after
"---" gets dropped when the patch is applied).

A random example:
https://patchwork.linux-mips.org/patch/15134/

>=20
> Either way, whatever makes more sense, we can drop the other v1 patch=20
> and add v2 or just add this patch on top.

Since the patch has already been applied for a while and the merge
window is imminent, I think its best to make do with fixup patches on
top this time around.

Thanks
James

--gj572EiMnwbLXET9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYnlBdAAoJEGwLaZPeOHZ69lQP/A9Dok74IIjpdhVC1Ju6IoPx
X2lsxKLFcCS6D3kqzctzxEXTGvn7sHJ7SjBeUzmpSyWj4cKGzax9ZEySyefYLJrK
io9Ddf77cEfqmyDxAGxYe5wHYwQk2i3FuBLJIOqI8BZKR6BVyzQj9fx29aPW3hT/
n7AjHquo+//gPvwUHcLV5ctjCQDkyn9CKQTyzDb1Sjm7ixvUg6T5iqFc5oODH8PG
07OheCN3WvhI0d6sEg3DQ4g+PsX821sTtduimDy2kj2v13IvoayLubvbwaj7ptsp
pc4/8wo6Ridl75I+qtg8+bX7lVx0Z5DbHgkELL/5GJsxks9QgHBychsmcGuTd5ZE
zpo3uCcQkxh4qz7BIRBRJqsXU3pgf6o/H7O9YAyDob2kYiVjDKZAmQXh6P1JKiuS
2COrjUjKPWLC1ZkjKrtWLyspBdp0uFpMTvt4fnzOP1t2a+HoQPMPxqFVoxk26zpz
ainjoNdavE8qIkg32QzzPDIkbvCxg5TDix/fa3IbTfX1YTnLNfn9NEwWJydAOYCg
cknnXjlHCkGwkgPcqAnxHNgP1xii+GFr22w0Y7yCLqEtQtHqFsXWD2uf7E8BlrR2
p+LgJCkgvMR2eAmpWpqoW4P7MzdDzx0cNtz0SkLxzJ3771iDaDXoRXrQ4PhwtVOM
k7+iMP4C974nDMTPpZDU
=+G3H
-----END PGP SIGNATURE-----

--gj572EiMnwbLXET9--

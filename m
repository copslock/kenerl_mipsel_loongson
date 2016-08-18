Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Aug 2016 12:00:50 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:63099 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23993253AbcHRKAmwqheP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 18 Aug 2016 12:00:42 +0200
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id 6518241F8D4D;
        Thu, 18 Aug 2016 11:00:37 +0100 (BST)
Received: from mailapp01.imgtec.com ([10.100.180.242])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Thu, 18 Aug 2016 11:00:37 +0100
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Thu, 18 Aug 2016 11:00:37 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id DF614BAE231ED;
        Thu, 18 Aug 2016 11:00:34 +0100 (IST)
Received: from localhost (192.168.154.110) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Thu, 18 Aug
 2016 11:00:36 +0100
Date:   Thu, 18 Aug 2016 11:00:36 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Greg KH <greg@kroah.com>
CC:     <stable@vger.kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        <linux-mips@linux-mips.org>, <kvm@vger.kernel.org>
Subject: Re: [PATCH BACKPORT 4.7 0/4] MIPS: KVM: Fix MMU/TLB management issues
Message-ID: <20160818100036.GE19514@jhogan-linux.le.imgtec.org>
References: <cover.d02ea4d58713b53527649c3ad5487b32fd8df3cd.1471018462.git-series.james.hogan@imgtec.com>
 <20160818094217.GA1509@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wl4gXchqb9PBRcq/"
Content-Disposition: inline
In-Reply-To: <20160818094217.GA1509@kroah.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: cee91754
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54608
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

--wl4gXchqb9PBRcq/
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 18, 2016 at 11:42:17AM +0200, Greg KH wrote:
> On Thu, Aug 18, 2016 at 10:01:25AM +0100, James Hogan wrote:
> > These patches backport fixes for several issues in the management of
> > MIPS KVM TLB faults to v4.7.
>=20
> Thanks for these, now applied.

Thanks Greg,

btw, is it okay to tag for stable in this way, knowing full well that
they'll all conflict and require backports?

Depending on your FAILED emails before sending backports just seemed
easier from my point of view, but if that increases any manual effort on
the part of the stable maintainers I can do it differently in future.

Cheers
James

--wl4gXchqb9PBRcq/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXtYdEAAoJEGwLaZPeOHZ6ncoP/0mowFbIUgg7T3W8kW1IBQua
utXGuallLzL/wjBZZMVADXvHsNtgd4zyZRzyVAS0WKYz0/NcBwUBAREmm5Xw1SkI
o0kTRWm67Ae6BArn1qBYPrt9FM2HToiFU133hOEeUiaeV4jxay1XmXBYX1yo28wm
hDPE5LIdd1ZuD0XzAabTl5jg4fQc5DAup2jlEEQzKdHwWjOjX4Vy10B+W1oCOdY1
mZXfNYJ3go6eOAmABMO6O3y4t/XcB9HuAlbOjb8eleuNm83ESsDo44CwEkzwoGax
RkBxnyz6IUfDbDPLnaD9z8VshLPfeT8y2c6LeUUQYUVm2iNf8h7uJ5pePZWPvsii
jI+VUIbi96nT79HJdK5rYVpaVK2F0iY0JGcMkEd0PljRLHkq5fGc6A0ZP58td3E/
Ehb58U0ujO+PRxRTrkCrQ0TSgzb2vex1hfmdk0jIEXQwSQPXo/Wp8EmNQfRyfmso
kL5m5lSAExZbl5rVJ447W1ep3/TYQ92a1c9RJ1ZbEiNdNb6S3dJ1R7a4tjdgFc4y
AodM3O8nZNUVCVpgIWLSXsRrVhAYuEMscetyHq4vHZqEbfvnUGBNE+XpXUHsIHoY
nKLN9yzBzs6TK7IOe1bVQTvzTCFZP2Ms/T+uDCqjCrwLPz8xTdZbUQXeMj3vuT/3
ZeN6IL5EpxR8aoEtAZZQ
=NmEH
-----END PGP SIGNATURE-----

--wl4gXchqb9PBRcq/--

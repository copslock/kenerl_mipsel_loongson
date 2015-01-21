Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Jan 2015 12:40:43 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:10738 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27011396AbbAULkleo4e7 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 21 Jan 2015 12:40:41 +0100
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id 72B7E41F8DC6;
        Wed, 21 Jan 2015 11:40:35 +0000 (GMT)
Received: from mailapp01.imgtec.com ([10.100.180.242])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Wed, 21 Jan 2015 11:40:35 +0000
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Wed, 21 Jan 2015 11:40:35 +0000
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id B2212A21D5D56;
        Wed, 21 Jan 2015 11:40:32 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Wed, 21 Jan 2015 11:40:35 +0000
Received: from [192.168.154.110] (192.168.154.110) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Wed, 21 Jan
 2015 11:40:34 +0000
Message-ID: <54BF9032.7000605@imgtec.com>
Date:   Wed, 21 Jan 2015 11:40:34 +0000
From:   James Hogan <james.hogan@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.3.0
MIME-Version: 1.0
To:     "Maciej W. Rozycki" <macro@linux-mips.org>,
        Markos Chandras <markos.chandras@imgtec.com>
CC:     <linux-mips@linux-mips.org>,
        Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        "David Daney (Cavium)" <david.daney@cavium.com>
Subject: Re: [PATCH RFC v2 28/70] MIPS: kernel: cpu-probe.c: Add support for
 MIPS R6
References: <1421405389-15512-1-git-send-email-markos.chandras@imgtec.com> <1421405389-15512-29-git-send-email-markos.chandras@imgtec.com> <alpine.LFD.2.11.1501202227140.28301@eddie.linux-mips.org>
In-Reply-To: <alpine.LFD.2.11.1501202227140.28301@eddie.linux-mips.org>
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature";
        boundary="Kw3vxawpNdan7QuPLNjvJfWFQlrDwQ90J"
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: b93fcccb
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45403
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

--Kw3vxawpNdan7QuPLNjvJfWFQlrDwQ90J
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Hi Maciej,

On 20/01/15 23:32, Maciej W. Rozycki wrote:
>  As a side note I can see that as from a96102be, ISA flags are inclusiv=
e,=20
> so the macros in <asm/cpu-features.h> can and I think should be rearran=
ged=20
> and simplified.  E.g. (indentation adjusted, we can afford it now):
>=20
> #define cpu_has_mips_2_3_4_5	cpu_has_mips_2
> #define cpu_has_mips_3_4_5	cpu_has_mips_3
>=20
> #define cpu_has_mips_2_3_4_5_r	cpu_has_mips_2
>=20
> #define cpu_has_mips32		cpu_has_mips32r1
> #define cpu_has_mips64		cpu_has_mips64r1
>=20
> #define cpu_has_mips_r		cpu_has_mips32r1

this isn't always the case. Although set_isa will do the right thing,
some platforms override these in exclusive ways, e.g.:

https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/arch=
/mips/include/asm/mach-cavium-octeon/cpu-feature-overrides.h#n49

David on Cc in case he'd like to justify that. IMO it seems wrong.

Cheers
James


--Kw3vxawpNdan7QuPLNjvJfWFQlrDwQ90J
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUv5AyAAoJEGwLaZPeOHZ6TtwQAKQHzCKmaFZ5+c6U4CzeVW9w
jJKPmZPkXDpH0WtZtL1Dylhn0I6RQb6x4F341aRAob8X9P4scnKrvuk2vS9Dsba4
tfSoFi7L/KscLNFpxLS7XPy23iWDIWKTlugoLuZGkE15MZaowKPoZz4+21RvvNlM
l5vM08MleOWlrLous+kNywhe1E0ZUbyu9p0epW5aBxk07rehVtEuauHCU6dY3eu/
7jjIcY4yMG3F3wl5lhjjFEojpmi1RO2kmEl1jB5udTITDQY/CHuYuHPkbgeBksUW
TJIOzncYKDBo9wKCfvDvPaqvfc+tlW7ATGGi6RaNeRqXh9sIatI8Lp5anhh8LsS2
NQxKRwTRPqFH2Lxw+REuZXojHqceGQrTGT8lbw2noR42RU7bjiPPFu25LNzl1MZz
rzkGAzJMkB3snn1y56g/XUw1QxMLTPzmAqoCWYPM76DrQ7KBb75vjqEOyYPdRapr
f9MV+jELJ4oXwW/iW6aRQ8HTWeTiQNIh403G4C7sUe2Lel2gVd4fIkuDSkf1bEb9
+MHurPxfamM58d6RyQz1LIQJJOy9LzG++cZuk76GT6PACC3ZIgHYyOjmNhEdhgi7
Umm3bnlnENgY22B6IFSlTX0JCm4WceqRlZLMccV9UuZ4uI6wmPZZ/dWRFRS/Qlpj
lg1GtvoyCE3evZULIoFo
=rlIN
-----END PGP SIGNATURE-----

--Kw3vxawpNdan7QuPLNjvJfWFQlrDwQ90J--

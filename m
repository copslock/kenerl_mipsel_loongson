Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Mar 2015 16:11:37 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:4907 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27009001AbbCYPLgfkyrp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 25 Mar 2015 16:11:36 +0100
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id 3582141F8DCD;
        Wed, 25 Mar 2015 15:11:32 +0000 (GMT)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Wed, 25 Mar 2015 15:11:32 +0000
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Wed, 25 Mar 2015 15:11:32 +0000
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 43AA3FA86BFC0;
        Wed, 25 Mar 2015 15:11:29 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Wed, 25 Mar 2015 15:11:31 +0000
Received: from [192.168.154.110] (192.168.154.110) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Wed, 25 Mar
 2015 15:11:31 +0000
Message-ID: <5512D01C.1050500@imgtec.com>
Date:   Wed, 25 Mar 2015 15:11:24 +0000
From:   James Hogan <james.hogan@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
MIME-Version: 1.0
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/3] MIPS: Add CDMM bus support
References: <1422877510-29247-1-git-send-email-james.hogan@imgtec.com> <1422877510-29247-3-git-send-email-james.hogan@imgtec.com> <20150325123756.GA2200@kroah.com>
In-Reply-To: <20150325123756.GA2200@kroah.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature";
        boundary="bKMEwn0sxnK16RmuBKpsXfmQfSGWVphd4"
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: da4c5968
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46520
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

--bKMEwn0sxnK16RmuBKpsXfmQfSGWVphd4
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 25/03/15 12:37, Greg Kroah-Hartman wrote:
> On Mon, Feb 02, 2015 at 11:45:09AM +0000, James Hogan wrote:
>> +struct bus_type mips_cdmm_bustype =3D {
>> +	.name		=3D "cdmm",
>> +	.dev_attrs	=3D mips_cdmm_dev_attrs,
>=20
> .dev_attrs is going away "soon", please use dev_groups instead here.

Thanks Greg. I've fixed this, and will send a v3 of this patch soon.

Cheers
James


--bKMEwn0sxnK16RmuBKpsXfmQfSGWVphd4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJVEtAjAAoJEGwLaZPeOHZ6y6EP/judqDj5E0JvT3fnKve0x1tb
qNlOm/DMM5srXxi2fs2lGkmxP0cVrNIQD76mtXs/3fe6Ifh/EI8uEuo4tEFjwQj5
1xlXmLcpqIO2Xs4UWHmrXIBh5bra+U+mpO7DLbVZT2cqMO7EQPne498cC4yb/YSZ
QqIkEj+6WVaPvv+MHXNrYoPmd63I+reIweie5LgiOpFQZdGUgNpS+ES1wKXXBW+J
Je1r++QAhVPTVJR/lysTLvlAE4pTRksy8yA5nMXNPNSeSagNV8uu3wpawnZ3tgq/
oVQoOaFmD8jNH3j/8Z+jNrOkudABZA+x4Rkqg1SC10z92M4sPl9sDbke182CV9Ii
yFjupQOOJQWElcaBxBj7UJZFASIuhKRm7aivDmrhubznTz2Q72EquBokZEUK1wRy
DuENY4uJ/aDQSQ4o7nIfAo2kRij24TUOJggDIyAoE4I+nx3LaKw2k9nkqmic/mA6
4qVsoWAb7WulgEyqVGghEzgGjKsiUQolHI/5XuqoeoyR1g7UeY/pWxFssNCDWakF
ChrqlmvGdoQm1l+KSiWMcmsPgC94QLfEzEWklLjxzSulQF+Gr6e1S09Zozhqxekf
LueIlYjVRRLEz26inyp2RQtQvG/MEuW+aDVu98KGhA3kPW5KC1rEweVyH8kCTDhM
JZ+2RQwd/YHoozf8n3fS
=1E5/
-----END PGP SIGNATURE-----

--bKMEwn0sxnK16RmuBKpsXfmQfSGWVphd4--

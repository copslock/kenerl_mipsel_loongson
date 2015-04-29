Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Apr 2015 17:37:55 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:39547 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27012146AbbD2PhwGY9dx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 29 Apr 2015 17:37:52 +0200
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id 5948D41F8DED;
        Wed, 29 Apr 2015 16:37:48 +0100 (BST)
Received: from mailapp01.imgtec.com ([10.100.180.242])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Wed, 29 Apr 2015 16:37:48 +0100
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Wed, 29 Apr 2015 16:37:48 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 3AECC58010F10;
        Wed, 29 Apr 2015 16:37:45 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Wed, 29 Apr 2015 16:36:47 +0100
Received: from [192.168.154.110] (192.168.154.110) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Wed, 29 Apr
 2015 16:36:46 +0100
Message-ID: <5540FA8E.40209@imgtec.com>
Date:   Wed, 29 Apr 2015 16:36:46 +0100
From:   James Hogan <james.hogan@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
MIME-Version: 1.0
To:     "Maciej W. Rozycki" <macro@linux-mips.org>
CC:     Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        <linux-mips@linux-mips.org>, <markos.chandras@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] MIPS64: R6: R2 emulation bugfix
References: <20150428195335.11229.4516.stgit@ubuntu-yegoshin> <5540A1BF.7060408@imgtec.com> <alpine.LFD.2.11.1504291025430.17786@eddie.linux-mips.org>
In-Reply-To: <alpine.LFD.2.11.1504291025430.17786@eddie.linux-mips.org>
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature";
        boundary="GEwuTDbBnpoWsPeSG51Jr99L7Rt5Nklwv"
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: b93fcccb
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47164
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

--GEwuTDbBnpoWsPeSG51Jr99L7Rt5Nklwv
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 29/04/15 10:49, Maciej W. Rozycki wrote:
> On Wed, 29 Apr 2015, James Hogan wrote:
>=20
>>> Error recovery pointers for fixups was improperly set as ".word"
>>> which is unsuitable for MIPS64.
>>>
>>> Replaced by __stringify(PTR)
>>
>> Every other case of this sort of thing uses STR(PTR) (or __UA_ADDR in
>> uaccess.h). Can we stick to STR(PTR) for consistency please?
>=20
>  Or __PA_ADDR in paccess.h.
>=20
>  I have mixed feelings, the reason for __stringify being absent is the =

> macro being generic and more recently added than pieces of code that us=
e=20
> STR, e.g. unaligned.c that has been there since forever.  And we do use=
=20
> __stringify in many other cases.

Well I don't particularly mind, so feel free to add my Reviewed-by
regardless, though it'd be nice to have some consistency eventually one
way or another.

Cheers
James

>=20
>  On the other hand STR is short and sweet, unlike __stringify.
>=20
>  So how about adding a macro like __STR_PTR that expands to=20
> __stringify(PTR) and converting all the places throughout our port=20
> (including ones currently using __UA_ADDR/__PA_ADDR) to use the new mac=
ro?
>=20
>  Leonid's bug fix will need to go in first of course.
>=20
>   Maciej
>=20


--GEwuTDbBnpoWsPeSG51Jr99L7Rt5Nklwv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJVQPqOAAoJEGwLaZPeOHZ6nuQP/2PFoG4cBDqkwcRL9HZ0hWaP
KKr8qvWj7SUa/HcHGhB3mhXMrFvRuIea9KClV/8AM9xlHogmjkD0K2o24uD2gXF1
PZWSR31qzl/p+aWNQti2f+j0z4Kq9g+rUwXFKN8IA7ECVCskWChYGTdYvjQcMCNc
uhVq4lXeVdwL9790gLsGx/7jyWVjEbJ4uSOotrdk8G3g6H+0IyhqPLBXQiq8K9mK
hTL/arD+jSlasbhbkROXJPbf7NtJFQymrJQe9gq0udA9P+Q3QdLiL6WpM0mbUJme
fO8IOdBbS09qeGxBOgRf9Bkwmi3QfgE3pvnBpHVnx8ZL6iGCNb589c+ji5q+7AlE
B2AJxF6+Rvr4pa90pOuV1ronuvB17DBGp7etjKrm/G7+fkm96g3KBqHucDetKYR8
wDJSYR4Z2YKnY/50kEqT07pK0spG56KfI8IDxMRT/qj+gDSM1Oi3GsJ6O/ZpHkH3
wfX7pzJ321/hN/XHUrU5pchN8V9orluxZxeyDnbb6dAGhrTZkZiEtVAQp6tvH8Ld
7xLXobMpV6hW0P8MR6bw53b1hw9SOCdjSsi+y/AXWE3tratqSv+Zy+3qc49I+x9E
DM3KlXjn+2OKu95rcGpOdJ2+iNp0SUVWmMZNxoDeGyoCU5vG0K/hOhbPoObkrqwc
J2hl9kObhUYvAtw8AOnO
=uW7F
-----END PGP SIGNATURE-----

--GEwuTDbBnpoWsPeSG51Jr99L7Rt5Nklwv--

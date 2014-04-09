Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Apr 2014 11:02:07 +0200 (CEST)
Received: from [217.156.133.130] ([217.156.133.130]:12494 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-FAIL-FAIL-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S6821191AbaDIJCFJs7lc (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 9 Apr 2014 11:02:05 +0200
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id ED6B741F8E1F;
        Wed,  9 Apr 2014 10:01:58 +0100 (BST)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Wed, 09 Apr 2014 10:01:58 +0100
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Wed, 09 Apr 2014 10:01:58 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id ED67732ADC4C0;
        Wed,  9 Apr 2014 10:01:56 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.181.6; Wed, 9 Apr 2014 10:01:58 +0100
Received: from [192.168.154.65] (192.168.154.65) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.174.1; Wed, 9 Apr
 2014 10:01:58 +0100
Message-ID: <53450C85.3030204@imgtec.com>
Date:   Wed, 9 Apr 2014 10:01:57 +0100
From:   James Hogan <james.hogan@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Markos Chandras <Markos.Chandras@imgtec.com>
CC:     Paul Bolle <pebolle@tiscali.nl>,
        Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
Subject: Re: MIPS: Remove last traces of SMTC Support too?
References: <1397033309.22767.8.camel@x220> <53450BBE.7050501@imgtec.com>
In-Reply-To: <53450BBE.7050501@imgtec.com>
X-Enigmail-Version: 1.5.2
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature";
        boundary="ET46Kath3jK405kQlOgXpMagF6sx7rlvv"
X-Originating-IP: [192.168.154.65]
X-ESG-ENCRYPT-TAG: 86d0bfe3
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39739
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

--ET46Kath3jK405kQlOgXpMagF6sx7rlvv
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 09/04/14 09:58, Markos Chandras wrote:
> On 04/09/2014 09:48 AM, Paul Bolle wrote:
>> The patch "MIPS: Remove SMTC Support" landed in linux-next (see
>> next-20140409). A quick grep of the tree suggests a follow up is neede=
d
>> (a sort-of-patch is pasted below).
>>
>> Is a similar follow up queued somewhere? If not, should I submit a pat=
ch
>> or should I wait with doing that until "MIPS: Remove SMTC Support" hit=
s
>> mainline?
>>
>>
>> Paul Bolle
>=20
> Hi Paul,
>=20
> I talked to Ralf yesterday. It seems the patch was not applied correctl=
y
> and there are a few traces left. My original patch definitely removes
> the traces listed in your patch.
>=20
> You can compare the original patch
>=20
> https://patchwork.linux-mips.org/patch/6719/
>=20
> with the one currently present in upstream-sfr/mips-for-linux-next bran=
ch
>=20

Note that the cpu-info.h part of Paul's suggested patch is new, due to
code added in b86c2247a20f (MIPS: Add cpu_vpe_id macro).

Cheers
James


--ET46Kath3jK405kQlOgXpMagF6sx7rlvv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (GNU/Linux)

iQIcBAEBAgAGBQJTRQyGAAoJEGwLaZPeOHZ6Q1wP/1SJ/gtluajsl17dPrJZJkOL
oESoNsC/EkBC+YGjcQ63VyqgrLUaAu4iv3rA7V1+puEi2GrD7ok0Q2d4gL35W2Q2
ZbpTeIQrLqDIc5Mz+A22jqoYZQQGqGp6wD9dO3JtGGvWVrPKx4HtT+8jqBTNe7fO
2AxznqRwUpOxsgY9AQV2Jd8+KG6TbMr8WcBqOK9+ZedJezHMP43MZ/ZPGlIGYpcT
o9WLEn8pCG/QKxZU1eiehrtiEtebNfkju8dk7hSUwueUyDXv44OndheYCLPHxzLO
1OxLGeMbruev430vhhOyXiqviETpsLFcgSXkkfKn0KwA0ccY3JvBYqaqx/85J8Lj
P7579mOcOT9FK+Crh1EoJpUa1sg7B2OpAT7MKdjlP2I/XyaTggrvyzlep4VCJuRi
66q7LA/p6CBpAPk5mSFQielDHZNuEGU/gn7j5bJTnoPx7TFuf3jdrWxRmr6EqHlM
HVsmOcyXPfli0BAm421PUyXsIlWYKOBX1Lm0JFLWCbGIb+mNogRYQ+V9t2Y5W50N
GUlsgybe7UALWXS1zgn2JMatIJxXiCqPJRytLNzAuIE3XmLB2rxwn2WO+xGU+aUr
dMAbL1VRLdRQDb+zKWIQQrAlNM4XdH1vX+xCOtHx9SL30YW7iGFO0yTZLC6yptSf
UXUDO4d8K7QJ0kg8PwIw
=SpBs
-----END PGP SIGNATURE-----

--ET46Kath3jK405kQlOgXpMagF6sx7rlvv--

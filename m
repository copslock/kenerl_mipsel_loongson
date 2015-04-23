Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Apr 2015 15:31:06 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:8287 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27011977AbbDWNbEq9IDO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 23 Apr 2015 15:31:04 +0200
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id DF02541F8E05;
        Thu, 23 Apr 2015 14:31:00 +0100 (BST)
Received: from mailapp01.imgtec.com ([10.100.180.242])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Thu, 23 Apr 2015 14:31:00 +0100
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Thu, 23 Apr 2015 14:31:00 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 2957E602F3E3;
        Thu, 23 Apr 2015 14:30:58 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Thu, 23 Apr 2015 14:31:00 +0100
Received: from [192.168.154.110] (192.168.154.110) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Thu, 23 Apr
 2015 14:31:00 +0100
Message-ID: <5538F413.5030509@imgtec.com>
Date:   Thu, 23 Apr 2015 14:30:59 +0100
From:   James Hogan <james.hogan@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
MIME-Version: 1.0
To:     Markos Chandras <Markos.Chandras@imgtec.com>,
        =?UTF-8?B?UmFmYcWCIE1pxYI=?= =?UTF-8?B?ZWNraQ==?= 
        <zajec5@gmail.com>
CC:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Hauke Mehrtens <hauke@hauke-m.de>
Subject: Re: [PATCH] MIPS: bcm47xx: Move the BCM47XX board types under a choice
 symbol
References: <1429792093-8160-1-git-send-email-markos.chandras@imgtec.com> <CACna6rwvnWtD0T2hXju-YUFxt2iEqigj=fVkKxOC_19+=2_FzA@mail.gmail.com> <5538EAC4.2010902@imgtec.com>
In-Reply-To: <5538EAC4.2010902@imgtec.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature";
        boundary="oq6vlfLHrH4pFjqHlnr3V2enJlkDjShE3"
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: b93fcccb
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47017
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

--oq6vlfLHrH4pFjqHlnr3V2enJlkDjShE3
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 23/04/15 13:51, Markos Chandras wrote:
> On 04/23/2015 01:33 PM, Rafa=C5=82 Mi=C5=82ecki wrote:
>> On 23 April 2015 at 14:28, Markos Chandras <markos.chandras@imgtec.com=
> wrote:
>>> Since the build system expects one of the two types to be selected,
>>> it's better if we move these symbols under a new choice symbol.
>>
>> Nack, it doesn't allow building kernel with *both* buses support.
>>
> I see. I didn't know that this was a valid configuration. Perhaps the
> choice statement needs some rework to add a third option to select both=

> buses.
>=20

sounds like a workaround for a workaround that'd be better to just fix
at the source level. :)

Cheers
James


--oq6vlfLHrH4pFjqHlnr3V2enJlkDjShE3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJVOPQUAAoJEGwLaZPeOHZ6QCoQAK9bNjVwKVzaYQkyHb66QSJp
1AnMbLs12VSUQnrV9SCBWDCSP8SmF9Q32u5Xz5juqmNe01V+iJePwLVk+iOZ6NPX
F00RJpQlpzzjpifxHC+0adDg8PuU1EwLVII5EOns5NftYEvf4Ev0mcfRbj4IejVo
1EBYY98VWdVbzLhG+4fnin+2GymEUsoQW13g0+a0PgaJaIfD6D3coSOweAnBcf/O
EOP0a7j7oLN6jGkaPoCz0lX/Vhpkg8RBiv1Ms6V1ZXP6Pk6Nm72lAjDIQTj0euhw
Ui0IMZWiv1SA6ZywDMFb9TnTrINEThKwWuTtopbs2dd0DhNX/rhdqea2xmcInna1
u/PkMJqwHeruu5B4Cb3VjKbescBuE3IC7dIW5+q/C8Itt6BZqT8qy2891/+GMoUJ
Z5Z3sRnzPZRCkEFBm7Kvkz1bY9+Gf70l7I6dJjylkaiccbEMfIJ77SsFjH7RRbmD
Z2ImhjvE96AN2Y6mm5OdfloMIZGBjOO2B2Wub+0AOburxjwymvZou6X46mVSGlbl
TTJy+ijvDIxLzzAUfdVfQxiDrTwv+thJxMgo6mNpB61oPF3hXrWogregkWah0BCj
M841czxI8wenBrEPPgrOC5NzZhYynls1p/uQXou7NDXnT2MvBnLTG8mmFsamyVGw
RXSYJHV/44QT4zZMWS79
=abHT
-----END PGP SIGNATURE-----

--oq6vlfLHrH4pFjqHlnr3V2enJlkDjShE3--

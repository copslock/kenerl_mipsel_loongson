Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Mar 2015 10:51:27 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:16431 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27007921AbbCSJvY5pzr9 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 19 Mar 2015 10:51:24 +0100
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id 5C74D41F8D2A;
        Thu, 19 Mar 2015 09:51:20 +0000 (GMT)
Received: from mailapp01.imgtec.com ([10.100.180.242])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Thu, 19 Mar 2015 09:51:20 +0000
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Thu, 19 Mar 2015 09:51:20 +0000
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id A3A63295ED2FA;
        Thu, 19 Mar 2015 09:51:18 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Thu, 19 Mar 2015 09:51:20 +0000
Received: from [192.168.154.110] (192.168.154.110) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Thu, 19 Mar
 2015 09:51:19 +0000
Message-ID: <550A9C0F.6060505@imgtec.com>
Date:   Thu, 19 Mar 2015 09:51:11 +0000
From:   James Hogan <james.hogan@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
MIME-Version: 1.0
To:     Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
CC:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "wangr@lemote.com" <wangr@lemote.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        Qais Yousef <Qais.Yousef@imgtec.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ralf@linux-mips.org" <ralf@linux-mips.org>,
        "davidlohr@hp.com" <davidlohr@hp.com>,
        "chenhc@lemote.com" <chenhc@lemote.com>,
        "manuel.lauss@gmail.com" <manuel.lauss@gmail.com>,
        "mingo@kernel.org" <mingo@kernel.org>
Subject: Re: [PATCH] MIPS: MSA: misaligned support
References: <20150318011630.2702.28882.stgit@ubuntu-yegoshin> <5509611D.80404@imgtec.com> <5509D62B.7030507@imgtec.com> <20150318221248.GB1116@jhogan-linux.le.imgtec.org> <550A097B.7020400@imgtec.com>
In-Reply-To: <550A097B.7020400@imgtec.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature";
        boundary="Wrsc2CBFXRu1cO6eBQoaV3G8LSpkl2CiG"
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: b93fcccb
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46456
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

--Wrsc2CBFXRu1cO6eBQoaV3G8LSpkl2CiG
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 18/03/15 23:25, Leonid Yegoshin wrote:
> On 03/18/2015 03:12 PM, James Hogan wrote:
>> Hi Leonid,
>>
>> On Wed, Mar 18, 2015 at 12:46:51PM -0700, Leonid Yegoshin wrote:
>>
>>> thread_msa_context_live() =3D=3D check of TIF_MSA_CTX_LIVE =3D=3D exi=
stence of
>>> MSA context for thread.
>>> It differs from MSA is owned by thread, it just says that thread has
>>> already initialized MSA.
>>>
>>> Unfortunate choice of function name, I believe.
>> Right (I mis-read when its cleared when i grepped). Still, that would
>> make it even harder to hit since lose_fpu wouldn't clear it, and you
>> already would've taken an MSA disabled exception first.
> No, lose_fpu disables MSA now, saves MSA context and switches off
> TIF_USEDMSA. See 33c771ba5c5d067f85a5a6c4b11047219b5b8f4e, "MIPS:
> save/disable MSA in lose_fpu".
>=20
> However, a process still has MSA context initialized and it is indicate=
d
> by TIF_MSA_CTX_LIVE.
> It should have it before it can get any AdE exception on MSA instructio=
n.

Yes, exactly.

>=20
>>
>> Anyway, my point was that there's nothing invalid about an unaligned
>> load being the first MSA instruction. You might use it to load the
>> initial vector state.
>=20
> No, it is invalid. If MSA is disabled it should trigger "MSA Disabled"
> exception.

It's valid for the user to start their program with a ld.b.
As you say, it'll raise an MSA disabled exception first though. The
handler will own MSA, and set TIF_MSA_CTX_LIVE, which makes the check
pointless?

I suppose an AdE from a normal unaligned load could still race with
another thread modifying the instruction to an MSA ld.b, but even if it
did, I don't think it would do any harm?

>=20
> Unfortunately, some HW versions had AdE first and it may be logical fro=
m
> some HW point (if access is done before instruction is completely
> decoded). But that is wrong.

Yes, MSA Disabled would clearly come under "Instruction Validity
Exceptions", which is very sensibly higher priority than "Address error
- Data access".

Anyway, at the very least it needs a comment to justify what it is
trying to catch and what harm it is trying to avoid, since it isn't
obvious, and tbh seems pointless.

Cheers
James


--Wrsc2CBFXRu1cO6eBQoaV3G8LSpkl2CiG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJVCpwXAAoJEGwLaZPeOHZ6WA8P/12JA5qHR3eURspz1brDAP30
8qXus2wEWMfRpFiaE3kwlopeyFhB5QFtGRPZRcZONNZtXFHpJR7lj6fcgUFv2ACC
nHufMeKukGd2gri2UB2sIbm857EQnmwxBqzbFcXIcTsxebTcP9Mv91TXHHEc5HG3
9pLY6da6qdM8EbKdHD8zciJiYwdZePa6HC9dR0jdbTj+E5zWmU7FOHUz/Z/lQ9jY
AWHPVsS5tTpaNIFbdSsH/Mh/byZqLbB1Dd3aj2S3MHXf8xUH8G7+UTTZI6kTAZpP
BTXHgZBDvSsWOLgTcTJwyQzNAQe8ePzU/ZV4LfMwJUsQpMTvw+ee8GDljBnPIQnB
mcLjSZZ4W9ao1IhUO5/YDexnAKfkuYtHsnKhz10ICddcJo0RVbcrNDHhKkPSmc/M
LvRpm4DEmwxA4vRAd4ECGW/JcQ4K5I2R9SvCJgXXCQyI4peGnMEnHiIMK/6YfDF2
QmeII6iSBbDvxeD5Q34vLcutlO/s4EXK717QrZnCd0DreMWmo/gg8+bwZFe4MKhw
x/gZ54kARuBfnsL6CfRHtVSd3ap3RPuhCNeiEc5oyf+Kjt692uCsRb3FXPBQ7Zfm
k79nIwNmmEPWy2A9UDFUJpw4tsE+WIN1szzR6/j9UgQWTAjffiE5nTpVs2ykvdIR
DvqSImPLPoLzONqBBuaS
=eKr3
-----END PGP SIGNATURE-----

--Wrsc2CBFXRu1cO6eBQoaV3G8LSpkl2CiG--

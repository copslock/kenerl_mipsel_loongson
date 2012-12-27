Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 Dec 2012 20:44:08 +0100 (CET)
Received: from qmta03.westchester.pa.mail.comcast.net ([76.96.62.32]:54455
        "EHLO qmta03.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6823037Ab2L0ToAB7Iwk (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 27 Dec 2012 20:44:00 +0100
Received: from omta11.westchester.pa.mail.comcast.net ([76.96.62.36])
        by qmta03.westchester.pa.mail.comcast.net with comcast
        id gcF31k0080mv7h053jjteZ; Thu, 27 Dec 2012 19:43:53 +0000
Received: from [192.168.1.13] ([76.106.69.86])
        by omta11.westchester.pa.mail.comcast.net with comcast
        id gjjs1k00L1rgsis3Xjjs1x; Thu, 27 Dec 2012 19:43:53 +0000
Message-ID: <50DCA50A.3020704@gentoo.org>
Date:   Thu, 27 Dec 2012 14:44:10 -0500
From:   Joshua Kinard <kumba@gentoo.org>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/17.0 Thunderbird/17.0
MIME-Version: 1.0
To:     Linux MIPS List <linux-mips@linux-mips.org>
CC:     Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH]: Fix 3.7 mips build if !CONFIG_MODULES
References: <50DC174D.6090302@gentoo.org> <CAMuHMdXyMzQtejXOHEcSUO7fLh7CP+sPvNYdVnzKjwZx9Vj6xg@mail.gmail.com>
In-Reply-To: <CAMuHMdXyMzQtejXOHEcSUO7fLh7CP+sPvNYdVnzKjwZx9Vj6xg@mail.gmail.com>
X-Enigmail-Version: 1.4.6
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig45F2602B37BA6F00EE3074FF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=q20121106; t=1356637433;
        bh=YWRFQj+xdISLhCQY3o1Cv0x+uD5UsidzOWdkrUod3kI=;
        h=Received:Received:Message-ID:Date:From:MIME-Version:To:Subject:
         Content-Type;
        b=ea2ToXJQKUO5yGtAI/COfqodlquDaCkXNYNLAh0BqK0vIF3CNIz7ZDGd09WOZo+3l
         ri+v6gU0r05YgUmISCxO4dSJdaUvIMYYhXewlWSAEqHpU2B+fMFnGpjmXHl/fPjFoq
         fqQo32lvIOYMUeKbo8ARoEpiMqgZ/ATQPER9mykgp1z1g3i7yltgTGg7fokl3Yw3ey
         ooR3PpJkHElHMp2GciNQJy/IqwEOaokq9tKOWVaLdnB7+Qy46QG2N6/7WObyMFWMVp
         E0RBeXDg5dnZRoOsFYcv1gXnrVaOzlLLu5ycBpPXLvOpyEbmiTUXHQwplE1iRf1XI5
         M9Pq69Ysv/cQA==
X-archive-position: 35339
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
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
Return-Path: <linux-mips-bounce@linux-mips.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig45F2602B37BA6F00EE3074FF
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 12/27/2012 4:45 AM, Geert Uytterhoeven wrote:
> On Thu, Dec 27, 2012 at 10:39 AM, Joshua Kinard <kumba@gentoo.org> wrot=
e:
>> The attached patch fixes a build failure if building a monolithic kern=
el due
>> to arch/mips/kernel/Kconfig selecting MODULES_USE_ELF_REL[A] without
>> checking to see if MODULES is set or not.  This leads to 'struct modul=
e' not
>> existing, which triggers a compile failure in arch/mips/kernel/module-=
rela.c
>> when the compiler attempts to dereference me->name on lines 36, 48, an=
d 133.
>>
>> Signed-off-by: Joshua Kinard <kumba@gentoo.org>
>> ---
>>
>>  Kconfig |    4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>>
>> diff -Naurp a/arch/mips/Kconfig b/arch/mips/Kconfig
>> --- a/arch/mips/Kconfig 2012-12-22 22:52:28.264461836 -0500
>> +++ b/arch/mips/Kconfig 2012-12-26 23:00:46.202996691 -0500
>> @@ -39,8 +39,8 @@ config MIPS
>>         select GENERIC_CLOCKEVENTS
>>         select GENERIC_CMOS_UPDATE
>>         select HAVE_MOD_ARCH_SPECIFIC
>> -       select MODULES_USE_ELF_REL
>> -       select MODULES_USE_ELF_RELA if 64BIT
>> +       select MODULES_USE_ELF_REL && MODULES
>=20
> Shouldn't that be
>=20
>     select MODULES_USE_ELF_REL if MODULES
>=20
> ?
>=20
>> +       select MODULES_USE_ELF_RELA if MODULES && 64BIT

Whoops, yep!  Thanks for the catch, I'll resend a fixed patch.

--=20
Joshua Kinard
Gentoo/MIPS
kumba@gentoo.org
4096R/D25D95E3 2011-03-28

"The past tempts us, the present confuses us, the future frightens us.  A=
nd
our lives slip away, moment by moment, lost in that vast, terrible in-bet=
ween."

--Emperor Turhan, Centauri Republic


--------------enig45F2602B37BA6F00EE3074FF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (MingW32)

iQIcBAEBAgAGBQJQ3KULAAoJENsjoH7SXZXjus8P/jUxPQ+uHEASKdJA6KHcnJwd
k8PQ9YI39Xuj8uGU4kXUSh5ySFkTxG6EKIaRkFpmeompuSSBgK4VHttzylScbOj0
hXzW+7Wf3z1OiSCXs5YwUmauvazu5ZxUGCGeG6PQoUkPPwK3jeyDIS/b9LHTPS64
ITp1hZqQovQtF61EvwTdwEcnJZd4CSw6xbP3+II5AOqHiecOjDXlH6/ygf5iIHjT
sgeJfrjTtyk3poPjj7O5UyoR25fsOo0813KPMToM5BsLmhLDMdB2GezixhHMRdQ0
adEOjqrnndQ4KcWy86YGjEd4klEnsKNzTmNMR/FrLi/T1LBpZxx9bSEv5fSk/nZY
o2cgwe+ml+yt5s43rTNnp50Ig3fI4KMtAwg4phrzj+j0Nwgrh/aUnuNx+fW5aZGA
U5Fr9zU8S8jN9UzRBxKNb6xrxC1U10OoiS7MY1HDl3n9AFwQYKvWF6Gc66vBl4Uy
lIihRWB9loEJOXJHfiKhsZTM+1xBdCEmfjvQ1SQGJBTPd19kaZKzMJxa9vwZ3RS6
MXKGZJspwf069SeRuppQbK2qAPvpN007+Wtvu6o6Qm7+uuDj+kTZRIt4P1SOm/7N
ULYCf/p4JA/jo9YcoOtD1fyc783bjaRXkOnP1+G5hXkWPY6OOmqT6kgbeWmNjVV2
r0MWoa1FZ9iuOHmr+ZMv
=IOVV
-----END PGP SIGNATURE-----

--------------enig45F2602B37BA6F00EE3074FF--

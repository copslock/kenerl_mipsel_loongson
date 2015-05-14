Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 May 2015 12:00:39 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:49356 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27011458AbbENKAiFH4pD (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 14 May 2015 12:00:38 +0200
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id DCF7941F8D88;
        Thu, 14 May 2015 11:00:34 +0100 (BST)
Received: from mailapp01.imgtec.com ([10.100.180.242])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Thu, 14 May 2015 11:00:34 +0100
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Thu, 14 May 2015 11:00:34 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id D0B42102C0A;
        Thu, 14 May 2015 11:00:32 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Thu, 14 May 2015 11:00:34 +0100
Received: from [192.168.154.110] (192.168.154.110) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Thu, 14 May
 2015 11:00:31 +0100
Message-ID: <55547238.1040005@imgtec.com>
Date:   Thu, 14 May 2015 11:00:24 +0100
From:   James Hogan <james.hogan@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
MIME-Version: 1.0
To:     Paul Burton <paul.burton@imgtec.com>,
        "Maciej W. Rozycki" <macro@linux-mips.org>
CC:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
Subject: Re: [PATCH 1/2] MIPS: malta-time: Don't switch RTC to BCD mode
References: <1431519473-24049-1-git-send-email-james.hogan@imgtec.com> <1431519473-24049-2-git-send-email-james.hogan@imgtec.com> <alpine.LFD.2.11.1505131829580.1538@eddie.linux-mips.org> <20150513221956.GE7723@jhogan-linux.le.imgtec.org> <20150514084130.GE22815@NP-P-BURTON>
In-Reply-To: <20150514084130.GE22815@NP-P-BURTON>
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature";
        boundary="cgWxPQq8Vudc0gGsAefU6AIKncMeOeh3f"
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: b93fcccb
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47396
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

--cgWxPQq8Vudc0gGsAefU6AIKncMeOeh3f
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 14/05/15 09:44, Paul Burton wrote:
> On Wed, May 13, 2015 at 11:19:56PM +0100, James Hogan wrote:
>> Hi Maciej,
>>
>> On Wed, May 13, 2015 at 07:03:51PM +0100, Maciej W. Rozycki wrote:
>>> On Wed, 13 May 2015, James Hogan wrote:
>>>
>>>> On Malta, the RTC is forced into binary coded decimal (BCD) mode dur=
ing
>>>> init, even if the bootloader put it into binary mode (as YAMON does)=
=2E
>>>> This can result in the RTC seconds being an invalid BCD (e.g.
>>>> 0x1a..0x1f) for up to 6 seconds.
>>>
>>>  Sigh.  No sooner I had fixed the breakage (with 636221b8 and a fat=20
>>> comment) it got put back (with a87ea88d).  Even though it's easily=20
>>> spotted as it breaks the system time (all the fields, including the d=
ate=20
>>> too, not only the seconds!) across a reboot due to YAMON eagerly=20
>>> switching the mode back.  And that'd be the first item I'd check when=
=20
>>> validating a change touching the RTC.
>>
>> Indeed, a quick bit of experimentation confirms a discrepancy before
>> this patch is applied before YAMON's "date" command and the RTC clock =
as
>> read by Linux (with year, day of month, hour & minute all going 22 -> =
16
>> (22 =3D=3D 0x16), and presumably different rates of time depending on =
which
>> mode its in. After this patch it appears to work again as it should.
>>
>>>  Is there an actual need to reinitialise the RTC at all?  The RTC=20
>>> registers are readable, so the current configuration can be obtained,=
=20
>>> the RTC driver copes with any valid arrangement, so can any other cod=
e=20
>>> using the clock as a reference.
>>>
>>>  YAMON OTOH is not as flexible, its clock management commands expect =
the=20
>>> format the monitor itself set the chip to, so I think the kernel has =
to=20
>>> respect that (just as it doesn't randomly flip bits in the RTC on x86=
=20
>>> PCs for example).
>>>
>>>  So unless proven otherwise I'll ask for `init_rtc' to be dropped=20
>>> altogether
>>
>> I suspect it comes down to what U-Boot does with RTC (possibly very
>> little), but I'll leave that to you and Paul to discuss.
>=20
> The reason for init_rtc was touched upon in the commit message for
> a87ea88d8f6c (MIPS: Malta: initialise the RTC at boot) but could perhap=
s
> have been clearer. Straight out of reset the RTC may not be running at
> all, but the code in estimate_frequencies (note: not the RTC driver)
> relies upon the RTC having been started. This was an issue when using
> earlier builds of U-boot which didn't touch the RTC at all, and is stil=
l
> an issue if you do something like load the kernel via a JTAG probe
> rather than using U-boot or YAMON. If the kernel doesn't ensure the RTC=

> is started then it'll just hang in estimate_frequencies waiting for the=

> UIP bit to change even though it never will. YAMON isn't the only way t=
o
> boot on Malta, and dependencies such as this between the kernel & the
> bootloader should really be minimised.
>=20
>>> and any changes required made to `estimate_frequencies'=20
>>> instead.  Which I believe you already did with 2/2.
>>
>> As long as the mode doesn't get changed, my change to
>> estimate_frequencies() should be happy enough. Before patch 2/2 it onl=
y
>> reads UIP flag to try to time a single second, so it shouldn't have
>> cared about such details as the RTC mode.
>=20
> ...and since it seems the U-boot & YAMON RTC drivers use it in differen=
t
> modes, I'd consider this patch reasonable. Feel free to have my:
>=20
>   Reviewed-by: Paul Burton <paul.burton@imgtec.com>

Thanks Paul,

Assuming Maciej is satisfied I'll rewrite the commit message, add a
stable tag, and resend.

Cheers
James


--cgWxPQq8Vudc0gGsAefU6AIKncMeOeh3f
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJVVHI/AAoJEGwLaZPeOHZ6GKEP/27cpDK9DKz7lm7PkYZhBwkQ
uDX/2lYnkfVecVUYrtS4LVuGaZVVjDSQvzbCr+iefT9rEQOeBQJBcUJ1hM6WP0LE
yjr1aEl8E3P65nkQRVyDpV4wuISRWNAVJr250X8p4vJLaLjE96rjcW4YDhTGq6Gc
3M2ud4mFyU7c6htZ51tZGedz1xDbkO91oLEjHbDODc60f8nhQmm845rAY0SzaZzt
EUbjiX2Qeg5JwbWzZWmHPZ6Al1QHEpJCsDSaNePaLYhHuWPIcIYqhKBSbiXgbGQ7
ca4R9kwDZ8DDmrK+DFamD5hIpBk0Ircp1QJ+0hsvvr71IAFnepB9Uo5BXNbfHmKs
aD2dPFksXh50RuWp30w52MzH+KpIn30MRAOWtgi/W7pSTIpNJuowDF6KJTHw4txM
mtHA2+/r9tyb52kZCxvx8EehwKpcrsnA+oUDzqz+RNLsQ7o6an0pHMQAV58/iylH
bI5SXjtuG6dZgBL498wNLeW4YU/mRXVNZtKjNHHhpG5nC6inkGTh/luIzFT7EKKd
5Tc2RdA3V+HKffXYXrL1TCWJlx2gy3KHxkmTCDWACwqKVUXhl2mp91xSh7BLyww6
V0TkQ42ljHCOQ3gs88K18CkLAe1vL5Qh2ItOhDoH208Dp5ggDFT6UAHE3wmZuUrv
M/jLy9L1htnoDx12UB1v
=Ednz
-----END PGP SIGNATURE-----

--cgWxPQq8Vudc0gGsAefU6AIKncMeOeh3f--

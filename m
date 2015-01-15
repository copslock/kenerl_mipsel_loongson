Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Jan 2015 17:50:09 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:34853 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27010580AbbAOQuH3I8cl (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 15 Jan 2015 17:50:07 +0100
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id F314141F8DBF;
        Thu, 15 Jan 2015 16:50:00 +0000 (GMT)
Received: from mailapp01.imgtec.com ([10.100.180.242])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Thu, 15 Jan 2015 16:50:00 +0000
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Thu, 15 Jan 2015 16:50:00 +0000
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id BF1F6CA86B57A;
        Thu, 15 Jan 2015 16:49:57 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Thu, 15 Jan 2015 16:50:00 +0000
Received: from [192.168.154.110] (192.168.154.110) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Thu, 15 Jan
 2015 16:50:00 +0000
Message-ID: <54B7EFB8.30904@imgtec.com>
Date:   Thu, 15 Jan 2015 16:50:00 +0000
From:   James Hogan <james.hogan@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.3.0
MIME-Version: 1.0
To:     Qais Yousef <qais.yousef@imgtec.com>
CC:     Andrew Bresticker <abrestic@chromium.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Jeffrey Deans <jeffrey.deans@imgtec.com>,
        "Markos Chandras" <markos.chandras@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Jonas Gorski <jogo@openwrt.org>,
        John Crispin <blogic@openwrt.org>,
        "David Daney" <ddaney.cavm@gmail.com>, <linux-mips@linux-mips.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2 18/24] irqchip: mips-gic: Stop using per-platform mapping
 tables
References: <1411076851-28242-1-git-send-email-abrestic@chromium.org> <1411076851-28242-19-git-send-email-abrestic@chromium.org> <54B7AB95.4080501@imgtec.com> <54B7EAE6.8040503@imgtec.com> <54B7EC8D.5050505@imgtec.com>
In-Reply-To: <54B7EC8D.5050505@imgtec.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature";
        boundary="uO8ohk5E26rkcoTWhBAAtouMNE6K5Wxts"
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: b93fcccb
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45129
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

--uO8ohk5E26rkcoTWhBAAtouMNE6K5Wxts
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 15/01/15 16:36, Qais Yousef wrote:
> On 01/15/2015 04:29 PM, James Hogan wrote:
>> On 15/01/15 11:59, James Hogan wrote:
>>> Hi Andrew,
>>>
>>> On 18/09/14 22:47, Andrew Bresticker wrote:
>>>> Now that the GIC properly uses IRQ domains, kill off the per-platfor=
m
>>>> routing tables that were used to make the GIC appear transparent.
>>>>
>>>> This includes:
>>>>   - removing the mapping tables and the support for applying them,
>>>>   - moving GIC IPI support to the GIC driver,
>>>>   - properly routing the i8259 through the GIC on Malta, and
>>>>   - updating IRQ assignments on SEAD-3 when the GIC is present.
>>>>
>>>> Platforms no longer will pass an interrupt mapping table to gic_init=
=2E
>>>> Instead, they will pass the CPU interrupt vector (2 - 7) that they
>>>> expect the GIC to route interrupts to.  Note that in EIC mode this
>>>> value is ignored and all GIC interrupts are routed to EIC vector 1.
>>>>
>>>> Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
>>>> Acked-by: Jason Cooper <jason@lakedaemon.net>
>>>> Reviewed-by: Qais Yousef <qais.yousef@imgtec.com>
>>>> Tested-by: Qais Yousef <qais.yousef@imgtec.com>
>>> This commit (18743d2781d01d34d132f952a2e16353ccb4c3de) appears to bre=
ak
>>> boot of interAptiv, dual core, dual vpe per core, on malta with
>>> malta_defconfig.
>>>
>>> It gets to here:
>>> ...
>>> CPU1 revision is: 0001a120 (MIPS interAptiv (multi))
>>> FPU revision is: 0173a000
>>> Primary instruction cache 64kB, VIPT, 4-way, linesize 32 bytes.
>>> Primary data cache 64kB, 4-way, PIPT, no aliases, linesize 32 bytes
>>> MIPS secondary cache 1024kB, 8-way, linesize 32 bytes.
>>> Synchronize counters for CPU 1: done.
>>> Brought up 2 CPUs
>>>
>>> and then appears to just hang. Passing nosmp works around it, allowin=
g
>>> it to get to userland.
>>>
>>> Is that a problem you've already come across?
>>>
>>> I'll keep debugging.
>> Right, it appears the CPU IRQ line that the GIC is using doesn't get
>> unmasked (STATUSF_IP2) when a new VPE is brought up, so only the first=

>> CPU will actually get any interrupts after your patch (including the
>> rather critical IPIs), i.e. hacking it in vsmp_init_secondary() in
>> smp-mt.c allows it to boot.
>>
>> Hmm, I'll have a think about what the most generic fix is, since
>> arbitrary stuff may or may not have registered handlers for the raw CP=
U
>> interrupts (timer, performance counter, gic etc)...
>>
>> Cheers
>> James
>>
>=20
> Is this similar to the issue addressed by this (ff1e29ade4c6 MIPS:
> smp-cps: Enable all hardware interrupts on secondary CPUs)?

Thanks Qais. Yes, enabling CPS also works around the problem thanks to
that commit.

Cheers
James


--uO8ohk5E26rkcoTWhBAAtouMNE6K5Wxts
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUt++4AAoJEGwLaZPeOHZ6ZAwP/3R52R3QvRAwk5Ic9Rhi7Db3
oOVKiHk0Gcw4bvxAAbSvnorAs4To3mcDxSXJqD0pwkqWCP43T5P7s9pk7eEE9jB/
f28pKBDiIW8yN8Rq+qePXEMvcKCNlHchgP+HIjZdFUyk/5Dy3vqqcchvFkzkx0hV
Hr51CJXCDhi37afV4c6ThIiN51WK8SXTmilHsVjvVl9PsdAkmdN7eSIPh8znHpkP
rl9Dyz/kxYBBD1RYEXD+ksKrjsi8mLllzjNfHYUXhUH6FPdNxI+E5P18A5SZem2z
ll7SXjoUZOU3jq/F78h7eyXE07xYpjBBVDsYDRd4KEgVs2lJC5pDnObMhrsmOVJ3
eSuhWTcm6SGPX9kAUCpjDNhSJRAauvs4Qqca+vmrWt++aBIZ+08VrqWltF6O10Vv
yQcxO69Jv/ttijhSo79rAt7lmHDZcyh3QAHlHsbAhWVazHrSIdSWoBbIEcYjUjNG
x7w+gHyHqsB1qWtyrOQwodegci82Rslee5dGq0hf/QC0iYgY6iqKqD2qxkXf/khB
4oy/5rDWP4BndbO1EakTPwgmrIR0pFCattw2r5WOku65jaPwmd/Bol+fa0Fl6oeg
Yy5dUweDXrkSJdBuwXAhAZvVMqenfKztRL6UjADUsQTAMef34P6tRYYcWwYikibi
REwiESTEnrUOCI51aqef
=yVxL
-----END PGP SIGNATURE-----

--uO8ohk5E26rkcoTWhBAAtouMNE6K5Wxts--

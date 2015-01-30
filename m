Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 Jan 2015 16:00:14 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:54743 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27012309AbbA3PAM2hSc6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 30 Jan 2015 16:00:12 +0100
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id ED22541F8DB6;
        Fri, 30 Jan 2015 15:00:06 +0000 (GMT)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Fri, 30 Jan 2015 15:00:06 +0000
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Fri, 30 Jan 2015 15:00:06 +0000
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 167A42ED9CC6E;
        Fri, 30 Jan 2015 15:00:04 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Fri, 30 Jan 2015 15:00:06 +0000
Received: from [192.168.154.110] (192.168.154.110) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Fri, 30 Jan
 2015 15:00:04 +0000
Message-ID: <54CB9C6D.1080506@imgtec.com>
Date:   Fri, 30 Jan 2015 14:59:57 +0000
From:   James Hogan <james.hogan@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.3.0
MIME-Version: 1.0
To:     "Maciej W. Rozycki" <macro@linux-mips.org>,
        Aaro Koskinen <aaro.koskinen@iki.fi>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        David Daney <david.daney@cavium.com>,
        <linux-mips@linux-mips.org>, <linux-kernel@vger.kernel.org>,
        Hemmo Nieminen <hemmo.nieminen@iki.fi>,
        <stable@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] MIPS: fix kernel lockup or crash after CPU offline/online
References: <1421355719-17576-1-git-send-email-aaro.koskinen@iki.fi> <1421355719-17576-2-git-send-email-aaro.koskinen@iki.fi> <alpine.LFD.2.11.1501300347170.28301@eddie.linux-mips.org> <54CB5B59.5050203@imgtec.com> <alpine.LFD.2.11.1501301242080.28301@eddie.linux-mips.org>
In-Reply-To: <alpine.LFD.2.11.1501301242080.28301@eddie.linux-mips.org>
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature";
        boundary="DMNkN7kt0u2t2J4KlMio8mwJQ6mMt015t"
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: da4c5968
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45576
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

--DMNkN7kt0u2t2J4KlMio8mwJQ6mMt015t
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 30/01/15 12:47, Maciej W. Rozycki wrote:
> On Fri, 30 Jan 2015, James Hogan wrote:
>=20
>>>  Hmm, why can a call to `printk' cause a TLB miss, what's so special =
about=20
>>> this function?  Does it use kernel mapped addresses for any purpose s=
uch=20
>>> as `vmalloc'?
>>
>> It would be the fact netconsole (or whatever other console is in use) =
is
>> built as a kernel module, memory for which is allocated from the vmall=
oc
>> area.
>=20
>  Ah, I see, thanks for enlightening me.  But in that case wouldn't it b=
e=20
> possible to postpone console output from `printk' until it is safe to=20
> access the device?  In a manner similar to how for example we handle ca=
lls=20
> to `printk' made from the hardirq context.  That would make things less=
=20
> fragile.

Hmm, kernel/printk/printk.c does have:

static inline int can_use_console(unsigned int cpu)
{
	return cpu_online(cpu) || have_callable_console();
}

which should prevent it dumping printk buffer to console. CPU shouldn't
be marked online that early, which suggests that the console has the
CON_ANYTIME flag set, which it probably shouldn't if it depends on
module code. call_console_drivers() seems to ensure the CPU is online or
has CON_ANYTIME before calling the console write callback.

A quick glance and I can't see any evidence of netconsole being able to
get CON_ANYTIME.

serial8250_console does appear to set that flag *and* is tristate
though, which is slightly worrying.

Aaro, what is the content of your /proc/consoles?

Cheers
James


--DMNkN7kt0u2t2J4KlMio8mwJQ6mMt015t
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUy5x0AAoJEGwLaZPeOHZ6bqIP/A67+XDb6J0TVn65uvmsXvKD
AwFMghX4pPMywmlqKRU4EV8QCRB0bOotA2HdE6fEhezhLDMzeC/dlHUVbqLKThOr
PMynEUH/Tt5RKlZfpDfKzl0e7210HDCPB3HVfN7hcStOhao/G4kndrf36kiqmD4V
DeM92x1/ng1Lx9UM5O9cK1KI7G13j8LeA16M/CsitUeDcxjIpyBZYNSDLuutRaCV
ip/BR+x21q77Ad0s2a28mNl7e8cBwRZfKDjU/oU1Fbtg2pdJYI41muIWHaIhjQ3W
2j6dXj8AMhq8eRoMwGZaz8ZKP3JWzYCSIBemLkH36XOOrXoePwdgZyd9GIk4RQHh
eXXkERVyW1bSrnA2XNq2TqvdesykV4ujKtDUgFwKGE/oZak+VjmtOHJlM5YoYKcY
4NgFQ62ihtGNdY02H/gFTLGzMCyxPeMLlKYhA6KgcdXW6oOuOmN+kCRj+6shspAr
2gIGRIt1cYUSv5aZxocQbwJcQrNHEqUqOApY80iIOYsTQ9kpiFPT306SDEX03dEb
XDjG6KR1Ty/GGkPnGYMj/SRryFGeMDX6uXCB8ShCanHXBZjTrSTB/SkelyEG4w/D
Qn2azTLsZfSD0m5bXnXG1FzYWp2hiJlEk8mXxv9D1XmyRSkqTpdzghMdmNWkRDGJ
XYgSnqQe0rBmPQboIr8C
=U6t3
-----END PGP SIGNATURE-----

--DMNkN7kt0u2t2J4KlMio8mwJQ6mMt015t--

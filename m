Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Mar 2015 11:30:17 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:11171 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27008837AbbCPKaQVH08A (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 16 Mar 2015 11:30:16 +0100
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id BFF7F41F8DC0;
        Mon, 16 Mar 2015 10:30:11 +0000 (GMT)
Received: from mailapp01.imgtec.com ([10.100.180.242])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Mon, 16 Mar 2015 10:30:11 +0000
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Mon, 16 Mar 2015 10:30:11 +0000
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 244C596F5A5C0;
        Mon, 16 Mar 2015 10:30:10 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Mon, 16 Mar 2015 10:30:11 +0000
Received: from [192.168.154.110] (192.168.154.110) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Mon, 16 Mar
 2015 10:30:10 +0000
Message-ID: <5506B0B2.3020606@imgtec.com>
Date:   Mon, 16 Mar 2015 10:30:10 +0000
From:   James Hogan <james.hogan@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
MIME-Version: 1.0
To:     Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Matthew Fortune <Matthew.Fortune@imgtec.com>,
        Andrew Bresticker <abrestic@chromium.org>
CC:     "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
        Ezequiel Garcia <ezequiel.garcia@imgtec.com>,
        James Hartley <james.hartley@imgtec.com>,
        "John Crispin" <blogic@openwrt.org>,
        Jonas Gorski <jogo@openwrt.org>,
        Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
Subject: Re: [U-Boot] MIPS UHI spec
References: <6D39441BF12EF246A7ABCE6654B0235320FDC2AC@LEMAIL01.le.imgtec.org>   <20150226101739.GY17695@NP-P-BURTON> <CACUy__Ux6v9O0RmSiUr6vDDJ8JSDPCsCTqm=KOiNM0M=x3hoQQ@mail.gmail.com>
In-Reply-To: <CACUy__Ux6v9O0RmSiUr6vDDJ8JSDPCsCTqm=KOiNM0M=x3hoQQ@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature";
        boundary="jsox8XNqLhRna4qK0swddEh8ng2sV6wek"
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: b93fcccb
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46392
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

--jsox8XNqLhRna4qK0swddEh8ng2sV6wek
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 26/02/15 12:37, Daniel Schwierzeck wrote:
> 2015-02-26 11:17 GMT+01:00 Paul Burton <paul.burton@imgtec.com>:
>> On Thu, Feb 19, 2015 at 01:50:23PM +0000, Matthew Fortune wrote:
>>> Hi Daniel,
>>>
>>> The spec for MIPS Unified Hosting Interface is available here:
>>>
>>> http://prplfoundation.org/wiki/MIPS_documentation
>>>
>>> As we have previously discussed, this is an ideal place to
>>> define the handover of device tree data from bootloader to
>>> kernel. Using a0 =3D=3D -2 and defining which register(s) you
>>> need for the actual data will fit nicely. I'll happily
>>> include whatever is decided into the next version of the spec.
>=20
> this originates from an off-list discussion some months ago started by
> John Crispin.
>=20
> (CC +John, Ralf, Jonas, linux-mips)
>=20
>>
>> (CC +Andrew, Ezequiel, James, James)
>>
>> On the talk of DT handover, this recent patchset adding support for a
>> system doing so to Linux is relevant:
>>
>>     http://www.linux-mips.org/archives/linux-mips/2015-02/msg00312.htm=
l
>>
>> I'm also working on a system for which I'll need to implement DT
>> handover very soon. It would be very nice if we could agree on some
>> standard way of doing so (and eventually if the code on the Linux side=

>> can be generic enough to allow a multiplatform kernel).
>>
>=20
> to be conformant with UHI I propose $a0 =3D=3D -2 and $a1 =3D=3D addres=
s of DT
> blob. It is a simple extension and should not interfere with the
> various legacy boot interfaces.

I was just looking at Andrew's patch:
http://patchwork.linux-mips.org/patch/9549/

How would the other registers (i.e. $a2 and $a3) be defined for this
boot interface? I'm guessing any future extensions are envisioned to use
a different negative value of $a0, in which case treating them as
unused/undefined is fine, but perhaps that should be spelt out in the
UHI spec?

Cheers
James

>=20
> U-Boot mainline code is almost ready for DT handover. I have prepared
> a patch [1] which completes it by implementing my proposal.
>=20
> [1] http://git.denx.de/?p=3Du-boot/u-boot-mips.git;a=3Dcommitdiff;h=3D3=
464e8de491c640d14d72853a741cc367ebabc79
>=20


--jsox8XNqLhRna4qK0swddEh8ng2sV6wek
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJVBrCyAAoJEGwLaZPeOHZ6Pq4P/ir/t0IRXMg3IxD8Wwf7iwL4
thsgP7w1B6kfhDgBOALxqSGCyEbRzO754X+5jQ3lTZ7cEfEjwEdi+jZE9g2E2ir1
4JebH5FmYvqdiICZsE6LYvT1tYL1k1nBq/Tphpf/lGt01lHxkY3Hq+0wwYwVXhzy
B31EwiPm0NAyLGVPWVZCoqWpOAk8MjvRU1fGQCP1HFQGSg9Up2ykeYOr6C/5tYKB
c/avVvHbgDVpIVp/CFacVHWFS9ULQro9KP2n4m8dWQez8QtwPJEACWKgf5rk/zaD
e+txktX0Ky9jl4P20qkU1DO10GDwFJOP8vmU+3NREo0DaQWcYEXm+2yc6rNwkvvl
ECMFhuFU6Exhk1mMBLqsAbRsBLKbwQzThNHu7iTx9cMQWSRy30z0GeilqTpLR0qG
jzXMux81DZwNlsPrU4c2A1Q7cpXq4JIalHTyQgL5BUquYyCHUv9rdAuQiTIdvXOS
bR6mR+YO2wU4SYThOHB0jNXYkfu6hqXBIB55vQEnlZj9zz+O6FXGZgwWmG1SvE9y
wJ0ClZ4vkkqvDzau8wfISa+PO3Z9hbTwBzwX/sE/CmvDwDFFt3ghJpmFmGpfUU5S
uV7AGqUTJKt8ZCe3r5puUjEiMJSrhhA5bGrndG9+vHrgh0DuyMB8PGwsVu+oOPIK
6nIL/tgzisuAGw4glKXc
=Zs2S
-----END PGP SIGNATURE-----

--jsox8XNqLhRna4qK0swddEh8ng2sV6wek--

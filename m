Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Mar 2015 13:33:17 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:40290 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27008791AbbCPMdPMv5M4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 16 Mar 2015 13:33:15 +0100
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id 4E81C41F8DDE;
        Mon, 16 Mar 2015 12:33:10 +0000 (GMT)
Received: from mailapp01.imgtec.com ([10.100.180.242])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Mon, 16 Mar 2015 12:33:10 +0000
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Mon, 16 Mar 2015 12:33:10 +0000
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 5C2DE5F417853;
        Mon, 16 Mar 2015 12:33:08 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Mon, 16 Mar 2015 12:33:10 +0000
Received: from [192.168.154.110] (192.168.154.110) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Mon, 16 Mar
 2015 12:33:09 +0000
Message-ID: <5506CD85.8070008@imgtec.com>
Date:   Mon, 16 Mar 2015 12:33:09 +0000
From:   James Hogan <james.hogan@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
MIME-Version: 1.0
To:     Matthew Fortune <Matthew.Fortune@imgtec.com>,
        Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
        Paul Burton <Paul.Burton@imgtec.com>,
        "Andrew Bresticker" <abrestic@chromium.org>
CC:     "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
        Ezequiel Garcia <Ezequiel.Garcia@imgtec.com>,
        James Hartley <James.Hartley@imgtec.com>,
        "John Crispin" <blogic@openwrt.org>,
        Jonas Gorski <jogo@openwrt.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: [U-Boot] MIPS UHI spec
References: <6D39441BF12EF246A7ABCE6654B0235320FDC2AC@LEMAIL01.le.imgtec.org>   <20150226101739.GY17695@NP-P-BURTON> <CACUy__Ux6v9O0RmSiUr6vDDJ8JSDPCsCTqm=KOiNM0M=x3hoQQ@mail.gmail.com> <5506B0B2.3020606@imgtec.com> <6D39441BF12EF246A7ABCE6654B023532100679F@LEMAIL01.le.imgtec.org>
In-Reply-To: <6D39441BF12EF246A7ABCE6654B023532100679F@LEMAIL01.le.imgtec.org>
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature";
        boundary="3XEc1RkNJDirkkjUqMg3PMSKREJWc9EN5"
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: b93fcccb
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46396
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

--3XEc1RkNJDirkkjUqMg3PMSKREJWc9EN5
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 16/03/15 11:53, Matthew Fortune wrote:
> James Hogan <James.Hogan@imgtec.com> writes:
>> On 26/02/15 12:37, Daniel Schwierzeck wrote:
>>> 2015-02-26 11:17 GMT+01:00 Paul Burton <paul.burton@imgtec.com>:
>>>> On Thu, Feb 19, 2015 at 01:50:23PM +0000, Matthew Fortune wrote:
>>>>> Hi Daniel,
>>>>>
>>>>> The spec for MIPS Unified Hosting Interface is available here:
>>>>>
>>>>> http://prplfoundation.org/wiki/MIPS_documentation
>>>>>
>>>>> As we have previously discussed, this is an ideal place to define
>>>>> the handover of device tree data from bootloader to kernel. Using a=
0
>>>>> =3D=3D -2 and defining which register(s) you need for the actual da=
ta
>>>>> will fit nicely. I'll happily include whatever is decided into the
>>>>> next version of the spec.
>>>
>>> this originates from an off-list discussion some months ago started b=
y
>>> John Crispin.
>>>
>>> (CC +John, Ralf, Jonas, linux-mips)
>>>
>>>>
>>>> (CC +Andrew, Ezequiel, James, James)
>>>>
>>>> On the talk of DT handover, this recent patchset adding support for =
a
>>>> system doing so to Linux is relevant:
>>>>
>>>>
>>>> http://www.linux-mips.org/archives/linux-mips/2015-02/msg00312.html
>>>>
>>>> I'm also working on a system for which I'll need to implement DT
>>>> handover very soon. It would be very nice if we could agree on some
>>>> standard way of doing so (and eventually if the code on the Linux
>>>> side can be generic enough to allow a multiplatform kernel).
>>>>
>>>
>>> to be conformant with UHI I propose $a0 =3D=3D -2 and $a1 =3D=3D addr=
ess of DT
>>> blob. It is a simple extension and should not interfere with the
>>> various legacy boot interfaces.
>>
>> I was just looking at Andrew's patch:
>> http://patchwork.linux-mips.org/patch/9549/
>>
>> How would the other registers (i.e. $a2 and $a3) be defined for this
>> boot interface? I'm guessing any future extensions are envisioned to u=
se
>> a different negative value of $a0, in which case treating them as
>> unused/undefined is fine, but perhaps that should be spelt out in the
>> UHI spec?
>=20
> Sounds sensible. Making it explicit may help prevent anyone extending t=
his
> and presuming that they can give meaning to one of the unused registers=
=2E
>=20
> Did anyone come to a conclusion on physical vs virtual address for the
> DTB? I forgot to reply to the thread, I would have thought the KSEG0
> address would be the obvious choice so that it is immediately usable fr=
om
> ordinary memory accesses. However, that is only because I don't follow =
how
> the kernel would benefit from being given a physical address. It can't =
be
> remapped except for the case of segmentation control (I believe) so the=
re
> seems little risk in using KSEG0.

The only obvious cases of physical addresses being passed into MIPS
Linux I can find by grepping for fw_arg[0123] are:
bcm3384: for DT boot, expects physical address of dtb in arg2
fw/sni and lantiq: expect physical arg pointer in arg1.

Physical addresses are probably of more use for arches where only
virtual addresses can be accessed after the MMU is turned on, and Linux
is started with the MMU turned off.

I suppose the problems with using virtual addresses for MIPS would be:
* limits it to low 256MB of RAM usually accessible in kseg0 and kseg1
* as you say, slightly less resistant to segmentation changes

I don't think either of those are really significant problems, though I
can see the appeal of physical addresses for this sort of interface. If
however the rest of the UHI boot APIs deal with directly usable
pointers, then maybe its best to stick with that pattern for consistency.=


Cheers
James


--3XEc1RkNJDirkkjUqMg3PMSKREJWc9EN5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJVBs2FAAoJEGwLaZPeOHZ6DOUP/jpLjyMo2pTQW27BH5+h+rAd
mf544CIeSj9nlnSe8JCcKgSyo76XxuwIzobA/sE4SmPzH9Z9tV9bCOO1ivcKwy0+
Er9WP71vG6Nsid/3NfUulEaRRPQx82/SOVfAy2YLvofXvzdp2JJ/KiOeyumQeICX
Numhy2ugMJTHKlztniX3j5hoImqRwpZeB2al19+PsnlWkTReViYv2fsszK284opL
Xz1mNGekSv/nzi6rzwVy5ZT+NTJBBeMN3L3+sJOvPsSgfG/5HPbYWzrkJMjYL9zl
+nj6CVSoSUXOVXC/XGUbDlKBQWj7H/yQ9yXwDNLp+F2gwWA62Q/bNfE4UlrRzXhP
hOlBc2ju2SElOVb1M1nPIhh2PcwoLunZ6rHasN/qJfkcTOrxOcFVmokumEMppEOz
TUwS46Nk3x40N47b58NQeXAL9JRfaUtEAGqflfcSCtGKfqxolJ5WPTowAY6h9hcA
dR2g1ivuy+NkFORoCO2b5kAWg6FDK6u/+bJF06QXPIKGWF+N8GFe5qCZgDyd2y3/
yKffqPhUvjx6jE890EtClIpgoCU9DATpBQN+BTco/kOp1BpQTAWhdg8/3+0EfUS9
+FyuNpQltn4It8RYzwHe0cFzCUJgzHAi2hQU+tM1aVkTP/1P1H9dZcTCZNYtzRV+
kqhMlU7gejslGCDOdUJE
=ks3W
-----END PGP SIGNATURE-----

--3XEc1RkNJDirkkjUqMg3PMSKREJWc9EN5--

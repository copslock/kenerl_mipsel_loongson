Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 29 Dec 2012 00:38:00 +0100 (CET)
Received: from qmta03.westchester.pa.mail.comcast.net ([76.96.62.32]:58939
        "EHLO qmta03.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6817293Ab2L1Xh7IZwIK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 29 Dec 2012 00:37:59 +0100
Received: from omta22.westchester.pa.mail.comcast.net ([76.96.62.73])
        by qmta03.westchester.pa.mail.comcast.net with comcast
        id hAj11k0071ap0As53Bds6m; Fri, 28 Dec 2012 23:37:52 +0000
Received: from [192.168.1.13] ([76.106.69.86])
        by omta22.westchester.pa.mail.comcast.net with comcast
        id hBdr1k0051rgsis3iBdrMA; Fri, 28 Dec 2012 23:37:52 +0000
Message-ID: <50DE2D49.1000603@gentoo.org>
Date:   Fri, 28 Dec 2012 18:37:45 -0500
From:   Joshua Kinard <kumba@gentoo.org>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/17.0 Thunderbird/17.0
MIME-Version: 1.0
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     Linux MIPS List <linux-mips@linux-mips.org>
Subject: Re: Unhandled kernel unaligned access on IP32 w/ network I/O && 3.7.1?
References: <50DD1FB9.6060707@gentoo.org> <20121228215225.GC6786@linux-mips.org>
In-Reply-To: <20121228215225.GC6786@linux-mips.org>
X-Enigmail-Version: 1.4.6
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig765BB01665E1675B9B7159D6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=q20121106; t=1356737872;
        bh=MCC5oo/Fv7bhoHdgZGXN0W2GfI1dDZFDP5ap8u/59PA=;
        h=Received:Received:Message-ID:Date:From:MIME-Version:To:Subject:
         Content-Type;
        b=XyVh+EqcvXtgIiyySZINcNzf8DCPY7I8eGuYyJqxafNX5eOSH2U59PYdlLXFlGsRn
         2Hs4z5oH9xOsFGYWE1v3OQZirY3cTiunQATVX4NOUv7QDObR5SjxHNH09HtVurbmu+
         fP8AdQhubbDmGHaPT5zVVlTbn4a81VLpxtzYb9Byfcr7nNB8QO/ztLwhvtBudMvnKD
         8DSty9szcLxUDTLKgZSCGVkFmMJ0coZn7pelHmhmJSENV+86SqgRC5I132xqCknjYh
         YGS0f+m/tjwHrQEESmQcEfhCcJWvORyCLGK5+yt096PUbdAeLi+qPlqMq+KLoFRjIT
         fF7+Cp2eOx70w==
X-archive-position: 35348
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
--------------enig765BB01665E1675B9B7159D6
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 12/28/2012 4:52 PM, Ralf Baechle wrote:
> On Thu, Dec 27, 2012 at 11:27:37PM -0500, Joshua Kinard wrote:
>=20
>> Has anyone run into an unhandled kernel unaligned access under 3.7.1? =
 I've
>> triggered it twice w/ network I/O on an SGI IP32 machine, however, the=
 stack
>> trace does not appear to be specific to any of IP32's own drivers.  3.=
6.7
>> was very stable, and the two oopses I've triggered so far both happene=
d
>> under 3.7.1.
>>
>> It looks like the culprit is in sk_stream_alloc_skb or tcp_sendmsg, ho=
wever,
>> I have little experience in the higher-level networking stack within L=
inux
>> and wanted to see if anyone else has triggered this on other MIPS syst=
ems.
>>
>> Seems to happen when I am logged in via SSH (on IPv6) and generating a=
 burst
>> of console output.
>>
>> Unhandled kernel unaligned access[#3]:
>> Cpu 0
>> $ 0   : 0000000000000000 0000000000000010 0000000000000000 bfffff00567=
1271c
>> $ 4   : 0000000000000000 0000000000000000 0000000000000000 00000000000=
00000
>> $ 8   : 980000005c24e000 0000000000000000 980000005c24e000 00000000000=
000cc
>> $12   : ffffffff9001fce1 000000001000001e fffffffffffff000 00000000000=
0001f
>> $16   : 980000005c00fa40 ffffffffde0300b8 ffffff0000000000 00000000000=
00005
>> $20   : 000000007f875700 00000000000005a8 0000000000000008 00000000000=
00005
>> $24   : 0000000000000001 00000000000003f0
>> $28   : 980000005c00c000 980000005c00fa10 0000000000000000 ffffffff800=
059a0
>> Hi    : 0000000007a11c93
>> Lo    : b645a1cac992645e
>> epc   : ffffffff8000b700 do_ade+0x1b0/0x480
>>     Tainted: G      D
>                      ^^^
>=20
> This kernel has already oopsed before.  Which means this oops message i=
s
> pretty much worthless.
>=20
>   Ralf

I'll try to recapture it over the weekend.  This was the only output left=
 in
the serial console buffer when I reattached, as I had the console
disconnected when it happened.  Thanks!

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


--------------enig765BB01665E1675B9B7159D6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (MingW32)

iQIcBAEBAgAGBQJQ3i1PAAoJENsjoH7SXZXjdt0P/j9y7PNKPeYBF+Ipjwj16JDt
iCLZk0yVEo1LfqJr8zlaC5MNxP3grYpFZs+WRsj0l82hh7HOH10lSGr5qGocS2Eu
tyafodoAaR5mdYauj/H31F7A0uJiZRUBVMEEK8agL5BaUlu0hvyw5pcPFSepFNLS
Cgy5GFnQHoi3Fa+Gh/VBlRR06TFfvCdh42MzF0lGDgPgwArpG1ew0IIHJR03hKhG
Prai0DmqkjvP6AmY0QSbOrgcCAWmWXfBpPQ1N0NND5lsrW92iOyJSgS/ex2awk3a
oP/NiG0zNinTnmyR8bAcQmrD6zmBywHFN92z+Qjl4Sk4YAdIWGfi5JJVvcqhPIRV
yNb7rejoIwAfsL9r/DdTQnGfY+N1J0PDrHFsuF7aTd+drMSL9L+1o50Ilrmqd5+r
vQLOnrhBr6xji+DFWZ2I69c3rNhKzyxxuyImEQD4EAm4Yk7qlG910cFoEiddADAU
3euG3uVk6x1FRunWo5C/M7zo9s/7nEQUlIu/0/reCU+MAmJYHe+LfVJckHDHp6K3
QlROS+0BdpVnkQC5vnM5E2meFtxRK5IJMVRkCo4vFGKjrrJUa3BJrzqJeO0Yes1I
qUNAdvHfL1ZFjXnE1ztHSe5i9QWEeFGWI7W/fz6Job8QLZWPDHiWJFi5kDozT5bl
q7C2BQkbvnekSFSqM6DV
=4DXn
-----END PGP SIGNATURE-----

--------------enig765BB01665E1675B9B7159D6--

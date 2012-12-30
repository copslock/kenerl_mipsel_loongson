Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 30 Dec 2012 09:23:48 +0100 (CET)
Received: from qmta05.westchester.pa.mail.comcast.net ([76.96.62.48]:39996
        "EHLO qmta05.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6823030Ab2L3IXrGSPt4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 30 Dec 2012 09:23:47 +0100
Received: from omta02.westchester.pa.mail.comcast.net ([76.96.62.19])
        by qmta05.westchester.pa.mail.comcast.net with comcast
        id hkLr1k0030QuhwU55kPgN3; Sun, 30 Dec 2012 08:23:40 +0000
Received: from [192.168.1.13] ([76.106.69.86])
        by omta02.westchester.pa.mail.comcast.net with comcast
        id hkPf1k0071rgsis3NkPf1Y; Sun, 30 Dec 2012 08:23:40 +0000
Message-ID: <50DFFA07.1040302@gentoo.org>
Date:   Sun, 30 Dec 2012 03:23:35 -0500
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
 boundary="------------enig7251CB8D6D467C0D6FF97DF7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=q20121106; t=1356855820;
        bh=i8YkfYL9X/d/Er038T8qhiF9R0Az4lY1BDNFZy0epsw=;
        h=Received:Received:Message-ID:Date:From:MIME-Version:To:Subject:
         Content-Type;
        b=h8GZGdnUrlJxli6gG+9fq6hWr/T/LJHvFpv6X5LhZbXKiR9QjVIeYc2Of8fMdn049
         h+K2v+dTfnirQ8hg4ezr0BvnYzPH9Hs3KnGGhKHJ4zaAtou30ISBqgGuHGqvnqmsfT
         uyR79airYNVZvs1LUCEV4T+O918L19iOLyGdfkqe5sCUefLTthxywWX7RovFz4+5qU
         rglCSUr+w4axwibLy49jMqijDBErBtdQPWMWGJAIpMlBCR9pOoEmMgG5OQvdFj13BJ
         EBiVqIGHRp6vVc/uAbGqtW/F6LfGXiZrYTbfvSuI1XYicb0t1dnLM9hmaKmWIXtLDW
         ty3TeKWCmPqTg==
X-archive-position: 35349
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
--------------enig7251CB8D6D467C0D6FF97DF7
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

Here's an untainted oops from IP32.  Triggered by logging in over SSH on
IPv6 and running 'dmesg':

Unhandled kernel unaligned access[#1]:
Cpu 0
$ 0   : 0000000000000000 0000000000000010 0000000000000000 bfffff005e17aa=
c4
$ 4   : 0000000000000000 0000000000000000 0000000000000000 00000000000000=
00
$ 8   : 980000005e00e000 0000000000000000 980000005e00e000 00000000000004=
10
$12   : ffffffff9001fce1 000000001000001e fffffffffffff000 00000000000000=
1f
$16   : 980000005e03fa40 ffffffffde0300b8 ffffff0000000000 00000000000000=
34
$20   : 00000000006532d8 0000000000000594 00000000004a1134 00000000004a00=
00
$24   : 0000000000000001 00000000000003f0
$28   : 980000005e03c000 980000005e03fa10 0000000000000000 ffffffff800059=
a0
Hi    : 000000000011a02a
Lo    : 000000000005e00e
epc   : ffffffff8000b700 do_ade+0x1b0/0x480
    Not tainted
ra    : ffffffff800059a0 ret_from_exception+0x0/0x24
Status: 9001fce3    KX SX UX KERNEL EXL IE
Cause : 00000010
BadVA : bfffff005e17aac4
PrId  : 00002733 (RM7000)
Process sshd (pid: 1323, threadinfo=3D980000005e03c000, task=3D980000005f=
e76000,
tls=3D0000000077010490)
Stack : 980000005e00e6a0 980000005e17aa0c 980000005faef000 00000000000005=
94
        0000000000000034 ffffffff800059a0 0000000000000000 00000000000000=
10
        00000000000000d0 0000000000000000 980000005faef000 00000000000008=
a0
        0000000000000000 0000000000000000 980000005e00e000 00000000000000=
00
        980000005e00e000 0000000000000410 0000000000000020 ffffffff80223b=
6c
        fffffffffffff000 000000000000001f 980000005e17aa0c 980000005faef0=
00
        0000000000000594 0000000000000034 00000000006532d8 00000000000005=
94
        00000000004a1134 00000000004a0000 0000000000000001 00000000000003=
f0
        0000000000000014 ffffffff802de0d0 980000005e03c000 980000005e03fb=
70
        0000000000000000 ffffffff80334ef8 ffffffff9001fce3 000000000011a0=
2a
        ...
Call Trace:
[<ffffffff8000b700>] do_ade+0x1b0/0x480
[<ffffffff800059a0>] ret_from_exception+0x0/0x24
[<ffffffff80334f24>] sk_stream_alloc_skb+0x6c/0x118
[<ffffffff80335e8c>] tcp_sendmsg+0x6fc/0xe90
[<ffffffff802d3744>] sock_aio_write+0x10c/0x150
[<ffffffff800b48c4>] do_sync_write+0x9c/0x108
[<ffffffff800b4a98>] vfs_write+0x168/0x180
[<ffffffff800b4bbc>] SyS_write+0x54/0xb8
[<ffffffff80013538>] handle_sys+0x118/0x13c


Code: 00441024  5440ffe6  de030100 <68730000> 6c730007  24030000  1460004=
0
00000000  8e020124
---[ end trace 8127ff095caa30f9 ]---


Turns out it is non-fatal.  The serial console is still alive, but sshd w=
as
terminated as a result (it's in the 'Ds' state under ps ux output).


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


--------------enig7251CB8D6D467C0D6FF97DF7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (MingW32)

iQIcBAEBAgAGBQJQ3/oNAAoJENsjoH7SXZXjSMoP/2AZujV1MWIDWQuURxOH01Dc
pSnMcPrpqdkL04hFrnmXneIlqzPnU2vzjttEYkGUaIst5zDncPHzXkxX1vsQivwG
eVLbvwJKifjos6b1W9a3JJkcs3zr/O6FitzrI+6DP9Z+PAtl6vl2r1ySISYbeA2j
e84RjDNpaYowCkeiYO1mJEJ9nkstc7wkEBRMP93craTfl59shB0/bszTRymhE5tf
xzK89eKOeEz8rNmQ9nnpjHHX6sQ830ad9by8XiB7ZPGjftCGsEs7irmITxAyvCLx
JftQ0p4yKD8A4ngkZb7UE/09lRznQxNpStEWBGjZH3Kyi0Ivgttgu9URJZOCs5Mv
jk1g3aRJ7mVwnORWfE8xE+ei8KX77pKlaDd78Wmq098uBQmOA9IEFGsI0Ehov63J
TQKtmYMNq66ynaqCBnh73XfcBUL9MaZ8POav/Ab1AV11USANQfdW4AwkdWzicALF
fb7JptqWIxaOOy5ToaPUIc4IIZQe7hPQ3dt/CLSHFo0vMkJCv+dAJPtUbqDlMvv4
/B66/HMj1QE13i9uS40owW3YjXtFh6ZWgqfzqhzqtSujDNrw/Ft6nKFL8Y7xOgzv
OW2MPtMoW9ALUWDTK2+1cLbWlZ/I9k+QLk9ALEeSUlC1L9im5TxnMbERVobeCml3
c5mM3+IkKpCaxRqmtwlg
=ZSMt
-----END PGP SIGNATURE-----

--------------enig7251CB8D6D467C0D6FF97DF7--

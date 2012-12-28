Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 Dec 2012 05:27:27 +0100 (CET)
Received: from qmta07.westchester.pa.mail.comcast.net ([76.96.62.64]:47933
        "EHLO qmta07.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6816831Ab2L1E10E447z (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 28 Dec 2012 05:27:26 +0100
Received: from omta02.westchester.pa.mail.comcast.net ([76.96.62.19])
        by qmta07.westchester.pa.mail.comcast.net with comcast
        id gsNt1k0010QuhwU57sTK3s; Fri, 28 Dec 2012 04:27:19 +0000
Received: from [192.168.1.13] ([76.106.69.86])
        by omta02.westchester.pa.mail.comcast.net with comcast
        id gsTJ1k0061rgsis3NsTJ9P; Fri, 28 Dec 2012 04:27:19 +0000
Message-ID: <50DD1FB9.6060707@gentoo.org>
Date:   Thu, 27 Dec 2012 23:27:37 -0500
From:   Joshua Kinard <kumba@gentoo.org>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/17.0 Thunderbird/17.0
MIME-Version: 1.0
To:     Linux MIPS List <linux-mips@linux-mips.org>
Subject: Unhandled kernel unaligned access on IP32 w/ network I/O && 3.7.1?
X-Enigmail-Version: 1.4.6
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig0DC42BBD64501981ABFAD84C"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=q20121106; t=1356668839;
        bh=4WLtE5N8es9AanQXS8O4lKUnhTeUmL8F84qzKesj4rE=;
        h=Received:Received:Message-ID:Date:From:MIME-Version:To:Subject:
         Content-Type;
        b=oL+SSjkJIyUrKqeMuA+7WyEbIuAMdssB10M1vGhhEcwVVOLZ3MpczPCGyXfuNuuUE
         22eHp0qIydufxYzLqofBHXqvxsX7djVlU4kKWLOmN3mwk4Txo3tFb2bOcC8fj1FWmv
         Q11c1Cft7KJy9NGbN+lpGt/rlmwLH/phi8kZdCp9s2XQ/uuZ1XYA5Cb5daB60XxeN2
         SouYw7mjZdqHhBdVzfCCUNqdhKiLkKHpvvtzIdQXe3UFfAXZA/KXQ8N62kgrI6ZtAf
         Stv/bOfu4e2A80DZnx+Rn8Uiz5jXZPrpNJ5I4S2GLV2RIi929/A5Fuqs46EVlogQbJ
         ZggROUoAnOJKg==
X-archive-position: 35343
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
--------------enig0DC42BBD64501981ABFAD84C
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Has anyone run into an unhandled kernel unaligned access under 3.7.1?  I'=
ve
triggered it twice w/ network I/O on an SGI IP32 machine, however, the st=
ack
trace does not appear to be specific to any of IP32's own drivers.  3.6.7=

was very stable, and the two oopses I've triggered so far both happened
under 3.7.1.

It looks like the culprit is in sk_stream_alloc_skb or tcp_sendmsg, howev=
er,
I have little experience in the higher-level networking stack within Linu=
x
and wanted to see if anyone else has triggered this on other MIPS systems=
=2E

Seems to happen when I am logged in via SSH (on IPv6) and generating a bu=
rst
of console output.

Unhandled kernel unaligned access[#3]:
Cpu 0
$ 0   : 0000000000000000 0000000000000010 0000000000000000 bfffff00567127=
1c
$ 4   : 0000000000000000 0000000000000000 0000000000000000 00000000000000=
00
$ 8   : 980000005c24e000 0000000000000000 980000005c24e000 00000000000000=
cc
$12   : ffffffff9001fce1 000000001000001e fffffffffffff000 00000000000000=
1f
$16   : 980000005c00fa40 ffffffffde0300b8 ffffff0000000000 00000000000000=
05
$20   : 000000007f875700 00000000000005a8 0000000000000008 00000000000000=
05
$24   : 0000000000000001 00000000000003f0
$28   : 980000005c00c000 980000005c00fa10 0000000000000000 ffffffff800059=
a0
Hi    : 0000000007a11c93
Lo    : b645a1cac992645e
epc   : ffffffff8000b700 do_ade+0x1b0/0x480
    Tainted: G      D
ra    : ffffffff800059a0 ret_from_exception+0x0/0x24
Status: 9001fce3    KX SX UX KERNEL EXL IE
Cause : 00000010
BadVA : bfffff005671271c
PrId  : 00002733 (RM7000)
Process rsync (pid: 3844, threadinfo=3D980000005c00c000,
task=3D980000005fada000, tls=3D0000000077dc9490)
Stack : 980000005c24e6a0 9800000056712664 980000005c228000 00000000000005=
a8
        0000000000000005 ffffffff800059a0 0000000000000000 00000000000000=
10
        00000000000000d0 0000000000000000 980000005c228000 00000000000008=
a0
        0000000000000000 0000000000000000 980000005c24e000 00000000000000=
00
        980000005c24e000 00000000000000cc 0000000000000020 ffffffff80223b=
6c
        fffffffffffff000 000000000000001f 9800000056712664 980000005c2280=
00
        00000000000005a8 0000000000000005 000000007f875700 00000000000005=
a8
        0000000000000008 0000000000000005 0000000000000001 00000000000003=
f0
        0000000000000014 ffffffff802de0d0 980000005c00c000 980000005c00fb=
70
        0000000000000000 ffffffff80334ef8 ffffffff9001fce3 0000000007a11c=
93
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
---[ end trace e5d137adb9de32d0 ]---


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


--------------enig0DC42BBD64501981ABFAD84C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (MingW32)

iQIcBAEBAgAGBQJQ3R+5AAoJENsjoH7SXZXj/0IQAJCHFyrh2GZzuMDZ7FWs0PIS
zWncJKpm/5pepgi9StGt8s9RtCl2+kbR+t5Uj/ig0Sn+KEhyF+qxAgjnAh7wGBub
fuRKEsKSePBOXD/brteXuxXGbedpYDtcbniEzL/Xsur/laSblq/xC92j+R4GVvNh
tdZPmOQFyxvVYuRuwatnCdaslxNl1gj83lYR018xP1JRY/GhwS8baIkFoI95pvAQ
VdRSG/y1qKIVjdBP045iDNHw5DI4YW1T0UXdwo52gh/OSQRQ98cfL0OKOTV0fmyY
LDOiUGE8lBO+ImrQmK2fQf1005pFalHe8n27N3IXHiRY37gHFrWF740vrrSvYDBD
pjMP8H5zzhScwUXu+FxZtjhzTxwVh1QFAQBWX50WEpoHENCwrwbrmx6EPwZwZ/H5
jNJAMCSzgRXjcqvCG5BUb7AwRs/U+oaiuIqDg+3Z7GW4KFC/9CYeOSS2sOSP/2M6
Upgu/b2Hakg+CDnQOrsbif97o2jZ+RsFj9ysOKwxuaxcJhE1NOswXghudAdKBRsB
634LnvjjbAzD9k+goqjqix1Kjc3ueBqJbbu9klfHs+Kv98ytuKarEUTMjtto6flN
4Ac1jf44+OX9lBx0tSeCXialTh1jBLgBEjgnj+Hh3Qe0RI+mjLQGefmqFHbjthot
9w0+4UbGCxvvpsj5YY2M
=gc2T
-----END PGP SIGNATURE-----

--------------enig0DC42BBD64501981ABFAD84C--

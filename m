Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Jan 2013 04:25:28 +0100 (CET)
Received: from qmta03.westchester.pa.mail.comcast.net ([76.96.62.32]:38609
        "EHLO qmta03.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6816743Ab3AADZ0Unopd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 1 Jan 2013 04:25:26 +0100
Received: from omta02.westchester.pa.mail.comcast.net ([76.96.62.19])
        by qmta03.westchester.pa.mail.comcast.net with comcast
        id iTGB1k00D0QuhwU53TRKZo; Tue, 01 Jan 2013 03:25:19 +0000
Received: from [192.168.1.13] ([76.106.69.86])
        by omta02.westchester.pa.mail.comcast.net with comcast
        id iTRG1k00r1rgsis3NTRJKT; Tue, 01 Jan 2013 03:25:19 +0000
Message-ID: <50E2571C.50607@gentoo.org>
Date:   Mon, 31 Dec 2012 22:25:16 -0500
From:   Joshua Kinard <kumba@gentoo.org>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/17.0 Thunderbird/17.0
MIME-Version: 1.0
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     Linux MIPS List <linux-mips@linux-mips.org>
Subject: Re: Unhandled kernel unaligned access on IP32 w/ network I/O && 3.7.1?
References: <50DD1FB9.6060707@gentoo.org> <20121228215225.GC6786@linux-mips.org> <50DFFA07.1040302@gentoo.org>
In-Reply-To: <50DFFA07.1040302@gentoo.org>
X-Enigmail-Version: 1.4.6
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig2A9F43BBD9D9FBA432D91D15"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=q20121106; t=1357010719;
        bh=k4S/Pow3uP9HLeFVuoPzVOK8Hcz6u+6XAgteWtwxubQ=;
        h=Received:Received:Message-ID:Date:From:MIME-Version:To:Subject:
         Content-Type;
        b=SLsAQh9/kSYRa9nLQhf5LkSFoTPY//JiM/cBTS98Sd2Xr8BrI8ineX91hahN//FaV
         7MJpxf0zky9BdEWnOabL+mb99VmCD36xcyYTJMN/giLhSfbogT5UG81SNkdymKetyR
         DDDGm3qvoeH0Zw3dyKeV5EcWhcuh7rlzp6F5xJBIoZuDOKkGfxUE/ja648PWiw5vq1
         eGcwx0wRZp0lNatcxq7/qbFQuF/TgJjE939cz56YN7DdBPBz2JnIA4LnYyvOv2o7N3
         TG1BEf7y3Fqpq6fYycbzRjH7SOZX2WPtK37m+Bwt2FxSW2NJBMmsl8gPcD7K1xGd/D
         WDaKGT1PPc0qA==
X-archive-position: 35351
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
--------------enig2A9F43BBD9D9FBA432D91D15
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 12/30/2012 3:23 AM, Joshua Kinard wrote:
>=20
> Here's an untainted oops from IP32.  Triggered by logging in over SSH o=
n
> IPv6 and running 'dmesg':
>=20
> Unhandled kernel unaligned access[#1]:
> Cpu 0
> $ 0   : 0000000000000000 0000000000000010 0000000000000000 bfffff005e17=
aac4
> $ 4   : 0000000000000000 0000000000000000 0000000000000000 000000000000=
0000
> $ 8   : 980000005e00e000 0000000000000000 980000005e00e000 000000000000=
0410
> $12   : ffffffff9001fce1 000000001000001e fffffffffffff000 000000000000=
001f
> $16   : 980000005e03fa40 ffffffffde0300b8 ffffff0000000000 000000000000=
0034
> $20   : 00000000006532d8 0000000000000594 00000000004a1134 00000000004a=
0000
> $24   : 0000000000000001 00000000000003f0
> $28   : 980000005e03c000 980000005e03fa10 0000000000000000 ffffffff8000=
59a0
> Hi    : 000000000011a02a
> Lo    : 000000000005e00e
> epc   : ffffffff8000b700 do_ade+0x1b0/0x480
>     Not tainted
> ra    : ffffffff800059a0 ret_from_exception+0x0/0x24
> Status: 9001fce3    KX SX UX KERNEL EXL IE
> Cause : 00000010
> BadVA : bfffff005e17aac4
> PrId  : 00002733 (RM7000)
> Process sshd (pid: 1323, threadinfo=3D980000005e03c000, task=3D98000000=
5fe76000,
> tls=3D0000000077010490)
> Stack : 980000005e00e6a0 980000005e17aa0c 980000005faef000 000000000000=
0594
>         0000000000000034 ffffffff800059a0 0000000000000000 000000000000=
0010
>         00000000000000d0 0000000000000000 980000005faef000 000000000000=
08a0
>         0000000000000000 0000000000000000 980000005e00e000 000000000000=
0000
>         980000005e00e000 0000000000000410 0000000000000020 ffffffff8022=
3b6c
>         fffffffffffff000 000000000000001f 980000005e17aa0c 980000005fae=
f000
>         0000000000000594 0000000000000034 00000000006532d8 000000000000=
0594
>         00000000004a1134 00000000004a0000 0000000000000001 000000000000=
03f0
>         0000000000000014 ffffffff802de0d0 980000005e03c000 980000005e03=
fb70
>         0000000000000000 ffffffff80334ef8 ffffffff9001fce3 000000000011=
a02a
>         ...
> Call Trace:
> [<ffffffff8000b700>] do_ade+0x1b0/0x480
> [<ffffffff800059a0>] ret_from_exception+0x0/0x24
> [<ffffffff80334f24>] sk_stream_alloc_skb+0x6c/0x118
> [<ffffffff80335e8c>] tcp_sendmsg+0x6fc/0xe90
> [<ffffffff802d3744>] sock_aio_write+0x10c/0x150
> [<ffffffff800b48c4>] do_sync_write+0x9c/0x108
> [<ffffffff800b4a98>] vfs_write+0x168/0x180
> [<ffffffff800b4bbc>] SyS_write+0x54/0xb8
> [<ffffffff80013538>] handle_sys+0x118/0x13c
>=20
>=20
> Code: 00441024  5440ffe6  de030100 <68730000> 6c730007  24030000  14600=
040
> 00000000  8e020124
> ---[ end trace 8127ff095caa30f9 ]---
>=20
>=20
> Turns out it is non-fatal.  The serial console is still alive, but sshd=
 was
> terminated as a result (it's in the 'Ds' state under ps ux output).

Some quick digging via objdump and a new oops, from a rebuilt kernel
including full debugging, points at an inlined call to skb_reserve from
within sk_stream_alloc_skb in net/ipv4/tcp.c.


Bottom of new oops:
Call Trace:
[<ffffffff8000b710>] do_ade+0x1b0/0x480
[<ffffffff800059a0>] ret_from_exception+0x0/0x24
[<ffffffff803352dc>] sk_stream_alloc_skb+0x6c/0x118
[<ffffffff8033624c>] tcp_sendmsg+0x6fc/0xe98
[<ffffffff802d3c44>] sock_aio_write+0x10c/0x150
[<ffffffff800b5cd4>] do_sync_write+0x9c/0x108
[<ffffffff800b5ea8>] vfs_write+0x168/0x180
[<ffffffff800b5fcc>] SyS_write+0x54/0xb8
[<ffffffff80013558>] handle_sys+0x118/0x13c

Disassembly of vmlinux, and match of address ffffffff803352dc yields this=
:
                if (sk_wmem_schedule(sk, skb->truesize)) {
                        skb_reserve(skb, sk->sk_prot->max_header);
ffffffff803352d8:       8c420108        lw      v0,264(v0)
 *      Increase the headroom of an empty &sk_buff by reducing the tail
 *      room. This is only allowed for an empty buffer.
 */
static inline void skb_reserve(struct sk_buff *skb, int len)
{
        skb->data +=3D len;
ffffffff803352dc:       de0300b8        ld      v1,184(s0)
        skb->tail +=3D len;
ffffffff803352e0:       8e0400a8        lw      a0,168(s0)
 *      Increase the headroom of an empty &sk_buff by reducing the tail
 *      room. This is only allowed for an empty buffer.
 */


I looked around at several files in git, mainly, net/ipv4/tcp.c, and none=
 of
the recent changes to 3.7 sticks out immediately as the cause.  I'll eith=
er
have to use git bisect or run kgdb on it to figure anything else out.

Does this look like a case of scheduling while atomic?  There's a fix in
davem's -next tree that addresses such a cause, but I haven't tried that
just yet to see if it's the same issue.

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


--------------enig2A9F43BBD9D9FBA432D91D15
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (MingW32)

iQIcBAEBAgAGBQJQ4lciAAoJENsjoH7SXZXj6KcQAJtGZ6kSCfKDbC/uDaq+L8UL
NQX8PAIKSjLLFDhfVxa2AIZirtqvvUq7DxO2R6YCcIOSXqySe+m6n1a0crK1TfSM
cAdTKEkOum8zIganEHKCwM60E4H0ODH6WNrRBr0x0esL/0ryb0tx6hnOSVgf8Z7m
di3Bbl2XMNWzk0tXn8hN8YWqSp5/bhCeqjzspvFtxKEVhta5fKwYlA0zaHU8Y2pE
KJ2BujmJ6x6pZ3KyQGP1S27tjCdyA4krQiDS/wZ/49D/ReqbrrNUqBVlCyehvdzE
CZtMwnpNfhBa0jonDTgd2+nSzk4U1Eln6YruayB29qPnuFS42rpfagKzoc/LRoe/
CKqrRDAF0axIStMJwrLwRX1MwjTUP4NkMR1wSx0f5lfGZxFSHhmhkK3+JtJ3gir/
ulHMLYaGjio64LD+i+YIaLNLNkoxQDkmnU1Noumy2bGHqD32uoisAw7qdBJd2jlY
VSGEZUVsWUQCsiTM9YA+mafJ6zMIRyjgtoaF70k9EIYSGTLu6VIri/jWEkQ6dRYx
s/dQzh7hXyW7DmINZrPrqWbBkpRxG6UbNk+avCcytxAyi5bb+6a6JJQ20gO5CFLb
iMzE4ZBJOsE/yLBUxLGSY/vqv01zdDh29Ya6DfP95P3z/rdJTMlPbrgZA2TfiI3U
02z56RXXj4W5hbsTZV6J
=zAGi
-----END PGP SIGNATURE-----

--------------enig2A9F43BBD9D9FBA432D91D15--

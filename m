Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Dec 2017 10:29:33 +0100 (CET)
Received: from forward100o.mail.yandex.net ([37.140.190.180]:47822 "EHLO
        forward100o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990427AbdLGJ3YQQnDR (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 7 Dec 2017 10:29:24 +0100
Received: from mxback9o.mail.yandex.net (mxback9o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::23])
        by forward100o.mail.yandex.net (Yandex) with ESMTP id 9F6BC2A20BA1;
        Thu,  7 Dec 2017 12:29:16 +0300 (MSK)
Received: from smtp4o.mail.yandex.net (smtp4o.mail.yandex.net [2a02:6b8:0:1a2d::28])
        by mxback9o.mail.yandex.net (nwsmtp/Yandex) with ESMTP id CW8d6teHlD-TDk8dAe9;
        Thu, 07 Dec 2017 12:29:16 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; s=mail; t=1512638956;
        bh=7NLTLMWAEp+zxnxtP1RDsG6RQjYCx9zq3T7CUTxJBrc=;
        h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=Y90sBwj5pv6PEGOJV/9BGH6RKL2TT7O+ZjNm8jWTPccGTY+ohi0cvHO829JdGTcTE
         fnpgNxDG4ymJD9g6wSv4YgEgrz/3qT5sz+t8/RBYb1XUErOhGvHz6kRFMGy4cj0Oxx
         ivDZ0fvkT0rSBOJaKRGxEx8t26O7V4Xq1uvnOMnY=
Received: by smtp4o.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id pSoQLzwTIB-T4Y4CLav;
        Thu, 07 Dec 2017 12:29:10 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; s=mail; t=1512638951;
        bh=7NLTLMWAEp+zxnxtP1RDsG6RQjYCx9zq3T7CUTxJBrc=;
        h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=o/jizDFyhTggijbToLXYJlsw4XKhuqJz2zN+biDNqpnN3MjI4/lguCiSbiuoemmzS
         gt6j9pHi2ztCNDy/stEjrUVswkrAzeN3SaqzgtnrEu05MtaAnvrIRuCcXkVoaWKz52
         5UCKvgeZNuXgQSRnSpzNeLrbMRTBKAARFD3ro/MA=
Authentication-Results: smtp4o.mail.yandex.net; dkim=pass header.i=@flygoat.com
Message-ID: <1512638934.10724.4.camel@flygoat.com>
Subject: Re: [PATCH 0/1] About MIPS/Loongson maintainance
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Huacai Chen <chenhc@lemote.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <james.hogan@mips.com>,
        Rui Wang <wangr@lemote.com>, Binbin Zhou <zhoubb@lemote.com>,
        Ce Sun <sunc@lemote.com>, Yao Wang <wangyao@lemote.com>,
        Liangliang Huang <huangll@lemote.com>,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>, r@hev.cc,
        zhoubb.aaron@gmail.com, huanglllzu@163.com, 513434146@qq.com,
        1393699660@qq.com, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 07 Dec 2017 17:28:54 +0800
In-Reply-To: <20171207065759.GC19722@kroah.com>
References: <1512628268-18357-1-git-send-email-chenhc@lemote.com>
         <20171207065759.GC19722@kroah.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-+azCMfa6Lx/OZSrgF+Vu"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Return-Path: <jiaxun.yang@flygoat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61333
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jiaxun.yang@flygoat.com
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


--=-+azCMfa6Lx/OZSrgF+Vu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 2017-12-07 07:57 +0100=EF=BC=8CGreg Kroah-Hartman wrote=EF=BC=9A
> On Thu, Dec 07, 2017 at 02:31:07PM +0800, Huacai Chen wrote:
> > Hi, Linus, Stephen, Greg, Ralf and James,
> >=20
> > We are kernel developers from Lemote Inc. and Loongson community.
> > We
> > have already made some contributions in Linux kernel, but we hope
> > we
> > can do more works.
> >=20
> > Of course Loongson is a sub-arch in MIPS, but linux-mips community
> > is
> > so inactive (Maybe maintainers are too busy?) that too many patches
> > (
> > Not only for Loongson, but also for other sub-archs) were delayed
> > for
> > a long time. So we are seeking a more efficient way to make
> > Loongson
> > patches be merged in upstream.
> >=20
> > Now we have a github organization for collaboration:
> > https://github.com/linux-loongson/linux-loongson.git
>=20
> Ick, why not get a kernel.org account for your git tree?

Of course we would like to get a kernel.org account. But in order to
get a kernel.org account, we must have enough kernel developer's PGP
sigs. In mainland China, it's hard to meet any of them. So wo choose
GitHub to host our git tree.
=20
>=20
> > We don't want to replace linux-mips, we just want to find a way to
> > co-
> > operate with linux-mips. So we will still use the maillist and
> > patchwork
> > of linux-mips, but we hope we can send pull requests from our
> > github to
> > linux-next and linux-mainline by ourselves (if there is no
> > objections
> > to our patches from linux-mips community).
>=20
> What does the mips maintainers think about this?
>=20
> Odds are a linux-next tree is fine, but they probably want to merge
> the
> trees into their larger mips one for the pulls to Linus, much like
> the
> arm-core tree works, right?
Yeah, thanks for your suggestion, we can do like this to reduce work
load of Linus.
>=20
> thanks,
>=20
> greg k-h

Jiaxun Yang
--=-+azCMfa6Lx/OZSrgF+Vu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEmAN5vv6/v0d+oE75wRGUkHP8D2cFAlopCdYACgkQwRGUkHP8
D2f83BAAjnw9C+WRsNyrvKjnBQswd2+Ha0/lrhHSL6tokyVcmBtfgQJJcJJrtp3+
JmpgMMlxi638J3j0OpNI9k83BrXKtEWaqoC0Fl02bgYwwUgigskPbgBqZqv/5fAN
HmxLRRMEK59ssRTkDzg6H0PpuL7ma0hAkhIE+K4ofS/kkBsbM8n54sIPXMhWo8x4
L82F6jh1Eu5KC6A7fzSOebRxjQfG5WtL8Qhl5/HLuJKEOyczPccUCeor8CE72dtj
3xz1igF99uqakRX5tJc39XFpkEhDclOQ0E8HTT9piz2rcoWycaeXqmg9QemI5+aR
PrHJI+0V3Ab0RZJcsDYglKl3CCn3U+JbtCuLuC+/C7TAbvE26gVGyfm69Hj4AItJ
6Rab6E/Ip9LynZPoW6yKwiTlGhkJj9RQrQ98iILqIoSXeEWfVkz2xLoUk+rdVEHj
R7Q+BKqJdn87CJm8JQZGDRW8mmk6uunsLgVgIhVNdb02ohUpFrlfd6AezGBHHvgU
P6d070JZgIO/4Kw4hd88zH70/U81rv4AHfNO+1mg/Fe4t0T+5xy2p5738aGQBVH1
61b8nzkhcJWvt/b31H0BXRs4a0DHxOpi8ogym/FiJhVaxaT4OtBfOPDaJilPW0yl
XANG1el3s0FVsqEyQP7tTr/c3ovd8g25nGoodN91pGWXSdA1sfk=
=T8gT
-----END PGP SIGNATURE-----

--=-+azCMfa6Lx/OZSrgF+Vu--

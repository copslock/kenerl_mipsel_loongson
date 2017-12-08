Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 Dec 2017 08:53:03 +0100 (CET)
Received: from 9pmail.ess.barracuda.com ([64.235.154.210]:34977 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990431AbdLHHwzxHM4p (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 8 Dec 2017 08:52:55 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx1402.ess.rzc.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Fri, 08 Dec 2017 07:52:10 +0000
Received: from localhost (192.168.154.110) by MIPSMAIL01.mipstec.com
 (10.20.43.31) with Microsoft SMTP Server (TLS) id 14.3.361.1; Thu, 7 Dec 2017
 23:51:37 -0800
Date:   Fri, 8 Dec 2017 07:51:35 +0000
From:   James Hogan <james.hogan@mips.com>
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Huacai Chen <chenhc@lemote.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Stephen Rothwell" <sfr@canb.auug.org.au>,
        Ralf Baechle <ralf@linux-mips.org>,
        Rui Wang <wangr@lemote.com>, Binbin Zhou <zhoubb@lemote.com>,
        Ce Sun <sunc@lemote.com>, Yao Wang <wangyao@lemote.com>,
        Liangliang Huang <huangll@lemote.com>,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>, <r@hev.cc>,
        <zhoubb.aaron@gmail.com>, <huanglllzu@163.com>, <513434146@qq.com>,
        <1393699660@qq.com>, <linux-mips@linux-mips.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/1] About MIPS/Loongson maintainance
Message-ID: <20171208075134.GP5027@jhogan-linux.mipstec.com>
References: <1512628268-18357-1-git-send-email-chenhc@lemote.com>
 <20171207065759.GC19722@kroah.com>
 <20171207110549.GM27409@jhogan-linux.mipstec.com>
 <1512652210.13996.10.camel@flygoat.com>
 <20171207141829.GN27409@jhogan-linux.mipstec.com>
 <1512705706.1756.12.camel@flygoat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="f6M9UaX53EEZorp0"
Content-Disposition: inline
In-Reply-To: <1512705706.1756.12.camel@flygoat.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
X-Originating-IP: [192.168.154.110]
X-BESS-ID: 1512719529-321458-11829-45721-14
X-BESS-VER: 2017.14-r1710272128
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.187752
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Return-Path: <James.Hogan@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61352
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@mips.com
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

--f6M9UaX53EEZorp0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 08, 2017 at 12:01:46PM +0800, Jiaxun Yang wrote:
> Also we're going to separate code between
> Loongson2 and Loongson3 since they are becoming more and more
> identical.

Do you mean you want to combine them?

> But It will cause a lot of changes under march of loongson64
>  that currently maintaining by linux-mips community. Send plenty of
> patches to mailing list would not be a wise way to do that. So we can
> PR these changes to linux-next directly and PR to linux-mips before
> merge window.

For the avoidance of doubt, a pull request would not excempt you from
needing your patches properly reviewed on the mailing lists first.

And quoting Stephen's boilerplate response to linux-next additions:
> Thanks for adding your subsystem tree as a participant of linux-next.  As
> you may know, this is not a judgement of your code.  The purpose of
> linux-next is for integration testing and to lower the impact of
> conflicts between subsystems in the next merge window.
>=20
> You will need to ensure that the patches/commits in your tree/series have
> been:
>      * submitted under GPL v2 (or later) and include the Contributor's
>         Signed-off-by,
>      * posted to the relevant mailing list,
>      * reviewed by you (or another maintainer of your subsystem tree),
>      * successfully unit tested, and
>      * destined for the current or next Linux merge window.
>=20
> Basically, this should be just what you would send to Linus (or ask him
> to fetch).  It is allowed to be rebased if you deem it necessary.

Cheers
James

--f6M9UaX53EEZorp0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAloqRHIACgkQbAtpk944
dnrU8xAAqTDR2+6cqkK6KwIyBfqaqrBm4A7SY5j2UA86HNzVDjEFO3Xs2vrjyinr
n+xmqGDp8rrL+hEq6u3I3D/VhBwZIoZHnzG8Rn4wrraF8Wpsu50ggiqqLfKve61g
WmInTkYX/L+duu5BM98Tc9h8HgDMekjonvJSQZlitVQKl4Alw9r9LuL+Hj6Vu5X0
1iiAroPsQ69qz5ebIEmSRsURRN1ZoxlIWDNEjasNR5on0u5gFZAdYOL5rEAHrwaF
zInK/S5SVdO2ucBi5HkIfM2qSfxpTY05OxzReZTunqMxeE8hMEnMwSREzfPDHf3+
WBWLr25ecCGey1oeqDVNj7atZfDSw4JQ9qaqTl7FvZdmYcOH1uOITghvAjiQuBPs
7hnhXa/yEBFOhqU9WOsH6mgxeaYFlyarKm8x6xP7I9XpvBTh8ZWDImJ6Si1BjAkp
Bwo1cEPuUhaQKoKIST3HZT4fXYUt57YItFcAGmmBub+KSqaNp/IaaLmW9fcZB8mP
CuZl9nmdzWQQeVdITw/vqHwRGIgDczzK6YZpX44GLfkKsJfQQrAJ74yXZ4ECrhQS
gdSah8O0dXLyllRrmb7ukseRZb+Feor1nvELUm/nHwLZGUMhcOT2i7unCMlI0y8U
vK8HakzU7XWrqYzSzTcXeE7arePtHRcwwytD59k6xQeG7chHfto=
=8aNB
-----END PGP SIGNATURE-----

--f6M9UaX53EEZorp0--

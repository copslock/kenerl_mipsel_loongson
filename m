Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Dec 2017 12:07:13 +0100 (CET)
Received: from 9pmail.ess.barracuda.com ([64.235.154.210]:41970 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990433AbdLGLHEVW5UI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 7 Dec 2017 12:07:04 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx1412.ess.rzc.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Thu, 07 Dec 2017 11:06:17 +0000
Received: from localhost (192.168.154.110) by MIPSMAIL01.mipstec.com
 (10.20.43.31) with Microsoft SMTP Server (TLS) id 14.3.361.1; Thu, 7 Dec 2017
 03:05:52 -0800
Date:   Thu, 7 Dec 2017 11:05:50 +0000
From:   James Hogan <james.hogan@mips.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Huacai Chen <chenhc@lemote.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Ralf Baechle <ralf@linux-mips.org>,
        Rui Wang <wangr@lemote.com>, Binbin Zhou <zhoubb@lemote.com>,
        Ce Sun <sunc@lemote.com>, Yao Wang <wangyao@lemote.com>,
        Liangliang Huang <huangll@lemote.com>,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>, <r@hev.cc>,
        <zhoubb.aaron@gmail.com>, <huanglllzu@163.com>, <513434146@qq.com>,
        <1393699660@qq.com>, <linux-mips@linux-mips.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/1] About MIPS/Loongson maintainance
Message-ID: <20171207110549.GM27409@jhogan-linux.mipstec.com>
References: <1512628268-18357-1-git-send-email-chenhc@lemote.com>
 <20171207065759.GC19722@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="00hq2S6J2Jlg6EbK"
Content-Disposition: inline
In-Reply-To: <20171207065759.GC19722@kroah.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
X-Originating-IP: [192.168.154.110]
X-BESS-ID: 1512644777-452060-31779-63263-5
X-BESS-VER: 2017.14.1-r1710272128
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.187715
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
X-archive-position: 61334
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

--00hq2S6J2Jlg6EbK
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 07, 2017 at 07:57:59AM +0100, Greg Kroah-Hartman wrote:
> On Thu, Dec 07, 2017 at 02:31:07PM +0800, Huacai Chen wrote:
> > Hi, Linus, Stephen, Greg, Ralf and James,
> >=20
> > We are kernel developers from Lemote Inc. and Loongson community. We
> > have already made some contributions in Linux kernel, but we hope we
> > can do more works.
> >=20
> > Of course Loongson is a sub-arch in MIPS, but linux-mips community is
> > so inactive (Maybe maintainers are too busy?) that too many patches (
> > Not only for Loongson, but also for other sub-archs) were delayed for
> > a long time. So we are seeking a more efficient way to make Loongson
> > patches be merged in upstream.
> >=20
> > Now we have a github organization for collaboration:
> > https://github.com/linux-loongson/linux-loongson.git
>=20
> Ick, why not get a kernel.org account for your git tree?
>=20
> > We don't want to replace linux-mips, we just want to find a way to co-
> > operate with linux-mips. So we will still use the maillist and patchwork
> > of linux-mips, but we hope we can send pull requests from our github to
> > linux-next and linux-mainline by ourselves (if there is no objections
> > to our patches from linux-mips community).
>=20
> What does the mips maintainers think about this?
>=20
> Odds are a linux-next tree is fine, but they probably want to merge the
> trees into their larger mips one for the pulls to Linus, much like the
> arm-core tree works, right?

I'm not officially a MIPS maintainer but I have donned the hat
unofficially a few times lately, so FWIW I think the Loongson stuff
should go through the MIPS tree, since it so often touches core
architecture code.

Clearly there have been some issues getting MIPS stuff applied recently,
but I think the right approach long-term is to try and improve things
there rather than bypass the MIPS tree altogether.

I believe assigning a co-maintainer would help spread Ralf's load, even
if that primarily means helping review patches (something we can all
help with tbh), and being able to ack patches which touch MIPS but need
to go through other subsystem trees (e.g. I know David Daney was waiting
on acks for the MIPS portions of the Octeon III ethernet driver series).

I'm willing to take on that role if Ralf is okay with it. I'm already
trying to keep track of fixes and spend more time reviewing patches on
the list, but the more who can help out the better.

The question of who applies patches can't be avoided though. It would
clearly suck to have all the review in the world but still end up with
the co-maintainer having to take the reigns at the last minute to get
those important fixes in, and then have no time to apply anything
substantial for the merge window.

Cheers
James

--00hq2S6J2Jlg6EbK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlopIIUACgkQbAtpk944
dno18RAAt6C+pTc9d2Zx5cCHKHZJmVGPuUWRD+SBbBaEylo9NUdI7yLJBsfs8Rm2
b/ryeHiw9ZOyGuN3n1Ai0f7mGkBVO/QvEBlg53MyeA4m8gx8BPbmO4/sYKq7ljZl
OzHsucCiyBGNzTNaYlQXRqoWdjlrggKo2RUw7zPYVU/R7oVYQB4Rln+rpcZbU72G
md2rn4VVUkzQG6QHSqagYf1a4drDm9yMz4veaDWj2p91BFbptJwFMR7r4ndSmGIr
pClxtFylvIG+W0qFzidxLbDg88J7ZpWsmLFksic/aNnNYEG3gxdla0zo2KA8rNWX
5dDnMev/xU197qsx59C0zt0VmQdXjJ0DMKjEBKtRa+tvd70D+etNLEyNg1IN+MWp
5OjEKE+AEw2kngrWzfarDpE/icT3nlZdyS5aISmAQXyryuxW1n5iVvpYpS5b562v
rGHbQ7zFisfFO74IFyGqi776Sws2P0kvcaXOXZBoVl/kgfchrBP2AIMcG7/oHI1T
8JjZ0jLqcKJ+7+uGz7gLYvqpU2IkXnrhEZiP2E+RJxrFos5IxwHF05NYNB5gW8R4
+g07QQRxyFKnB3hfLEKpqXaRiw4uxXQdk2xCSJnZwyfMu0kieB3dvpJtSnPkqd6D
tQpolZIezD+Dzhg38pfrm3/HsNVWiuP8C39VGlG0h2GVYhGtn7k=
=9uKS
-----END PGP SIGNATURE-----

--00hq2S6J2Jlg6EbK--

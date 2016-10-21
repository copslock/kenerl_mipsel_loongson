Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Oct 2016 09:46:05 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:55875 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23990513AbcJUHp7BKa-F (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 21 Oct 2016 09:45:59 +0200
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id 13AC041F8DE5;
        Fri, 21 Oct 2016 08:45:22 +0100 (BST)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Fri, 21 Oct 2016 08:45:22 +0100
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Fri, 21 Oct 2016 08:45:22 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 517917F2CCD2C;
        Fri, 21 Oct 2016 08:45:50 +0100 (IST)
Received: from np-p-burton.localnet (10.100.200.125) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Fri, 21 Oct
 2016 08:45:52 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     Nicholas Piggin <npiggin@gmail.com>
CC:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH 0/6] MIPS: Use thin archives & dead code elimination
Date:   Fri, 21 Oct 2016 08:45:47 +0100
Message-ID: <1724594.nvOo2qz5cT@np-p-burton>
Organization: Imagination Technologies
User-Agent: KMail/5.3.2 (Linux/4.7.6-1-ARCH; KDE/5.27.0; x86_64; ; )
In-Reply-To: <20161021115147.0f6eea51@roar.ozlabs.ibm.com>
References: <20161020202705.3783-1-paul.burton@imgtec.com> <20161021115147.0f6eea51@roar.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart23477701.SVBATBIGA1";
        micalg=pgp-sha256; protocol="application/pgp-signature"
X-Originating-IP: [10.100.200.125]
X-ESG-ENCRYPT-TAG: 1b7d744b
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55539
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

--nextPart23477701.SVBATBIGA1
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Nick,

On Friday, 21 October 2016 11:51:47 BST Nicholas Piggin wrote:
> Paul Burton <paul.burton@imgtec.com> wrote:
> > This series fixes a few issues with CONFIG_LD_DEAD_CODE_DATA_ELIMINATION
> > and then enables it, along with CONFIG_THIN_ARCHIVES, for MIPS. This
> > 
> > leads to a typical generic kernel build becoming ~5% smaller:
> >   add/remove: 0/3028 grow/shrink: 1/14 up/down: 18/-457362 (-457344)
> >   ...
> >   Total: Before=9001030, After=8543686, chg -5.08%
> > 
> > Applies atop v4.9-rc1.
> 
> Very nice, and thanks for the kbuild fixes, I think they all look sane.
> 
> Let's try to get those kbuild fixes in through the kbuild tree first
> (which has some other fixes required for 4.9). I can take them and send
> them to kbuild maintainer if you like.

That sounds great :)

> On powerpc we'll likely provide an option to select these manually for
> 4.9 because there has been the odd toolchain issue come up, so that's
> something to consider.

I imagine the MIPS bits will probably be v4.10 material, but hopefully Ralf 
can get them into -next as soon as possible after the kbuild bits are in, 
which should give us some time to discover any toolchain issues.

> For your linker script, you may consider putting the function sections
> into the same input as other text. TEXT_TEXT does not include .text.*,
> so mips's .text.* below it will catch those.
> 
> You may just open-code your TEXT_TEXT, and have:
> 
> *(.text.hot .text .text.fixup .text.unlikely .text.[0-9a-zA-Z_]*)
> 
> or similar.

Ah, so are you saying that would give the linker more scope for discarding 
things?

Thanks,
    Paul
--nextPart23477701.SVBATBIGA1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIcBAABCAAGBQJYCcerAAoJEIIg2fppPBxllhwQAKYrjCJtJSRdaGlUIHyVAcu8
CFLgqlpez68qcjQtxYTzaraZv/hhm0R+fLl8A+dbdVeyS4fcLQhE2tfIU0DD7Sjk
MdwhgWpXmmfZP0FfpOfkpnXCHooKLK2Y1kUJclIzhzkrM9V5bBBwjuDvoDv7hUpm
uDS1hxeGxksiwZMLJWWszLeO4RPdfdtw11AVYkOos9Jjx9OEtEeNtXME4rTmFq1/
aI6zq1kJY0PKX0z9+Io34fM4abp5Mr+8yJy/XY6uJyn+mG2OZcsvw+LAnJgcnoDZ
P+CpX/L9EVlZesM6MbZ4N4YokLcnz0mATookzeOu2jsh5lAur64yEt9xPgN9GoDA
cwWJlqt2vD2SqQdrxwtknzCsRLb5utyRidCfgRmJ7zgdXlJyAA8o9cxxfzETPVV5
G6Dn4JI3q2szjhWCRjtPQzdrc+sqBaxA7JJ8t/zgj7YaUgqq05FMMu04X2+fzsPB
Nvn0Z8gQ+fBaQP8gxI41ALD5sMgMfdt8ylO2407g7SqQbO45VS9VShf4IBDA1idj
jCI+MTWswItld/f+F9dU6HgeVtt4XPC9ck+Nge3DIeVnLPXk9AJofKPnyOeUM/P9
BzH3r4g7ZkJr/ZkQq5AZRCH2RzsgXLCz//EVkq37vxWK5RFnb/gAfj2FYKsrbQl/
rtAvXFiH5dP/jOdlblBG
=5Yuz
-----END PGP SIGNATURE-----

--nextPart23477701.SVBATBIGA1--

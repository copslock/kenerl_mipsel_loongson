Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 May 2018 16:31:06 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.99]:39380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993997AbeEQOa77HU6g (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 17 May 2018 16:30:59 +0200
Received: from jamesdev (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D4D6A20652;
        Thu, 17 May 2018 14:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1526567452;
        bh=xpLrqBlANpm5lJwLgb1GU9cvAmjKF14GHcHEMP6GNQo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cpy4s+0gHwHoUkcBIGJCuu9lxVknuELfAeM7S9LDoFp0p+hzBciIumuMk5zovdo6r
         zeooSlvEeOZMShYU/JtFgfbzgglNkp6KTx3jjCw3IGcGOZkn9RL3XLCUnt2n2H81oB
         OQZJY5eWOwVSF90qSouUgjpj8pd1R3sYX6ROn0sc=
Date:   Thu, 17 May 2018 15:30:47 +0100
From:   James Hogan <jhogan@kernel.org>
To:     Matt Redfearn <matt.redfearn@mips.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 1/6] MIPS: Move ehb() to barrier.h
Message-ID: <20180517143046.GA24704@jamesdev>
References: <1515148270-9391-1-git-send-email-matt.redfearn@mips.com>
 <1515148270-9391-2-git-send-email-matt.redfearn@mips.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="fUYQa+Pmc3FrFX/N"
Content-Disposition: inline
In-Reply-To: <1515148270-9391-2-git-send-email-matt.redfearn@mips.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63985
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jhogan@kernel.org
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


--fUYQa+Pmc3FrFX/N
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On Fri, Jan 05, 2018 at 10:31:05AM +0000, Matt Redfearn wrote:
> The current location of ehb() in mipsmtregs.h does not make sense, since
> it is not strictly related to multi-threading, and may be used in code
> which does not include mipsmtregs.h

>  arch/mips/include/asm/barrier.h    | 13 +++++++++++++
>  arch/mips/include/asm/mipsmtregs.h |  8 --------

But ehb isn't really a memory barrier like the other barriers in
barrier.h, its an execution hazard barrier, as used when available by
the hazard macros in hazards.h, and in fact there is already an _ehb()
there.

I suspect the intention was that most MIPS arch code using ehb would do
so using the appropriate hazard abstractions, which would do the right
number of NOPs on hardware without the EHB instruction. Code that is
specific to certain arch revisions (like the MIPS MT code and MIPS KVM)
can get away with using _ehb/ehb, but should use the abstractions where
they exist to make intentions clear.

None of the specific hazards in hazards.h really match the case in patch
2, I suppose you could have a new sync_mfc0_hazard() macro, but its so
specific and EHB should be guaranteed to exist there, so perhaps _ehb()
should just be used instead of ehb() there? (with a comment to describe
what operations are being protected from what hazards).

Cheers
James

--fUYQa+Pmc3FrFX/N
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQS7lRNBWUYtqfDOVL41zuSGKxAj8gUCWv2SFQAKCRA1zuSGKxAj
8g1NAQDbRoahEifuu6/yUogKV60Ye0OY1HPN5uhoF/Sps8q+6AD8DQ8sqzB6icvF
yii4y7HzTo+e6WZ7o9i1Z1pm2g8YqgA=
=6e5S
-----END PGP SIGNATURE-----

--fUYQa+Pmc3FrFX/N--

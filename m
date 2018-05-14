Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 May 2018 23:42:22 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.99]:55462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992684AbeENVmPU1Qjv (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 14 May 2018 23:42:15 +0200
Received: from jamesdev (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 45B062172B;
        Mon, 14 May 2018 21:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1526334128;
        bh=TubcA6woMMMWWs/UYiov1wxUzfuzWNZF9p8iD5N8cl4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=09w3OMCaSsTSwkOaagAYX28ADtD1WlMudxvzER5W4jxfdpBjFdlkpYP4RA05Nnbxv
         AS4+meffI4EY+MxygqeqfS+pQdNUM0QJLXwzVxkm3DC156UAJBLeS1N6n2y5LysdAF
         NJqEjeqBtgSa/zLiZ8GLDcBnaTrXaLfmR1cs11N4=
Date:   Mon, 14 May 2018 22:42:02 +0100
From:   James Hogan <jhogan@kernel.org>
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     linux-i2c@vger.kernel.org, Greg Ungerer <gerg@uclinux.org>,
        Russell King <linux@armlinux.org.uk>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Tony Lindgren <tony@atomide.com>,
        Sergey Lapin <slapin@ossfans.org>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Ralf Baechle <ralf@linux-mips.org>,
        Haavard Skinnemoen <hskinnemoen@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-mips@linux-mips.org, linux-media@vger.kernel.org
Subject: Re: [PATCH 1/7] i2c: i2c-gpio: move header to platform_data
Message-ID: <20180514214201.GA29541@jamesdev>
References: <20180419200015.15095-1-wsa@the-dreams.de>
 <20180419200015.15095-2-wsa@the-dreams.de>
 <20180514213719.o6ceftp2quem3s7f@ninjato>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="liOOAslEiF7prFVr"
Content-Disposition: inline
In-Reply-To: <20180514213719.o6ceftp2quem3s7f@ninjato>
User-Agent: Mutt/1.9.5 (2018-04-13)
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63954
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


--liOOAslEiF7prFVr
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On Mon, May 14, 2018 at 11:37:20PM +0200, Wolfram Sang wrote:
> > diff --git a/arch/mips/alchemy/board-gpr.c b/arch/mips/alchemy/board-gpr.c
> > index 4e79dbd54a33..fa75d75b5ba9 100644
> > --- a/arch/mips/alchemy/board-gpr.c
> > +++ b/arch/mips/alchemy/board-gpr.c
> > @@ -29,7 +29,7 @@
> >  #include <linux/leds.h>
> >  #include <linux/gpio.h>
> >  #include <linux/i2c.h>
> > -#include <linux/i2c-gpio.h>
> > +#include <linux/platform_data/i2c-gpio.h>
> >  #include <linux/gpio/machine.h>
> >  #include <asm/bootinfo.h>
> >  #include <asm/idle.h>

Acked-by: James Hogan <jhogan@kernel.org>

Cheers
James

--liOOAslEiF7prFVr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQS7lRNBWUYtqfDOVL41zuSGKxAj8gUCWvoCqAAKCRA1zuSGKxAj
8nygAQCNvidVKuxZlkvSnxLStRpTqVCTrCRwmEaSQtc5VUpZxQD+MqHBbBboGCpp
2ebujn+XBLyfqCKc2jDW2UT4S6LpPgk=
=zJkS
-----END PGP SIGNATURE-----

--liOOAslEiF7prFVr--

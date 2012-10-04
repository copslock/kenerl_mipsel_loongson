Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Oct 2012 20:30:05 +0200 (CEST)
Received: from moutng.kundenserver.de ([212.227.126.187]:51920 "EHLO
        moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6817521Ab2JDS36S8k0g (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 4 Oct 2012 20:29:58 +0200
Received: from mailbox.adnet.avionic-design.de (mailbox.avionic-design.de [109.75.18.3])
        by mrelayeu.kundenserver.de (node=mreu1) with ESMTP (Nemesis)
        id 0M3OD6-1TbEVC3I2K-00qw5j; Thu, 04 Oct 2012 20:29:35 +0200
Received: from localhost (localhost [127.0.0.1])
        by mailbox.adnet.avionic-design.de (Postfix) with ESMTP id BF5F42A2833A;
        Thu,  4 Oct 2012 20:29:32 +0200 (CEST)
X-Virus-Scanned: amavisd-new at avionic-design.de
Received: from mailbox.adnet.avionic-design.de ([127.0.0.1])
        by localhost (mailbox.avionic-design.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id vEGq-SGvLoKt; Thu,  4 Oct 2012 20:29:32 +0200 (CEST)
Received: from localhost (avionic-0098.adnet.avionic-design.de [172.20.31.233])
        (Authenticated sender: thierry.reding)
        by mailbox.adnet.avionic-design.de (Postfix) with ESMTPA id ADC752A282EE;
        Thu,  4 Oct 2012 20:29:31 +0200 (CEST)
Date:   Thu, 4 Oct 2012 20:29:31 +0200
From:   Thierry Reding <thierry.reding@avionic-design.de>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     linux-kernel@vger.kernel.org,
        Russell King <linux@arm.linux.org.uk>,
        Shawn Guo <shawn.guo@linaro.org>,
        Eric Miao <eric.y.miao@gmail.com>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Bryan Wu <bryan.wu@canonical.com>,
        Richard Purdie <rpurdie@rpsys.net>,
        Samuel Ortiz <sameo@linux.intel.com>,
        Ashish Jangam <ashish.jangam@kpitcummins.com>,
        Andrew Jones <drjones@redhat.com>,
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        linux-input@vger.kernel.org, linux-leds@vger.kernel.org
Subject: Re: [PATCH] pwm: Get rid of HAVE_PWM
Message-ID: <20121004182931.GA7228@avionic-0098.mockup.avionic-design.de>
References: <1349330819-11924-1-git-send-email-thierry.reding@avionic-design.de>
 <506DA487.9070400@metafoo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="OXfL5xGRrasGEqWY"
Content-Disposition: inline
In-Reply-To: <506DA487.9070400@metafoo.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Provags-ID: V02:K0:hG1M9P3fohT8RoKb3XZkx3l8UfKm+75/T1W7y6LjLz2
 a/HjxHGhB7BqKY23rXd2fn3pkP9oUpRFTSX4XEcoAPi8r8JzYD
 N46BghJyeAzp+qmcH+7ic7usmBuQHbPlZaHHtmctyxQ7cgt8BI
 9J/ZjvoMZZLmwkX+ctqmvQangBVMA/b1Rp96YCND4TBkxH4Y5o
 Ds0RRHhaEnE0vRLI87HBRyl497ItcHizncO+Nj01dO5L1NYShX
 1/tBPs6WpaNSJkcI+QcWdkE9zhJIYkCJGV8d+E/oBgwPlq+oTe
 4nLVZwdMXDvMrnqGsyUceRfSEmKmK7QWS8q9PKy52EpovcymLT
 8nOSVG3veuZ3fp70+/lfukfdXhkeI2Cs3S+x9ybe3JLmfXteM9
 HmE33buuUxFUsabSVAgQJSrJVdj2WRIAtw=
X-archive-position: 34608
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: thierry.reding@avionic-design.de
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


--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 04, 2012 at 05:00:23PM +0200, Lars-Peter Clausen wrote:
> On 10/04/2012 08:06 AM, Thierry Reding wrote:
> > [...]
> > diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> > index 331d574..b38f23d 100644
> > --- a/arch/mips/Kconfig
> > +++ b/arch/mips/Kconfig
> > @@ -219,7 +219,8 @@ config MACH_JZ4740
> >  	select GENERIC_GPIO
> >  	select ARCH_REQUIRE_GPIOLIB
> >  	select SYS_HAS_EARLY_PRINTK
> > -	select HAVE_PWM
> > +	select PWM
> > +	select PWM_JZ4740
> >  	select HAVE_CLK
> >  	select GENERIC_IRQ_CHIP
>=20
> I'm not sure if this is such a good idea, not all jz4740 based board
> necessarily require PWM.

This really only restores previous behaviour. But I agree that this is
potentially not what we want. Maybe we should just not select this for
any boards but rather leave it up to some default configuration. If so
the patch can be made simpler by just removing the HAVE_PWM entries.

Thierry

--OXfL5xGRrasGEqWY
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQbdWKAAoJEN0jrNd/PrOhg7gQAJQ6YVy/tvgoCjJ4ESOIEmUF
cLyZDEsgwlHWcF2LilA9lync0s6ZcKAjg6RPOVRn8sCILBoxYqKQC2C7BGekETpC
1D+p6L0kq8YY8+bBSWPDc/me+J0S0OoSHNhjZ4WWeqs+vGVnefqjQUJEZsthvy55
tyQ2fmkXAFc/kCcpp+9PqJ71541uZqcaZcrFiYcDqdgAJA0MJ63OxbEQ4sgqjhJN
tHVpW0mlEJw/RBpCI/yzCgaWP8nhPPX4ThUkydMuEVj3YJ2tkmbEpDdcOkAYqm0r
iR551u4JM54ctWsztyWMbYa9dsntM8ZBVXjUeUgmw2C57J78wLIuPbkyiS2Q8wkO
W/CMv6s7TV2jh8XL2i+3DDibcY8oRatW0yEys50V/mLDdOl1GTi9AgvlLqBWTj1Y
mtRMoT2BVeVJtHzRWpEnbLizqIK4ItUc1/kAgIHlo/DWVJfctSz+EEr/BRVUFtJG
hb10QW6DcagvjEyUWMpKejrCfjv9TG2yuLxJxl8WcR4iFAUnkcrSHWFhQVzDgBoG
05wskTjr5rSKzUsEpUfFmrkbOW0Ks6FF9OmOcIEak3sOZM3RMRCJw9idfTClN+/k
mlaRk1VJeeFMaYFPnT+P4rmIMFK0gDx9YVM3OeDD1SBXbZ7QPU3jGooqWjDjqfbM
bhpeJuS1HCPiOe+ul0yN
=fqL5
-----END PGP SIGNATURE-----

--OXfL5xGRrasGEqWY--

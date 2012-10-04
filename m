Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Oct 2012 21:13:54 +0200 (CEST)
Received: from moutng.kundenserver.de ([212.227.17.8]:50924 "EHLO
        moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6817419Ab2JDTNnJxXQJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 4 Oct 2012 21:13:43 +0200
Received: from mailbox.adnet.avionic-design.de (mailbox.avionic-design.de [109.75.18.3])
        by mrelayeu.kundenserver.de (node=mrbap4) with ESMTP (Nemesis)
        id 0Lwqt6-1TUeWU3LmS-016veR; Thu, 04 Oct 2012 21:13:11 +0200
Received: from localhost (localhost [127.0.0.1])
        by mailbox.adnet.avionic-design.de (Postfix) with ESMTP id 0E8322A2833B;
        Thu,  4 Oct 2012 21:13:10 +0200 (CEST)
X-Virus-Scanned: amavisd-new at avionic-design.de
Received: from mailbox.adnet.avionic-design.de ([127.0.0.1])
        by localhost (mailbox.avionic-design.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id U17NQfHq6yx4; Thu,  4 Oct 2012 21:13:09 +0200 (CEST)
Received: from localhost (avionic-0098.adnet.avionic-design.de [172.20.31.233])
        (Authenticated sender: thierry.reding)
        by mailbox.adnet.avionic-design.de (Postfix) with ESMTPA id F2BCF2A282EE;
        Thu,  4 Oct 2012 21:13:08 +0200 (CEST)
Date:   Thu, 4 Oct 2012 21:13:08 +0200
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
Message-ID: <20121004191308.GB7228@avionic-0098.mockup.avionic-design.de>
References: <1349330819-11924-1-git-send-email-thierry.reding@avionic-design.de>
 <506DA487.9070400@metafoo.de>
 <20121004182931.GA7228@avionic-0098.mockup.avionic-design.de>
 <506DDA16.8070604@metafoo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="E39vaYmALEf/7YXx"
Content-Disposition: inline
In-Reply-To: <506DDA16.8070604@metafoo.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Provags-ID: V02:K0:KcvJ/pl4WAKqG7Omxpx/Qsgwotn3WH6SE6Hn0PXAhlB
 eNS85dpAcZyiUYMyc/G/T/YNUWDPaaou2hLn2xb1g4n69Xo/s6
 uR8w1epXuNGOVzJNxwjD0auX/oE23qTgHtuHsi6hyb5KEbmdMD
 OnBfUY7lCCElZUdnLzWrJIepW1+PLwa8Taj7WziYl46T9NNn5r
 EJo5ROZMY4y4YY5/xH7TSwGjtJcnsIpU31KdHL7coDnd4486T8
 KVFRMantEM+VgvZ4ctOXrmPv8RUnAd2ZO+7H5vZ5UzTBjGTdQJ
 vIkVkAb7jr0oB++EpWEM00ZHyWv0YPFr07wP5g3IGaPU8Pz9oQ
 j9zTVwN26QhhYIISd1uyUcTRH4eiuuM1fdTu/DmDH87IMidZ+0
 v+iJs3BZtmuEv6DssDF8HDdOpYU+ni8yHKLLU+BCkrZfb2jDcG
 r2GAQ
X-archive-position: 34610
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


--E39vaYmALEf/7YXx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 04, 2012 at 08:48:54PM +0200, Lars-Peter Clausen wrote:
> On 10/04/2012 08:29 PM, Thierry Reding wrote:
> > On Thu, Oct 04, 2012 at 05:00:23PM +0200, Lars-Peter Clausen wrote:
> >> On 10/04/2012 08:06 AM, Thierry Reding wrote:
> >>> [...]
> >>> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> >>> index 331d574..b38f23d 100644
> >>> --- a/arch/mips/Kconfig
> >>> +++ b/arch/mips/Kconfig
> >>> @@ -219,7 +219,8 @@ config MACH_JZ4740
> >>>  	select GENERIC_GPIO
> >>>  	select ARCH_REQUIRE_GPIOLIB
> >>>  	select SYS_HAS_EARLY_PRINTK
> >>> -	select HAVE_PWM
> >>> +	select PWM
> >>> +	select PWM_JZ4740
> >>>  	select HAVE_CLK
> >>>  	select GENERIC_IRQ_CHIP
> >>
> >> I'm not sure if this is such a good idea, not all jz4740 based board
> >> necessarily require PWM.
> >=20
> > This really only restores previous behaviour. But I agree that this is
> > potentially not what we want. Maybe we should just not select this for
> > any boards but rather leave it up to some default configuration. If so
> > the patch can be made simpler by just removing the HAVE_PWM entries.
>=20
> At least for JZ4740 I think that is the better solution.

Okay, I'll give other people the chance to comment on this. Especially
for PXA there are many boards that use the PWM for backlight and it
would be interesting to hear from them how they want this to be handled.

Thierry

--E39vaYmALEf/7YXx
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQbd/EAAoJEN0jrNd/PrOhjmoP/AhDZQl6ibL4kdb0hHm6OK4l
DGTOK2GYWqHoewsuP8nR71/kdeTS/jZkUMAfUjVZG9Rpkew1HvK3ZxG9i0YGDrCV
RMQOI08335OMtJB+IcuwEpwMmSMQTqAR1gP6Bjwsp91twbxDwV/KJRvW3zcrH5oS
E8ih1cwkd66x7aZvuj0smo/Tw5whvZMgvOd+8VFZdAKdjCTSjTANzAX2rvDZX08q
y+Xiq79ftrjbCmhUllq+HfI0nOBGnLuznY8Vrim41lGXfPxmWs78/ZSFbSalpPi7
a75X+iUVpZlc2gDvMHh96S2DkhVZRQJ5YZaIfKGNTtDnA5phNQsxRZwaLi/GmdyE
l22z6q3bVqlTzZn4NE25nVq3KCtuzcddo1I73rRUdjNMs3g/cOO1krV/5MFDTi9O
jktWWQaqDhgnDnQxl8A5sogvwXQHKGJLt1FrOtbHa/iy7tWeSJmN7YV5b6nkkKOI
doOxWyCstEkdAm/2Z0UlQ8uUkATtiPmIdk21/3N1uRnJKsi1E3TsaE1BSXK/+I86
TKmd8rDpOez5PrL6G16pZ2XeUxY8SokUPGgKBuQltmDkItadPMjmOk3kuXNXPxDH
auujSMmyzfxBADEVRioTlpcLc+dQMYSEZSJUHnqYCMWzgqZmAJsTOSXCIdXJabuY
suVqA2unwAnQLxgZYu0S
=dX0O
-----END PGP SIGNATURE-----

--E39vaYmALEf/7YXx--

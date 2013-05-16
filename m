Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 16 May 2013 15:19:57 +0200 (CEST)
Received: from devils.ext.ti.com ([198.47.26.153]:48774 "EHLO
        devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6823124Ab3EPNTwcUmLo (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 16 May 2013 15:19:52 +0200
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id r4GDI8tA006393;
        Thu, 16 May 2013 08:18:08 -0500
Received: from DFLE72.ent.ti.com (dfle72.ent.ti.com [128.247.5.109])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id r4GDI8I0002192;
        Thu, 16 May 2013 08:18:08 -0500
Received: from dlelxv22.itg.ti.com (172.17.1.197) by DFLE72.ent.ti.com
 (128.247.5.109) with Microsoft SMTP Server id 14.2.342.3; Thu, 16 May 2013
 08:18:08 -0500
Received: from [172.24.64.3] (h64-3.vpn.ti.com [172.24.64.3])   by
 dlelxv22.itg.ti.com (8.13.8/8.13.8) with ESMTP id r4GDHtmw007723;      Thu, 16 May
 2013 08:17:55 -0500
Message-ID: <5194DC82.8050408@ti.com>
Date:   Thu, 16 May 2013 16:17:54 +0300
From:   Tomi Valkeinen <tomi.valkeinen@ti.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130510 Thunderbird/17.0.6
MIME-Version: 1.0
To:     <dedekind1@gmail.com>
CC:     Viresh Kumar <viresh.kumar@linaro.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        <linux-kernel@vger.kernel.org>, <linux-mips@linux-mips.org>,
        <alsa-devel@alsa-project.org>, <linux-usb@vger.kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Matt Mackall <mpm@selenic.com>, <linux-fbdev@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>,
        Jaroslav Kysela <perex@perex.cz>, <linux-ide@vger.kernel.org>,
        Wim Van Sebroeck <wim@iguana.be>, <netdev@vger.kernel.org>,
        <linux-mtd@lists.infradead.org>, <linux-i2c@vger.kernel.org>,
        Evgeniy Polyakov <zbr@ioremap.net>,
        Wan ZongShun <mcuos.com@gmail.com>,
        <ac100@lists.launchpad.net>, <devel@driverdev.osuosl.org>,
        Kukjin Kim <kgene.kim@samsung.com>,
        Russell King <linux@arm.linux.org.uk>,
        Herbert Xu <herbert@gondor.hengli.com.au>,
        Florian Tobias Schandinat <FlorianSchandinat@gmx.de>,
        Marc Dietrich <marvin24@gmx.de>,
        Stephen Warren <swarren@wwwdotorg.org>,
        "Rafael J. Wysocki" <rjw@sisk.pl>, <cpufreq@vger.kernel.org>,
        Eduardo Valentin <eduardo.valentin@ti.com>,
        David Airlie <airlied@linux.ie>,
        Alan Stern <stern@rowland.harvard.edu>,
        Grant Likely <grant.likely@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Thierry Reding <thierry.reding@avionic-design.de>,
        Deepak Saxena <dsaxena@plexity.net>,
        <linux-watchdog@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        <linux-pm@vger.kernel.org>,
        Julian Andres Klode <jak@jak-linux.org>,
        Inki Dae <inki.dae@samsung.com>,
        <linux-samsung-soc@vger.kernel.org>,
        Ben Dooks <ben-linux@fluff.org>,
        Barry Song <baohua.song@csr.com>,
        <linux-tegra@vger.kernel.org>, <rtc-linux@googlegroups.com>,
        <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Joonyoung Shim <jy0922.shim@samsung.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        <spi-devel-general@lists.sourceforge.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Felipe Balbi <balbi@ti.com>,
        Tony Prisk <linux@prisktech.co.nz>,
        Vinod Koul <vinod.koul@intel.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.de>,
        Dan Williams <djbw@fb.com>, Tejun Heo <tj@kernel.org>,
        Samuel Ortiz <sameo@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Paul Zimmerman <paulz@synopsys.com>
Subject: Re: [PATCH 00/33] devm improvement series, part 1, take 2
References: <1368702961-4325-1-git-send-email-wsa@the-dreams.de>  <1368705452.15764.217.camel@sauron.fi.intel.com>  <CAKohpokUy7QfvKkzGH025Zs5VkUhr8zRLeo3caG3LAnLfptzww@mail.gmail.com> <1368709862.15764.224.camel@sauron.fi.intel.com>
In-Reply-To: <1368709862.15764.224.camel@sauron.fi.intel.com>
X-Enigmail-Version: 1.5.1
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature";
        boundary="----enig2EHULBAGEHLETABJNANUE"
Return-Path: <tomi.valkeinen@ti.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36422
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tomi.valkeinen@ti.com
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

------enig2EHULBAGEHLETABJNANUE
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 16/05/13 16:11, Artem Bityutskiy wrote:
> On Thu, 2013-05-16 at 18:25 +0530, Viresh Kumar wrote:
>> On 16 May 2013 17:27, Artem Bityutskiy <dedekind1@gmail.com> wrote:
>>> On Thu, 2013-05-16 at 13:15 +0200, Wolfram Sang wrote:
>>>> Despite various architectures and platform dependencies, I managed t=
o
>>>> compile
>>>> test 45 out of 57 modified files locally using heuristics and
>>>> defconfigs.
>>>> If somebody knows how to create a minimal .config with a certain
>>>> kconfig symbol
>>>> (and its dependencies) set, I'd love to hear about it.
>>>
>>> If you find this out, please, share!
>>
>> Are you guys looking for "make savedefconfig" ??
>=20
> No. It is more like:
>=20
> I have changed this strange driver.
>=20
> I want to compile-test my changes.
>=20
> I need a defconfig which would have this driver enabled. I also want to=

> know <arch> for my "make ARCH=3D<arch>" command.

Not quite the same thing, but I sent this a while ago:

http://lkml.indiana.edu/hypermail/linux/kernel/1304.3/02847.html

My "softdepends" feature is probably not needed, as pointed out in the
thread, as the behavior can be implemented with the current Kconfig
language just fine.

I had a quick look at fbdev drivers, and some of them compile fine on
all (well, arm and x86) archs. But many do have real arch dependencies.

I think it'd be a good long term goal to make drivers arch-independent,
and add CONFIG_SHOW_ALL_DRIVERS or such, which would allow compiling
drivers that are not used on your arch, but still compile fine.

 Tomi



------enig2EHULBAGEHLETABJNANUE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJRlNyCAAoJEPo9qoy8lh71l58P/j0OTooy3PHnvOCCS7eRw6IP
95MLCoZruiAk75I2dLxS1wQ2HAHGeLVJlk5gTYtbgMyhzqfZJSpMpEOHNwumYwi3
s7cC2GQsH4d8Epuh9R2C1Jje+8+dMutMzQhkm/L4RZfsmUaBH6GhVBQqtI66eSYR
bV4YTnGUG1ppR+l+ZqFmTT5TmFVprcKfqNg96P1BmutTSCGyEM3oHTSTOLEbdutq
Ms1Ex0zXypQ2p14pCe91eDqnEDjVAclOUTzaVop4ADJ28mh4MnodSeNhb7Yz2nRT
zGMUMu4D1WdUvLEzIawATE4pNh0xyvz0Sn2HVfkWfpWUlkA/3fINpBTIzEVEDL7G
3q4pChhqHX3CTqUyCzVKF/zQ3VUJ9VGAgoTpfZJ8JAeqsPvy1LVgB6j8CtEc0pW2
07K450ptCkRHuE+ziRRBzCK/XJQJySBGpIjWDNsTka2G/QydHZx21rGmURh7Cz7x
+5tDMZzylVPrVipjdlX2aAm4iUXlPlppX1rwRNVpsQ6Uf/dGGQcyOK1bCLuUWiAY
nz0Mzu95h71lYJ/lsr986v1om/GhMh8c9xLx77xQQgklWE6cqpzw7ifnhlqELEDz
CijOLMhn9k3eEtiZqj6J8tz0yXI0HSUjm2GMft479ezmG6kJnyANTY/Jl9hH052s
8XWRsSCRfCgeFVNVLYoN
=mQ7r
-----END PGP SIGNATURE-----

------enig2EHULBAGEHLETABJNANUE--

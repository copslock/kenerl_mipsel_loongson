Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 May 2013 22:36:35 +0200 (CEST)
Received: from moutng.kundenserver.de ([212.227.17.10]:63788 "EHLO
        moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6824795Ab3EWUe6OyNuJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 23 May 2013 22:34:58 +0200
Received: from mailbox.adnet.avionic-design.de (mailbox.avionic-design.de [109.75.18.3])
        by mrelayeu.kundenserver.de (node=mrbap2) with ESMTP (Nemesis)
        id 0MBIsH-1UnYGg3GOj-00A1Pi; Thu, 23 May 2013 22:32:49 +0200
Received: from localhost (localhost [127.0.0.1])
        by mailbox.adnet.avionic-design.de (Postfix) with ESMTP id 7BC7B2A28209;
        Thu, 23 May 2013 22:32:46 +0200 (CEST)
X-Virus-Scanned: amavisd-new at avionic-design.de
Received: from mailbox.adnet.avionic-design.de ([127.0.0.1])
        by localhost (mailbox.avionic-design.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id QBPLSRTmRFWT; Thu, 23 May 2013 22:32:45 +0200 (CEST)
Received: from mailman.adnet.avionic-design.de (mailman.adnet.avionic-design.de [172.20.31.172])
        by mailbox.adnet.avionic-design.de (Postfix) with ESMTP id C52EE2A281DB;
        Thu, 23 May 2013 22:32:43 +0200 (CEST)
Received: from localhost (avionic-0098.adnet.avionic-design.de [172.20.31.233])
        by mailman.adnet.avionic-design.de (Postfix) with ESMTP id A48B91000E6;
        Thu, 23 May 2013 22:32:40 +0200 (CEST)
Date:   Thu, 23 May 2013 22:32:43 +0200
From:   Thierry Reding <thierry.reding@avionic-design.de>
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     linux-kernel@vger.kernel.org, ac100@lists.launchpad.net,
        Alan Stern <stern@rowland.harvard.edu>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        alsa-devel@alsa-project.org, Arnd Bergmann <arnd@arndb.de>,
        Barry Song <baohua.song@csr.com>,
        Ben Dooks <ben-linux@fluff.org>, cpufreq@vger.kernel.org,
        Dan Williams <djbw@fb.com>, David Airlie <airlied@linux.ie>,
        David Woodhouse <dwmw2@infradead.org>,
        Deepak Saxena <dsaxena@plexity.net>,
        devel@driverdev.osuosl.org, dri-devel@lists.freedesktop.org,
        Eduardo Valentin <eduardo.valentin@ti.com>,
        Evgeniy Polyakov <zbr@ioremap.net>,
        Felipe Balbi <balbi@ti.com>,
        Florian Tobias Schandinat <FlorianSchandinat@gmx.de>,
        Grant Likely <grant.likely@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Inki Dae <inki.dae@samsung.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Joonyoung Shim <jy0922.shim@samsung.com>,
        Julian Andres Klode <jak@jak-linux.org>,
        Kukjin Kim <kgene.kim@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-fbdev@vger.kernel.org,
        linux-i2c@vger.kernel.org, linux-ide@vger.kernel.org,
        linux-mips@linux-mips.org, linux-mtd@lists.infradead.org,
        linux-omap@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-watchdog@vger.kernel.org,
        Marc Dietrich <marvin24@gmx.de>,
        Mark Brown <broonie@kernel.org>,
        Matt Mackall <mpm@selenic.com>, netdev@vger.kernel.org,
        Paul Zimmerman <paulz@synopsys.com>,
        "Rafael J. Wysocki" <rjw@sisk.pl>,
        Ralf Baechle <ralf@linux-mips.org>, rtc-linux@googlegroups.com,
        Russell King <linux@arm.linux.org.uk>,
        Samuel Ortiz <sameo@linux.intel.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        spi-devel-general@lists.sourceforge.net,
        Stephen Warren <swarren@wwwdotorg.org>,
        Takashi Iwai <tiwai@suse.de>, Tejun Heo <tj@kernel.org>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Tony Prisk <linux@prisktech.co.nz>,
        Vinod Koul <vinod.koul@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Wan ZongShun <mcuos.com@gmail.com>,
        Wim Van Sebroeck <wim@iguana.be>,
        Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH 00/33] devm improvement series, part 1, take 2
Message-ID: <20130523203243.GA18069@avionic-0098.adnet.avionic-design.de>
References: <1368702961-4325-1-git-send-email-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="cWoXeonUoKmBZSoM"
Content-Disposition: inline
In-Reply-To: <1368702961-4325-1-git-send-email-wsa@the-dreams.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Provags-ID: V02:K0:g6QKos/qRDaujPH58X4yK9jLOGUSH+lS1kjy6Q3/Y2I
 Is1DZc/cG4N5oPrg7Gs1DXfbKhD88haaeX6Gl9ouxGUqKwFmx9
 AUl4qSEEnX8eHjYs9T8H764kDd734GC944RLBOuxms9o0Pkgkj
 jT+DvoveSCD6n7KCOXjpcDUVEUuwZ4BV7RDLABcLJ+AQLiv62d
 Qw75atyA1B+UIAT8uN+Gse9RGkcOM1WcwkaCxQPM13LZcxQUZu
 +zZ3U9veERtGjbMJDU9G2IBk/vcW4ownpCH3vLqdCwDJ28tRgg
 4vA/DY4jVy9MiIaxBBO/6JwX43TnRY7RjgABo6M2hAFwdJlAOE
 1f9OEokXUZ3iS5eS+DX1HNvoSu2Ipm9PVF57e5j4lr6rQq9qUD
 MHsBLHXluFKhHxs4rTB5LSSz60B4grQqW4wUpY56z31kH03byv
 KImP8
Return-Path: <thierry.reding@avionic-design.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36576
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


--cWoXeonUoKmBZSoM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 16, 2013 at 01:15:28PM +0200, Wolfram Sang wrote:
> Lately, I have been experimenting how to improve the devm interface to ma=
ke
> writing device drivers easier and less error prone while also getting rid=
 of
> its subtle issues. I think it has more potential but still needs work and
> definately conistency, especiall in its usage.
>=20
> The first thing I come up with is a low hanging fruit regarding
> devm_ioremap_resouce(). This function already checks if the passed resour=
ce is
> valid and gives an error message if not. So, we can remove similar checks=
 from
> the drivers and get rid of a bit of code and a number of inconsistent err=
or
> strings.

Sorry for jumping in so late. I generally like the idea. One small
inconvenience is that devm_ioremap_resource() returns -EINVAL if
res =3D=3D NULL, which means that drivers will now also return -EINVAL
in cases where no resource was returned. Typically drivers handle
this by returning something like -ENODEV, -ENXIO, -ENOENT. Some do
return -EINVAL but perhaps having a separate error code (and maybe
error message as well) for a missing resource would be helpful.

Doing this would be rather easy now that you've paved the way by
making devm_ioremap_resource() usage consistent across drivers.

Thierry

--cWoXeonUoKmBZSoM
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRnnzqAAoJEN0jrNd/PrOh7SQP/0805wibt2DFxkTSFnZBxDGZ
hU1p6eTzQ5Nh3uDq449RqWs8GsB+f2osxomSH71KMqGJmlKi0jc0gtcINotD6FH+
F8ABG95AKXi5TmG9hEcdIv6eAzfI0AUAgx1izHLxQWLHIcVoca5GpptWPrkOlW6U
NujE+Lz3rYYtbNMoK8jexasO9uQzo/V6fB3IMVdnEx80CE5o6TbTYBQz5fInVcs8
QlA0w37qFEcmOq1BsEJNdlcm0JUJ+3sXoFUdnN9jPGcrTgiOg8jXx6GpKLMRJyA3
cToFc9kVXqgOOtYPw08CUkrzkqF/E0i11IaBOtlvXG489AbvlUOeF95JQEZvLgu9
ScBNy/PqNN9Z3jZhoiqsTd//QGBb5kNUKEs5v30o4zHpy+3buWpOSiUgJLvX18la
o8Krom/w4KEH01JRqLSCJLHwZXvyOj6DWW/ogPPMpirX+TTdyDLt4XbGP5GU6iVh
um0drkT9bUruG2pQVDeNkVwpTMedd5xa96kTXLu0D3MB7Lvfp43mVDVAuYG/FjhU
m4NkG0SY8N07Upidbb2LZSvAEydzHVJcF7kobEMRnQwH99VYyRUmviKHhoP469T0
VyKKbTxfTlSWkLQqvgS3eVraylffA8O6eV4RHpAYZyZlsoa+5JulahO69B0yebx2
atBr1eUuDOTwTR9IUz59
=pYVl
-----END PGP SIGNATURE-----

--cWoXeonUoKmBZSoM--

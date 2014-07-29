Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 29 Jul 2014 13:31:52 +0200 (CEST)
Received: from devils.ext.ti.com ([198.47.26.153]:36469 "EHLO
        devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6816288AbaG2LbnzkoyC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 29 Jul 2014 13:31:43 +0200
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id s6TBVEeG016306;
        Tue, 29 Jul 2014 06:31:14 -0500
Received: from DLEE71.ent.ti.com (dlee71.ent.ti.com [157.170.170.114])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id s6TBVDKs024513;
        Tue, 29 Jul 2014 06:31:13 -0500
Received: from dlep33.itg.ti.com (157.170.170.75) by DLEE71.ent.ti.com
 (157.170.170.114) with Microsoft SMTP Server id 14.3.174.1; Tue, 29 Jul 2014
 06:31:13 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153]) by
 dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id s6TBV2wV017182;        Tue, 29 Jul
 2014 06:31:04 -0500
Message-ID: <53D785F0.1000309@ti.com>
Date:   Tue, 29 Jul 2014 14:30:56 +0300
From:   Tomi Valkeinen <tomi.valkeinen@ti.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.0
MIME-Version: 1.0
To:     Linus Walleij <linus.walleij@linaro.org>,
        abdoulaye berthe <berthe.ab@gmail.com>,
        "arm@kernel.org" <arm@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Jiri Kosina <jkosina@suse.cz>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Bryan Wu <cooloney@gmail.com>,
        Mauro Carvalho Chehab <m.chehab@samsung.com>,
        Lee Jones <lee.jones@linaro.org>,
        Samuel Ortiz <sameo@linux.intel.com>,
        Matthew Garrett <matthew.garrett@nebula.com>,
        Michael Buesch <m@bues.ch>,
        Greg KH <gregkh@linuxfoundation.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
CC:     Alexandre Courbot <gnurou@gmail.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        <linux-mips@linux-mips.org>,
        "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
        Linux Input <linux-input@vger.kernel.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Subject: Re: [PATCH 3/3] driver:gpio remove all usage of gpio_remove retval
 in driver
References: <CACRpkda6mzVdaN0cvOxpbsxWyCv2nGyDXOjZg_5aT8u7SSQeUw@mail.gmail.com>        <1405197014-25225-1-git-send-email-berthe.ab@gmail.com> <1405197014-25225-4-git-send-email-berthe.ab@gmail.com> <CACRpkdasp9bLULT7NJM9nYX58rRSsQKXFddOLz9Ah6kp-j-3=Q@mail.gmail.com>
In-Reply-To: <CACRpkdasp9bLULT7NJM9nYX58rRSsQKXFddOLz9Ah6kp-j-3=Q@mail.gmail.com>
X-Enigmail-Version: 1.6
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature";
        boundary="nDvig6w1IaO5idwNJGff6KXjnBUdsJGt1"
Return-Path: <tomi.valkeinen@ti.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41787
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

--nDvig6w1IaO5idwNJGff6KXjnBUdsJGt1
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 22/07/14 18:08, Linus Walleij wrote:
> On Sat, Jul 12, 2014 at 10:30 PM, abdoulaye berthe <berthe.ab@gmail.com=
> wrote:
>=20
> Heads up. Requesting ACKs for this patch or I'm atleast warning that it=
 will be
> applied. We're getting rid of the return value from gpiochip_remove().

>>  drivers/video/fbdev/via/via-gpio.c             | 10 +++-------
>=20
> Tomi can you ACK this?

Acked-by: Tomi Valkeinen <tomi.valkeinen@ti.com>

 Tomi



--nDvig6w1IaO5idwNJGff6KXjnBUdsJGt1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJT14X1AAoJEPo9qoy8lh71gvsP/iJDf8dcnv2JZFloH/noIb3s
DCXfxyTW2zDeWEEH7rLW+fP5JKu5TutqOCF2Y85HaPa/DV1iMI4S+IUeEwNiw0wd
JTwMqUbS2ua22J87F1Oc5kXshDk+uqLRfpxO7xs0Pd/JcsrOgA7zqJN67jeDwQo/
XsiRTBmJ3CNR/qur7AKN8toHdZp+KaHZ/4cazUxxp/cu71eFuRfFJMjE/cGk8cva
fsIrugCAFjYIy3z88VtW4VPj1rcNDYUlxcklbpNtosOKUuPfNoDwToLUCdjE22G9
v93XHZKlv0iWso5fo9HA2BTDK7N37WMsyktqF1ULEUiKIyoWs6a0WG9eREVLKlpi
ugiCLH6c4jQYycmSTmFGZnzuhz5hN5oirXpKtba6hVHh6ZNkIkGtFElGTZYjVhKn
k06HXBVTTYwf4pg2PGSGPsl2dIx0Zyl8pG+iFn10LSxELxbNU6N/wYzf6LquPLok
cnnfX2riaFV6DgQHhHlTqr0tN6NFb8smYeH9rq37+4GyVYnokXuBMJ+qQ5In8BDZ
9ZgW2N1PH2aRO2RZERVwll4otqtZgJcmWdAgeZzjkl0nBpWH8X78c41O3T3LUscq
3cDDyXHCLDGabHGuab5JPofNnN1GW8xM/wN8jLmH/abZICdjfGqRVzaQh7FJjc97
PbSJaJG3ZaHHHc6LWcil
=W85Y
-----END PGP SIGNATURE-----

--nDvig6w1IaO5idwNJGff6KXjnBUdsJGt1--

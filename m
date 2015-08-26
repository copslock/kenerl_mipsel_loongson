Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 Aug 2015 20:05:02 +0200 (CEST)
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:38401 "EHLO
        mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007131AbbHZSFAUfBqL (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 26 Aug 2015 20:05:00 +0200
Received: from cpc11-sgyl31-2-0-cust672.sgyl.cable.virginm.net ([94.175.94.161] helo=debutante)
        by mezzanine.sirena.org.uk with esmtpsa (TLS1.2:RSA_AES_128_CBC_SHA1:128)
        (Exim 4.80)
        (envelope-from <broonie@sirena.org.uk>)
        id 1ZUf3v-0006P7-OD; Wed, 26 Aug 2015 18:04:40 +0000
Received: from broonie by debutante with local (Exim 4.86)
        (envelope-from <broonie@sirena.org.uk>)
        id 1ZUf3s-0004Yi-MY; Wed, 26 Aug 2015 19:04:36 +0100
Date:   Wed, 26 Aug 2015 19:04:36 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Qais Yousef <qais.yousef@imgtec.com>
Cc:     alsa-devel@alsa-project.org, Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Message-ID: <20150826180436.GC28760@sirena.org.uk>
References: <1440419959-14315-1-git-send-email-qais.yousef@imgtec.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="LwW0XdcUbUexiWVK"
Content-Disposition: inline
In-Reply-To: <1440419959-14315-1-git-send-email-qais.yousef@imgtec.com>
X-Cookie: Victory uber allies!
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: 94.175.94.161
X-SA-Exim-Mail-From: broonie@sirena.org.uk
Subject: Re: [PATCH 00/10] Add support for img AXD audio hardware decoder
X-SA-Exim-Version: 4.2.1 (built Mon, 26 Dec 2011 16:24:06 +0000)
X-SA-Exim-Scanned: Yes (on mezzanine.sirena.org.uk)
Return-Path: <broonie@sirena.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49028
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: broonie@kernel.org
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


--LwW0XdcUbUexiWVK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 24, 2015 at 01:39:09PM +0100, Qais Yousef wrote:

> Qais Yousef (10):
>   irqchip: irq-mips-gic: export gic_send_ipi
>   dt: add img,axd.txt device tree binding document
>   ALSA: add AXD Audio Processing IP alsa driver
>   ALSA: axd: add fw binary header manipulation files
>   ALSA: axd: add buffers manipulation files
>   ALSA: axd: add basic files for sending/receiving axd cmds
>   ALSA: axd: add cmd interface helper functions
>   ALSA: axd: add low level AXD platform setup files
>   ALSA: axd: add alsa compress offload operations
>   ALSA: axd: add Makefile

Please try to use subject lines matching the style for the subsystem, I
very nearly deleted this unread because it looks like an ALSA patch
series, not an ASoC one.

--LwW0XdcUbUexiWVK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJV3f+zAAoJECTWi3JdVIfQDD0H/Rv5PJHlXTHPut//XcmWFdjW
ZEbb8EbNzBiGp9uhsOSs5ERfBEVi1CjDDaizb0rfaOyI/y1X+0alRsl4oaOV/Xi1
aJ50s3o23cUg21eaB6i1tUtX2vm07vEVbwgEAiOa7nXiKL3nhTg0//DgC4//zedE
gB7X1qKLBw7aah0PRMBDkVIQP2hEDwockP5Jp6MS9TTBFWA/EuADWfxtbOmKepbz
vC9LQIksBz3Pdy3PNuQy5aSH9irdGllVP7Fca2aEfk4LJ0a2q/wUoJUTrnsh3MJy
6pvbTMHNf85EqD1guc3CuI/jb1wPfsJwkeFzmujW9iHRxT9Bv7AkaDT7+InBrNc=
=9Ye+
-----END PGP SIGNATURE-----

--LwW0XdcUbUexiWVK--

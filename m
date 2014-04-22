Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Apr 2014 22:54:36 +0200 (CEST)
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:47433 "EHLO
        mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6834667AbaDVUyanNDLR (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 22 Apr 2014 22:54:30 +0200
Received: from cpc11-sgyl31-2-0-cust672.sgyl.cable.virginm.net ([94.175.94.161] helo=debutante.sirena.org.uk)
        by mezzanine.sirena.org.uk with esmtpsa (TLS1.2:RSA_AES_128_CBC_SHA1:128)
        (Exim 4.80)
        (envelope-from <broonie@sirena.org.uk>)
        id 1Wchhl-0005ob-D6; Tue, 22 Apr 2014 20:54:21 +0000
Received: from broonie by debutante.sirena.org.uk with local (Exim 4.82)
        (envelope-from <broonie@sirena.org.uk>)
        id 1Wchhi-0002dn-FU; Tue, 22 Apr 2014 21:54:10 +0100
Date:   Tue, 22 Apr 2014 21:54:10 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        alsa-devel@alsa-project.org
Message-ID: <20140422205410.GI12304@sirena.org.uk>
References: <1398199596-23649-1-git-send-email-lars@metafoo.de>
 <1398199596-23649-4-git-send-email-lars@metafoo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="3/KfPELnh2c6u5MZ"
Content-Disposition: inline
In-Reply-To: <1398199596-23649-4-git-send-email-lars@metafoo.de>
X-Cookie: You will be successful in your work.
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: 94.175.94.161
X-SA-Exim-Mail-From: broonie@sirena.org.uk
Subject: Re: [PATCH 4/6] ASoC: qi_lb60: Use devm_snd_soc_register_card()
X-SA-Exim-Version: 4.2.1 (built Mon, 26 Dec 2011 16:24:06 +0000)
X-SA-Exim-Scanned: Yes (on mezzanine.sirena.org.uk)
Return-Path: <broonie@sirena.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39897
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


--3/KfPELnh2c6u5MZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 22, 2014 at 10:46:34PM +0200, Lars-Peter Clausen wrote:
> Makes the code a bit shorter and will also allow us to remove the drivers
> remove() callback eventually.

Applied all the patches up to here, thanks.  Will wait for Ralf's review
for the other two, they look good to me.

--3/KfPELnh2c6u5MZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTVtbvAAoJELSic+t+oim9g4IP/imAIIYp74x9bvnORKsvTwzf
f1yfb4RAaOndTqG2IUodMXusgv1kLCHLyKFQJmYRoSJIShQ/Wm/JWyuDB1U82OFq
DR/JIGkDPEb3rRJmkvOnrHSvKTisoiJnMcBAAGX7cdtsdaY6fvo0e0qFK9f+LQDF
2danQSLoA/1Egw9rllI2fWbs8rslLDejG0jxkPlruzy+LqsCfn8JrvchrHbq33mq
CM2yhTl6KKjVhoN5e1GFnn97BK0bEaA+0Jv+GZ7fB8JfAGQK6XbhY/BBfXE9m59d
u+aXA6XDMY9SwtGB5Hb0Ztz58pA9uhypEY9IknoJVWaKoDr/MmyHjTB/sNWMEUyg
cQLw7TB9MEnbyCQC5jIp4rmgH3MAkbvBNyxI4bsbdGx/IPTYC24+QhZbWvP01Jd+
EceGkEu4AEnZUGjwRYPRSzX21BUE6GQfsAfigS2gI+lVWTp7vFuodwZCELJQvjUj
wrv+qCLaa7qmFcl9JgWIgRqgRUj4zl0UmlFndgP62kj2GbUw8ILj1CfC4VvCZ1R0
5Rzn+gOVmhmnO+xCzMf5Jt0dumij5V8l5vC3hb+Mc8KU0pyq1qQNvo+kmzxCkgRZ
55zXNo4WgrMFrvIqfDSgqZaO/4AI6ULcJiRurcA1hTYu7kB0zEjMigWvc22F1V6Z
ND6lJKTDWG6sJzgxO8pn
=JdFI
-----END PGP SIGNATURE-----

--3/KfPELnh2c6u5MZ--

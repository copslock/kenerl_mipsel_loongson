Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Dec 2015 22:06:16 +0100 (CET)
Received: from sauhun.de ([89.238.76.85]:59899 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27013160AbbLCVGESx7R- (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 3 Dec 2015 22:06:04 +0100
Received: from p4fe25b0c.dip0.t-ipconnect.de ([79.226.91.12]:60099 helo=katana)
        by pokefinder.org with esmtpsa (TLS1.2:RSA_AES_128_CBC_SHA1:128)
        (Exim 4.80)
        (envelope-from <wsa@the-dreams.de>)
        id 1a4b4l-0003Hb-AS; Thu, 03 Dec 2015 22:06:03 +0100
Date:   Thu, 3 Dec 2015 22:06:01 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Paul Burton <paul.burton@imgtec.com>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        linux-i2c@vger.kernel.org
Subject: Re: [PATCH 15/28] i2c: eg20t: set i2c_adapter->dev.of_node
Message-ID: <20151203210601.GF8509@katana>
References: <1448900513-20856-1-git-send-email-paul.burton@imgtec.com>
 <1448900513-20856-16-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="FoLtEtfbNGMjfgrs"
Content-Disposition: inline
In-Reply-To: <1448900513-20856-16-git-send-email-paul.burton@imgtec.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <wsa@the-dreams.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50326
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wsa@the-dreams.de
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


--FoLtEtfbNGMjfgrs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 30, 2015 at 04:21:40PM +0000, Paul Burton wrote:
> Set the I2C adapter devices of_node to that of the PCI device, such that
> I2C clients may be instantiated via device tree.
>=20
> Signed-off-by: Paul Burton <paul.burton@imgtec.com>

Applied to for-next, thanks!


--FoLtEtfbNGMjfgrs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWYK65AAoJEBQN5MwUoCm2WgoP/2+pGSMn6dhbwEEp0XpkhDQS
gmT3L80YwMXT82Xn/9wyQ+C1z//Ifks7A1fD2nR+DJBARC2EzS4dFe26s+d2cgRj
tls2jt+Ok73wyIlJLQ8SESIW4vtI5iad2IbtjJhMwj0kx8T4RPA+VBvLEV/E5ABQ
a1GbB+7hZ942dDPUqcZYmDVeAqN4SVHp+UVeMTLjTK6c4pTPunB1mKDvGW66vbsI
ubP3oOeSe0ip0JR4E2xy6FynroiZZWdbuXfjp9u4wWZs1YriFu4Ktj6zpPtKNNZa
9cb8OV+fOoUbEMIru4Rmq1QOkmtchRPOvAnXJZFo4LgQT4VrHWkd9L+TPu08vmMa
a0X3KtzebwhHpzz2zgwPpHKQjjtSTytWsZJvNCrYHaJFqYuwveup6MWl5lJ1mL+W
l+3ozdsk+qr7StilGU4oA+fZMoNjF3CgCd058HjJPniPj7O7WZmcAae++6SJj31h
cwqufLuXiRKnIoy3Ug2X3m4XJ5gXWjZH5CMPhjwlGGhc74fsQOqDEzGrxCBbk+60
YbBOMSndY0KSSeF571o7qm3OxFKAklQsvAN1Jje+JUIGlZWhqdYrlb3OswThIStD
aiqdoUkKMHlrXkhScKkjsfqmdH5uO6XYK1qtmvAKLHZiKrIWFguRgC7FG4f5ED5k
377gltsbwvXw1qsX9Fmu
=laPP
-----END PGP SIGNATURE-----

--FoLtEtfbNGMjfgrs--

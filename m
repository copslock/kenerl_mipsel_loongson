Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Mar 2015 15:56:21 +0100 (CET)
Received: from sauhun.de ([89.238.76.85]:44380 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27006906AbbCLO4Tvud9g (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 12 Mar 2015 15:56:19 +0100
Received: from p4fe24c69.dip0.t-ipconnect.de ([79.226.76.105]:57859 helo=katana)
        by pokefinder.org with esmtpsa (TLS1.2:RSA_AES_128_CBC_SHA1:128)
        (Exim 4.80)
        (envelope-from <wsa@the-dreams.de>)
        id 1YW4X0-0001mo-L7; Thu, 12 Mar 2015 15:56:14 +0100
Date:   Thu, 12 Mar 2015 15:56:33 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     "Ivan T. Ivanov" <iivanov@mm-sol.com>
Cc:     linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-mips@linux-mips.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Ludovic Desroches <ludovic.desroches@atmel.com>,
        Yingjoe Chen <yingjoe.chen@mediatek.com>,
        Eddie Huang <eddie.huang@mediatek.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC V2 00/12] i2c: describe adapter quirks in a generic way
Message-ID: <20150312145633.GD9572@katana>
References: <1424880126-15047-1-git-send-email-wsa@the-dreams.de>
 <1425562025.5705.24.camel@mm-sol.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="ZJcv+A0YCCLh2VIg"
Content-Disposition: inline
In-Reply-To: <1425562025.5705.24.camel@mm-sol.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <wsa@the-dreams.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46351
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


--ZJcv+A0YCCLh2VIg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> For QUP driver.=20
>=20
> Reviewed-by: Ivan T. Ivanov <iivanov@mm-sol.com>
> Tested-by: Ivan T. Ivanov <iivanov@mm-sol.com>

Great, thanks for testing!


--ZJcv+A0YCCLh2VIg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVAakhAAoJEBQN5MwUoCm2twwP/A2zoANciZOEjLldTBsHZdK7
+RM4ElSlRH3OXmsCp3kxLxVkAUexy3GltZOrVdTDlfUm7JiATCRV64Jy2YSabwu1
9quPEDF7TRO3qJEohSMelqa2F7R8C0LrTRMANDS0b8QuxUsqF7hsESbRxKEw4Bdd
/RoTKz4En5F0mg+Tu5hL8rwwxK+D+84e+bm0Qvgd0Jg6POOuVl3gqFScpbFlQYi6
6HWlaeUFQUHrZGKZhn6oxgUdwEybv/NWtM20nSSMaFz9Bana9+foT6oEVx7g3rU7
ornBH9QUAdsXc9zZcoWizaCVmLXklD9cZGZYQReN1iMfdelpV8j4I+e/2O8C0T7b
F6ygM/AJVBe2+6GKM+e+vX/P82XTPoIPj7zXlHReUR58tGwrAQl/cXkHfx35zuVy
llDaXAbB2lCWPDPemtqRevzEFBCjrC3g4ZD7uTobEtgdoNdZ2+KNswWachaDHPhA
/z909WpzkEHu4i7l7AUrVjRCv7OyZgvxkgg1EHGlJO9jdPWLTkhfnUSxBkILr6sK
ar8yulEi8o1FvW6MXIzAinbNs/MKok73qn0Qr/6C3JP6mfoYFo15EEU/y5Vu/25O
i2+kzLhrd09BUl1XxRYxG674+Xa4Ej0kdYAZWgkHh/NWky3HpWgmKk3TSlcvXK1l
IuPw9mhSbJEzc6bQOOqz
=Ko6C
-----END PGP SIGNATURE-----

--ZJcv+A0YCCLh2VIg--

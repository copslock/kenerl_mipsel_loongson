Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Mar 2015 15:50:52 +0100 (CET)
Received: from sauhun.de ([89.238.76.85]:44340 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27006906AbbCLOuvX2BHF (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 12 Mar 2015 15:50:51 +0100
Received: from p4fe24c69.dip0.t-ipconnect.de ([79.226.76.105]:57847 helo=katana)
        by pokefinder.org with esmtpsa (TLS1.2:RSA_AES_128_CBC_SHA1:128)
        (Exim 4.80)
        (envelope-from <wsa@the-dreams.de>)
        id 1YW4RU-0001fB-Ad; Thu, 12 Mar 2015 15:50:32 +0100
Date:   Thu, 12 Mar 2015 15:50:49 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-mips@linux-mips.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Yingjoe Chen <yingjoe.chen@mediatek.com>,
        Eddie Huang <eddie.huang@mediatek.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC V2 03/12] i2c: at91: make use of the new infrastructure for
 quirks
Message-ID: <20150312145049.GA9572@katana>
References: <1424880126-15047-1-git-send-email-wsa@the-dreams.de>
 <1424880126-15047-4-git-send-email-wsa@the-dreams.de>
 <20150308082845.GB1904@katana>
 <20150310135520.GY9132@odux.rfo.atmel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="sm4nu43k4a2Rpi4c"
Content-Disposition: inline
In-Reply-To: <20150310135520.GY9132@odux.rfo.atmel.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <wsa@the-dreams.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46348
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


--sm4nu43k4a2Rpi4c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> You can add my=20
>=20
> Acked-by and Tested-By: Ludovic Desroches <ludovic.desroches@atmel.com>
>=20
> Tested on sama5d3, some problems with at24 eeprom on sama5d4 but it
> doesn't come from the i2c quirks patch series.

Thanks for testing! Are the eeprom problems something which needs fixing
upstream?


--sm4nu43k4a2Rpi4c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVAafIAAoJEBQN5MwUoCm2lyQP/jILqA5ITnGfCNuV6tGp7lPY
DdMbdr2QT/0kbeo0cX8laa5KfA83MO+AlmMFSWlR1pCQOpFvtBfCWUGxuGhwT7Pr
x4FKE2StJFKbgu86b4NCFslKLmLpii1olh4OOleKcupFsMCiNA70XiTjW9rU+jrA
U8G4K8j7d2xjHXirFdG3gkPRuMDFZDZH11dcvZOk+dbPfeb3DzwTemKz1FDctpu1
VtAQCoFQJK9WA7qtjwt1Cq/ds4CAhR1iv8jbZ5My2gB5q3XGRUspezVCSCq5MV4B
HEGHaon9kXzZusR27zZzYSiStEJ7RNvtf82hmAK/TtEDoowNRoE5/rmQ1D8nmWCy
PPmWPB/X9XRYZXqXBpQXRDj+AI8DWji99210vAxeoCtckfWJUs/UuR8A/Y02wgwD
/UKxLJzU/yRHkjS6ClWuW7cbICDIa/kWTfly0TMIZFxG2+i4z93X2ZNXF1rQ7VgY
h6vP27LYHorJ9bRYjUFQAk2IUNZvTSW7Ir8lyvVs4Os+ZDtcnp2AeRa5h+LSDC0t
m6jUWpndpZihWvga/S5B1IVyGKKc+3CfQUG8WIaox89Z9j7OOaTL5kePBhwON+6z
UiDNGc9tnnl6eoNfRKL4hUu6sEtO2fJ1UAbml0Zyo79llOnzn4XjbfXKhThBP8t/
aVXGxC1SpKU9jIsNMGkO
=qkc8
-----END PGP SIGNATURE-----

--sm4nu43k4a2Rpi4c--

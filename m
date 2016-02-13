Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 13 Feb 2016 02:49:31 +0100 (CET)
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:36374 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009751AbcBMBt3rppVJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 13 Feb 2016 02:49:29 +0100
Received: from [2a02:8011:400e:2:a11:96ff:fe28:a980] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84)
        (envelope-from <ben@decadent.org.uk>)
        id 1aUPKq-00044E-0Z; Sat, 13 Feb 2016 01:49:20 +0000
Received: from ben by deadeye with local (Exim 4.86)
        (envelope-from <ben@decadent.org.uk>)
        id 1aUPKk-0007kp-It; Sat, 13 Feb 2016 01:49:14 +0000
Message-ID: <1455328149.2801.82.camel@decadent.org.uk>
Subject: Re: [PATCH net-next v8 05/19] net: ethtool: add new
 ETHTOOL_GSETTINGS/SSETTINGS API
From:   Ben Hutchings <ben@decadent.org.uk>
To:     David Decotigny <ddecotig@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-api@vger.kernel.org, linux-mips@linux-mips.org,
        fcoe-devel@open-fcoe.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>
Cc:     Eric Dumazet <edumazet@google.com>,
        Eugenia Emantayev <eugenia@mellanox.co.il>,
        Or Gerlitz <ogerlitz@mellanox.com>,
        Ido Shamay <idos@mellanox.com>, Joe Perches <joe@perches.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Govindarajulu Varadarajan <_govind@gmx.com>,
        Venkata Duvvuru <VenkatKumar.Duvvuru@Emulex.Com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Pravin B Shelar <pshelar@nicira.com>,
        Ed Swierk <eswierk@skyportsystems.com>,
        Robert Love <robert.w.love@intel.com>,
        "James E.Yuval Mintz" <Yuval.Mintz@qlogic.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        David Decotigny <decot@googlers.com>
Date:   Sat, 13 Feb 2016 01:49:09 +0000
In-Reply-To: <1455064168-5102-6-git-send-email-ddecotig@gmail.com>
References: <1455064168-5102-1-git-send-email-ddecotig@gmail.com>
         <1455064168-5102-6-git-send-email-ddecotig@gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-NCwJIfUL82hmdvCgSQ0U"
X-Mailer: Evolution 3.18.3-1 
Mime-Version: 1.0
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:a11:96ff:fe28:a980
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Return-Path: <ben@decadent.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52031
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ben@decadent.org.uk
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


--=-NCwJIfUL82hmdvCgSQ0U
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2016-02-09 at 16:29 -0800, David Decotigny wrote:
> From: David Decotigny <decot@googlers.com>
>=20
> This patch defines a new ETHTOOL_GSETTINGS/SSETTINGS API, handled by
> the new get_ksettings/set_ksettings callbacks. This API provides
> support for most legacy ethtool_cmd fields, adds support for larger
> link mode masks (up to 4064 bits, variable length), and removes
> ethtool_cmd deprecated fields (transceiver/maxrxpkt/maxtxpkt).
[...]

I previously asked you to include 'link' in the command names and
structure name. =C2=A0This would clarify that these are now only for link
settings and reduce the risk of confusion between old and new commands.
However, you didn't reply to that review. =C2=A0Do you have any objection t=
o
doing this?

Ben.

--=20
Ben Hutchings
Sturgeon's Law: Ninety percent of everything is crap.
--=-NCwJIfUL82hmdvCgSQ0U
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIVAwUAVr6Llee/yOyVhhEJAQptQxAAqHw6JCPN3b1UNtl5CkykMq9sgZ+j8VOi
9b6BaMefBawGFNaPzk6xQBpnwfrGdcofFw+r3Y+OThloB1NB5orhWTnX8citmnlA
zFuKYE0Si1YC23nlITS+n3U8xJnQKyjwN4jB+acYc3YqELGg6qXvLGQYYpRXKBa0
rwlYT13ZjTF9oar0dpEXJo9Y3uUsWDVnAeG1E3AAqel5llKzr0n+bUdjO76rdNMQ
/B2IOq2H09ufZdRKJl9Mtd0LrcvNXZzFepfRqW86kd9NqClwwLsHsinlUVttYaz2
I5DprGRLIC2CCh82aqLwBMqvnwcR2erOANIPdGpnHS8vUpkgCdClxEXujB3IOzcs
+CYF4FMZjjVZp0fsedds4hkTKdgn1ALKurMoyfWPKbzFBdgJR8qGbpzAdR2uz3Vg
+AzeRqLv9EP3VnctF9Cmndlmy0ycmpb1Vd3sU3x+2MNFy1lPavzmbXULtB1T+GsN
TRnfUfvWQ2T+dadHpqH+tVElNivQoiaKOpL2FVWUPZEs+0ngI9I74VKQuMG2RbBu
3EzolbI3XfCt+kMbvnkJuCXHdvt63OOcVGy6QBfQW+Hy64aUaDB7ojau+/3NJjwl
K9F+jJF07SRDWToWHNO2h98fnZt2/9dxazlELgwAnyU7PpK1RieS9huDeHvXG8Ge
QM9yzxMhV4s=
=aMKY
-----END PGP SIGNATURE-----

--=-NCwJIfUL82hmdvCgSQ0U--

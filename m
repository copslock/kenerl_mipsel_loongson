Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Nov 2004 15:18:45 +0000 (GMT)
Received: from grey.subnet.at ([IPv6:::ffff:193.170.141.20]:42770 "EHLO
	grey.subnet.at") by linux-mips.org with ESMTP id <S8225192AbUKWPSl>;
	Tue, 23 Nov 2004 15:18:41 +0000
Received: from ip6-localhost ([193.170.141.4]) by grey.subnet.at ; Tue, 23 Nov 2004 16:18:37 +0100
From: Bruno Randolf <bruno.randolf@4g-systems.biz>
To: linux-mips@linux-mips.org
Subject: patch: au1000 eth vlan support
Date: Tue, 23 Nov 2004 16:10:31 +0100
User-Agent: KMail/1.7.1
Organization: 4G Systems
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart12964275.pWPlkLcm6m";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200411231610.40432.bruno.randolf@4g-systems.biz>
X-Rcpt-To: <linux-mips@linux-mips.org>
Return-Path: <bruno.randolf@4g-systems.biz>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6418
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bruno.randolf@4g-systems.biz
Precedence: bulk
X-list: linux-mips

--nextPart12964275.pWPlkLcm6m
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

hello!

i think i've sent in the following patch already, but it, or something=20
similar, is not yet in the CVS. the following line adds 802.1Q VLAN support=
=20
to the au1000 eth driver. without it vlans frames (which are 4 bytes bigger=
=20
than normal ones) are tuncated.

thanks,
bruno

=2D-- linux/drivers/net/au1000_eth.c.orig 2004-11-18 13:44:52.163605416 +01=
00
+++ linux/drivers/net/au1000_eth.c 2004-11-18 13:51:42.096286176 +0100
@@ -1389,6 +1389,7 @@
   control |=3D MAC_FULL_DUPLEX;
  }
  aup->mac->control =3D control;
+ aup->mac->vlan1_tag =3D 0x8100; /* activate vlan support */
  au_sync();
=20
  spin_unlock_irqrestore(&aup->lock, flags);

--nextPart12964275.pWPlkLcm6m
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBBo1Lwfg2jtUL97G4RAj3dAKCLUlKeJh+3EVD01efgjeSEznAyLACgj2H4
p/Ux0JYx3pq5GyT9I2OkUZw=
=AR0f
-----END PGP SIGNATURE-----

--nextPart12964275.pWPlkLcm6m--

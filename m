Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Feb 2005 20:07:40 +0000 (GMT)
Received: from mail-relay.infostations.net ([IPv6:::ffff:69.19.152.5]:37568
	"EHLO mail-relay.infostations.net") by linux-mips.org with ESMTP
	id <S8225439AbVBBUHX>; Wed, 2 Feb 2005 20:07:23 +0000
Received: from kei.infostations.net (kei.infostations.net [71.4.40.33])
	by mail-relay.infostations.net (Postfix) with ESMTP id 314B09F76C;
	Wed,  2 Feb 2005 12:07:42 -0800 (PST)
Received: from host-66-81-128-82.rev.o1.com ([66.81.128.82])
	by kei.infostations.net with esmtp (Exim 4.42 #1 (Gentoo))
	id 1CwQny-0004p2-QZ; Wed, 02 Feb 2005 12:08:51 -0800
Subject: Re: Problems with PCMCIA on AMD Alchemy DB1100
From:	Josh Green <jgreen@users.sourceforge.net>
To:	ppopov@embeddedalley.com
Cc:	linux-mips@linux-mips.org
In-Reply-To: <4200230A.6020002@embeddedalley.com>
References: <1107304567.2912.34.camel@SillyPuddy.localdomain>
	 <4200230A.6020002@embeddedalley.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-RJrn6Hhzy6NmmgtLwks3"
Date:	Wed, 02 Feb 2005 12:07:48 -0800
Message-Id: <1107374868.15000.2.camel@SillyPuddy.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Return-Path: <jgreen@users.sourceforge.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7119
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jgreen@users.sourceforge.net
Precedence: bulk
X-list: linux-mips


--=-RJrn6Hhzy6NmmgtLwks3
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

> > Some additional problems that I have been experiencing, but am still
> > investigating.  If anyone has any ideas of what is causing these, I'd
> > love to hear them.
> >=20
> > I have 2 Senao 802.11b PCMCIA cards and I'm using the hostap_cs driver.
> > If I initialize pcmcia (cardmgr) with both cards in the PCMCIA slots
> > only one of them will initialize, the second one causes an error:
> >=20
> > Linux Kernel Card Services
> >   options:  none
> > hostap_cs: 0.2.6 - 2004-12-25 (Jouni Malinen <jkmaline@cc.hut.fi>)
> > hostap_cs: Registered netdevice wifi0
> > hostap_cs: index 0x01: Vcc 3.3, irq 34, io 0xc0000000-0xc000003f
> > wifi0: NIC: id=3D0x800c v1.0.0
> > wifi0: PRI: id=3D0x15 v1.1.0
> > wifi0: STA: id=3D0x1f v1.4.9
> > 0.0: RequestIO: Configuration locked    <--- Second card causes this
> > 0.0: GetNextTuple: No more items
> > ds: unable to create instance of 'hostap_cs'!
> >=20
> >=20
> > If I bring up PCMCIA without the cards in, and then insert one, and the=
n
> > the other, both cards initialize fine and I get wlan0 and wlan1.
>=20


I think I found this bug, and this time its in drivers/pcmcia/ds.c which
surprises me, since I would think it would have been detected sooner.
Here is the patch:

--- ds.c.orig   2005-01-13 06:06:18.000000000 -0800
+++ ds.c        2005-02-02 11:58:29.125469160 -0800
@@ -660,7 +660,7 @@
                        p_dev =3D pcmcia_get_dev(p_dev);
                        if (!p_dev)
                                continue;
-                       if ((!p_dev->client.state & CLIENT_UNBOUND) ||
+                       if ((!(p_dev->client.state & CLIENT_UNBOUND)) ||
                            (!p_dev->dev.driver)) {
                                pcmcia_put_dev(p_dev);
                                continue;


Best regards,
	Josh Green


--=-RJrn6Hhzy6NmmgtLwks3
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBCATMURoMuWKCcbgQRAl3KAKCnwJ+AVF+m2XEvFHuy9MrRgPc4RACfTx+n
Lk+0Uk2RWmKdZLBN9LB0/uU=
=/J7U
-----END PGP SIGNATURE-----

--=-RJrn6Hhzy6NmmgtLwks3--

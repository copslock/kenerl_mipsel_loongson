Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fBMLlFi11965
	for linux-mips-outgoing; Sat, 22 Dec 2001 13:47:15 -0800
Received: from noose.gt.owl.de (postfix@noose.gt.owl.de [62.52.19.4])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fBMLl9X11962
	for <linux-mips@oss.sgi.com>; Sat, 22 Dec 2001 13:47:10 -0800
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 54EE983C; Sat, 22 Dec 2001 21:46:56 +0100 (CET)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id A22C945DF; Fri, 21 Dec 2001 00:23:07 +0100 (CET)
Date: Fri, 21 Dec 2001 00:23:07 +0100
From: Florian Lohoff <flo@rfc822.org>
To: linux-mips@oss.sgi.com
Subject: sgiseeq.c
Message-ID: <20011220232307.GA22055@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yrj/dFKFPuw6o+aM"
Content-Disposition: inline
User-Agent: Mutt/1.3.24i
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


--yrj/dFKFPuw6o+aM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Hi,
did anyone have a look at the sgiseeq.c driver ? It seems it is
very suboptimal to what the hardware is capable to do. From just a quick
glance we are copying the packets payload from the skb to KSEG1
preallocated tx-rings and then run the dma instead of just dmaing from
the skbuff we just got handed (After a dma_cache_wback_inv for the
skbuf).=20
On receive we basically do the same the other way round. We copy the
packets from KSEG1 to the "final" skb.=20

=46rom my perspective this is ok when you only have "cache_flush_all"=20
but with the finer granularity of dma_cache_wback_inv or dma_cache_inv
we would be more happy to just dma from the skbuff shouldnt we ?

Flo
--=20
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
Nine nineth on september the 9th              Welcome to the new billenium

--yrj/dFKFPuw6o+aM
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8InLbUaz2rXW+gJcRAu8AAKCTkqxSga2nJyslnxMppEaCDRufJACg57iu
Sq+4lykpbzHIn0NULWK6KfE=
=JfmE
-----END PGP SIGNATURE-----

--yrj/dFKFPuw6o+aM--

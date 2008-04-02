Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Apr 2008 20:32:11 +0200 (CEST)
Received: from hydra.gt.owl.de ([195.71.99.218]:11463 "EHLO hydra.gt.owl.de")
	by lappi.linux-mips.net with ESMTP id S1102616AbYDBScD (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 2 Apr 2008 20:32:03 +0200
Received: by hydra.gt.owl.de (Postfix, from userid 1000)
	id 2BC3832CEB; Wed,  2 Apr 2008 20:31:14 +0200 (CEST)
Date:	Wed, 2 Apr 2008 20:31:14 +0200
From:	Florian Lohoff <flo@rfc822.org>
To:	Matteo Croce <technoboy85@gmail.com>
Cc:	linux-mips@linux-mips.org, Eugene Konev <ejka@imfi.kspu.ru>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH][MIPS][3/6]: AR7: VLYNQ bus
Message-ID: <20080402183114.GA371@paradigm.rfc822.org>
References: <200803120221.25044.technoboy85@gmail.com> <200803120226.42795.technoboy85@gmail.com> <20080329095914.GA18263@paradigm.rfc822.org> <200804021456.44472.technoboy85@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZGiS0Q5IWpPtfppv"
Content-Disposition: inline
In-Reply-To: <200804021456.44472.technoboy85@gmail.com>
Organization: rfc822 - pure communication
X-SpiderMe: mh-200804022026@listme.rfc822.org
User-Agent: Mutt/1.5.13 (2006-08-11)
Return-Path: <flo@rfc822.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18776
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: flo@rfc822.org
Precedence: bulk
X-list: linux-mips


--ZGiS0Q5IWpPtfppv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 02, 2008 at 02:56:44PM +0200, Matteo Croce wrote:
>=20
> Works fine for my AR7 which has an interlan clock.
>=20

Its doesnt for me with an external clock - thats what i mean - Auto
probing should first try to listen for an external clock before letting
clocks run against each other. This is the hunk of a patch on top of
yours ...

@@ -371,12 +371,20 @@ static int __vlynq_enable_device(struct=20
=20
        switch (dev->divisor) {
        case vlynq_div_auto:
-               /* Only try locally supplied clock, others cause problems */
+      =20
+               vlynq_reg_write(dev->local->control, 0);
                vlynq_reg_write(dev->remote->control, 0);
+               if (vlynq_linked(dev)) {
+                       printk(KERN_DEBUG "%s: using external clock\n",
+                              dev->dev.bus_id);
+                       return 0;
+               }
+
                for (i =3D vlynq_ldiv2; i <=3D vlynq_ldiv8; i++) {
                        vlynq_reg_write(dev->local->control,
                                        VLYNQ_CTRL_CLOCK_INT |
                                        VLYNQ_CTRL_CLOCK_DIV(i - vlynq_ldiv=
1));
+                       vlynq_reg_write(dev->remote->control, 0);
                        if (vlynq_linked(dev)) {
                                printk(KERN_DEBUG
                                       "%s: using local clock divisor %d\n",

Flo
--=20
Florian Lohoff                  flo@rfc822.org             +49-171-2280134
	Those who would give up a little freedom to get a little=20
          security shall soon have neither - Benjamin Franklin

--ZGiS0Q5IWpPtfppv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFH89DyUaz2rXW+gJcRAmkrAKCHy18gvEz0YZyWRsIKSaapLwPACgCgln1W
ASQxBkyXowNvoXqegMq9VxQ=
=qKwm
-----END PGP SIGNATURE-----

--ZGiS0Q5IWpPtfppv--

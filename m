Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 May 2006 16:10:39 +0100 (BST)
Received: from 81-174-11-161.f5.ngi.it ([81.174.11.161]:45255 "EHLO
	gundam.enneenne.com") by ftp.linux-mips.org with ESMTP
	id S8133712AbWEBPKa (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 2 May 2006 16:10:30 +0100
Received: from giometti by gundam.enneenne.com with local (Exim 3.36 #1 (Debian))
	id 1FawV0-0002EA-00; Tue, 02 May 2006 17:09:14 +0200
Date:	Tue, 2 May 2006 17:09:14 +0200
From:	Rodolfo Giometti <giometti@linux.it>
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc:	jgarzik@pobox.com, netdev@vger.kernel.org,
	Linux-MIPS <linux-mips@linux-mips.org>
Subject: Re: [PATCH] au1000_eth.c Power Management, driver registration and module support
Message-ID: <20060502150914.GE20543@gundam.enneenne.com>
References: <20060405154711.GL7029@enneenne.com> <20060405222332.GO7029@enneenne.com> <20060405222620.GP7029@enneenne.com> <4435290C.50607@ru.mvista.com> <20060406155011.GC23424@enneenne.com> <4446857D.90507@ru.mvista.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6WlEvdN9Dv0WHSBl"
Content-Disposition: inline
In-Reply-To: <4446857D.90507@ru.mvista.com>
Organization: GNU/Linux Device Drivers, Embedded Systems and Courses
X-PGP-Key: gpg --keyserver keyserver.linux.it --recv-keys D25A5633
User-Agent: Mutt/1.5.5.1+cvs20040105i
Return-Path: <giometti@enneenne.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11272
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: giometti@linux.it
Precedence: bulk
X-list: linux-mips


--6WlEvdN9Dv0WHSBl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

here:

   http://ftp.enneenne.com/pub/misc/au1100-patches/linux/patch-au1000_eth-p=
m-and-registration

the new version of my patch for au1000_eth.c who should implement:

* Module support.

   -	bool "MIPS AU1000 Ethernet support"
   +	tristate "MIPS AU1000 Ethernet support"

* Driver registration.

   +static int __init au1000_eth_init(void)
   +{
   +	return driver_register(&au1000_driver);
   +}
   +
   +static void __exit au1000_eth_cleanup(void)
   +{
   +	driver_unregister(&au1000_driver);
   +}     =20

* Power Management.

   +#ifdef CONFIG_PM
   +	.suspend        =3D au1000_drv_suspend,
   +	.resume         =3D au1000_drv_resume,
   +#endif

Also, as suggested by Sergei it:

* uses physical addresses and not KSEG1-based virtual anymore and
  claims/releases the 4-byte MAC enable registers:

   wwpc:~# cat /proc/iomem
   10500000-1050ffff : eth-base
   10520000-10520003 : eth-mac
     =20
* assigns to the Ethernet ports two consecutive MAC addresses:

   -		dev->dev_addr[4] +=3D 0x10;
   +				((unsigned long) macen_addr);
   +		memcpy(ndev->dev_addr, au1000_mac_addr, sizeof(au1000_mac_addr));
   +		ndev->dev_addr[5] +=3D 0x01;
     =20
Ciao,

Rodolfo

--=20

GNU/Linux Solutions                  e-mail:    giometti@enneenne.com
Linux Device Driver                             giometti@gnudd.com
Embedded Systems                     		giometti@linux.it
UNIX programming                     phone:     +39 349 2432127

--6WlEvdN9Dv0WHSBl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFEV3YaQaTCYNJaVjMRAkmvAKC1t5hzmLeO1EmmfVz1+l8sX6dQeACdHu+c
Vr4ge1cRv4H88pgyp+ncci4=
=cO/5
-----END PGP SIGNATURE-----

--6WlEvdN9Dv0WHSBl--

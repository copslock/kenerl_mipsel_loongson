Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fBDFOwG06636
	for linux-mips-outgoing; Thu, 13 Dec 2001 07:24:58 -0800
Received: from noose.gt.owl.de (postfix@noose.gt.owl.de [62.52.19.4])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fBDFOro06631
	for <linux-mips@oss.sgi.com>; Thu, 13 Dec 2001 07:24:53 -0800
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id EE93E855; Thu, 13 Dec 2001 15:24:42 +0100 (CET)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id A6E5E44AC; Thu, 13 Dec 2001 15:24:13 +0100 (CET)
Date: Thu, 13 Dec 2001 15:24:13 +0100
From: Florian Lohoff <flo@rfc822.org>
To: linux-mips@oss.sgi.com
Subject: Wrong /proc/cpuinfo on SGI Indy 
Message-ID: <20011213142413.GB12503@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oLBj+sq0vYjzfsbl"
Content-Disposition: inline
User-Agent: Mutt/1.3.24i
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


--oLBj+sq0vYjzfsbl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Hi,
broken /proc/cpuinfo with current cvs:

flo@revamp:~$ cat /proc/cpuinfo=20
system type             : SGI IndyIndy
processor               : 0
cpu model               : R4600 V2.0  FPU V2.0
BogoMIPS                : 132.71
wait instruction        : yes
microsecond timers      : yes
extra interrupt vector  : no
hardware watchpoint     : no
VCED exceptions         : not available
VCEI exceptions         : not available

Flo
--=20
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
Nine nineth on september the 9th              Welcome to the new billenium

--oLBj+sq0vYjzfsbl
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8GLoNUaz2rXW+gJcRAsKPAJ9SmC8o8xDZcFDmgIoUIYMPPPJFmwCeJVoS
sPuuQ9EsqImF+4LPE4IptLY=
=mZMU
-----END PGP SIGNATURE-----

--oLBj+sq0vYjzfsbl--

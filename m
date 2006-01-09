Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Jan 2006 17:44:10 +0000 (GMT)
Received: from 81-174-11-161.f5.ngi.it ([81.174.11.161]:27809 "EHLO
	gundam.enneenne.com") by ftp.linux-mips.org with ESMTP
	id S8133636AbWAIRnw (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 9 Jan 2006 17:43:52 +0000
Received: from giometti by gundam.enneenne.com with local (Exim 3.36 #1 (Debian))
	id 1Ew14r-0007vB-00; Mon, 09 Jan 2006 18:45:05 +0100
Date:	Mon, 9 Jan 2006 18:45:05 +0100
From:	Rodolfo Giometti <giometti@linux.it>
To:	Jordan Crouse <jordan.crouse@amd.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: ALCHEMY:  Add SD support to AU1200 MMC/SD driver
Message-ID: <20060109174505.GD1373@gundam.enneenne.com>
References: <20051202190108.GF28227@cosmic.amd.com> <20051214134139.GN22061@hulk.enneenne.com> <20051214155324.GC9734@cosmic.amd.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VUDLurXRWRKrGuMn"
Content-Disposition: inline
In-Reply-To: <20051214155324.GC9734@cosmic.amd.com>
Organization: Programmi e soluzioni GNU/Linux
X-PGP-Key: gpg --keyserver keyserver.penguin.de --recv-keys D25A5633
User-Agent: Mutt/1.5.5.1+cvs20040105i
Return-Path: <giometti@enneenne.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9821
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: giometti@linux.it
Precedence: bulk
X-list: linux-mips


--VUDLurXRWRKrGuMn
Content-Type: multipart/mixed; boundary="GpGaEY17fSl8rd50"
Content-Disposition: inline


--GpGaEY17fSl8rd50
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 14, 2005 at 08:53:25AM -0700, Jordan Crouse wrote:
> Well, hopefully everything will Just Work (TM), but you'll want to make
> sure that all the various definitions are enabled for the AU1100.  I'll
> have to give you my standard disclaimer that I haven't compiled this
> for anything but a DB1200 and PB1200, so I can't promise that it will wor=
k,
> but there is nothing in the code that says it won't.

I'm just trying to run your driver on a Au1100 based board and I got
some problems...

First of all I needed to disable the DMA support (dma =3D 0) and using
the FIFO mode, since Au1100 dma support seems not well implemented (or
not implemented at all) and my board freeze.

After that, when I insert a 256MB MMC card I get the attached messages
and the system refuses to power up the card (please, see the last
message who reports the power status).

Have you any suggestions? :)

Thanks in advance,

Rodolfo

--=20

GNU/Linux Solutions                  e-mail:    giometti@enneenne.com
Linux Device Driver                             giometti@gnudd.com
Embedded Systems                     		giometti@linux.it
UNIX programming                     phone:     +39 349 2432127

--GpGaEY17fSl8rd50
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=mmc_output

Jan  1 00:01:17 hostname kernel: set_ios (id=0, power=1, clock=0Hz, vdd=23, mode=1)
Jan  1 00:01:17 hostname kernel: set_ios (id=0, power=2, clock=450000Hz, vdd=23, mode=1)
Jan  1 00:01:17 hostname kernel: WWPC: power 1
Jan  1 00:01:17 hostname kernel: set_ios (id=0, power=2, clock=450000Hz, vdd=23, mode=1)
Jan  1 00:01:17 hostname kernel: WWPC: power 1
Jan  1 00:01:17 hostname kernel: MMC: starting cmd 00 arg 00000000 flags 00000000
Jan  1 00:01:17 hostname kernel: MMC: req done (00): 0: 00000000 00000000 00000000 00000000
Jan  1 00:01:17 hostname kernel: set_ios (id=0, power=2, clock=450000Hz, vdd=23, mode=1)
Jan  1 00:01:17 hostname kernel: WWPC: power 1
Jan  1 00:01:17 hostname kernel: MMC: starting cmd 37 arg 00000000 flags 00000009
Jan  1 00:01:17 hostname kernel: MMC: req done (37): 2: 3fffffff 00000000 00000000 00000000
Jan  1 00:01:17 hostname kernel: MMC: starting cmd 37 arg 00000000 flags 00000009
Jan  1 00:01:17 hostname kernel: MMC: req done (37): 0: 00000120 00000000 00000000 00000000
Jan  1 00:01:17 hostname kernel: MMC: starting cmd 29 arg 00000000 flags 00000001
Jan  1 00:01:17 hostname kernel: MMC: req done (29): 0: 00ff8000 00000000 00000000 00000000
Jan  1 00:01:17 hostname kernel: set_ios (id=0, power=2, clock=450000Hz, vdd=15, mode=1)
Jan  1 00:01:17 hostname kernel: WWPC: power 1
Jan  1 00:01:17 hostname kernel: set_ios (id=0, power=2, clock=450000Hz, vdd=15, mode=1)
Jan  1 00:01:17 hostname kernel: WWPC: power 1
Jan  1 00:01:17 hostname kernel: MMC: starting cmd 00 arg 00000000 flags 00000000
Jan  1 00:01:17 hostname kernel: MMC: req done (00): 0: 00000000 00000000 00000000 00000000
Jan  1 00:01:17 hostname kernel: set_ios (id=0, power=2, clock=450000Hz, vdd=15, mode=1)
Jan  1 00:01:17 hostname kernel: WWPC: power 1
Jan  1 00:01:17 hostname kernel: MMC: starting cmd 37 arg 00000000 flags 00000009
Jan  1 00:01:17 hostname kernel: MMC: req done (37): 0: 00000120 00000000 00000000 00000000
Jan  1 00:01:17 hostname kernel: MMC: starting cmd 29 arg 00018000 flags 00000001
Jan  1 00:01:17 hostname kernel: MMC: req done (29): 0: 00ff8000 00000000 00000000 00000000
Jan  1 00:01:17 hostname kernel: MMC: starting cmd 37 arg 00000000 flags 00000009
Jan  1 00:01:17 hostname kernel: MMC: req done (37): 0: 00000120 00000000 00000000 00000000
Jan  1 00:01:17 hostname kernel: MMC: starting cmd 29 arg 00018000 flags 00000001
Jan  1 00:01:17 hostname kernel: MMC: req done (29): 0: 00ff8000 00000000 00000000 00000000
Jan  1 00:01:17 hostname kernel: MMC: starting cmd 37 arg 00000000 flags 00000009
Jan  1 00:01:17 hostname kernel: MMC: req done (37): 0: 00000120 00000000 00000000 00000000
Jan  1 00:01:17 hostname kernel: MMC: starting cmd 29 arg 00018000 flags 00000001
Jan  1 00:01:17 hostname kernel: MMC: req done (29): 0: 00ff8000 00000000 00000000 00000000
Jan  1 00:01:17 hostname kernel: MMC: starting cmd 37 arg 00000000 flags 00000009
Jan  1 00:01:17 hostname kernel: MMC: req done (37): 1: 00000000 00000000 00000000 00000000
Jan  1 00:01:17 hostname kernel: MMC: starting cmd 37 arg 00000000 flags 00000009
Jan  1 00:01:17 hostname kernel: MMC: req done (37): 1: 00000000 00000000 00000000 00000000
Jan  1 00:01:17 hostname kernel: MMC: starting cmd 37 arg 00000000 flags 00000009
Jan  1 00:01:17 hostname kernel: MMC: req done (37): 0: 00000120 00000000 00000000 00000000
Jan  1 00:01:17 hostname kernel: MMC: starting cmd 29 arg 00018000 flags 00000001
Jan  1 00:01:17 hostname kernel: MMC: req done (29): 0: 00ff8000 00000000 00000000 00000000
Jan  1 00:01:17 hostname kernel: MMC: starting cmd 37 arg 00000000 flags 00000009
Jan  1 00:01:17 hostname kernel: MMC: req done (37): 0: 00000120 00000000 00000000 00000000
Jan  1 00:01:17 hostname kernel: MMC: starting cmd 29 arg 00018000 flags 00000001
Jan  1 00:01:17 hostname kernel: MMC: req done (29): 0: 00ff8000 00000000 00000000 00000000
Jan  1 00:01:17 hostname kernel: MMC: starting cmd 37 arg 00000000 flags 00000009
Jan  1 00:01:17 hostname kernel: MMC: req done (37): 0: 00000120 00000000 00000000 00000000
Jan  1 00:01:17 hostname kernel: MMC: starting cmd 29 arg 00018000 flags 00000001
Jan  1 00:01:17 hostname kernel: MMC: req done (29): 0: 00ff8000 00000000 00000000 00000000
Jan  1 00:01:17 hostname kernel: MMC: starting cmd 37 arg 00000000 flags 00000009
Jan  1 00:01:17 hostname kernel: MMC: req done (37): 0: 00000120 00000000 00000000 00000000
Jan  1 00:01:17 hostname kernel: MMC: starting cmd 29 arg 00018000 flags 00000001
Jan  1 00:01:17 hostname kernel: MMC: req done (29): 0: 00ff8000 00000000 00000000 00000000
Jan  1 00:01:17 hostname kernel: MMC: starting cmd 37 arg 00000000 flags 00000009
Jan  1 00:01:17 hostname kernel: MMC: req done (37): 1: 00000000 00000000 00000000 00000000
Jan  1 00:01:17 hostname kernel: MMC: starting cmd 37 arg 00000000 flags 00000009
Jan  1 00:01:17 hostname kernel: MMC: req done (37): 1: 00000000 00000000 00000000 00000000
Jan  1 00:01:17 hostname kernel: MMC: starting cmd 37 arg 00000000 flags 00000009
Jan  1 00:01:17 hostname kernel: MMC: req done (37): 1: 00000000 00000000 00000000 00000000
Jan  1 00:01:17 hostname kernel: MMC: starting cmd 37 arg 00000000 flags 00000009
Jan  1 00:01:17 hostname kernel: MMC: req done (37): 1: 00000000 00000000 00000000 00000000
Jan  1 00:01:17 hostname kernel: MMC: starting cmd 02 arg 00000000 flags 0000000a
Jan  1 00:01:17 hostname kernel: MMC: req done (02): 1: 00000000 00000000 00000000 00000000
Jan  1 00:01:17 hostname last message repeated 3 times
Jan  1 00:01:17 hostname kernel: set_ios (id=0, power=2, clock=450000Hz, vdd=15, mode=2)
Jan  1 00:01:17 hostname kernel: WWPC: power 1
Jan  1 00:01:17 hostname kernel: set_ios (id=0, power=0, clock=0Hz, vdd=0, mode=1)
Jan  1 00:01:17 hostname kernel: WWPC: power 0

--GpGaEY17fSl8rd50--

--VUDLurXRWRKrGuMn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFDwqEhQaTCYNJaVjMRArOqAJsFwn3pQfPW2I8+W/IGf4GU8Ad+uwCg1k7P
3j4X9JyhxEXVrTzJydIKS5Q=
=S5Ke
-----END PGP SIGNATURE-----

--VUDLurXRWRKrGuMn--

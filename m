Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f34LbqF00656
	for linux-mips-outgoing; Wed, 4 Apr 2001 14:37:52 -0700
Received: from barry.mail.mindspring.net (barry.mail.mindspring.net [207.69.200.25])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f34LbpM00653
	for <linux-mips@oss.sgi.com>; Wed, 4 Apr 2001 14:37:51 -0700
Received: from frednet.dyndns.org (user-33qt47m.dialup.mindspring.com [199.174.144.246])
	by barry.mail.mindspring.net (8.9.3/8.8.5) with SMTP id RAA05052
	for <linux-mips@oss.sgi.com>; Wed, 4 Apr 2001 17:37:48 -0400 (EDT)
Received: (qmail 22476 invoked by uid 1000); 4 Apr 2001 21:37:47 -0000
Date: Wed, 4 Apr 2001 16:37:47 -0500
From: Matthew Fredrickson <matt@frednet.dyndns.org>
To: jsc6233@ritvax.isc.rit.edu, linux-mips@oss.sgi.com
Subject: Re: your mail
Message-ID: <20010404163747.A22469@frednet.dyndns.org>
References: <5.0.0.25.0.20010404172906.00a4bce8@vmspop.isc.rit.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="SUOF0GtieIMvvwua"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <5.0.0.25.0.20010404172906.00a4bce8@vmspop.isc.rit.edu>; from jsc6233@ritvax.isc.rit.edu on Wed, Apr 04, 2001 at 05:29:54PM -0700
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


--SUOF0GtieIMvvwua
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 04, 2001 at 05:29:54PM -0700, jsc6233@ritvax.isc.rit.edu wrote:
>=20
> hello,
> Yeah i am trying to compile it while running Irix 6.5. Once i get it all=
=20
> working I was going to boot into it. Does that make sense?
> james

<g>No offense, but not really.  Actually, you'll probably need to start
off by setting up the x86-mips cross compilers on an x86 linux machine of
yours and booting the kernel via tftp over the network to get started.  I
think most of this is covered in the FAQ on the site.  Anyway, I don't
think it's _ever_ been supported to compile up the kernel in IRIX anyway,
so your kind of out of luck for that.  On a side note, you probably want
to stop by freeware.sgi.com and upgrade your gcc from 2.7 to the latest
(2.95.3 I think).  Might even try downloading some pre3.0 stuff and try
that out.  Back to topic:  Read EVERYTHING you can on the linux-mips sgi
site before asking a question here;  if you don't, that's a very good way
to get kindly (and a lot of times unkindly) pointed to the FAQ.  Hope this
helps.

--=20
Matthew Fredrickson AIM MatthewFredricks
ICQ 13923212 matt@NOSPAMfredricknet.net=20
http://www.fredricknet.net/~matt/
"Everything is relative"

--SUOF0GtieIMvvwua
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6y5QrHzCekITFKgsRAv8dAJ48BXa3ksHmb8khceS0s5jj4Tm4mQCfQ1KR
eKluaXCQYgFgqvZfvTzJ394=
=//D2
-----END PGP SIGNATURE-----

--SUOF0GtieIMvvwua--

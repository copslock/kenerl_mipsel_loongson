Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f8K69xA14036
	for linux-mips-outgoing; Wed, 19 Sep 2001 23:09:59 -0700
Received: from straylight.cyberhqz.com (root@h24-76-98-250.vc.shawcable.net [24.76.98.250])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f8K69te14033
	for <linux-mips@oss.sgi.com>; Wed, 19 Sep 2001 23:09:55 -0700
Received: (from rmurray@localhost)
	by straylight.cyberhqz.com (8.9.3/8.9.3/Debian 8.9.3-21) id XAA17444
	for linux-mips@oss.sgi.com; Wed, 19 Sep 2001 23:09:53 -0700
From: Ryan Murray <rmurray@cyberhqz.com>
Date: Wed, 19 Sep 2001 23:09:53 -0700
To: linux-mips@oss.sgi.com
Subject: Re: native gcc-3.0.1?
Message-ID: <20010919230953.B6044@cyberhqz.com>
Mail-Followup-To: linux-mips@oss.sgi.com
References: <20010920015742.A8317@neurosis.mit.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZGiS0Q5IWpPtfppv"
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <20010920015742.A8317@neurosis.mit.edu>; from jim@jtan.com on Thu, Sep 20, 2001 at 01:57:42AM -0400
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


--ZGiS0Q5IWpPtfppv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 20, 2001 at 01:57:42AM -0400, Jim Paris wrote:
> Does anyone have gcc-3.0.1 built as a native MIPS compiler?

Debian built 3.0.1 natively...

> It could also be that gcc-3.0.1 is simply broken when running natively
> on MIPS.  Has anyone done this?  Any luck?

When that was the version in Debian, it did work.

> anyone has built gcc-3.0 or gcc-3.0.1 natively on MIPS, can you send
> me the config.cache from your build?

I don't have that around anymore, but I can send you the config.cache from
a build of a 3.0.2 CVS snapshot...

--=20
Ryan Murray, Debian Developer (rmurray@cyberhqz.com, rmurray@debian.org)
The opinions expressed here are my own.

--ZGiS0Q5IWpPtfppv
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7qYgxN2Dbz/1mRasRAgwhAKCmEITst+jeArOdgIJaEW4amMU/wQCglsnw
dSmS5JtzKZQZLmhtuSDqm+k=
=aTMZ
-----END PGP SIGNATURE-----

--ZGiS0Q5IWpPtfppv--

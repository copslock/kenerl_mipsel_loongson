Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g76GVuRw028291
	for <linux-mips-outgoing@oss.sgi.com>; Tue, 6 Aug 2002 09:31:56 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g76GVu62028290
	for linux-mips-outgoing; Tue, 6 Aug 2002 09:31:56 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from noose.gt.owl.de (noose.gt.owl.de [62.52.19.4])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g76GVmRw028281
	for <linux-mips@oss.sgi.com>; Tue, 6 Aug 2002 09:31:49 -0700
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 7936E7F3; Tue,  6 Aug 2002 18:33:44 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 320D03714B; Tue,  6 Aug 2002 18:33:38 +0200 (CEST)
Date: Tue, 6 Aug 2002 18:33:38 +0200
From: Florian Lohoff <flo@rfc822.org>
To: Robin Humble <rjh@cita.utoronto.ca>
Cc: linux-mips@oss.sgi.com
Subject: Re: R4600SC Indy
Message-ID: <20020806163338.GA8378@paradigm.rfc822.org>
References: <20020806111959.C15670@marmot.cita.utoronto.ca>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BXVAT5kNtrzKuDFl"
Content-Disposition: inline
In-Reply-To: <20020806111959.C15670@marmot.cita.utoronto.ca>
User-Agent: Mutt/1.3.28i
Organization: rfc822 - pure communication
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


--BXVAT5kNtrzKuDFl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 06, 2002 at 11:20:00AM -0400, Robin Humble wrote:
> The 2.4.17-13feb2002 kernel on the R4600SC seems pretty stable (apart
> from the ubiquitous X shared mem/bitmap corruption) so I'm quietly
> confident that there are no broken hardware issues... I'm running
> redhat-7.1 + much of 7.2 and some 7.3. Toolchain is:

The debian mips kernel has a fix for the shmem issues - It has been
posted to this list a couple of times but was found to be an incomplete
fix.

Flo
--=20
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
                        Heisenberg may have been here.

--BXVAT5kNtrzKuDFl
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE9T/piUaz2rXW+gJcRAgYVAKDf7jJ6X6UNosdocds+NghWmZZtkgCcDzHk
uHulBTqvgsmvFyNbJMMJvV8=
=8LTy
-----END PGP SIGNATURE-----

--BXVAT5kNtrzKuDFl--

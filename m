Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f7FI4g522331
	for linux-mips-outgoing; Wed, 15 Aug 2001 11:04:42 -0700
Received: from gateway.total-knowledge.com (c1213523-b.smateo1.sfba.home.com [24.1.66.97])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f7FI4fj22325
	for <linux-mips@oss.sgi.com>; Wed, 15 Aug 2001 11:04:41 -0700
Received: (qmail 8241 invoked by uid 502); 15 Aug 2001 18:04:40 -0000
Content-Type: text/plain;
  charset="iso-8859-1"
From: Ilya Volynets <ilya@theIlya.com>
Reply-To: ilya@theIlya.com
Organization: Total knowledge
To: Keith M Wesolowski <wesolows@foobazco.org>,
   "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Subject: Re: [patch] linux 2.4.5: Export mips_machtype
Date: Wed, 15 Aug 2001 11:04:37 -0700
X-Mailer: KMail [version 1.2]
Cc: "Gleb O. Raiko" <raiko@niisi.msk.ru>, Ralf Baechle <ralf@oss.sgi.com>,
   Harald Koerfgen <hkoerfg@web.de>, linux-mips@fnet.fr,
   linux-mips@oss.sgi.com
References: <20010815104435.A8370@foobazco.org>
In-Reply-To: <20010815104435.A8370@foobazco.org>
MIME-Version: 1.0
Message-Id: <0108151104370T.07543@gateway>
Content-Transfer-Encoding: 8bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Wednesday 15 August 2001 10:44, Keith M Wesolowski wrote:
> On Tue, Aug 14, 2001 at 07:43:23PM +0200, Maciej W. Rozycki wrote:
> >  How do you set up mips_machtype on your system in the first place?  At
> > kernel_entry the code does not know what machine it's running on anyway,
> > so it has to set mips_machtype based on a detection algorithm.
>
> Of course.  I published a patch and some documentation a long time ago
> for doing just this.  I don't think anyone ever even read any of it; I
> received no comments.  In any case it's currently used in my tree for
> O2 and although I know it could be better it seems to work rather
> well.
Not true. I read it, and thought it's good enough to leave as is :-)
No comments seemed to be nessesary.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjt6ubgACgkQtKh84cA8u2nZhgCg2eg3Z48ZjXca9x3Rctt48Jj9
oisAoKEF2LQz3tnIc+I+j6nfSnOdFKgG
=+aUM
-----END PGP SIGNATURE-----

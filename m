Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6HK96o30363
	for linux-mips-outgoing; Tue, 17 Jul 2001 13:09:06 -0700
Received: from gateway.total-knowledge.com (c1213523-b.smateo1.sfba.home.com [24.1.66.97])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6HK94V30360
	for <linux-mips@oss.sgi.com>; Tue, 17 Jul 2001 13:09:04 -0700
Received: (qmail 29906 invoked by uid 502); 17 Jul 2001 20:09:03 -0000
Content-Type: text/plain;
  charset="koi8-r"
From: Ilya Volynets <ilya@theIlya.com>
Reply-To: ilya@theIlya.com
Organization: Total knowledge
To: "H . J . Lu" <hjl@lucon.org>
Subject: Re: Updates on RedHat 7.1/mips
Date: Tue, 17 Jul 2001 13:09:00 -0700
X-Mailer: KMail [version 1.2]
Cc: linux-mips@oss.sgi.com
References: <3B4573B8.9F89022B@mips.com> <20010717125027.A22672@nevyn.them.org> <20010717125718.A24725@lucon.org>
In-Reply-To: <20010717125718.A24725@lucon.org>
MIME-Version: 1.0
Message-Id: <01071713090011.04620@gateway>
Content-Transfer-Encoding: 8bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Tuesday 17 July 2001 12:57, H . J . Lu wrote:
> On Tue, Jul 17, 2001 at 12:50:27PM -0700, Daniel Jacobowitz wrote:
> > > Perl has to be built natively. I uploaded mysql-3.23.36-1.1.src.rpm,
> > > perl-5.6.0-12.1.src.rpm, apache-1.3.19-5.src.rpm,
> > > mod_perl-1.24_01-2.src.rpm, tcsh-6.10-5.src.rpm and
> > > zsh-3.0.8-8.src.rpm. Just installed my RedHat 7.1. Then you can build
> > > perl yourself. You may need to build/install the tcsh rpm first.
> >
> > It's not yet available for MIPS (later this week), but MontaVista
> > Journeyman contains the patches to cross-compile Perl.  It's not pretty,
> > though.
>
> That is a reason why I didn't bother with cross-compile Perl :-). The
> next thing on my todo list is to cross compile XFree86 :-(.
If you can get cross-compiling full XFree86, you'll be a hero of all times.
It shouldn't be hard to get it with KDriveArchitecture & TinyX enabled.

I was working on it a while ago, and here are few pointers:
Some tools have to be run natively (i.e. xkbcomp), but also need to
be installed on target. I din't find a rule that does both. I think new
rule is needed.

gcc-3.0 crashes when compiling some parts of Xserver and Xlib,
with very obscure bug. Minimal test case I came up with is
~45(!) lines long. Keith filed report to gcc team on my behalf,
but there seems to be no responce. I do not know if your
gcc has same problem, but someone mentioned similar problem
with 2.9x.y series on this list not so long ago.

Hmm... I can't remember any other interesting things at this moment, but if I
will, I'll follow up...

	Ilya.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjtUm18ACgkQtKh84cA8u2ll+QCfSjexRpQ2H7Qa16JYrun/vvVd
vCQAoIKb1BRxJ/508SWu9uHEP0okhH00
=kWTa
-----END PGP SIGNATURE-----

Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6I41PU27195
	for linux-mips-outgoing; Tue, 17 Jul 2001 21:01:25 -0700
Received: from gateway.total-knowledge.com (c1213523-b.smateo1.sfba.home.com [24.1.66.97])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6I41OV27190
	for <linux-mips@oss.sgi.com>; Tue, 17 Jul 2001 21:01:24 -0700
Received: (qmail 1561 invoked by uid 502); 18 Jul 2001 04:01:23 -0000
Content-Type: text/plain;
  charset="koi8-r"
From: Ilya Volynets <ilya@theIlya.com>
Reply-To: ilya@theIlya.com
Organization: Total knowledge
To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
   "H . J . Lu" <hjl@lucon.org>
Subject: Re: Updates on RedHat 7.1/mips
Date: Tue, 17 Jul 2001 21:01:20 -0700
X-Mailer: KMail [version 1.2]
Cc: linux-mips@oss.sgi.com
References: <3B4573B8.9F89022B@mips.com> <20010717131146.A24907@lucon.org> <20010718005255.R10373@conectiva.com.br>
In-Reply-To: <20010718005255.R10373@conectiva.com.br>
MIME-Version: 1.0
Message-Id: <01071721012019.04620@gateway>
Content-Transfer-Encoding: 8bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Those messages are about compiling using TinyX and KDrive, which
works with only minor modifications. Thing is, it is not what is really needed.

On Tuesday 17 July 2001 20:52, Arnaldo Carvalho de Melo wrote:
> Em Tue, Jul 17, 2001 at 01:11:46PM -0700, H . J . Lu escreveu:
> > On Tue, Jul 17, 2001 at 01:09:00PM -0700, Ilya Volynets wrote:
> > > I was working on it a while ago, and here are few pointers:
> > > Some tools have to be run natively (i.e. xkbcomp), but also need to
> > > be installed on target. I din't find a rule that does both. I think new
> > > rule is needed.
> >
> > I am aware of those. I want to delay it as much as I can.
>
> recent messages to the XFree86 mailing lists has the recipe to x-compile
> XFree86, IIRC Keith Packard did the work
>
> > > gcc-3.0 crashes when compiling some parts of Xserver and Xlib,
> > > with very obscure bug. Minimal test case I came up with is
> > > ~45(!) lines long. Keith filed report to gcc team on my behalf,
> > > but there seems to be no responce. I do not know if your
> > > gcc has same problem, but someone mentioned similar problem
> > > with 2.9x.y series on this list not so long ago.
> >
> > Don't bother with gcc-3.0. I won't use it myself for building X.
> >
> >
> > H.J.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjtVChMACgkQtKh84cA8u2nRTACgvPDSNX0E62POj2W+QkntYE9l
pzIAnAjjprS4qWgUfELszqT94T+XGV0C
=tJST
-----END PGP SIGNATURE-----

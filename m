Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fBC0Bir26601
	for linux-mips-outgoing; Tue, 11 Dec 2001 16:11:44 -0800
Received: from nevyn.them.org (mail@NEVYN.RES.CMU.EDU [128.2.145.6])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fBC0Beo26598
	for <linux-mips@oss.sgi.com>; Tue, 11 Dec 2001 16:11:40 -0800
Received: from drow by nevyn.them.org with local (Exim 3.33 #1 (Debian))
	id 16Dw3M-00080e-00; Tue, 11 Dec 2001 18:11:12 -0500
Date: Tue, 11 Dec 2001 18:11:12 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: Ralf Baechle <ralf@oss.sgi.com>
Cc: Ben Elliston <bje@redhat.com>, "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
   "H . J . Lu" <hjl@lucon.org>, linux-mips@oss.sgi.com
Subject: Re: PATCH: Handle Linux/mips (Re: Why is byteorder removed from /proc/cpuinfo?)
Message-ID: <20011211181112.A30778@nevyn.them.org>
References: <Pine.GSO.3.96.1011210211533.24010J-100000@delta.ds2.pg.gda.pl> <Pine.LNX.4.33.0112110939100.17417-100000@hypatia.brisbane.redhat.com> <20011211113008.A30693@dea.linux-mips.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011211113008.A30693@dea.linux-mips.net>
User-Agent: Mutt/1.3.23i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, Dec 11, 2001 at 11:30:08AM -0200, Ralf Baechle wrote:
> On Tue, Dec 11, 2001 at 09:40:50AM +1000, Ben Elliston wrote:
> 
> > > > crosscompilation unlike the /proc/cpuinfo thing and doesn't rely on
> > > > properly installed libraries and headers might possibly of interest for
> > > > building standalone software.
> > 
> > >  Hmm, I don't think config.guess is ever used for cross-compilation as
> > > the script's purpose is to guess the host and you need to specify one
> > > explicitly for a cross-compilation to happen.  Anyway it's saner not
> > > to use build system properties to guess host system ones.
> > 
> > You're close, but not quite correct.  In a cross-compilation environment,
> > the job of config.guess is to determine the type of the build system,
> > which may be different to the host and will certainly be different to the
> > target.
> 
> In case of Linux/MIPS it could guess wether it's a little endian or big
> endian configuration and emit mips-unknown-gnu-linux or
> mipsel-unknown-gnu-linux that is taking away the burden of the user knowing
> about the right endianess for his target - specifying mips-linux as target
> should then be sufficient.  Does that sound sane or would overriding the
> users explicitly give targetname (or even hostname for a native build) be
> considered a bad thing?

Since specifying "mips-linux" is understood to mean big-endian right
now, I'd say yes...

-- 
Daniel Jacobowitz                           Carnegie Mellon University
MontaVista Software                         Debian GNU/Linux Developer

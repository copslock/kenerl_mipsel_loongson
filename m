Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fBB14v524928
	for linux-mips-outgoing; Mon, 10 Dec 2001 17:04:57 -0800
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fBB14po24924;
	Mon, 10 Dec 2001 17:04:51 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id BAA10583;
	Tue, 11 Dec 2001 01:04:33 +0100 (MET)
Date: Tue, 11 Dec 2001 01:04:32 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ben Elliston <bje@redhat.com>
cc: Ralf Baechle <ralf@oss.sgi.com>, "H . J . Lu" <hjl@lucon.org>,
   linux-mips@oss.sgi.com
Subject: Re: PATCH: Handle Linux/mips (Re: Why is byteorder removed from /proc/cpuinfo?)
In-Reply-To: <Pine.LNX.4.33.0112110939100.17417-100000@hypatia.brisbane.redhat.com>
Message-ID: <Pine.GSO.3.96.1011211004658.5181B-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, 11 Dec 2001, Ben Elliston wrote:

> >  Hmm, I don't think config.guess is ever used for cross-compilation as
> > the script's purpose is to guess the host and you need to specify one
> > explicitly for a cross-compilation to happen.  Anyway it's saner not
> > to use build system properties to guess host system ones.
> 
> You're close, but not quite correct.  In a cross-compilation environment,
> the job of config.guess is to determine the type of the build system,

 It actually depends on the autoconf version -- historically it was
backwards.  Still, even if config.guess is used to determine the build
system, the script need not care about the host, so there's no problem
with the cross-compilation (apart from purity).

> which may be different to the host and will certainly be different to the
> target.

 Not necessarily, although unlikely, indeed.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

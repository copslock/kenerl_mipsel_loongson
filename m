Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fBB0fZ123727
	for linux-mips-outgoing; Mon, 10 Dec 2001 16:41:35 -0800
Received: from hypatia.brisbane.redhat.com (lulu.redhat.com.au [202.83.74.3])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fBB0fUo23724;
	Mon, 10 Dec 2001 16:41:30 -0800
Received: from localhost (bje@localhost)
	by hypatia.brisbane.redhat.com (8.11.6/8.11.0) with ESMTP id fBANeoS17820;
	Tue, 11 Dec 2001 09:40:50 +1000
Date: Tue, 11 Dec 2001 09:40:50 +1000 (EST)
From: Ben Elliston <bje@redhat.com>
X-X-Sender:  <bje@hypatia.brisbane.redhat.com>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
cc: Ralf Baechle <ralf@oss.sgi.com>, "H . J . Lu" <hjl@lucon.org>,
   <linux-mips@oss.sgi.com>
Subject: Re: PATCH: Handle Linux/mips (Re: Why is byteorder removed from
 /proc/cpuinfo?)
In-Reply-To: <Pine.GSO.3.96.1011210211533.24010J-100000@delta.ds2.pg.gda.pl>
Message-ID: <Pine.LNX.4.33.0112110939100.17417-100000@hypatia.brisbane.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

> > crosscompilation unlike the /proc/cpuinfo thing and doesn't rely on
> > properly installed libraries and headers might possibly of interest for
> > building standalone software.

>  Hmm, I don't think config.guess is ever used for cross-compilation as
> the script's purpose is to guess the host and you need to specify one
> explicitly for a cross-compilation to happen.  Anyway it's saner not
> to use build system properties to guess host system ones.

You're close, but not quite correct.  In a cross-compilation environment,
the job of config.guess is to determine the type of the build system,
which may be different to the host and will certainly be different to the
target.

Ben

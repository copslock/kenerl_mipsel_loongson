Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6O8OuL24865
	for linux-mips-outgoing; Tue, 24 Jul 2001 01:24:56 -0700
Received: from gandalf.physik.uni-konstanz.de (gandalf.physik.uni-konstanz.de [134.34.144.69])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6O8OcO24855;
	Tue, 24 Jul 2001 01:24:39 -0700
Received: from agx by gandalf.physik.uni-konstanz.de with local (Exim 3.12 #1 (Debian))
	id 15OxUb-0000df-00; Tue, 24 Jul 2001 10:24:37 +0200
Date: Tue, 24 Jul 2001 10:24:37 +0200
From: Guido Guenther <guido.guenther@gmx.net>
To: Ralf Baechle <ralf@oss.sgi.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: Segfaults on r4600
Message-ID: <20010724102436.A1101@gandalf.physik.uni-konstanz.de>
Mail-Followup-To: Ralf Baechle <ralf@oss.sgi.com>, linux-mips@oss.sgi.com
References: <20010723194830.A9033@galadriel.physik.uni-konstanz.de> <20010724052441.A25160@bacchus.dhis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010724052441.A25160@bacchus.dhis.org>; from ralf@oss.sgi.com on Tue, Jul 24, 2001 at 05:24:42AM +0200
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, Jul 24, 2001 at 05:24:42AM +0200, Ralf Baechle wrote:
> On Mon, Jul 23, 2001 at 07:48:30PM +0200, Guido Guenther wrote:
> 
> > I'm seeing various segfaults especially with perl on an R4600 Indy.
> > R4000 I2 with identical debian packages works fine though. I have tried
> > various kernels (cvs head as from two days ago(natively and
> > crosscompiled) and 2.4.3-r4k-ip22 from rfc822.org. Interesting enough
> > the segfaults disappear when using "strace -o/dev/null
> > segfaulting_binary". I also tried to investigate the core file but gdb
> > dies when loading it(gdb is 5.0-3 debian package).
> 
> Strace uses ptrace(2) which does enormous numbers of cache flushes.
> Are those segfault non-deterministic?  Do the perl script you're running
> do alot of I/O?
No extensive I/O and perfectly deterministic. Another interesting fact
is, that some of these scripts fail when executed from a shells script 
but work perfectly well when exactly the same call is typed into a
shell.
 -- Guido

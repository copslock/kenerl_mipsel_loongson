Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6O3OqJ10796
	for linux-mips-outgoing; Mon, 23 Jul 2001 20:24:52 -0700
Received: from dea.waldorf-gmbh.de (u-223-19.karlsruhe.ipdial.viaginterkom.de [62.180.19.223])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6O3OnO10790
	for <linux-mips@oss.sgi.com>; Mon, 23 Jul 2001 20:24:50 -0700
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f6O3Ogl25223;
	Tue, 24 Jul 2001 05:24:42 +0200
Date: Tue, 24 Jul 2001 05:24:42 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: Guido Guenther <guido.guenther@gmx.net>
Cc: linux-mips@oss.sgi.com
Subject: Re: Segfaults on r4600
Message-ID: <20010724052441.A25160@bacchus.dhis.org>
References: <20010723194830.A9033@galadriel.physik.uni-konstanz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010723194830.A9033@galadriel.physik.uni-konstanz.de>; from guido.guenther@gmx.net on Mon, Jul 23, 2001 at 07:48:30PM +0200
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, Jul 23, 2001 at 07:48:30PM +0200, Guido Guenther wrote:

> I'm seeing various segfaults especially with perl on an R4600 Indy.
> R4000 I2 with identical debian packages works fine though. I have tried
> various kernels (cvs head as from two days ago(natively and
> crosscompiled) and 2.4.3-r4k-ip22 from rfc822.org. Interesting enough
> the segfaults disappear when using "strace -o/dev/null
> segfaulting_binary". I also tried to investigate the core file but gdb
> dies when loading it(gdb is 5.0-3 debian package).

Strace uses ptrace(2) which does enormous numbers of cache flushes.
Are those segfault non-deterministic?  Do the perl script you're running
do alot of I/O?

  Ralf

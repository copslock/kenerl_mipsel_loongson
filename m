Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g7GHnnRw029465
	for <linux-mips-outgoing@oss.sgi.com>; Fri, 16 Aug 2002 10:49:49 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g7GHnnGi029464
	for linux-mips-outgoing; Fri, 16 Aug 2002 10:49:49 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from gateway.total-knowledge.com (12-234-207-60.client.attbi.com [12.234.207.60])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g7GHnhRw029455
	for <linux-mips@oss.sgi.com>; Fri, 16 Aug 2002 10:49:44 -0700
Received: (qmail 4511 invoked by uid 502); 16 Aug 2002 17:52:24 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 16 Aug 2002 17:52:24 -0000
Date: Fri, 16 Aug 2002 10:52:18 -0700 (PDT)
From: ilya@theIlya.com
X-X-Sender: ilya@ns2.total-knowledge.com
To: Curtis Robinson <curtis@oushi.org>
cc: linux-mips@oss.sgi.com
Subject: Re: SGI O2 R5000
In-Reply-To: <20020816175837.B2597@linux-mips.org>
Message-ID: <Pine.LNX.4.44.0208161050170.26255-100000@ns2.total-knowledge.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Status: No, hits=-5.9 required=5.0 tests=IN_REP_TO,NO_REAL_NAME,PGP_SIGNATURE version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

And yes, it is possible to run Linux on O2. Look at
http://www.linux-mips.org/~glaurung for pre-built kernels. There was also
Linux-O2 HOWTO posted to the list recently, which you should read. I don't
think it made to any of Linux/MIPS websites yet :(

On Fri, 16 Aug 2002, Ralf Baechle wrote:

> On Fri, Aug 16, 2002 at 11:21:12AM -0500, Curtis Robinson wrote:
>
> > I know this question is probably asked alot.
> > I tried looking at some of the mailing list archives.
> > I wanted to know if it is possible to install Linux on SGI 02 R5000's
> > I noticed there was support for R5000s, but not for R5000 that had CPU-controlled secondary
> > cache.  I couldnt figure out how to find out if the 02 I have is one or the other.
>
> O2 uses the builtin cache controller which people are currently adding
> support for.
>
>   Ralf
>
>
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)
Comment: pgpenvelope 2.9.0 - http://pgpenvelope.sourceforge.net/

iD8DBQE9XTvY84S94bALfyURAnbzAJ9kXymejTkims1SQOS+gJwiWIL3hgCgzcc7
y/M6NJMxqU1Lo7ElbhUU9o8=
=RDaZ
-----END PGP SIGNATURE-----

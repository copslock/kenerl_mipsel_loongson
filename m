Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g250Zl604988
	for linux-mips-outgoing; Mon, 4 Mar 2002 16:35:47 -0800
Received: from idiom.com (espin@idiom.com [216.240.32.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g250Zh904982;
	Mon, 4 Mar 2002 16:35:44 -0800
Received: (from espin@localhost)
	by idiom.com (8.9.3/8.9.3) id PAA40038;
	Mon, 4 Mar 2002 15:35:42 -0800 (PST)
Date: Mon, 4 Mar 2002 15:35:42 -0800
From: Geoffrey Espin <espin@idiom.com>
To: William Jhun <wjhun@ayrnetworks.com>
Cc: Jun Sun <jsun@mvista.com>, Ralf Baechle <ralf@oss.sgi.com>,
   linux-mips@oss.sgi.com
Subject: Re: Compressed images?
Message-ID: <20020304153542.B31050@idiom.com>
References: <20020304120803.A1247@ayrnetworks.com> <20020304145709.A1332@oss.sgi.com> <3C83FA43.4090407@mvista.com> <20020304150334.D1247@ayrnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.1i
In-Reply-To: <20020304150334.D1247@ayrnetworks.com>; from William Jhun on Mon, Mar 04, 2002 at 03:03:34PM -0800
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

> But this is a good point. Our own compressed/ build requires building
> several elf-header-mangling tools just to get our bootstrap (which we
> can't change) to even recognize the finished image.
> Though, I'm not sure how much the different decompression (misc.c)
> routines vary; could there be some way to do this in a
> platform-independent way?

Pete Popov's mips/zboot is probably the most generic for MIPS,
though, it only was done for Alchemy's.  See:

    http://cvs.sourceforge.net/cgi-bin/viewcvs.cgi/linux-mips/linux/arch/mips/zboot/


[I re-ported it to Korva and reduced much of the extraneous fluff
(both extra misc- source files and unneeded utils/), but its
never been checked into CVS.]

Geoff
--
Geoffrey Espin
espin@idiom.com
--

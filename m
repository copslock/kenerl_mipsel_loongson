Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0UJeaU18481
	for linux-mips-outgoing; Wed, 30 Jan 2002 11:40:36 -0800
Received: from idiom.com (espin@idiom.com [216.240.32.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0UJeYd18477
	for <linux-mips@oss.sgi.com>; Wed, 30 Jan 2002 11:40:34 -0800
Received: (from espin@localhost)
	by idiom.com (8.9.3/8.9.3) id KAA51552;
	Wed, 30 Jan 2002 10:39:19 -0800 (PST)
Date: Wed, 30 Jan 2002 10:39:19 -0800
From: Geoffrey Espin <espin@idiom.com>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: "Steven J. Hill" <sjhill@cotw.com>, linux-mips@oss.sgi.com
Subject: Re: [PATCH] Compiler warnings and remove unused code....
Message-ID: <20020130103919.A49140@idiom.com>
References: <20020130102340.A37609@idiom.com> <Pine.GSO.3.96.1020130193233.8443D-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.1i
In-Reply-To: <Pine.GSO.3.96.1020130193233.8443D-100000@delta.ds2.pg.gda.pl>; from Maciej W. Rozycki on Wed, Jan 30, 2002 at 07:35:13PM +0100
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Maciej,

> > This is linux.2.4.16 + sourceforge/mipslinux (a few weeks old).
>  These errors are not MIPS-specific.  They were introduced by a stricter
> symbol checking in recent binutils.  Many of them (but possibly not all)
> are removed in Linux 2.4.17.  Please try the current version and see if
> they persist.

Thanks!  Thought so. I was afraid of that.  :-)
[Not sure if/when I'll move up again.]

Steve: you might want to add that caveat to your toolchain announcement.

Geoff
-- 
espin@idiom.com

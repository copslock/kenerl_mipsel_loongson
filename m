Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0UJs4o19926
	for linux-mips-outgoing; Wed, 30 Jan 2002 11:54:04 -0800
Received: from idiom.com (espin@idiom.com [216.240.32.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0UJs1d19922
	for <linux-mips@oss.sgi.com>; Wed, 30 Jan 2002 11:54:01 -0800
Received: (from espin@localhost)
	by idiom.com (8.9.3/8.9.3) id KAA60344;
	Wed, 30 Jan 2002 10:53:50 -0800 (PST)
Date: Wed, 30 Jan 2002 10:53:50 -0800
From: Geoffrey Espin <espin@idiom.com>
To: Daniel Jacobowitz <dan@debian.org>
Cc: "Steven J. Hill" <sjhill@cotw.com>, linux-mips@oss.sgi.com
Subject: Re: [PATCH] Compiler warnings and remove unused code....
Message-ID: <20020130105350.C49140@idiom.com>
References: <3C582D6E.F86FBFE7@cotw.com> <20020130102340.A37609@idiom.com> <20020130134129.A31924@nevyn.them.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.1i
In-Reply-To: <20020130134129.A31924@nevyn.them.org>; from Daniel Jacobowitz on Wed, Jan 30, 2002 at 01:41:29PM -0500
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


> These were fixed in the kernel.org tree around 2.4.17 (maybe 2.4.18pre
> for a few of them, too).
> If you just want to work around it you can comment out the /DISCARD/ {}
> block in arch/mips/ld.script.
>   Daniel Jacobowitz                           Carnegie Mellon University

That worked great!      [comment out DISCARD section in ld.script.in]

> I think --noinhibit-exec worked for me as a temporary measure until I
> upgraded the kernel.
> Brad LaRonde

I'll just give you a smiley for that suggestion:   :-) 
Sure, it probably works.

Thanks all!

Geoff
-- 
espin@idiom.com

Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1MFVxU12496
	for linux-mips-outgoing; Fri, 22 Feb 2002 07:31:59 -0800
Received: from delta.ds2.pg.gda.pl (delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1MFVg912489
	for <linux-mips@oss.sgi.com>; Fri, 22 Feb 2002 07:31:43 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id PAA08463;
	Fri, 22 Feb 2002 15:28:58 +0100 (MET)
Date: Fri, 22 Feb 2002 15:28:57 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Hiroyuki Machida <machida@sm.sony.co.jp>
cc: hjl@lucon.org, wgowcher@yahoo.com, linux-mips@oss.sgi.com
Subject: Re: pthread support in mipsel-linux
In-Reply-To: <20020222.224522.80690047.machida@sm.sony.co.jp>
Message-ID: <Pine.GSO.3.96.1020222152633.5266F-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, 22 Feb 2002, Hiroyuki Machida wrote:

> >  What's wrong with -mips1 currently?  It used to be OK around glibc 2.2 --
> > has anything changed since then that needs -mips1 to be fixed?
> 
> Functions such as compre_and_swap() in sysdeps/mips/atomicity.h are
> not atmoic with -mips1 option.

 They used not to be used for threads -- has it changed recently?  It
would make threads non-operational on the i386 as well, yet it doesn't
seem to be the case. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

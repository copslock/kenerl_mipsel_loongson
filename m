Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1MEeZT11373
	for linux-mips-outgoing; Fri, 22 Feb 2002 06:40:35 -0800
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1MEeR911370
	for <linux-mips@oss.sgi.com>; Fri, 22 Feb 2002 06:40:28 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id OAA07299;
	Fri, 22 Feb 2002 14:38:53 +0100 (MET)
Date: Fri, 22 Feb 2002 14:38:53 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: "H . J . Lu" <hjl@lucon.org>
cc: Wayne Gowcher <wgowcher@yahoo.com>, Linux-MIPS <linux-mips@oss.sgi.com>
Subject: Re: pthread support in mipsel-linux
In-Reply-To: <20020221102503.A28936@lucon.org>
Message-ID: <Pine.GSO.3.96.1020222143540.5266C-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, 21 Feb 2002, H . J . Lu wrote:

> > Just to clarify, the glibc rpm in your Redhat 7.1 is
> > compiled with -mips1 right ? So as it is broken yes ?
> 
> Yes. -mips1 doesn't work well with thread.

 What's wrong with -mips1 currently?  It used to be OK around glibc 2.2 --
has anything changed since then that needs -mips1 to be fixed?

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

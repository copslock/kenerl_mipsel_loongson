Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0VDkNI16403
	for linux-mips-outgoing; Thu, 31 Jan 2002 05:46:23 -0800
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0VDk9d16392
	for <linux-mips@oss.sgi.com>; Thu, 31 Jan 2002 05:46:10 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id NAA09623;
	Thu, 31 Jan 2002 13:45:32 +0100 (MET)
Date: Thu, 31 Jan 2002 13:45:32 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: "Steven J. Hill" <sjhill@cotw.com>
cc: linux-mips@oss.sgi.com, ralf@uni-koblenz.de
Subject: Re: [PATCH] Compiler warnings and remove unused code....
In-Reply-To: <3C5845CF.A61BF774@cotw.com>
Message-ID: <Pine.GSO.3.96.1020131133418.5578B-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, 30 Jan 2002, Steven J. Hill wrote:

> > > --- drivers/pci/pci.ids       3 Jan 2002 17:20:28 -0000       1.3
> > > +++ drivers/pci/pci.ids       30 Jan 2002 17:20:50 -0000
> > 
> >  Are you sure it belongs here?  Or is needed at all?
> > 
> What happens is that when 'gendev' is ran to produce devlist.h, without
> the patch it spits on '??? trigraph' warnings. By escaping them, the
> warning disappears.

 You should fix drivers/pci/gen-devlist.c, then (pci.ids is maintained
externally and is meant to be a plain text file -- see
http://pciids.sourceforge.net/) and submit changes to the author and,
possibly, linux-kernel.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

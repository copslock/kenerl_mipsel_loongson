Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f7NFvwH30391
	for linux-mips-outgoing; Thu, 23 Aug 2001 08:57:58 -0700
Received: from delta.ds2.pg.gda.pl (delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f7NFvqd30388
	for <linux-mips@oss.sgi.com>; Thu, 23 Aug 2001 08:57:52 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id RAA22926;
	Thu, 23 Aug 2001 17:59:51 +0200 (MET DST)
Date: Thu, 23 Aug 2001 17:59:51 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: "Gleb O. Raiko" <raiko@niisi.msk.ru>
cc: linux-mips@fnet.fr, linux-mips@oss.sgi.com
Subject: Re: [patch] linux 2.4.5: Export mips_machtype
In-Reply-To: <3B84EB2C.7643F00B@niisi.msk.ru>
Message-ID: <Pine.GSO.3.96.1010823174707.21718F-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, 23 Aug 2001, Gleb O. Raiko wrote:

> In order to read a PCI ID, you need to know how to do it. In pc world,
> you may rely on configuation access types, at least, ports are known. On
> other arches, you need to know where such "ports" are. Even if hardware
> supports, say, configuration type 1 accesses, developers are free to put
> port addresses anywhere.

 Yep, I see.  MIPS is quite special here, because, unlike for Alphas,
PowerPCs, SPARCs, etc. there is a couple of independend vendors making
systems, so there is no single way of obtaining a system ID.  So you need
to know how to access chipset from elsewhere.

> >  How do you set up mips_machtype on your system in the first place?  At
> > kernel_entry the code does not know what machine it's running on anyway,
> > so it has to set mips_machtype based on a detection algorithm.
> 
> First, mips_machtype is accessed far later than kernel_entry is

 That's quite obvious -- nothing can be done in Linux earlier. ;-)  But
you need to initialize mips_machtype somehow.

> executed. Personally, I am lucky :-), I may read firmware environment
> variables.

 Well, other system might as well (e.g. DECstations can), but that doesn't
solve the problem -- to access firmware variables you need to know which
kind of firmware you are on. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

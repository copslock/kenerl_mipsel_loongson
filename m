Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g11D2iV01606
	for linux-mips-outgoing; Fri, 1 Feb 2002 05:02:44 -0800
Received: from delta.ds2.pg.gda.pl (delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g11D2ed01603
	for <linux-mips@oss.sgi.com>; Fri, 1 Feb 2002 05:02:40 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id NAA27210;
	Fri, 1 Feb 2002 13:01:57 +0100 (MET)
Date: Fri, 1 Feb 2002 13:01:57 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Jason Gunthorpe <jgg@debian.org>
cc: linux-mips@fnet.fr, linux-mips@oss.sgi.com
Subject: Re: [patch] linux 2.4.17: An mb() rework
In-Reply-To: <Pine.LNX.3.96.1020131180511.14195A-100000@wakko.deltatee.com>
Message-ID: <Pine.GSO.3.96.1020201125608.26449C-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, 31 Jan 2002, Jason Gunthorpe wrote:

> I'm afraid I don't have any manuals for any of the MIPS chips just 3rd
> party ones SB1, RM7K and SR71000 - which is why I have some many
> odd questions. :>

 Please feel free to grab a few from 'http://www.mips.com/Documentation/'
and 'http://www.mips.com/declassified/'. ;-)  I have a few excellent IDT
manuals on their original CD-ROM as well.  If they can't be downloaded
anymore, I may put them online at my site. 

> Did some more research + phoning.. RM7K is definately documented to dump
> the write buffer on 'sync'. The RM7K guide even has an example (7.8.5)
> where it implies that sync also forces a write back of any dirty cache
> lines - gah! (Hard to belive though..)

 If RM7K is always strongly ordered, I may code a workaround.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

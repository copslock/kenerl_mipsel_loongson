Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f7A8wUT06121
	for linux-mips-outgoing; Fri, 10 Aug 2001 01:58:30 -0700
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f7A8wQV06118
	for <linux-mips@oss.sgi.com>; Fri, 10 Aug 2001 01:58:27 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id LAA03733;
	Fri, 10 Aug 2001 11:00:41 +0200 (MET DST)
Date: Fri, 10 Aug 2001 11:00:40 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Jan-Benedict Glaw <jbglaw@lug-owl.de>
cc: linux-mips@oss.sgi.com
Subject: Re: Problem with PMAD-AA / DECStation 5000/200
In-Reply-To: <20010809183552.B25724@lug-owl.de>
Message-ID: <Pine.GSO.3.96.1010810105208.2724E-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, 9 Aug 2001, Jan-Benedict Glaw wrote:

> I'm not that sure. Does there always exist a "clean" PROM? For
> example, I'm searching for a tftp/bootp enabled PROM for a
> DEC 5000/240 (or was it /200?). Does anybody have sth like this?

 Look at 'http://www.netbsd.org/Ports/pmax/board-list.html'.  They list MB
ROMs only, though.  Note that certain options (FDDI controllers) have a
Flash ROM that is soldered to the PCB, so they can only be updated via
appropriate software. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

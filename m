Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f42ED9K05606
	for linux-mips-outgoing; Wed, 2 May 2001 07:13:09 -0700
Received: from delta.ds2.pg.gda.pl (delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f42ECSF05593;
	Wed, 2 May 2001 07:12:42 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id QAA26564;
	Wed, 2 May 2001 16:12:13 +0200 (MET DST)
Date: Wed, 2 May 2001 16:12:13 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ralf Baechle <ralf@oss.sgi.com>
cc: Jun Sun <jsun@mvista.com>, Ian Soanes <ians@lineo.com>,
   Michael Shmulevich <michaels@jungo.com>,
   Linux/MIPS <linux-mips@oss.sgi.com>
Subject: Re: usermode gdb / remote gdb
In-Reply-To: <20010426010457.A11453@bacchus.dhis.org>
Message-ID: <Pine.GSO.3.96.1010502160653.26258B-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, 26 Apr 2001, Ralf Baechle wrote:

> > Hmm, I added linux-mips target for gdbserver in gdb 4.17.  And I thought Ralf
> > sent the patch back to FSF (as I had to fill out some copyright forms). 
> > Perhaps it is lost somewhere?
> 
> As most of the 4.17 work was done by David Miller it's not upto me to
> contribute the patches back.

 I have ported 4.17 changes to 5.0.  They are available at my FTP site.  I
have submitted changes I wrote myself to the gdb team.  I have submitting
other changes on my to-do list -- it requires checking the changes against
the current CVS version and contacting all interested parties.  As I lack
time at the moment I cannot promise I'll do it in the foreseeable future.
If anyone wants to do it -- feel free. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6MDeFRw023623
	for <linux-mips-outgoing@oss.sgi.com>; Mon, 22 Jul 2002 06:40:15 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6MDeFdY023622
	for linux-mips-outgoing; Mon, 22 Jul 2002 06:40:15 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6MDeBRw023613
	for <linux-mips@oss.sgi.com>; Mon, 22 Jul 2002 06:40:11 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id PAA05050;
	Mon, 22 Jul 2002 15:41:30 +0200 (MET DST)
Date: Mon, 22 Jul 2002 15:41:29 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Jun Sun <jsun@mvista.com>
cc: linux-mips@oss.sgi.com, Ralf Baechle <ralf@uni-koblenz.de>
Subject: Re: [PATCH]  Let Malta and its friends use common timer interrupt code
In-Reply-To: <3D388136.2050502@mvista.com>
Message-ID: <Pine.GSO.3.96.1020722153902.2373D-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, 19 Jul 2002, Jun Sun wrote:

> This patch let Malta and other MIPS boards use the common timer interrupt 
> code.  Not only it reduces maintainance, but also it lets Malta benefit from 
> common improvement (such as Preemptible kernel).

 Hmm, as a side note, it's actually questionable whether a kernel
preemption is an improvement or not. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

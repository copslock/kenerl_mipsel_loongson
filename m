Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g5RBlGnC014271
	for <linux-mips-outgoing@oss.sgi.com>; Thu, 27 Jun 2002 04:47:16 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g5RBlGoN014270
	for linux-mips-outgoing; Thu, 27 Jun 2002 04:47:16 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g5RBlBnC014264
	for <linux-mips@oss.sgi.com>; Thu, 27 Jun 2002 04:47:12 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id NAA21929;
	Thu, 27 Jun 2002 13:51:05 +0200 (MET DST)
Date: Thu, 27 Jun 2002 13:51:05 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Jun Sun <jsun@mvista.com>
cc: Ladislav Michl <ladis@psi.cz>, Ralf Baechle <ralf@uni-koblenz.de>,
   linux-mips@oss.sgi.com
Subject: Re: [patch] linux: DBE/IBE handling rewrite
In-Reply-To: <3D19F728.7020903@mvista.com>
Message-ID: <Pine.GSO.3.96.1020627132824.21496A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, 26 Jun 2002, Jun Sun wrote:

> I suggest we have a function pointer called board_bus_error_init, which is 
> initialized to a NULL function.  Any board that wishes to override it can do 
> so in <board>_setup() routine.

 I thought about it (even started coding, but postponed the task), but I
didn't want to complicate things at the first approach.  Especially as
multiple-system support doesn't exist now and bits were already done this
way.  Feel free to improve the code -- I will look at it again when I am
writing a handler for DECstations, but I can't state exactly when, yet.

> With more amd more MIPS boards poping up, the more friendly board interface is 
> the better.

 I was thinking of the system identification problem today morning and I
believe I know how to detect a DECstation reliably. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

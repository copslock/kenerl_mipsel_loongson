Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g5JFDHnC026556
	for <linux-mips-outgoing@oss.sgi.com>; Wed, 19 Jun 2002 08:13:17 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g5JFDHV9026555
	for linux-mips-outgoing; Wed, 19 Jun 2002 08:13:17 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g5JFDDnC026551
	for <linux-mips@oss.sgi.com>; Wed, 19 Jun 2002 08:13:14 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id RAA22879;
	Wed, 19 Jun 2002 17:16:37 +0200 (MET DST)
Date: Wed, 19 Jun 2002 17:16:37 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Justin Carlson <justin@cs.cmu.edu>
cc: linux-mips@oss.sgi.com
Subject: Re: reenabling interrupts on return from function
In-Reply-To: <1024179748.1549.12.camel@localhost.localdomain>
Message-ID: <Pine.GSO.3.96.1020619171416.15094N-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On 15 Jun 2002, Justin Carlson wrote:

> However, I still don't see the point of the above code.  Why do we
> explicitly clear bits 4-0 of the status register just before reloading
> it from the system stack?  

 Not to receive an interrupt in the middle of register restoration.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

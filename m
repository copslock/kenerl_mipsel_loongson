Received: from oss.sgi.com (localhost.localdomain [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g3ADVc8d020563
	for <linux-mips-outgoing@oss.sgi.com>; Wed, 10 Apr 2002 06:31:38 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g3ADVXnw020509
	for linux-mips-outgoing; Wed, 10 Apr 2002 06:31:33 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g3ADVL8d020401
	for <linux-mips@oss.sgi.com>; Wed, 10 Apr 2002 06:31:24 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id PAA06262;
	Wed, 10 Apr 2002 15:31:08 +0200 (MET DST)
Date: Wed, 10 Apr 2002 15:31:07 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Jun Sun <jsun@mvista.com>
cc: Ralf Baechle <ralf@uni-koblenz.de>, linux-mips@fnet.fr,
   linux-mips@oss.sgi.com
Subject: Re: [patch] linux: New style IRQs for DECstation
In-Reply-To: <3CB32694.1010503@mvista.com>
Message-ID: <Pine.GSO.3.96.1020410150951.3644D-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, 9 Apr 2002, Jun Sun wrote:

> How about "there will be likely no such CPUs/systems in the future"?

 Does it mean code needs to be dirty?  There is no performance hit for new
CPUs and the code bloat is minimal and even that is discarded after boot.

> Your patch will force every new CPU to add FPUEX option to the cpu_option, 
> where apparently no place really need to use it.

 Well, I agree to some extent here.  I may negate the flag, so it's not
needed for most CPUs.

> Leaving FPU exception enabled for a CPU that does not generate FPU exception 
> is acceptable. (because it does *not* generate FPU exceptions).  And hooking 

 You never know.  You may get one due to a hardware fault.  It's better to
trap it and panic then, than to try to pretend nothing special happened.

> up/dispatching the FPU exception interrupt is system-specific already anyway.

 But pretty generic -- you just need to grab the right IRQ line.  See the
top of decstation_handle_int in arch/mips/dec/int-handler.S -- nothing
system-specific until after the FPU path branch.  You may cut and paste it
for any other system.

> It, however, makes sense to provide a common wrapper code for fpu interrupt to 
> jump to fpu exception handling code.

 No additional code is actually generated -- only a label for a second
entry point is added.

> Over-abstraction can make the picture cloudy rather than clear.  My 2 cents.

 I appreciate your point of view.  You haven't convinced me, though. 
Apart from the negation of MIPS_CPU_FPUEX, which sounds reasonable indeed. 

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

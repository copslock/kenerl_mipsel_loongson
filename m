Received: from oss.sgi.com (localhost.localdomain [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g3CI4s8d017172
	for <linux-mips-outgoing@oss.sgi.com>; Fri, 12 Apr 2002 11:04:54 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g3CI4s5u017171
	for linux-mips-outgoing; Fri, 12 Apr 2002 11:04:54 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g3CI4o8d017162
	for <linux-mips@oss.sgi.com>; Fri, 12 Apr 2002 11:04:51 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id UAA16892;
	Fri, 12 Apr 2002 20:05:43 +0200 (MET DST)
Date: Fri, 12 Apr 2002 20:05:43 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: "Bradley D. LaRonde" <brad@ltc.com>
cc: "MIPS/Linux List (SGI)" <linux-mips@oss.sgi.com>
Subject: Re: Can modules be stripped?
In-Reply-To: <00e601c1e24a$4d7bc9a0$4c00a8c0@prefect>
Message-ID: <Pine.GSO.3.96.1020412195812.14896B-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, 12 Apr 2002, Bradley D. LaRonde wrote:

> OK, you can't strip kernel modules (news to me, then again how often do I
> use modules?), but it can't be because they "are relocatables".  I routinely
> strip libraries without problem, and those are relocatables too.

 What kind of libraries?  Shared libraries are shared objects and not
relocatables.  Static libraries ("ar" archives), OTOH, are sets of
relocatables as is e.g. /usr/lib/crt1.o and any assembler output.  The
rule is a relocatable is any object that has unresolved static
relocations, i.e. has not undergone final linking.  If unsure check with
file(1). 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

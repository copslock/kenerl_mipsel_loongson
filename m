Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1MIMoe16951
	for linux-mips-outgoing; Fri, 22 Feb 2002 10:22:50 -0800
Received: from delta.ds2.pg.gda.pl (root@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1MILR916944
	for <linux-mips@oss.sgi.com>; Fri, 22 Feb 2002 10:21:27 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id SAA11973;
	Fri, 22 Feb 2002 18:06:58 +0100 (MET)
Date: Fri, 22 Feb 2002 18:06:58 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: "H . J . Lu" <hjl@lucon.org>
cc: Wayne Gowcher <wgowcher@yahoo.com>, Linux-MIPS <linux-mips@oss.sgi.com>
Subject: Re: pthread support in mipsel-linux
In-Reply-To: <20020222085310.A17035@lucon.org>
Message-ID: <Pine.GSO.3.96.1020222175750.5266G-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, 22 Feb 2002, H . J . Lu wrote:

> Mutex is now implemented with spin lock by default. BTW, how many

 Well, testandset() from linuxthreads/sysdeps/mips/pt-machine.h should
work fine with -mips1.  As should __pthread_spin_lock() from
linuxthreads/sysdeps/mips/pspinlock.c. 

> people have run "make check" on glibc compiled -mips1?

 No idea.  I may run `./configure && make all && make check' tonight on my
system as it's going to be idle over the weekend anyway.  It should finish
by Monday. ;-) 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

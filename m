Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0LEisu27988
	for linux-mips-outgoing; Mon, 21 Jan 2002 06:44:54 -0800
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0LEioP27984
	for <linux-mips@oss.sgi.com>; Mon, 21 Jan 2002 06:44:51 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id OAA24201;
	Mon, 21 Jan 2002 14:43:51 +0100 (MET)
Date: Mon, 21 Jan 2002 14:43:51 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Reply-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: "H . J . Lu" <hjl@lucon.org>
cc: "Kevin D. Kissell" <kevink@mips.com>,
   Machida Hiroyuki <machida@sm.sony.co.jp>, drepper@redhat.com,
   GNU C Library <libc-alpha@sources.redhat.com>, linux-mips@oss.sgi.com
Subject: Re: thread-ready ABIs
In-Reply-To: <20020120111912.A6918@lucon.org>
Message-ID: <Pine.GSO.3.96.1020121143105.22392B-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Sun, 20 Jan 2002, H . J . Lu wrote:

> As I understand, we don't need k1 based semaphore for MIPS II or above.
> So many processors can still benefit from the thread register. We can
> use a system call to implement loading a thread register. So it is
> a trade off between system-call/k1 for thread-register/semaphore. We
> can make it a configure time option. Since PS2 is already using k1 for
> semaphore, I'd like to see it get merged in ASAP so that anything we
> do won't break PS2.

 I believe we need not trade anything off if we split k1 into two parts. 
We could use e.g. the 31 MSBs for the thread register and the LSB for the
ll/sc equivalent.  Other splits are possible if the ll/sc emulation needs
more bits. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

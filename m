Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0VNHp712516
	for linux-mips-outgoing; Thu, 31 Jan 2002 15:17:51 -0800
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0VNHld12513
	for <linux-mips@oss.sgi.com>; Thu, 31 Jan 2002 15:17:47 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id XAA09643;
	Thu, 31 Jan 2002 23:17:22 +0100 (MET)
Date: Thu, 31 Jan 2002 23:17:21 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: "H . J . Lu" <hjl@lucon.org>
cc: GNU C Library <libc-alpha@sources.redhat.com>, linux-mips@oss.sgi.com
Subject: Re: PATCH: Fix ll/sc for mips
In-Reply-To: <20020131123547.A22759@lucon.org>
Message-ID: <Pine.GSO.3.96.1020131230104.9069A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, 31 Jan 2002, H . J . Lu wrote:

> 	(__compare_and_swap): Return 0 when failed to compare or swap.
[...]
> 	* sysdeps/mips/atomicity.h (compare_and_swap): Return 0 when
> 	failed to compare or swap.

 Looking at the i486 implementation these are not expected to fail. 
Unless I am missing something... 

> 	* sysdeps/unix/sysv/linux/mips/sys/tas.h (_test_and_set): Fill
> 	the delay slot.

 What's the difference?  The code looks the same after changes.  Also you
forgot to indent instructions in delay slots, which worsens readability. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

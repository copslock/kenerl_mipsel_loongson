Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g18C5JM29185
	for linux-mips-outgoing; Fri, 8 Feb 2002 04:05:19 -0800
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g18C5DA29182
	for <linux-mips@oss.sgi.com>; Fri, 8 Feb 2002 04:05:13 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id NAA09027;
	Fri, 8 Feb 2002 13:03:41 +0100 (MET)
Date: Fri, 8 Feb 2002 13:03:40 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Andreas Jaeger <aj@suse.de>
cc: "H . J . Lu" <hjl@lucon.org>, linux-mips@oss.sgi.com,
   GNU C Library <libc-alpha@sources.redhat.com>
Subject: Re: PATCH: Not use branch likely on mips
In-Reply-To: <hou1sswghp.fsf@gee.suse.de>
Message-ID: <Pine.GSO.3.96.1020208125705.8526A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, 8 Feb 2002, Andreas Jaeger wrote:

> > Here is a new patch. I have checked in a gcc patch which makes
> > ".set noreorder" unnecessary even with "gcc -g".
> 
> But what about current GCC releases?  Does it work there also without
> problems?

 At worst you lose a few cycles for superfluous nops.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

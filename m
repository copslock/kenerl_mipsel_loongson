Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1LFOa127781
	for linux-mips-outgoing; Thu, 21 Feb 2002 07:24:36 -0800
Received: from delta.ds2.pg.gda.pl (delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1LFOU927699
	for <linux-mips@oss.sgi.com>; Thu, 21 Feb 2002 07:24:31 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id PAA08638;
	Thu, 21 Feb 2002 15:19:26 +0100 (MET)
Date: Thu, 21 Feb 2002 15:19:25 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Atsushi Nemoto <nemoto@toshiba-tops.co.jp>
cc: jgg@debian.org, kevink@mips.com, linux-mips@fnet.fr,
   linux-mips@oss.sgi.com
Subject: Re: [patch] linux 2.4.17: The second mb() rework (final)
In-Reply-To: <20020221.210052.38718643.nemoto@toshiba-tops.co.jp>
Message-ID: <Pine.GSO.3.96.1020221151304.1033H-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, 21 Feb 2002, Atsushi Nemoto wrote:

> As I wrote in another mail, TX39's uncached load does NOT return data
> from a write buffer.  Uncached load/store always appears on I/O bus in
> same order.

 Well, the specification suggests that a load doesn't stall until all data
from the buffer are written back.  Therefore a load will appear on the
host bus before pending writes.  It implies mb() has to stall on the
"buffer not empty" condition.

> The problem of TX39's write buffer is that cached load/store operation
> can overtake preceding uncached store operation (even if "SYNC" was
> exist between these operations).

 It's implied by the above.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

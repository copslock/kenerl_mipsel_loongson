Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f36HrHk02965
	for linux-mips-outgoing; Fri, 6 Apr 2001 10:53:17 -0700
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f36Hq7M02952
	for <linux-mips@oss.sgi.com>; Fri, 6 Apr 2001 10:52:36 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id SAA19118;
	Fri, 6 Apr 2001 18:48:42 +0200 (MET DST)
Date: Fri, 6 Apr 2001 18:48:42 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Florian Lohoff <flo@rfc822.org>
cc: "Kevin D. Kissell" <kevink@mips.com>, debian-mips@lists.debian.org,
   linux-mips@oss.sgi.com
Subject: Re: first packages for mipsel
In-Reply-To: <20010406152836.A21459@paradigm.rfc822.org>
Message-ID: <Pine.GSO.3.96.1010406184110.15958F-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, 6 Apr 2001, Florian Lohoff wrote:

> For SMP versions we could currently just put an "#error" in it. There has
> to be machine dependent support as the older SGI Challenge have. So dont
> worry on that case.

 Yep, DS5800 provides hw for atomic ops as well -- a write to a specific
location makes the next memory read and write cycle atomic.

 The kernel may choose whatever way is needed for particular hw (if we
ever support it).

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f5EBNiK04664
	for linux-mips-outgoing; Thu, 14 Jun 2001 04:23:44 -0700
Received: from delta.ds2.pg.gda.pl (delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f5EBFUP03570
	for <linux-mips@oss.sgi.com>; Thu, 14 Jun 2001 04:16:14 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id MAA20236;
	Thu, 14 Jun 2001 12:26:59 +0200 (MET DST)
Date: Thu, 14 Jun 2001 12:26:58 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Harald Koerfgen <hkoerfg@web.de>
cc: Jun Sun <jsun@mvista.com>, "H . J . Lu" <hjl@lucon.org>,
   linux-mips@oss.sgi.com
Subject: Re: A new mips toolchain is available
In-Reply-To: <01061322550001.00617@intel>
Message-ID: <Pine.GSO.3.96.1010614122558.20194A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, 13 Jun 2001, Harald Koerfgen wrote:

> Anyway, the linux-vr source tree has a partially working ll/sc emulation, at 
> least enough for glibc, and MIPS_ATOMIC_SET is not neccessarily needed.
> In fact, MIPS_ATOMIC_SET has been removed from the vr tree.

 I suppose we may remove it, too, once we agree on a sane replacement.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f339scW28756
	for linux-mips-outgoing; Tue, 3 Apr 2001 02:54:38 -0700
Received: from delta.ds2.pg.gda.pl (delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f339sJM28709;
	Tue, 3 Apr 2001 02:54:21 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id LAA25830;
	Tue, 3 Apr 2001 11:26:12 +0200 (MET DST)
Date: Tue, 3 Apr 2001 11:26:11 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Florian Lohoff <flo@rfc822.org>
cc: "Kevin D. Kissell" <kevink@mips.com>, Ralf Baechle <ralf@oss.sgi.com>,
   "MIPS/Linux List (SGI)" <linux-mips@oss.sgi.com>
Subject: Re: Dumb Question on Cross-Development
In-Reply-To: <20010402234850.B25228@paradigm.rfc822.org>
Message-ID: <Pine.GSO.3.96.1010403112218.25523B-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, 2 Apr 2001, Florian Lohoff wrote:

> Cross-compilation is IMHO so broken when it comes to userspace
> than noone really thinking of having something reusable would
> consider this. It all ends beeing a really ugly hack.

 I disagree.  It's not that userland cross-compilation is broken.  It's
just the matter of certain programmers who do not care to write
scripts/Makefiles to support cross-development portably.  They might even
not realize there exists such a feature as cross-compilation. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

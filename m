Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g11Mfvs19769
	for linux-mips-outgoing; Fri, 1 Feb 2002 14:41:57 -0800
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g11Mfsd19761
	for <linux-mips@oss.sgi.com>; Fri, 1 Feb 2002 14:41:54 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id WAA10068;
	Fri, 1 Feb 2002 22:41:17 +0100 (MET)
Date: Fri, 1 Feb 2002 22:41:17 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: "H . J . Lu" <hjl@lucon.org>
cc: Hiroyuki Machida <machida@sm.sony.co.jp>, libc-alpha@sources.redhat.com,
   linux-mips@oss.sgi.com
Subject: Re: PATCH: Fix ll/sc for mips
In-Reply-To: <20020201094025.A10392@lucon.org>
Message-ID: <Pine.GSO.3.96.1020201223721.9982A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, 1 Feb 2002, H . J . Lu wrote:

> Here is the updated patch.

 Please do indent instructions in branch delay slots like it's done in
other code (and here originally as well).  It much improves the perception
of what exactly is going on. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g5O8QjnC021942
	for <linux-mips-outgoing@oss.sgi.com>; Mon, 24 Jun 2002 01:26:45 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g5O8Qjen021941
	for linux-mips-outgoing; Mon, 24 Jun 2002 01:26:45 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g5O8QfnC021938
	for <linux-mips@oss.sgi.com>; Mon, 24 Jun 2002 01:26:42 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id KAA23941;
	Mon, 24 Jun 2002 10:30:23 +0200 (MET DST)
Date: Mon, 24 Jun 2002 10:30:22 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Guido Guenther <agx@sigxcpu.org>
cc: linux-mips@oss.sgi.com
Subject: Re: 2.4.18: pgtable.h compile fix
In-Reply-To: <20020623125811.GA24851@bogon.ms20.nix>
Message-ID: <Pine.GSO.3.96.1020624102402.22509D-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Sun, 23 Jun 2002, Guido Guenther wrote:

> Is there a reason why the "_LANGUAGE_ASSEMBLY" ifdefs were removed?
> Mips64 still has these #ifdefs though.

 MIPS64 lags behind a bit due to less interest/testing.  Note that you
should use "__ASSEMBLY__" to guard assembly-unsafe parts of headers.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

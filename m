Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g46B3WwJ015287
	for <linux-mips-outgoing@oss.sgi.com>; Mon, 6 May 2002 04:03:32 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g46B3WxF015286
	for linux-mips-outgoing; Mon, 6 May 2002 04:03:32 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g46B3OwJ015283;
	Mon, 6 May 2002 04:03:25 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id NAA17553;
	Mon, 6 May 2002 13:04:59 +0200 (MET DST)
Date: Mon, 6 May 2002 13:04:58 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Reply-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Florian Lohoff <flo@rfc822.org>
cc: ralf@oss.sgi.com, linux-mips@oss.sgi.com, agx@sigxcpu.org
Subject: Re: XSHM/shared-pixmap fix  Was: Linux Shared Memory Issue
In-Reply-To: <20020427214505.GA23046@paradigm.rfc822.org>
Message-ID: <Pine.GSO.3.96.1020506130204.17175B-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Sat, 27 Apr 2002, Florian Lohoff wrote:

  [NON-Text Body part not included]

 Check it doesn't break static executables -- there were a few
arch_get_unmapped_area() updates in mm/mmap.c that you don't include in
the patch it would seem. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

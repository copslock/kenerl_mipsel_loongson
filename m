Received: from oss.sgi.com (localhost.localdomain [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g3IHxM8d005471
	for <linux-mips-outgoing@oss.sgi.com>; Thu, 18 Apr 2002 10:59:22 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g3IHxMXk005470
	for linux-mips-outgoing; Thu, 18 Apr 2002 10:59:22 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g3IHxG8d005460
	for <linux-mips@oss.sgi.com>; Thu, 18 Apr 2002 10:59:17 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id TAA05899;
	Thu, 18 Apr 2002 19:59:49 +0200 (MET DST)
Date: Thu, 18 Apr 2002 19:59:47 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: "Gleb O. Raiko" <raiko@niisi.msk.ru>
cc: Keith Owens <kaos@ocs.com.au>,
   "'linux-mips@oss.sgi.com'" <linux-mips@oss.sgi.com>
Subject: Re: DBE table ordering
In-Reply-To: <3CBEB61C.BC6F1746@niisi.msk.ru>
Message-ID: <Pine.GSO.3.96.1020418195601.5266A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, 18 Apr 2002, Gleb O. Raiko wrote:

> I dont't know about other tables and other arches. Perhaps, they need
> sorting of some tables. But, definetely, sorting isn't required for mips
> dbe/unaligned access tables.

 Still it can be done for consistency.  It won't hurt, will it?

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

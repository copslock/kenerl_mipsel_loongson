Received: from oss.sgi.com (localhost.localdomain [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g3JCIV8d001804
	for <linux-mips-outgoing@oss.sgi.com>; Fri, 19 Apr 2002 05:18:31 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g3JCIV8D001803
	for linux-mips-outgoing; Fri, 19 Apr 2002 05:18:31 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g3JCIR8d001800
	for <linux-mips@oss.sgi.com>; Fri, 19 Apr 2002 05:18:28 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id OAA00353;
	Fri, 19 Apr 2002 14:19:28 +0200 (MET DST)
Date: Fri, 19 Apr 2002 14:19:25 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: "Gleb O. Raiko" <raiko@niisi.msk.ru>
cc: Keith Owens <kaos@ocs.com.au>,
   "'linux-mips@oss.sgi.com'" <linux-mips@oss.sgi.com>
Subject: Re: DBE table ordering
In-Reply-To: <3CBFD518.C413C72A@niisi.msk.ru>
Message-ID: <Pine.GSO.3.96.1020419141152.29703A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, 19 Apr 2002, Gleb O. Raiko wrote:

> Sure, it won't hurt performance. Just looks stupid in this place.

 If it's done uniformly across all such tables it isn't stupid any longer. 
The reason is some independent code may depend on the consistency now or
in the future and creating unnecessary exceptions to rules makes
maintenance complicated and prone to hard to detect errors.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

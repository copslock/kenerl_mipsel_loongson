Received: from oss.sgi.com (localhost.localdomain [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g3CGuc8d011680
	for <linux-mips-outgoing@oss.sgi.com>; Fri, 12 Apr 2002 09:56:38 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g3CGuc54011679
	for linux-mips-outgoing; Fri, 12 Apr 2002 09:56:38 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g3CGuY8d011661
	for <linux-mips@oss.sgi.com>; Fri, 12 Apr 2002 09:56:35 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id SAA15738;
	Fri, 12 Apr 2002 18:57:10 +0200 (MET DST)
Date: Fri, 12 Apr 2002 18:57:09 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Scott A McConnell <samcconn@cotw.com>
cc: "MIPS/Linux List (SGI)" <linux-mips@oss.sgi.com>
Subject: Re: Can modules be stripped?
In-Reply-To: <3CB71C48.B768A40D@cotw.com>
Message-ID: <Pine.GSO.3.96.1020412185401.14896A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, 12 Apr 2002, Scott A McConnell wrote:

> If I strip a module, insmod dies in obj_load() with Floating point
> exception.

 You can't strip modules as they are relocatables -- global symbols and
relocations have to stay intact.  You may try `strip -d' if you want to
remove debugging symbols.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

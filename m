Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f5PCGOk29454
	for linux-mips-outgoing; Mon, 25 Jun 2001 05:16:24 -0700
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f5PCGFV29445
	for <linux-mips@oss.sgi.com>; Mon, 25 Jun 2001 05:16:16 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id OAA22705;
	Mon, 25 Jun 2001 14:13:31 +0200 (MET DST)
Date: Mon, 25 Jun 2001 14:13:31 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: "Gleb O. Raiko" <raiko@niisi.msk.ru>
cc: Ralf Baechle <ralf@uni-koblenz.de>, linux-mips@oss.sgi.com
Subject: Re: Bug in memmove
In-Reply-To: <3B372893.7EB21D8C@niisi.msk.ru>
Message-ID: <Pine.GSO.3.96.1010625135833.20469E-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, 25 Jun 2001, Gleb O. Raiko wrote:

> Considering your patch and my investigation though, it's not
> showstopper. In fact, there are a few places that call memmove, all of
> them aren't on "common path". However, I would consider that common path
> certainly depends on the way Linux is used. I may imagine the
> configuration where the bug may trigger.

 Note that the non-optimal code gets only invoked if the areas do really
overlap.

> Perhaps, eliminating that known "horror fix" (you know) is more
> important.

 Let's just let it remain in place until working optimization is done. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

Received: from oss.sgi.com (localhost.localdomain [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g3FICf8d005975
	for <linux-mips-outgoing@oss.sgi.com>; Mon, 15 Apr 2002 11:12:41 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g3FICfuq005974
	for linux-mips-outgoing; Mon, 15 Apr 2002 11:12:41 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g3FICb8d005961
	for <linux-mips@oss.sgi.com>; Mon, 15 Apr 2002 11:12:38 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id UAA29321;
	Mon, 15 Apr 2002 20:13:43 +0200 (MET DST)
Date: Mon, 15 Apr 2002 20:13:42 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Guido Guenther <agx@sigxcpu.org>
cc: linux-mips@oss.sgi.com
Subject: Re: head.S and init_task.c vs addinitrd
In-Reply-To: <20020415181743.A24174@gandalf.physik.uni-konstanz.de>
Message-ID: <Pine.GSO.3.96.1020415201017.19735Q-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, 15 Apr 2002, Guido Guenther wrote:

> Are you telling me the only reason for the changes in init_task.c/head.S
> were made to break the elf2ecoff/addinitrd "hack"? Where exactly was
> there a hack in head.S/init_task.c. Please point me to the line of code
> since I don't understand enough about the kernel to see it.

 I meant it stopped working because it is an ugly hack.  It is too fragile
to work in all cases. 

> That's 2.5 stuff. We should not break expected behavior in 2.4.

 Agreed.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

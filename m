Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g5OBYmnC025884
	for <linux-mips-outgoing@oss.sgi.com>; Mon, 24 Jun 2002 04:34:48 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g5OBYmk4025883
	for linux-mips-outgoing; Mon, 24 Jun 2002 04:34:48 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g5OBYfnC025880;
	Mon, 24 Jun 2002 04:34:41 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id NAA27692;
	Mon, 24 Jun 2002 13:38:27 +0200 (MET DST)
Date: Mon, 24 Jun 2002 13:38:27 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Carsten Langgaard <carstenl@mips.com>
cc: Ralf Baechle <ralf@oss.sgi.com>, linux-mips@oss.sgi.com
Subject: Re: sys_syscall patch.
In-Reply-To: <3D16F891.78A333BA@mips.com>
Message-ID: <Pine.GSO.3.96.1020624133501.22509K-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, 24 Jun 2002, Carsten Langgaard wrote:

> > What programs btw are using syscall()?  To be honest I don't recall one ...
> 
> /sbin/rpc.lockd.
> It use syscall() to indirectly call the 'sys_nfsservctl' syscall, why it
> doesn't do the syscall directly is beyond me.

 Hmm, shouldn't syscall() be a library wrapper?  I think we should kill
sys_syscall(). 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f7DElTs09983
	for linux-mips-outgoing; Mon, 13 Aug 2001 07:47:29 -0700
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f7DElMj09979
	for <linux-mips@oss.sgi.com>; Mon, 13 Aug 2001 07:47:22 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id QAA23031;
	Mon, 13 Aug 2001 16:49:22 +0200 (MET DST)
Date: Mon, 13 Aug 2001 16:49:22 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Keith Owens <kaos@ocs.com.au>
cc: Ralf Baechle <ralf@uni-koblenz.de>, Harald Koerfgen <hkoerfg@web.de>,
   linux-mips@fnet.fr, linux-mips@oss.sgi.com
Subject: Re: [patch] modutils 2.4.6: Make __dbe_table available to modules 
In-Reply-To: <15497.997712357@ocs3.ocs-net>
Message-ID: <Pine.GSO.3.96.1010813164151.18279K-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, 14 Aug 2001, Keith Owens wrote:

> Checking dbe table is fine but where you placed the table in struct
> modules is wrong.  You must not insert fields in the middle of struct
> module, it introduces version skew between kernel and user space.  At
> the very least you have moved the can_unload which will break IPv6 plus
> a few other modules.
[...]

 Thanks a lot for the detailed explanation.  I'll cook an improvement
soon. 

> The only other change you have to make is to init_modules().  For mips
> you create pointers to the kernel dbe tables and fill in archdata start
> and end in kernel_module.  Since init_module is called before kmalloc
> is ready, make the kernel dbe table a static variable.

 __dbe_table is initialized exactly like __ex_table, i.e. it's a separate
ELF section with pointers to the start and the end computed in a linker
script.  Thus it is fine.  The table has actually been present in the
kernel for quite some time already. 

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

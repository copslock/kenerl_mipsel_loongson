Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f56IkpT11960
	for linux-mips-outgoing; Wed, 6 Jun 2001 11:46:51 -0700
Received: from delta.ds2.pg.gda.pl (delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.3/8.11.3) with SMTP id f56IkBh11862
	for <linux-mips@oss.sgi.com>; Wed, 6 Jun 2001 11:46:12 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id UAA10647;
	Wed, 6 Jun 2001 20:34:05 +0200 (MET DST)
Date: Wed, 6 Jun 2001 20:34:04 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Alexandr Andreev <andreev@niisi.msk.ru>,
   Ralf Baechle <ralf@uni-koblenz.de>
cc: linux-mips@oss.sgi.com
Subject: Re: Troubles in r2300.c
In-Reply-To: <3B1EDB4A.4080803@niisi.msk.ru>
Message-ID: <Pine.GSO.3.96.1010606202621.10246A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, 6 Jun 2001, Alexandr Andreev wrote:

> In the r2300.c ,in some functions ( like the r3k_cache_size and so on ), 
> the
> CONFIG register is modified. To return this register to initial state, the
> save_and_cli(flags) and the restore_flags(flags) functions are used. The
> restore_flags do not modify whole STATUS register, but only the 
> Interrupt Enable
> bit. So we should use the read_32bit_cp0_register and the 
> write_32bit_cp0_register
> functions instead ( like it was in linux-2.4.1 ).

 Sh*t!  Why do people keep "fixing" things they did not break, especially
when no one is watching???  The functions were already discussed back in
January or so and I already explained why read/write functions are needed
instead of cli/restore!

 I think I'll cook up a patch with a few explicit comments so nobody
touches the code unless he know what he is doing.

 Ralf, please apply the patch ASAP.  Thanks.

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

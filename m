Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g54EomnC028218
	for <linux-mips-outgoing@oss.sgi.com>; Tue, 4 Jun 2002 07:50:48 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g54EomCi028217
	for linux-mips-outgoing; Tue, 4 Jun 2002 07:50:48 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g54EognC028214
	for <linux-mips@oss.sgi.com>; Tue, 4 Jun 2002 07:50:43 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id QAA18686;
	Tue, 4 Jun 2002 16:52:36 +0200 (MET DST)
Date: Tue, 4 Jun 2002 16:52:36 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: "Gleb O. Raiko" <raiko@niisi.msk.ru>
cc: Ralf Baechle <ralf@uni-koblenz.de>, linux-mips@fnet.fr,
   linux-mips@oss.sgi.com
Subject: Re: [patch] linux: mb() and friends again
In-Reply-To: <3CFCA790.9C698A6D@niisi.msk.ru>
Message-ID: <Pine.GSO.3.96.1020604164624.17556E-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, 4 Jun 2002, Gleb O. Raiko wrote:

> In previous version of your patch there was the change in mm/c-r3k.c:
> 
> static void r3k_dma_cache_wback_inv(unsigned long start, unsigned long
> size)
> {
> -       wbflush();
> +       iob();
>         r3k_flush_dcache_range(start, start + size);
> }
> 
> Why did you drop it? It's definetely required.

 Nope, it wasn't dropped.  It's included in a different patch, namely
"patch-mips-2.4.18-20020412-wbflush-5".  The patch depends on the
"patch-mips-2.4.18-20020530-mb-wb-8" one, so I am not going to resubmit
the former one for discussion here until (unless) we decide on the latter
one.

> While you patch operates in unusual terms from hw point of view, it does
> right thins by stating that external wbs do differ from internal wb.

 What do you mean by "unusual terms"?  The names of the macros?  Well,
they are based on what's used for other platforms and if treated as
abstract names (as they should be) they actually reflect reality. 

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

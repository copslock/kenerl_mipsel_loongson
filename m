Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f7OGFxx17919
	for linux-mips-outgoing; Fri, 24 Aug 2001 09:15:59 -0700
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f7OGFud17916
	for <linux-mips@oss.sgi.com>; Fri, 24 Aug 2001 09:15:56 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id SAA16170;
	Fri, 24 Aug 2001 18:18:03 +0200 (MET DST)
Date: Fri, 24 Aug 2001 18:18:02 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Hiroo Hayashi <hiroo.hayashi@toshiba.co.jp>
cc: linux-mips@fnet.fr, linux-mips@oss.sgi.com
Subject: Re: bus error by write transaction (RE: [patch] linux 2.4.5: Make __dbe_table available to modules)
In-Reply-To: <FFEHJOJAGEIJIPPEKDNGOEJGCDAA.hiroo.hayashi@toshiba.co.jp>
Message-ID: <Pine.GSO.3.96.1010824181047.14758B-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, 23 Aug 2001, Hiroo Hayashi wrote:

> Note that most MIPS documents use word 'load' and 'store' for instruction,
> and 'read' and 'write' for bus transaction.  You have to distinguish them.

 Don't I?

> (Here I'm ignoring I/O access to make the point clear.)

 How do you define an I/O access for MIPS?

> The data on a write bus transaction may be a data modified by a store
> instruction which was issued some years ago :-)  What the OS can do?

 Report it and panic.  The problem with bus errors on MIPS is that one
can't distinguish between errors on reads and writes.  The former are
exact and are not fatal -- i.e. you can terminate if there is a guilty
process and try to continue; otherwise panic.  The latter are always fatal
as they are inexact and a panic is the most reasonable way to recover. 
With no way to distinguish between the two cases, it's hard to decide if
to go the strict way and panic in all cases or to hope a possible failing
write will not make the system inconsistent. 

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

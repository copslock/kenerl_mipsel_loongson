Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fAQCxnf22568
	for linux-mips-outgoing; Mon, 26 Nov 2001 04:59:49 -0800
Received: from delta.ds2.pg.gda.pl (delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fAQCxXo22564
	for <linux-mips@oss.sgi.com>; Mon, 26 Nov 2001 04:59:36 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id MAA24991;
	Mon, 26 Nov 2001 12:57:24 +0100 (MET)
Date: Mon, 26 Nov 2001 12:57:23 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: William Lee Irwin III <wli@holomorphy.com>
cc: linux-mips@oss.sgi.com
Subject: Re: FPU interrupt handler
In-Reply-To: <20011125002352.G1048@holomorphy.com>
Message-ID: <Pine.GSO.3.96.1011126124533.21598D-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Sun, 25 Nov 2001, William Lee Irwin III wrote:

>         EXPORT(dec_intr_fpu)
> dec_intr_fpu:   PANIC("Unimplemented FPU interrupt handler")
> 
> I've not encountered this quite yet, but I have an R3K-based
> DecStation up and running, and if I understand this properly,
> R3K delivers FPU exceptions as interrupts. It looks like
> this could take the machine down.

 Nope, R3k DECstations used to use the FPU emulator unconditionally. :-(
This would have never got triggered.  An FPU interrupt-to-exception glue
was non-existent.

> Maciej, I was asked to notify you specifically, but this is
> my only known point of contact. If you could look into this,
> I would be much obliged.

 No need to do anything -- I happened to work on the FPU a bit recently
and I sent a patch here on Friday that adds the glue, enables the FPU and
rips the broken code off.  Ralf has already applied the patch. 

 I would *really* appreciate any feedback on DECstation patches I'm
sending here -- for quite some time I have a feeling I'm the last one to
run Linux on a DECstation... :-(

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

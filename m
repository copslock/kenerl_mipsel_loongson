Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f7DGM3k12852
	for linux-mips-outgoing; Mon, 13 Aug 2001 09:22:03 -0700
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f7DGLtj12843;
	Mon, 13 Aug 2001 09:21:55 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id SAA24704;
	Mon, 13 Aug 2001 18:24:20 +0200 (MET DST)
Date: Mon, 13 Aug 2001 18:24:19 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ralf Baechle <ralf@oss.sgi.com>
cc: Harald Koerfgen <hkoerfg@web.de>, Keith Owens <kaos@ocs.com.au>,
   linux-mips@fnet.fr, linux-mips@oss.sgi.com
Subject: Re: [patch] linux 2.4.5: Make __dbe_table available to modules
In-Reply-To: <20010813175042.C2228@bacchus.dhis.org>
Message-ID: <Pine.GSO.3.96.1010813181607.23241N-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, 13 Aug 2001, Ralf Baechle wrote:

> Looks fine at the first view.  I'll apply it but duplicate it for mips64
> also.

 Please wait for a while, until I resolve modutils interoperability as
pointed out by Keith. 

> The whole mechanism has it's problems though.  On the Origin certain
> accesses like an attempt to write to a non-existant serial interface
> take down the machine though.  I don't have an explanation nor did Kanoj
> seem to.

 The MIPS architecture defines the bus error exception event for data
reads and instruction fetches only.  Writes are asynchronous so errors on
them cannot be reported exactly -- some MIPS documentation recommends
using a general-purpose interrupt line for such events.

 Both bus error exceptions and error interrupts are system-specific and
might not work unless designed to.  The Origin might be an example.  Does
it crash for reads/fetches from the affected address space, either? 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

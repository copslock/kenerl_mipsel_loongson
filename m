Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f7DFrEk11910
	for linux-mips-outgoing; Mon, 13 Aug 2001 08:53:14 -0700
Received: from dea.waldorf-gmbh.de (u-86-18.karlsruhe.ipdial.viaginterkom.de [62.180.18.86])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f7DFrBj11907
	for <linux-mips@oss.sgi.com>; Mon, 13 Aug 2001 08:53:11 -0700
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f7DFogR02275;
	Mon, 13 Aug 2001 17:50:42 +0200
Date: Mon, 13 Aug 2001 17:50:42 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Harald Koerfgen <hkoerfg@web.de>, Keith Owens <kaos@ocs.com.au>,
   linux-mips@fnet.fr, linux-mips@oss.sgi.com
Subject: Re: [patch] linux 2.4.5: Make __dbe_table available to modules
Message-ID: <20010813175042.C2228@bacchus.dhis.org>
References: <Pine.GSO.3.96.1010813152644.18279G-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.3.96.1010813152644.18279G-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Mon, Aug 13, 2001 at 03:38:36PM +0200
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, Aug 13, 2001 at 03:38:36PM +0200, Maciej W. Rozycki wrote:

>  Unlike most architectures which only handle memory faults/privilege
> violations via __ex_table, the MIPS port allows to handle bus error
> exceptions via __dbe_table. Unfortunately, the latter table is not
> exported to modules, so if a modularized driver needs to probe the address
> space for a device it's out of luck.
> 
>  The following patch implements the kernel part of __dbe_table support.  A
> separate patch is needed for modutils.
> 
>  A side effect of the patch is a fix to unhandled bus error exceptions
> which happen in the kernel mode.  Currently they cause the faulting code
> to be reexecuted which results in a hang in an infinite loop.  With the
> patch applied, the kernel's response is an "Oops" similar to the one
> printed when a memory fault happens.
> 
>  I hope it's fine to apply.

Looks fine at the first view.  I'll apply it but duplicate it for mips64
also.

The whole mechanism has it's problems though.  On the Origin certain
accesses like an attempt to write to a non-existant serial interface
take down the machine though.  I don't have an explanation nor did Kanoj
seem to.

  Ralf

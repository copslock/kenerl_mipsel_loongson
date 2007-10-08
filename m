Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 08 Oct 2007 16:24:03 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:50106 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20022374AbXJHPYB (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 8 Oct 2007 16:24:01 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l98FO1pj005369;
	Mon, 8 Oct 2007 16:24:01 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l98FO0j9005368;
	Mon, 8 Oct 2007 16:24:01 +0100
Date:	Mon, 8 Oct 2007 16:24:00 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Cc:	"Maciej W. Rozycki" <macro@linux-mips.org>,
	Thiemo Seufer <ths@networkno.de>, linux-mips@linux-mips.org
Subject: Re: [PATCH] mm/pg-r4k.c: Dump the generated code
Message-ID: <20071008152400.GA1317@linux-mips.org>
References: <20071003131158.GL16772@networkno.de> <4703F155.4000301@gmail.com> <20071003201800.GP16772@networkno.de> <47049734.6050802@gmail.com> <20071004121557.GA28928@linux-mips.org> <4705004C.5000705@gmail.com> <Pine.LNX.4.64N.0710041616570.10573@blysk.ds.pg.gda.pl> <4705EFE5.7090704@gmail.com> <Pine.LNX.4.64N.0710051312490.17849@blysk.ds.pg.gda.pl> <470A4349.9090301@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <470A4349.9090301@gmail.com>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16889
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Oct 08, 2007 at 04:48:41PM +0200, Franck Bui-Huu wrote:

> Maciej W. Rozycki wrote:
> > The exact CPU type is not known at the moment.  For example CPU_R4X00 and 
> > CPU_MIPS32_R1 cover whole ranges that have subtle differences.  It may be 
> > possible to provide all the variations as a selection to the user, but it 
> > may be unfeasible -- I don't know.  Compare what we have in 
> > arch/mips/Kconfig with <asm/cpu.h>.
> > 
> 
> OK, I see.
> 
> Well, having all cpu variations in Kconfig should be technically
> possible. The user needs to know what exact cpu is running on which
> doesn't sound impossible and we could add some sanity checkings to
> ensure he doesn't messed up its configuration.

I don't consider this much of a problem.  The machines which either
have one or multiple of the R4000 family or a mix of of R10000 family
processors simply shouldn't hardwire the CPU types.  The R4000 machines
can afford the few bytes of kernel executable and the R10000 machines
often come with ridiculous amounts of memory anyway.

> BTW, we could pass more cpu compiler options for optimization this
> way. For example, when using a '4ksd' cpu, we currently can't pass
> '-march=4ksd' to gcc since the cpu type used for it is 'mips32r2'. And
> I guess it's true for all cpu types which cover a range of slightly
> different processors (r4x00 comes in mind).
> 
> OTOH, I don't know if it can work on SMP: if the system needs 2
> different implementations of the handler (I don't know if it can
> happen though), we must be able to select 2 different cpu types in
> Kconfig...

The currently only multiprocessor systems which allow mixing of different
processors are the SGI machines and there we have the restriction to
at least the same family of processors, see above.  One which I sooner
or later expect to see is CMP systems with different clock rates per
processor.

> Do you see any other points that we should consider before trying to
> use static handlers ? Some other cpu features influencing the tlb
> handler generations and that can be found only at runtime ?

  Ralf

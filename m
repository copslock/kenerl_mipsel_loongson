Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Jun 2003 08:53:48 +0100 (BST)
Received: (from localhost user: 'ladis' uid#10009 fake: STDIN
	(ladis@sirjeppe-pt.tunnel.tserv1.fmt.ipv6.he.net)) by linux-mips.org
	id <S8224861AbTFQHxq>; Tue, 17 Jun 2003 08:53:46 +0100
Date: Tue, 17 Jun 2003 08:53:46 +0100
From: Ladislav Michl <ladis@linux-mips.org>
To: Juan Quintela <quintela@trasno.org>
Cc: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
	linux-mips@linux-mips.org
Subject: Re: [PATCH] kill prom_printf
Message-ID: <20030617085346.A27590@ftp.linux-mips.org>
References: <Pine.GSO.3.96.1030616165248.2112D-100000@delta.ds2.pg.gda.pl> <867k7lsiq1.fsf@trasno.mitica>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <867k7lsiq1.fsf@trasno.mitica>; from quintela@trasno.org on Tue, Jun 17, 2003 at 01:31:02AM +0200
Return-Path: <ladis@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2653
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ladis@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Jun 17, 2003 at 01:31:02AM +0200, Juan Quintela wrote:
> >>>>> "maciej" == Maciej W Rozycki <macro@ds2.pg.gda.pl> writes:
[snip]
> maciej> Hmm, strange idea -- I guess that originates from systems that have no
> maciej> suitable firmware to perform such an operation at the console.  Currently
> maciej> only x86_64 implements early_printk() -- if we have an implementation for
> maciej> MIPS, we may consider removing the alternative.  Also prom_printf() comes
> maciej> almost for free and works very early and as I see in the x86_64 version
> maciej> early_printk() requires initialization of a console driver, which may be
> maciej> unfortunate if debugging a problem within the driver. 
> 
> There is at least one implementation for x86 that uses the VGA
> directly (as the BIOS left it), getting it very soon.
> 
> But you are right, PC's speciality is not to have a nice console.
> Anyways, you can use early_printk() in MIPS.  You only need to put the
> setup of the early console sooner, as for you the setup is basically a NOP.

(I'm only implementing it and I don't care how good idea it is :-) Anyway
I still think that firmware should be used directly to print message before
kernel halts in situations like arch/mips/arc/init.c at line 30)

Maciej, i'll try to make some conclusion from what I was told (and Juan is
welcome to correct me if I missunderstood something)

Idea is to have only one way for printing kernel messages. In case of Indy,
O2 and SNI RM200 "arc" console will do it. Here you can find where should
be early console initialized:
http://marc.theaimsgroup.com/?l=linux-kernel&m=105519188505235&w=2
As Juan pointed out setup for such console is actually a nop and one is
supposed to enable this feature only when debugging kernel. DEC prom console
however needs some setup to determine REX entry points. early console is
currently used on sh, alpha, x86_64 and ia64 architectures. Btw, see comment
at the top of arch/sparc/prom/printf.c

Regards, ladis

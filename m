Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g5P0c2nC014108
	for <linux-mips-outgoing@oss.sgi.com>; Mon, 24 Jun 2002 17:38:02 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g5P0c1OQ014107
	for linux-mips-outgoing; Mon, 24 Jun 2002 17:38:01 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from kopretinka (p055.as-l025.contactel.cz [212.65.234.55])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g5P0bFnC014102
	for <linux-mips@oss.sgi.com>; Mon, 24 Jun 2002 17:37:40 -0700
Received: from ladis by kopretinka with local (Exim 3.35 #1 (Debian))
	id 17MeKW-0000VP-00; Tue, 25 Jun 2002 02:37:12 +0200
Date: Tue, 25 Jun 2002 02:36:34 +0200
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: linux-mips@oss.sgi.com
Subject: Re: DBE/IBE handling incompatibility
Message-ID: <20020625003634.GA1917@kopretinka>
References: <20020617113311.GA839@kopretinka> <Pine.GSO.3.96.1020619182253.15094Q-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.3.96.1020619182253.15094Q-100000@delta.ds2.pg.gda.pl>
User-Agent: Mutt/1.3.28i
From: Ladislav Michl <ladis@psi.cz>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, Jun 19, 2002 at 06:47:05PM +0200, Maciej W. Rozycki wrote:
>  Don't rely in dbe_board_handler and ibe_board_handler -- they are
> system-specific backends that shouldn't be touched unless you want to
> handle the exceptions in a system-specific way (e.g. to report ECC errors
> from a memory controller).

MC sends an interrupt whenever bus or parity errors occur. In addition, if the
error happened during a CPU read, it also asserts the bus error pin on the R4K.
so once one access nonexistent memory on Indy first DBE is generated followed
by Bus Error interupt (IRQ 6). When GIO status register is cleared inside DBE
handler, irq is not delivered.

> Also expect the handlers to get rewritten so that search_dbe_table() gets 
> invoked unconditionally, before a system-specific backend.

i don't want to use these handlers, i'd like to write it mips64 way.

> Use get_dbe() from <asm/paccess.h> for reading data with an additional
> DBE status.  For a simple example see drivers/mtd/devices/ms02-nv.c.  The
> macro is used in a somewhat more complex way in drivers/tc/tc.c as well --
> this bit of code fits your situation quite closely (here probing
> TURBOchannel bus slots).  The macro works in modules as well.

that does't work. i used folowing pseudocode:

my_get_dbe()
  nofault = 1;
  ret = get_dbe(*val, (unsigned int *) addr);
  __asm__ __volatile__("nop;nop;nop;nop");
  nofault = 0;
	
my_do_buserr()
  save_and_clear_buserr();
  if (nofault) {
    nofault = 0;
    return;
  }
  panic();

when calling my_get_dbe for nonexistent address it enters my_do_buserr
and returns "somewhere" causing machine to freeze. calling
save_and_clear_buserr() from board specific DBE handler works as
expected. is there better solution or i missed anything important?

thanks,
	ladis

Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 28 Sep 2002 22:07:14 +0200 (CEST)
Received: from p042.as-l025.contactel.cz ([212.65.234.42]:5636 "EHLO
	kopretinka") by linux-mips.org with ESMTP id <S1121744AbSI1UHN>;
	Sat, 28 Sep 2002 22:07:13 +0200
Received: from ladis by kopretinka with local (Exim 3.35 #1 (Debian))
	id 17vNgk-0000GW-00; Sat, 28 Sep 2002 21:55:42 +0200
Date: Sat, 28 Sep 2002 21:55:42 +0200
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Guido Guenther <agx@sigxcpu.org>, linux-mips@linux-mips.org
Subject: Re: [patch] GIO bus support
Message-ID: <20020928195542.GA990@kopretinka>
References: <20020626205956.GA2079@kopretinka> <Pine.GSO.3.96.1020627140152.21496C-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.3.96.1020627140152.21496C-100000@delta.ds2.pg.gda.pl>
User-Agent: Mutt/1.3.28i
From: Ladislav Michl <ladis@psi.cz>
Return-Path: <ladis@psi.cz>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 303
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ladis@psi.cz
Precedence: bulk
X-list: linux-mips

On Thu, Jun 27, 2002 at 02:21:30PM +0200, Maciej W. Rozycki wrote:
> On Wed, 26 Jun 2002, Ladislav Michl wrote:
> 
> > +int be_ip22_handler(struct pt_regs *regs, int is_fixup)
> > +{
> > +	save_and_clear_buserr();
> > +	if (nofault) {
> > +		nofault = 0;
> > +		compute_return_epc(regs);
> > +		return MIPS_BE_DISCARD;
> > +	}
> > +	return MIPS_BE_FIXUP;
> > +}
> 
>  I wouldn't use nofault -- it leads to reentrancy problems and I don't
> think you really need it.  You probably need to code it like this:
> 
> {
> 	save_and_clear_buserr();
> 
> 	return is_fixup ? MIPS_BE_FIXUP : MIPS_BE_FATAL;
> }
> 
> unless:
> 
> 1. There is a condition when for is_fixup true you should ignore the fixup
> anyway (e.g. what the bus error logic reports is irrelevant to fixups). 
> You should choose between MIPS_BE_FATAL and MIPS_BE_DISCARD then. 
> 
> 2. There is a condition when for is_fixup false, an error is not fatal and
> execution should get restarted.  You should return MIPS_BE_DISCARD then.

There are no such conditions (or I'm missing something). I wrote it as
you suggested:

int be_ip22_handler(struct pt_regs *regs, int is_fixup)
{
  DBG("BE exception (%s)\n", is_fixup ? "fixup" : "no fixup");
  save_and_clear_buserr();
  if (is_fixup)
    return MIPS_BE_FIXUP;
  print_buserr();
  return MIPS_BE_FATAL;
}

try to read status register

  addr = KSEG1ADDR(gio_slot_base_addr);
  DBG("get_dbe\n");
  if (!get_dbe(id, addr)) {
    ... ok
  }							

> > +int ip22_baddr(unsigned int *val, unsigned long addr)
> > +{
> > +	nofault = 1;
> > +	*val = *(volatile unsigned int *) addr;
> > +	__asm__ __volatile__("nop;nop;nop;nop");
> > +	if (nofault) {
> > +		nofault = 0;
> > +		return 0;
> > +	}
> > +	return -EFAULT;
> > +}
> 
>  Why not simply:
> 
> {
> 	int err;
> 
> 	err = get_dbe(*val, (volatile unsigned int *) addr);
> 
> 	return err ? -EFAULT : 0;
> }
> 
> It was designed exactly for this purpose.  You may consider using "u32" 
> instead of "unsigned int" for hardware accesses to assure the type will
> always be 32-bit.

This way gives following result:

get_dbe
BE exception (no fixup)

Dump of MC registers shows that timeout occurs when accessing nonexistant
memory. Of course it is posible return MIPS_BE_DISCARD than (and
regs->cp0_epc += 4), but how to force get_dbe fail then? Not mentioning
that in such case is better to avoid use of get_dbe... Suggestions are
welcome as always.

Thanks a lot,
	Ladis

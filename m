Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id RAA99903 for <linux-archive@neteng.engr.sgi.com>; Sun, 8 Nov 1998 17:07:45 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id RAA36529
	for linux-list;
	Sun, 8 Nov 1998 17:07:29 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id RAA09186
	for <linux@cthulhu.engr.sgi.com>;
	Sun, 8 Nov 1998 17:07:19 -0800 (PST)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1]) 
	by sgi.sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id RAA01728
	for <linux@cthulhu.engr.sgi.com>; Sun, 8 Nov 1998 17:07:18 -0800 (PST)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from lappi.waldorf-gmbh.de (pmport-29.uni-koblenz.de [141.26.249.29])
	by mailhost.uni-koblenz.de (8.9.1/8.9.1) with ESMTP id CAA12230
	for <linux@cthulhu.engr.sgi.com>; Mon, 9 Nov 1998 02:07:10 +0100 (MET)
Received: (from ralf@localhost)
	by lappi.waldorf-gmbh.de (8.8.7/8.8.7) id AAA17930;
	Mon, 9 Nov 1998 00:50:45 +0100
Message-ID: <19981109005044.A17922@uni-koblenz.de>
Date: Mon, 9 Nov 1998 00:50:44 +0100
From: ralf@uni-koblenz.de
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>, linux-mips@fnet.fr,
        linux@cthulhu.engr.sgi.com, linux-mips@vger.rutgers.edu
Subject: Re: GDB
References: <19981105023015.K359@uni-koblenz.de> <19981106212424.A2271@alpha.franken.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="/04w6evG8XlLl3ft"
X-Mailer: Mutt 0.91.1
In-Reply-To: <19981106212424.A2271@alpha.franken.de>; from Thomas Bogendoerfer on Fri, Nov 06, 1998 at 09:24:24PM +0100
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


--/04w6evG8XlLl3ft
Content-Type: text/plain; charset=us-ascii

On Fri, Nov 06, 1998 at 09:24:24PM +0100, Thomas Bogendoerfer wrote:

> On Thu, Nov 05, 1998 at 02:30:15AM +0100, ralf@uni-koblenz.de wrote:
> > I found that by accident GDB and the kernel were using different
> > ptrace(2) interfaces.  After fixing that for example ``info registers''
> > works ok.
> 
> how about sharing your fix with us ? 

Guess too much decaf when I wrote that mail ...  Attached the fixed
version of mipslinux-nat.c.  I've copied all the (corrected!) definitions
of the kernel interfaces into mipslinux-nat.c, therefore no more headerfile
problems even with old kernel headers installed.

  Ralf

--/04w6evG8XlLl3ft
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="mipslinux-nat.c"

/* Low level MIPS/Linux interface, for GDB when running native.
   Copyright 1996 Free Software Foundation, Inc.
   Contributed by David S. Miller (davem@caip.rutgers.edu) at
   Rutgers University CAIP Research Center.

This file is part of GDB.

This program is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; either version 2 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.  */

#include "defs.h"
#include "inferior.h"
#include "gdbcore.h"
#include "target.h"
#include "gdb_string.h"
#include "symtab.h"
#include "bfd.h"
#include "symfile.h"
#include "objfiles.h"
#include "command.h"
#include "frame.h"
#include "gnu-regex.h"
#include "inferior.h"
#include "language.h"
#include "gdbcmd.h"
#include <sys/ptrace.h>
#include <sys/time.h>
#include <sys/types.h>
#include <sys/param.h>
#include <sys/user.h>

#include <setjmp.h>   /* For JB_PC and friends. */

/* This duplicates definitions from <asm/elfcore.h> ...  */

/* ELF register definitions */
#define ELF_NGREG       45
#define ELF_NFPREG      33

typedef unsigned long gregset_t [ELF_NGREG];
typedef double fpregset_t [ELF_NFPREG];

/* This duplicates definitions from <asm/elf.h> ...  */

/* 0 - 31 are integer registers, 32 - 63 are fp registers.  */
#define FPR_BASE	32
#define PC		64
#define CAUSE		65
#define BADVADDR	66
#define MMHI		67
#define MMLO		68
#define FPC_CSR		69
#define FPC_EIR		70

/* End of duplicated definitions  */

/* Size of elements in jmpbuf */

#define JB_ELEMENT_SIZE 4

/* Figure out where the longjmp will land.
   We expect the first arg to be a pointer to the jmp_buf structure from which
   we extract the pc (JB_PC) that we will land at.  The pc is copied into PC.
   This routine returns true on success. */

int
get_longjmp_target(pc)
     CORE_ADDR *pc;
{
  CORE_ADDR jb_addr;
  char buf[TARGET_PTR_BIT / TARGET_CHAR_BIT];

  jb_addr = read_register (A0_REGNUM);

  if (target_read_memory (jb_addr + JB_PC * JB_ELEMENT_SIZE, buf,
			  TARGET_PTR_BIT / TARGET_CHAR_BIT))
    return 0;

  *pc = extract_address (buf, TARGET_PTR_BIT / TARGET_CHAR_BIT);

  return 1;
}

/*
 * See the comment in m68k-tdep.c regarding the utility of these functions.
 *
 * These definitions are from the MIPS SVR4 ABI, so they may work for
 * any MIPS SVR4 target.
 */

void 
supply_gregset (gregsetp)
     gregset_t *gregsetp;
{
  register int regi;
  register unsigned int *regp = (unsigned int *) &(*gregsetp)[0];
  static char zerobuf[MAX_REGISTER_RAW_SIZE] = {0};

  for (regi = EF_REG0; regi <= EF_LO; regi++)
    supply_register ((regi - EF_REG0), (char *)(regp + regi));

  supply_register(PC_REGNUM, (char *)(regp + EF_CP0_EPC));
  supply_register(CAUSE_REGNUM, (char *)(regp + EF_CP0_CAUSE));
  supply_register(BADVADDR_REGNUM, (char *)(regp + EF_CP0_BADVADDR));
  supply_register(LO_REGNUM, (char *)(regp + EF_LO));
  supply_register(HI_REGNUM, (char *)(regp + EF_HI));

  /* Fill inaccessible registers with zero.  */
  supply_register (FP_REGNUM, zerobuf);
  supply_register (UNUSED_REGNUM, zerobuf);
}

void
fill_gregset (gregsetp, regno)
     gregset_t *gregsetp;
     int regno;
{
  int regi;
  register unsigned int *regp = (unsigned int *) &(*gregsetp)[0];

  for (regi = 0; regi <= (EF_SIZE / 4); regi++)
    if ((regno == -1) || (regno == regi))
      *(regp + regi) = *(unsigned int *) &registers[REGISTER_BYTE (regi)];
}

/* Now we do the same thing for floating-point registers.
 * We don't bother to condition on FP0_REGNUM since any
 * reasonable MIPS configuration has an R3010 in it.
 *
 * Again, see the comments in m68k-tdep.c.
 */

void
supply_fpregset (fpregsetp)
     fpregset_t *fpregsetp;
{
  register int regi;
  static char zerobuf[MAX_REGISTER_RAW_SIZE] = {0};

  for (regi = 0; regi < 32; regi++)
    supply_register (FP0_REGNUM + regi,
		     (char *)&fpregsetp[regi]);

  supply_register (FCRCS_REGNUM, (char *)&fpregsetp[32]);

  /* FIXME: how can we supply FCRIR_REGNUM?  The ABI doesn't tell us. */
  supply_register (FCRIR_REGNUM, zerobuf);
}

void
fill_fpregset (fpregsetp, regno)
     fpregset_t *fpregsetp;
     int regno;
{
  int regi;
  char *from, *to;

  for (regi = FP0_REGNUM; regi < FP0_REGNUM + 32; regi++)
    {
      if ((regno == -1) || (regno == regi))
	{
	  from = (char *) &registers[REGISTER_BYTE (regi)];
	  to = (char *) &(fpregsetp[regi - FP0_REGNUM]);
	  memcpy(to, from, REGISTER_RAW_SIZE (regi));
	}
    }

#if 0
  if ((regno == -1) || (regno == FCRCS_REGNUM))
    fpregsetp[32] = *(unsigned int *) &registers[REGISTER_BYTE(FCRCS_REGNUM)];
#endif
}

/* Map gdb internal register number to ptrace ``address''.
   These ``addresses'' are defined in <mips/ptrace.h> */

#define REGISTER_PTRACE_ADDR(regno) \
   (regno < 32 ? 		regno   \
  : regno == PC_REGNUM ?	PC	\
  : regno == CAUSE_REGNUM ?	CAUSE	\
  : regno == HI_REGNUM ?	MMHI	\
  : regno == LO_REGNUM ?	MMLO	\
  : regno == FCRCS_REGNUM ?	FPC_CSR	\
  : regno == FCRIR_REGNUM ?	FPC_EIR	\
  : regno >= FP0_REGNUM ?	FPR_BASE + (regno - FP0_REGNUM) \
  : 0)

/* Return the ptrace ``address'' of register REGNO. */

CORE_ADDR
register_addr (regno, blockend)
     int regno;
     CORE_ADDR blockend;
{
  if(regno < 0 || regno >= NUM_REGS)
    error ("Bogon register number %d.", regno);

  return REGISTER_PTRACE_ADDR (regno);
}

--/04w6evG8XlLl3ft--

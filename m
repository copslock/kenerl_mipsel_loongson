Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id OAA70874 for <linux-archive@neteng.engr.sgi.com>; Mon, 8 Feb 1999 14:05:28 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id OAA20114
	for linux-list;
	Mon, 8 Feb 1999 14:04:15 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id OAA22906
	for <linux@engr.sgi.com>;
	Mon, 8 Feb 1999 14:04:02 -0800 (PST)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id OAA09193
	for <linux@engr.sgi.com>; Mon, 8 Feb 1999 14:03:59 -0800 (PST)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from lappi.waldorf-gmbh.de (cacc-26.uni-koblenz.de [141.26.131.26])
	by mailhost.uni-koblenz.de (8.9.1/8.9.1) with ESMTP id XAA14362
	for <linux@engr.sgi.com>; Mon, 8 Feb 1999 23:03:56 +0100 (MET)
Received: (from ralf@localhost)
	by lappi.waldorf-gmbh.de (8.8.7/8.8.7) id GAA01704;
	Mon, 8 Feb 1999 06:12:22 +0100
Message-ID: <19990208061220.A1699@uni-koblenz.de>
Date: Mon, 8 Feb 1999 06:12:20 +0100
From: ralf@uni-koblenz.de
To: Karel van Houten <K.H.C.vanHouten@research.kpn.com>
Cc: linux@cthulhu.engr.sgi.com, linux-mips@fnet.fr,
        linux-mips@vger.rutgers.edu
Subject: MIPS egcs bug, was: working modutils for DECStation Linux ??
References: <199902071436.PAA11929@sparta.research.kpn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93.2
In-Reply-To: <199902071436.PAA11929@sparta.research.kpn.com>; from Karel van Houten on Sun, Feb 07, 1999 at 03:36:40PM +0100
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Sun, Feb 07, 1999 at 03:36:40PM +0100, Karel van Houten wrote:

> The '#ident' line makes the array initialisation incorrect. After removing
> this line, depmod compiles and works correctly.

Thanks for tracking this down.

> EGCS guru's, any hints?

Adding this to egcs-1.0.2/gcc/config/mips/linux.h at the bottom should
fix things:

/* Attach a special .ident directive to the end of the file to identify
   the version of GCC which compiled this code.  The format of the
   .ident string is patterned after the ones produced by native svr4
   C compilers.  */

#undef IDENT_ASM_OP
#define IDENT_ASM_OP ".ident"

/* Output #ident as a .ident.  */

#undef ASM_OUTPUT_IDENT
#define ASM_OUTPUT_IDENT(FILE, NAME) \
  fprintf (FILE, "\t%s\t\"%s\"\n", IDENT_ASM_OP, NAME);

I'll test this and make a real patch later.  Until that -fno-ident is the
silver bullet to avoid such sick effects.

IRIX people: I think the same bug also hits IRIX, RISC/os and others,
it's probably as long in gcc / egcs as I can think back.  At least for some
of the affected targets the above fix can not be used.

  Ralf

Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6H32so07017
	for linux-mips-outgoing; Mon, 16 Jul 2001 20:02:54 -0700
Received: from dea.waldorf-gmbh.de (u-198-18.karlsruhe.ipdial.viaginterkom.de [62.180.18.198])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6H32oV07014
	for <linux-mips@oss.sgi.com>; Mon, 16 Jul 2001 20:02:51 -0700
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f6H30ot01797;
	Tue, 17 Jul 2001 05:00:50 +0200
Date: Tue, 17 Jul 2001 05:00:50 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: Greg Johnson <gjohnson@superweasel.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: Linux on a 100MHz r4000 indy?
Message-ID: <20010717050050.A1737@bacchus.dhis.org>
References: <20010716163712.B12104@superweasel.com> <20010717032055.A1236@bacchus.dhis.org> <20010716223902.A16351@superweasel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010716223902.A16351@superweasel.com>; from gjohnson@superweasel.com on Mon, Jul 16, 2001 at 10:39:02PM -0400
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, Jul 16, 2001 at 10:39:02PM -0400, Greg Johnson wrote:

> CPU revision is: 00000422

That's a really old and buggy CPU.  Kevin Kissel may correct me but I think
it's the first series shipped to customers.  Among the fun bugs:

-----------------------------------------------------------------------------

4. R4000PC, R4000SC: An instruction sequence which contains a load which causes
   a data cache miss and a jump, where the jump instruction is that last
   instruction in the page and the delay slot of the jump is not currently
   mapped, causes the exception vector to be overwritten by the jump address.
   The R4000 will use the jump address as the exception vector.

   Example:	lw	<---- data cache miss
		noop	<---- one or two Noops
		jr	<---- last instruction in the page (jump or branch in-
			      struction)
		--------------<----	page boundary
		noop

   Workaround: Jump and branch instructions should never be in the last loca-
               tion of a page.
11. R4000PC, R4000SC: In the case:

		lw rA, (rn)
		noop		(or any non-conflicting instruction)
		lw rn, (rA)	(where the address in rA causes a TLB refill)
		--------------------> end of page
		page not mapped

   where rn and RA are general purpose registers r0 through r31

   This code sequence causes the second load instruction to slip due to a
   load use interlock. When the R4000 crosses the page boundary after the
   lw, it vectors to 0x8000 0000 and later causes an instruction cache miss.
   After the instruction cache miss is complete the LW causes another TLB
   refill. This should vector to 0x8000 0000 but instead goes to 0x8000 0180.

14 (Just an update of erratum 4)

-----------------------------------------------------------------------------

There's more but I don't want to paste the whole errata document in here
and above bugs alone without the respective workarounds in kernel and tools
are grave bugs.

  Ralf

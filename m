Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 May 2005 12:19:23 +0100 (BST)
Received: from extgw-uk.mips.com ([IPv6:::ffff:62.254.210.129]:57357 "EHLO
	bacchus.net.dhis.org") by linux-mips.org with ESMTP
	id <S8225439AbVECLTE>; Tue, 3 May 2005 12:19:04 +0100
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.1/8.13.1) with ESMTP id j43BIwdt015132;
	Tue, 3 May 2005 12:18:58 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.1/8.13.1/Submit) id j43BIw4q015131;
	Tue, 3 May 2005 12:18:58 +0100
Date:	Tue, 3 May 2005 12:18:57 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	peter fuerst <pf@net.alphadv.de>
Cc:	linux-mips@linux-mips.org
Subject: Re: Bus error question...
Message-ID: <20050503111857.GR24693@linux-mips.org>
References: <Pine.LNX.4.21.0505020149150.3024-100000@Opal.Peter>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0505020149150.3024-100000@Opal.Peter>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7844
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, May 02, 2005 at 01:55:08AM +0200, peter fuerst wrote:

> this question is posted here in the hope, it will be picked up and answered
> by some of the <*@*engr.sgi.com> gurus, i apologize to the other members of
> this mailing-list for annoying them with it as well ;-)

They've sold their souls to the evil empire.

> Is it save to assume, that memory bus errors (mc cpu_error_stat & 0x400) on
> IP28 - due to R10k's precise exception model - can be asynchronous only when
> caused by an aborted (misspeculated) instruction ?
> The R10k manual, experiences with spurious bus errors and experiments with
> "real" and speculated loads/stores seem to suggest this.
> Moreover, could it be enough to recognize the bus error as asynchrounous,
> when the exception code in cp0_cause doesn't say "Instruction bus error
> exception" (6) or "Data bus..." (7), but "Interrupt" (0) ?  (i.e. without
> analyzing the instruction at epc and register contents)
> 
> Rationale for this question: if a memory bus error can reliably be identified
> as originating from a misspeculated memory access, it would be possible to get
> rid of the myriads of cache barriers before *loads* (stores will remain
> protected by cache barriers anyway) again, and spending some thousand machine
> cycles on analyzing a bus error every three days of uptime is clearly more
> efficient than having a cache barrier in kernel code every seventeen
> instructions...

Supposedly cache barrier instructions on the R10000 are relativly cheap
but so far due to the lack of a need we haven't actually benchmarked that.

As I recall the issue loads would still fetch the line from memory
which in case of DMA buffers could result in stale data unless a cache
flush is being performed after the DMA as well.

  Ralf

Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 28 Apr 2003 01:56:46 +0100 (BST)
Received: from p508B65B8.dip.t-dialin.net ([IPv6:::ffff:80.139.101.184]:19910
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225245AbTD1A4o>; Mon, 28 Apr 2003 01:56:44 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id h3S0uef20860;
	Mon, 28 Apr 2003 02:56:40 +0200
Date: Mon, 28 Apr 2003 02:56:39 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Kip Walker <kwalker@broadcom.com>
Cc: linux-mips@linux-mips.org
Subject: Re: [PATCH]: load_mmu for SMP systems
Message-ID: <20030428025639.A20753@linux-mips.org>
References: <3EA97D54.6910D49E@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3EA97D54.6910D49E@broadcom.com>; from kwalker@broadcom.com on Fri, Apr 25, 2003 at 11:24:20AM -0700
Return-Path: <ralf@linux-mips.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-Spam-Checker-Version: SpamAssassin 2.50 (1.173-2003-02-20-exp)
X-archive-position: 2213
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Apr 25, 2003 at 11:24:20AM -0700, Kip Walker wrote:

> In SMP systems, each CPU needs to set up "current_cpu_data.tlbsize". 
> Some CPUs do this initialization in cpu_probe, which is called both by
> init_arch and start_secondary.  However, some CPUs do this in their TLB
> setup code, which is called via load_mmu.  The SMP boot code doesn't
> currently call load_mmu() for the secondary CPUs.  Here's a simple fix
> for the 2.4 tree.

I instead changed cpu-probe to set tlbsize properly.  Nothing wrong with
your patch, it just fits better into my Grand Plan (TM) :-)

> TLB flush routines that have loops running up to tlbsize will lose if
> it's not set properly on all CPUs!

Yeah, they're going to be sort of slow.  There must be a reason for all
those GHz processors ;-)

  Ralf

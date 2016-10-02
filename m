Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 02 Oct 2016 12:30:21 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:59700 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991894AbcJBKaOIyuyt (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 2 Oct 2016 12:30:14 +0200
Date:   Sun, 2 Oct 2016 11:30:13 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Matt Redfearn <matt.redfearn@imgtec.com>
cc:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <james.hogan@imgtec.com>, linux-mips@linux-mips.org
Subject: Re: [PATCH 1/9] MIPS: traps: 64bit kernels should read CP0_EBase
 64bit
In-Reply-To: <73eede89-af68-eb17-b0b3-2537084da819@imgtec.com>
Message-ID: <alpine.LFD.2.20.1610021038190.25303@eddie.linux-mips.org>
References: <cover.d93e43428f3c573bdd18d7c874830705b39c3a8a.1472747205.git-series.james.hogan@imgtec.com> <e826225b15736539cd96a1b6b2a99e2bb2b4eb87.1472747205.git-series.james.hogan@imgtec.com> <20160921130852.GA10899@linux-mips.org>
 <73eede89-af68-eb17-b0b3-2537084da819@imgtec.com>
User-Agent: Alpine 2.20 (LFD 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55308
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

On Wed, 21 Sep 2016, Matt Redfearn wrote:

> > > When reading the CP0_EBase register containing the WG (write gate) bit,
> > > the ebase variable should be set to the full value of the register, i.e.
> > > on a 64-bit kernel the full 64-bit width of the register via
> > > read_cp0_ebase_64(), and on a 32-bit kernel the full 32-bit width
> > > including bits 31:30 which may be writeable.
> > How about changing the definition of read/write_c0_ebase to
> >
> > #define read_c0_ebase()         __read_ulong_c0_register($15, 1)
> > #define write_c0_ebase(val)     __write_ulong_c0_register($15, 1, val)
> 
> James added the {read,write}_c0_ebase_64 functions in
> 37fb60f8e3f011c25c120081a73886ad8dbc42fd, because performing a 64bit access to
> 32bit cp0 registers (like ebase on 32bit cpus) was an undefined operation
> pre-r6, so we can't always access them as longs.

 Well, `long' is 32-bit with 32-bit processors, however in older (as in: 
before 3.50) architecture revisions EBase was 32-bit even with 64-bit 
processors, so I take it you meant "like ebase on 64bit cpus", right?

> > or using a new variant like
> >
> > #define read_c0_ebase_ulong()         __read_ulong_c0_register($15, 1)
> > #define write_c0_ebase_ulong(val)     __write_ulong_c0_register($15, 1, val)
> >
> > to avoid the ifdefery?  This could also make this bit
> >
> >                  ebase = cpu_has_mips64r6 ? read_c0_ebase_64()
> > : (s32)read_c0_ebase();
> 
> This relies on being able to determine a 64bit value for ebase, either by
> reading it in its entirety on a 64bit cpu (including on a 32bit kernel) or sign
> extending it from a 32bit read.

 This does look wrong to me, as I noted above EBase is 64-bit with MIPS64 
processors as from architecture revision 3.50.  Also I don't think we want 
to have EBase set to outside the 32-bit address space with 32-bit kernels.

 So Ralf's proposal is actually close to being right, except for the 
condition.  I'd also move the condition to the macro definition itself so 
that it doesn't have to be repeated inline, making the whole piece in 
question look like:

#define read_c0_ebase		(cpu_has_ebase_wg ?
				 __read_ulong_c0_register($15, 1) :
				 __read_32bit_c0_register($15, 1))

	if (cpu_has_veic || cpu_has_vint) {
		unsigned long size = 0x200 + VECTORSPACING*64;
		ebase = (unsigned long)
		__alloc_bootmem(size, 1 << fls(size), 0);
        } else if (cpu_has_mips_r2_r6) {
		ebase = read_c0_ebase() & ~0xfff;
	} else {
		ebase = CAC_BASE;
	}

-- short and sweet, isn't it?

  Maciej

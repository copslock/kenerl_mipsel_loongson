Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Jan 2006 15:00:10 +0000 (GMT)
Received: from mipsfw.mips-uk.com ([194.74.144.146]:30985 "EHLO
	bacchus.net.dhis.org") by ftp.linux-mips.org with ESMTP
	id S8133367AbWAYO7x (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 25 Jan 2006 14:59:53 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.4) with ESMTP id k0PF44iI012322;
	Wed, 25 Jan 2006 15:04:04 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.4/8.13.4/Submit) id k0PF44EA012321;
	Wed, 25 Jan 2006 15:04:04 GMT
Date:	Wed, 25 Jan 2006 15:04:04 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Franck <vagabon.xyz@gmail.com>
Cc:	"Kevin D. Kissell" <kevink@mips.com>, linux-mips@linux-mips.org
Subject: Re: [RFC] Optimize swab operations on mips_r2 cpu
Message-ID: <20060125150404.GF3454@linux-mips.org>
References: <cda58cb80601250136p5ee350e6g@mail.gmail.com> <20060125124738.GA3454@linux-mips.org> <cda58cb80601250534r5f464fd1v@mail.gmail.com> <43D78725.6050300@mips.com> <20060125141424.GE3454@linux-mips.org> <cda58cb80601250632r3e8f7b9en@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cda58cb80601250632r3e8f7b9en@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10144
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Jan 25, 2006 at 03:32:22PM +0100, Franck wrote:

> > We have CPU_MIPS32_R1, CPU_MIPS32_R2, CPU_MIPS64_R1, CPU_MIPS64_R2.
> > Based on those we also define CPU_MIPS32, CPU_MIPS64, CPU_MIPSR1,
> > and CPU_MIPSR2 as short cuts.
> >
> 
> hm I should have missed something, but what about CPUs which have
> their own CPU_XXX (different form CPU_MIPS32_R[12]) and which are a
> mips32-r2 compliant for example ? (I'm thinking of 4KSD for example)

The 4KSD is still a MIPS32 processor - just one with an ASE.

The real bug here - and what's causing your confusion - is that the
processor configuration is mixing up all the architecture variants
(MIPS I - IV, MIPS32 and MIPS64 R1/R2, weirdo variants ...) and the
processor types.  Example: 4K, 4KE, 24K, 24KE, 34K, AMD Alchemy are all
MIPS32 (either R1 or R2).  R4000, R4400, R4600 are all MIPS III.  But
what we actually offer in the processor configuration is R4X00, MIPS32_R1,

  Ralf

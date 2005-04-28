Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Apr 2005 14:41:26 +0100 (BST)
Received: from extgw-uk.mips.com ([IPv6:::ffff:62.254.210.129]:32525 "EHLO
	bacchus.net.dhis.org") by linux-mips.org with ESMTP
	id <S8225767AbVD1NlL>; Thu, 28 Apr 2005 14:41:11 +0100
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.1/8.13.1) with ESMTP id j3SDfJsn001936;
	Thu, 28 Apr 2005 14:41:19 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.1/8.13.1/Submit) id j3SDfIK5001935;
	Thu, 28 Apr 2005 14:41:18 +0100
Date:	Thu, 28 Apr 2005 14:41:18 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org
Subject: Re: preempt safe fpu-emulator
Message-ID: <20050428134118.GC1276@linux-mips.org>
References: <20050427.143622.77402407.nemoto@toshiba-tops.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050427.143622.77402407.nemoto@toshiba-tops.co.jp>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7813
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Apr 27, 2005 at 02:36:22PM +0900, Atsushi Nemoto wrote:

> Hi.  Here is a patch to make the fpu-emulator preempt-safe.  It would
> be SMP-safe also.
> 
> The 'ieee754_csr' global variable is removed.  Now the 'ieee754_csr'
> is an alias of current->thread.fpu.soft.fcr31.  While the fpu-emulator
> uses different mapping for RM bits (FPU_CSR_Rm vs. IEEE754_Rm), RM
> bits are converted before (and after) calling of cop1Emulate().  If we
> adjusted IEEE754_Rm to match with FPU_CSR_Rm, we can remove ieee_rm[]
> and mips_rm[].  Should we do it?
> 
> With this patch, whole fpu-emulator can be run without disabling
> preempt.  I will post a patch to fix preemption issue soon.

I applied both your patches with some slight cleanup for the endianess
stuff in arch/mips/math-emu/ieee754.h and non-Linux stuff.

  Ralf

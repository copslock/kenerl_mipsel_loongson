Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 08 May 2010 18:46:16 +0200 (CEST)
Received: from mv-drv-hcb004.ocn.ad.jp ([118.23.109.134]:42036 "EHLO
        mv-drv-hcb004.ocn.ad.jp" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491868Ab0EHQqL (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 8 May 2010 18:46:11 +0200
Received: from vcmba.ocn.ne.jp (localhost.localdomain [127.0.0.1])
        by mv-drv-hcb004.ocn.ad.jp (Postfix) with ESMTP id 07C7E1B402E;
        Sun,  9 May 2010 01:46:04 +0900 (JST)
Received: from localhost (softbank221040169135.bbtec.net [221.40.169.135])
        by vcmba.ocn.ne.jp (Postfix) with ESMTP;
        Sun,  9 May 2010 01:46:03 +0900 (JST)
Date:   Sun, 09 May 2010 01:46:02 +0900 (JST)
Message-Id: <20100509.014602.173372140.anemo@mba.ocn.ne.jp>
To:     kevink@paralogos.com
Cc:     ralf@linux-mips.org, mcdonald.shane@gmail.com,
        linux-mips@linux-mips.org
Subject: Re: [MIPS] FPU emulator: allow Cause bits of FCSR to be writeable
 by ctc1
From:   Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <4BE1C4EA.1020202@paralogos.com>
References: <4BE19214.4010209@paralogos.com>
        <20100506.012240.118951273.anemo@mba.ocn.ne.jp>
        <4BE1C4EA.1020202@paralogos.com>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 5.2 on Emacs 22.2 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26645
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Wed, 05 May 2010 12:20:10 -0700, "Kevin D. Kissell" <kevink@paralogos.com> wrote:
> > Yes, that's my patch.  Though I cannot remember precisely, maybe I
> > just had (mis)thought Cause bits in FCSR are read-only at that time.
> > I have never used real SMP MIPS platforms, so there must be no
> > SMP-related issues.
> >
> The patch was labeled for "preemption and SMP problems", and if you 
> weren't working on an SMP system, I'd guess that you were working with 
> full preemption and seeing a problem that you might have assumed was 
> also relevant to SMP.  The FPU emulator *shouldn't* have pre-emption 
> issues, since it works off of data structures that are instantiated per 
> thread context.  The FCSR seen by thread A is logically independent of 
> that seen by thread B, so that even if one emulation was preempted in 
> the middle by another, they shouldn't be able to interfere with one 
> another.  That was the concept, anyway.

Yes, I created the patch for full preemption support. At that time,
ieee754_csr was a global variable, not an alias of
current->thread.fpu.soft.fcr31.

The commmit 72402e was mixture of two patch: "just make FPU emulator
fully-preemptive" and "fix FPU ownership issues on preemption".  The
wrong code is a part of the first one.  So I don't think your fix
causes any regressions on SMP/preemption point of view.

I'm still trying to remember why I masked out some bits on CTC1
emulation, but no success.  Maybe I was just confused.

Anyway, thanks Shane and Kevin!

---
Atsushi Nemoto

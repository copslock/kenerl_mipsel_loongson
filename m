Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 May 2010 18:22:51 +0200 (CEST)
Received: from mv-drv-hcb003.ocn.ad.jp ([118.23.109.133]:56763 "EHLO
        mv-drv-hcb003.ocn.ad.jp" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492149Ab0EEQWr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 5 May 2010 18:22:47 +0200
Received: from vcmba.ocn.ne.jp (localhost.localdomain [127.0.0.1])
        by mv-drv-hcb003.ocn.ad.jp (Postfix) with ESMTP id A80A656421D;
        Thu,  6 May 2010 01:22:42 +0900 (JST)
Received: from localhost (softbank221040169135.bbtec.net [221.40.169.135])
        by vcmba.ocn.ne.jp (Postfix) with ESMTP;
        Thu,  6 May 2010 01:22:42 +0900 (JST)
Date:   Thu, 06 May 2010 01:22:40 +0900 (JST)
Message-Id: <20100506.012240.118951273.anemo@mba.ocn.ne.jp>
To:     kevink@paralogos.com
Cc:     ralf@linux-mips.org, mcdonald.shane@gmail.com,
        linux-mips@linux-mips.org
Subject: Re: [MIPS] FPU emulator: allow Cause bits of FCSR to be writeable
 by ctc1
From:   Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <4BE19214.4010209@paralogos.com>
References: <4BE122D1.3000609@paralogos.com>
        <20100505091159.GA4016@linux-mips.org>
        <4BE19214.4010209@paralogos.com>
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
X-archive-position: 26605
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Wed, 05 May 2010 08:43:16 -0700, "Kevin D. Kissell" <kevink@paralogos.com> wrote:
> >> I'm glad to hear that the patch is functional.  It was pretty clear that
> >> it would solve your problem, but I was concerned that the inability to
> >> write the Cause bits was done as a way around some other problem. 
> >> Someone went to a certain amount of trouble to not accept them as
> >> inputs, in violation of spec.  I just looked back, and the bug was
> >> introduced as part of a patch of Ralf's from April 2005 entitled "Fix
> >> Preemption and SMP problems in the FP emulator".  It's unlikely that
> >> overriding CTC semantics actually fixed any underlying problems, but it
> >> may have masked symptoms of problems that we can only hope have been
> >> fixed in the mean time. Anyone run this patch on an FPUless SMP?   Oh,
> >> for a 34Kf with a bunch of TCs! ;o)
> >>     
> >
> > That's commit ID 72402ec9efdb2ea7e0ec6223cf20e7301a57da02 and the patch
> > was comitted during the CVS days which only records the comitter but not
> > the author.  The actual author is Atsushi Nemoto.
> >   
> Well,. I certainly understood that you were simply the guy who did the
> commit.  Didn't mean to make it sound like an accusation, but it was
> marginally easier to type your name and date than to find, cut, and
> paste the commit ID.  Sorry if it came off wrong.  It would be cool if
> Atsushi remembered the reasoning behind the change, but empirical proof
> that undoing it doesn't create a subtle problem for current SMP kernels
> would be better still.

Yes, that's my patch.  Though I cannot remember precisely, maybe I
just had (mis)thought Cause bits in FCSR are read-only at that time.
I have never used real SMP MIPS platforms, so there must be no
SMP-related issues.

I'm OK with Kevin's fix.  Thank you very much for reporting and
investigating.

---
Atsushi Nemoto

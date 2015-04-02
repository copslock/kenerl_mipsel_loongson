Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Apr 2015 14:59:30 +0200 (CEST)
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S27014353AbbDBM71cHNn1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 2 Apr 2015 14:59:27 +0200
Date:   Thu, 2 Apr 2015 13:59:27 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     cee1 <fykcee1@gmail.com>
cc:     Ralf Baechle <ralf@linux-mips.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Chen Jie <chenj@lemote.com>
Subject: Re: [v5] MIPS: lib: csum_partial: more instruction paral
In-Reply-To: <CAGXxSxU_fCvUqkrFDU64MOgsyOW3XkcrSuB7DjcBMODG-B8=xw@mail.gmail.com>
Message-ID: <alpine.LFD.2.11.1504021342130.5791@eddie.linux-mips.org>
References: <1427389644-92793-1-git-send-email-fykcee1@gmail.com> <20150330201015.GA3757@linux-mips.org> <CAGXxSxU_fCvUqkrFDU64MOgsyOW3XkcrSuB7DjcBMODG-B8=xw@mail.gmail.com>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46701
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

On Tue, 31 Mar 2015, cee1 wrote:

> >> One example about how this patch works is in CSUM_BIGCHUNK1:
> >> // ** original **    vs    ** patch applied **
> >>     ADDC(sum, t0)           ADDC(t0, t1)
> >>     ADDC(sum, t1)           ADDC(t2, t3)
> >>     ADDC(sum, t2)           ADDC(sum, t0)
> >>     ADDC(sum, t3)           ADDC(sum, t2)
> >>
> >> With this patch applied, ADDC and the **next next** ADDC are independent.
> >
> > This is interesting because even CPUs as old as the R2000 have a pipeline
> > bypass which allows an instruction to use a result written to a register
> > by an immediately preceeeding instruction.
> 
> But if removes some dependency(as the patch did), instruction A and
> instruction B can be issued at the same cycle[1], instead of B waiting
> for the result from A   (a pipeline bypass reduces the wait time, but
> not eliminates it, right?)

 Hmm, that sounds to me remarkably like the scenario with Intel's original 
Pentium processor that had a dual issue pipeline with U and V execution 
pipes, both of which accepted ALU operations, and then each had some 
further constraints as to other instructions, some of which had to go to a 
specific pipe of the two (and were still parallelised if the other 
instruction was acceptable for the other pipe).

 To get good performance out of that design you had to interleave ALU 
operations so that there was no data dependency between two consecutive 
instructions, in which case two instructions could have been issued and 
retired at a time, in parallel.  The further constraints the U and V pipes 
had with other instructions made instruction scheduling quite an 
interesting challenge for the compiler or handcoded assembly.

 With the more complex pipeline design the Pentium's successor Pentium Pro 
had there was no longer such an issue, I reckon there were several 
mechanisms involved including register renaming and speculative execution 
of more than just two instructions ahead that eliminated the need of such 
constrained instruction scheduling although I don't remember offhand how 
all this worked.

> > Can you explain why this patch is so beneficial for Loongson 3A?
> 
> I have written a simply test[2] to measure the performance gain on
> Loongson 3A, the result[3] shows at most 50% performance gain.
> 
> IMHO, the patch not only benefits Loongson 3A, but would also benefit
> other MIPS CPU(s).

 I'm not sure if any such other superscalar MIPS pipeline implementation 
exists, but if written correctly then at worst it won't hurt anyone else, 
so just make sure your change does not regress scalar MIPS pipelines.  I 
hope you have a way to verify it.

  Maciej

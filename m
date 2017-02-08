Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Feb 2017 22:56:42 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:18530 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992221AbdBHV4fMyQL3 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 8 Feb 2017 22:56:35 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTP id 66E2B8644E278;
        Wed,  8 Feb 2017 21:56:21 +0000 (GMT)
Received: from [10.20.78.134] (10.20.78.134) by hhmail02.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server id 14.3.294.0; Wed, 8 Feb 2017
 21:56:24 +0000
Date:   Wed, 8 Feb 2017 21:56:14 +0000
From:   "Maciej W. Rozycki" <macro@imgtec.com>
To:     James Hogan <james.hogan@imgtec.com>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>,
        <linux-mips@linux-mips.org>
Subject: Re: [PATCH] MIPS: Fix protected_cache(e)_op() for microMIPS
In-Reply-To: <20170208103547.22560-1-james.hogan@imgtec.com>
Message-ID: <alpine.DEB.2.00.1702082127060.26999@tp.orcam.me.uk>
References: <20170208103547.22560-1-james.hogan@imgtec.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.20.78.134]
Return-Path: <Maciej.Rozycki@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56737
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@imgtec.com
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

On Wed, 8 Feb 2017, James Hogan wrote:

> When building for microMIPS we need to ensure that the assembler always
> knows that there is code at the target of a branch or jump. Commit
> 7170bdc77755 ("MIPS: Add return errors to protected cache ops")
> introduced a fixup path to protected_cache(e)_op() which does not meet
> this requirement. The fixup path jumps to the "2" label but we don't
> know what will be placed at that label since it's at the end of the
> inline asm. If the inline asm happens to be followed by an instruction
> manually encoded with .word or similar then the toolchain will not know
> that "2" labels code and linking will fail with:
> 
>   mips-img-linux-gnu-ld: arch/mips/mm/c-r4k.o: .fixup+0x0: Unsupported
>   jump between ISA modes; consider recompiling with interlinking
>   enabled.

 That is not really the cause.  The cause is the `.section' pseudo-op that 
immediately physically follows, and which causes GAS to fix its current 
state.  Since by this point it hasn't seen an instruction any outstanding 
labels that haven't been finalised will be marked as `object' (i.e. data).  
So it doesn't really matter what follows the inline asm, an ISA mode 
mismatch will always happen here.

 The amount of infrastructure that would be required to have state saved 
and then restored where applicable to "see through section switches" is 
substantial enough for no one to have tried implementing it so far. 

 Consequently all places where a code label is immediately followed by one 
of the section switch directives (technically, by the syntax rules of the 
assembly language, such a label is attached to the directive), such as 
`.section', `.previous', `.popsection', etc., need to have `.insn' added 
to be treated correctly (arguably we could make them mark labels as 
`function' instead, however I fear it may break something out there in a 
subtler way as you won't get a similar error for data accesses and the 
semantics has been like this since the introduction of MIPS16 support back 
in 1996).

 I suggest that you send an update with the description amended so as not 
to confuse people about the actual cause.  Overall, unless you have done 
that already, I think it would be the best if our sources were reviewed 
for any remaining places across the MIPS port where a code label is 
followed by a section switch and `.insn' added there right away.  It will 
prevent people sneaking in new bad code by copying and pasting from the 
wrong place.

 I'll be happy to ack a patch with an updated description.

  Maciej

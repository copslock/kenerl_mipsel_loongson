Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Apr 2015 02:43:14 +0200 (CEST)
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S27010172AbbDHAnMGrVQZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 8 Apr 2015 02:43:12 +0200
Date:   Wed, 8 Apr 2015 01:43:12 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     James Hogan <james.hogan@imgtec.com>
cc:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>,
        Gleb Natapov <gleb@kernel.org>
Subject: Re: [PATCH 02/20] MIPS: Clear [MSA]FPE CSR.Cause after
 notify_die()
In-Reply-To: <1426085096-12932-3-git-send-email-james.hogan@imgtec.com>
Message-ID: <alpine.LFD.2.11.1504080113360.21028@eddie.linux-mips.org>
References: <1426085096-12932-1-git-send-email-james.hogan@imgtec.com> <1426085096-12932-3-git-send-email-james.hogan@imgtec.com>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46833
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

On Wed, 11 Mar 2015, James Hogan wrote:

> When handling floating point exceptions (FPEs) and MSA FPEs the Cause
> bits of the appropriate control and status register (FCSR for FPEs and
> MSACSR for MSA FPEs) are read and cleared before enabling interrupts,
> presumably so that it doesn't have to go through the pain of restoring
> those bits if the process is pre-empted, since writing those bits would
> cause another immediate exception while still in the kernel.

 Another reason is MIPS I processors (and for the record I believe the 
R6000 MIPS II implementation as well) signal FPA exceptions using an 
ordinary interrupt, seen on one of the IP[7:2] bits in the CP0 Cause 
register.  Consequently reenabling interrupts without first clearing at 
least all the unmasked FCSR.Cause bits would retrigger the interrupt and 
cause an infinite loop.

 We don't ever mask the FPA interrupt with the relevant IM[7:2] bit in the 
CP0 Status register, because for simplicity we reuse the whole of the FPE 
exception handling path for FPA interrupts as well.  Except that we enter 
it via the `handle_fpe_int' alternative entry point rather than the usual 
`handle_fpe' one, bypassing the register save sequence as it was already 
done by the interrupt handler.

  Maciej

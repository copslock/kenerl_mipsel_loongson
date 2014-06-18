Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Jun 2014 17:49:10 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:34060 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6859954AbaFRPtGLF63E (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 18 Jun 2014 17:49:06 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.7/8.14.4) with ESMTP id s5IFn2Bu001578;
        Wed, 18 Jun 2014 17:49:02 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.7/8.14.7/Submit) id s5IFmx5u001556;
        Wed, 18 Jun 2014 17:48:59 +0200
Date:   Wed, 18 Jun 2014 17:48:59 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Paul Burton <paul.burton@imgtec.com>
Cc:     linux-mips@linux-mips.org,
        "Joseph S. Myers" <joseph@codesourcery.com>, stable@vger.kernel.org
Subject: Re: [PATCH] Revert "MIPS: Save/restore MSA context around signals"
Message-ID: <20140618154858.GF26335@linux-mips.org>
References: <1403100046-5693-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1403100046-5693-1-git-send-email-paul.burton@imgtec.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40634
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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

On Wed, Jun 18, 2014 at 03:00:46PM +0100, Paul Burton wrote:

> This reverts commit eec43a224cf1 "MIPS: Save/restore MSA context around
> signals" and the MSA parts of ca750649e08c "MIPS: kernel: signal:
> Prevent save/restore FPU context in user memory" (the restore path of
> which appears incorrect anyway...).
> 
> The reverted patch took care not to break compatibility with userland
> users of struct sigcontext, but inadvertantly changed the offset of the
> uc_sigmask field of struct ucontext. Thus Linux v3.15 breaks the
> userland ABI. The MSA context will need to be saved via some other
> opt-in mechanism, but for now revert the change to reduce the fallout.
> 
> This will have minimal impact upon use of MSA since the only supported
> CPU which includes it (the P5600) is 32-bit and therefore requires that
> the experimental CONFIG_MIPS_O32_FP64_SUPPORT Kconfig option be selected
> before the kernel will set FR=1 for a task, a requirement for MSA use.
> Thus the users of MSA are limited to known small groups of people & this
> patch won't be breaking any previously working MSA-using userland
> outside of experimental settings.
> 
> Cc: stable@vger.kernel.org
> Reported-by: Joseph S. Myers <joseph@codesourcery.com>
> Signed-off-by: Paul Burton <paul.burton@imgtec.com>
> ---
> Ralf: if this can get into mainline ASAP so it can hit the 3.15 stable
> branch too that would be great. Sorry for this!

I tried to apply this to my fixes branch which is 3.16-rc1-based but
I'm getting rejects:

--- arch/mips/kernel/asm-offsets.c
+++ arch/mips/kernel/asm-offsets.c
@@ -296,8 +296,6 @@
        OFFSET(SC_LO2, sigcontext, sc_lo2);
        OFFSET(SC_HI3, sigcontext, sc_hi3);
        OFFSET(SC_LO3, sigcontext, sc_lo3);
-       OFFSET(SC_MSAREGS, sigcontext, sc_msaregs);
-       OFFSET(SC_MSA_CSR, sigcontext, sc_msa_csr);
        BLANK();
 }
 #endif
@@ -312,8 +310,6 @@
        OFFSET(SC_MDLO, sigcontext, sc_mdlo);
        OFFSET(SC_PC, sigcontext, sc_pc);
        OFFSET(SC_FPC_CSR, sigcontext, sc_fpc_csr);
-       OFFSET(SC_MSAREGS, sigcontext, sc_msaregs);
-       OFFSET(SC_MSA_CSR, sigcontext, sc_msa_csr);
        BLANK();
 }
 #endif
@@ -325,8 +321,6 @@
        OFFSET(SC32_FPREGS, sigcontext32, sc_fpregs);
        OFFSET(SC32_FPC_CSR, sigcontext32, sc_fpc_csr);
        OFFSET(SC32_FPC_EIR, sigcontext32, sc_fpc_eir);
-       OFFSET(SC32_MSAREGS, sigcontext32, sc_msaregs);
-       OFFSET(SC32_MSA_CSR, sigcontext32, sc_msa_csr);
        BLANK();
 }
 #endif

This is rejecting because the upstream asm-offsets.c doesn't contain
the SC_MSA_CSR / SC32_MSA_CSR lines.  Also hunk2 of r4k_fpu.S is
rejecting.

I've fixed the rejects and applied this as c0a098f1 to upstream-sfr
but you may want to test this and resubmit it for -stable.

Cheers,

  Ralf

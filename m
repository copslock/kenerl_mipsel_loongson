Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Apr 2015 17:24:35 +0200 (CEST)
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S27007783AbbDGPYcfJW4b (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 7 Apr 2015 17:24:32 +0200
Date:   Tue, 7 Apr 2015 16:24:32 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>
cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH 46/48] MIPS: math-emu: Make ABS.fmt and NEG.fmt arithmetic
 again
In-Reply-To: <alpine.LFD.2.11.1504032201480.21028@eddie.linux-mips.org>
Message-ID: <alpine.LFD.2.11.1504071620230.21028@eddie.linux-mips.org>
References: <alpine.LFD.2.11.1504030054200.21028@eddie.linux-mips.org> <alpine.LFD.2.11.1504032201480.21028@eddie.linux-mips.org>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46806
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

On Fri, 3 Apr 2015, Maciej W. Rozycki wrote:

> The ABS.fmt and NEG.fmt instructions have been specified as arithmetic 
> in the MIPS architecture, which in particular implies handling NaN data 
> in the usual way with qNaN bit patterns propagated unchanged and sNaN 
> bit patterns signalling the usual IEEE 754 Invalid Operation exception 
> and quieted by default.
> 
> A series of changes applied over time to our implementation:
> 
> c5033d78 [MIPS] ieee754[sd]p_neg workaround
> cea2be44 MIPS: Fix abs.[sd] and neg.[sd] emulation for NaN operands
> 
> has led to the current situation where the sign bit is updated according 
> to the operation requested even for NaN inputs.  This is according to 
> these commits a workaround so that broken binaries produced by GCC 
> disregarding the properties of these instructions have a chance to work.
> 
> For sNaN inputs this remains within IEEE Std 754 as the standard leaves 
> the choice of output qNaN bit patterns produced under the default 
> Invalid Operation exception handling for individual sNaN input bit 
> patterns to implementer's discretion, even though it still recommends as 
> much NaN input information to be preserved in NaN outputs.
> 
> For qNaN inputs however it violates the standard as it requires a qNaN 
> input bit patterns to propagate unchanged to output.
> 
> This is also unlike real MIPS FPU hardware behaves where sNaN and/or 
> qNaN processing has been fully implemented with no Unimplemented 
> Operation exception signalled.  Such hardware propagates any input qNaN 
> bit pattern unchanged.  It also quiets any input sNaN bit pattern in an 
> implementer-specific manner, for example the MIPS 74Kf processor returns 
> the default qNaN pattern with the sign bit always clear and the Broadcom 
> SB-1 and BMIPS5000 processors propagate the input sNaN bit pattern with 
> the sign bit unchanged and the quiet bit first cleared in the trailing 
> significand field and then the next lower bit set if clearing the quiet 
> bit left the field with no other bit set.
> 
> Especially the latter observation indicates the limited usefulness of 
> the workaround as it will cover many hardware configurations, but not 
> all of them, only making it harder to discover such broken binaries that 
> need to be recompiled with GCC told to avoid the use of ABS.fmt and 
> NEG.fmt instructions where non-arithmetic semantics is required by the 
> algorithm used.
> 
> Revert the damage done by the series of changes then, and take the 
> opportunity to simplify implementation by calling `ieee754dp_sub' and 
> `ieee754dp_add' as required and also the rounding mode set towards -Inf 
> temporarily so that the sign of 0 is correctly handled.
> 
> Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
> ---

 One point to make here is the use of `ieee754dp_sub' and `ieee754dp_add' 
makes emulated ABS.fmt and NEG.fmt respect FCSR.FS for denormals just as 
hardware does.  I should have noted that in the commit message, perhaps it 
can be retrofitted?

  Maciej

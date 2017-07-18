Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 Jul 2017 13:44:57 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:56764 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990924AbdGRLot4nJPZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 18 Jul 2017 13:44:49 +0200
Date:   Tue, 18 Jul 2017 12:44:49 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>
cc:     linux-mips@linux-mips.org, stable@vger.kernel.org
Subject: Re: [PATCH] MIPS: DEC: Fix an int-handler.S CPU_DADDI_WORKAROUNDS
 regression
In-Reply-To: <alpine.LFD.2.20.1707090226390.5208@eddie.linux-mips.org>
Message-ID: <alpine.LFD.2.20.1707181236230.26637@eddie.linux-mips.org>
References: <alpine.LFD.2.20.1707090226390.5208@eddie.linux-mips.org>
User-Agent: Alpine 2.20 (LFD 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59132
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

On Sun, 9 Jul 2017, Maciej W. Rozycki wrote:

> Fix a commit 3021773c7c3e ("MIPS: DEC: Avoid la pseudo-instruction in 
> delay slots") regression and remove assembly errors:
> 
> arch/mips/dec/int-handler.S: Assembler messages:
> arch/mips/dec/int-handler.S:162: Error: Macro used $at after ".set noat"
> arch/mips/dec/int-handler.S:163: Error: Macro used $at after ".set noat"
> arch/mips/dec/int-handler.S:229: Error: Macro used $at after ".set noat"
> arch/mips/dec/int-handler.S:230: Error: Macro used $at after ".set noat"
> 
> triggering with with the CPU_DADDI_WORKAROUNDS option set and the DADDIU 
> instruction.  This is because with that option in place the instruction 
> becomes a macro, which expands to an LI/DADDU (or actually ADDIU/DADDU) 
> sequence that uses $at as a temporary register.  Use ADDIU instead then, 
> which is equivalent when used with LUI to compose the intermediate 
> 32-bit values.

 64-bit DEC configurations unconditionally select CPU_DADDI_WORKAROUNDS, 
which in turn requires KBUILD_SYM32 or a build error is triggered in our 
top-level arch Makefile.  Therefore this issue can be handled better, by 
checking for KBUILD_64BIT_SYM32 and then the problematic 64-bit leg of 
the #ifdef can be reduced to #error, as not supposed to be ever enabled.

 Withdrawing this patch then, I'll send a different one soon.

  Maciej

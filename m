Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 May 2013 21:06:04 +0200 (CEST)
Received: from kymasys.com ([64.62.140.43]:40161 "HELO kymasys.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with SMTP
        id S6835058Ab3EVTGDIkzWI convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 22 May 2013 21:06:03 +0200
Received: from ::ffff:75.40.23.192 ([75.40.23.192]) by kymasys.com for <linux-mips@linux-mips.org>; Wed, 22 May 2013 12:05:51 -0700
Subject: Re: [PATCH v5 0/6] mips/kvm: Fix ABI for compatibility with 64-bit guests.
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=us-ascii
From:   Sanjay Lal <sanjayl@kymasys.com>
In-Reply-To: <1369248236-27237-1-git-send-email-ddaney.cavm@gmail.com>
Date:   Wed, 22 May 2013 12:05:52 -0700
Cc:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        kvm@vger.kernel.org, Gleb Natapov <gleb@redhat.com>,
        linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <1DD81AF9-D720-4A61-8468-1D61558C9BA1@kymasys.com>
References: <1369248236-27237-1-git-send-email-ddaney.cavm@gmail.com>
To:     David Daney <ddaney.cavm@gmail.com>
X-Mailer: Apple Mail (2.1283)
Return-Path: <sanjayl@kymasys.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36538
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sanjayl@kymasys.com
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


On May 22, 2013, at 11:43 AM, David Daney wrote:

> From: David Daney <david.daney@cavium.com>
> 
> The initial patch set implementing MIPS KVM does not handle 64-bit
> guests or use of the FPU.  This patch set corrects these ABI issues,
> and does some very minor clean up.
> 
> Changes from v4: No code change, just keep more of the code in
>                 kvm_mips.c rather than kvm_trap_emul.c
> 
> Changes from v3: Use KVM_SET_ONE_REG instead of KVM_SET_MSRS.  Added
>                 ENOIOCTLCMD patch.
> 
> Changes from v2: Split into five parts, no code change.
> 
> David Daney (6):
>  mips/kvm: Fix ABI for use of FPU.
>  mips/kvm: Fix ABI for use of 64-bit registers.
>  mips/kvm: Fix name of gpr field in struct kvm_regs.
>  mips/kvm: Use ARRAY_SIZE() instead of hardcoded constants in
>    kvm_arch_vcpu_ioctl_{s,g}et_regs
>  mips/kvm: Fix ABI by moving manipulation of CP0 registers to
>    KVM_{G,S}ET_ONE_REG
>  mips/kvm: Use ENOIOCTLCMD to indicate unimplemented ioctls.
> 
> arch/mips/include/asm/kvm.h      | 137 +++++++++++++++----
> arch/mips/include/asm/kvm_host.h |   4 -
> arch/mips/kvm/kvm_mips.c         | 278 ++++++++++++++++++++++++++++++++++++---
> arch/mips/kvm/kvm_trap_emul.c    |  50 -------
> 4 files changed, 367 insertions(+), 102 deletions(-)
> 
> -- 
> 1.7.11.7

Acked-by: Sanjay Lal <sanjayl@kymasys.com>

Regards
Sanjay

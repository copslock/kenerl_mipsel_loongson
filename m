Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 May 2013 01:11:41 +0200 (CEST)
Received: from kymasys.com ([64.62.140.43]:53511 "HELO kymasys.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with SMTP
        id S6823054Ab3EFXLk5aWpW convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 7 May 2013 01:11:40 +0200
Received: from ::ffff:75.40.23.192 ([75.40.23.192]) by kymasys.com for <linux-mips@linux-mips.org>; Mon, 6 May 2013 16:11:30 -0700
Subject: Re: [PATCH] mips/kvm: Fix ABI for compatibility with 64-bit guests.
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=us-ascii
From:   Sanjay Lal <sanjayl@kymasys.com>
In-Reply-To: <1367879980-2440-1-git-send-email-ddaney.cavm@gmail.com>
Date:   Mon, 6 May 2013 16:11:34 -0700
Cc:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Daney <david.daney@cavium.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <1069B54B-C9CD-4333-B56F-B0E1D740CADB@kymasys.com>
References: <1367879980-2440-1-git-send-email-ddaney.cavm@gmail.com>
To:     David Daney <ddaney.cavm@gmail.com>
X-Mailer: Apple Mail (2.1283)
Return-Path: <sanjayl@kymasys.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36331
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


On May 6, 2013, at 3:39 PM, David Daney wrote:

> 
> /* for KVM_GET_REGS and KVM_SET_REGS */
> +/*
> + * If Config[AT] is zero (32-bit CPU), the register contents are
> + * stored in the lower 32-bits of the struct kvm_regs fields and sign
> + * extended to 64-bits.
> + */
> struct kvm_regs {
> -	__u32 gprs[32];
> -	__u32 hi;
> -	__u32 lo;
> -	__u32 pc;
> +	/* out (KVM_GET_REGS) / in (KVM_SET_REGS) */
> +	__u64 gpr[32];
> +	__u64 hi, lo;
> +	__u64 pc;
> +};
> 
> -	__u32 cp0reg[N_MIPS_COPROC_REGS][N_MIPS_COPROC_SEL];

Hi David, I'll try out the diff with QEMU and confirm that it works as expected. Could you just leave the GPR field in kvm_regs as "gprs". Its a minor change but avoids diffs that just replace "gprs" with "gpr".

Regards
Sanjay

Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Apr 2015 09:59:10 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:57084 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010711AbbDWH7If8FqW (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 23 Apr 2015 09:59:08 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 0ABCD2E313A88;
        Thu, 23 Apr 2015 08:59:02 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Thu, 23 Apr 2015 08:59:04 +0100
Received: from [192.168.154.77] (192.168.154.77) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Thu, 23 Apr
 2015 08:59:03 +0100
Message-ID: <5538A647.10009@imgtec.com>
Date:   Thu, 23 Apr 2015 08:59:03 +0100
From:   Markos Chandras <Markos.Chandras@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
MIME-Version: 1.0
To:     <linux-mips@linux-mips.org>
CC:     "Maciej W. Rozycki" <macro@linux-mips.org>
Subject: Re: [RFC] MIPS: Prevent "BUG: using smp_processor_id() in preemptible..."
 errors
References: <20150422172359.GA20553@paulmartin.codethink.co.uk>
In-Reply-To: <20150422172359.GA20553@paulmartin.codethink.co.uk>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.77]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47012
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Markos.Chandras@imgtec.com
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

Hi,

On 04/22/2015 06:24 PM, Paul Martin wrote:
> Commit 9b26616c8d9dae53fbac7f7cb2c6dd1308102976 "MIPS: Respect the ISA
> level in FCSR handling" added references to current_cpu_data, which is
> a macro expanding to cpu_data[smp_processor_id()].  Change these to
> raw_current_cpu_data.
> 
> These changes may or may not be a good idea.
> 
> There may also be a need for a similar change in
> arch/mips/kernel/ptrace.c which I haven't made.
> 

(^^^ missed your SOB line here? But since this RFC that might have been
intentional)

> ---
>  arch/mips/include/asm/elf.h | 4 ++--
>  arch/mips/math-emu/cp1emu.c | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/mips/include/asm/elf.h b/arch/mips/include/asm/elf.h
> index a594d8e..63f3bbc 100644
> --- a/arch/mips/include/asm/elf.h
> +++ b/arch/mips/include/asm/elf.h
> @@ -304,7 +304,7 @@ do {									\
>  									\
>  	current->thread.abi = &mips_abi;				\
>  									\
> -	current->thread.fpu.fcr31 = current_cpu_data.fpu_csr31;		\
> +	current->thread.fpu.fcr31 = raw_current_cpu_data.fpu_csr31;	\

The change looks sensible. I am wondering if
boot_cpu_data(==cpu_data[0]) is a better option though.

I leave that to Maciej.

-- 
markos

Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Nov 2011 21:01:33 +0100 (CET)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:15851 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903675Ab1KHUB0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 8 Nov 2011 21:01:26 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4eb98ae70000>; Tue, 08 Nov 2011 12:02:47 -0800
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Tue, 8 Nov 2011 12:01:23 -0800
Received: from dd1.caveonetworks.com ([64.2.3.195]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Tue, 8 Nov 2011 12:01:23 -0800
Message-ID: <4EB98A8E.4060900@cavium.com>
Date:   Tue, 08 Nov 2011 12:01:18 -0800
From:   David Daney <david.daney@cavium.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.15) Gecko/20101027 Fedora/3.0.10-1.fc12 Thunderbird/3.0.10
MIME-Version: 1.0
To:     "manesoni@cisco.com" <manesoni@cisco.com>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        "ananth@in.ibm.com" <ananth@in.ibm.com>,
        "kamensky@cisco.com" <kamensky@cisco.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: [PATCH 2/4] MIPS Kprobes: Deny probes on ll/sc instructions
References: <20111108170336.GA16526@cisco.com> <20111108170535.GC16526@cisco.com>
In-Reply-To: <20111108170535.GC16526@cisco.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 08 Nov 2011 20:01:23.0746 (UTC) FILETIME=[30EFC020:01CC9E51]
X-archive-position: 31440
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: david.daney@cavium.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 7137

On 11/08/2011 09:05 AM, Maneesh Soni wrote:
>
> From: Maneesh Soni<manesoni@cisco.com>
>
> Deny probes on ll/sc instructions for MIPS kprobes
>
> As ll/sc instruction are for atomic read-modify-write operations, allowing
> probes on top of these insturctions is a bad idea.
>

s/insturctions/instructions/

Not only is it a bad idea, it will probably make them fail 100% of the time.

It is also an equally bad idea to place a probe between any LL and SC 
instructions.  How do you prevent that?

If you cannot prevent probes between LL and SC, why bother with this at all?

David Daney

> Signed-off-by: Victor Kamensky<kamensky@cisco.com>
> Signed-off-by: Maneesh Soni<manesoni@cisco.com>
> ---
>   arch/mips/kernel/kprobes.c |   31 +++++++++++++++++++++++++++++++
>   1 files changed, 31 insertions(+), 0 deletions(-)
>
> diff --git a/arch/mips/kernel/kprobes.c b/arch/mips/kernel/kprobes.c
> index 9fb1876..0ab1a5f 100644
> --- a/arch/mips/kernel/kprobes.c
> +++ b/arch/mips/kernel/kprobes.c
> @@ -113,6 +113,30 @@ insn_ok:
>   	return 0;
>   }
>
> +/*
> + * insn_has_ll_or_sc function checks whether instruction is ll or sc
> + * one; putting breakpoint on top of atomic ll/sc pair is bad idea;
> + * so we need to prevent it and refuse kprobes insertion for such
> + * instructions; cannot do much about breakpoint in the middle of
> + * ll/sc pair; it is upto user to avoid those places
> + */
> +static int __kprobes insn_has_ll_or_sc(union mips_instruction insn)
> +{
> +	int ret = 0;
> +
> +	switch (insn.i_format.opcode) {
> +	case ll_op:
> +	case lld_op:
> +	case sc_op:
> +	case scd_op:
> +		ret = 1;
> +		break;
> +	default:
> +		break;
> +	}
> +	return ret;
> +}
> +
>   int __kprobes arch_prepare_kprobe(struct kprobe *p)
>   {
>   	union mips_instruction insn;
> @@ -121,6 +145,13 @@ int __kprobes arch_prepare_kprobe(struct kprobe *p)
>
>   	insn = p->addr[0];
>
> +	if (insn_has_ll_or_sc(insn)) {
> +		pr_notice("Kprobes for ll and sc instructions are not"
> +			  "supported\n");
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
>   	if (insn_has_delayslot(insn)) {
>   		pr_notice("Kprobes for branch and jump instructions are not"
>   			  "supported\n");

Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Nov 2011 20:57:57 +0100 (CET)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:15670 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903675Ab1KHT5t (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 8 Nov 2011 20:57:49 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4eb98a0e0000>; Tue, 08 Nov 2011 11:59:10 -0800
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Tue, 8 Nov 2011 11:57:47 -0800
Received: from dd1.caveonetworks.com ([64.2.3.195]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Tue, 8 Nov 2011 11:57:47 -0800
Message-ID: <4EB989B9.2060904@cavium.com>
Date:   Tue, 08 Nov 2011 11:57:45 -0800
From:   David Daney <david.daney@cavium.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.15) Gecko/20101027 Fedora/3.0.10-1.fc12 Thunderbird/3.0.10
MIME-Version: 1.0
To:     "manesoni@cisco.com" <manesoni@cisco.com>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        "ananth@in.ibm.com" <ananth@in.ibm.com>,
        "kamensky@cisco.com" <kamensky@cisco.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: [PATCH 1/4] MIPS Kprobes: Fix OOPS in arch_prepare_kprobe()
References: <20111108170336.GA16526@cisco.com> <20111108170454.GB16526@cisco.com>
In-Reply-To: <20111108170454.GB16526@cisco.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 08 Nov 2011 19:57:47.0256 (UTC) FILETIME=[AFE5FF80:01CC9E50]
X-archive-position: 31439
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: david.daney@cavium.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 7132

On 11/08/2011 09:04 AM, Maneesh Soni wrote:
[...]
>
> diff --git a/arch/mips/kernel/kprobes.c b/arch/mips/kernel/kprobes.c
> index ee28683..9fb1876 100644
> --- a/arch/mips/kernel/kprobes.c
> +++ b/arch/mips/kernel/kprobes.c
> @@ -25,6 +25,7 @@
>
>   #include<linux/kprobes.h>
>   #include<linux/preempt.h>
> +#include<linux/uaccess.h>
>   #include<linux/kdebug.h>
>   #include<linux/slab.h>
>
> @@ -118,11 +119,19 @@ int __kprobes arch_prepare_kprobe(struct kprobe *p)
>   	union mips_instruction prev_insn;
>   	int ret = 0;
>
> -	prev_insn = p->addr[-1];
>   	insn = p->addr[0];
>
> -	if (insn_has_delayslot(insn) || insn_has_delayslot(prev_insn)) {
> -		pr_notice("Kprobes for branch and jump instructions are not supported\n");
> +	if (insn_has_delayslot(insn)) {
> +		pr_notice("Kprobes for branch and jump instructions are not"
> +			  "supported\n");

Don't wrap these strings.

It is better to go a little bit over 80 columns, than have this.

David Daney

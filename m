Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Dec 2010 20:25:41 +0100 (CET)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:9379 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491039Ab0L2TZi (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 29 Dec 2010 20:25:38 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4d1b8b5d0000>; Wed, 29 Dec 2010 11:26:21 -0800
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Wed, 29 Dec 2010 11:25:34 -0800
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Wed, 29 Dec 2010 11:25:34 -0800
Message-ID: <4D1B8B2E.7030601@caviumnetworks.com>
Date:   Wed, 29 Dec 2010 11:25:34 -0800
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.15) Gecko/20101027 Fedora/3.0.10-1.fc12 Thunderbird/3.0.10
MIME-Version: 1.0
To:     Maksim Rayskiy <maksim.rayskiy@gmail.com>
CC:     linux-mips <linux-mips@linux-mips.org>,
        "Kevin D. Kissell" <kevink@paralogos.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH RESEND] MIPS: Add local_flush_tlb_all_mm to clear all
 mm contexts on calling cpu
References: <AANLkTimKSauYdv-cfSmc3cxQo3-YE4sOpLQ7sepwJf==@mail.gmail.com>
In-Reply-To: <AANLkTimKSauYdv-cfSmc3cxQo3-YE4sOpLQ7sepwJf==@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 29 Dec 2010 19:25:34.0950 (UTC) FILETIME=[2A720060:01CBA78E]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28771
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

On 12/29/2010 11:04 AM, Maksim Rayskiy wrote:
>  From 9a03661a40407e14ee75295f5541f371f0a7cdda Mon Sep 17 00:00:00 2001
> From: Maksim Rayskiy<maksim.rayskiy@gmail.com>
> Date: Tue, 30 Nov 2010 11:34:31 -0800
> Subject: [PATCH] MIPS: Add local_flush_tlb_all_mm to clear all mm
> contexts on calling cpu
>
> When hotplug removing a cpu, all mm context TLB entries must be cleared
> to avoid ASID conflict when cpu is restarted.
> New functions local_flush_tlb_all_mm() and all-cpu version
> flush_tlb_all_mm() are added.
> To function properly, local_flush_tlb_all_mm() must be called when
> mm_cpumask for all mm context on given cpu is cleared.
>
> Signed-off-by: Maksim Rayskiy<maksim.rayskiy@gmail.com>
> ---
> =A0arch/mips/include/asm/tlbflush.h | =A0 =A04 ++++
> =A0arch/mips/kernel/smp.c =A0 =A0 =A0 =A0 =A0 | =A0 10 ++++++++++
> =A0arch/mips/mm/tlb-r4k.c =A0 =A0 =A0 =A0 =A0 | =A0 12 ++++++++++++
> =A03 files changed, 26 insertions(+), 0 deletions(-)
>
> diff --git a/arch/mips/include/asm/tlbflush.h b/arch/mips/include/asm/t=
> lbflush.h
> index 86b21de..d7b75e6 100644
> --- a/arch/mips/include/asm/tlbflush.h
> +++ b/arch/mips/include/asm/tlbflush.h
> @@ -8,12 +8,14 @@
> =A0*
> =A0* =A0- flush_tlb_all() flushes all processes TLB entries
> =A0* =A0- flush_tlb_mm(mm) flushes the specified mm context TLB entries
> + * =A0- flush_tlb_all_mm() flushes all mm context TLB entries
[...]

Your mailer did an excellent job of mangling the patch.

Can you resend it but without the Content-Transfer-Encoding: 
QUOTED-PRINTABLE bit?

David Daney

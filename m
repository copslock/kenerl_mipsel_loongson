Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 30 Aug 2011 01:53:39 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:10239 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491754Ab1H2Xxd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 30 Aug 2011 01:53:33 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4e5c26bc0000>; Mon, 29 Aug 2011 16:54:36 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Mon, 29 Aug 2011 16:53:26 -0700
Received: from dd1.caveonetworks.com ([64.2.3.195]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Mon, 29 Aug 2011 16:53:25 -0700
Message-ID: <4E5C2673.3070406@cavium.com>
Date:   Mon, 29 Aug 2011 16:53:23 -0700
From:   David Daney <david.daney@cavium.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.15) Gecko/20101027 Fedora/3.0.10-1.fc12 Thunderbird/3.0.10
MIME-Version: 1.0
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
        linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: SMTC: Correct saving of CP0_STATUS
References: <20110829232029.GA15763@zapo> <4E5C2490.6040203@cavium.com>
In-Reply-To: <4E5C2490.6040203@cavium.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 29 Aug 2011 23:53:26.0005 (UTC) FILETIME=[D7EBA250:01CC66A6]
X-archive-position: 31010
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: david.daney@cavium.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 21960

On 08/29/2011 04:45 PM, David Daney wrote:
> On 08/29/2011 04:20 PM, Edgar E. Iglesias wrote:
>> Hi,
>>
>> Commit 362e696428590f7d0a5d0971a2d04b0372a761b8
>> reorders a bunch of insns to improve the flow of the pipeline but
>> for MT_SMTC kernels, AFAICT, the saving of CP0_STATUS seems wrong.
>
> Indeed.
>
>>
>> Am I missing something?
>>
>
> It does look like in the MIPS_MT_SMTC case we are clobbering the value
> in v1.
>
>> If not here is a patch, tested with qemu.
>>
>
> How about the attached completely untested one instead?
>

Ralf,

I didn't mean to imply that Edgar's patch was not correct, it seems 
likely that it is.  Really either approach is fine with me.

David Daney.

.
.
.

>
>  From d0035295ae34bcf84d601b1e25e2642fe0802752 Mon Sep 17 00:00:00 2001
> From: David Daney<david.daney@cavium.com>
> Date: Mon, 29 Aug 2011 16:42:12 -0700
> Subject: [PATCH] MIPS: Don't clobber CP0_STATUS vaue for CONFIG_MIPS_MT_SMTC
>
> Untested, but it looks nice.
>
> Reported-by: Edgar E. Iglesias<edgar.iglesias@gmail.com>
> Signed-off-by: David Daney<david.daney@cavium.com>
> ---
>   arch/mips/include/asm/stackframe.h |    4 ++--
>   1 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/mips/include/asm/stackframe.h b/arch/mips/include/asm/stackframe.h
> index 569681e..51a3a0c 100644
> --- a/arch/mips/include/asm/stackframe.h
> +++ b/arch/mips/include/asm/stackframe.h
> @@ -195,9 +195,9 @@
>   		 * to cover the pipeline delay.
>   		 */
>   		.set	mips32
> -		mfc0	v1, CP0_TCSTATUS
> +		mfc0	k0, CP0_TCSTATUS
>   		.set	mips0
> -		LONG_S	v1, PT_TCSTATUS(sp)
> +		LONG_S	k0, PT_TCSTATUS(sp)
>   #endif /* CONFIG_MIPS_MT_SMTC */
>   		LONG_S	$4, PT_R4(sp)
>   		LONG_S	$5, PT_R5(sp)

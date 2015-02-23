Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Feb 2015 23:08:01 +0100 (CET)
Received: from mail-ig0-f181.google.com ([209.85.213.181]:52269 "EHLO
        mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007050AbbBWWH7X9-YR (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 23 Feb 2015 23:07:59 +0100
Received: by mail-ig0-f181.google.com with SMTP id hn18so22166335igb.2;
        Mon, 23 Feb 2015 14:07:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=cdYNb2yzG/Pf8QI/pbKbtApyZZQ6Sh7D94qPWNNPL3A=;
        b=JAiHZm0r7WJwt/qvWTJaFidFMvBNgcMldy/l2cL/FcHwg3x0hjNG3aNSbxc1eKoBWH
         gC3osFpSbs98vQrPLGfvpJZCKjIZ/2iRGFM/6ptf+GBxKGIJOzutEN+9IxxCu6J4TNHG
         9JFkoS1C1+uc69NL+PGLKYtmTQR72ziXlhjng4SBXWevJzA+WgJZBBUteIxAAFrxHE/c
         Dp0xdFpctSMGDUe0jZU16v2DPbJcclranRN/mEabueiLdQAoFzEZqUCxupb1zMUlx5sB
         UBv7yMxpytl081yMV2bQRKgMIPVaGpzwqa6I9HSBo6tJekHDO/a6lntCNQDT/ad9AUPL
         39fg==
X-Received: by 10.107.32.14 with SMTP id g14mr17376682iog.3.1424729274201;
        Mon, 23 Feb 2015 14:07:54 -0800 (PST)
Received: from dl.caveonetworks.com (64.2.3.194.ptr.us.xo.net. [64.2.3.194])
        by mx.google.com with ESMTPSA id n4sm6897369igr.3.2015.02.23.14.07.53
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 23 Feb 2015 14:07:53 -0800 (PST)
Message-ID: <54EBA4B8.3070809@gmail.com>
Date:   Mon, 23 Feb 2015 14:07:52 -0800
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Markos Chandras <markos.chandras@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>
CC:     linux-mips@linux-mips.org,
        Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
Subject: Re: [PATCH RFC v2 41/70] MIPS: mm: tlbex: Use cpu_has_mips_r2_exec_hazard
 for the EHB instruction
References: <1421405389-15512-1-git-send-email-markos.chandras@imgtec.com> <1421405389-15512-42-git-send-email-markos.chandras@imgtec.com> <54EBA3C3.30108@gmail.com>
In-Reply-To: <54EBA3C3.30108@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45897
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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

On 02/23/2015 02:03 PM, David Daney wrote:
> On 01/16/2015 02:49 AM, Markos Chandras wrote:
>> From: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
>>
>> MIPS uses the cpu_has_mips_r2_exec_hazard macro to determine whether the
>> EHB instruction is available or not. This is necessary for MIPS R6
>> which also supports the EHB instruction.
>>
>> Signed-off-by: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
>> Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
>
> For the version of this patch currently in mips-for-linux-next: NACK
>

FYI, that would be: Commit id: 77f3ee59ee7cfe19e0ee48d9a990c7967fbfcbed

> There are two problems:
>
> 1) It breaks OCTEON, which will now crash in early boot with:
>
>    Kernel panic - not syncing: No TLB refill handler yet (CPU type: 80)
>
> 2) The logic is broken.
>
> The meaning of cpu_has_mips_r2_exec_hazard is that the EHB instruction
> is required.  You change the meaning to be that EHB is part of the ISA.
>
> Can we get this patch reverted from mips-for-linux-next?
>
> David Daney
>
>
>> ---
>>   arch/mips/mm/tlbex.c | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
>> index ff8d99ce3b9b..d75ff73a2012 100644
>> --- a/arch/mips/mm/tlbex.c
>> +++ b/arch/mips/mm/tlbex.c
>> @@ -501,7 +501,7 @@ static void build_tlb_write_entry(u32 **p, struct
>> uasm_label **l,
>>       case tlb_indexed: tlbw = uasm_i_tlbwi; break;
>>       }
>>
>> -    if (cpu_has_mips_r2) {
>> +    if (cpu_has_mips_r2_exec_hazard) {
>>           /*
>>            * The architecture spec says an ehb is required here,
>>            * but a number of cores do not have the hazard and
>> @@ -1953,7 +1953,7 @@ static void build_r4000_tlb_load_handler(void)
>>
>>           switch (current_cpu_type()) {
>>           default:
>> -            if (cpu_has_mips_r2) {
>> +            if (cpu_has_mips_r2_exec_hazard) {
>>                   uasm_i_ehb(&p);
>>
>>           case CPU_CAVIUM_OCTEON:
>> @@ -2020,7 +2020,7 @@ static void build_r4000_tlb_load_handler(void)
>>
>>           switch (current_cpu_type()) {
>>           default:
>> -            if (cpu_has_mips_r2) {
>> +            if (cpu_has_mips_r2_exec_hazard) {
>>                   uasm_i_ehb(&p);
>>
>>           case CPU_CAVIUM_OCTEON:
>>
>

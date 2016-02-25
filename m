Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Feb 2016 02:06:20 +0100 (CET)
Received: from mail-pf0-f172.google.com ([209.85.192.172]:33767 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007825AbcBYBGStpGVx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 25 Feb 2016 02:06:18 +0100
Received: by mail-pf0-f172.google.com with SMTP id q63so22618400pfb.0;
        Wed, 24 Feb 2016 17:06:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=ny7Y3bCt4Qx1gvMss9VYDIcKdtESo212UbAjYUXsaUs=;
        b=kdXz725kGHA1w8nU20o9xxPsY8xnX0jzggITZVVCPgT2J5Z568tM4GBxvl0k1ozDRl
         fVyxLN2PuFZSDNIbv4i2pJW5czIPHzScen2D4Of3a/m8ZMThdILg0iFmDQaO3bfwpo1E
         4B6SAeETxwU+uVO+uNYJk7jw2qdQImQh4rCWpppstSxI3sbkJ6WpOrDYHfm3JSNZY1T9
         R6X9KpxZnn5Lj97yJFsgRE4BPzNMe5vHleaexjzZ3W+4qosrvZHuRygv6HJHrC9PiUF6
         YHlQrRXUAsMmI392WRx0kYdRXiFqhx+0wG8gO1NQvZVXfBv+6bgVuNi6jsq1KOV7KFVI
         rv2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=ny7Y3bCt4Qx1gvMss9VYDIcKdtESo212UbAjYUXsaUs=;
        b=HCCf5LFYXQls6MM0FYCGE5Mhn2+N3IyP+5CllqHQ+vZcpO9LaK9kOkkBSU9/Qzdmdy
         e/zp0oVpnm6nADw4daH0ZLyZ37B45JAx13brhYOZy5qWzWQNnMPwQy3kqDX/xKOUOJiy
         4nEvmDnIXUSMkmyWHrZsP8Hg1woqo4ImKZpgLGTWCYmJ42E7jXEVtMUenBvW220pgj/V
         ObA5OSQlVHznHFrX5MMoTON0lyoAmoSm/Jv4prS67Vlm0aqqPBmqMn9PFRLUTnuVuBQX
         hJtgxbCWzirpvCy2FYW/o2ZxOXzeALZL5/AVPQxClLLDxBmzl7j4tkt33Uvg5TqDHMpv
         1YXA==
X-Gm-Message-State: AG10YOSwDUZpPya6fElUUrxAOPeSc2lyE5TiUDZJH/U0mrGwuECKUBDkyoOw6pToKYtFqQ==
X-Received: by 10.98.80.10 with SMTP id e10mr39563798pfb.141.1456362372974;
        Wed, 24 Feb 2016 17:06:12 -0800 (PST)
Received: from dl.caveonetworks.com ([64.2.3.194])
        by smtp.googlemail.com with ESMTPSA id e1sm7655995pas.1.2016.02.24.17.06.11
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 24 Feb 2016 17:06:11 -0800 (PST)
Message-ID: <56CE5382.4090800@gmail.com>
Date:   Wed, 24 Feb 2016 17:06:10 -0800
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     "Maciej W. Rozycki" <macro@imgtec.com>,
        Huacai Chen <chenhc@lemote.com>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Aurelien Jarno <aurelien@aurel32.net>,
        "Steven J . Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>, stable@kernel.org
Subject: Re: [PATCH] MIPS: tlbex: Fix bugs in tlbchange handler
References: <1456324384-18118-1-git-send-email-chenhc@lemote.com> <1456324384-18118-2-git-send-email-chenhc@lemote.com> <alpine.DEB.2.00.1602250029390.15885@tp.orcam.me.uk>
In-Reply-To: <alpine.DEB.2.00.1602250029390.15885@tp.orcam.me.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52227
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

On 02/24/2016 04:40 PM, Maciej W. Rozycki wrote:
> On Wed, 24 Feb 2016, Huacai Chen wrote:
>
>> If a tlb miss triggered when EXL=1, tlb refill exception is treated as
>> tlb invalid exception, so tlbp may fails. In this situation, CP0_Index
>> register doesn't contain a valid value. This may not be a problem for
>> VTLB since it is fully-associative. However, FTLB is set-associative so
>> not every tlb entry is valid for a specific address. Thus, we should
>> use tlbwr instead of tlbwi when tlbp fails.
>
>   Can you please explain exactly why this change is needed?  You're
> changing pretty generic code which has worked since forever.  So why is a
> change suddenly needed?  Our kernel entry/exit code has been written such
> that no mapped memory is accessed with EXL=1 so no TLB exception is
> expected to ever happen in these circumstances.  So what's your scenario
> you mean to address?  Your patch description does not explain it.
>

I asked this exact same question back on Jan. 26, when the patch was 
previously posted.

No answer was given, all we got was the same thing again with no 
explanation.

David Daney



>> @@ -1913,7 +1935,14 @@ build_r4000_tlbchange_handler_tail(u32 **p, struct uasm_label **l,
>>   	uasm_i_ori(p, ptr, ptr, sizeof(pte_t));
>>   	uasm_i_xori(p, ptr, ptr, sizeof(pte_t));
>>   	build_update_entries(p, tmp, ptr);
>> +	uasm_i_mfc0(p, ptr, C0_INDEX);
>> +	uasm_il_bltz(p, r, ptr, label_tail_miss);
>> +	uasm_i_nop(p);
>>   	build_tlb_write_entry(p, l, r, tlb_indexed);
>> +	uasm_il_b(p, r, label_leave);
>> +	uasm_i_nop(p);
>> +	uasm_l_tail_miss(l, *p);
>> +	build_tlb_write_entry(p, l, r, tlb_random);
>>   	uasm_l_leave(l, *p);
>>   	build_restore_work_registers(p);
>>   	uasm_i_eret(p); /* return from trap */
>
>   Specifically you're causing a performance hit here, which is a fast path,
> for everyone.  If you have a scenario that needs this change, then please
> make it conditional on the circumstances and keep the handler unchanged in
> all the other cases.
>
>    Maciej
>
>
>

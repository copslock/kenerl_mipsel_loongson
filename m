Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Jan 2015 21:10:17 +0100 (CET)
Received: from mail-ig0-f174.google.com ([209.85.213.174]:47807 "EHLO
        mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011506AbbAOUKQN9fCv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 15 Jan 2015 21:10:16 +0100
Received: by mail-ig0-f174.google.com with SMTP id hn15so30016880igb.1;
        Thu, 15 Jan 2015 12:10:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=vMViOnW+uv3fNv/izzlEr35kkxHkuoGKzf06gNgceoY=;
        b=RNQ9hMuD1lck2gfSyFTjdyefv2xZLyq5PaO2wLIf/0PngyiDEPdGgi9JuT84JTJP/c
         i1159BthXLu9BumKtLjtK7hdTV6FJNKnBQuWudiUpX4GkvA0/3Qv5u1cvysMLAxj8RbA
         rCp8P6TsLoFnaGX19jM3qzBgSbbNW4KBQPhkKSALVN68ZHb4ft5TBwRPdpiabv38FCRP
         7FxOY0TxWBG7wrcWHwroBq9s4h3ah9Y6pdYbPVBU5uimP2MOAbUrwypyTdscAATkTCKE
         U3D+BOZ5zEwIOJL0mocNSJIF8lm5WRoyNJdcp5nxTM1ayc57qx8/0Bj7lhHTjGXB5twx
         lgwQ==
X-Received: by 10.42.78.208 with SMTP id o16mr11292576ick.41.1421352610491;
        Thu, 15 Jan 2015 12:10:10 -0800 (PST)
Received: from dl.caveonetworks.com (64.2.3.194.ptr.us.xo.net. [64.2.3.194])
        by mx.google.com with ESMTPSA id 75sm1535418ioz.35.2015.01.15.12.10.09
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 15 Jan 2015 12:10:10 -0800 (PST)
Message-ID: <54B81EA0.8060409@gmail.com>
Date:   Thu, 15 Jan 2015 12:10:08 -0800
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Aaro Koskinen <aaro.koskinen@iki.fi>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        David Daney <david.daney@cavium.com>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Hemmo Nieminen <hemmo.nieminen@iki.fi>, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] MIPS: OCTEON: fix kernel crash when offlining a CPU
References: <1421347767-21740-1-git-send-email-aaro.koskinen@iki.fi> <54B816AC.7070902@gmail.com> <20150115195345.GA8087@fuloong-minipc.musicnaut.iki.fi>
In-Reply-To: <20150115195345.GA8087@fuloong-minipc.musicnaut.iki.fi>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45137
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

On 01/15/2015 11:53 AM, Aaro Koskinen wrote:
> Hi,
>
> On Thu, Jan 15, 2015 at 11:36:12AM -0800, David Daney wrote:
>> On 01/15/2015 10:49 AM, Aaro Koskinen wrote:
>>> octeon_cpu_disable() will unconditionally enable interrupts when called
>>> with interrupts disabled. Fix that.
>>
>> interrupts are always disabled here, so...
>
> Is that also true for all the currently supported stable kernels...?

I haven't done extensive research recently, but I have removed that pair 
of local_irq_disable/local_irq_enable in our SDK kernel based on 3.10


> Or should I just drop Cc: stable from this patch?
>
>> Just remove this...
>>
>>>   	octeon_fixup_irqs();
>>> -	local_irq_enable();
>>> +	local_irq_restore(flags);
>>
>> ... and this.
>>
>>>
>>>   	flush_cache_all();
>>>   	local_flush_tlb_all();
>>>
>>
>> You can add an Acked-by me if you do that.
>
> Ok, I will do that.
>
> A.
>
>

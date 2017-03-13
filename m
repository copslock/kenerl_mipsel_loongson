Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Mar 2017 17:45:42 +0100 (CET)
Received: from mail-pf0-x243.google.com ([IPv6:2607:f8b0:400e:c00::243]:34708
        "EHLO mail-pf0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993967AbdCMQpeqfteI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 13 Mar 2017 17:45:34 +0100
Received: by mail-pf0-x243.google.com with SMTP id o126so19558836pfb.1;
        Mon, 13 Mar 2017 09:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=NN71PS4bWFBUAuwqagbkqGUKaaQ+avWqKv3H7Al6P+M=;
        b=vBP29daUkdh2FKUjr3YEMhlydeR6OSUTdThlVznTney7IqpxqAmlUlwhoauOrGqJ/V
         smkQv9BIwP83DCiuyBZO7PAS10BjnmbZqY7LEgDhI3N1Uc+p12HMiRFwG4lio5Lu4iIW
         COKpYKNcFsBl2hZJ5hoF06Z/5bLuH+DosTSjtfomKHqH4T6UTMNe4H2n1xMfGRE+Cv+1
         d4vlSJxjTfMvHcLmOT71Od45h7CEoWuDmHra8VFiADHstu2/B5nBq33MZPVtEPt74Xzr
         0MU5ydbUB5iWhxnSEI85HI60BKglXcJwudk+PE/3WJgh8FCUi7wcsJXZ4GwLBx8vXpVh
         wWTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=NN71PS4bWFBUAuwqagbkqGUKaaQ+avWqKv3H7Al6P+M=;
        b=CWyDf47yV1/9VLcdUaFgIJjCtmPWC71nvwdBHW/GGcjpTP0KD72hKCNPdu7b67FAk6
         7Ma3/yiSl5uyT4pEmlWhQjKKg3FXUIzMqPmh27eAAv44zN8iwGXDQETgxFB5zQbuq3E4
         ux2QCzr4wFiA71QLYZSf7arXNglhJyS2fZ5QEJLxFNh6YHcX7TeGBtouMbUbuEPBAOM8
         n+/BwEgC5haEzww5GCdv+q/SdQGCovlfGFbUj8dprNRwt07gjJ6nNN5G7gq9bt/qxsrk
         tLCJfKSH+MlkS18BF0JZpH889lf4RJXOJItxEjG8URZQeCEFDh/szX5tugfcSBnhpyfh
         fEuw==
X-Gm-Message-State: AMke39nzxhv0qj+0AYsJkAbbItNhs94MygU6MPgY1/ynDQTzhW5XNfTKSHMLOWA7bTjx1Q==
X-Received: by 10.84.162.204 with SMTP id o12mr48966320plg.132.1489423528874;
        Mon, 13 Mar 2017 09:45:28 -0700 (PDT)
Received: from ddl.caveonetworks.com (50-233-148-156-static.hfc.comcastbusiness.net. [50.233.148.156])
        by smtp.googlemail.com with ESMTPSA id t6sm34030175pgo.42.2017.03.13.09.45.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Mar 2017 09:45:27 -0700 (PDT)
Subject: Re: [PATCH] MIPS: BPF: Add support for SKF_AD_HATYPE
To:     James Hogan <james.hogan@imgtec.com>,
        David Daney <david.daney@cavium.com>
References: <20170310221405.30648-1-david.daney@cavium.com>
 <20170313105659.GJ996@jhogan-linux.le.imgtec.org>
Cc:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        linux-kernel@vger.kernel.org,
        "Steven J. Hill" <steven.hill@cavium.com>,
        Alexei Starovoitov <ast@kernel.org>, netdev@vger.kernel.org
From:   David Daney <ddaney.cavm@gmail.com>
Message-ID: <9da6cebb-b991-e89f-bc88-a2ec530e32ec@gmail.com>
Date:   Mon, 13 Mar 2017 09:45:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <20170313105659.GJ996@jhogan-linux.le.imgtec.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57158
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

On 03/13/2017 03:56 AM, James Hogan wrote:
> On Fri, Mar 10, 2017 at 02:14:05PM -0800, David Daney wrote:
>> This let's us pass some additional "modprobe test-bpf" tests.
>>
>> Reuse the code for SKF_AD_IFINDEX, but substitute the offset and size
>> of the "type" field.
>>
>> Signed-off-by: David Daney <david.daney@cavium.com>
>
> I think the BPF maintainers should probably be Cc'd on this patch.
> Cc'ing now.
>

Good point.

Since there are some corrections needed, I will send another version and 
CC the proper people.


>> ---
>>  arch/mips/net/bpf_jit.c | 14 ++++++++++----
>>  1 file changed, 10 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/mips/net/bpf_jit.c b/arch/mips/net/bpf_jit.c
>> index 49a2e22..f613708 100644
>> --- a/arch/mips/net/bpf_jit.c
>> +++ b/arch/mips/net/bpf_jit.c
>> @@ -1111,6 +1111,7 @@ static int build_body(struct jit_ctx *ctx)
>>  			emit_load(r_A, 28, off, ctx);
>>  			break;
>>  		case BPF_ANC | SKF_AD_IFINDEX:
>> +		case BPF_ANC | SKF_AD_HATYPE:
>>  			/* A = skb->dev->ifindex */
>
> this comment should probably be updated.

Right.

>
>>  			ctx->flags |= SEEN_SKB | SEEN_A;
>>  			off = offsetof(struct sk_buff, dev);
>> @@ -1120,10 +1121,15 @@ static int build_body(struct jit_ctx *ctx)
>>  			emit_bcond(MIPS_COND_EQ, r_s0, r_zero,
>>  				   b_imm(prog->len, ctx), ctx);
>>  			emit_reg_move(r_ret, r_zero, ctx);
>> -			BUILD_BUG_ON(FIELD_SIZEOF(struct net_device,
>> -						  ifindex) != 4);
>> -			off = offsetof(struct net_device, ifindex);
>> -			emit_load(r_A, r_s0, off, ctx);
>> +			if (code == (BPF_ANC | SKF_AD_IFINDEX)) {
>> +				BUILD_BUG_ON(FIELD_SIZEOF(struct net_device, ifindex) != 4);
>> +				off = offsetof(struct net_device, ifindex);
>> +				emit_load(r_A, r_s0, off, ctx);
>> +			} else { /* (code == (BPF_ANC | SKF_AD_HATYPE) */
>> +				BUILD_BUG_ON(FIELD_SIZEOF(struct net_device, type) != 2);
>> +				off = offsetof(struct net_device, type);
>> +				emit_half_load(r_A, r_s0, off, ctx);
>
> Technically net_device::type is unsigned, and emit_half_load uses LH
> which sign extends. Does that matter in practice.

The next version will use LHU.


>
> Cheers
> James
>

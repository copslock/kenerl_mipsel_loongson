Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 May 2013 01:28:22 +0200 (CEST)
Received: from mail-da0-f48.google.com ([209.85.210.48]:35754 "EHLO
        mail-da0-f48.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6823127Ab3EFX2RXJJ4T (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 7 May 2013 01:28:17 +0200
Received: by mail-da0-f48.google.com with SMTP id h32so2049133dak.35
        for <multiple recipients>; Mon, 06 May 2013 16:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=RDp6cgaximA/YJP/RYDF15AuYJGIGCuLAvNlze/WXeE=;
        b=tsJn8NyJfpGigeNuKVrzzPH2/uUEIbKtP+8Tydvp/9VOW0C0eAvPuregHgTb4FHDwG
         0lSBqwDbFIFnH22MfpcBAGgkYadq9wVNwtX4ObdyW6zzDwTjGBTreFV6sERNiafgPPuC
         oG1jKlxlEO5/7dY5xpN5eYeLZWXH1IoOHYNpgYuLxvKr9iSikXdtCCQ6L8spqFptTlNs
         iU3dAqMKZyAlGItxw6vvjLyCm/2k2gIO4F+yOTZJb+LF6yXExkb1bRGiVXKK6baNctEA
         LvCtPt40l59k1LoKk2NfRNSOhmanGNQinalzNAvjuwIVunoMSrNc0vnBPGbF5b2TttmX
         Xang==
X-Received: by 10.68.238.38 with SMTP id vh6mr28101059pbc.63.1367882890434;
        Mon, 06 May 2013 16:28:10 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id v5sm25627078pbz.4.2013.05.06.16.28.08
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 06 May 2013 16:28:09 -0700 (PDT)
Message-ID: <51883C87.7010501@gmail.com>
Date:   Mon, 06 May 2013 16:28:07 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130311 Thunderbird/17.0.4
MIME-Version: 1.0
To:     Sanjay Lal <sanjayl@kymasys.com>
CC:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Daney <david.daney@cavium.com>
Subject: Re: [PATCH] mips/kvm: Fix ABI for compatibility with 64-bit guests.
References: <1367879980-2440-1-git-send-email-ddaney.cavm@gmail.com> <1069B54B-C9CD-4333-B56F-B0E1D740CADB@kymasys.com>
In-Reply-To: <1069B54B-C9CD-4333-B56F-B0E1D740CADB@kymasys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36332
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

On 05/06/2013 04:11 PM, Sanjay Lal wrote:
>
> On May 6, 2013, at 3:39 PM, David Daney wrote:
>
>>
>> /* for KVM_GET_REGS and KVM_SET_REGS */
>> +/*
>> + * If Config[AT] is zero (32-bit CPU), the register contents are
>> + * stored in the lower 32-bits of the struct kvm_regs fields and sign
>> + * extended to 64-bits.
>> + */
>> struct kvm_regs {
>> -	__u32 gprs[32];
>> -	__u32 hi;
>> -	__u32 lo;
>> -	__u32 pc;
>> +	/* out (KVM_GET_REGS) / in (KVM_SET_REGS) */
>> +	__u64 gpr[32];
>> +	__u64 hi, lo;
>> +	__u64 pc;
>> +};
>>
>> -	__u32 cp0reg[N_MIPS_COPROC_REGS][N_MIPS_COPROC_SEL];
>
> Hi David, I'll try out the diff with QEMU and confirm that it works as expected. Could you just leave the GPR field in kvm_regs as "gprs". Its a minor change but avoids diffs that just replace "gprs" with "gpr".
>

Well, there were two changes with respect to 'gprs' vs. 'gpr'.

The change you show above only results in a small handful of diff lines.

My argument for the change is that it will be part of a public ABI, and 
should be short and concise, so I changed it to 'gpr'.

I also changed the field with the same name in struct kvm_vcpu_arch to 
match, which causes the changes in asm-offsets.c and quite a few other 
places as well.  One could argue that this one was gratuitous, but I 
thought it would be nice for them to match.  Since it is an internal 
implementation detail, it is not that important, so I could revert this 
part if there are strong objections.

David Daney

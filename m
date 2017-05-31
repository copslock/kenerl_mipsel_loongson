Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 31 May 2017 19:20:49 +0200 (CEST)
Received: from mail-qt0-x241.google.com ([IPv6:2607:f8b0:400d:c0d::241]:35497
        "EHLO mail-qt0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993419AbdEaRUn30pcF (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 31 May 2017 19:20:43 +0200
Received: by mail-qt0-x241.google.com with SMTP id r58so2675681qtb.2;
        Wed, 31 May 2017 10:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cTkX9O7cmU+iz3p/mwL9zyGXRE4vyQN+Yc5eNwdfBps=;
        b=KrtvMnXN0xNaGlGxjmBmpY5a25bkBjp+8vY9fw0r3YnN8jhcaWnja+5CVGFfDVX/l8
         66Jma8HxU9GhQXdNLAV128bOML85v4xlXpGTJnpnunAZ3K/rORN4BkfdtAM8DvXCBBI4
         O/mIRIjMICkypyGePk4pb5rax5uR96ZRXu1PfYk3OzyE40uOq92f7CoKqGa88I+PrJSW
         zEb+gQgYAjCHANdX4/3YL1/rWMBdyo8fezkhSNLamjHeR1e0KRJaAJ9a6VnuxDwWsTwb
         emm0G4uS4zOACuNXCA8WMt6zcE11YSInN0g6cdm2EcZpG1LKxLsvP3tg6lG2VtsaobwV
         OYNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cTkX9O7cmU+iz3p/mwL9zyGXRE4vyQN+Yc5eNwdfBps=;
        b=USxzc7cnsaie8mViSchtRwbABpzomJ/99KHJYFZfhGTNMZvDQZIJLcr0C8jDg0c/N7
         bXIRYhk6Zh0JrmVuP1w9csinaSGl2yeApCnKw22I5gnF9DIqOa5IHUU+PZ1DkRcdI3ao
         92rZrukEEH7JYhZriJYcuM0glpDnVRwQcwQJKxFP3qJwQsH/AQLVknAbrA0cy/y2HaZe
         ATIHbpeyEjpBs+BAjrbM3bI1l3lCH0KZ6PKhmZwVlNXJZvRiUJuuBFwv+2p9BWbon96L
         PVofVKKhBTev5iQVZmB8bps1hM+e/9gsJ6xGbuqpr1hZrb03E3khUXPGyZYS9CQWV2b2
         7zsA==
X-Gm-Message-State: AODbwcBwija57dTwVuSEISqbZdpeB29P133WcYTmmvGQI4kF13YjV+nU
        C1Uo8uUHcJipEFHR
X-Received: by 10.237.62.12 with SMTP id l12mr31080660qtf.20.1496251237545;
        Wed, 31 May 2017 10:20:37 -0700 (PDT)
Received: from ddl.caveonetworks.com (50-233-148-156-static.hfc.comcastbusiness.net. [50.233.148.156])
        by smtp.googlemail.com with ESMTPSA id z53sm11054826qth.43.2017.05.31.10.20.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 May 2017 10:20:37 -0700 (PDT)
Subject: Re: [PATCH 4/4] MIPS: Branch straight to ll in mips_atomic_set()
To:     James Hogan <james.hogan@imgtec.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
References: <cover.5633df325dbcbc41dbf9cc60df22b38f7812e73a.1496240182.git-series.james.hogan@imgtec.com>
 <c17c30b035caec45c1de97f4d069ab31fec2067e.1496240182.git-series.james.hogan@imgtec.com>
 <580e1148-aaf9-895c-09ec-8b38772a9154@gmail.com>
 <20170531164754.GM6973@jhogan-linux.le.imgtec.org>
From:   David Daney <ddaney.cavm@gmail.com>
Message-ID: <d671ae4e-f58b-6f7e-4814-f8ef764a8625@gmail.com>
Date:   Wed, 31 May 2017 10:20:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.0
MIME-Version: 1.0
In-Reply-To: <20170531164754.GM6973@jhogan-linux.le.imgtec.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58100
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

On 05/31/2017 09:47 AM, James Hogan wrote:
> Hi David,
> 
> On Wed, May 31, 2017 at 09:28:36AM -0700, David Daney wrote:
>> On 05/31/2017 08:19 AM, James Hogan wrote:
>>> Adjust the atomic loop in the MIPS_ATOMIC_SET operation of the sysmips
>>> system call to branch straight back to the linked load rather than
>>> jumping via a different subsection (whose purpose remains a mystery to
>>> me).
>>
>> The subsection keeps the code for the (hopefully) cold path out of line
>> which should result in a smaller cache footprint in the hot path.
> 
> Hmm, yes that would make sense if it did something useful there, but it
> just immediately jumps back to the ll.

In this case, it could be that the pattern was copied without carefully 
examining what was being done.

> 
> Cheers
> James
> 
>>
>>
>>>
>>> Signed-off-by: James Hogan <james.hogan@imgtec.com>
>>> Cc: Ralf Baechle <ralf@linux-mips.org>
>>> Cc: linux-mips@linux-mips.org
>>> ---
>>>    arch/mips/kernel/syscall.c | 6 +-----
>>>    1 file changed, 1 insertion(+), 5 deletions(-)
>>>
>>> diff --git a/arch/mips/kernel/syscall.c b/arch/mips/kernel/syscall.c
>>> index ca54ac40252b..6c6bf43d681b 100644
>>> --- a/arch/mips/kernel/syscall.c
>>> +++ b/arch/mips/kernel/syscall.c
>>> @@ -137,13 +137,9 @@ static inline int mips_atomic_set(unsigned long addr, unsigned long new)
>>>    		"	move	%[tmp], %[new]				\n"
>>>    		"2:							\n"
>>>    		user_sc("%[tmp]", "(%[addr])")
>>> -		"	beqz	%[tmp], 4f				\n"
>>> +		"	beqz	%[tmp], 1b				\n"
>>>    		"3:							\n"
>>>    		"	.insn						\n"
>>> -		"	.subsection 2					\n"
>>> -		"4:	b	1b					\n"
>>> -		"	.previous					\n"
>>> -		"							\n"
>>>    		"	.section .fixup,\"ax\"				\n"
>>>    		"5:	li	%[err], %[efault]			\n"
>>>    		"	j	3b					\n"
>>>
>>

Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Jan 2014 20:56:18 +0100 (CET)
Received: from mail-ig0-f176.google.com ([209.85.213.176]:46322 "EHLO
        mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6825733AbaA0T4P3uCT9 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 27 Jan 2014 20:56:15 +0100
Received: by mail-ig0-f176.google.com with SMTP id j1so9982107iga.3
        for <linux-mips@linux-mips.org>; Mon, 27 Jan 2014 11:56:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=IastCxmya6KJyReF0aEz4FhneOIaw8Mw9f3ilX1xVV4=;
        b=eV/Pj5oAq3qR/BOlfjglFRkWLMp5u7EYULL0SOtwE4LrV1zRXmym7N4kmHm7HnwyR9
         wwowg2ZwFidSQJud1MMWcoi0W4DjENTqQfAdiHiOhYjpiomK/z/NdJve5Ph0B13B0tcA
         U+BG7UV3vxozwV7tDcrpHVNIQOZJinShVkjs7EJCEPygfyr8xF5wCEDQOVc/bcAx9BvB
         k6UAG0YO9YDwR3hZ9No6PL/j+fvsAgfu1WeO6Oo61M/VnWReKXBuFrSXWtoyAMXOq3ID
         kj1osizfE0y+e/I1wsv8k8/jUz3I78n47QRKqRQdutf9kSULx7F9SSJhCF7Xbs3ArRyg
         RnNQ==
X-Received: by 10.50.45.33 with SMTP id j1mr19159414igm.32.1390852569188;
        Mon, 27 Jan 2014 11:56:09 -0800 (PST)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id a1sm46646894igo.0.2014.01.27.11.56.08
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 27 Jan 2014 11:56:08 -0800 (PST)
Message-ID: <52E6B9D7.8030208@gmail.com>
Date:   Mon, 27 Jan 2014 11:56:07 -0800
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Paul Burton <paul.burton@imgtec.com>
CC:     linux-mips@linux-mips.org
Subject: Re: [PATCH 14/15] mips: panic if vector register partitioning is
 implemented
References: <1390836194-26286-1-git-send-email-paul.burton@imgtec.com> <1390836194-26286-15-git-send-email-paul.burton@imgtec.com> <52E6A7B5.2040505@gmail.com> <20140127193908.GL970@pburton-linux.le.imgtec.org>
In-Reply-To: <20140127193908.GL970@pburton-linux.le.imgtec.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39116
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

On 01/27/2014 11:39 AM, Paul Burton wrote:
> On Mon, Jan 27, 2014 at 10:38:45AM -0800, David Daney wrote:
>> ....
>> On 01/27/2014 07:23 AM, Paul Burton wrote:
>>> No current systems implementing MSA include support for vector register
>>> partitioning which makes it somewhat difficult to implement support for
>>> it in the kernel. Thus for the moment the kernel includes no such
>>> support. However if the kernel were to be run on a system which
>>> implemented register partitioning then it would not function correctly,
>>> mishandling MSA disabled exceptions. Calling panic when run on a system
>>> with vector register partitioning implemented ensures that we're not
>>> caught out by this later but instead reminded to implement support once
>>> such a system is available.
>>>
>>> Signed-off-by: Paul Burton <paul.burton@imgtec.com>
>>> ---
>>>   arch/mips/kernel/cpu-probe.c | 6 +++++-
>>>   1 file changed, 5 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
>>> index 852e085..003ba3c 100644
>>> --- a/arch/mips/kernel/cpu-probe.c
>>> +++ b/arch/mips/kernel/cpu-probe.c
>>> @@ -1193,9 +1193,13 @@ void cpu_probe(void)
>>>   	else
>>>   		c->srsets = 1;
>>>
>>> -	if (cpu_has_msa)
>>> +	if (cpu_has_msa) {
>>>   		c->msa_id = cpu_get_msa_id();
>>>
>>> +		if (c->msa_id & MSA_IR_WRPF)
>>> +			panic("Vector register partitioning unimplemented!");
>>
>> You should probably use a WARN_ON() instead.  There is no reason to crash
>> the kernel for this condition is there?
>>
>
> Well mapping vector registers reuses the MSA disabled exception, so if
> the kernel were to continue with my current code & userland were to
> execute an MSA instruction I believe it would appear to hang. [...]

The CPU probing things are called so early that any panic() or BUG() 
here will result in absolutely no console output as this code is called 
before any console drivers are enabled.

So the choice is really:

panic(): No output on console and system is frozen/locked-up.

WARN(): Nice stack trace on console, theoretical lockup once userspace 
code starts executing.

You can probably guess which I think is the better option.

>
> Thanks,
>      Paul
>
>>> +	}
>>> +
>>>   	cpu_probe_vmbits(c);
>>>
>>>   #ifdef CONFIG_64BIT
>>>
>>
>>
>> To report this email as SPAM, please forward it to spam@websense.com
>
>
>

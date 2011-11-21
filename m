Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 21 Nov 2011 20:16:17 +0100 (CET)
Received: from mail-gx0-f177.google.com ([209.85.161.177]:46861 "EHLO
        mail-gx0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903800Ab1KUTQN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 21 Nov 2011 20:16:13 +0100
Received: by ggki1 with SMTP id i1so1996288ggk.36
        for <multiple recipients>; Mon, 21 Nov 2011 11:16:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=8FXgqNfbESzkO/S8oKttxEmBXeHjaC0vUE1OP4hc2Do=;
        b=C8wwD5zwA+K8PYVE5ZDUE23MQAbQJPAvXw3Joc8zDII2axmA39Yx9GlxZLpp3FDlej
         +lp2t+iEhJktAvHNRUDp119KHr/7PRrVIBGzxcUS1Z3rXIQo9viKMYCWcSYjmrs98wuN
         XWzGGJNVrFkuU6svoEU/MSJJJPT/kCLZl/qWw=
Received: by 10.236.35.205 with SMTP id u53mr21674874yha.24.1321902967152;
        Mon, 21 Nov 2011 11:16:07 -0800 (PST)
Received: from dd1.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id f47sm15534586yhh.8.2011.11.21.11.16.05
        (version=SSLv3 cipher=OTHER);
        Mon, 21 Nov 2011 11:16:05 -0800 (PST)
Message-ID: <4ECAA374.2040102@gmail.com>
Date:   Mon, 21 Nov 2011 11:16:04 -0800
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.15) Gecko/20101027 Fedora/3.0.10-1.fc12 Thunderbird/3.0.10
MIME-Version: 1.0
To:     Mike Frysinger <vapier@gentoo.org>
CC:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-embedded@vger.kernel.org, x86@kernel.org,
        David Daney <david.daney@cavium.com>
Subject: Re: [PATCH RFC 1/5] scripts: Add sortextable to sort the kernel's
 exception table.
References: <1321645068-20475-1-git-send-email-ddaney.cavm@gmail.com> <201111201822.13614.vapier@gentoo.org> <4ECA97A0.3090005@gmail.com> <201111211350.58916.vapier@gentoo.org>
In-Reply-To: <201111211350.58916.vapier@gentoo.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-archive-position: 31895
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 17686

On 11/21/2011 10:50 AM, Mike Frysinger wrote:
> On Monday 21 November 2011 13:25:36 David Daney wrote:
>> On 11/20/2011 03:22 PM, Mike Frysinger wrote:
>>> On Friday 18 November 2011 14:37:44 David Daney wrote:
>>>> +	switch (w2(ehdr->e_machine)) {
>>>> +	default:
>>>> +		fprintf(stderr, "unrecognized e_machine %d %s\n",
>>>> +			w2(ehdr->e_machine), fname);
>>>> +		fail_file();
>>>> +		break;
>>>> +	case EM_386:
>>>> +	case EM_MIPS:
>>>> +	case EM_X86_64:
>>>> +		break;
>>>> +	}  /* end switch */
>>>
>>> unlike recordmcount, this file doesn't do anything arch specific.  so
>>> let's just delete this and be done.
>>
>> Not really true at this point.  We don't know the size or layout of the
>> architecture specific exception table entries, likewise for
>> CONFIG_ARCH_HAS_SORT_EXTABLE, we don't even know how to do the comparison.
>
> all of your code that i could see is based on "is it 32bit or is it 64bit".
> there is no code that says "if it's x86, we need to do XXX".

At this point there is no need.  MIPS, i386 and x86_64 all store the key 
in the first word of a two word structure.

If there were some architecture that didn't fit this model, we would 
have to create a special sorting function and select it (and perhaps 
other parameters as well) in that switch statement.


>
> when i look in the kernel, we have common code behind ARCH_HAS_SORT_EXTABLE.
> so you could easily do the same thing:
>
> scripts/sortextable.c:
> 	#ifdef ARCH_HAS_SORT_EXTABLE
> 		switch (w2(ehdr->e_machine)) {
> 		default:
> 			fprintf(stderr, "unrecognized e_machine %d %s\n",
> 				w2(ehdr->e_machine), fname);
> 			... return a unique exit code like 77 ...
> 			break;
> 		/* add arch sorting info here */
> 		}  /* end switch */
> 	#endif
>
> kernel/extable.c:
> 	#if defined(ARCH_HAS_SORT_EXTABLE)&&  !defined(ARCH_HAS_SORTED_EXTABLE)
> 	void __init sort_main_extable(void)
> 	{
> 		sort_extable(__start___ex_table, __stop___ex_table);
> 	}
> 	#endif
>


Yes, I am familiar with that code.  One thing to keep in mind is that 
the compiler has access to struct exception_table_entry, and can easily 
figure out both how big the structure is *and* where the insn field is 
within the structure.

This is not the case for the author of sortextable.  Except for MIPS, 
MIPS64, i386 and x86_64, I know neither the size of struct 
exception_table_entry, nor the offset of its insn field.

For those with knowledge of the inner working of other architectures, it 
may be as simple as a two line patch to add support, but it isn't 
something that I want to take responsibility for at this point

> this way all the people not doing unique stuff work out of the box.  only the
> people who are doing funky stuff need to extend things.

I didn't want to include something like this that I cannot test.  An 
unsorted (or improperly sorted) exception table is not necessarily 
something that will be noticeable by simply booting the kernel.  Your 
only indication may be a panic or OOPS under rarely encountered conditions.

David Daney

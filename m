Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Feb 2015 01:38:46 +0100 (CET)
Received: from mail-ie0-f180.google.com ([209.85.223.180]:41122 "EHLO
        mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006916AbbBYAipSHliL (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 25 Feb 2015 01:38:45 +0100
Received: by iecrd18 with SMTP id rd18so753172iec.8;
        Tue, 24 Feb 2015 16:38:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=BwCQxZa8gMfH2c08eEvYMIX4e/y+1cQO7SpzkBUH2hE=;
        b=qpaJSsLLg8+V5yf3ht+1HPofDbRZgZuBDwYpE+YzK9ZdIuWRWmc7SYaHKzOEKJOqAB
         8crr+8ccnnxZj6lrWYFoCRSdac+5r/7ZRqaehV6bRmtl7F3LQEcQQNVF/GuEeNcsio9y
         8qNJNzZUq2EHCVn+jCnlQuByBhcw8V6Ez4MMOZ5NlwhOU6EhCI3J3xgF26vyPBEGQzT2
         ZbebBjwd/3f1yTr88HJlh4H7VkPVGl08EGtXcP4W+lRr9dMTc6rNSUuRC0YtIuTYbFhl
         UbKBvXQPEPbKi2hNFn5NlTH4AeSdcFolppYDZh8GgRl5B0mV1H0wgZuQjad+owjUhxlP
         j7LA==
X-Received: by 10.43.160.200 with SMTP id md8mr1049120icc.70.1424824719847;
        Tue, 24 Feb 2015 16:38:39 -0800 (PST)
Received: from dl.caveonetworks.com (64.2.3.194.ptr.us.xo.net. [64.2.3.194])
        by mx.google.com with ESMTPSA id a31sm8929127ioj.42.2015.02.24.16.38.38
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 24 Feb 2015 16:38:39 -0800 (PST)
Message-ID: <54ED198E.4060906@gmail.com>
Date:   Tue, 24 Feb 2015 16:38:38 -0800
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     "Maciej W. Rozycki" <macro@linux-mips.org>
CC:     Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        Zenon Fortuna <zenon.fortuna@imgtec.com>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        IMG - MIPS Linux Kernel developers 
        <IMG-MIPSLinuxKerneldevelopers@imgtec.com>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>
Subject: Re: [PATCH V2 1/3] MIPS: Fix cache flushing for swap pages with non-DMA
 I/O.
References: <1424362664-30303-1-git-send-email-Steven.Hill@imgtec.com> <1424362664-30303-2-git-send-email-Steven.Hill@imgtec.com> <CAJiQ=7DMBznB5Ths0sAZORf2hgSQRuBoPF-7HGHhcHn0EajnWg@mail.gmail.com> <54EBCC38.7000702@imgtec.com> <54EBD023.8090706@imgtec.com> <alpine.LFD.2.11.1502240224500.17311@eddie.linux-mips.org> <54ECE7CE.4040407@imgtec.com> <alpine.LFD.2.11.1502242140220.17311@eddie.linux-mips.org> <54ECF3E6.9080606@imgtec.com> <alpine.LFD.2.11.1502242235160.17311@eddie.linux-mips.org> <54ED01F5.8040409@gmail.com> <54ED06F4.8020607@imgtec.com> <alpine.LFD.2.11.1502242358170.17311@eddie.linux-mips.org>
In-Reply-To: <alpine.LFD.2.11.1502242358170.17311@eddie.linux-mips.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45946
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

On 02/24/2015 04:07 PM, Maciej W. Rozycki wrote:
> On Tue, 24 Feb 2015, Leonid Yegoshin wrote:
>
>>> SYNCI is only useful in non-SMP kernels.
>> Yes, until MIPS R6. I pressed hard on Arch team to change vague words in SYNCI
>> description and now (MIPS R6) it has words requiring execution on all cores:
>>
>>> "SYNCI globalization:
>>> Release 6: SYNCI globalization (as described below) is required: compliant
>>> implementations must globalize SYNCI.
>>> Portable software can rely on this behavior, and use SYNCI rather than
>>> expensive “instruction cache shootdown”
>>> using inter-processor interrupts."
>
>   Good, thanks for enforcing sanity!
>
>>> If a thread is migrated to a different CPU between the SYNCI, and the
>>> attempt to execute the freshly generated code, the new CPU can still have a
>>> dirty ICACHE.  So for Linux userspace, cacheflush(2) is your only option.
>
>   Is it not a kernel bug then?

I don't think so. cacheflush(2) is the only way for the kernel to know 
that it needs to do extra work.  The alternative is to not use ASIDs in 
the TLB and caches, and just invalidate all caches whenever we change 
contexts.

We carry a lot complexity in the kernel to avoid unnecessary TLB and 
cache invalidations.  All that goes out the window (with the performance 
improvements that it brings) if you want to magically make cacheflush(2) 
unnecessary.

> Shouldn't migration code enforce cache
> coherency manually if hardware does not?  User software is supposed to
> have a consistent view of the system and such details as being run on a
> multiprocessor should be completely hidden.

Traditionally on MIPS, the ICache is not coherent, going from non-SMP to 
SMP doesn't magically make it coherent.  Part of the ABI is that if you 
have self modifying code, you must call cacheflush(2)  If you violate 
the ABI, it won't work.

David Daney

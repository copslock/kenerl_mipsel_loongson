Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Feb 2015 22:40:12 +0100 (CET)
Received: from mail-ig0-f179.google.com ([209.85.213.179]:43173 "EHLO
        mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007274AbbBYVkLWpcLF (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 25 Feb 2015 22:40:11 +0100
Received: by mail-ig0-f179.google.com with SMTP id l13so9636581iga.0
        for <linux-mips@linux-mips.org>; Wed, 25 Feb 2015 13:40:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=ewYFtQQywrQpPAP8l+MNuZja/tdEibvgb5VUmddy7Lw=;
        b=kplRFnnI0ijD/m+h3Nssng2SkQZaTsm1BS5Ofko1EOo0N7u1aOTorz+kPtSi+hlQPF
         kFN6GQsAGdoqUdyzEN5+TR6HgffjFv495f4GrETGjmSwejzwTNYYxn+tB2PwGO87tcna
         MU7/bClWuMYeR8GJqeXI921mMVW9twQn4WgU1veEP3n+uuXkSym0G9RXfYLBYl6YhAx4
         khteF6MlPdhwQphHuaP3zD4HIFaXuMJrJDy97cnuaoyhamlPSZmxKn2atFDQiuScFx3A
         LRHOdHe3wkchFk1HsuY5QiZZpVHwxtOpBX7uHgZREKrQLJhFtOXGLhBjOA37Ciic0ZOO
         GvwA==
X-Received: by 10.50.129.9 with SMTP id ns9mr7509119igb.24.1424900406054;
        Wed, 25 Feb 2015 13:40:06 -0800 (PST)
Received: from dl.caveonetworks.com (64.2.3.194.ptr.us.xo.net. [64.2.3.194])
        by mx.google.com with ESMTPSA id a196sm3719425ioe.41.2015.02.25.13.40.05
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 25 Feb 2015 13:40:05 -0800 (PST)
Message-ID: <54EE4134.2050501@gmail.com>
Date:   Wed, 25 Feb 2015 13:40:04 -0800
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     =?ISO-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
CC:     Paul Martin <paul.martin@codethink.co.uk>,
        linux-mips@linux-mips.org
Subject: Re: 4.0-rc1 breakage in FPE?
References: <20150225182048.GC31062@paulmartin.codethink.co.uk> <yw1xh9u97k5c.fsf@unicorn.mansr.com>
In-Reply-To: <yw1xh9u97k5c.fsf@unicorn.mansr.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45978
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

On 02/25/2015 01:31 PM, Måns Rullgård wrote:
> Paul Martin <paul.martin@codethink.co.uk> writes:
>
>> Some change between 3.19 and 4.0-rc1 has broken the FPE such that some
>> code running on an Octeon II is subtly not working.
>>

Can you say where your userspace comes from, so we can try to reproduce 
the issue?



>> eg.
>>
>>    $ echo "1 2" | gawk '{ print $1 }'
>>    1 2
>>
>> which should output (and does output on 3.19)
>>
>>    $ echo "1 2" | gawk '{ print $1 }'
>>    1
>>
>> I'm going to try bisecting this over the next few days.
>
> Are you running a 32-bit userland?  If so, enabling
> MIPS_O32_FP64_SUPPORT should fix this.

??

32-bit userland (Debian for instance) typically shouldn't need special 
"Exprimental" config options enabled.

If we can identify the offending patch, we should revert it.


David Daney

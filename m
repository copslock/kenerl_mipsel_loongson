Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 16 May 2010 19:04:22 +0200 (CEST)
Received: from mail-pv0-f177.google.com ([74.125.83.177]:55437 "EHLO
        mail-pv0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491827Ab0EPRER (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 16 May 2010 19:04:17 +0200
Received: by pvg3 with SMTP id 3so1540573pvg.36
        for <multiple recipients>; Sun, 16 May 2010 10:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=PEWxaZuUAZ8WN/WxW39Gp8gGqcvRKmv+jolhKtIBQF8=;
        b=Fy84+dS0hF/QYQzjxld3w5OdMDYGL+OW/QQcNSyY3VMRB8MhCdZ8BdPiq0NirZi75u
         k7dHB0YAZ/CNMK3BwzREVIRGytcYdOcpGa7gLB+cmc49uASDOb4njLaNL2YgMpyRD8e6
         jcHWJXMHxRUGHT3qzHVF/z1xNKlZt7PjLiZgw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=qU59JdE9UMz3aTbX5Iuji9jAFh/pyHd7w9T31+f4ZaL5QNTqVAxm42P3B8ZakERoTi
         bgv3EYb+CC7kUrqHdh/se1SPbR37eb3LLTIiYEfT7+WqKG3EF2dp/X9YMfsyX8d/1rlu
         B2rs+WC6GWqQjHSJN7C6iMiHALjfUrjZor8hY=
Received: by 10.115.84.40 with SMTP id m40mr3346649wal.223.1274029450028;
        Sun, 16 May 2010 10:04:10 -0700 (PDT)
Received: from dd_xps.caveonetworks.com (adsl-67-127-190-169.dsl.pltn13.pacbell.net [67.127.190.169])
        by mx.google.com with ESMTPS id c14sm41145537waa.13.2010.05.16.10.04.08
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 16 May 2010 10:04:08 -0700 (PDT)
Message-ID: <4BF02587.5020303@gmail.com>
Date:   Sun, 16 May 2010 10:04:07 -0700
From:   David Daney <david.s.daney@gmail.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.9) Gecko/20100330 Fedora/3.0.4-1.fc11 Thunderbird/3.0.4
MIME-Version: 1.0
To:     wuzhangjin@gmail.com
CC:     Ralf Baechle <ralf@linux-mips.org>,
        linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH 7/9] tracing: MIPS: Reduce the overhead of dynamic Function
 Tracer
References: <cover.1273834561.git.wuzhangjin@gmail.com>  <6b4495690164114ff7353c86f6b53b979fca2756.1273834562.git.wuzhangjin@gmail.com>  <4BED8524.8010805@gmail.com> <1273891425.8552.12.camel@localhost>
In-Reply-To: <1273891425.8552.12.camel@localhost>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <david.s.daney@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26741
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: david.s.daney@gmail.com
Precedence: bulk
X-list: linux-mips

On 05/14/2010 07:43 PM, Wu Zhangjin wrote:
> On Fri, 2010-05-14 at 10:15 -0700, David Daney wrote:
>    
>> On 05/14/2010 04:08 AM, Wu Zhangjin wrote:
>>      
>>> From: Wu Zhangjin<wuzhangjin@gmail.com>
>>>
>>> With the help of uasm, this patch encodes the instructions of dynamic
>>> Function Tracer in ftrace_dyn_arch_init() when initializing it.
>>>
>>>        
>> [...]
>>      
>>> +#include<asm/uasm.h>
>>>
>>>        
>> All of uasm is _cpuinit, I haven't checked everything, but are you sure
>> you aren't calling if from non-_cpuinit code?
>>      
> The calling tree looks like this:
>
> start_kernel()  // __init
>    -->  ftrace_init()  // __init
>          -->  ftrace_dyn_arch_init() // __init
>                -->  ftrace_dyn_arch_init_insns() // inline
> 	            -->  uasm_*/UASM_*
>
> Nobody else will call uasm_*/UASM_* in this patch, I have checked the
> uasm usage in arch/mips/kernel/traps.c. Seems the usam functions are
> also called in the __init *set_except_vector(). so, it will also be safe
> in this patch, is it?
>
>    

Yes, that seems good to me.  I just wanted to make sure that this wasn't 
being called from non-init code.

David Daney

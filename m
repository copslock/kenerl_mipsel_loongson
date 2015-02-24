Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Feb 2015 23:58:07 +0100 (CET)
Received: from mail-ig0-f172.google.com ([209.85.213.172]:36111 "EHLO
        mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007145AbbBXW6FtBghd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 24 Feb 2015 23:58:05 +0100
Received: by mail-ig0-f172.google.com with SMTP id l13so30913679iga.5;
        Tue, 24 Feb 2015 14:57:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=9KepSmF9evTJm+J2d2gKkBXjgbRjQB49G1zih4W7JmU=;
        b=rxo0bmhAPT89/koCtsVU9/GZt9GUud1+fDaTcZ+jlRsD0UVBXym4tOabp4PhYSoNgd
         DNDFjmUkQmhCxImHZ/VIJcVOwTe+ymr4uBLzJ3TpyrAZK4k8Mq1r/rTnstwKetH3KTN0
         WBefw3ouQKPLrjLDHwYuYERuSVrV26j7lplXQw4U/pTOUnyIIXELRIwoQdYHZ/8msyx6
         mI+KTI7/4oaB/H4oWOqJT6xGIH1RFZV5FUKMGgaRfmmd2KzH/7WV3lwhby9eWHUw/ZxC
         zRg9iw+kA6PtX35H4wXT6+WPid0roOxU66/FVovJPgW6OlcQp+egkOduyEK34qlZUgIq
         DXbw==
X-Received: by 10.107.40.2 with SMTP id o2mr811534ioo.68.1424818679761;
        Tue, 24 Feb 2015 14:57:59 -0800 (PST)
Received: from dl.caveonetworks.com (64.2.3.194.ptr.us.xo.net. [64.2.3.194])
        by mx.google.com with ESMTPSA id 184sm15185731ion.14.2015.02.24.14.57.58
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 24 Feb 2015 14:57:59 -0800 (PST)
Message-ID: <54ED01F5.8040409@gmail.com>
Date:   Tue, 24 Feb 2015 14:57:57 -0800
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
References: <1424362664-30303-1-git-send-email-Steven.Hill@imgtec.com> <1424362664-30303-2-git-send-email-Steven.Hill@imgtec.com> <CAJiQ=7DMBznB5Ths0sAZORf2hgSQRuBoPF-7HGHhcHn0EajnWg@mail.gmail.com> <54EBCC38.7000702@imgtec.com> <54EBD023.8090706@imgtec.com> <alpine.LFD.2.11.1502240224500.17311@eddie.linux-mips.org> <54ECE7CE.4040407@imgtec.com> <alpine.LFD.2.11.1502242140220.17311@eddie.linux-mips.org> <54ECF3E6.9080606@imgtec.com> <alpine.LFD.2.11.1502242235160.17311@eddie.linux-mips.org>
In-Reply-To: <alpine.LFD.2.11.1502242235160.17311@eddie.linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45940
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

On 02/24/2015 02:50 PM, Maciej W. Rozycki wrote:
> On Tue, 24 Feb 2015, Leonid Yegoshin wrote:
>
>>>    For simplicity perhaps on SMP we should just always use hit operations
>>> regardless of the size requested.
>>
>> High performance folks may not like doing a lot of stuff for 8MB VMA release
>> instead of flushing 64KB.
>
>   What kind of a use case is that, what does it do?
>
>> Especially taking into account TLB exceptions and postprocessing in
>> fixup_exception() for swapped-out/not-yet-loaded-ELF blocks.
>
>   The normal use for cacheflush(2) I know of is for self-modifying or other
> run-time-generated code, to synchronise caches after a block of machine
> code has been patched in -- SYNCI can also be used for that purpose these
> days,

SYNCI is only useful in non-SMP kernels.

If a thread is migrated to a different CPU between the SYNCI, and the 
attempt to execute the freshly generated code, the new CPU can still 
have a dirty ICACHE.  So for Linux userspace, cacheflush(2) is your only 
option.

David Daney

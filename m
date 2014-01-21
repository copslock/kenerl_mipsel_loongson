Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Jan 2014 22:03:48 +0100 (CET)
Received: from mail-ie0-f176.google.com ([209.85.223.176]:45248 "EHLO
        mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6823127AbaAUVDqZxXvC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 21 Jan 2014 22:03:46 +0100
Received: by mail-ie0-f176.google.com with SMTP id tp5so4210535ieb.21
        for <multiple recipients>; Tue, 21 Jan 2014 13:03:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=s+Bjp5UhLRCk1tCAzKKxpwGyWRQXIJuqxyXRtSSRqc0=;
        b=U5GjICaP5WTzwHadGAZxivfIeuTpnOdeOFy/hhNkGUm/p8prh2vQHR8rk+ZXI80zrl
         BSq+TkMsrC+RQG58KnT/0INSVa7DyAMibYNk8xh48b2TjkvWUHEUgnklKZRlSlPye7gV
         6mCs2Q6Y0imQqolFlTyqaTRc7TlbkpqyZp9fIcbjdCQhlmGpY1ZxgPzxafaLhmMtOxeF
         t6C20BhuO3OKcj5PaSV4rfza6Q9JbAHBmCJRzBL39IewA+YgMXO0tZ9SHt7i0AocdAzW
         DvUbJnZrw+Vih0EZ8omgybPOUeO6ufaKOD8F+ZlUQIOsy6+hYvPpbpGs1Zg8XcoYayq+
         5iTw==
X-Received: by 10.50.119.3 with SMTP id kq3mr19981545igb.12.1390338219949;
        Tue, 21 Jan 2014 13:03:39 -0800 (PST)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id kb10sm15020706igb.6.2014.01.21.13.03.38
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 21 Jan 2014 13:03:39 -0800 (PST)
Message-ID: <52DEE0A9.4010007@gmail.com>
Date:   Tue, 21 Jan 2014 13:03:37 -0800
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     "Steven J. Hill" <Steven.Hill@imgtec.com>
CC:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: lib: Optimize partial checksum ops using prefetching.
References: <1390321122-25634-1-git-send-email-Steven.Hill@imgtec.com> <20140121204938.GW14169@linux-mips.org> <52DEDF84.1000006@imgtec.com>
In-Reply-To: <52DEDF84.1000006@imgtec.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39051
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

On 01/21/2014 12:58 PM, Steven J. Hill wrote:
> On 01/21/2014 02:49 PM, Ralf Baechle wrote:
>> On Tue, Jan 21, 2014 at 10:18:42AM -0600, Steven J. Hill wrote:
>>
>>> From: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
>>>
>>> Use the PREF instruction to optimize partial checksum operations.
>>
>> Prefetch operations may cause obscure bus error exceptions on some
>> systems
>> such as Malta, for example, when prefetching beyond the end of memory.
>> It may also mean memory regions that are just undergoing a DMA transfer
>> are being brought back into cache.
>>
>> This pretty much means that pref is only safe to use on cache-coherent
>> systems.
>>
> So, could we have:
>
>     #ifdef CONFIG_DMA_NONCOHERENT
>     #undef CONFIG_CPU_HAS_PREFETCH
>     #endif
>     #define PREFSIZE   (1 << MIPS_L1_CACHE_SHIFT)
>
> and then use the PREFSIZE value instead of the hardcoded value of 32?

See arch/mips/mm/page.c for code that tries to do something sensible 
with streaming prefetches.


>
> Steve
>
>
>
>

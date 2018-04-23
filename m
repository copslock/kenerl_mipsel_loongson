Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Apr 2018 13:58:55 +0200 (CEST)
Received: from smtp.codeaurora.org ([198.145.29.96]:44060 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993070AbeDWL6sAaOAK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 23 Apr 2018 13:58:48 +0200
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 048B360FF9; Mon, 23 Apr 2018 11:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1524484721;
        bh=ocaL3N+TbssSwNzIk35QuAlR9EBDeJEFn450nQVQNhA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ZSs37GQDcujuKGTEho/PNfCQQpONM9EsXpt+oWDAYJGE5bOeM4gJ9ZCZuFPg2zTLL
         VM/ys/cKk/Qe/xAv0sGLFvkYjnCOpE4M9fZkyNcPfv4127Zj49LQDyq1IdwoR4TybX
         kK1YWh9QGWsMZ5ttm5f0cTU5b+kuqNLTBrFM3wDU=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id C62D960FFA;
        Mon, 23 Apr 2018 11:58:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1524484719;
        bh=ocaL3N+TbssSwNzIk35QuAlR9EBDeJEFn450nQVQNhA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lvov2jVfMQeCvIU75NxlpmdPaIp3ULI3Mcj7psUeLrM+GkaajEplI0mj4eaFJfVV0
         +y8RhvYSD5VHsRD2EuzoBvMFJSTC30rrdjE4C8e4GpuzonvNgBHfrZy1sGpUe6Faiy
         hqJ3BkyX43ObFqCDlDUMJpGenKm1UXNhuQyxZeqA=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 23 Apr 2018 07:58:39 -0400
From:   okaya@codeaurora.org
To:     Huacai Chen <chenhc@lemote.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <james.hogan@mips.com>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        stable <stable@vger.kernel.org>, chenhuacai@gmail.com
Subject: Re: [PATCH] MIPS: io: Add barrier after register read in inX()
In-Reply-To: <CAAhV-H6R8=59WLEOHRNhMHvNsrZXUZnShr94BfCY2xhgZZj7+Q@mail.gmail.com>
References: <1524455600-30384-1-git-send-email-chenhc@lemote.com>
 <c5a26d6f1e6ba35a4d45450adfa36aa3@codeaurora.org>
 <CAAhV-H6R8=59WLEOHRNhMHvNsrZXUZnShr94BfCY2xhgZZj7+Q@mail.gmail.com>
Message-ID: <80ba8c398092f2570dee009504faafed@codeaurora.org>
X-Sender: okaya@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Return-Path: <okaya@codeaurora.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63699
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: okaya@codeaurora.org
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

On 2018-04-23 00:51, Huacai Chen wrote:
> Your patch add rmb() before read in readX(), why inX() need rmb() after 
> read?
> 

I had to double check what ioswab macro does.

/*
  * Raw operations are never swapped in software.  OTOH values that raw
  * operations are working on may or may not have been swapped by the bus
  * hardware.  An example use would be for flash memory that's used for
  * execute in place.
  */
# define __raw_ioswabb(a, x)	(x)
# define __raw_ioswabw(a, x)	(x)
# define __raw_ioswabl(a, x)	(x)
# define __raw_ioswabq(a, x)	(x)
# define ____raw_ioswabq(a, x)	(x)

/* ioswab[bwlq], __mem_ioswab[bwlq] are defined in mangle-port.h */

So, neither my patch nor yours places rmb before read.

Both are placing it after read and it is the right thing.

ioswab is just an endianness conversion macro.

> Huacai
> 
> On Mon, Apr 23, 2018 at 12:31 PM,  <okaya@codeaurora.org> wrote:
>> On 2018-04-22 23:53, Huacai Chen wrote:
>>> 
>>> While a barrier is present in the outX() functions before the 
>>> register
>>> write, a similar barrier is missing in the inX() functions after the
>>> register read. This could allow memory accesses following inX() to
>>> observe stale data.
>>> 
>>> This patch is very similar to commit a1cc7034e33d12dc1 ("MIPS: io: 
>>> Add
>>> barrier after register read in readX()"). Because 
>>> war_io_reorder_wmb()
>>> is both used by writeX() and outX(), if readX() need a barrier then 
>>> so
>>> does inX().
>>> 
>>> Cc: stable@vger.kernel.org
>>> Signed-off-by: Huacai Chen <chenhc@lemote.com>
>>> ---
>>>  arch/mips/include/asm/io.h | 2 ++
>>>  1 file changed, 2 insertions(+)
>>> 
>>> diff --git a/arch/mips/include/asm/io.h b/arch/mips/include/asm/io.h
>>> index a7d0b83..cea8ad8 100644
>>> --- a/arch/mips/include/asm/io.h
>>> +++ b/arch/mips/include/asm/io.h
>>> @@ -414,6 +414,8 @@ static inline type pfx##in##bwlq##p(unsigned long
>>> port)                     \
>>>         __val = *__addr;                                              
>>>   \
>>>         slow;                                                         
>>>   \
>>>                                                                       
>>>   \
>>> +       /* prevent prefetching of coherent DMA data prematurely */    
>>>   \
>>> +       rmb();                                                        
>>>   \
>>>         return pfx##ioswab##bwlq(__addr, __val);                      
>>>   \
>>>  }
>> 
>> 
>> Typically read barrier is applied after register read.

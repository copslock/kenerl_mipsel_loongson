Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Aug 2010 15:59:36 +0200 (CEST)
Received: from mail-iw0-f177.google.com ([209.85.214.177]:48442 "EHLO
        mail-iw0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491074Ab0H3N7c convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 30 Aug 2010 15:59:32 +0200
Received: by iwn40 with SMTP id 40so5552970iwn.36
        for <multiple recipients>; Mon, 30 Aug 2010 06:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=PU6LtQ6v2ebjNPoxePJr7x1SbiLdbUuuH9IhjRdWU04=;
        b=S3K/PeWunbkrD1EYlvasv2H3cernow7fPtShxB3NSzOCitJ1A8hA6knPdm+Fg9hHgA
         zUOwhud9KnaQByKH8H8vN6sLUQs6olE79sTHt1xrgvGkJDqczPg37MTIAxesXGUdYJVS
         SI/FaYjA00IYXQjmjm8EWRcHQEWgxXl3HDNiw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=BkK8tfugGs3XdZtl/Dj0RSMaMXpZdY286uyvE2ObBSOO0HrAF7ITFFdqtmosAeE0M0
         7WXpTcXYiWDN3AB4ep+++IowvGOnhmsC3VXnUBWtfITNtQHW4o+/bF+w9/Cv5Jdw6I7f
         d2X7SugpA7lXE5mkG9GpD3JzIyHVyNivnUYsQ=
MIME-Version: 1.0
Received: by 10.231.30.134 with SMTP id u6mr5314446ibc.121.1283176708272; Mon,
 30 Aug 2010 06:58:28 -0700 (PDT)
Received: by 10.231.119.28 with HTTP; Mon, 30 Aug 2010 06:58:27 -0700 (PDT)
In-Reply-To: <AANLkTim53N4t7PXiRPNqtP0G9cEjMdQY77m73MVkApH5@mail.gmail.com>
References: <AANLkTikXife5CaPBQ4k_FUUM6-VD2C7SOOEbyugRhIqG@mail.gmail.com>
        <alpine.LFD.2.00.1006271745480.14683@eddie.linux-mips.org>
        <20100627205206.GB4554@linux-mips.org>
        <AANLkTim53N4t7PXiRPNqtP0G9cEjMdQY77m73MVkApH5@mail.gmail.com>
Date:   Mon, 30 Aug 2010 21:58:27 +0800
Message-ID: <AANLkTinAP93+W8AYsc_PmjiE0doCERaYiQg4=ztZm_wA@mail.gmail.com>
Subject: Re: some question about wmb in mips
From:   loody <miloody@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        "Maciej W. Rozycki" <macro@linux-mips.org>
Cc:     Linux MIPS Mailing List <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <miloody@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27697
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: miloody@gmail.com
Precedence: bulk
X-list: linux-mips

hi all:

2010/7/6 loody <miloody@gmail.com>:
> Dear ralf and maciej:
> 2010/6/28 Ralf Baechle <ralf@linux-mips.org>:
>> On Sun, Jun 27, 2010 at 06:47:14PM +0100, Maciej W. Rozycki wrote:
>>
>>> > AFAIK, wmb in mips is implemented by calling sync,
>>>
>>>  For platforms that support this instructions, yes.
>>
>> For platforms that support this instruction _AND_ are not strongly ordered.
>> Iow we try to avoid it, if possible.  Details are complicated.
>>
>>> > wmb->fast_wmb->__sync, which makes sure Loads and stores executed
>>> > before the SYNC are completed before loads
>>> > and stores after the SYNC can start
>>>
>>>  You shouldn't be relying on implementation details -- WMB is defined as a
>>> write ordering barrier only, so all the interface guarantees is any
>>> outstanding stores will be seen on the processor's bus interface before
>>> any future store starts.  This is AFAIR the case with (at least some)
>>> platforms that do not have the SYNC instruction -- where any outstanding
>>> stores can still be delayed until after a future load.
>>>
>>>  Actually with the recent introduction of the SYNC_WMB instruction it's
>>> likely it'll get used as the implementation of the WMB interface as soon
>>> as the distribution of the instruction is wide enough across platforms.
>>> As the name implies, this instruction only guarantees an ordering barrier
>>> for stores and not for loads.
>>>
>>> > But will this instruction write the cache back too?
>>>
>>>  No, SYNC is only meaningful for uncached (and cached coherent) accesses.
>>> I think that's clear from how the instruction has been specified.
>>>
>>> > take usb example, it will call this maco before it let host processing
>>> > the commands on dram, so I wondering whether sync will write the cache
>>> > back to memory.
>>>
>>>  You need to call the appropriate helper -- see the DMA API document for
>>> details.  Or use a coherent (in the Linux sense) mapping, which in turn
>>> will make CPU-side memory accesses to this area uncached on non-coherent
>>> (in the MIPS sense) systems.
> thanks for your suggestion. :)
> I will take look at the DMA API for details.
> appreciate your help,
after reading the DMA api document and check the source code.
I found mips seems not implement "dma map ops", but x86 has implemented it.
What are they used for and why mips don't implement it?
appreciate your help,
miloody

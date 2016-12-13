Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Dec 2016 20:18:45 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:31273 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993061AbcLMTSimCmMd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 13 Dec 2016 20:18:38 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 9E44B6E781FB9;
        Tue, 13 Dec 2016 19:18:26 +0000 (GMT)
Received: from BAMAIL02.ba.imgtec.org (10.20.40.28) by HHMAIL01.hh.imgtec.org
 (10.100.10.19) with Microsoft SMTP Server (TLS) id 14.3.294.0; Tue, 13 Dec
 2016 19:18:29 +0000
Received: from [10.20.2.61] (10.20.2.61) by bamail02.ba.imgtec.org
 (10.20.40.28) with Microsoft SMTP Server (TLS) id 14.3.266.1; Tue, 13 Dec
 2016 11:18:27 -0800
Message-ID: <58504983.2050608@imgtec.com>
Date:   Tue, 13 Dec 2016 11:18:27 -0800
From:   Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
MIME-Version: 1.0
To:     "Maciej W. Rozycki" <macro@imgtec.com>
CC:     Florian Fainelli <f.fainelli@gmail.com>,
        Justin Chen <justinpopo6@gmail.com>,
        <linux-mips@linux-mips.org>,
        <bcm-kernel-feedback-list@broadcom.com>,
        Justin Chen <justin.chen@broadcom.com>
Subject: Re: [RFC] MIPS: Add cacheinfo support
References: <20161208011626.20885-1-justinpopo6@gmail.com> <5849EC43.2070802@imgtec.com> <CAJx26kW0e-HC0VUTObZ5Or+XjFvE9KmtOToKbFvKYvhE--Vw5A@mail.gmail.com> <584A0281.3040505@imgtec.com> <3004fca6-3688-65bb-7c86-248603482088@gmail.com> <584F0C71.5010004@imgtec.com> <6981ff1e-685e-2df7-4b6e-c67c3aa735e7@gmail.com> <584F3E9D.9030501@imgtec.com> <alpine.DEB.2.00.1612131101200.6743@tp.orcam.me.uk>
In-Reply-To: <alpine.DEB.2.00.1612131101200.6743@tp.orcam.me.uk>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.20.2.61]
Return-Path: <Leonid.Yegoshin@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56035
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Leonid.Yegoshin@imgtec.com
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

On 12/13/2016 03:09 AM, Maciej W. Rozycki wrote:
> On Tue, 13 Dec 2016, Leonid Yegoshin wrote:
>
>> Well, I prefer the collection of 3 flags:
>>
>> flush_required        - or flush to next level is required to force coherency
>> between this level and next after update of this level
>> invalidate_required   - or invalidate is required to force coherency between
>> this level and next after update of next level
>> coherent_to_level     - object is coherent with this level (only one domain of
>> coherency on this level is assumed)
>   A "flush" has always been an ambiguous term -- meaning anything from
> "write-back", through "write-back+invalidate" to "invalidate".  What is
> "flush" is supposed to exactly mean here?  If specifically any of the two
> formers (the latter is obviously the other flag), then I suggest using the
> respective name, or otherwise if it is meant to be generic "do what is
> needed", then perhaps "synchronize" will work, like with the name of the
> SYNCI instruction?
>
Well, I am not expert in choosing names, you know. I just would like to 
make a distinguishing between "transfer data from this level to next 
one" - any way - writeback or write-back-invalidate, and "clear data in 
this level to be pulled on demand from next level".

This is an information purpose as Florian described, so details can be 
skipped. The only useful info here - some efforts are needed after event 
(see above) and that efforts are not cheap from performance point of view.

If we put here details then it is a long way because we need a lot of 
details, see my original post. However, I would like to differ "flush" 
and "invalidate" because it is triggered by different kind of event 
(from upstream or from downstream).

- Leonid.

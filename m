Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Nov 2011 01:48:37 +0100 (CET)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:14629 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903811Ab1KVAsc (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 22 Nov 2011 01:48:32 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4ecaf1b40000>; Mon, 21 Nov 2011 16:49:56 -0800
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Mon, 21 Nov 2011 16:48:30 -0800
Received: from dd1.caveonetworks.com ([64.2.3.195]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Mon, 21 Nov 2011 16:48:30 -0800
Message-ID: <4ECAF15E.1070008@caviumnetworks.com>
Date:   Mon, 21 Nov 2011 16:48:30 -0800
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.15) Gecko/20101027 Fedora/3.0.10-1.fc12 Thunderbird/3.0.10
MIME-Version: 1.0
To:     Linus Torvalds <torvalds@linux-foundation.org>
CC:     David Daney <ddaney.cavm@gmail.com>,
        David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "ralf@linux-mips.org" <ralf@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        David Daney <david.daney@cavium.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        Robin Holt <holt@sgi.com>
Subject: Re: [patch] hugetlb: remove dummy definitions of HPAGE_MASK and HPAGE_SIZE
References: <1321567050-13197-1-git-send-email-ddaney.cavm@gmail.com> <alpine.DEB.2.00.1111171520130.20133@chino.kir.corp.google.com> <alpine.DEB.2.00.1111171522131.20133@chino.kir.corp.google.com> <4ECACF68.3020701@gmail.com> <CA+55aFwZxqHfEOemj+OJNKCj2toqGf3rkK-9iuS39L7iZsoH1Q@mail.gmail.com> <4ECAE314.9060209@gmail.com>  <CA+55aFx==PGGLX9YXv1GOeTja4W0PSW8U4i8zkmtiZwqmFwHFw@mail.gmail.com>
In-Reply-To: <CA+55aFx==PGGLX9YXv1GOeTja4W0PSW8U4i8zkmtiZwqmFwHFw@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 22 Nov 2011 00:48:30.0472 (UTC) FILETIME=[743C4880:01CCA8B0]
X-archive-position: 31910
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 18084

On 11/21/2011 04:37 PM, Linus Torvalds wrote:
> On Mon, Nov 21, 2011 at 3:47 PM, David Daney<ddaney.cavm@gmail.com>  wrote:
>>
>> These symbols are on dead code paths, so they are eliminated by the
>> compiler's Dead Code Elimination (DCE) optimizations, and the BUG() code
>> never gets emitted to the final executable.
>
> If you are so damn sure of that, then DON'T MAKE IT A BUG_ON! If you
> are 100% syre, then you might as well leave out the BUG_ON() entirely.
>
> Seriously. What's so hard to understand?

Really Linus, did you read the other half of the message you quoted?

The part you quote above explains the reason things are the way they 
currently are.

The second part, that I think you may have missed, is the part I had 
hoped you would read...

>
> Either you are 100% sure, or you are not. If you are 100% sure, then
> the BUG_ON() is pointless. And if you are not, then the BUG_ON() is
> *wrong*.
>
> Notice? The BUG_ON() is never *ever* valid. You cannot have it both
> ways. So stop pushing crap, already!
>
> So what are non-crap solutions?
>
>   - the current one: error out at compile time (early) if somebody uses
> them in invalid contexts.
>
>     This seems to be a good case, especially since apparently no actual
> current code wants to use them outside of the existing #ifdef's. And
> there is no reason to think that some random MIPS-only future code is
> a good enough reason to re-introduce these things
>
>   - if you really want to use them, but expect the compiler to always
> compile them away as dead code, use a non-existing function linkage,
> so that you at least get a static failure at link-time for incorrect
> code, rather than some random BUG_ON() at run-time that may be
> impossible to find.
>
> See? There are real solutions. BUG_ON() is not one of them.

... because it said exactly what you say above.

I will send you a patch within the next two hours that shows what may be 
an acceptable solution.

Thanks,
David Daney

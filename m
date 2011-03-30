Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 30 Mar 2011 18:39:56 +0200 (CEST)
Received: from mail-gw0-f49.google.com ([74.125.83.49]:37010 "EHLO
        mail-gw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491179Ab1C3Qjx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 30 Mar 2011 18:39:53 +0200
Received: by gwb1 with SMTP id 1so632170gwb.36
        for <linux-mips@linux-mips.org>; Wed, 30 Mar 2011 09:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=yvjJl2JBlx4TIfzhGrmd1bqhCZXwO1IeOWIZMB4CE2Y=;
        b=gpNW1NbHcZfaYBw5oOKXfAMBWzR7nkvdX6LSZrFEkMeLCFTgt+GlY+1uJyWNNtpFPh
         gtKNxtYKjrklQ/8D8f4lZOQh3Bykcrn3BK9Lo1HUxcqurPXxaAwx9+Ods/EmCkhezvVy
         Ptx4BcqDbGtCZXNwU3LKy9Nr2jfLJ2ncHe1M8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=PVhVyH02uchyW/7D9WGT/6AvepyxQxTfGy5jeLhQI1G9AW5umV5sjld34dwDrgm1Fc
         7P2ZdQjN3RTLneM/yLvpT4r2pAovDoCEYxj5jgz8U79oxdTFE/Zaa5CMoMzeaxsH0vJP
         X72aKDGUisReFiizaTKuT9ZIOgz8OlZ8l7TmE=
Received: by 10.236.176.166 with SMTP id b26mr2016898yhm.287.1301503187266;
        Wed, 30 Mar 2011 09:39:47 -0700 (PDT)
Received: from dd_xps.caveonetworks.com ([12.108.191.226])
        by mx.google.com with ESMTPS id h59sm116208yhm.99.2011.03.30.09.39.45
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 30 Mar 2011 09:39:45 -0700 (PDT)
Message-ID: <4D935CD3.2030706@gmail.com>
Date:   Wed, 30 Mar 2011 09:39:47 -0700
From:   David Daney <david.s.daney@gmail.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.15) Gecko/20110307 Fedora/3.1.9-0.38.b3pre.fc13 Thunderbird/3.1.9
MIME-Version: 1.0
To:     Gergely Kis <gergely@homejinni.com>
CC:     linux-mips@linux-mips.org
Subject: Re: Oprofile callgraph support on the MIPS architecture
References: <AANLkTinDFQFLiHZoKw2kPpVov80xc08FFxLjYsORKyKd@mail.gmail.com> <4D8ED363.9050001@gmail.com> <AANLkTinJdwqL=OrCYfUcrd7j-h9vtT0F02T8ntzxQbK8@mail.gmail.com>
In-Reply-To: <AANLkTinJdwqL=OrCYfUcrd7j-h9vtT0F02T8ntzxQbK8@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <david.s.daney@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29653
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: david.s.daney@gmail.com
Precedence: bulk
X-list: linux-mips

On 03/29/2011 03:57 PM, Gergely Kis wrote:

[...]
>> That said, how do you handle the case of getting a fault while reading
>> code/data while unwinding?
>>
> In case there is a fault, we basically return to the caller, so the
> building of the callgraph is stopped. We looked at the ARM version and
> they handled this case in a similar way.
>

But it looks like you are invoking get_user() from interrupt context?  
As far as I know that is not allowed.  Have you tested it?

I don't see where you handle faults when trying to read kernel memory.


>> Also I don't see how you handle these cases:
>>
>> o Leaf functions where neither the $ra is saved to the stack, nor the stack
>> pointer adjusted.
>>
> We currently don't have a special handling for this, but we plan to
> try to detect the prologue of leaf functions as well, if possible.
> This detection process will probably never be
> 100% accurate, but we have found the call graph outputs even in their
> current form useful.
>
> Oprofile call graphs are not always accurate anyways, because of the
> statistical nature of oprofile.
>
>> o Functions where $sp is adjusted several times (use of alloca() or VLAs).
>>
>> o Functions with multiple return points (i.e. 'jr $ra' in the middle of a
>> function).
> Yes, this is a shortcoming in the current implementation, we are
> already working on changing the prologue detection to detect the exact
> combination of the prologue instructions.
>
> We are also looking at the stack unwinding function used to display
> the kernel stacktraces when an oops or other error condition occurs,
> to see if we can refactor it to suit our needs as well. This way a
> single solution for stack walking could be included in the kernel.
>
>> o Functions with more than 1024 instructions.
> Currently we set this (arbitrary) limit. We can probably change it, or
> make it configurable, but until we are using heuristics to detect the
> function boundaries, I think we should have a maximum number of
> allowed steps for the stack walking functions.
>
> What do you think?
>

My questions about your unwinding algorithm were really rhetorical in 
nature.

It is not possible to do robust unwinding by code examination, precisely 
because there is no way to identify the start of a function.

David Daney

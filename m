Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 Jun 2012 18:39:31 +0200 (CEST)
Received: from mail-pb0-f49.google.com ([209.85.160.49]:56495 "EHLO
        mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903691Ab2FKQjZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 11 Jun 2012 18:39:25 +0200
Received: by pbbrq13 with SMTP id rq13so6371782pbb.36
        for <multiple recipients>; Mon, 11 Jun 2012 09:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=QzFOTJJ4hbcRSW1my/7hUKMNZuea2njFJJopNQ05E7A=;
        b=LNQniiSizxYwE/3E/J09W/H+eA+Af8Qzturnk0m36KDjX7F0AiNDuuJ4mEzJKJk14K
         NnEJCbK3J4QHIO/px1St2d4jXPzO2iNh26r+JSH84eD7bm+I9jiVsuJvjdZz0d8CN4iR
         4tQXg3X71Ui9eh8OydBoe97IDsgiwSR22znA6NiH2os+TSyn+ksHUxwuV0xzgwornG2g
         8zdfx15msVDVTK59vU7iRR9BkFAs6pNpWbFEm2Hky5NFxsZUFQijiRIE/jwm6+j9g5hw
         CHSKSCxnl06iYlEblr1R5JpqpsFLimwyj3dhXIb3fsURftUZsmoK5ku392ldtUaDNIH6
         kWIg==
Received: by 10.68.228.102 with SMTP id sh6mr27634241pbc.134.1339432759084;
        Mon, 11 Jun 2012 09:39:19 -0700 (PDT)
Received: from dd1.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id mt9sm18989780pbb.14.2012.06.11.09.39.17
        (version=SSLv3 cipher=OTHER);
        Mon, 11 Jun 2012 09:39:18 -0700 (PDT)
Message-ID: <4FD61F35.1080103@gmail.com>
Date:   Mon, 11 Jun 2012 09:39:17 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.15) Gecko/20101027 Fedora/3.0.10-1.fc12 Thunderbird/3.0.10
MIME-Version: 1.0
To:     Shane McDonald <mcdonald.shane@gmail.com>
CC:     linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH v2 5/5] MIPS: Move cache setup to setup_arch().
References: <1337040290-16015-1-git-send-email-ddaney.cavm@gmail.com>   <1337040290-16015-6-git-send-email-ddaney.cavm@gmail.com> <CACoURw4+N8Nk-N81kryXHOg9O_=ntvqv9prOLAZW6KKEYQ9v+A@mail.gmail.com> <4FD61B22.3040407@gmail.com>
In-Reply-To: <4FD61B22.3040407@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-archive-position: 33608
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On 06/11/2012 09:21 AM, David Daney wrote:
> On 06/10/2012 09:16 PM, Shane McDonald wrote:
>> I've run into a problem in linux-3.5-rc1, and I've tracked it down
>> to this patch, MIPS: Move cache setup to setup_arch().,
>> commit 6650df3c380e0db558dbfec63ed860402c6afb2a.
>>
>
> Are you permitted to describe the problem in any additional detail?
>
> Knowing what type of system is affected and the nature of the problem
> would be useful in trying to arrive at a good solution.
>

OK, for some reason I missed this bit...

[...]
>>
>> I'm running a single-CPU, PMC-Sierra RM7035C-based system.
>>
>> Before applying this patch, cca_setup() in arch/mips/mm/c-r4k.c
>> is called before coherency_setup() (called from rk4_cache_init()).
>> After applying the patch, it is called afterwards. Because
>> coherency_setup() relies on cca_setup() properly setting the
>> variable cca, it won't use the value of cca supplied on the
>> kernel command line.
>>
>> I haven't verified it, but I suspect the same problem will occur
>> with the call to setcoherentio(), also in c-r4k.c.
>>
>> Unfortunately, I don't have the knowledge to formulate a patch
>> to this problem, but I wanted to raise the issue.
>>
>> Shane McDonald
>>
>

I will think about how to fix it.

David Daney

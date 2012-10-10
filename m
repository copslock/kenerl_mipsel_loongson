Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Oct 2012 20:09:04 +0200 (CEST)
Received: from mail-pa0-f49.google.com ([209.85.220.49]:64097 "EHLO
        mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6872761Ab2JJSI5Ur1nO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 10 Oct 2012 20:08:57 +0200
Received: by mail-pa0-f49.google.com with SMTP id bi5so912353pad.36
        for <multiple recipients>; Wed, 10 Oct 2012 11:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=1As622FIsHyMUg4di5eAF0kuWtsHM/ai6C/QGdt30pc=;
        b=mLpNBbwxuJgDA3rh1w8yqh6UOURFe6WU5RvDkOGoEge5eEBtcv5wM7MB7PqTAalpwy
         fvyUnG2rB+mM6WFpucRW8MNqytRrgLq+/YxMttX4Xc6zwjY7fj1nziffajkXm/q7OiLA
         or2nSvu+sdOHMgjpE0t1i/aw5jjpu6JL4fcrfXWFYYP0eyHYIdOhtiJ4IQZWwCpn4GDo
         HEq59HwMURZJfbCWH6zOK9+shfac/OwbfLpDxZGJjf5VHNAi4gN9OgtQqmArDkuR3B5K
         A34MCsToNINzZ6x3iUzPNpy3sVX0Os+9JkUY8LvEA5x68AjNmB476pGcCWucmTOuEnx4
         BjTw==
Received: by 10.68.138.170 with SMTP id qr10mr75877566pbb.53.1349892530573;
        Wed, 10 Oct 2012 11:08:50 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id it5sm1359369pbc.10.2012.10.10.11.08.49
        (version=SSLv3 cipher=OTHER);
        Wed, 10 Oct 2012 11:08:50 -0700 (PDT)
Message-ID: <5075B9B1.2050503@gmail.com>
Date:   Wed, 10 Oct 2012 11:08:49 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:15.0) Gecko/20120828 Thunderbird/15.0
MIME-Version: 1.0
To:     Ronny Meeus <ronny.meeus@gmail.com>
CC:     "Maciej W. Rozycki" <macro@linux-mips.org>,
        Rich Felker <dalias@aerifal.cx>, linux-mips@linux-mips.org,
        "Pinski, Andrew" <Andrew.Pinski@caviumnetworks.com>
Subject: Re: 2GB userspace limitation in ABI N32
References: <CAMJ=MEfFsJH6Cqkow7-w3a352iYiWWi+ubOSJaqhh2bp2MqPZg@mail.gmail.com> <20121010080756.GC6740@linux-mips.org> <20121010125700.GR254@brightrain.aerifal.cx> <5075A8D8.2080704@gmail.com> <alpine.LFD.2.02.1210101805410.21287@eddie.linux-mips.org> <5075B19D.4080701@gmail.com> <CAMJ=MEf2LFcWLo8f061-WiM9dMt-hQJUmoRCCs6agZvc2VQrNQ@mail.gmail.com>
In-Reply-To: <CAMJ=MEf2LFcWLo8f061-WiM9dMt-hQJUmoRCCs6agZvc2VQrNQ@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-archive-position: 34679
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

On 10/10/2012 10:49 AM, Ronny Meeus wrote:
> This is exactly the platform we are targeting:
> - a Cavium processor
> - running 64bit Linux
> - 4Gb of ram of which almost 3Gb will be used by 1 process (consisting
> of multiple threads)
>
> It would be really great that we could get help from you guys here.

As far as I know, we are not actively working on this.  So, as I see it, 
your options are:

A) Use n64.

B) Do all the work yourself.

C) Pay someone to do the work for you.

David Daney


> Many thanks for the effort you are putting into this.
>
> On Wed, Oct 10, 2012 at 7:34 PM, David Daney <ddaney.cavm@gmail.com> wrote:
>> On 10/10/2012 10:10 AM, Maciej W. Rozycki wrote:
>>>
>>> On Wed, 10 Oct 2012, David Daney wrote:
>>>
>>>> The only disadvantage of doing this is that the code will be slightly
>>>> larger/slower as it takes three instructions to load a zero extended
>>>> 32-bit
>>>> pointer verses two for n32-2GB.
>>>
>>>
>>>    And of course such code will only run on 64-bit processors that not only
>>> support 64-bit data, but 64-bit addressing as well.
>>
>>
>> That's right.  All of this assumes a fully 64-bit operating system kernel
>> (Linux).
>>
>> It is not really very interesting on 'small' systems that have less than
>> about 1GB of RAM.  And obviously impossible if 64-bit addressing is not
>> supported.
>>
>> So the interesting use cases are 'modern' systems with 4GB or more of ram
>> installed.  And only then for the subset of applications that need more than
>> 2GB of virtual address space but will never need to consider more than 4GB.
>>
>>
>>
>>
>>>   That is implement the
>>> CP0.Status.UX bit rather than CP0.Status.PX only -- the latters are still
>>> compatible with the true n32 ABI.  See also CP0.Config.AT.
>>>
>>>     Maciej
>>>
>>>
>>
>>
>
>

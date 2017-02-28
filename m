Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Feb 2017 23:41:50 +0100 (CET)
Received: from prod-mail-xrelay06.akamai.com ([96.6.114.98]:36481 "EHLO
        prod-mail-xrelay06.akamai.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993177AbdB1WlkoUpLm (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 28 Feb 2017 23:41:40 +0100
Received: from prod-mail-xrelay06.akamai.com (localhost.localdomain [127.0.0.1])
        by postfix.imss70 (Postfix) with ESMTP id 9456E16C879;
        Tue, 28 Feb 2017 22:41:34 +0000 (GMT)
Received: from prod-mail-relay08.akamai.com (prod-mail-relay08.akamai.com [172.27.22.71])
        by prod-mail-xrelay06.akamai.com (Postfix) with ESMTP id 7D51716C86C;
        Tue, 28 Feb 2017 22:41:34 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; s=a1;
        t=1488321694; bh=fY01Nrj4LzO3CqMymQgPJUXsofCf7WUamgZRZ1dama8=;
        l=3135; h=To:References:Cc:From:Date:In-Reply-To:From;
        b=x5dyHDvZYRKXbJ1b9vjy7xvANd5tOa+P5ytM2qm0AIF3gFSjLFJtb6uxKP19tNyST
         fHBWxh+kc6XZpgr3Wexdi+CpcodAtKKJ4DhiBl+FUV9KYqiXvGJRDyT3OlzX04s6YH
         MY0RkPdAUDrCExv6y+XtgJ2yq5CwYLsH/tqkrZ4I=
Received: from [172.28.13.148] (bos-lpjec.kendall.corp.akamai.com [172.28.13.148])
        by prod-mail-relay08.akamai.com (Postfix) with ESMTP id A9C1298088;
        Tue, 28 Feb 2017 22:41:33 +0000 (GMT)
Subject: Re: [PATCH] jump_label: align jump_entry table to at least 4-bytes
To:     David Daney <ddaney@caviumnetworks.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sachin Sant <sachinp@linux.vnet.ibm.com>
References: <1488221364-13905-1-git-send-email-jbaron@akamai.com>
 <93219edf-0f6d-5cc7-309c-c998f16fe7ac@akamai.com>
 <aa139c18-1b04-2c20-2e22-89d74503b3cf@caviumnetworks.com>
 <20170227160601.5b79a1fe@gandalf.local.home>
 <6db89a8d-6053-51d1-5fd4-bae0179a5ebd@caviumnetworks.com>
 <20170227170911.2280ca3e@gandalf.local.home>
 <7fa95eea-20be-611c-2b63-fca600779465@caviumnetworks.com>
 <20170227173630.57fff459@gandalf.local.home>
 <7bd72716-feea-073f-741c-04212ebd0802@caviumnetworks.com>
 <68fe24ea-7795-24d8-211b-9d8a50affe9f@akamai.com>
 <510FF566-011D-4199-86F7-2BB4DBF36434@linux.vnet.ibm.com>
 <20170228112144.65455de5@gandalf.local.home>
 <cdf98840-8d43-2c58-e2f9-75ae8fb8a600@caviumnetworks.com>
 <1de00727-de97-f887-78bd-dd49131cdf61@akamai.com>
 <999e2c3f-698c-703c-67a9-26aea3c97dc0@caviumnetworks.com>
 <d10e986c-7f6a-3935-88e2-ba39708f79ad@caviumnetworks.com>
 <542488db-5c59-afa5-6d1d-a437c87bc613@akamai.com>
 <912fa97a-aa1d-c0e4-dc83-fc5c745db1c1@caviumnetworks.com>
Cc:     linux-mips@linux-mips.org, Chris Metcalf <cmetcalf@mellanox.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Russell King <linux@armlinux.org.uk>,
        Ralf Baechle <ralf@linux-mips.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Rabin Vincent <rabin@rab.in>,
        Paul Mackerras <paulus@samba.org>,
        Anton Blanchard <anton@samba.org>,
        linuxppc-dev@lists.ozlabs.org, Ingo Molnar <mingo@kernel.org>,
        linux-arm-kernel@lists.infradead.org, Zhigang Lu <zlu@ezchip.com>
From:   Jason Baron <jbaron@akamai.com>
Message-ID: <23989c10-7b47-3fda-f790-25b539704bec@akamai.com>
Date:   Tue, 28 Feb 2017 17:41:33 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <912fa97a-aa1d-c0e4-dc83-fc5c745db1c1@caviumnetworks.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <jbaron@akamai.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56936
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jbaron@akamai.com
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

On 02/28/2017 03:15 PM, David Daney wrote:
> On 02/28/2017 11:34 AM, Jason Baron wrote:
>>
>>
>> On 02/28/2017 02:22 PM, David Daney wrote:
>>> On 02/28/2017 11:05 AM, David Daney wrote:
>>>> On 02/28/2017 10:39 AM, Jason Baron wrote:
>>>>>
>>> [...]
>>>>>> I suspect that the alignment of the __jump_table section in the .ko
>>>>>> files is not correct, and you are seeing some sort of problem due to
>>>>>> that.
>>>>>>
>>>>>>
>>>>>
>>>>> Hi,
>>>>>
>>>>> Yes, if you look at the trace that Sachin sent the module being loaded
>>>>> that does the WARN_ON() is nfsd.ko.
>>>>>
>>>>> That module from Sachin's trace has:
>>>>>
>>>>>   [31] __jump_table      PROGBITS        0000000000000000 03fd77
>>>>> 0000c0
>>>>> 18 WAM  0   0  1
>>>>
>>>> The problem is then the section alignment (last column) for power.
>>>>
>>>> On mips with no patches applied, we get:
>>>>
>>>>   [17] __jump_table      PROGBITS        0000000000000000 00d2c0 000048
>>>> 00  WA  0   0  8
>>>>
>>>> Look, proper alignment!
>>>>
>>>> The question I have is why do the power ".llong" and ".long" assembler
>>>> directives not force section alignment?  Is there an alternative that
>>>> could be used that would result in the proper alignment?  Would ".word"
>>>> work?
>>>>
>>>> If not, then I would say patch only power with your balign thing.
>>>> 8-byte
>>>> alignment for 64-bit kernel, 4-byte alignment for 32-bit kernel
>>>>
>>>
>>> I think the proper fix is either:
>>>
>>> A) Modify scripts/module-common.lds to force __jump_table alignment for
>>> all architectures.
>>>
>>> B) Add arch/powerpc/kernel/module.lds to force __jump_table alignment
>>> for powerpc only.
>>>
>>> David.
>>>
>>>
>>
>> Ok, I can try adding it to the linger script.
>>
>> FWIW, here is my before and after with the .balign thing for the nfsd.ko
>> module on powperc (using a cross-compiler):
>>
>> before:
>>
>>   [31] __jump_table      PROGBITS        0000000000000000 03ee3e 0000f0
>> 00  WA  0   0  1
>>
>> after:
>>
>>  [31] __jump_table      PROGBITS        0000000000000000 03ee40 0000f0
>> 00  WA  0   0  4
>>
>
> Try the (lightly tested) attached.
>
> If it works and Steven likes it, perhaps someone can merge it.
>
> David.
>
>
>

So before your module.lds script:

# powerpc64-linux-readelf -eW fs/nfsd/nfsd.o | grep jump 

   [31] __jump_table      PROGBITS        0000000000000000 03edfe 0000f0 
00  WA  0   0  1
 

# powerpc64-linux-readelf -eW fs/nfsd/nfsd.ko | grep jump 

   [32] __jump_table      PROGBITS        0000000000000000 044046 0000f0 
00  WA  0   0  1

With your patch:
 
 
 

# powerpc64-linux-readelf -eW fs/nfsd/nfsd.o | grep jump 

   [31] __jump_table      PROGBITS        0000000000000000 03edfe 0000f0 
00  WA  0   0  1
 

# powerpc64-linux-readelf -eW fs/nfsd/nfsd.ko | grep jump 

   [18] __jump_table      PROGBITS        0000000000000000 03e358 0000f0 
00  WA  0   0  8


I also checked all the other .ko files and they were properly aligned. 
So I think this should hopefully work, and I like that its not a 
per-arch fix.

Sachin, sorry to bother you again, but I'm hoping you can try David's 
latest patch to scripts/module-common.lds, just to test in your setup.

Thanks,

-Jason

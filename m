Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Feb 2017 20:35:11 +0100 (CET)
Received: from prod-mail-xrelay08.akamai.com ([96.6.114.112]:25686 "EHLO
        prod-mail-xrelay08.akamai.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993868AbdB1TfBCVfFr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 28 Feb 2017 20:35:01 +0100
Received: from prod-mail-xrelay08.akamai.com (localhost.localdomain [127.0.0.1])
        by postfix.imss70 (Postfix) with ESMTP id AE4DC20000D;
        Tue, 28 Feb 2017 19:34:54 +0000 (GMT)
Received: from prod-mail-relay08.akamai.com (prod-mail-relay08.akamai.com [172.27.22.71])
        by prod-mail-xrelay08.akamai.com (Postfix) with ESMTP id A164F20001C;
        Tue, 28 Feb 2017 19:34:54 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; s=a1;
        t=1488310494; bh=tnj5PBxusCS2+m72yZkylat3mT3RlIRqh6y/CK4dt2Y=;
        l=3324; h=To:References:Cc:From:Date:In-Reply-To:From;
        b=ujGtV0f5YvrUo8qrptZZy6QeZLlU4mBdilTAtflg8iugn3CvHYGniVVBZw2vlIgL6
         Ma7x0gU20+KyJZKRKHuXmGzHG3+IpImLuFEazTDz34KkPGixEhndG/zxdY8w7Gwcta
         fn1ey8dsff3kpns5pe8nkjuc/I73jVCd3LlBQ6A0=
Received: from [0.0.0.0] (prod-ssh-gw01.bos01.corp.akamai.com [172.27.119.138])
        by prod-mail-relay08.akamai.com (Postfix) with ESMTP id 9874C98098;
        Tue, 28 Feb 2017 19:34:53 +0000 (GMT)
Subject: Re: [PATCH] jump_label: align jump_entry table to at least 4-bytes
To:     David Daney <ddaney@caviumnetworks.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sachin Sant <sachinp@linux.vnet.ibm.com>
References: <1488221364-13905-1-git-send-email-jbaron@akamai.com>
 <f7532548-7007-1a32-f669-4520792805b3@caviumnetworks.com>
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
Message-ID: <542488db-5c59-afa5-6d1d-a437c87bc613@akamai.com>
Date:   Tue, 28 Feb 2017 14:34:52 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <d10e986c-7f6a-3935-88e2-ba39708f79ad@caviumnetworks.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-Path: <jbaron@akamai.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56931
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



On 02/28/2017 02:22 PM, David Daney wrote:
> On 02/28/2017 11:05 AM, David Daney wrote:
>> On 02/28/2017 10:39 AM, Jason Baron wrote:
>>>
> [...]
>>>> I suspect that the alignment of the __jump_table section in the .ko
>>>> files is not correct, and you are seeing some sort of problem due to
>>>> that.
>>>>
>>>>
>>>
>>> Hi,
>>>
>>> Yes, if you look at the trace that Sachin sent the module being loaded
>>> that does the WARN_ON() is nfsd.ko.
>>>
>>> That module from Sachin's trace has:
>>>
>>>   [31] __jump_table      PROGBITS        0000000000000000 03fd77 0000c0
>>> 18 WAM  0   0  1
>>
>> The problem is then the section alignment (last column) for power.
>>
>> On mips with no patches applied, we get:
>>
>>   [17] __jump_table      PROGBITS        0000000000000000 00d2c0 000048
>> 00  WA  0   0  8
>>
>> Look, proper alignment!
>>
>> The question I have is why do the power ".llong" and ".long" assembler
>> directives not force section alignment?  Is there an alternative that
>> could be used that would result in the proper alignment?  Would ".word"
>> work?
>>
>> If not, then I would say patch only power with your balign thing. 8-byte
>> alignment for 64-bit kernel, 4-byte alignment for 32-bit kernel
>>
> 
> I think the proper fix is either:
> 
> A) Modify scripts/module-common.lds to force __jump_table alignment for
> all architectures.
> 
> B) Add arch/powerpc/kernel/module.lds to force __jump_table alignment
> for powerpc only.
> 
> David.
> 
>

Ok, I can try adding it to the linger script.

FWIW, here is my before and after with the .balign thing for the nfsd.ko
module on powperc (using a cross-compiler):

before:

  [31] __jump_table      PROGBITS        0000000000000000 03ee3e 0000f0
00  WA  0   0  1

after:

 [31] __jump_table      PROGBITS        0000000000000000 03ee40 0000f0
00  WA  0   0  4

Thanks,

-Jason


> 
>>
>>>
>>> So its not the size but rather the start offset '03fd77', that is the
>>> problem here. That is what the WARN_ON triggers on, that the start of
>>> the table is not 4-byte aligned.
>>>
>>> Using a ppc cross-compiler and the ENTSIZE patch that line does not
>>> change, however if I use the initial patch posted in this thread, the
>>> start does align to 4-bytes and thus the warning goes away, as Sachin
>>> verified. In fact, without the patch I found several modules that don't
>>> start at the proper alignment, however with the patch that started this
>>> thread they were all properly aligned.
>>>
>>> In terms of the '.balign' causing holes, we originally added the
>>> '_ASM_ALIGN' to x86 for precisely this reason. See commit:
>>> ef64789 jump label: Add _ASM_ALIGN for x86 and x86_64 and discussion.
>>>
>>> In addition, we have a lot of runtime with the .balign in the tree and
>>> I'm not aware of any holes in the table. I think the code would blow up
>>> pretty badly if there were.
>>>
>>> A number of arches were already using the '.balign', and the patch I
>>> proposed simply added it to remaining ones, now that we added a
>>> WARN_ON() to catch this condition.
>>>
>>> Thanks,
>>>
>>> -Jason
>>>
>>>
>>>
>>>
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

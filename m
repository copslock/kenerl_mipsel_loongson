Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 May 2016 17:57:22 +0200 (CEST)
Received: from mail-pa0-f52.google.com ([209.85.220.52]:33538 "EHLO
        mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006153AbcELP5UedHf0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 12 May 2016 17:57:20 +0200
Received: by mail-pa0-f52.google.com with SMTP id xk12so31001168pac.0;
        Thu, 12 May 2016 08:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-transfer-encoding;
        bh=ZFUqo4ovoG81w4/aFyKJeJyHttR/MiANSZZM6tmnDME=;
        b=F9Xi2tKwh81O7oqZajwVbEpEhQBI/jeAeaQ4RWBepUe/3f8oqt9hHzN6zH0C38hHbc
         JbRO0wz2VvWvchLU+LXv/9jOudu7VxbcNyzXYgVNMs2l8PeF/OtZ6XSVYiN6tw0+UmBE
         zqfzyvf2A+XXng1fax1s+29S1Fai7PeD4wF7Mz5w0YwDg+ymRe7oJbsyV5nEmt1mMNot
         Z0ecEU0JOI2YBfBnq16PHoL/QLaDyUnrMIODjY1OT/xSJ3WbJLVLrRy7/D3m4kWjZrLB
         24TePqrSruY7Q17IY+FVXT+qOFqgtECR4GSIDqc+WVWXiLOUz1usa3kOu+tazZPGAc+n
         7dbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-transfer-encoding;
        bh=ZFUqo4ovoG81w4/aFyKJeJyHttR/MiANSZZM6tmnDME=;
        b=Q/l+2i3rIJLv8giXx1Fe8xhtf9MqnTicTQ1s7hIYb7TFW/DNfLGSZq3zliPw+8krEJ
         91UfrWL8YobCnvUM8CcglXNv6U35R9jPFM1aTv1kUe9lHhNSSGDB28Bs8lIswStiVlNU
         WUUoHvUJP3Pf/ylRlH0US8lOvnOGVhibYQrztfczuTqm2ifphkGcP6VH/m4aZKBdfpkW
         fYSfsrkKErOahGozwJltmM5sURuzMrVlYsNIyvBWl7d6BVNKgUiTqOzG3F6VaPfxclWh
         wogC1Er/EoqAZJko9dMiQmQMGZLUXTbhia+SWEz73wZ+bdh7uTCujEOedOMaZb9UpBvp
         6nMQ==
X-Gm-Message-State: AOPr4FVqcR08+6pSpM7Hw1u43zO7sYb1d8BfvOO7113XGUHChLOKESlDlsyYmexm5jHOUA==
X-Received: by 10.66.253.68 with SMTP id zy4mr14956969pac.81.1463068634393;
        Thu, 12 May 2016 08:57:14 -0700 (PDT)
Received: from dl.caveonetworks.com ([64.2.3.194])
        by smtp.googlemail.com with ESMTPSA id n190sm20874513pfn.23.2016.05.12.08.57.12
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 12 May 2016 08:57:13 -0700 (PDT)
Message-ID: <5734A7D8.9030407@gmail.com>
Date:   Thu, 12 May 2016 08:57:12 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Ralf Baechle <ralf@linux-mips.org>,
        "Hill, Steven" <Steven.Hill@caviumnetworks.com>
CC:     Florian Weimer <fweimer@redhat.com>, linux-mips@linux-mips.org
Subject: Re: Endless loop on execution attempt on non-executable page
References: <57345F0D.9070503@redhat.com> <20160512125342.GS16402@linux-mips.org> <9af052f6-b50c-7ba5-ebbb-0bdff0c58dd9@redhat.com> <20160512142306.GT16402@linux-mips.org>
In-Reply-To: <20160512142306.GT16402@linux-mips.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53412
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

On 05/12/2016 07:23 AM, Ralf Baechle wrote:
> On Thu, May 12, 2016 at 03:07:51PM +0200, Florian Weimer wrote:
>
>> On 05/12/2016 02:53 PM, Ralf Baechle wrote:
>>> On Thu, May 12, 2016 at 12:46:37PM +0200, Florian Weimer wrote:
>>>
>>>> The GCC compile farm has a big-endian 64-bit MIPS box.  The kernel is:
>>>>
>>>> Linux erpro8-fsf1 3.14.10-er8mod-00013-ge0fe977 #1 SMP PREEMPT Wed Jan
>>>> 14 12:33:22 PST 2015 mips64 GNU/Linux
>>>>
>>>> Which is a vendor kernel for the EdgeRouter Pro-8.
>>>>
>>>> /proc/cpuinfo reports:
>>>>
>>>> system type             : UBNT_E200 (CN6120p1.1-1000-NSP)
>>>> machine                 : Unknown
>>>> processor               : 0
>>>> cpu model               : Cavium Octeon II V0.1
>>>>
>>>> While testing W^X (execmod, DEP, NX) stack enforcement, I noticed that once
>>>> I try to execute code off a non-executable page, I do not get a signal, but
>>>> the code appears to enter an infinite loop.  The generated function starts
>>>> with a jump instruction to return to the caller, but instead, the program
>>>> counter does not seem to change at all.
>>>>
>>>> “si” in GDB also hangs (but can be interrupted with ^C).
>>>>
>>>> My test code is here:
>>>>
>>>>    https://pagure.io/execmod-tests
>>>>
>>>> Is this a kernel bug or an issue with the silicon?
>>>
>>> I see the test case uses mprotect to add PROT_EXEC after writing the code
>>> to memory.  I don't think mprotect however gives any guarantee that this
>>> will make the I-cache coherent with the D-cache, that is that the CPU will
>>> actually fetch and execute the instruction that were just written to memory.
>>> For that you have to do something architecture specific such as dancing
>>> around a fire waving a dead chicken.  Or on MIPS call cacheflush(), see
>>> the man page for details.
>>
>> There is a fork between the write and the execute.  It is somewhat unlikely
>> that that's not a barrier, but it did happen on POWER.
>>
>> However, I can successfully execute code without the barrier, so this whole
>> thing goes in the wrong direction. :)
>>
>> I have added it, just to be on the safe side.
>>
>>> For portability sake to some broken processors you should also ensure
>>> that a 32 byte cache line is entirely filled with valid instructions by
>>> padding the two test instructions with another six no-op (opcode 0).
>>
>> Added as well.
>>
>>> The test case as it is guarantees this implicitly by using a freshly
>>> allocated page but I thought I should mention it.
>>
>> There are some tests that don't (the stack variable might be clobbered, for
>> example).
>>
>> Anyway, neither change fixed things for me.  Given the peculiar “si”
>> behavior in GDB, that's not entirely unexpected ...
>
> Thanks for fixing and testing this obvious things.  Now let's look one
> or two levels deeper ...
>

This is something that would be easy to diagnose on the OCTEON simulator...

Before spending time doing that, has anyone tried this on current 
kernels rather than the 3.14 indicated above?

It might also be interesting to know if it still happens when booting on 
only a single CPU rather than what I assume is the default on this 
platform of all available CPUs

David Daney

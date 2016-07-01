Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Jul 2016 02:49:49 +0200 (CEST)
Received: from mail-pf0-f196.google.com ([209.85.192.196]:34198 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993272AbcGAAtjg7qQt (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 1 Jul 2016 02:49:39 +0200
Received: by mail-pf0-f196.google.com with SMTP id 66so8620742pfy.1;
        Thu, 30 Jun 2016 17:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-transfer-encoding;
        bh=lhRLBmaSbA+ej4FaEX2rgVOZqIloIrqo6EKKJ3hrpOc=;
        b=Y5oRvBMk6vs061SgokUy/5ycGR0lTBU48nhGDQqiPhfpw6mrcohmgKMhELt100ipR4
         g8B4M5aWty7rJE9/9luYbIne4WnIBWtMXD2KoUJb5mvxyzGeTcKG8W5ey44yIORvoYDV
         bwrGKhkeILYKUPyy1tzuN1ykUvxt3kYwLo6lttKtXqXTBt3pVZvHvXqNu96bTeZrnx+d
         fz4QOLgQGjCpE1erHMNUkkv2QE/IAqpe9kqscInYyqzkRY721ttQiwI+LSA4t8+9+wF2
         MvP4kcC1tV5HnD8ghN1oWcAkG3IYHC9/6vSunSmMBrgKAKj6Z3eHDNGi2ZP3+eYms8oR
         5xFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-transfer-encoding;
        bh=lhRLBmaSbA+ej4FaEX2rgVOZqIloIrqo6EKKJ3hrpOc=;
        b=hyRr8kACy23oa06X5+20y50GDtOWVtxZwwK7Yg0NYi+lfd0O/Jf7k6VWYqq7ckPHhZ
         1kAAm5gpdQXi409olKEPSLvC6oAkMBlhyGub7H0WZ/utGUz/EBI1RZvbv/RR4aGPWIe3
         q6xqHzPdgmK6MWH7goCRJdwPKoYUcCGESqCnXcHiYuecK4LC8hoE8nDM3P2KMoZZaten
         seqirXTxfelAIT6ppubCdUVpXkgkI/RXKS3UgA6pxp2UaMsDjp8xa+yeOHVuAYLJM9iK
         bkbe+0cyMG3xwCwLO7leUT++26H4awtWqUa9SaruJjQVTxHprHM5OYUdZQx5Sc+kOwgp
         tKAQ==
X-Gm-Message-State: ALyK8tLCs9lg7aI/1VAxpk5+wW728aCYTJgh/Dxf3HE0g3ULVNL6lbwMSj1u/RQplczM5g==
X-Received: by 10.98.35.27 with SMTP id j27mr26647734pfj.10.1467334172555;
        Thu, 30 Jun 2016 17:49:32 -0700 (PDT)
Received: from dl.caveonetworks.com ([50.233.148.158])
        by smtp.googlemail.com with ESMTPSA id y10sm694619pas.24.2016.06.30.17.49.30
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Thu, 30 Jun 2016 17:49:31 -0700 (PDT)
Message-ID: <5775BE1A.8050909@gmail.com>
Date:   Thu, 30 Jun 2016 17:49:30 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Faraz Shahbazker <faraz.shahbazker@imgtec.com>
CC:     Paul Burton <paul.burton@imgtec.com>,
        Matthew Fortune <Matthew.Fortune@imgtec.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        Raghu Gandham <Raghu.Gandham@imgtec.com>,
        Maciej Rozycki <Maciej.Rozycki@imgtec.com>
Subject: Re: [RFC PATCH v3 2/2] MIPS: non-exec stack & heap when non-exec
 PT_GNU_STACK is present
References: <20160629143830.526-1-paul.burton@imgtec.com> <20160629143830.526-3-paul.burton@imgtec.com> <6D39441BF12EF246A7ABCE6654B023537E465A74@HHMAIL01.hh.imgtec.org> <fb77e2f2-801d-8dd5-6121-73909ebbd227@imgtec.com> <6D39441BF12EF246A7ABCE6654B023537E465F8E@HHMAIL01.hh.imgtec.org> <96de1cb3-7bb7-769d-e032-5bd10a3d1633@imgtec.com> <57755990.8010807@imgtec.com>
In-Reply-To: <57755990.8010807@imgtec.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54195
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

What ever happens, somebody needs to test kernels with this patch 
against old distros (Debian for example) to make sure you don't break them.

Some of the initial non-exec-stack patch sets intentionally broke 
compatibility with existing binaries, and that is not acceptable.

David Daney


On 06/30/2016 10:40 AM, Faraz Shahbazker wrote:
> Hi Paul,
>
> The user-mode patch hasn't gone upstream either, so it is open to modification. Assuming the kernel currently has no other means of publishing RIXI support, or there is no existing software relying on such publication, then a RIXI bit in HWCAP seems appropriate.
>
> @Matthew/@Maciej: If this is a priority, could we swap the libc-abi numbers for IFUNC(4) and non-exec stack(5) to push this change through before IFUNC? I think that is the only reason we've held the user-mode patches for glibc and gcc. A binutils patch with abiversion=5 was committed, so it will need fixing, but its only a one-liner.
>
> Regards,
> Faraz
>
>
> On 06/30/2016 09:25 AM, Paul Burton wrote:
>> On 30/06/16 13:04, Matthew Fortune wrote:
>>>>> There will be some extra work on top of this to inform user-mode that
>>>>> no-exec-stack support is actually safe. I'm a bit fuzzy on the exact
>>>>> details though as I have not been directly involved for a while.
>>>>>
>>>>> https://www.sourceware.org/ml/libc-alpha/2016-01/msg00719.html
>>>>>
>>>>> Adding Faraz who worked on the user-mode side and Maciej who has been
>>>>> reviewing.
>>>>
>>>> Hi Matthew,
>>>>
>>>> Interesting. That glibc patch seems to imply that the kernel already
>>>> supports this, which isn't true. It makes use of a
>>>> "AV_FLAGS_MIPS_GNU_STACK" constant & says that's taken from Linux, but
>>>> it doesn't exist. Are you using an experimental patch for the kernel
>>>> side (perhaps Leonid's?). I'm not sure why you'd use AT_FLAGS for this,
>>>> which Linux currently unconditionally sets to 0 for all architectures.
>>>> Would a HWCAP bit for RIXI perhaps be more suitable?
>>>
>>> We are/were under the assumption that a pre-existing kernel will honor
>>> the PT_GNU_STACK marker overriding the arch specific read-implies-exec
>>> logic:
>>>
>>> http://lxr.free-electrons.com/source/fs/binfmt_elf.c?v=3.2#L689
>>> http://lxr.free-electrons.com/source/fs/exec.c?v=3.2#L703
>>>
>>> This means that if we produce tools which have PT_GNU_STACK with executable
>>> stack disabled then older kernels will crash as they will obey it and
>>> the FPU emulator will break.
>>>
>>> Is this incorrect? I.e. does today's MIPS kernel do absolutely nothing
>>> when PT_GNU_STACK is seen?
>>
>> Hi Matthew,
>>
>> No I believe what you've described there is correct, existing kernels on systems with RIXI will make the stack non-executable for binaries with a non-executable PT_GNU_STACK, and that will cause problems for the kernels delay slot emulation code (used by the FPU emulator & pre-MIPSr6 emulation on MIPSr6 systems).
>>
>>> The "AV_FLAGS_MIPS_GNU_STACK" is a proposal of how to handle the
>>> transition from a kernel that does as I describe above to one that safely
>>> supports no-exec-stack. I don't know if this has to be an AT_FLAGS or
>>> whether a HWCAP would do. I think we perhaps latched on to the idea of
>>> AT_FLAGS as we have used that as part of the nan2008 work but we can
>>> work through that detail later. The user-mode work is still very much in
>>> review. There is no kernel with this feature yet.
>>
>> This part is probably something we need to discuss - though I suppose it could if needed go in after these kernel changes, just not before them. Having gone digging I see Maciej used AT_FLAGS in some NaN support that hasn't yet been submitted for merging. There was this RFC:
>>
>>      https://patchwork.linux-mips.org/patch/11490/
>>      https://patchwork.linux-mips.org/patch/11491/
>>      https://patchwork.linux-mips.org/patch/11492/
>>      https://patchwork.linux-mips.org/patch/11493/
>>
>> ...but no non-RFC submission so the code isn't yet in the kernel. Right now AT_FLAGS is unconditionally 0 in Linux, for all architectures:
>>
>>
>> http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/fs/binfmt_elf.c?id=v4.7-rc5#n241
>>
>> Presuming it's still the plan to get this NaN code into mainline the use of AT_FLAGS seems less odd to me. I still think a HWCAP bit would be a sane alternative though as this patchset can be seen as completing kernel support for RIXI, so indicating that a system properly supports RIXI makes sense (& implies that the stack may be non-executable).
>>
>>> Faraz: Did I explain that correctly?
>>
>> I'd love to get your input on this too Faraz.
>>
>> Thanks,
>>      Paul
>
>
>

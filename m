Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Oct 2014 01:38:27 +0200 (CEST)
Received: from mail-pd0-f174.google.com ([209.85.192.174]:46966 "EHLO
        mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010654AbaJFXiZVDAks (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 7 Oct 2014 01:38:25 +0200
Received: by mail-pd0-f174.google.com with SMTP id y13so3994161pdi.5
        for <linux-mips@linux-mips.org>; Mon, 06 Oct 2014 16:38:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=FaCanRrIkcfhH9uXoxmrMc6iWdpBFVMXFvEN1iccNIg=;
        b=dhNNe2Ary2xHhxPVmzZkUh2IwhK2jrAc1D83p7MmRdg+YgtyYR0ZSCRvUVGu8cf3+5
         ukqmWAfkOTHF4zyrDKHBNXiw4rJ8Kbuv0kV4C/srk4Hy8eknCAkwtC8/qg9R3QYTC1Fs
         JBT8JJNiRDbX63MGS+Bag66lttWA/5UnUtFktg0yoDrIx3mcZrEmjPAe4MGCMa4Erus8
         Crj1TyrOIKR/6GHXjhewWWjlBjqPmbhhL/HDr9DTP7KjKiYO5F+1bUe3Y/ICNqaoqFD4
         zv8IesYd6FWFLnvgSJEeAdAQW3u9LXDNFz6zo1I2+yGz6+/MbV6cKTud+FV3RwaY+QT8
         pl1w==
X-Gm-Message-State: ALoCoQl1B6VKA417WwTqHciQTMnaYfq+2DYOOq+P1ZBuXBo4r3I99R8ZoP3l5QZh5JESNkQMZuQh
X-Received: by 10.66.220.194 with SMTP id py2mr23842pac.81.1412638698835;
        Mon, 06 Oct 2014 16:38:18 -0700 (PDT)
Received: from amaluto.corp.amacapital.net (50-76-60-73-ip-static.hfc.comcastbusiness.net. [50.76.60.73])
        by mx.google.com with ESMTPSA id nu1sm14290388pbc.19.2014.10.06.16.38.16
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Oct 2014 16:38:17 -0700 (PDT)
Message-ID: <543327E7.4020608@amacapital.net>
Date:   Mon, 06 Oct 2014 16:38:15 -0700
From:   Andy Lutomirski <luto@amacapital.net>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.1.1
MIME-Version: 1.0
To:     Rich Felker <dalias@libc.org>,
        David Daney <ddaney@caviumnetworks.com>
CC:     David Daney <ddaney.cavm@gmail.com>, libc-alpha@sourceware.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        David Daney <david.daney@cavium.com>
Subject: Re: [PATCH resend] MIPS: Allow FPU emulator to use non-stack area.
References: <1412627010-4311-1-git-send-email-ddaney.cavm@gmail.com> <20141006205459.GZ23797@brightrain.aerifal.cx> <5433071B.4050606@caviumnetworks.com> <20141006213101.GA23797@brightrain.aerifal.cx> <54330D79.80102@caviumnetworks.com> <20141006215813.GB23797@brightrain.aerifal.cx>
In-Reply-To: <20141006215813.GB23797@brightrain.aerifal.cx>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-Path: <luto@amacapital.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42976
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: luto@amacapital.net
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

On 10/06/2014 02:58 PM, Rich Felker wrote:
> On Mon, Oct 06, 2014 at 02:45:29PM -0700, David Daney wrote:
>> On 10/06/2014 02:31 PM, Rich Felker wrote:
>>> On Mon, Oct 06, 2014 at 02:18:19PM -0700, David Daney wrote:
>>>>> Userspace should play no part in this; requiring userspace to help
>>>>> make special accomodations for fpu emulation largely defeats the
>>>>> purpose of fpu emulation.
>>>>
>>>> That is certainly one way of looking at it.  Really it is opinion,
>>>> rather than fact though.
>>>
>>> It's an opinion, yes, but it has substantial reason behind it.
>>>
>>>> GLibc is full of code (see ld.so) that in earlier incantations of
>>>> Unix/Linux was in kernel space, and was moved to userspace.  Given
>>>> that there is a partitioning of code between kernel space and
>>>> userspace, I think it not totally unreasonable to consider doing
>>>> some of this in userspace.
>>>>
>>>> Even on systems with hardware FPU, the architecture specification
>>>> allows for/requires emulation of certain cases (denormals, etc.)  So
>>>> it is already a requirement that userspace cooperate by always
>>>> having free space below $SP for use by the kernel.  So the current
>>>> situation is that userspace is providing services for the kernel FPU
>>>> emulator.
>>>>
>>>> My suggestion is to change the nature of the way these services are
>>>> provided by the userspace program.
>>>
>>> But this isn't setup by the userspace program. It's setup by the
>>> kernel on program entry. Despite that, though, I think it's an
>>> unnecessary (and undocumented!) constraint; the fact that it requires
>>> the stack to be executable makes it even more harmful and
>>> inappropriate.
>>>
>>
>> The management of the stack is absolutely done by userspace code.
>> Any time you do pthread_create(), userspace code does mmap() to
>> allocate the stack area, it then sets permissions on the area, and
>> then it passes the address of the area to clone().
> 
> This is hardly management.
> 
>> Furthermore the
>> userspace code has to be very careful in its use of the $sp
>> register, so that it doesn't store data in places that will be
>> used/clobbered by the kernel.
> 
> This is not "being careful". The stack pointer can never become
> invalid unless you do wacky things in asm or invoke UB.

I disagree a bit here.  There are runtimes that aren't libc or even C at
all.  See, for example, Go.  (Ugh!)

What happens if a signal happens while executing from this magic
trampoline?  Allocation of another one?  Crash on return from the outer
trampoline invocation?

Also, if this ends up being solved with a hack of this type, please do
it right: have *two* aliases of the trampoline, one writable, and one
executable (unless the MIPS kernel can bypass write-protection).


> 
>> All of this is under the control of the userspace program and done
>> with userspace code.
> 
> For the most part it just happens by default. There is no particular
> intentionality needed, and certainly no hideous MIPS-specific hacks
> needed.
> 
>> I appreciate the fact that libc authors might prefer *not* to write
>> more code, but they could, especially if they wanted to add the
>> feature of non-executable stacks to their library implementation.
> 
> So your position is that:
> 
> 1. A non-exec-stack system can only run new code produced to do extra
>    stuff in userspace.
> 
> 2. The startup code needs to do special work in userspace on MIPS to
>    setup an executable area for fpu emulation.
> 
> 3. Every call to clone/CLONE_VM needs to be accompanied by a call to
>    mmap and this new syscall to set the address, and every call to
>    SYS_exit needs to be accompanies by a call to munmap for the
>    corresponding mapping.
> 
> This is a huge ill-designed mess.

Amen.

Can the kernel not just emulate the instructions directly?  Can it
single-step through them in place?

FWIW, I have considered playing trampoline games like this on x86.  It's
a giant bloody mess, and it will almost certainly never happen, even
though the performance win is dramatic.  No, you don't want to know why. [1]

[1] If you actually want to know, imagine returning from a page fault
with sysret.

--Andy

Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 Aug 2015 23:02:17 +0200 (CEST)
Received: from mail-io0-f169.google.com ([209.85.223.169]:34910 "EHLO
        mail-io0-f169.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007260AbbHYVCPbVBGQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 25 Aug 2015 23:02:15 +0200
Received: by iodt126 with SMTP id t126so203307874iod.2
        for <linux-mips@linux-mips.org>; Tue, 25 Aug 2015 14:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=veayQraMXt54jPd8Jsa6S7E9KDt8CyuPJdPTzY9wAAM=;
        b=oKeMnIvYDoBb4CLF4Df+ZQhOwYngzAgUdQTiB1wxf2khsnDV5UPgQ6PBY3znC7ahtH
         15PsGHguz6quD3TbSKgx70ZSFcgpgWaESKgeys3h0nB2wftusGIWdFJiQx88Eyu/VGIJ
         YxkF/t43P9rD+WK7kGehQIrKQ98Fmxt7l/EZ3BZNFGhJx8uZOQybY/SaRMHaruP0DAeN
         aHh2QH0s2vpKedNrOerZ7UZnNqPir87IXyMUArRrxb7hECgEXzZdNAIhOEtGODo0dyvi
         T7uuXhWj73AeERhKpz+NSNr5OEudr/wm6aNTv9TcqK3EdcxEuNl1/Mwo4txGBkdeKr2O
         uf1w==
X-Received: by 10.107.135.148 with SMTP id r20mr32152988ioi.41.1440536529433;
        Tue, 25 Aug 2015 14:02:09 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.194.ptr.us.xo.net. [64.2.3.194])
        by smtp.googlemail.com with ESMTPSA id j134sm16350204ioj.7.2015.08.25.14.02.08
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 25 Aug 2015 14:02:08 -0700 (PDT)
Message-ID: <55DCD7CF.400@gmail.com>
Date:   Tue, 25 Aug 2015 14:02:07 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Markos Chandras <Markos.Chandras@imgtec.com>
CC:     linux-mips@linux-mips.org
Subject: Re: [PATCH 2/2] MIPS: kernel: signal: Drop unused arguments for traditional
 signal handlers
References: <1440071122-24971-1-git-send-email-markos.chandras@imgtec.com> <1440071122-24971-3-git-send-email-markos.chandras@imgtec.com> <55D759CA.7060409@gmail.com> <55DACF45.9050209@imgtec.com>
In-Reply-To: <55DACF45.9050209@imgtec.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49015
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

On 08/24/2015 01:01 AM, Markos Chandras wrote:
> On 08/21/2015 06:03 PM, David Daney wrote:
>> On 08/20/2015 04:45 AM, Markos Chandras wrote:
>>> Traditional signal handlers (ie !SA_SIGINFO) only need only argument
>>> holding the signal number so we drop the additional arguments and fix
>>> the related comments. We also update the comments for the SA_SIGINFO
>>> case where the second argument is a pointer to a siginfo_t structure.
>>>
>>> Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
>>> ---
>>>    arch/mips/kernel/signal.c     | 6 +-----
>>>    arch/mips/kernel/signal32.c   | 6 +-----
>>>    arch/mips/kernel/signal_n32.c | 2 +-
>>>    3 files changed, 3 insertions(+), 11 deletions(-)
>>>
>>> diff --git a/arch/mips/kernel/signal.c b/arch/mips/kernel/signal.c
>>> index be3ac5f7cbbb..3a125331bf8b 100644
>>> --- a/arch/mips/kernel/signal.c
>>> +++ b/arch/mips/kernel/signal.c
>>> @@ -683,15 +683,11 @@ static int setup_frame(void *sig_return, struct
>>> ksignal *ksig,
>>>         * Arguments to signal handler:
>>>         *
>>>         *   a0 = signal number
>>> -     *   a1 = 0 (should be cause)
>>> -     *   a2 = pointer to struct sigcontext
>>>         *
>>>         * $25 and c0_epc point to the signal handler, $29 points to the
>>>         * struct sigframe.
>>>         */
>>>        regs->regs[ 4] = ksig->sig;
>>> -    regs->regs[ 5] = 0;
>>> -    regs->regs[ 6] = (unsigned long) &frame->sf_sc;
>>
>> This changes the kernel ABI.
>>
>> Have you tested this change against all userspace applications that use
>> signals to make sure it doesn't break anything?
>>
>> David Daney
>
> i am confident there is no userland application that uses inline asm to
> fetch additional arguments from (*sa_handler) when using !SA_SIGINFO

You don't need inline asm.  All you have to do is use a C cast on the 
function pointer.

I think your confidence is misplaced.  I have a program that this change 
will break.

You are changing the de facto kernel ABI in such a manner that it could 
break existing programs without a strong reason to do so.

Answer this:  Why is it important to you to change this?  The change log 
gives no justification other than we can, and it doesn't seem to break 
limited set of test cases.

If you are fixing some real bug, then OK.  But if you don't have a 
reason to do this, then: NAK.

David Daney


>

Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Sep 2015 19:04:42 +0200 (CEST)
Received: from mail-io0-f170.google.com ([209.85.223.170]:35737 "EHLO
        mail-io0-f170.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013698AbbIRREkDMp3J (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 18 Sep 2015 19:04:40 +0200
Received: by ioiz6 with SMTP id z6so62774852ioi.2;
        Fri, 18 Sep 2015 10:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=7dEXidYcuVkRkB/JN0k3krFUcLHRUrWBcfjdKRIs1VU=;
        b=kz8CCqYxwdLfqJlWH/2YxsnJgJtxhDwORFUzw3qLOpfGy/iSPfO+hFbPMkEQErAms5
         hD7OpR+EWCsASz+1hDSU5wIrEdMnYBoblRLGvn7j74vq+TBJBHSWbSdB7Fgh/zbL/c7c
         nYvQEsdYj3laZ7UyvKfRTmTsKAZD1PeLKrr8iDIFbNpB/Gf2EriGKKkuu/oanA1MbT2O
         mI5jn/fei4Qtv/39U4xX4gpO0MUlW1vki8hjTT3nJolZa8nQjSjA6WjhfMrDRaU4vOBI
         U7Zw1W0MH+YtdlQSXq7/JxQTux1c1PSSKD30O1thnyPIRKgeHeujJxdnU0uEcXfSViiJ
         qJTw==
X-Received: by 10.107.129.65 with SMTP id c62mr16801385iod.4.1442595873974;
        Fri, 18 Sep 2015 10:04:33 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.194.ptr.us.xo.net. [64.2.3.194])
        by smtp.googlemail.com with ESMTPSA id 21sm4064970ioo.16.2015.09.18.10.04.32
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 18 Sep 2015 10:04:32 -0700 (PDT)
Message-ID: <55FC441F.6080804@gmail.com>
Date:   Fri, 18 Sep 2015 10:04:31 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     "Maciej W. Rozycki" <macro@linux-mips.org>
CC:     Luis Machado <lgustavo@codesourcery.com>,
        gdb-patches@sourceware.org, linux-mips@linux-mips.org
Subject: Re: [PATCH] Expect SI_KERNEL si_code for a MIPS software breakpoint
 trap
References: <1442592647-3051-1-git-send-email-lgustavo@codesourcery.com> <alpine.LFD.2.20.1509181729100.10647@eddie.linux-mips.org>
In-Reply-To: <alpine.LFD.2.20.1509181729100.10647@eddie.linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49237
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

We have to be very careful changing the ABI here.

This is used by almost all userspace code to detect integer division by 
zero.  Many things like the libgcj runtime use this to generate runtime 
exceptions, we don't want to break them.

David Daney



On 09/18/2015 09:56 AM, Maciej W. Rozycki wrote:
> Hi Luis,
>
>> I tracked this down to the lack of a proper definition of what MIPS' kernel
>> returns in the si_code for a software breakpoint trap.
>>
>> Though i did not find documentation about this, tests showed that we should
>> check for SI_KERNEL, just like i386. I've cc-ed Maciej, just to be sure this
>> is indeed correct.
>
>   Hmm, the MIPS/Linux port does not set any particular code for SIGTRAP,
> all such signals will have the SI_KERNEL default, so you may well return
> TRUE unconditionally.
>
>   I'm not convinced however that it is safe to assume all SIGTRAPs come
> from breakpoints -- this signal is sent by the kernel for both BREAK and
> trap (multiple mnemonics, e.g. TEQ, TGEI, etc.) instructions which may
> have been placed throughout code for some reason, for example to serve as
> cheap assertion checks.
>
>   Is there a separate check made afterwards like `bpstat_explains_signal'
> to validate the source of the signal here?
>
>   Perhaps we should make it a part of the ABI and teach MIPS/Linux about
> the breakpoint encoding used by GDB, which is `BREAK 5' (aka BRK_SSTEPBP
> in kernel-speak, a misnomer I'm afraid), and make it set `si_code' to
> TRAP_BRKPT, as expected.  This won't fix history of course, but at least
> it will make debugging a little bit easier to handle in the future.
> Cc-ing `linux-mips' for further input.
>
>   I was wondering where these SIGTRAPs come from too BTW, thanks for
> investigating it.  And thanks for the heads-up!
>
>    Maciej
>
>

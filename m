Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 Jan 2015 00:51:21 +0100 (CET)
Received: from mail-ie0-f174.google.com ([209.85.223.174]:60799 "EHLO
        mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011579AbbA2XvTKGbRf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 30 Jan 2015 00:51:19 +0100
Received: by mail-ie0-f174.google.com with SMTP id vy18so302193iec.5
        for <linux-mips@linux-mips.org>; Thu, 29 Jan 2015 15:51:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=PLTHfaXUk+6zJpKKLGyUspZVHdwHi1bjOvjy4a+Bo6I=;
        b=GVB/iPfmcNeiza2uH32nMXTtWi+tNtLqBwGiN0zCyRveKJCR8iBI1/jCbuHKC9lBCL
         dwsWKfK9Uzb4986bH/YyWO7PMbQYYhSOad2iyiRBUop5c5e1ubzkCWEoKI4XwnQ7Iee1
         txQNof9EdhJtukhswbyo8vbiWHT6NoopE7Celkj7zu0RoA1kuldH9k2u9U5f1o/A9jrz
         /a2nL1QVWlVmKgCsiNb59dpwsZl/v9O18/KtymAE/nTQxJ20pNDWZA5SL9K1ii/zjWk6
         8VT8CRd6yYRGAWpJKwHq6pfcXP5Nk6OkovfW6JuVn2pNtwE6On9OT4yv3W6f5P05W4iC
         aOkQ==
X-Received: by 10.43.126.67 with SMTP id gv3mr3508160icc.31.1422575470804;
        Thu, 29 Jan 2015 15:51:10 -0800 (PST)
Received: from dl.caveonetworks.com (64.2.3.194.ptr.us.xo.net. [64.2.3.194])
        by mx.google.com with ESMTPSA id n4sm256022igr.3.2015.01.29.15.51.10
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 29 Jan 2015 15:51:10 -0800 (PST)
Message-ID: <54CAC76D.9020900@gmail.com>
Date:   Thu, 29 Jan 2015 15:51:09 -0800
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Bruce Korb <bruce.korb@gmail.com>
CC:     linux-mips <linux-mips@linux-mips.org>
Subject: Re: Hardware breakpoints on MIPS
References: <CAKRnqN+Js_zDn==T0+-EGzyTSW4P-dpvB7jKsLmFJEbKhxifJw@mail.gmail.com> <54CABBC3.6000006@gmail.com> <CAKRnqNKBCOF0toKNDc8=Y-geA18bzM_7_Mc5HN6jgb40H5OfaA@mail.gmail.com>
In-Reply-To: <CAKRnqNKBCOF0toKNDc8=Y-geA18bzM_7_Mc5HN6jgb40H5OfaA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45555
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

On 01/29/2015 03:43 PM, Bruce Korb wrote:
> Thank you!
>
> On Thu, Jan 29, 2015 at 3:01 PM, David Daney <ddaney.cavm@gmail.com> wrote:
>>> Anyway, I need to set a hardware breakpoint on a Mips CPU on a "Cavium"
>>> platform
>>> in a kernel module.
>>
>> This would appear to be for the most part, completely independent of GDB,
>
> I had guessed as much, but did not have a better guess, either.
>
>> Since many years ago, WatchLo and WatchHi have been under the control of the
>> Linux kernel.  If you set these registers and a Watch Exception is
>> triggered, it will cause the registers to be cleared and the exception will
>> be ignored, unless they were configured via ptrace(2) for userspace
>> addresses.
>
> Can a hacked ptrace set it up to panic instead?
> All I need is a stack trace once this one single spot in memory gets written.
>

Look at do_watch() in traps.c, you would have to doctor that function up 
to generate the stacktrace.

>> For debugging kernel space with watchpoint registers on OCTEON it is
>> probably best to use the facilities in the EJTAG unit.
>
> Which, I'll hazard a guess, requires physical access.
> I'll have to go begging and pleading for special access to the Hardware Lab.
> Please don't ask me why we software types are kept out.
> I've not gotten a straight answer, so I could only answer with speculation.
>
>
> *sigh*.  Thank you.
>
>

Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Oct 2014 22:03:41 +0200 (CEST)
Received: from mail-ig0-f182.google.com ([209.85.213.182]:62279 "EHLO
        mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010752AbaJGUDk32H43 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 7 Oct 2014 22:03:40 +0200
Received: by mail-ig0-f182.google.com with SMTP id hn18so5624487igb.9
        for <linux-mips@linux-mips.org>; Tue, 07 Oct 2014 13:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=YHTwlKV2cx8uBOaEn07Wo5JRVEAZ/XJzC/1zjfJfT4Y=;
        b=SpARIQj7cLOIDChlZUi9gQw5ecrsMdTb5FO1h4CrK+2o6zn0zHZA28eb1VLjtNLBs7
         XSFY/9I5HYYyt82s70Yw6s8otUk+OOOoS7WV8YAnrKr1sIqWQx8MtfamsCuOAkWr9XtM
         /siAWxll7ThHRpfYTNQ/9GhQiD7YB4rluaXtw4Jh75wtvYLu/QpY7J91HEZV0zVuQBQ6
         rnSawIWGzis+4z8HkVTLrui+E6xUbbPtnK0FDrHvsBgBhIdM5AnqzwHBfuYn3rpT4bW5
         WlNklOYPrC8KMYtqjc4dfHmfhv+jA3cVGJANyfffVD7FXmSstRe+uGntaLqgMiPqzTUf
         TrTA==
X-Received: by 10.50.56.42 with SMTP id x10mr41042703igp.1.1412712214425;
        Tue, 07 Oct 2014 13:03:34 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id m7sm3169289igj.18.2014.10.07.13.03.32
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 07 Oct 2014 13:03:33 -0700 (PDT)
Message-ID: <54344714.1000600@gmail.com>
Date:   Tue, 07 Oct 2014 13:03:32 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Andy Lutomirski <luto@amacapital.net>
CC:     Rich Felker <dalias@libc.org>,
        Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        Matthew Fortune <Matthew.Fortune@imgtec.com>,
        David Daney <david.s.daney@gmail.com>,
        David Daney <ddaney.cavm@gmail.com>,
        "libc-alpha@sourceware.org" <libc-alpha@sourceware.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        David Daney <david.daney@cavium.com>
Subject: Re: [PATCH resend] MIPS: Allow FPU emulator to use non-stack area.
References: <54332A64.5020605@caviumnetworks.com> <20141007000514.GD23797@brightrain.aerifal.cx> <543334CE.8060305@caviumnetworks.com> <20141007004915.GF23797@brightrain.aerifal.cx> <54337127.40806@gmail.com> <6D39441BF12EF246A7ABCE6654B0235320F1E173@LEMAIL01.le.imgtec.org> <543431DA.4090809@imgtec.com> <CALCETrUQEbb=DotSzsneN7Hano_eC-EoTMko6uKcyZXvEcktkw@mail.gmail.com> <20141007190943.GM23797@brightrain.aerifal.cx> <54343C2B.2080801@imgtec.com> <20141007192107.GN23797@brightrain.aerifal.cx> <CALCETrU8qPL1qKGk7FqM=LCnoeSfuwDV_bG_a=5zcOKtWfkdGw@mail.gmail.com>
In-Reply-To: <CALCETrU8qPL1qKGk7FqM=LCnoeSfuwDV_bG_a=5zcOKtWfkdGw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43094
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

On 10/07/2014 12:28 PM, Andy Lutomirski wrote:
> On Tue, Oct 7, 2014 at 12:21 PM, Rich Felker <dalias@libc.org> wrote:
>> On Tue, Oct 07, 2014 at 12:16:59PM -0700, Leonid Yegoshin wrote:
>>> On 10/07/2014 12:09 PM, Rich Felker wrote:
>>>> I agree completely here. We should not break things (or, as it
>>>> seems, leave them broken) for common usage cases that affect
>>>> everyone just to coddle proprietary vendor-specific instructions.
>>>> The latter just should not be used in delay slots unless the chip
>>>> vendor also promises to provide fpu branch in hardware. Rich
>>> And what do you propose - remove a current in-stack emulation and
>>> you still think it doesn't break a status-quo?
>>
>> The in-stack trampoline support could be left but used only for
>> emulating instructions the kernel doesn't know. This would make all
>> normal binaries immediately usable with non-executable stack, and
>> would avoid the only potential source of regressions. Ultimately I
>> think the "xol" stuff should be removed, but that could be a long term
>> goal.
>
> Does anything break if the xol stuff is disabled for PT_GNU_STACK tasks?
>

The instructions must be executed, if you turn on a non-executable 
stack, you cannot execute them on the stack, so they must be handled in 
another way, which is the subject of this thread.

Options:

1a) XOL kernel manages the memory
1b) XOL userspace manages the menory
2) Emulate the instructions.
3) I don't think there is a 3rd. option.

As the imgtec people have said, you have to do #2 for their new r6 ISA, 
as it uses PC relative instructions.

I really think we should bite the bullet and do #2 for everything, it 
will be the cleanest long term solutions.

David Daney

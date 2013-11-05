Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Nov 2013 19:43:40 +0100 (CET)
Received: from mail-ie0-f172.google.com ([209.85.223.172]:48858 "EHLO
        mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6824283Ab3KESnhuCtRL (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 5 Nov 2013 19:43:37 +0100
Received: by mail-ie0-f172.google.com with SMTP id tp5so15945214ieb.17
        for <linux-mips@linux-mips.org>; Tue, 05 Nov 2013 10:43:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=7cL/uis/Wda8Ut5U9vSTGOQ6aPertW7ZbrXo52D+ZR0=;
        b=j8ElsvS4m2JQnQ+G+hpv8hn2KMh0ZGBVmdCEnGITyR3GHj0AFtQWTNMvCbloMPuGcB
         5L4a3kxwZD8OExoR4eItwgFTY3pm7Nd1iMynoqmgerNVBbrc/4raac/qLKMoRtyGbc1u
         gB6x9tuk6IJy3jzJLxCRdipZyKt92zshDh11eC1aoUmN2D94iOw2DwX4sy6ySpt6alnn
         Br3BkCT5mujbfISsY/LDlB6kGJvIwaa24geQLZlkVTy6gPuUcW3n8xcIKGJYe0wsFSK1
         bBNQlnU0v/KBXMRlFUmSbvA2BgAgtNlqrqkkm93ZfHwy/bCP8r7TgN+v2e7nJoabHiWI
         ZCnQ==
X-Received: by 10.42.149.7 with SMTP id t7mr1309260icv.60.1383677011002;
        Tue, 05 Nov 2013 10:43:31 -0800 (PST)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id p5sm9709663igj.10.2013.11.05.10.43.29
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 05 Nov 2013 10:43:30 -0800 (PST)
Message-ID: <52793C50.9030300@gmail.com>
Date:   Tue, 05 Nov 2013 10:43:28 -0800
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Rich Felker <dalias@aerifal.cx>,
        "Pinski, Andrew" <Andrew.Pinski@caviumnetworks.com>
CC:     Andreas Barth <aba@ayous.org>,
        "Joseph S. Myers" <joseph@codesourcery.com>,
        David Miller <davem@davemloft.net>, aurelien@aurel32.net,
        linux-mips@linux-mips.org, libc-alpha@sourceware.org
Subject: Re: prlimit64: inconsistencies between kernel and userland
References: <20130628133835.GA21839@hall.aurel32.net> <20131104213756.GD18700@hall.aurel32.net> <20131104.194519.1657797548878784116.davem@davemloft.net> <Pine.LNX.4.64.1311050058580.9883@digraph.polyomino.org.uk> <20131105012203.GA24286@brightrain.aerifal.cx> <20131105085859.GE28240@mails.so.argh.org> <20131105183732.GB24286@brightrain.aerifal.cx>
In-Reply-To: <20131105183732.GB24286@brightrain.aerifal.cx>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38456
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

On 11/05/2013 10:37 AM, Rich Felker wrote:
> On Tue, Nov 05, 2013 at 09:58:59AM +0100, Andreas Barth wrote:
>> * Rich Felker (dalias@aerifal.cx) [131105 02:22]:
>>> On Tue, Nov 05, 2013 at 01:04:45AM +0000, Joseph S. Myers wrote:
>>>> On Mon, 4 Nov 2013, David Miller wrote:
>>>>
>>>>> From: Aurelien Jarno <aurelien@aurel32.net>
>>>>> Date: Mon, 4 Nov 2013 22:37:56 +0100
>>>>>
>>>>>> Any news about this issue? It really starts to causes a lot of issues in
>>>>>> Debian. I have added a Cc: to libc people so that we can also hear their
>>>>>> opinion.
>>>>>
>>>>> I had the same exact problem on sparc several years ago, I simply fixed
>>>>> the glibc header value, it's the only way to fix this.
>>>>>
>>>>> Yes, that means you then have to recompile applications and libraries
>>>>> that reference this value.
>>>>
>>>> Surely you can create new symbol versions for getrlimit64 and setrlimit64,
>>>> with the old versions just using the 32-bit syscalls (or otherwise
>>>> translating between conventions, but using the 32-bit syscalls is the
>>>> simplest approach)?  I see no need to break compatibility with existing
>>>> binaries.
>>>>
>>>> As I noted in
>>>> <https://sourceware.org/ml/libc-ports/2006-05/msg00020.html>, at that time
>>>> the value of RLIM64_INFINITY for o32/n32 was purely a glibc convention the
>>>> kernel didn't see at all.  It's only with the use of newer syscalls that
>>>> this glibc convention is any sort of problem.
>>>
>>> Why not just make them convert any value >= 0x7fffffffffffffff to
>>> infinity before making the syscall? There's certainly no meaningful
>>> use for finite values in that range...
>>
>> Or just replace 0x7fffffffffffffff by kernels infinity - and still
>> fixing glibc, because the same value as the kernel should be the right
>> answer long term.
>
> Oh, I agree that change should be made too. I just suggested an
> additional fix that could be made to avoid the need for recompiling
> and replacing old binaries.
>

Why can't the default version of the functions in question be fixed so 
that they do the right thing?  That way you wouldn't have to rebuild old 
binaries.

Do we really need new function versions at all?


And FWIW:  I think Pinski might be looking at fixing this.

David Daney

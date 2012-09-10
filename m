Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Sep 2012 20:05:13 +0200 (CEST)
Received: from mail-pb0-f49.google.com ([209.85.160.49]:57281 "EHLO
        mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903466Ab2IJSFF (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 10 Sep 2012 20:05:05 +0200
Received: by pbbrq8 with SMTP id rq8so3024140pbb.36
        for <linux-mips@linux-mips.org>; Mon, 10 Sep 2012 11:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=EX57iYaZsxkx6zesvcJPdvD8OFOwy8yP9r5YUnzXNQw=;
        b=Ngi5kcqWdPs7t43yuHUQ9879hKttKcxtx6UBIkYfL3c+mFqhS9TjB9FendH1OrhURD
         7iVFt0rWM8o0HIeoHuGoP6grbA5lDKei/QlotSQIVNGgsOrd5gvrdubOMICEezGOGXRb
         h1Ih4NjsAXJ/H08l9Uxi4jGGc+KCwSrAnsX8Wbx2i6NR2AX5ZDeLWdfR5pHTsvV7QQsL
         oUxhuMbJSbKR4yLTXn/fGlPk0feaiio+ciZJTDpFi+C2VQxElaBrnGcy6kktru0VgkHx
         o3mAaEerLbSeJF5aF2jR8HTBRGyt1pzMuR7Hec2zanpRjIkiZynunw4DUtuB1n0Bo8kO
         0Osw==
Received: by 10.68.129.73 with SMTP id nu9mr7013787pbb.59.1347300298283;
        Mon, 10 Sep 2012 11:04:58 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id uu10sm8424328pbc.2.2012.09.10.11.04.56
        (version=SSLv3 cipher=OTHER);
        Mon, 10 Sep 2012 11:04:57 -0700 (PDT)
Message-ID: <504E2BC7.7000108@gmail.com>
Date:   Mon, 10 Sep 2012 11:04:55 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:15.0) Gecko/20120828 Thunderbird/15.0
MIME-Version: 1.0
To:     Rich Felker <dalias@aerifal.cx>
CC:     linux-mips@linux-mips.org
Subject: Re: Is r25 saved across syscalls?
References: <20120909193008.GA15157@brightrain.aerifal.cx> <20120910170830.GB24448@linux-mips.org> <20120910172248.GN27715@brightrain.aerifal.cx>
In-Reply-To: <20120910172248.GN27715@brightrain.aerifal.cx>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-archive-position: 34456
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On 09/10/2012 10:22 AM, Rich Felker wrote:
> On Mon, Sep 10, 2012 at 07:08:30PM +0200, Ralf Baechle wrote:
>> On Sun, Sep 09, 2012 at 03:30:08PM -0400, Rich Felker wrote:
>>
>>> The kernel syscall entry/exit code seems to always save and restore
>>> r25. Is this stable/documented behavior I can rely on? If there's a
>>> reason it _needs_ to be preserved, knowing that would help convince me
>>> it's safe to assume it will always be done. The intended usage is to
>>> be able to make syscalls (where the syscall # is not a constant that
>>> could be loaded with lwi) without a stack frame, as in "move $2,$25 ;
>>> syscall".
>>
>> The basic design idea is that syscalls use a calling convention similar
>> to subroutine calls.  $25 is $t9, so a temp register which is callee saved.
>>
>> So if the kernel is saving $t9 and you've been relying on that, consider
>> yourself lucky - there's not guarantee for that.
>
> Is there any documentation of what the kernel does guarantee?

Not really.  The glibc souces can be used as the canonical 
implementation as we cannot break it.  glibc assumes $25 is clobbered.

> All
> existing syscall-making code I've seen depends at least on r4-r7 not
> being clobbered when a signal interrupts a syscall

This is an internal kernel implementation detail. Relying on it in 
userspace is probably not a good idea.

> and sets it up for
> restart (since the arguments still need to be there when it's
> restarted), and seems to also depend on r4-r6 not being clobbered when
> the syscall successfully returns (since they're not listed in the
> clobber list, e.g. in uClibc's inline syscall asm).

Some versions of uClibc's inline syscall asm are buggy.  So they cannot 
be used as an indication of what is supported.

> These are
> requirements beyond the normal function call convention (which does
> not require the callee preserve the values of r4-r7).

I would assume these are clobbered (from glibc sources 
ports/sysdeps/unix/sysv/linux/mips/mips64/n64/sysdep.h):

"$1", "$3", "$10", "$11", "$12", "$13", "$14", "$15", "$24", "$25", 
"hi", "lo"


David Daney

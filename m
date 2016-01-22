Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Jan 2016 15:30:54 +0100 (CET)
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34658 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27014864AbcAVOavXhLVd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 22 Jan 2016 15:30:51 +0100
Received: by mail-wm0-f67.google.com with SMTP id b14so17644387wmb.1;
        Fri, 22 Jan 2016 06:30:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=bWzNCEVJSnaZ657DQD9p0Ipinu3hhYUAt+oHAyZl9Ec=;
        b=pjKOjoijdeQGj45EBaCAG3Z8t8N+OLz+5INlaMHHtGJ8LQDoU5AUyxRWuqSgrgM4kE
         UQRMW2eIvFh/ncEeTSSspeIe9L3VUtkvi+tRRqZ9ILoLqHheh9tLQjH56DZ+p4BlAU1F
         ldSYcsgS1Uuf5r4aXQNQwaOhK5eW7P+fsfe4py5oVArSopXAGTnC/ZVH7s2x4OT+HLaO
         sTAq64X/pR1iyLLqeZzLKeWy3c+7c+tuC47keJtnlEiM9r9HWPx9WCvXtvCpcl1fRmgj
         AikcAuNt2JWjGdX5nZRiB4+hmdiuIcFN+SSKG1v6BngRNlrpWWXLoXC9k/kzHJwJgsIL
         Pn0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=bWzNCEVJSnaZ657DQD9p0Ipinu3hhYUAt+oHAyZl9Ec=;
        b=DJtgLYMj9Tj7xC3HPqdRKo6Rcro21O8HLc7Ni8EHEcisdGCk1BVdxrr4FsAk6pIbGV
         a7uotgQdmgOgDFliqnTganDicK2ARXd8Ymubrgx4irMB9nHL897MWyMOW/mIZv2IT53D
         SCQec0PnsHpA4hWCHKR1fBNJSlJ7ymmmqLqMzf7CzEbRlnuBMTtsBdZAmIL34pwJl3Ux
         oOFT+clOCqaKKChw6Q32Hu6P9zMD8S6YmsQLeP5NEQp67po4a3y+4e8N3nrPFbkK88bv
         A4zV4MmPImalWfwy364uazDSKMCdfni+bSFpUFky2xKbuFKKyBMyCHIy/IsCy6WpOzSN
         sSKw==
X-Gm-Message-State: AG10YOQR3/ldBLZ/EjEbq0GnvldmXUFlFH6DRgSV4xPA0E8Hpyzxz+xO8khKJtN4BGGBS3Pz/fmLs261w8PUgQ==
X-Received: by 10.28.214.76 with SMTP id n73mr4224590wmg.52.1453473046158;
 Fri, 22 Jan 2016 06:30:46 -0800 (PST)
MIME-Version: 1.0
Received: by 10.28.136.68 with HTTP; Fri, 22 Jan 2016 06:30:06 -0800 (PST)
In-Reply-To: <20160122121908.GG31243@jhogan-linux.le.imgtec.org>
References: <1453460306-8505-1-git-send-email-james.hogan@imgtec.com>
 <1453460306-8505-2-git-send-email-james.hogan@imgtec.com> <CAOLZvyGeAgMt1KbmQR7c96WWXNJLr89b8hNSi9SePtjUK5K5fg@mail.gmail.com>
 <20160122121908.GG31243@jhogan-linux.le.imgtec.org>
From:   Manuel Lauss <manuel.lauss@gmail.com>
Date:   Fri, 22 Jan 2016 15:30:06 +0100
Message-ID: <CAOLZvyFi41ijxX7CrtiqqB7GcSUGLD0a5ZW3mmXzNQzcG0rN2A@mail.gmail.com>
Subject: Re: [PATCH 1/2] MIPS: c-r4k: Sync icache when it fills from dcache
To:     James Hogan <james.hogan@imgtec.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Leonid Yegoshin <leonid.yegoshin@imgtec.com>,
        Linux-MIPS <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <manuel.lauss@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51308
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@gmail.com
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

On Fri, Jan 22, 2016 at 1:19 PM, James Hogan <james.hogan@imgtec.com> wrote:
> On Fri, Jan 22, 2016 at 01:06:14PM +0100, Manuel Lauss wrote:
>> Hi James,
>>
>> On Fri, Jan 22, 2016 at 11:58 AM, James Hogan <james.hogan@imgtec.com> wrote:
>> > It is still necessary to handle icache coherency in flush_cache_range()
>> > and copy_to_user_page() when the icache fills from the dcache, even
>> > though the dcache does not need to be written back. However when this
>> > handling was added in commit 2eaa7ec286db ("[MIPS] Handle I-cache
>> > coherency in flush_cache_range()"), it did not do any icache flushing
>> > when it fills from dcache.
>> >
>> > Therefore fix r4k_flush_cache_range() to run
>> > local_r4k_flush_cache_range() without taking into account whether icache
>> > fills from dcache, so that the icache coherency gets handled. Checks are
>> > also added in local_r4k_flush_cache_range() so that the dcache blast
>> > doesn't take place when icache fills from dcache.
>> >
>> > A test to mmap a page PROT_READ|PROT_WRITE, modify code in it, and
>> > mprotect it to VM_READ|VM_EXEC (similar to case described in above
>> > commit) can hit this case quite easily to verify the fix.
>> >
>> > A similar check was added in commit f8829caee311 ("[MIPS] Fix aliasing
>> > bug in copy_to_user_page / copy_from_user_page"), so also fix
>> > copy_to_user_page() similarly, to call flush_cache_page() without taking
>> > into account whether icache fills from dcache, since flush_cache_page()
>> > already takes that into account to avoid performing a dcache flush.
>> >
>> > Signed-off-by: James Hogan <james.hogan@imgtec.com>
>> > Cc: Ralf Baechle <ralf@linux-mips.org>
>> > Cc: Leonid Yegoshin <leonid.yegoshin@imgtec.com>
>> > Cc: Manuel Lauss <manuel.lauss@gmail.com>
>> > Cc: linux-mips@linux-mips.org
>> > ---
>> >  arch/mips/mm/c-r4k.c | 11 +++++++++--
>> >  arch/mips/mm/init.c  |  2 +-
>> >  2 files changed, 10 insertions(+), 3 deletions(-)
>>
>>
>> I did some light testing on Alchemy and see no problems so far.
>> If it matters:  Tested-by: Manuel Lauss <manuel.lauss@gmail.com>
>
> Thanks Manuel.
>
> FWIW, attached is the test program I mentioned, which hits the first
> part of this patch (flush_cache_range) via mprotect(2) and checks if
> icache seems to have been flushed (tested on mips64r6, but should be
> portable).

With the patch it takes almost 3 times as long to finish the test, but
it does fix
occasional (5 out of 20 runs) failures.  The --loop2 test always fails, with or
without the patch:

db1300 ~ # ./mprotect-test --loop2
Initial mprotect SUCCESS
Looped { mprotect RW, modify, mprotect RX, test } SUCCESS
mprotect.c:214: Looped mprotect(2) PROT_READ|PROT_WRITE|PROT_EXEC
didn't sync icache, ret=ffffffff, expected 0

Manuel

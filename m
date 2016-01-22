Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Jan 2016 16:56:20 +0100 (CET)
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34126 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009553AbcAVP4SOPwkC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 22 Jan 2016 16:56:18 +0100
Received: by mail-wm0-f65.google.com with SMTP id b14so18080787wmb.1;
        Fri, 22 Jan 2016 07:56:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=78qpiCIAcBu/7Yo4Mw/jk/oh8G8lqzJneLm9j6bvTYA=;
        b=sx/0YUiPBs9eZTAnLx2r8uqSOgY8mKjYeJZ2Ya3YUgNRqFxSkgjAcHoL9xXQd7cRN8
         xe6AptPl3s+8fauQz8WJG+tvjHI5Q2qNTBi7KVe43VQPZHW95oUqwpnoG3EZhmPO0tTc
         FXedeUDq3dwh6MpXt3WREnTmhvai0lBZEcNoAKD3ETTP/T1fYainjoee9Pfg87Y5xgsN
         hprAcj8iV4fU++BVSbvkcZzM/L3QAM/WFW1uEwAZYWw3gtFnHzNys/ifvSggqDztGffs
         V2J/FWrO1tQzzZ2mLL9I+n+OmNf/pJO25xZEOMMhbQKwlVdiLaEX+DGiBKI58q+t2i9n
         QZ0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=78qpiCIAcBu/7Yo4Mw/jk/oh8G8lqzJneLm9j6bvTYA=;
        b=kPduslo0VCte+blHFgCxdbcbq39vx3XLqbRuZGxp4tk0RPZxxk0nLbMrsO7AeqTRZV
         RFPAtJUDT8QFDgZttCD3kGzPceUyPWOl8zOLnys3TdlBWbYV8PfGJSIb2ldVzwaxYpdg
         nUTdKoodCNd2nvnBkWefSzV8zt7+fu5FI1VhZCIi3Vwpd0VY20Vy5j2j8zp8UGyGdibM
         tLj/tzD4pAtbLjdmQvS8mHJXtQ2JOyeKtJA90x1EhCiEZ9/vi0qDgZWe3jux3c07mzi5
         yDcyt2IAiLajSsjVb2GfIUsCRN8SMjRdra6sBLQiooQl/SjpZ/xY61q4VdF8SuFfURrr
         A8vA==
X-Gm-Message-State: AG10YOT179/a4zVi5IxkZ2evGtIdehfPWLbW+ufyo+64c78Ia0UQAdl0mH5FcdDBTBe+QSju9QQjEqOx38VgAw==
X-Received: by 10.28.229.201 with SMTP id c192mr4469331wmh.103.1453478172995;
 Fri, 22 Jan 2016 07:56:12 -0800 (PST)
MIME-Version: 1.0
Received: by 10.28.136.68 with HTTP; Fri, 22 Jan 2016 07:55:33 -0800 (PST)
In-Reply-To: <20160122150241.GS24198@jhogan-linux.le.imgtec.org>
References: <1453460306-8505-1-git-send-email-james.hogan@imgtec.com>
 <1453460306-8505-2-git-send-email-james.hogan@imgtec.com> <CAOLZvyGeAgMt1KbmQR7c96WWXNJLr89b8hNSi9SePtjUK5K5fg@mail.gmail.com>
 <20160122121908.GG31243@jhogan-linux.le.imgtec.org> <CAOLZvyFi41ijxX7CrtiqqB7GcSUGLD0a5ZW3mmXzNQzcG0rN2A@mail.gmail.com>
 <20160122150241.GS24198@jhogan-linux.le.imgtec.org>
From:   Manuel Lauss <manuel.lauss@gmail.com>
Date:   Fri, 22 Jan 2016 16:55:33 +0100
Message-ID: <CAOLZvyExip6KRfNxXP--fsJXJ1Lb_i+VB5h0AE-2PLYkhgw38A@mail.gmail.com>
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
X-archive-position: 51311
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

On Fri, Jan 22, 2016 at 4:02 PM, James Hogan <james.hogan@imgtec.com> wrote:
> On Fri, Jan 22, 2016 at 03:30:06PM +0100, Manuel Lauss wrote:
>> On Fri, Jan 22, 2016 at 1:19 PM, James Hogan <james.hogan@imgtec.com> wrote:
>> > On Fri, Jan 22, 2016 at 01:06:14PM +0100, Manuel Lauss wrote:
>> >> Hi James,
>> >>
>> >> On Fri, Jan 22, 2016 at 11:58 AM, James Hogan <james.hogan@imgtec.com> wrote:
>> >> > It is still necessary to handle icache coherency in flush_cache_range()
>> >> > and copy_to_user_page() when the icache fills from the dcache, even
>> >> > though the dcache does not need to be written back. However when this
>> >> > handling was added in commit 2eaa7ec286db ("[MIPS] Handle I-cache
>> >> > coherency in flush_cache_range()"), it did not do any icache flushing
>> >> > when it fills from dcache.
>> >> >
>> >> > Therefore fix r4k_flush_cache_range() to run
>> >> > local_r4k_flush_cache_range() without taking into account whether icache
>> >> > fills from dcache, so that the icache coherency gets handled. Checks are
>> >> > also added in local_r4k_flush_cache_range() so that the dcache blast
>> >> > doesn't take place when icache fills from dcache.
>> >> >
>> >> > A test to mmap a page PROT_READ|PROT_WRITE, modify code in it, and
>> >> > mprotect it to VM_READ|VM_EXEC (similar to case described in above
>> >> > commit) can hit this case quite easily to verify the fix.
>> >> >
>> >> > A similar check was added in commit f8829caee311 ("[MIPS] Fix aliasing
>> >> > bug in copy_to_user_page / copy_from_user_page"), so also fix
>> >> > copy_to_user_page() similarly, to call flush_cache_page() without taking
>> >> > into account whether icache fills from dcache, since flush_cache_page()
>> >> > already takes that into account to avoid performing a dcache flush.
>> >> >
>> >> > Signed-off-by: James Hogan <james.hogan@imgtec.com>
>> >> > Cc: Ralf Baechle <ralf@linux-mips.org>
>> >> > Cc: Leonid Yegoshin <leonid.yegoshin@imgtec.com>
>> >> > Cc: Manuel Lauss <manuel.lauss@gmail.com>
>> >> > Cc: linux-mips@linux-mips.org
>> >> > ---
>> >> >  arch/mips/mm/c-r4k.c | 11 +++++++++--
>> >> >  arch/mips/mm/init.c  |  2 +-
>> >> >  2 files changed, 10 insertions(+), 3 deletions(-)
>> >>
>> >>
>> >> I did some light testing on Alchemy and see no problems so far.
>> >> If it matters:  Tested-by: Manuel Lauss <manuel.lauss@gmail.com>
>> >
>> > Thanks Manuel.
>> >
>> > FWIW, attached is the test program I mentioned, which hits the first
>> > part of this patch (flush_cache_range) via mprotect(2) and checks if
>> > icache seems to have been flushed (tested on mips64r6, but should be
>> > portable).
>>
>> With the patch it takes almost 3 times as long to finish the test, but
>
> Interesting... I suppose at least it brings alchemy in line with
> behaviour on other cores.
>
>> it does fix
>> occasional (5 out of 20 runs) failures.
>
> How big is your icache?

icache has16kB


> With 64KB icache it fails fairly consistently for me, but wouldn't
> surprise me if smaller caches would make it much harder to hit,
> especially as it only tests the first cache line in the page.




Thanks!
     Manuel

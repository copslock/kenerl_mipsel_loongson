Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Jan 2016 13:07:01 +0100 (CET)
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33893 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009517AbcAVMG7cqJ24 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 22 Jan 2016 13:06:59 +0100
Received: by mail-wm0-f66.google.com with SMTP id b14so16904713wmb.1;
        Fri, 22 Jan 2016 04:06:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=NtpUazDYNoTLXS7SZ2B2mr+eUHTLejQgHr2m4O/NHM8=;
        b=wLqpvfuV7IuMTXBymwrKGrTF2CTv+XtMNMK7ezvpcCEJUUq/ejipxdLoSB+o09CYWH
         c5uiJmPse0Rf+aatwfgksTNpvJGgVVOhSDGQIRtnF9aFsMPoS0BKC0gVB/8l+9qyFWtI
         ZqOAZ3ktNRhynXjpRyUVZ02ywCk/oDDqt6m433QCJ/So4+PNOJv9prYIZx7o/Mg/yPNl
         YlAS0jU2H9jsR6HW1UPPN8C0CduIW4LdPi24rhRXxwtVoE6x8poeiJ0bbXlJ14/n2QFX
         Rnin3QeLnqxar0xfkfgf+ER+Cic77AZU0UAcmRA2XbGdoshlmKddlNSYOcz9EQuBLC8y
         NMnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=NtpUazDYNoTLXS7SZ2B2mr+eUHTLejQgHr2m4O/NHM8=;
        b=bmon66nDedjq7EnruDiMDI+ckiJsrUHktAU+9GZ0ydAJn3pUxiEcVDFTZmWAav45XR
         bTq5CM6k7dDAdcuJhrYs3e1a9MJL0nfGXgl5ixEA5R8m5ojxdCfzUzd1ok8iGsdlo9EZ
         Jzb690N+NYZj8v9RXPImLjWOopoWPDvLXBoP8bZ9s2YT8aq0aM9u2+Lt+X3YmRMeZUWs
         GGF5yNgA1rvjJ8OTzk5UmMT62rQGXzlXincZ3vMhM10FFRI+zlYTubAwnO2/8Dhp5Axz
         PiAxvCi4Le/pTdMqqvHDo5wRzxkofT+btmEcmmPjIpDaG0vkL52HkOa2UAH1pcbGBFB9
         xR9w==
X-Gm-Message-State: AG10YOSEOUjUQmc4LzKwD4FrndQ/xFLj5g4+Zvadid2ZRfZ/D9a85y8fYz14eweo4mALSi3UUZWY7Wgc8WQOEg==
X-Received: by 10.194.21.135 with SMTP id v7mr2772351wje.131.1453464414276;
 Fri, 22 Jan 2016 04:06:54 -0800 (PST)
MIME-Version: 1.0
Received: by 10.28.136.68 with HTTP; Fri, 22 Jan 2016 04:06:14 -0800 (PST)
In-Reply-To: <1453460306-8505-2-git-send-email-james.hogan@imgtec.com>
References: <1453460306-8505-1-git-send-email-james.hogan@imgtec.com> <1453460306-8505-2-git-send-email-james.hogan@imgtec.com>
From:   Manuel Lauss <manuel.lauss@gmail.com>
Date:   Fri, 22 Jan 2016 13:06:14 +0100
Message-ID: <CAOLZvyGeAgMt1KbmQR7c96WWXNJLr89b8hNSi9SePtjUK5K5fg@mail.gmail.com>
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
X-archive-position: 51303
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

Hi James,

On Fri, Jan 22, 2016 at 11:58 AM, James Hogan <james.hogan@imgtec.com> wrote:
> It is still necessary to handle icache coherency in flush_cache_range()
> and copy_to_user_page() when the icache fills from the dcache, even
> though the dcache does not need to be written back. However when this
> handling was added in commit 2eaa7ec286db ("[MIPS] Handle I-cache
> coherency in flush_cache_range()"), it did not do any icache flushing
> when it fills from dcache.
>
> Therefore fix r4k_flush_cache_range() to run
> local_r4k_flush_cache_range() without taking into account whether icache
> fills from dcache, so that the icache coherency gets handled. Checks are
> also added in local_r4k_flush_cache_range() so that the dcache blast
> doesn't take place when icache fills from dcache.
>
> A test to mmap a page PROT_READ|PROT_WRITE, modify code in it, and
> mprotect it to VM_READ|VM_EXEC (similar to case described in above
> commit) can hit this case quite easily to verify the fix.
>
> A similar check was added in commit f8829caee311 ("[MIPS] Fix aliasing
> bug in copy_to_user_page / copy_from_user_page"), so also fix
> copy_to_user_page() similarly, to call flush_cache_page() without taking
> into account whether icache fills from dcache, since flush_cache_page()
> already takes that into account to avoid performing a dcache flush.
>
> Signed-off-by: James Hogan <james.hogan@imgtec.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Leonid Yegoshin <leonid.yegoshin@imgtec.com>
> Cc: Manuel Lauss <manuel.lauss@gmail.com>
> Cc: linux-mips@linux-mips.org
> ---
>  arch/mips/mm/c-r4k.c | 11 +++++++++--
>  arch/mips/mm/init.c  |  2 +-
>  2 files changed, 10 insertions(+), 3 deletions(-)


I did some light testing on Alchemy and see no problems so far.
If it matters:  Tested-by: Manuel Lauss <manuel.lauss@gmail.com>

Thanks!
     Manuel

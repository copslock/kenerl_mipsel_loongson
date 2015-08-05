Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Aug 2015 22:26:18 +0200 (CEST)
Received: from mail-ig0-f175.google.com ([209.85.213.175]:37772 "EHLO
        mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012582AbbHEU0P4F6xJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 5 Aug 2015 22:26:15 +0200
Received: by igbpg9 with SMTP id pg9so40920077igb.0
        for <linux-mips@linux-mips.org>; Wed, 05 Aug 2015 13:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=yKkfLTV6edDeY/RBSgi6XFcMCnH3UjwOevX91zgEU8w=;
        b=e+cbdzDlU5O4nD6VDDwfkMAPG2V/Wgq39IybyAtjk4mssaevCDtiLlwKDNKoj1zFom
         6fNKz5gmH3a2Gl2MemxLsCzMJfF6FElYrDCCX11iJld6pC8kxSDB2yI0lXOQsKXlczAD
         pgoUBect2XdwZ7cdJRM7b4C/ug22JOEQTTww2e+tPPm86RVxkr2tI5zwDo7nzSqtte6H
         SlNnWtSEWkzL9CjCO9xTjRp0sW0dKa8Ve72bYRCpHy5z8LyeL6499KKHs2Y/OIiMmIQZ
         HQlffbO7vFVk1A932oY/0PJf3v2k/Lyy7Vjms4CFCIJ8rihy9qGlL4l36eCCOa9PwIC/
         zWuQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=yKkfLTV6edDeY/RBSgi6XFcMCnH3UjwOevX91zgEU8w=;
        b=O7OalrVUPEoeA4pphn37fgUswu4riovSrQBs6lPXPpVFxENdrcuSiACfdoOy0emLwl
         C/3hGFSZB428xD33x1TyF5NteHSuMeGVL6LPGXBJl5fW0DyHZGwIi/aA6Gz50RCLR/md
         WMWzf8I1bQlA3vN72blD3xgJetybW5fIi8bfs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=yKkfLTV6edDeY/RBSgi6XFcMCnH3UjwOevX91zgEU8w=;
        b=Tuf0ACpkrCexddn7fGqJY/dwPzV4LHdyipETXSmoNWohEYLIQGhgPAVvzLJQwIrXPY
         fgDIyuUwCTrdA6XdWlc97zgkdc2GjQHPNaq8D2RjNKjfosqINPC60Ni8GFuL5Pd/TZql
         4QhO+ZB00/51YhRVMhD2CYz2GuiRvJ2zcoCYPtAaVGEcSMey8pSPrAt3dfUkW7frTaT4
         QmffyhO/wPgQ1ugJzv8EIQjSlWFxQ46VzHqjxE48AT0Qz9mWhZ02SuaA5hLf6VyvCQrI
         gtldN1uyEm1jt4hU4I34aCLvrLYUInq+texPgdyCc3bnEM/n0Vc3cR0ZPFk96q72UKmd
         mfbQ==
X-Gm-Message-State: ALoCoQmSsAm+t90x00UoDS97Fv3NKB7d1YHCLAzqhten8I/6jrwCKpYEpgWxDxBbIUOIit1SP68H
MIME-Version: 1.0
X-Received: by 10.50.66.197 with SMTP id h5mr1300716igt.81.1438806369775; Wed,
 05 Aug 2015 13:26:09 -0700 (PDT)
Received: by 10.64.60.130 with HTTP; Wed, 5 Aug 2015 13:26:09 -0700 (PDT)
In-Reply-To: <1438789735-4643-1-git-send-email-james.hogan@imgtec.com>
References: <1438789735-4643-1-git-send-email-james.hogan@imgtec.com>
Date:   Wed, 5 Aug 2015 13:26:09 -0700
X-Google-Sender-Auth: trxKmAXLjteCIDrRIX5RxHvNmlA
Message-ID: <CAGXu5jJd4EH37B51zxphYkwp6RBOkYuwiGNr7C6nJK2q=JE79A@mail.gmail.com>
Subject: Re: [PATCH 0/7] test_user_copy improvements
From:   Kees Cook <keescook@chromium.org>
To:     James Hogan <james.hogan@imgtec.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <keescook@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48606
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: keescook@chromium.org
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

On Wed, Aug 5, 2015 at 8:48 AM, James Hogan <james.hogan@imgtec.com> wrote:
> These patches extend the test_user_copy test module to handle lots more
> cases of user accessors which architectures can override separately, and
> in particular those which are important for checking the MIPS Enhanced
> Virtual Addressing (EVA) implementations, which need to handle
> overlapping user and kernel address spaces, with special instructions
> for accessing user address space from kernel mode.
>
> - Checking that kernel pointers are accepted when user address limit is
>   set to KERNEL_DS, as done by the kernel when it internally invokes
>   system calls with kernel pointers.
> - Checking of the unchecked accessors (which don't call access_ok()).
>   Some of the tests are special cased for EVA at the moment which has
>   stricter hardware guarantees for bad user accesses than other
>   configurations.
> - Checking of other sets of user accessors, including the inatomic user
>   copies, copy_in_user, clear_user, the user string accessors, and the
>   user checksum functions, all of which need special handling in arch
>   code with EVA.
>
> Tested on MIPS with and without EVA, and on x86_64.
>
> James Hogan (7):
>   test_user_copy: Check legit kernel accesses
>   test_user_copy: Check unchecked accessors
>   test_user_copy: Check __clear_user()/clear_user()
>   test_user_copy: Check __copy_in_user()/copy_in_user()
>   test_user_copy: Check __copy_{to,from}_user_inatomic()
>   test_user_copy: Check user string accessors
>   test_user_copy: Check user checksum functions
>
>  lib/test_user_copy.c | 221 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 221 insertions(+)
>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>

Ooooh! Nice! This is great, thank you. :) Great to hear it helped find
a bug too. :)

I'm wondering if we need to macro-ize any of these. Probably not, but
it just feels like there's a lot of repeated stuff now. But I think
it's a bit of an illusion since each test is ever so slightly
different from the others.

Acked-by: Kees Cook <keescook@chromium.org>

-Kees

-- 
Kees Cook
Chrome OS Security

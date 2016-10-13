Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Oct 2016 20:42:36 +0200 (CEST)
Received: from mail-lf0-f45.google.com ([209.85.215.45]:36055 "EHLO
        mail-lf0-f45.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992195AbcJMSm2gOyIe (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 13 Oct 2016 20:42:28 +0200
Received: by mail-lf0-f45.google.com with SMTP id b75so149018305lfg.3
        for <linux-mips@linux-mips.org>; Thu, 13 Oct 2016 11:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=h78anNMCNnjlvJdqoYcN7gBeyGMmjsYYQDVKDAoFtw0=;
        b=VmuOK8ohCcT7+5+WUQtw0ocQfq3tChILnmfszPhYZi0KAs6ugHPXta2OJOPl5X74ca
         7y2YErxTma9KXhHteKjZo6ngaMgD0aAlAet6SM/iC9bfd3iboNPHfywfk4RJ4PcmwhsT
         aOQebT+LqF53Zx3yhf/Kmq+GaptXwA8A7DpHlrIB7xOvncUBAedJcF9M0pQzUJiwb3KA
         ts0J8DCfRc63f4viQLle8HsL65JO7RcTzZDg7pIueaWDJu0FUwYQ/BMcv5eCA0BviEAT
         z5iqEVm0l1nhci5oVp7VmB+vx08gL6DPljP4cOoQ0M6hZZ7glZ/RP2mn3wsVe8gSIT/o
         +u6g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=h78anNMCNnjlvJdqoYcN7gBeyGMmjsYYQDVKDAoFtw0=;
        b=QvUgjtuIZ2u8EeHyXYFZE/JGcgMHguD5ZsbFYUipwVebJDV65Y70S/u44tkWHeiXZc
         7AlhxUpKsaJfmUL0IdOebfgRPdh0MDSjyM/ftss4azvCfC1iGNWxcVIeqT9p/5o4Accm
         nYu8IvIDCR+tOBOeAqrCU4gqKehSFP+28pH64=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=h78anNMCNnjlvJdqoYcN7gBeyGMmjsYYQDVKDAoFtw0=;
        b=D85cIe3lyDkwFSBM//eG4xpqFal/mztySBZiOyea+J1nTkk+HidpPXjq6AzQoD+Ycp
         OJe0VUQhl+FrOXMQAUd28jQlXNGWzYgA7BO+2lK8YDWceGHK81oWFazgXtK1NQkvYUL/
         qgOacdPj7CFvhKXeJZ/eRedV9AgC7XmbogUsoBB5Y1fe5YTT9y0Proc7U4f82oyYvIZp
         +QfPnV20VEsNM2Zghv1Zo6UT3BbiUr3hp/eL+MR79BVdFadA9D0tE+ygHuEKKtNrvzPt
         SlBYKrC0hh8KRVre9U/V5CAir66Hwh3f9uGAze0RGoG4fs526da3yGSLgK/JZ+YQkNBF
         NiFg==
X-Gm-Message-State: AA6/9RlaNnuHaOoSx2RxtaAwzrlo1rgaDwkGNJXxPGPaoVVfk78oGSFAKOJGCgaKCd5l1Tkbni5D46rRXCp/NEfl
X-Received: by 10.28.64.133 with SMTP id n127mr3106640wma.31.1476384142674;
 Thu, 13 Oct 2016 11:42:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.28.104.67 with HTTP; Thu, 13 Oct 2016 11:42:21 -0700 (PDT)
In-Reply-To: <33584114.GQq7GNxjzm@np-p-burton>
References: <20161008214714.5375-1-paul.burton@imgtec.com> <20161010132642.GA8229@linux-mips.org>
 <CAGXu5jLZjFu_Mg93bzu0WBPwNVLuqmiNQ7O4Gpo4NaDn=yO_PQ@mail.gmail.com> <33584114.GQq7GNxjzm@np-p-burton>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 13 Oct 2016 11:42:21 -0700
X-Google-Sender-Auth: YVXsLMJ4FxVTYtV3BNN-D0-bD7c
Message-ID: <CAGXu5jLy21v=GCbZm-GgRafXP2pz1tn=kww5hr0WmaYpW2XtRw@mail.gmail.com>
Subject: Re: [PATCH] MIPS: Enable hardened usercopy
To:     Paul Burton <paul.burton@imgtec.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Dmitry Vyukov <dvyukov@google.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <keescook@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55424
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

On Thu, Oct 13, 2016 at 7:08 AM, Paul Burton <paul.burton@imgtec.com> wrote:
> On Wednesday, 12 October 2016 23:36:28 BST Kees Cook wrote:
>> On Mon, Oct 10, 2016 at 6:26 AM, Ralf Baechle <ralf@linux-mips.org> wrote:
>> > On Sat, Oct 08, 2016 at 10:47:14PM +0100, Paul Burton wrote:
>> >> Enable CONFIG_HARDENED_USERCOPY checks for MIPS, calling check_object
>> >> size in all of copy_{to,from}_user(), __copy_{to,from}_user() &
>> >> __copy_{to,from}_user_inatomic().
>>
>> Awesome! Thanks for hooking this up. (Were you able to test with
>> lkdtm's usercopy tests?)
>
> Hi Kees,
>
> Yes - they successfully failed with a v4.8-based kernel, except for the stack
> ones (because we don't yet have arch_within_stack_frames, which looks to be
> true of everyone but x86) and the heap flags ones, which I gather from your
> blog post[1] isn't expected to fail yet.
>
> [1] https://outflux.net/blog/archives/2016/10/04/security-things-in-linux-v4-8/

Yup, perfect, those all sound to have behaved as expected. :) Thanks!

-Kees

-- 
Kees Cook
Nexus Security

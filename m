Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 20 Sep 2014 19:20:04 +0200 (CEST)
Received: from mail-ob0-f182.google.com ([209.85.214.182]:58073 "EHLO
        mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009362AbaITRUCxcO3f (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 20 Sep 2014 19:20:02 +0200
Received: by mail-ob0-f182.google.com with SMTP id wo20so2718234obc.27
        for <linux-mips@linux-mips.org>; Sat, 20 Sep 2014 10:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=UxcMSApMKIc8UNRtUd7vRjPk7Cv1CJRGZHnkPelqGzM=;
        b=YxOpldbxDeuuO7aYjXJsRy82l7tcduJfFvOIkf0o1jWqXElcuHYmTsqbdAFp3dGPZS
         qpngWDXREciCFMVljTENUuvs/3MFc7sMjltD/69Zp36HXfSzvUp7sDg4zoyuWO9C6ndq
         KzW+BnLU3qNrdA2NBBtFaCKe2q0/6iDwemCnATjDu95AbCpwU5BEebLwdl4U2T5kAb/R
         f1JTzOkfji9cBRHpxvaAb0t3SPTAK6bbDPFq0S4Azr5UwWGJtdX0ZH12d6/+UnIoYSEZ
         jcbZY+OWfAJ8t8d4WK4iF3VsZxhrB2SJsJWZ4JGHg2NuSlBap73n+tnaE/Yd4ts3cp1w
         DOfA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=UxcMSApMKIc8UNRtUd7vRjPk7Cv1CJRGZHnkPelqGzM=;
        b=YOtchZrRYTQ+Df0NdTHEGdR5aJL8AA7s9iaCdzzDzWpssXj072hZefYblERcY0CuBp
         q3J/w0lycUqREMNIKdVQNTmcDOlLzHB9nr8rC14vaaAKqhu2veJrfG9g60YLu/gbxh0U
         D7XPQvhhC6pcyY9nwNv8fwhMfOXZ38SNriZHU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=UxcMSApMKIc8UNRtUd7vRjPk7Cv1CJRGZHnkPelqGzM=;
        b=QDnVsfZl83Ux/8c4JgEzdZ4krnFuS5TrM2U7sQlbOHI+dTR2ZZe7IbQChZfGW4hs3r
         a/3ODah6cv+dg9SxvOPjbRs36aoQDnD/SbbFkPR3j8O+sjfYvijjkYORgsUv1emxoHh8
         AqkidpvQycoNveP6WA4lUOuMPhupX60lVnfDPmAifwRMljTMsM8zZGU3gFKLk3PjtsuK
         bGEhnEOPmI/cWMtugBFHftHIrYJWMsLuMQAZ8D//jBCJwBJsuRs5LoqhcXpLtxzOCvge
         Y8FwKVRHc4ODx8nfJlYz+OPb3Ale6og3bb36wtAsyMFJFOC6/Bp6+y4e6CMTCQH84Bp5
         QWYA==
X-Gm-Message-State: ALoCoQmmJcSiRZq16dF+KTUte3iM/l42PBCb0671pddFK/ZCHkUEPW7M5m4mal1P6ekrAbnI/UUE
MIME-Version: 1.0
X-Received: by 10.60.101.226 with SMTP id fj2mr3593601oeb.70.1411233596484;
 Sat, 20 Sep 2014 10:19:56 -0700 (PDT)
Received: by 10.182.73.227 with HTTP; Sat, 20 Sep 2014 10:19:56 -0700 (PDT)
In-Reply-To: <201409201940.AHG21834.LJOFFHSFQOtVMO@I-love.SAKURA.ne.jp>
References: <201409192053.IHJ35462.JLOMOSOFFVtQFH@I-love.SAKURA.ne.jp>
        <541D16EA.70407@huawei.com>
        <201409201940.AHG21834.LJOFFHSFQOtVMO@I-love.SAKURA.ne.jp>
Date:   Sat, 20 Sep 2014 10:19:56 -0700
X-Google-Sender-Auth: Lt9yeWj59SHYbGBtJAA-5Sb0WGw
Message-ID: <CAGXu5jLf3st2WBV5ycEOgCJGk8z5TP1SuvLQcD=sC2cs_4CF8w@mail.gmail.com>
Subject: Re: [PATCH 3.17-rc5] Fix confusing PFA_NO_NEW_PRIVS constant.
From:   Kees Cook <keescook@chromium.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        James Morris <james.l.morris@oracle.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
        David Drysdale <drysdale@google.com>,
        Michael Kerrisk-manpages <mtk.manpages@gmail.com>,
        Will Drewry <wad@chromium.org>,
        Julien Tinnes <jln@chromium.org>,
        Linux API <linux-api@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <keescook@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42706
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

On Sat, Sep 20, 2014 at 3:40 AM, Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
> Can you apply below patch before new PFA_* are defined?
> Cgroups code might want to define PFA_SPREAD_PAGE as 1 and PFA_SPREAD_SLAB as 2.
> ----------------------------------------
> >From 8543e68adb210142fa347d8bc9d83df0bb2c5291 Mon Sep 17 00:00:00 2001
> From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Date: Sat, 20 Sep 2014 19:24:23 +0900
> Subject: [PATCH 3.17-rc5] Fix confusing PFA_NO_NEW_PRIVS constant.
>
> Commit 1d4457f99928 ("sched: move no_new_privs into new atomic flags")
> defined PFA_NO_NEW_PRIVS as hexadecimal value, but it is confusing
> because it is used as bit number. Redefine it as decimal bit number.
>
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> ---
>  include/linux/sched.h |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 5c2c885..4557765 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -1957,7 +1957,7 @@ static inline void memalloc_noio_restore(unsigned int flags)
>  }
>
>  /* Per-process atomic flags. */
> -#define PFA_NO_NEW_PRIVS 0x00000001    /* May not gain new privileges. */
> +#define PFA_NO_NEW_PRIVS 0     /* May not gain new privileges. */
>
>  static inline bool task_no_new_privs(struct task_struct *p)
>  {

Thanks, good catch.

Acked-by: Kees Cook <keescook@chromium.org>

-Kees

-- 
Kees Cook
Chrome OS Security

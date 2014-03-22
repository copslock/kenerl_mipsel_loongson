Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 22 Mar 2014 20:06:05 +0100 (CET)
Received: from mail-ob0-f177.google.com ([209.85.214.177]:58918 "EHLO
        mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6816383AbaCVTGCbfZKp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 22 Mar 2014 20:06:02 +0100
Received: by mail-ob0-f177.google.com with SMTP id wo20so3919851obc.36
        for <linux-mips@linux-mips.org>; Sat, 22 Mar 2014 12:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=A3RHmhO31NF15B9AHMv6L4yQK2M+Rg7nl1KmwZSqS8Y=;
        b=TMnHgfhPUUq20fyXydnNcUNuVMhsdqoRceO9Bioj+YGoYVNzXRu4wCHpgOPGR7Rs6s
         u8IAY3NypePjeReVP157TPtHaJQJICazyt/sK+vMFWfjtneG4cceIJXrroPlTZqJ7w5y
         9PgWReJBtqGtawj+AEBLY5LDkpgFXA2zr0gVYd+tJPoCUnqUn3WoKi/Qj6yio5SO7a5w
         /Hfj/XlxBhJY022s4rhmO1FXoWNBGDJkhA66MPUeKq+fMR/W/g/Bp56/AaH79j1qp7z6
         kdb5gvHPd1DfckcKV7ZAC9EcFRhFM9AAE38XPFmEudefkC3HNqaex0MU7SJRtdzroBjn
         S4PA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=A3RHmhO31NF15B9AHMv6L4yQK2M+Rg7nl1KmwZSqS8Y=;
        b=jn9w2s8r3O+q1D6Kh1NBwu7FYFe2NIZa/U4mV0nS35jd349HssGwt1WpWXDXrBKE7e
         lLgDmeKnRr3M7bzuISRp8mpMMOsUPJAqXkJ00vle9Q7LUjbWa7CG/IRLgDAmkoC1pqd8
         N077im/7hL/qvc84/72jx1dzzumsRqmDrcM0w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=A3RHmhO31NF15B9AHMv6L4yQK2M+Rg7nl1KmwZSqS8Y=;
        b=D2LKmJ75b4/zSYFCL5yoNAfO5VFZGbkTn06/PmfPuryJEy+M/pst4hMJuL7l0FLyS5
         UAI2oj6xwqvxk3hURzk6ctCYkFqMGXbMbsAvjDLeGE17/q/0coN26EBx/rwc726luhba
         9bYJPOXNGkCbVqpd8M/a55fz+z9I+a63l4IpV4tovF1GAMZgfRPlENhql3hR7/jHg3rY
         YBIm793ZBJUMW4Skch8cKFpQbjGLFOoddjrJoFZJdt+WknfH0TbI0nAAjVe6X9qBZ5AJ
         5CQGkuSDwLpacLnDlNzsRkkrzyIbcCOrk+q0wvi+FlDzZ72OeJgrHynC0zDQ94YcZmAQ
         ZMIQ==
X-Gm-Message-State: ALoCoQnlbu2fTpARUcoK1aM6NRQUSDP2ACBMFdeyEYvjGDSZ6bg4f2A+vqS5y7EahjG5J/Sntiaf7J/GTzyhPM22ZKEaw20a6efXNkMcbhbn8+GC+5fOHuN+dGkZFZ3JCxPZ1SRorDGPrP9veJodaQH1GVEnDfwtg7t2+12GtyN68aJajXukP5/CMHLprh27fR4iGTF7vUjscH/eS2zt6bHWgAL3tZbVRA==
MIME-Version: 1.0
X-Received: by 10.182.194.103 with SMTP id hv7mr18393276obc.30.1395515156187;
 Sat, 22 Mar 2014 12:05:56 -0700 (PDT)
Received: by 10.182.226.163 with HTTP; Sat, 22 Mar 2014 12:05:56 -0700 (PDT)
In-Reply-To: <20140322154720.GA23863@www.outflux.net>
References: <20140322154720.GA23863@www.outflux.net>
Date:   Sat, 22 Mar 2014 13:05:56 -0600
X-Google-Sender-Auth: Q0N1F6Fu1NM1UfSUhI6mIPDO-Vo
Message-ID: <CAGXu5jL+o4dG+ruUDh-+5LY=iD0veWaimBUq3cJBtuCiNbYt1A@mail.gmail.com>
Subject: Re: [PATCH] mips: export icache_flush_range
From:   Kees Cook <keescook@chromium.org>
To:     Paul Gortmaker <paul.gortmaker@windriver.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Sanjay Lal <sanjayl@kymasys.com>,
        John Crispin <blogic@openwrt.org>, linux-mips@linux-mips.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <keescook@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39548
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

On Sat, Mar 22, 2014 at 9:47 AM, Kees Cook <keescook@chromium.org> wrote:
> The lkdtm module performs tests against executable memory ranges, so
> it needs to flush the icache for proper behaviors. Other architectures
> already export this, so do the same for MIPS.
>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
> This is currently untested! I'm building a MIPS cross-compiler now...
> If someone can validate this fixes the build when lkdtm is a module,
> that would be appreciated. :)

Okay, now tested. I reproduced the failure and this patch fixes it. :)

-Kees

> ---
>  arch/mips/mm/cache.c |    1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/mips/mm/cache.c b/arch/mips/mm/cache.c
> index fde7e56d13fe..b3f1df13d9f6 100644
> --- a/arch/mips/mm/cache.c
> +++ b/arch/mips/mm/cache.c
> @@ -38,6 +38,7 @@ void (*__flush_kernel_vmap_range)(unsigned long vaddr, int size);
>  void (*__invalidate_kernel_vmap_range)(unsigned long vaddr, int size);
>
>  EXPORT_SYMBOL_GPL(__flush_kernel_vmap_range);
> +EXPORT_SYMBOL_GPL(flush_icache_range);
>
>  /* MIPS specific cache operations */
>  void (*flush_cache_sigtramp)(unsigned long addr);
> --
> 1.7.9.5
>
>
> --
> Kees Cook
> Chrome OS Security



-- 
Kees Cook
Chrome OS Security

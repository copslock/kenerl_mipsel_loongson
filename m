Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 Nov 2011 13:18:20 +0100 (CET)
Received: from mail-ww0-f43.google.com ([74.125.82.43]:56476 "EHLO
        mail-ww0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1904606Ab1KXMSD convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 24 Nov 2011 13:18:03 +0100
Received: by wwo1 with SMTP id 1so3100695wwo.24
        for <multiple recipients>; Thu, 24 Nov 2011 04:17:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=Gx6VzsFPNHKf0kpSOBm86eXBSQMjZ9Lj+1J9fnlMTo8=;
        b=FD0xrJ7/vmGV0QFsdchWkXy4bxDKMpxYbPfkMnxgMxs1qxROgqvjwNosRQfphUxBDt
         p8wEWHglBSzgY31bLxPJKuZ8wEk5Su+spCYXXEZfI1Pbh7KpDnUMQyIKFMWEoELQnhxB
         5QEbfHRO9p7T6c/tdvMG/Db4b+RiQwHyhPiE0=
MIME-Version: 1.0
Received: by 10.227.57.66 with SMTP id b2mr18145409wbh.6.1322137078065; Thu,
 24 Nov 2011 04:17:58 -0800 (PST)
Received: by 10.216.69.74 with HTTP; Thu, 24 Nov 2011 04:17:57 -0800 (PST)
In-Reply-To: <1321990924-14189-1-git-send-email-ddaney.cavm@gmail.com>
References: <1321990924-14189-1-git-send-email-ddaney.cavm@gmail.com>
Date:   Thu, 24 Nov 2011 20:17:57 +0800
Message-ID: <CAJd=RBDwdJtxET8Um-aSO78zDwEcHYTZ8WPe_ROOGXPB3Nz2_Q@mail.gmail.com>
Subject: Re: [PATCH] MIPS: Add dummy definitions of HPAGE_SHIFT et al.
From:   Hillf Danton <dhillf@gmail.com>
To:     David Daney <ddaney.cavm@gmail.com>
Cc:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        David Daney <david.daney@cavium.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-archive-position: 31960
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dhillf@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 20794

On Wed, Nov 23, 2011 at 3:42 AM, David Daney <ddaney.cavm@gmail.com> wrote:
> From: David Daney <david.daney@cavium.com>
>
> In the case of !CONFIG_HUGETLB_PAGE we need dummy definitions of
> HPAGE_SHIFT, HPAGE_SIZE and HPAGE_MASK to be able to compile tlb-r4k.c
>
> Add these with a BUILD_BUG() to properly flag situations where they
> are improperly used.
>
> Also conditionally define BUILD_BUG(), as the definition for this may
> not have been merged by the time this patch is merged.  Once a
> BUILD_BUG() is defined in kernel.h, we can remove this one.
>
> Cc: Hillf Danton <dhillf@gmail.com>
> Signed-off-by: David Daney <david.daney@cavium.com>
> ---

Acked-by: Hillf Danton <dhillf@gmail.com>

>  arch/mips/include/asm/page.h |    8 ++++++++
>  1 files changed, 8 insertions(+), 0 deletions(-)
>
> diff --git a/arch/mips/include/asm/page.h b/arch/mips/include/asm/page.h
> index e59cd1a..d417909 100644
> --- a/arch/mips/include/asm/page.h
> +++ b/arch/mips/include/asm/page.h
> @@ -38,6 +38,14 @@
>  #define HPAGE_SIZE     (_AC(1,UL) << HPAGE_SHIFT)
>  #define HPAGE_MASK     (~(HPAGE_SIZE - 1))
>  #define HUGETLB_PAGE_ORDER     (HPAGE_SHIFT - PAGE_SHIFT)
> +#else /* !CONFIG_HUGETLB_PAGE */
> +# ifndef BUILD_BUG
> +#  define BUILD_BUG() do { extern void __build_bug(void); __build_bug(); } while (0)
> +# endif
> +#define HPAGE_SHIFT    ({BUILD_BUG(); 0; })
> +#define HPAGE_SIZE     ({BUILD_BUG(); 0; })
> +#define HPAGE_MASK     ({BUILD_BUG(); 0; })
> +#define HUGETLB_PAGE_ORDER     ({BUILD_BUG(); 0; })
>  #endif /* CONFIG_HUGETLB_PAGE */
>
>  #ifndef __ASSEMBLY__
> --
> 1.7.2.3
>
>

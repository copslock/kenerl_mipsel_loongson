Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 21 Nov 2011 23:23:54 +0100 (CET)
Received: from mail-yw0-f49.google.com ([209.85.213.49]:57791 "EHLO
        mail-yw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903805Ab1KUWXp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 21 Nov 2011 23:23:45 +0100
Received: by ywp31 with SMTP id 31so6183724ywp.36
        for <multiple recipients>; Mon, 21 Nov 2011 14:23:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=ooa0RU9Da+9Q651YpUnkZzpwv0/uJIgJZiDIcqS6d88=;
        b=Mf6JauAFFh8r8bgnxz927OTHB/jxEIzhEyoTQTL19f3aOCoJDsWlRbYDWoorpcC3u5
         /cTnt2A3cMToFxV5mgtDFv650PA+LGofSZM39tPxL0wieKRUaAll15v+W/R8Qr4LaUe2
         X//Tu4VLYmXdsD1Iu0inTb22hRYu6499mxh3Y=
Received: by 10.101.107.9 with SMTP id j9mr3549310anm.100.1321914218935;
        Mon, 21 Nov 2011 14:23:38 -0800 (PST)
Received: from dd1.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id 8sm996289anv.16.2011.11.21.14.23.37
        (version=SSLv3 cipher=OTHER);
        Mon, 21 Nov 2011 14:23:37 -0800 (PST)
Message-ID: <4ECACF68.3020701@gmail.com>
Date:   Mon, 21 Nov 2011 14:23:36 -0800
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.15) Gecko/20101027 Fedora/3.0.10-1.fc12 Thunderbird/3.0.10
MIME-Version: 1.0
To:     David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
CC:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>,
        linux-arch@vger.kernel.org, Robin Holt <holt@sgi.com>
Subject: Re: [patch] hugetlb: remove dummy definitions of HPAGE_MASK and HPAGE_SIZE
References: <1321567050-13197-1-git-send-email-ddaney.cavm@gmail.com> <alpine.DEB.2.00.1111171520130.20133@chino.kir.corp.google.com> <alpine.DEB.2.00.1111171522131.20133@chino.kir.corp.google.com>
In-Reply-To: <alpine.DEB.2.00.1111171522131.20133@chino.kir.corp.google.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-archive-position: 31900
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 17936

Linus,

It may not have been evident when you committed this (commit 
a5c86e986f0b2fe779f13cf53ce6e9f467b03950), but there was considerable 
discussion around this patch.

Andrew had taken into his tree a couple of patches to make the 
definitions that David Rientjes is removing safer:

http://marc.info/?l=linux-kernel&m=132156712623915&w=2
http://marc.info/?l=linux-kernel&m=132156712523914&w=2

David objected, but Andrew wasn't convinced, see all the replies to this 
patch but especially:

http://marc.info/?l=linux-kernel&m=132157428626522&w=2

On 11/17/2011 03:22 PM, David Rientjes wrote:
> Dummy, non-zero definitions for HPAGE_MASK and HPAGE_SIZE were added in
> 51c6f666fceb ("mm: ZAP_BLOCK causes redundant work") to avoid a divide
> by zero in generic kernel code.
>
> That code has since been removed, but probably should never have been
> added in the first place: we don't want HPAGE_SIZE to act like PAGE_SIZE
> for code that is working with hugepages, for example, when the dependency
> on CONFIG_HUGETLB_PAGE has not been fulfilled.
>
> Because hugepage size can differ from architecture to architecture, each
> is required to have their own definitions for both HPAGE_MASK and
> HPAGE_SIZE.  This is always done in arch/*/include/asm/page.h.
>
> So, just remove the dummy and dangerous definitions since they are no
> longer needed and reveals the correct dependencies.  Tested on
> architectures using the definitions with allyesconfig: x86 (even with
> thp), hppa, mips, powerpc, s390, sh3, sh4, sparc, and sparc64, and
> with defconfig on ia64.
>

This whole comment strikes me as somewhat dishonest, as at the time 
David Rientjes wrote it, he knew that there were dependencies on these 
symbols in the linux-next tree.

Now we can add these:
+#define HPAGE_SHIFT	({ BUG(); 0; })
+#define HPAGE_SIZE	({ BUG(); 0; })
+#define HPAGE_MASK	({ BUG(); 0; })

To the different architecture header files instead of having them in the 
common include/linux/hugetlb.h

If this is the way Linus wants it, I can live with that.  But it was a 
little surprising to see that this was merged when there were strong 
arguments against it.

David Daney

> Cc: Robin Holt<holt@sgi.com>
> Cc: David Daney<david.daney@cavium.com>
> Signed-off-by: David Rientjes<rientjes@google.com>
> ---
>   include/linux/hugetlb.h |    5 -----
>   1 files changed, 0 insertions(+), 5 deletions(-)
>
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -110,11 +110,6 @@ static inline void copy_huge_page(struct page *dst, struct page *src)
>
>   #define hugetlb_change_protection(vma, address, end, newprot)
>
> -#ifndef HPAGE_MASK
> -#define HPAGE_MASK	PAGE_MASK		/* Keep the compiler happy */
> -#define HPAGE_SIZE	PAGE_SIZE
> -#endif
> -
>   #endif /* !CONFIG_HUGETLB_PAGE */
>
>   #define HUGETLB_ANON_FILE "anon_hugepage"
>

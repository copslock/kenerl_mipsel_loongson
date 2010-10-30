Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 30 Oct 2010 10:01:09 +0200 (CEST)
Received: from mail-ww0-f41.google.com ([74.125.82.41]:61520 "EHLO
        mail-ww0-f41.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1490970Ab0J3IBG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 30 Oct 2010 10:01:06 +0200
Received: by wwe15 with SMTP id 15so3364938wwe.0
        for <linux-mips@linux-mips.org>; Sat, 30 Oct 2010 01:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=SpzZvanYR0dxKwYpKe8maGy55viI9X0sMlMYWl339eI=;
        b=FVboFJ8PfA35w00X7Pnw3DzZEtjXHsGAx03S+gxFkI7Kdq3Xyd2egAXnYGAvv5aYeV
         wBPmIIr9lDGYiuCMVZeM0W97zGkpUYvLpQ2NYTHW/qsi6YnxPlyuKzFf78g6qh3XTyI3
         fqnLC345UVc3CnEb/hMaoiA8JDLYA3rpRcMwE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=P9aKe2bf91wiFMcwsikdvQfTPZlV2sLWDf3X7a5qoI9KzU2P4oLB7zVM0M4ZOoeEaE
         9jg1z+vatoTVe/HlNHY5fqLjGcD+c0+hvnq15bV0fD+Mkkqj9kexaquVGUqR//thRyZ3
         4KYx/ZnKlXaVVv3OpiZAIaLxaKKcEjJkIaX9k=
MIME-Version: 1.0
Received: by 10.216.48.196 with SMTP id v46mr250089web.28.1288425660699; Sat,
 30 Oct 2010 01:01:00 -0700 (PDT)
Received: by 10.216.176.203 with HTTP; Sat, 30 Oct 2010 01:01:00 -0700 (PDT)
In-Reply-To: <4CCBC8B1.2080808@in.ibm.com>
References: <4CCBC8B1.2080808@in.ibm.com>
Date:   Sat, 30 Oct 2010 16:01:00 +0800
Message-ID: <AANLkTimE=uzwhDMz_-jVWKyb9NAONGuVvVo5KbjkkZVu@mail.gmail.com>
Subject: Re: [s390] 2.6.36-git14 build break - fs/compat.c :631
 (PAGE_CACHE_MASK undeclared)
From:   wu zhangjin <wuzhangjin@gmail.com>
To:     Sachin Sant <sachinp@in.ibm.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        linux-s390@vger.kernel.org, linux-mips <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28272
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

The same problem on MIPS.

Perhaps this can help:

$ git diff
diff --git a/fs/compat.c b/fs/compat.c
index ff66c0d..c580c32 100644
--- a/fs/compat.c
+++ b/fs/compat.c
@@ -49,6 +49,7 @@
 #include <linux/eventpoll.h>
 #include <linux/fs_struct.h>
 #include <linux/slab.h>
+#include <linux/pagemap.h>

 #include <asm/uaccess.h>
 #include <asm/mmu_context.h>

I'm not sure if this is a good fixup, because the problem is
introduced by MAX_RW_COUNT defined in include/linux/fs.h:

#define MAX_RW_COUNT (INT_MAX & PAGE_CACHE_MASK)

and the PAGE_CACHE_MASK is defined in pagemap.h, we may be possible to
add <linux/pagemap.h> in include/linux/fs.h but pagemap.h has included
<linux/fs.h> too ...

Regards,
Wu Zhangjin

On Sat, Oct 30, 2010 at 3:26 PM, Sachin Sant <sachinp@in.ibm.com> wrote:
> Latest 2.6.36 git [commit 44234d0c46...] fails to build on s390x with
> following error :
>
> fs/compat.c: In function compat_rw_copy_check_uvector:
> fs/compat.c:631: error: PAGE_CACHE_MASK undeclared (first use in this
> function)
> fs/compat.c:631: error: (Each undeclared identifier is reported only once
> fs/compat.c:631: error: for each function it appears in.)
> make[1]: *** [fs/compat.o] Error 1
>
> The code in question was added via following commit:
>
> commit 435f49a518c78eec8e2edbbadd912737246cbe20
> readv/writev: do the same MAX_RW_COUNT truncation that read/write does
>
> Thanks
> -Sachin

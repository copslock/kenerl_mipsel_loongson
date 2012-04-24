Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Apr 2012 01:32:03 +0200 (CEST)
Received: from mail-pz0-f48.google.com ([209.85.210.48]:45448 "EHLO
        mail-pz0-f48.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903767Ab2DXXbq (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 25 Apr 2012 01:31:46 +0200
Received: by dakb39 with SMTP id b39so1330779dak.35
        for <multiple recipients>; Tue, 24 Apr 2012 16:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=kELVyRqwRjlgVG6ZjD0R1eX3og9lUCp1VaOO465b7eQ=;
        b=I3PMmfZt7K8M01kgUUrc2ge5KAJzVZ+s+zJLNlfGhY6K5TUTREWtGmofTBaZ6p36y8
         nrk0tFkDBhtwJPVEgtSwrlyhlNc2c0J6C+ukcfReNALfVh2Ab13ukEY9sWyks4Qd02ue
         ZRanRzC1/CRImNz89uizrsN5NH05jEzn2Vol62NZUKtoqP3QZSy65GRi0MPBeF2v6mcP
         a54fby33JSQnCZx5nEMgcDz1fnmzubKhNV8kApq4nUsyt/b+YrdHKzORU7WLab57584p
         v5Eey4fBAe2/yH6z/7Kw/3HFor3+B8CQxo3/lk5F/iLQN0MwJTI5r1kllE0+fR4vPEqM
         VyNQ==
Received: by 10.68.75.45 with SMTP id z13mr2022030pbv.100.1335310299602;
        Tue, 24 Apr 2012 16:31:39 -0700 (PDT)
Received: from dd1.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id wi8sm18706829pbc.11.2012.04.24.16.31.38
        (version=SSLv3 cipher=OTHER);
        Tue, 24 Apr 2012 16:31:38 -0700 (PDT)
Message-ID: <4F9737D9.9080008@gmail.com>
Date:   Tue, 24 Apr 2012 16:31:37 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.15) Gecko/20101027 Fedora/3.0.10-1.fc12 Thunderbird/3.0.10
MIME-Version: 1.0
To:     Hillf Danton <dhillf@gmail.com>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mips@linux-mips.org
Subject: Re: [PATCH 2/3] MIPS: changes in mm for adding THP
References: <CAJd=RBBWia26FaPjn5-RvmAy9MBRtF0Bthkc0f7kxEWcFz6=oQ@mail.gmail.com>
In-Reply-To: <CAJd=RBBWia26FaPjn5-RvmAy9MBRtF0Bthkc0f7kxEWcFz6=oQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-archive-position: 33008
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On 11/26/2011 06:39 AM, Hillf Danton wrote:
> Based on the current work of huge TLB, no code is added for THP but info gcc
> to compile the huge TLB code for THP. That is the second factor why the present
> bit is selected.
>
> Signed-off-by: Hillf Danton<dhillf@gmail.com>
> ---
>
> --- a/arch/mips/include/asm/page.h	Thu Nov 24 21:17:10 2011
> +++ b/arch/mips/include/asm/page.h	Sat Nov 26 21:35:51 2011
> @@ -33,7 +33,7 @@
>   #define PAGE_SIZE	(_AC(1,UL)<<  PAGE_SHIFT)
>   #define PAGE_MASK       (~((1<<  PAGE_SHIFT) - 1))
>
> -#ifdef CONFIG_HUGETLB_PAGE
> +#if defined(CONFIG_HUGETLB_PAGE) || defined(CONFIG_TRANSPARENT_HUGEPAGE)

This exact sequence happens many times in the patch.

Can we define some symbol (perhaps in page.h) that is set for both of 
the conditions?

#if defined(CONFIG_HUGETLB_PAGE) || defined(CONFIG_TRANSPARENT_HUGEPAGE)
#define BRFL
#endif
.
.
.

#ifdef BRFL  /* everywhere else */

We of course wouldn't use the name BRFL, but rather something fitting.

With a change like that, I would like to retest the patches and try to 
get them merged.

David Daney

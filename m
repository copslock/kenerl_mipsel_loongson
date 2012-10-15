Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Oct 2012 22:51:54 +0200 (CEST)
Received: from mail-pa0-f49.google.com ([209.85.220.49]:51276 "EHLO
        mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6823041Ab2JOUvTi4l7T (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 15 Oct 2012 22:51:19 +0200
Received: by mail-pa0-f49.google.com with SMTP id bi5so5455954pad.36
        for <linux-mips@linux-mips.org>; Mon, 15 Oct 2012 13:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:x-x-sender:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version:content-type;
        bh=ZphSaKwJQTYoGuZJtvF1BDTKqVMwUGAEFRDtKMbmExM=;
        b=GYPwXvmqFjHwmrdeXlZJtrQDw3HpEJkL7eNBxyF2Fx59SODSddoJz2pK2B5+cHfU8J
         F90ptbkWbSN6wj1Yb4txmp/nSiAILZCsCL07jQAvmQ4FlITrZX5r2+oXaeXJVzzeSDNv
         5KhmgjJh0VpMScBKVPWz6Ia36VZvvZvtEYyhXHP3Ifp8uUB3sNC1hMfM9AXFzxjUFuJm
         6EPb9D54Q0A20xxgnOiOL9bR/KXIsHyGqDJV31rzJ4bvPQYlYeLVPY+9nJdyA8jWdtQc
         NJPamppcv8KPg3wZ41q+8M6VNWFj6uHOriaaLWUoWi2Ae1pI2gxRZUcBK+2V0cDAG6NP
         V1jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:x-x-sender:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version:content-type:x-gm-message-state;
        bh=ZphSaKwJQTYoGuZJtvF1BDTKqVMwUGAEFRDtKMbmExM=;
        b=K9zA4Xrxy/0AoKIY3Pltwxa8jkjxYPK/CW4CyZ3g/NP/UxXQ+7hwNpd8uOK/zRCCCI
         9VTwmb+IvTawNRWM7kZe6CbxxLsaVTaHkrI7B7op9MQ8P0MN1EbGPVUIwtE02WEpEBsq
         omzJfNU2ryg733nI3QrM/pHks7mAsGHv/FTlHdE+e0Xa7BAyIYgayQOpaCEi8vyJQZqm
         LM5fA+fSVXTlFBl5JSiflNhjT7tCsOl0HtnsfBHJPg2AyazXhsx7sQYkv5i6kRYwcepY
         fLjrOp0JxviFGrFMKIBqJwoKVzOoYKhTYbN5d3XPADTr02zjiWd9OsYqtToiCgg+rUsf
         goWg==
Received: by 10.68.131.40 with SMTP id oj8mr41348169pbb.40.1350334272976;
        Mon, 15 Oct 2012 13:51:12 -0700 (PDT)
Received: from [2620:0:1008:1101:be30:5bff:fed8:5e64] ([2620:0:1008:1101:be30:5bff:fed8:5e64])
        by mx.google.com with ESMTPS id o5sm9588113paz.32.2012.10.15.13.51.11
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 15 Oct 2012 13:51:12 -0700 (PDT)
Date:   Mon, 15 Oct 2012 13:51:10 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Ralf Baechle <ralf@linux-mips.org>
cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-mips@linux-mips.org, David Daney <david.daney@cavium.com>
Subject: Re: [PATCH] mm: huge_memory: Fix build error.
In-Reply-To: <20121015114456.GA30314@linux-mips.org>
Message-ID: <alpine.DEB.2.00.1210151349560.17947@chino.kir.corp.google.com>
References: <20121015114456.GA30314@linux-mips.org>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Gm-Message-State: ALoCoQlddEsB7OroqiTDThQjZu9ykuISU0IFalEHxhaN6AD3wmHdaFmA2FZWgk3SmzmKtx7aQCzprYRJZgP+hIiMtUokXUS0dNJ50ESVT52Utb5hhNzDNi2ZzhW7qjhEwyhPQ4n0s6OwClig15gqXkYhRDUFzA12kMZDRZqHlXPCiUVFDuHjoUsUfEFDHVinh2YdDWT/XXGnvmLuHDJY/gie5eVi/BP8Vw==
X-archive-position: 34705
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rientjes@google.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On Mon, 15 Oct 2012, Ralf Baechle wrote:

> Certain configurations won't implicitly pull in <linux/pagemap.h> resulting
> in the following build error:
> 
> mm/huge_memory.c: In function 'release_pte_page':
> mm/huge_memory.c:1697:2: error: implicit declaration of function 'unlock_page' [-Werror=implicit-function-declaration]
> mm/huge_memory.c: In function '__collapse_huge_page_isolate':
> mm/huge_memory.c:1757:3: error: implicit declaration of function 'trylock_page' [-Werror=implicit-function-declaration]
> cc1: some warnings being treated as errors
> 

This is because CONFIG_HUGETLB_PAGE=n so mempolicy.h doesn't include 
pagemap.h?

> Reported-by: David Daney <david.daney@cavium.com>
> Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

Acked-by: David Rientjes <rientjes@google.com>

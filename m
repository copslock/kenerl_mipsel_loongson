Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Sep 2018 04:34:35 +0200 (CEST)
Received: from mail-vk0-x244.google.com ([IPv6:2607:f8b0:400c:c05::244]:38263
        "EHLO mail-vk0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990475AbeIFCeboWxrg convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 6 Sep 2018 04:34:31 +0200
Received: by mail-vk0-x244.google.com with SMTP id h200-v6so3494777vke.5
        for <linux-mips@linux-mips.org>; Wed, 05 Sep 2018 19:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8GbrTSHm4Lsu+kJCxDeaCv1TtTTacTb81H9Kc/eTDp0=;
        b=vTLXTr4fC8fgQkLW5Sct4/hZIovSgg1d0neRS8hGoRgRfZS/tlb8K+8i3Xw32hblbt
         C4lcTRVOlKz2vBlPJVGEOOfshz0YsvxvCICvuy3q1PBdTNDJHAX/93kaEt8876fzg4b4
         SK4fZU5svelRQxgBRXOh6/ZfPp/o4YWR1xC20IKbB1IisRNs6UgN+9Jn/gfTzE4RPCv8
         RNwaNQ49LgzD+L8stF2xZA2RfNKqVFPltc8YTjygt3X6Kq9/lJPOIuEUpyus3AgIwu87
         Gfc0f7Qe356+NUawn9D9qZYGBg9X/jsDgxQ90kN/50hbjL9uzhXK8O1PZsa3IRLoBcev
         Y5Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8GbrTSHm4Lsu+kJCxDeaCv1TtTTacTb81H9Kc/eTDp0=;
        b=RwYoEdn9Rf/c//B6qfLJxu+RGSrBnHZQAJ8PXIIeTI39MMg+Y//7Qknr3zbhCp0/Mm
         v3kuaZzL8JgdCFFhzB4lvg/Vwai7N+dzTUUg3XjPexPvPjk9/0lYkshBUwfhCRGZ/yVN
         L+geeFs2lUIMPBttvdhhsXOBDx9YFGYEQPZYYnuqmyULkC0h1yTesivjJJVZ7isSKSHd
         cn17dPMuw4uwsxbf2yvfIAg5PDhHYZ2VJbtcODbxwUcmTfLQeOisQTKits7YjUSrTrYa
         vJWviXzB8BUQZrK+X+LFzeFF3bGtxHr3aaJH7Pv4o1rZ4d3I9u1WgnJ4t1Bco5l6CHjs
         M27w==
X-Gm-Message-State: APzg51A39p9boZGss7CaRUoHC0ZjtUcG16J54CIQJuSJ8v82NQlJxtX9
        tmBkheOjUHtof/2M/Ezb5WW26OHg8drrmsXTBag=
X-Google-Smtp-Source: ANB0Vdb8gvf/ZxS9AueOu1GlInJxPnckdmEb0TgyF7PbzKdJ8kWninxcZIqOjDuAdzlUvyI+i0lw7Pk4mbuCyNiR8KU=
X-Received: by 2002:a1f:f8c2:: with SMTP id w185-v6mr192338vkh.135.1536201265474;
 Wed, 05 Sep 2018 19:34:25 -0700 (PDT)
MIME-Version: 1.0
References: <1536163184-26356-1-git-send-email-rppt@linux.vnet.ibm.com>
In-Reply-To: <1536163184-26356-1-git-send-email-rppt@linux.vnet.ibm.com>
From:   Greentime Hu <green.hu@gmail.com>
Date:   Thu, 6 Sep 2018 10:33:48 +0800
Message-ID: <CAEbi=3dKL1zOYc0DC3yXm=7srw6tUfx-JR=o9n4pVrGp+Sosug@mail.gmail.com>
Subject: Re: [RFC PATCH 00/29] mm: remove bootmem allocator
To:     rppt@linux.vnet.ibm.com
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        David Miller <davem@davemloft.net>, gregkh@linuxfoundation.org,
        mingo@redhat.com, mpe@ellerman.id.au, mhocko@suse.com,
        paul.burton@mips.com, Thomas Gleixner <tglx@linutronix.de>,
        tony.luck@intel.com, linux-ia64@vger.kernel.org,
        linux-mips@linux-mips.org, linuxppc-dev@lists.ozlabs.org,
        sparclinux <sparclinux@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-Path: <green.hu@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66001
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: green.hu@gmail.com
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

Mike Rapoport <rppt@linux.vnet.ibm.com> 於 2018年9月6日 週四 上午12:04寫道：
>
> Hi,
>
> These patches switch early memory managment to use memblock directly
> without any bootmem compatibility wrappers. As the result both bootmem and
> nobootmem are removed.
>
> There are still a couple of things to sort out, the most important is the
> removal of bootmem usage in MIPS.
>
> Still, IMHO, the series is in sufficient state to post and get the early
> feedback.
>
> The patches are build-tested with defconfig for most architectures (I
> couldn't find a compiler for nds32 and unicore32) and boot-tested on x86
> VM.
>
Hi Mike,

There are nds32 toolchains.
https://mirrors.edge.kernel.org/pub/tools/crosstool/files/bin/x86_64/8.1.0/x86_64-gcc-8.1.0-nolibc-nds32le-linux.tar.gz
https://github.com/vincentzwc/prebuilt-nds32-toolchain/releases/download/20180521/nds32le-linux-glibc-v3-upstream.tar.gz

Sorry, we have no qemu yet.

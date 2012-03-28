Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Mar 2012 13:30:49 +0200 (CEST)
Received: from mail-bk0-f49.google.com ([209.85.214.49]:40342 "EHLO
        mail-bk0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903566Ab2C1Lao (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 28 Mar 2012 13:30:44 +0200
Received: by bkcjk13 with SMTP id jk13so1011826bkc.36
        for <linux-mips@linux-mips.org>; Wed, 28 Mar 2012 04:30:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding
         :x-gm-message-state;
        bh=85LdmA9jkDNuGTeXX+jqsOLfin+/HXAyUD0Pne9loVc=;
        b=XK1MhoGoM9B01C4lwrp8gtTxnJBSs/J0weorlptWTQWZJN79pR3SLo7wHR7gIY7pm3
         sr1q3aFIKdvdLe4XB/d3VvOg2kvhNaKVIpY8N1Z+KgWadPO1m/gR2hglarq9LYTR8VcB
         sDovk0Tsqv5xJitQKfFv7AKnsKzcbd7a2X3I/Vojym4I9Mp5A6BE3IKQ0hUBJAEJfDlU
         rSeMMhmD4WZUBDduHgqOKhU9nXbs2e0nP3BTT0kmLNqFplJp/cTzhhINkdUG9alXhQ7I
         KGqtp4L7tRS3PWQ3JbLdnnNgZfqhKdy4ZN+gCtrEOE0zWGDLZf6g5AfDh6Nm5uu8rddw
         GWGw==
Received: by 10.204.143.151 with SMTP id v23mr12009163bku.63.1332934236860;
        Wed, 28 Mar 2012 04:30:36 -0700 (PDT)
Received: from [192.168.2.2] (ppp91-79-105-46.pppoe.mtu-net.ru. [91.79.105.46])
        by mx.google.com with ESMTPS id c4sm5927046bkh.0.2012.03.28.04.30.31
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 28 Mar 2012 04:30:34 -0700 (PDT)
Message-ID: <4F72F603.2000803@mvista.com>
Date:   Wed, 28 Mar 2012 15:29:07 +0400
From:   Sergei Shtylyov <sshtylyov@mvista.com>
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:11.0) Gecko/20120312 Thunderbird/11.0
MIME-Version: 1.0
To:     Marek Szyprowski <m.szyprowski@samsung.com>
CC:     linux-kernel@vger.kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>,
        microblaze-uclinux@itee.uq.edu.au, linux-arch@vger.kernel.org,
        x86@kernel.org, linux-sh@vger.kernel.org,
        linux-alpha@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-ia64@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-mips@linux-mips.org, discuss@x86-64.org,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linaro-mm-sig@lists.linaro.org, Jonathan Corbet <corbet@lwn.net>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Andrzej Pietrasiewicz <andrzej.p@samsung.com>,
        Kevin Cernekee <cernekee@gmail.com>,
        Dezhong Diao <dediao@cisco.com>,
        Richard Kuo <rkuo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        Michal Simek <monstr@monstr.eu>,
        Guan Xuetao <gxt@mprc.pku.edu.cn>,
        Paul Mundt <lethal@linux-sh.org>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>
Subject: Re: [PATCHv2 01/14] common: dma-mapping: introduce alloc_attrs and
 free_attrs methods
References: <1332855768-32583-1-git-send-email-m.szyprowski@samsung.com> <1332855768-32583-2-git-send-email-m.szyprowski@samsung.com>
In-Reply-To: <1332855768-32583-2-git-send-email-m.szyprowski@samsung.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Gm-Message-State: ALoCoQmF4QSFC/uVMqzcbBytffj9Y2DYGq2N8NRYNwfLDeIacTA+CpxZsoIPhRdxzQ9IxpEJpBpx
X-archive-position: 32802
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@mvista.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Hello.

On 27-03-2012 17:42, Marek Szyprowski wrote:

> Introduce new generic alloc and free methods with attributes argument.

    The method names don't match the ones in the subject.

> Existing alloc_coherent and free_coherent can be implemented on top of the
> new calls with NULL attributes argument. Later also dma_alloc_non_coherent
> can be implemented using DMA_ATTR_NONCOHERENT attribute as well as
> dma_alloc_writecombine with separate DMA_ATTR_WRITECOMBINE attribute.

> This way the drivers will get more generic, platform independent way of
> allocating dma buffers with specific parameters.

> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
> Reviewed-by: David Gibson <david@gibson.dropbear.ud.au>
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>

WBR, Sergei

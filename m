Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Sep 2013 04:35:44 +0200 (CEST)
Received: from mail-pa0-f47.google.com ([209.85.220.47]:38991 "EHLO
        mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6816671Ab3IYCfimWmRA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 25 Sep 2013 04:35:38 +0200
Received: by mail-pa0-f47.google.com with SMTP id kp14so4504699pab.6
        for <linux-mips@linux-mips.org>; Tue, 24 Sep 2013 19:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version:content-type;
        bh=AhflUEd4YT8qJdlAS8DSYq4IC/dr4FSlchlZ3tb6ldw=;
        b=RbdkPbdLpj7mejCl2MpD0HF1IVMoXe+PrvcOGFINh3MXPS8agosplQchRTBuq3vQuQ
         vaPwCRmKT6UuTYSdjR2Gn2hqnEsMAyFKY4tWxLlU0Vq7TiLiivOynW2z07PuDRjLiSQ3
         4B+Z7YBQ5cFz0LBRW17/9ZAl1iSZ+w7ZklRit6nspnLTQlv7Je3So07UEcAnPM/MGLoK
         26HTENtnV1d62FC0krDz2u8PK2zMdAhHM6iDIecpnM7w0aiEGxhfUFZzYwze2XR9XqcZ
         rQPif1uMFeiWjijk8Hg60wxy3k+/3rTnl2QbO7MUbxQzW89pILxHGKT4zuHaIKNNAAj7
         7YOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version:content-type;
        bh=AhflUEd4YT8qJdlAS8DSYq4IC/dr4FSlchlZ3tb6ldw=;
        b=Mpo3Ej/ZOUNiRWKlD0H8U1g8jt0xlBdHvyy+LGKKJdIXdnqVo3TSQ39Vq1bYcaVPxY
         HTgthXr/8q7enQ/vwKRWMVBliez208grTGnoE++M1rfRaxAWbNIxNN+lXMp1/QFlMBGk
         wQfSuXrfH2PKxX+v6Ey7snhKq5x+yhgX8uehX5TDkA5tim9S1Yll3ilOxO6y58ZSQwvc
         LKUJgskVxTwBCqsYNvTEwz1teF0UpENM40/j58dUurlNUkcAP0XxGBy9q8KoKg82+xX3
         g1+G+BrkauzlF9mg0m1+pFhQYhgM2i6uxtOolp7C9Tf4YHz22IYhdJeReJg6Pl1+zeh9
         s2cw==
X-Gm-Message-State: ALoCoQm2jOXTOReM97tXo0M4Si9PX19LTjOphNBOVZOCptyOG+voNWHoCBuYaIo8IS3JzNkb00oVo2W/DtIHPwH57DKhHYC1Ge/haKDdgVedZPts01NLJiwXeps3skY8e1h7h9f7z/xZWVF77RMU6ZjhAaTk+k0ext2BZsbjLPq/YZW/zr9GrUkcy2jrma0QL77VWUB7z5Jfsj/JArUEPX1O+4/NzJeEOA==
X-Received: by 10.66.226.46 with SMTP id rp14mr14532974pac.133.1380076531826;
        Tue, 24 Sep 2013 19:35:31 -0700 (PDT)
Received: from [2620:0:1008:1101:be30:5bff:fed8:5e64] ([2620:0:1008:1101:be30:5bff:fed8:5e64])
        by mx.google.com with ESMTPSA id kd1sm49345619pab.20.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 24 Sep 2013 19:35:31 -0700 (PDT)
Date:   Tue, 24 Sep 2013 19:35:29 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Jianguo Wu <wujianguo@huawei.com>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mips@linux-mips.org, linux-parisc@vger.kernel.org,
        linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
        x86@kernel.org
Subject: Re: [Resend with ACK][PATCH] mm/arch: use NUMA_NODE
In-Reply-To: <524019D0.9070706@huawei.com>
Message-ID: <alpine.DEB.2.02.1309241935190.26187@chino.kir.corp.google.com>
References: <524019D0.9070706@huawei.com>
User-Agent: Alpine 2.02 (DEB 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <rientjes@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37951
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

On Mon, 23 Sep 2013, Jianguo Wu wrote:

> Use more appropriate NUMA_NO_NODE instead of -1 in all archs' module_alloc()
> 
> Signed-off-by: Jianguo Wu <wujianguo@huawei.com>
> Acked-by: Ralf Baechle <ralf@linux-mips.org>

Acked-by: David Rientjes <rientjes@google.com>

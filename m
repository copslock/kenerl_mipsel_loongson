Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 23 Jun 2012 02:47:12 +0200 (CEST)
Received: from mail-lb0-f177.google.com ([209.85.217.177]:34407 "EHLO
        mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903669Ab2FWArE convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 23 Jun 2012 02:47:04 +0200
Received: by lbbgg6 with SMTP id gg6so4350088lbb.36
        for <multiple recipients>; Fri, 22 Jun 2012 17:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=8vDBEz6v5guEyXwFctK2D+LkgFp35tO0GHorwBKcHwQ=;
        b=nTNJPcXmUwOsDVQqQ6X2PyG+/2rr8oDTZK1v+t7y644igPBGHYu2B2oiD/TPLqwxH9
         zAz8hzxbaDnoOALg1oKn8lagNGOFYNEZE2Gumt0WaOBKkm6nxgiFNyfMhWzqoFh1mYqr
         ndrPFkYLK/11pOKfbOf1u2LJaTL7qV5fc1V7VZZ3ZLgEwiiKHaVr8w3wOMnIZqoZognF
         4BRVme3TGBtHBbpk5WphbKn/n1ye9dY5k/GVTMbz29nHdqFa9HE6suGUlYAFEIoGl8yN
         TsteOG7sRGQ+oSV3xC7RvZSVq+DQsFZlc3R1Kne5UuMl0zw5ZqG9BP9JuhOKn0JxWQ9Z
         BscA==
MIME-Version: 1.0
Received: by 10.152.122.9 with SMTP id lo9mr3922438lab.41.1340412419082; Fri,
 22 Jun 2012 17:46:59 -0700 (PDT)
Received: by 10.152.5.103 with HTTP; Fri, 22 Jun 2012 17:46:59 -0700 (PDT)
In-Reply-To: <20120622111131.GB18249@linux-mips.org>
References: <1340334073-17804-1-git-send-email-chenhc@lemote.com>
        <1340334073-17804-12-git-send-email-chenhc@lemote.com>
        <87txy3sn20.fsf@lebrac.rtp-net.org>
        <CAAhV-H5q5G87UMn0ixPUVZNcEV1b_qBHJKVKmCJsmzKdEB--4A@mail.gmail.com>
        <20120622111131.GB18249@linux-mips.org>
Date:   Sat, 23 Jun 2012 08:46:59 +0800
Message-ID: <CAAhV-H6nbB_QNC9Qm0AwgNeUyWK7iRQmKQRLNXiEjHR1Zdyejw@mail.gmail.com>
Subject: Re: [PATCH V3 11/16] drm/radeon: Make radeon card usable for Loongson.
From:   Huacai Chen <chenhuacai@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Arnaud Patard <arnaud.patard@rtp-net.org>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>,
        Hongliang Tao <taohl@lemote.com>, Hua Yan <yanh@lemote.com>,
        dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-archive-position: 33788
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chenhuacai@gmail.com
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

On Fri, Jun 22, 2012 at 7:11 PM, Ralf Baechle <ralf@linux-mips.org> wrote:
> On Fri, Jun 22, 2012 at 06:55:40PM +0800, Huacai Chen wrote:
>
>> > btw, would it be a good idea to use uncached accelerated instead ?
>> I have tried uncached accelerated, there will be random points in the
>> monitor, it seems a hw issue...
>
> Have you flushed the pages from memory before switching their cache mode
> to uncached accelerated?  The MIPS architecture defines the result of
> mixing cache modes as UNPREDICTABLE so be careful to flush caches before
> switching cache mode of a page.
Not because of flushing, CPU designing team told us a method but very
complex, and that method will cause other performance drop. So, we
won't use uncached accelerate mode.
>
>  Ralf

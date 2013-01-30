Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 30 Jan 2013 12:47:26 +0100 (CET)
Received: from mail-ob0-f179.google.com ([209.85.214.179]:54711 "EHLO
        mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6818018Ab3A3LrZuzcvF convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 30 Jan 2013 12:47:25 +0100
Received: by mail-ob0-f179.google.com with SMTP id un3so1493557obb.24
        for <linux-mips@linux-mips.org>; Wed, 30 Jan 2013 03:47:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:content-type:content-transfer-encoding;
        bh=rAXCAA2JHZfj+v3E4mNd+SUCKjpQfIGloWVU8qQUDho=;
        b=oJvq2ajomS4G1N19JOrAhFKAYrpZX5RRWpilfC3wtuBOJjP1MfvC2hSsYnVmrxvxy5
         JkaxJRPpE2HFFbsp+hYS/MdKVDhE99gG0Yazm+JGzlnu7hQAZL1dCBe4lVA3kw/ty6yZ
         TdKOd6z3DwDS3tGe/+1rCoTSbaWpcxKafJAxefc6GHJw0APjHBpL+OIPROCOYaqFOzrx
         KjuRkwrj2DRfZVkxazZalvkcZ6p7X4tC0uwG+cjaxQfIo27YDeOBwEgBFiY8mxh8cQO7
         kSYtZMGp8fxQ9F2Bp9eJQby1MBEgcTNC2DBVPChQgy6WgQWIEsM5Vz3m2WDmzLtlDROr
         kU+w==
MIME-Version: 1.0
X-Received: by 10.60.30.231 with SMTP id v7mr3260165oeh.22.1359540192660; Wed,
 30 Jan 2013 02:03:12 -0800 (PST)
Received: by 10.76.109.197 with HTTP; Wed, 30 Jan 2013 02:03:12 -0800 (PST)
In-Reply-To: <CACna6ryTefwz2McxQOaafwsGJJA7Kf46TYAP+BqGLxirYrEP7A@mail.gmail.com>
References: <CACna6ryTefwz2McxQOaafwsGJJA7Kf46TYAP+BqGLxirYrEP7A@mail.gmail.com>
Date:   Wed, 30 Jan 2013 11:03:12 +0100
Message-ID: <CACna6rxRDreFEVMMrrHtMg+NB5mtzCuOQeppq7=qFKRHRvPGmQ@mail.gmail.com>
Subject: Re: Distincting very similar CPUs in cpu-probe.c
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
To:     linux-mips@linux-mips.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-archive-position: 35625
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zajec5@gmail.com
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

2013/1/30 Rafał Miłecki <zajec5@gmail.com>:
> I can see current code in cpu-probe.c handles some (very slightly)
> different CPUs in the same way:
>
> case PRID_IMP_24K:
> case PRID_IMP_24KE:
>         c->cputype = CPU_24K;
>         __cpu_name[cpu] = "MIPS 24Kc";
>         break;
>
> There is almost nothing wrong about this, but setting the same name is
> a little confusing for users. I wish to see different names in
> /proc/cpuinfo for PRID_IMP_24K==24Kc and PRID_IMP_24KE==24KEc.
>
> Is there a preferred way of handling this? The simplest one seems to
> be using separated "cases" while still using CPU_24K:
> case PRID_IMP_24K:
>         c->cputype = CPU_24K;
>         __cpu_name[cpu] = "MIPS 24Kc";
>         break;
> case PRID_IMP_24KE:
>         c->cputype = CPU_24K;
>         __cpu_name[cpu] = "MIPS 24KEc";
>         break;
>
> What do you think about this? Is this acceptable?
>
> For some reason I'm not aware of you may prefer adding CPU_24KE at the
> same time. Does it make any sense?

Yet another option would be to use
__cpu_name[cpu] = "MIPS 24Kc / MIPS 24KEc";

User still won't know which CPU he has, but at least we won't make
aware MIPS 24KEc owners confused.

-- 
Rafał

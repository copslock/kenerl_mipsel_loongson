Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 Dec 2017 10:01:02 +0100 (CET)
Received: from mail-it0-x242.google.com ([IPv6:2607:f8b0:4001:c0b::242]:36733
        "EHLO mail-it0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990436AbdLHJAzCp0Cb (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 8 Dec 2017 10:00:55 +0100
Received: by mail-it0-x242.google.com with SMTP id d16so3382099itj.1;
        Fri, 08 Dec 2017 01:00:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=KxDuJ5sn1MJJg67AjOYxyEANW4HDk4OjvU/U77NB870=;
        b=vUpBfrn7aK3sNRbaVyNuUlh6fIZDOKhQLDtOKe+Wha0S6NJmhjmR/uhCwqcOJEDpmT
         SvvjYhsT1veLg/8VMlIPjFqjeTl27stxRzxzG6nUE9LttymLkIh7x7ppRiDsX21qPEGG
         k7D6Us2zaP10ib0T3emsTPEf7fp0KdWBZ9k19kGcKJU3/QB5XXmN6tZHnsplOe9LaCWg
         6Bt/rNKnFXYNZo6tQibLHcXqwihPm4f/emq6glQBkbIja2ujh8bkcjQdm4E2Szmsd/m4
         M0k4POEXJpBhXPznXBvawx7PR5R46v0BRon8fC8MG/vA0HcqUbdxxF2tXW3Y/pSS0I8N
         s9lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=KxDuJ5sn1MJJg67AjOYxyEANW4HDk4OjvU/U77NB870=;
        b=jPIo6FdPSEZsDsg9qMd7tjgJxgoBA8Tam/bc/iqKUn+v2HGWJ7QK1PqjLsZOWDbax7
         XTEldX3WiZidixnbt/dillEcp0ndLbSAaMukde7bYP7oidsFv3pqsgeEsLftM7j0MSjq
         0E+I5K7GBIb0bmBRiXNeeJ6lt9Vt114BQahhcTMHIl1UBtwAwQ+nWv17YpXgeUO8RWBc
         J7QBXmGi4GZWIIcYI0NXy1Sug2yIISPuEdWQUmJJDVrCdSWI9JwlKrjluhbLAkcc1beP
         NP4bWSlllEj0uqbyN7rVM7ubL8z1d0TqZ+NiIzejNavv8SRHsmn1M9Y9w+FOtOd3aqB8
         Ealg==
X-Gm-Message-State: AKGB3mKfQKgspq9CADKFlIfcgUQ/IZQKVn6aI68zNV+I5D9c2JdgWBeT
        YbAV7vtbbTHdfKN0URi0QtaGvMJ2EFOqcxP9BMI=
X-Google-Smtp-Source: AGs4zMZ8q1XHqGALWs7fj/EySh1zcPRS6GHjQJ4ji2Z9J9+c02MZM5VuOHwuBIJDjDDtB9sRlPj8ZTw2F+Oi0ObzOmo=
X-Received: by 10.36.219.214 with SMTP id c205mr4716092itg.65.1512723647363;
 Fri, 08 Dec 2017 01:00:47 -0800 (PST)
MIME-Version: 1.0
Received: by 10.107.28.131 with HTTP; Fri, 8 Dec 2017 01:00:46 -0800 (PST)
In-Reply-To: <20171208075134.GP5027@jhogan-linux.mipstec.com>
References: <1512628268-18357-1-git-send-email-chenhc@lemote.com>
 <20171207065759.GC19722@kroah.com> <20171207110549.GM27409@jhogan-linux.mipstec.com>
 <1512652210.13996.10.camel@flygoat.com> <20171207141829.GN27409@jhogan-linux.mipstec.com>
 <1512705706.1756.12.camel@flygoat.com> <20171208075134.GP5027@jhogan-linux.mipstec.com>
From:   Huacai Chen <chenhc@lemote.com>
Date:   Fri, 8 Dec 2017 17:00:46 +0800
X-Google-Sender-Auth: t4OK3LNxAMsRNchtIGSZ4OfrkRE
Message-ID: <CAAhV-H6JPqHvQFRq6XdgZfnSveSJM3OCNi9v0ZNVfpmy2CgT=A@mail.gmail.com>
Subject: Re: [PATCH 0/1] About MIPS/Loongson maintainance
To:     James Hogan <james.hogan@mips.com>
Cc:     Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Ralf Baechle <ralf@linux-mips.org>,
        Rui Wang <wangr@lemote.com>, Binbin Zhou <zhoubb@lemote.com>,
        Ce Sun <sunc@lemote.com>, Yao Wang <wangyao@lemote.com>,
        Liangliang Huang <huangll@lemote.com>,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        =?UTF-8?B?546L6ZSQ?= <r@hev.cc>,
        Aaron Chou <zhoubb.aaron@gmail.com>, huanglllzu@163.com,
        513434146@qq.com, David king <1393699660@qq.com>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61355
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chenhc@lemote.com
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

Hi, James,

Of course we don't want to send PR directly, if there is a better way.
So, I hope you can officially be a co-maintainer of linux-mips, and as
a result, our community will become more active. I think most of MIPS
developers have the same will as me.

Huacai

On Fri, Dec 8, 2017 at 3:51 PM, James Hogan <james.hogan@mips.com> wrote:
> On Fri, Dec 08, 2017 at 12:01:46PM +0800, Jiaxun Yang wrote:
>> Also we're going to separate code between
>> Loongson2 and Loongson3 since they are becoming more and more
>> identical.
>
> Do you mean you want to combine them?
>
>> But It will cause a lot of changes under march of loongson64
>>  that currently maintaining by linux-mips community. Send plenty of
>> patches to mailing list would not be a wise way to do that. So we can
>> PR these changes to linux-next directly and PR to linux-mips before
>> merge window.
>
> For the avoidance of doubt, a pull request would not excempt you from
> needing your patches properly reviewed on the mailing lists first.
>
> And quoting Stephen's boilerplate response to linux-next additions:
>> Thanks for adding your subsystem tree as a participant of linux-next.  As
>> you may know, this is not a judgement of your code.  The purpose of
>> linux-next is for integration testing and to lower the impact of
>> conflicts between subsystems in the next merge window.
>>
>> You will need to ensure that the patches/commits in your tree/series have
>> been:
>>      * submitted under GPL v2 (or later) and include the Contributor's
>>         Signed-off-by,
>>      * posted to the relevant mailing list,
>>      * reviewed by you (or another maintainer of your subsystem tree),
>>      * successfully unit tested, and
>>      * destined for the current or next Linux merge window.
>>
>> Basically, this should be just what you would send to Linus (or ask him
>> to fetch).  It is allowed to be rebased if you deem it necessary.
>
> Cheers
> James

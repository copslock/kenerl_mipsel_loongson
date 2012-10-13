Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 13 Oct 2012 08:28:06 +0200 (CEST)
Received: from [124.207.24.138] ([124.207.24.138]:33067 "EHLO
        mail.ss.pku.edu.cn" rhost-flags-FAIL-FAIL-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6817053Ab2JMG2BJXzde (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 13 Oct 2012 08:28:01 +0200
Received: from mail-lb0-f177.google.com (mail-lb0-f177.google.com [209.85.217.177])
        (Authenticated sender: mlin@ss.pku.edu.cn)
        by mail.ss.pku.edu.cn (Postfix) with ESMTPA id 742AFDBC25
        for <linux-mips@linux-mips.org>; Sat, 13 Oct 2012 14:27:51 +0800 (CST)
Received: by mail-lb0-f177.google.com with SMTP id gi11so2412475lbb.36
        for <linux-mips@linux-mips.org>; Fri, 12 Oct 2012 23:27:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.112.45.231 with SMTP id q7mr2371902lbm.133.1350109667474; Fri,
 12 Oct 2012 23:27:47 -0700 (PDT)
Received: by 10.114.74.171 with HTTP; Fri, 12 Oct 2012 23:27:47 -0700 (PDT)
In-Reply-To: <CAMmEz3TzA-ndXpeEeWOgt81KK-68Qmne7WMt6fqYaaALh32r0w@mail.gmail.com>
References: <CAF1ivSYqNpzZD5U6Ne_FL_gDmPC0aETb7Gt3uyWZzNp9tTMP5Q@mail.gmail.com>
        <20120828081353.GB23288@linux-mips.org>
        <CAF1ivSbCYW3Dfs7Ej=XdAhdk5Xc+enoY-wKmwZSZ4bJ+HmPa8g@mail.gmail.com>
        <CAMmEz3TzA-ndXpeEeWOgt81KK-68Qmne7WMt6fqYaaALh32r0w@mail.gmail.com>
Date:   Sat, 13 Oct 2012 14:27:47 +0800
Message-ID: <CAF1ivSYqNO6ofT_Eum4eedtTUvQ9Q_eiFtz4p6bcgNVd46QfVg@mail.gmail.com>
Subject: Re: panic in hrtimer_run_queues
From:   Lin Ming <mlin@ss.pku.edu.cn>
To:     Noor <noor.mubeen@gmail.com>
Cc:     linux-mips@linux-mips.org
Content-Type: text/plain; charset=ISO-8859-1
X-archive-position: 34692
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mlin@ss.pku.edu.cn
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

On Sat, Oct 13, 2012 at 1:07 PM, Noor <noor.mubeen@gmail.com> wrote:
>>> On Tue, Aug 28, 2012 at 09:42:51AM +0800, Lin Ming wrote:
>> fn = timer->function;
>> restart = fn(timer);   <---- line 1164
>>
>> Seems "fn" is corrupted....
>
> was this root cause identifed ?

I didn't identify the root cause.

This bug disappears with a fix in some network driver.

But I can't explain why ....

>
> Noor

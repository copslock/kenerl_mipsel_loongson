Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 May 2014 18:10:18 +0200 (CEST)
Received: from mail.lemote.com ([222.92.8.138]:56188 "EHLO mail.lemote.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6822677AbaESQKOL20uX (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 19 May 2014 18:10:14 +0200
Received: from localhost (localhost [127.0.0.1])
        by mail.lemote.com (Postfix) with ESMTP id F31F42273C
        for <linux-mips@linux-mips.org>; Mon, 19 May 2014 23:40:11 +0800 (CST)
X-Virus-Scanned: Debian amavisd-new at lemote.com
Received: from mail.lemote.com ([127.0.0.1])
        by localhost (mail.lemote.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 9QVyhAZuhXCM for <linux-mips@linux-mips.org>;
        Mon, 19 May 2014 23:40:11 +0800 (CST)
Received: from mail-lb0-f171.google.com (mail-lb0-f171.google.com [209.85.217.171])
        (Authenticated sender: chenj@lemote.com)
        by mail.lemote.com (Postfix) with ESMTPSA id 855B121D30
        for <linux-mips@linux-mips.org>; Mon, 19 May 2014 23:40:10 +0800 (CST)
Received: by mail-lb0-f171.google.com with SMTP id 10so4164141lbg.2
        for <linux-mips@linux-mips.org>; Mon, 19 May 2014 08:40:06 -0700 (PDT)
X-Received: by 10.112.137.39 with SMTP id qf7mr25435914lbb.18.1400513594997;
 Mon, 19 May 2014 08:33:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.114.176.137 with HTTP; Mon, 19 May 2014 08:32:54 -0700 (PDT)
In-Reply-To: <1818781.bbVdBBlkH9@radagast>
References: <1400137743-8806-1-git-send-email-chenj@lemote.com>
 <1400469247-17788-1-git-send-email-chenj@lemote.com> <1818781.bbVdBBlkH9@radagast>
From:   Chen Jie <chenj@lemote.com>
Date:   Mon, 19 May 2014 23:32:54 +0800
Message-ID: <CAGXxSxUBej1hTzDWmf1tz=vST1Z1gXvzagO3B+4wWhuVX4Q5_w@mail.gmail.com>
Subject: Re: [PATCH, v2] MIPS: lib: csum_partial: more instruction paral
To:     James Hogan <james.hogan@imgtec.com>
Cc:     linux-mips@linux-mips.org, markos.chandras@imgtec.com,
        =?UTF-8?B?6ZmI5Y2O5omN?= <chenhc@lemote.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <chenj@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40139
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chenj@lemote.com
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

2014-05-19 14:59 GMT+08:00 James Hogan <james.hogan@imgtec.com>:
> On Monday 19 May 2014 11:14:07 chenj wrote:
>> Computing sum introduces true data dependency, e.g.
>>       ADDC(sum, t0)
>>       ADDC(sum, t1)
>>       ADDC(sum, t2)
>>       ADDC(sum, t3)
>> Here, each ADDC(sum, ...) references the sum value updated by previous ADDC.
>>
>> In this patch, above sequence is adjusted as following:
>>       ADDC(t0, t1)
>>       ADDC(t2, t3)
>>       ADDC(sum, t0)
>>       ADDC(sum, t2)
>> The first two ADDC operations are independent, hence can be executed
>> simultaneously if possible.
>
> The actual patch appears to change it to this:
> ADDC(t0, t1)
> ADDC(sum, t0)
> ADDC(t2, t3)
> ADDC(sum, t2)
>
> which is slightly different (presumably due to the interleaved stores in some
> of the cases).
>
>> This patch improves instruction level parallelism, and brings at most 50%
>> csum performance gain on Loongson 3a processor[1].
>
> Nice results.
>
> The stuff below the --- will get dropped when the patch is applied though,
> after which the "[1]" won't refer to anything.
>
Thanks for your suggestion, I'll amend the commit message further later.

Basically, the patch reduces the case of one ADDC depending on the
result of the previous ADDC.

BTW, I'm not sure whether the sum value of the new implementation is
equivalent to the original one, but in my test(make run_test of the
csum_test.tar.gz, and a comparing patch in kernel) it is.

Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 31 Mar 2015 10:35:08 +0200 (CEST)
Received: from mail-ig0-f175.google.com ([209.85.213.175]:35996 "EHLO
        mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008592AbbCaIfGIwguf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 31 Mar 2015 10:35:06 +0200
Received: by igbud6 with SMTP id ud6so12141777igb.1;
        Tue, 31 Mar 2015 01:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=QMyP2N2k1TKi8TqbGjYYesFnPQprygNCY4wX3sHJJ4Q=;
        b=auxg481g5Q+lJ9BCNtfYSHArHAZCkBXQtfn67y0QV2j3FEJxbGU37Tr9IIZC1d/M8S
         51gsv9VYlh8QMPjqHB/BZNdBZ9VXqhkVikOPIL+tSoLTSQPkgYOGj4P1BviAlOFNd/Tl
         A+Bln0lEWm2JrAC+voEYtRmuTv+VWF3jMMSIcJLhSkZU6XmWihXAcFFizRmMvSLPToDS
         nNfmBL5UzzyJtptifEvJEt7v+Die7cePffnaFw6FppMvc1hfIy547B6nU4lCAYcUFQ7v
         aclQTZ/Jnzk4qpHx35hQUlwWVmG7yqG/iQWk/PBMz+AS5iBQA4+uR9ajAS28DcUkgZU5
         Uz/w==
X-Received: by 10.50.143.36 with SMTP id sb4mr2566986igb.0.1427790899592; Tue,
 31 Mar 2015 01:34:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.50.239.38 with HTTP; Tue, 31 Mar 2015 01:34:39 -0700 (PDT)
In-Reply-To: <20150330201015.GA3757@linux-mips.org>
References: <1427389644-92793-1-git-send-email-fykcee1@gmail.com> <20150330201015.GA3757@linux-mips.org>
From:   cee1 <fykcee1@gmail.com>
Date:   Tue, 31 Mar 2015 16:34:39 +0800
Message-ID: <CAGXxSxU_fCvUqkrFDU64MOgsyOW3XkcrSuB7DjcBMODG-B8=xw@mail.gmail.com>
Subject: Re: [v5] MIPS: lib: csum_partial: more instruction paral
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Chen Jie <chenj@lemote.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <fykcee1@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46640
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: fykcee1@gmail.com
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

2015-03-31 4:10 GMT+08:00 Ralf Baechle <ralf@linux-mips.org>:
>> One example about how this patch works is in CSUM_BIGCHUNK1:
>> // ** original **    vs    ** patch applied **
>>     ADDC(sum, t0)           ADDC(t0, t1)
>>     ADDC(sum, t1)           ADDC(t2, t3)
>>     ADDC(sum, t2)           ADDC(sum, t0)
>>     ADDC(sum, t3)           ADDC(sum, t2)
>>
>> With this patch applied, ADDC and the **next next** ADDC are independent.
>
> This is interesting because even CPUs as old as the R2000 have a pipeline
> bypass which allows an instruction to use a result written to a register
> by an immediately preceeeding instruction.

But if removes some dependency(as the patch did), instruction A and
instruction B can be issued at the same cycle[1], instead of B waiting
for the result from A   (a pipeline bypass reduces the wait time, but
not eliminates it, right?)

>
> Can you explain why this patch is so beneficial for Loongson 3A?

I have written a simply test[2] to measure the performance gain on
Loongson 3A, the result[3] shows at most 50% performance gain.

IMHO, the patch not only benefits Loongson 3A, but would also benefit
other MIPS CPU(s).


--
1. If the hardware supports this, e.g. at least two ALU units for ALU
operations, and is an out of order execution pipeline, etc
2. http://dev.lemote.com/files/upload/software/csum-opti/csum-test.tar.gz
3. http://dev.lemote.com/files/upload/software/csum-opti/csum-opti-benchmark.html



Regards,

- cee1

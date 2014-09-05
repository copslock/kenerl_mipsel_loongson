Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 Sep 2014 15:56:59 +0200 (CEST)
Received: from mail-ig0-f175.google.com ([209.85.213.175]:50481 "EHLO
        mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008183AbaIEN4yp4MSV convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 5 Sep 2014 15:56:54 +0200
Received: by mail-ig0-f175.google.com with SMTP id uq10so1125798igb.8
        for <linux-mips@linux-mips.org>; Fri, 05 Sep 2014 06:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=dZprwMo+2qcsWWjJzgyTzTJ++yHoIfw+FvfG1w5Oo2I=;
        b=vB5RMJoDNMepVxIUI29Pt/lu+zIUxiZ/3p5nCRZOiCUyWzui5l1Zzyl2LkpjPv2tbo
         WElK1rL3WoApTrKfkZDwAcacjZMJyFy867pGrbwqiTNmLGk4AFBPoLm1wrSiLTX/OB6y
         BcX7WjVi7DAg+9cLniFLdjo6LZg7Xez7PPdHBYnHkQ9uB1FHcf+xQ7nm9ujz4p6YOcvN
         5/A6AP1whf0CPUeIlnvHGZSggZa90/cuqax5eBxGNZ0DyACTjJG/kuTjVCm0lFnM4aT1
         /BUUi7Ap9O00vjjkWCcxJrUbtqKStz6AVMdLRMUu8y+NA94RN1tEtNF42hqg7+eCnheS
         fkCA==
X-Received: by 10.50.128.46 with SMTP id nl14mr4965063igb.48.1409925408665;
 Fri, 05 Sep 2014 06:56:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.26.201 with HTTP; Fri, 5 Sep 2014 06:56:28 -0700 (PDT)
In-Reply-To: <1400997742-9393-1-git-send-email-chenj@lemote.com>
References: <1400997742-9393-1-git-send-email-chenj@lemote.com>
From:   cee1 <fykcee1@gmail.com>
Date:   Fri, 5 Sep 2014 21:56:28 +0800
Message-ID: <CAGXxSxXTroiohkMVDfCxFeDo4ty+q5WKFR5Q8p3oc8eut8BfsQ@mail.gmail.com>
Subject: Re: [v4, Resend] MIPS: lib: csum_partial: more instruction paral
To:     chenj <chenj@lemote.com>
Cc:     Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        =?UTF-8?B?6ZmI5Y2O5omN?= <chenhc@lemote.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-Path: <fykcee1@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42428
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

2014-05-25 14:02 GMT+08:00 chenj <chenj@lemote.com>:
> Computing sum introduces true data dependency. This patch removes some
> true data depdendencies, hence instruction level parallelism is
> improved.
>
> This patch brings at most 50% csum performance gain on Loongson 3a
> processor in our test.
>
> One example about how this patch works is in CSUM_BIGCHUNK1:
> // ** original **    vs    ** patch applied **
>     ADDC(sum, t0)           ADDC(t0, t1)
>     ADDC(sum, t1)           ADDC(t2, t3)
>     ADDC(sum, t2)           ADDC(sum, t0)
>     ADDC(sum, t3)           ADDC(sum, t2)

Following is the math behind the above transformation, i.e. math proof
of equalization of the left and right.

For convenience of expression:
1. Mark "ADDC(A, B)" as "A 烫 B", then
A 烫 B = (A + B >= 2^64) ? A + B - 2^64 + 1 : A+B

2. Mark 2^64 as @

What we prove is:
sum 烫 A 烫 B == sum 烫 (A 烫 B)

There are two add operations in "sum 烫 A 烫 B". According to whether
each add op overflows, there are four cases:
Case 1: The first add op overflows, the second **not**

Case 2: The first add op does **not** overflow, the second does

Case 3: Both the first and the second add op overflow

Case 4: **Neither** the first nor the second add op overflow


====
Case 1: The first add op overflows, the second **not**, that means:
1   sum + A >= @
2   sum + A - @ + 1 + B < @
sum 烫 A 烫 B = sum + A + B - @ + 1

If A + B >= @:
        => A 烫 B = A + B - @ + 1

        Q: sum + (A 烫 B) = sum + A + B - @ + 1 OVERFLOWS？(i.e. sum + A
+ B - @ + 1 >= @)
        sum 烫 (A 烫 B) = sum + A + B - @ + 1    # see (2)

If A + B < @:
         => A 烫 B = A + B

        Q: sum + (A 烫 B) = sum + A + B OVERFLOWS?
        sum + A + B >= @ + B >= @    # adds B to both sides of (1)
        => sum 烫 (A 烫 B) = sum + A + B - @ + 1


====
Case 2: The first add op does **not** overflow, the second does, that means:
1   sum + A < @
2   sum + A + B >= @
sum 烫 A 烫 B = sum + A + B - @ + 1

If A + B >= @:
        => A 烫 B = A + B - @ + 1

        Q: sum + (A 烫 B) = sum + A + B - @ + 1 OVERFLOWS?
        sum + A + B - @ + 1 < @ + B - @ + 1    # adds 'B-@+1' to both
sides of (1)
        => sum + A + B - @ + 1 < B + 1 <= @
        => sum + A + B - @ + 1 < @
        => sum 烫 (A 烫 B) = sum + A + B - @ + 1

If A + B < @:
         => A 烫 B = A + B

        Q:  sum + (A 烫 B) = sum + A + B OVERFLOWS?
        sum 烫 (A 烫 B) = sum + A + B - @ + 1    # see (2)


====
Case 3: Both the first and the second add op overflow, that means:
1   sum + A >= @
2   sum + A + B - @ + 1 >= @
sum 烫 A 烫 B = sum + A + B - 2@ + 2

3   A + B >= 2@ - 1 - sum   # transformed from (2)
    1 + sum <= @
    => @ + 1 + sum <= 2@
    => @ <= 2@ - 1 - sum
    => @ <= 2@ - 1 - sum <= A + B    # see (3)
    => A + B >= @
    => A 烫 B = A + B - @ + 1

    Q: sum + (A 烫 B) = sum + A + B - @ + 1 OVERFLOWS?
    sum 烫 (A 烫 B) = sum + A + B - 2@ + 2    # see (2)


====
Case 4: Neither the first nor the second add op overflow, that means:
1   sum + A < @
2   sum + A + B < @
sum 烫 A 烫 B = sum + A + B

    A + B < @ - sum <= @    # transformed from (2)
    => A + B < @
    => A 烫 B = A + B

    Q: sum + (A 烫 B) = sum + A + B OVERFLOWS?
    sum 烫 (A 烫 B) = sum + A + B   # see (2)


Conclusion: sum 烫 A 烫 B == sum 烫 (A 烫 B)


-- 
Regards,

- cee1

Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 31 Mar 2015 10:35:26 +0200 (CEST)
Received: from mail-ig0-f178.google.com ([209.85.213.178]:38694 "EHLO
        mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009467AbbCaIfV4XejG convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 31 Mar 2015 10:35:21 +0200
Received: by igbqf9 with SMTP id qf9so11096032igb.1;
        Tue, 31 Mar 2015 01:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=yTW/atLFfI087wIGxgx+dbl/rjUpATlhLTjgLomxTEo=;
        b=FoA8E13aBXLLt3m/MijkBhbOVY3T/YDdWgvLxYDpuPw7P0yrWJnVb8PVZLImu32ktP
         6X9yl65YBs7VgBmCCs6D/3mvKy3z9vLn6BF4P+WCtIWN4Wo8scjuoMvCgEVdJ1CTAYfT
         Ww251OsDt6ijEBXfYhO83bwqSizOeT8dWNJ6/9KKOWl4iP+zDZ8PuwrTDW/xrlTvRDiN
         Xzn/kNddQWgTT8IemF1g2iIRijETdrqDq1S3ddsnqecZcXk6mdcLBKL8s7DWGAXtqpeA
         WGESbWSjpVIlDgaG+udHFzaowVeb5yYH1F8RXGdRD0bHXF5QjiyOvGyZch26HRrgJkBP
         Fp+w==
X-Received: by 10.42.68.204 with SMTP id y12mr20175628ici.84.1427790917025;
 Tue, 31 Mar 2015 01:35:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.50.239.38 with HTTP; Tue, 31 Mar 2015 01:34:56 -0700 (PDT)
In-Reply-To: <1427389644-92793-1-git-send-email-fykcee1@gmail.com>
References: <1427389644-92793-1-git-send-email-fykcee1@gmail.com>
From:   cee1 <fykcee1@gmail.com>
Date:   Tue, 31 Mar 2015 16:34:56 +0800
Message-ID: <CAGXxSxWYDmK9x5nLQy97bxPmrcH_DAkvGTwvxR4QpNx1GMOXbw@mail.gmail.com>
Subject: Re: [v5] MIPS: lib: csum_partial: more instruction paral
To:     Linux MIPS Mailing List <linux-mips@linux-mips.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        =?UTF-8?B?6ZmI5Y2O5omN?= <chenhc@lemote.com>,
        =?UTF-8?B?5ZC056ug6YeR?= <wuzhangjin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-Path: <fykcee1@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46641
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

The output result isn't influenced by this patch, as shown by
following mathematical proof.

For convenience, let's mark '2^64' as '@', mark 'ADDC(A, B)' as 'A ⊕ B', then:
A ⊕ B = (A + B >= @) ? A + B - @ + 1 : A + B

What this patch did is transforming "sum ⊕ A ⊕ B ⊕ C ⊕ D" to "sum ⊕ (A
⊕ B) ⊕ (C ⊕ D)",
so what we are trying to prove is:

sum ⊕ A ⊕ B ⊕ C ⊕ D = sum ⊕ (A ⊕ B)

Let's first prove "sum ⊕ A ⊕ B" = "sum ⊕ (A ⊕ B)". There are 2 add ops
within 2 '⊕' here. According whether these add ops overflow, there are
4 cases:
Case 1: Only the first add op overflows.

Case 2: Only the second add op overflows.

Case 3: Both add ops overflow.

Case 4: Neither add ops overflow.

## In Case 1, we have
(1) sum + A >= @
    => sum ⊕ A = sum + A - @ + 1

(2) sum + A - @ + 1 + B < @
    => sum ⊕ A ⊕ B = sum + A + B - @ + 1

If A + B >= @:
    => A ⊕ B = A + B - @ + 1
    => sum + (A ⊕ B) = sum + A + B - @ + 1 < @   (see (2))
    => sum ⊕ (A ⊕ B) = sum + A + B - @ + 1 = sum ⊕ A ⊕ B

If A + B < @:
    => A ⊕ B = A + B
(3) => sum + (A ⊕ B) = sum + A + B

    sum + A + B >= @ + B >= @   (adds B to both sides of (1))
    => sum + (A ⊕ B) >= @       (see (3))
    => sum ⊕ (A ⊕ B) = sum + A + B - @ + 1 = sum ⊕ A ⊕ B

## In Case 2, we have
(1) sum + A < @
    => sum ⊕ A = sum + A

(2) sum + A + B >= @
    => sum ⊕ A ⊕ B = sum + A + B - @ + 1

If A + B >= @:
    => A ⊕ B = A + B - @ + 1
(3) => sum + (A ⊕ B) = sum + A + B - @ + 1

    sum + A + B - @ + 1 < @ + B - @ + 1   (adds 'B - @ + 1' to both
sides of (1))
    => sum + A + B - @ + 1 < B + 1 <= @
    => sum + A + B - @ + 1 < @
    => sum + (A ⊕ B) < @                  (see (3))
    => sum ⊕ (A ⊕ B) = sum + A + B - @ + 1 = sum ⊕ A ⊕ B

If A + B < @:
    => A ⊕ B = A + B
    => sum + (A ⊕ B) = sum + A + B >= @   (see (2))
    => sum ⊕ (A ⊕ B) = sum + A + B - @ + 1 = sum ⊕ A ⊕ B

## In Case 3, we have
(1) sum + A >= @
    => sum ⊕ A = sum + A - @ + 1

(2) sum + A - @ + 1 + B >= @
    => sum ⊕ A ⊕ B = sum + A + B - 2@ + 2

(3) A + B >= 2@ - 1 - sum   (transformed from (2))

    1 + sum <= @            ( sum is in range [0, @) )
    => @ + 1 + sum <= 2@    ( adds @ to both sides)
    => @ <= 2@ - 1 - sum <= A + B   (combining with (3))
    => A + B >= @                   (cleaning up)
    => A ⊕ B = A + B - @ + 1
    => sum + (A ⊕ B) = sum + A + B - @ + 1 >= @   (see (2))
    => sum ⊕ (A ⊕ B) = sum + A + B - 2@ + 2 = sum ⊕ A ⊕ B

## In Case 4, we have
(1) sum + A < @
    => sum ⊕ A = sum + A

(2) sum + A + B < @
    => sum ⊕ A ⊕ B = sum + A + B

    A + B < @ - sum    (subtracts 'sum' from both sides of (2))
    => A + B < @
    => A ⊕ B = A + B
    => sum + (A ⊕ B) = sum + A + B < @   (see (2))
    => sum ⊕ (A ⊕ B) = sum + A + B = sum ⊕ A ⊕ B

Conclusion: sum ⊕ A ⊕ B = sum ⊕ (A ⊕ B)


Let U = sum ⊕ A ⊕ B (or sum ⊕ (A ⊕ B)), then

sum ⊕ A ⊕ B ⊕ C ⊕ D = U ⊕ C ⊕ D = U ⊕ (C ⊕ D)   (use the conclusion)

so we have:

sum ⊕ A ⊕ B ⊕ C ⊕ D = sum ⊕ (A ⊕ B) ⊕ (C ⊕ D)

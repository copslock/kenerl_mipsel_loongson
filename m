Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 10 Mar 2018 23:46:27 +0100 (CET)
Received: from mail-pl0-x242.google.com ([IPv6:2607:f8b0:400e:c01::242]:34516
        "EHLO mail-pl0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992818AbeCJWqVLPFVt convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 10 Mar 2018 23:46:21 +0100
Received: by mail-pl0-x242.google.com with SMTP id u13-v6so7229658plq.1
        for <linux-mips@linux-mips.org>; Sat, 10 Mar 2018 14:46:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Tri7ZfGmN6n8kC/0Qegrooq6MBu5Bgsf7a/DKkBK2N4=;
        b=PpamWougWnqQtGKLfnFCQgwB5G9KdIzT2JCxT+Ot5MkUkbtTLd/fxYzuVZ/rRtQEKi
         5hjXfrbg+NwHbSZqkgOQ5XmDpXMjx5+ujYUSOygRLhKWRvVsVPgv4834E1kiqFOr9I+t
         5nHFS3L235mLp8O30+VkLAkLOZVxprysEgMtckjAi7xajH62piMMXambqRMssn/l2uQZ
         N497z+8Dz0eEq3AYxGS5o0oHSFx/4ySaSI7x9t88cvDD0gQ6dH/HIg1cPzSR5yU8yRSb
         mnxo02Sdg1dMNS67disrvWfy8Vc4NYL+tGbniPyBU9dkOpH2RqoqtdC77VcJLkUpdtPg
         xMEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Tri7ZfGmN6n8kC/0Qegrooq6MBu5Bgsf7a/DKkBK2N4=;
        b=s01xJz0ZS68w33f29H1SU7+j3Ztvo3Tn/AVOK54E6Lj37PIecrrP4WohBC8+sxWqbR
         ajLRcn77jf56xDdv8qJ1bBjHvHQNnDXaLlyhx5Acyglco26R+7QEag99qWiMS4/mk58R
         hKeOJIa6naQl1vCOh3w9F2etzi4grTrDkMjhA/20aNqW4Y+5ZHgMs4vku0XtZk+JQA8+
         RqARz/OPbzEmMdll9z3w2k+ceKFHqaY3dlyeWRV0orgcDwm11OM+U1tEehm0pV5QZAlw
         v+yq1ZGQudZeLc5IzNgHmLA2AuwZu6PGe7M8sO58Rd3XOQa3xnVUEIS5CQbShuAw6qex
         3G9g==
X-Gm-Message-State: AElRT7GmFd538Usj8S9oPFBa+jIEeTFzxwL3EwlgAkWWXVH29guLO0Fh
        C8RbD+WhJHRQ3kYrBIqZ2/DUHFLa4lt1obcKSKhyuw==
X-Google-Smtp-Source: AG47ELtqFBJ9j7LK0b0TZdV0JWyY6kqWFYeUcpgZMZkMN2veOdX+ExcpDBVa1fSdC8StGoELvFFeScqkxM5olxltlAs=
X-Received: by 2002:a17:902:bcc6:: with SMTP id o6-v6mr3186930pls.16.1520721974851;
 Sat, 10 Mar 2018 14:46:14 -0800 (PST)
MIME-Version: 1.0
Received: by 10.100.149.10 with HTTP; Sat, 10 Mar 2018 14:46:14 -0800 (PST)
In-Reply-To: <20180309224937.GI24558@saruman>
References: <20180309151219.18723-1-ezequiel@vanguardiasur.com.ar>
 <20180309151219.18723-10-ezequiel@vanguardiasur.com.ar> <20180309224937.GI24558@saruman>
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Date:   Sat, 10 Mar 2018 19:46:14 -0300
Message-ID: <CAAEAJfCsoc3d+uEq6TrsSZmv=5Xsq5Qd1hbz+9+GzsgV2w77pw@mail.gmail.com>
Subject: Re: [PATCH 09/14] mmc: jz4740: Fix race condition in IRQ mask update
To:     James Hogan <jhogan@kernel.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>,
        linux-mmc@vger.kernel.org, Linux-MIPS <linux-mips@linux-mips.org>,
        Alex Smith <alex.smith@imgtec.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-Path: <ezequiel@vanguardiasur.com.ar>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62907
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ezequiel@vanguardiasur.com.ar
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

On 9 March 2018 at 19:49, James Hogan <jhogan@kernel.org> wrote:
> On Fri, Mar 09, 2018 at 12:12:14PM -0300, Ezequiel Garcia wrote:
>> From: Alex Smith <alex.smith@imgtec.com>
>>
>> A spinlock is held while updating the internal copy of the IRQ mask,
>> but not while writing it to the actual IMASK register. After the lock
>> is released, an IRQ can occur before the IMASK register is written.
>> If handling this IRQ causes the mask to be changed, when the handler
>> returns back to the middle of the first mask update, a stale value
>> will be written to the mask register.
>>
>> If this causes an IRQ to become unmasked that cannot have its status
>> cleared by writing a 1 to it in the IREG register, e.g. the SDIO IRQ,
>> then we can end up stuck with the same IRQ repeatedly being fired but
>> not handled. Normally the MMC IRQ handler attempts to clear any
>> unexpected IRQs by writing IREG, but for those that cannot be cleared
>> in this way then the IRQ will just repeatedly fire.
>>
>> This was resulting in lockups after a while of using Wi-Fi on the
>> CI20 (GitHub issue #19).
>>
>> Resolve by holding the spinlock until after the IMASK register has
>> been updated.
>>
>
> Maybe have a Link tag instead of referencing "github issue #19", i.e.:
> Link: https://github.com/MIPS/CI20_linux/issues/19
>
> Since this fixes an older commit, it'd be worth adding:
>
> Fixes: 61bfbdb85687 ("MMC: Add support for the controller on JZ4740 SoCs.")
>
>> Signed-off-by: Alex Smith <alex.smith@imgtec.com>
>
> ... and presumably is worthy of backporting (the driver was introduced
> in 2.6.36), i.e.:
> Cc: stable@vger.kernel.org
>

Oh, yes, good catch. I've overlooked this commit.

Thanks,
-- 
Ezequiel García, VanguardiaSur
www.vanguardiasur.com.ar

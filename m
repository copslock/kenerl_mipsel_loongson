Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Sep 2017 16:31:02 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.99]:54148 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994926AbdIEOarZ0XjV (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 5 Sep 2017 16:30:47 +0200
Received: from mail-qk0-f169.google.com (mail-qk0-f169.google.com [209.85.220.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C561321E92
        for <linux-mips@linux-mips.org>; Tue,  5 Sep 2017 14:30:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C561321E92
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=robh@kernel.org
Received: by mail-qk0-f169.google.com with SMTP id a128so12045447qkc.5
        for <linux-mips@linux-mips.org>; Tue, 05 Sep 2017 07:30:43 -0700 (PDT)
X-Gm-Message-State: AHPjjUiJnp4Mf6kLp5kpoBvteewi2t5N1CVhUXzVKMiDHtqz8uxgjcKJ
        Ryd43efHpuE5V+8T9maxQwZ7GxUPRQ==
X-Google-Smtp-Source: ADKCNb792YFhgxvddsq4tCw3RnSu2OvGhrpTuRXR7r3H29rOQ2Ck0sENCOp23xHBcMmQ0ikbF88ejAqg/WZY72EfMTM=
X-Received: by 10.55.160.4 with SMTP id j4mr5195505qke.357.1504621842956; Tue,
 05 Sep 2017 07:30:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.153.1 with HTTP; Tue, 5 Sep 2017 07:30:22 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.21.1709030637090.24875@localhost.localdomain>
References: <alpine.LFD.2.21.1709020416130.13598@localhost.localdomain>
 <1504390854.4974.108.camel@kernel.crashing.org> <alpine.LFD.2.21.1709030637090.24875@localhost.localdomain>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 5 Sep 2017 09:30:22 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJNoWAAi3Nj5KxAf5ov73nfPVaGeT1RTNgzZGpdxZ7s=w@mail.gmail.com>
Message-ID: <CAL_JsqJNoWAAi3Nj5KxAf5ov73nfPVaGeT1RTNgzZGpdxZ7s=w@mail.gmail.com>
Subject: Re: [PATCH] devicetree: Remove remaining references/tests for "chosen@0"
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        Michal Simek <monstr@monstr.eu>,
        Linux PPC Mailing List <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <robh@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59934
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: robh@kernel.org
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

On Sun, Sep 3, 2017 at 5:43 AM, Robert P. J. Day <rpjday@crashcourse.ca> wrote:
> On Sun, 3 Sep 2017, Benjamin Herrenschmidt wrote:
>
>> On Sat, 2017-09-02 at 04:43 -0400, Robert P. J. Day wrote:
>> > Since, according to a recent devicetree ML posting by Rob Herring,
>> > the node "/chosen@0" is most likely for real Open Firmware and
>> > does not apply to DTSpec, remove all remaining tests and
>> > references for that node, of which there are very few left:
>>
>> Technically that would break Open Firmware systems where the node is
>> really called chosen@0
>>
>> Now I'm not sure such a thing actually exist however.
>>
>> My collection of DTs don't seem to have one, except in the ancient
>> html variants that were extracted by the pengionppc folks for the
>> original PowerMac 8600 but I wonder if that's a bug in the
>> extraction script since they also have @0 on /packages etc...
>
>   obviously, this isn't a priority issue, i was just working off a
> comment by rob herring that "chosen@0" is not defined by the current
> DTSpec 0.1, so it seemed appropriate to toss it. if there's a reason
> to hang onto it, that's fine with me.
>
>   however, given the diff stat of the change to remove every single
> reference to that node name in the current kernel source:
>
>  arch/microblaze/kernel/prom.c | 3 +--
>  arch/mips/generic/yamon-dt.c  | 4 ----
>  arch/powerpc/boot/oflib.c     | 7 ++-----
>  drivers/of/base.c             | 2 --
>  drivers/of/fdt.c              | 5 +----
>  5 files changed, 4 insertions(+), 17 deletions(-)
>
> it seems inconsistent that three architectures would be testing for
> that node, but none of the rest. consistency suggests that every
> architecture should take it into account, or none should.

I generally agree and have moved various things from arch to
drivers/of/ to ensure that. But for legacy things, we have to allow
for exceptions. I agree with Ben and think that microblaze (they
generally just copied PPC), MIPS, and the FDT code in drivers/of/ can
be changed.

Rob

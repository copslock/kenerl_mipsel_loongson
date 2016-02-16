Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Feb 2016 16:53:53 +0100 (CET)
Received: from mail-ob0-f178.google.com ([209.85.214.178]:33063 "EHLO
        mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012831AbcBPPxwWJdrn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 16 Feb 2016 16:53:52 +0100
Received: by mail-ob0-f178.google.com with SMTP id jq7so80285097obb.0
        for <linux-mips@linux-mips.org>; Tue, 16 Feb 2016 07:53:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=jScXW9oOcDXxtwXBGtIUi7VqI0bIwPbBYe8Gs1GRxDk=;
        b=SpBy00mMhMUVMDhMpuTpS/0ISGNXe2MWDVgL+G62MeKaBg+FdXjbEvJJAdw8cgJRW+
         O6V+hNgQGM1M0ja+yhi1WHZNEEFUamxN73kmvUlxnCREpulOs7pHMOaLax4RmRYslODe
         QmafqLOu8t92LWIdMoJq4mbh1pK6IlEDOo/jU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=jScXW9oOcDXxtwXBGtIUi7VqI0bIwPbBYe8Gs1GRxDk=;
        b=FKljlC1GuS1UrS1KIky7q4EzmDUVxkJ5WvMx93Ks82r6ZEv2ySfwVyVXOr9fmRhJu9
         /daML0tTgmaSUY/v1iB3f38kwKmqwPb4v5IqGC0fKU/p8f3OXRaIw7/K0FzNzFYPqLej
         6Fz6CmNi2brkN07GGo+TCwNXQGnrMGq1uxPXqkcBmaU9uZwa3ZckVsNkqfxzry+Mfe/T
         I5Myo2iQQyeqUDDvPV7e3u4Vq9pwtWEdRlo449/s5gJczoGDK6LVZqojkE7D9AIkt26S
         5KUW4bB9OCnZoB05HGC1kXGYLb5zUqTV9q16za/3rKN4CBYDbmqZ8yX2o9t3tfxPjkdD
         6LoQ==
X-Gm-Message-State: AG10YORXGe+I0Vcmce5sm8+kfm+XzuXTb6g5L0ElPMh6v0yQoQZDBL2ZzEFUtvAUg+n8qJAdrsiUzUQwVrs1kpEi
MIME-Version: 1.0
X-Received: by 10.202.180.137 with SMTP id d131mr16876965oif.135.1455638023950;
 Tue, 16 Feb 2016 07:53:43 -0800 (PST)
Received: by 10.182.55.105 with HTTP; Tue, 16 Feb 2016 07:53:43 -0800 (PST)
In-Reply-To: <2646870.5L1En4yxph@wuerfel>
References: <20160202194831.10827.63244.stgit@bhelgaas-glaptop2.roam.corp.google.com>
        <1455551208-2825510-2-git-send-email-arnd@arndb.de>
        <CACRpkdaQN9_qoTn4_riZGvi4BKRLEVkRRL4CWzKj8e_di7Q2Xg@mail.gmail.com>
        <2646870.5L1En4yxph@wuerfel>
Date:   Tue, 16 Feb 2016 16:53:43 +0100
Message-ID: <CACRpkdYDqU7bbZguifQ2cos0r0ywgofzx4XvsmkQ8d73W9183A@mail.gmail.com>
Subject: Re: [PATCH 1/4] gpio: remove broken irq_to_gpio() interface
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Alexandre Courbot <gnurou@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>,
        Linux MIPS <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <linus.walleij@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52092
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linus.walleij@linaro.org
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

On Tue, Feb 16, 2016 at 4:45 PM, Arnd Bergmann <arnd@arndb.de> wrote:

> I've just sent v2 of the series, with a separate patch for MIPS
> that now conflicts with this one. Can you pick up the new patch
> instead?

OK I'll back out and apply the v2 versions.

Yours,
Linus Walleij

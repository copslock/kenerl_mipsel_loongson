Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Oct 2014 10:44:26 +0100 (CET)
Received: from mail-ie0-f178.google.com ([209.85.223.178]:37074 "EHLO
        mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011556AbaJ1JoYw7S1t (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 28 Oct 2014 10:44:24 +0100
Received: by mail-ie0-f178.google.com with SMTP id rl12so250908iec.9
        for <linux-mips@linux-mips.org>; Tue, 28 Oct 2014 02:44:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=h2KgcRRTxvU6rFVBBVzjXI2BnK6woov3kKVyqIJsPCQ=;
        b=HJ5g8Bm9mO1J7CxmaBk40YmwDjaa1tU0vPpYVtDBJ3B3sDxlCez9r1mwVXFcLe/5Xw
         NHb3IF5jig6ELkBztzBZD6VUGAANxzjyIjGBvrbWheJmWz4cVS9++4ezJHNyJ2Ogxpz2
         mNFYOTQsHQjnV325Uh9v94FP3ZTCeS6Bj3x5utv4VhXWEUa1G56LagSlDpqr99De+jRS
         nRqxXqmkBfA6Zkd4QUxXfEetGdPdi7bB9D5C5P23SLBCxRa4fA3OwLVb+zFirrV9TlbX
         ps330pFaZAfKxHPsmoXz4WCIv+rU7u804AFW1BzbwR/sJJ06HSJu4DV09JYcTpgkWasQ
         Crvw==
X-Gm-Message-State: ALoCoQmKh4JdWTibmacH7x1yrwFlokMy31UaRmMu+VXAxhUObYLS1/nu0hdzughBvpLnO1FPmm8A
MIME-Version: 1.0
X-Received: by 10.50.117.104 with SMTP id kd8mr3201790igb.3.1414489459072;
 Tue, 28 Oct 2014 02:44:19 -0700 (PDT)
Received: by 10.42.49.141 with HTTP; Tue, 28 Oct 2014 02:44:19 -0700 (PDT)
In-Reply-To: <CAAVeFuKgbsrZr88qXVf9DCJEmEjLx4ZMbwjZ=szQKMSihW7=-Q@mail.gmail.com>
References: <1412972930-16777-1-git-send-email-blogic@openwrt.org>
        <1412972930-16777-4-git-send-email-blogic@openwrt.org>
        <CAAVeFu+kC0RFxVfuhukFPdDLxMd3v7Eo+=7BYJ4sUh1cGSkJzw@mail.gmail.com>
        <54449E43.40304@openwrt.org>
        <CAAVeFuKgbsrZr88qXVf9DCJEmEjLx4ZMbwjZ=szQKMSihW7=-Q@mail.gmail.com>
Date:   Tue, 28 Oct 2014 10:44:19 +0100
Message-ID: <CACRpkdbm9mNz1=Xe+=q==AGmeSmWeAsAW4XS1gPwjjzBVWk_eQ@mail.gmail.com>
Subject: Re: [PATCH 4/5] GPIO: MIPS: ralink: add gpio driver for ralink MT762x SoC
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Alexandre Courbot <gnurou@gmail.com>
Cc:     John Crispin <blogic@openwrt.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Linux MIPS <linux-mips@linux-mips.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <linus.walleij@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43617
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

On Mon, Oct 20, 2014 at 8:27 AM, Alexandre Courbot <gnurou@gmail.com> wrote:
> On Mon, Oct 20, 2014 at 2:31 PM, John Crispin <blogic@openwrt.org> wrote:

>> i am not sure i have seen another instance of dts using a count index
>> for the following properties array/table/... do you have an example of
>> a driver doing so ?
>
> gpio-bcm-kona does something close: the number of interrupts specified
> indicate how many banks the chip has. I would not rely too much on
> existing bindings to decide what a "good" practice is.

Overall honestly I think too much responsibility of DT bindings
(and now also ACPI!) is pushed to the subsystem maintainers,
we are Linux GPIO experts, not really hardware description experts.

We do a best effort but the current practice of letting the subsystem
maintainers have the final word on all device tree bindings is
not optimal, I would like to have a DT/OF persons Reviewed-by tag
on any substantially new binding that is not just a copy of what
every other GPIO driver is doing.

Yours,
Linus Walleij

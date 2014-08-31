Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 31 Aug 2014 20:34:44 +0200 (CEST)
Received: from mail-vc0-f181.google.com ([209.85.220.181]:59836 "EHLO
        mail-vc0-f181.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006909AbaHaSemvyIGl (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 31 Aug 2014 20:34:42 +0200
Received: by mail-vc0-f181.google.com with SMTP id ij19so4578339vcb.40
        for <linux-mips@linux-mips.org>; Sun, 31 Aug 2014 11:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=7Ijt9vsU7z5HG1g9JThtu+T695hhwBA/uVs74Qyqj88=;
        b=SrDInL8wz243tl+V9UUriC4IKVPf7yYIQocdkuht89Xw4fNFKXUgQj2VMoLvDZLuLu
         +VgcTZMlormxAxS6w19by+o6i4IfIWcArfLay8eCLjupPfv3VdqGAgk2GwmmKzm8QA1h
         vWllSsovE7jNNsSvAvDSGQGMCE2LdR5bUyTfFKqo/I6BaliG0sOa7NJCbg3hXj2ops0q
         TJ4W7pz7zAmlOV3KwcoXYLX2szoIBK2D5Qj2AQyzTkg3dbwDtFm6+4UtLSUX1xtm0Fuv
         WoCA3bCuqS2pWtH3UAalhf+vdx+TJAjSBu/NjkxvqQ2rrE+1d4bIuxAX9zMp4yyl6+sm
         HR/g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=7Ijt9vsU7z5HG1g9JThtu+T695hhwBA/uVs74Qyqj88=;
        b=LmhLcVfZBeoLfvNg5glOhZD+b1BGPKCYxBKhs7ESf6xBDJDoOqdd6aPIWEd6UdeYBk
         kuuuj5Lq3xj9sdNpEQeQxZYbbEMHO5M67gmUn2VMacLjicDFLas9VZOPCm16JwMXf307
         1VsGi8GQD8ibqkuYlBAe4B//fta10YsS9e2Xo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=7Ijt9vsU7z5HG1g9JThtu+T695hhwBA/uVs74Qyqj88=;
        b=QA73ZZPQiD0vPOlXcrpqPo73W2gmF9X99BKkh+SCYyQi7Du00G6GzEA9zGbzElg/s2
         vm+u4ECN+3qyGJcGPXbAUFvnZ5ldByBmqbBT4aljB4QHsIfoAqqVcb1Sp5/jH9OX96ix
         jzHIqYieZWKrG2QsLxsOBHjqVz+3t5NsDyoLd3Y7QwBjEvX5mpHpmitZDKmEeekqLPDN
         VGfG2b5YGENebn3qF35j+2VvqA1YKuGJob+WIonin4fsp8KdjkaLK/XXYGes0THG6Wch
         mBAO6PirbpRSu5oOE1Fy/kddSRpkOf8g+m7pcUtYMtKvv35DJMMo8Xv/GiMBaEhpcKqM
         OHsQ==
X-Gm-Message-State: ALoCoQlPaHbwx1UQ3Z0z+JNWJP5oyLLiYPsytM9QjzhB16tKEOs4gEEA5yPynIC+VgOv80G/1Zou
MIME-Version: 1.0
X-Received: by 10.52.253.39 with SMTP id zx7mr12042540vdc.2.1409510076926;
 Sun, 31 Aug 2014 11:34:36 -0700 (PDT)
Received: by 10.53.5.133 with HTTP; Sun, 31 Aug 2014 11:34:36 -0700 (PDT)
In-Reply-To: <6798670.9zbxUzsGyC@wuerfel>
References: <1409350479-19108-1-git-send-email-abrestic@chromium.org>
        <1409350479-19108-4-git-send-email-abrestic@chromium.org>
        <6798670.9zbxUzsGyC@wuerfel>
Date:   Sun, 31 Aug 2014 11:34:36 -0700
X-Google-Sender-Auth: eXjALQgChIQgmisWYfKJwQ2G46k
Message-ID: <CAL1qeaE1jKLM0kK95efvcaeQwS4qjAR9-77Maa2q8aTJ4TC3jw@mail.gmail.com>
Subject: Re: [PATCH 03/12] of: Add binding document for MIPS GIC
From:   Andrew Bresticker <abrestic@chromium.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        Jeffrey Deans <jeffrey.deans@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42350
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: abrestic@chromium.org
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

On Sat, Aug 30, 2014 at 12:53 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Friday 29 August 2014 15:14:30 Andrew Bresticker wrote:
>> The Global Interrupt Controller (GIC) present on certain MIPS systems
>> can be used to route external interrupts to individual VPEs and CPU
>> interrupt vectors.  It also supports a timer and software-generated
>> interrupts.
>>
>> Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
>> ---
>>  Documentation/devicetree/bindings/mips/gic.txt | 50 ++++++++++++++++++++++++++
>>
>
> This may be a stupid question, but is this related to the ARM GIC
> in any way or does it just share the name?

There's no relation.  Note that it's also "Global Interrupt
Controller" vs. "Generic Interrupt Controller".

> In either case the binding belongs into
> Documentation/devicetree/bindings/interrupt-controller/.

Will do.

Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Nov 2014 23:45:40 +0100 (CET)
Received: from mail-pa0-f42.google.com ([209.85.220.42]:37103 "EHLO
        mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012912AbaKGWpiCzy64 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 7 Nov 2014 23:45:38 +0100
Received: by mail-pa0-f42.google.com with SMTP id bj1so4390651pad.15
        for <linux-mips@linux-mips.org>; Fri, 07 Nov 2014 14:45:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=G35VrwEZ2f1z4huop9EEkQgaB9SZzg87AbV0C0LoQKk=;
        b=bieyfq7t3Q8mxRRuMYxmuFbUwoGhBlBb4XiTZ0LpOo1BxuFaMiRPQgJj5kwiExjHM/
         H1jXh2qi/KBJ4f5xtT6rY9Kz/z86u3Lcp4EoXwb+PAA3V58Pdclvw81/7w1qTbFnpk5U
         ISJNcA2phyvX9GU+g4muPemtgmDB7yrLaqPjD/lm3qAC5IpjGn4NRIu+74RMkoc0V+oY
         tAgDBDhkToYdMpWYEgkqSHW/UHfkv2oBKpLrflhJI7mqBRiEY3FlmsfxRdLgLSsAFaHG
         K/Dj8Q6rlTc4VE9baEOBYx6cqSMEx/EulWbiaEgUvgc3gXkmEFDR7mSd+EmqY8pKlHo2
         N9PQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=G35VrwEZ2f1z4huop9EEkQgaB9SZzg87AbV0C0LoQKk=;
        b=KPs5mqRbCHpr2TwKAQzpYt5ZCd2N9CvXRlh0Q93CLtCuYt1a8WH/2yBDEm6BRqJgOP
         27eTkVOrE3LRXYA053sNWht9PsT7c8qg2UZEV1b4ytHbjDJ/9P4j+5iAEopJIWe3s5S+
         PQHnJE0s+HXs8meGZtgAlVO+3bJdOm4xLRbo8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=G35VrwEZ2f1z4huop9EEkQgaB9SZzg87AbV0C0LoQKk=;
        b=X42gdfG79xa6vAsz34Ya1eO6cayeEPhFaFapHpcNOBW0dgCa5Vna9QtbeQv8vOVRdW
         lWncVHG+Ea5VcOLLYf960cKbgWsgI9mCrEsiGBxYZM9r4HO+umLBLUnphnUJbUIMKOCg
         OfY4ri9HfS07i1SSD0tqAWA9hthLlChuv1cAPrgO5fId/axl42shjMBVLL7nn5/yllIe
         mtn1MjGmvvDGY6PsweOdrKrU0kzbVomBPzoN8qV5EmV2WLCLVoJUU8UvlRcwIk1vOk3e
         Mj2r5S7uoR5qF9y7qS5KEP9Mo/I7O/GPuVaFKmCXfk/zd7bW629FZqDWkdF0Wzj4nzd8
         Rv7Q==
X-Gm-Message-State: ALoCoQnv9IxwhuDNBEF0zVa+lhcRrP9o0PkRFNWhyeXBAEqBLHWz6YXjDuHOXiYnBY8EivIlZOrZ
MIME-Version: 1.0
X-Received: by 10.70.88.165 with SMTP id bh5mr15215680pdb.51.1415400330587;
 Fri, 07 Nov 2014 14:45:30 -0800 (PST)
Received: by 10.70.118.170 with HTTP; Fri, 7 Nov 2014 14:45:30 -0800 (PST)
In-Reply-To: <20141107041742.GH3698@titan.lakedaemon.net>
References: <1414624790-15690-1-git-send-email-abrestic@chromium.org>
        <1414624790-15690-4-git-send-email-abrestic@chromium.org>
        <20141107041742.GH3698@titan.lakedaemon.net>
Date:   Fri, 7 Nov 2014 14:45:30 -0800
X-Google-Sender-Auth: qVXuNPjKbSS1dB4vrSRuBzW4FW0
Message-ID: <CAL1qeaFpA8Ar3ef4Utd94SVtVfzP2=HVKwDc-2XgWuV+6sWswQ@mail.gmail.com>
Subject: Re: [PATCH V4 3/4] irqchip: mips-gic: Add device-tree support
From:   Andrew Bresticker <abrestic@chromium.org>
To:     Jason Cooper <jason@lakedaemon.net>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        John Crispin <blogic@openwrt.org>,
        David Daney <ddaney.cavm@gmail.com>,
        Qais Yousef <qais.yousef@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43924
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

On Thu, Nov 6, 2014 at 8:17 PM, Jason Cooper <jason@lakedaemon.net> wrote:
> On Wed, Oct 29, 2014 at 04:19:49PM -0700, Andrew Bresticker wrote:
>> Add device-tree support for the MIPS GIC.  Update the GIC irqdomain's
>> xlate() callback to handle the three-cell specifier described in the
>> MIPS GIC binding document.
>>
>> Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
>> Acked-by: Arnd Bergmann <arnd@arndb.de>
>> ---
>> Changes from v3:
>>  - use reserved-cpu-vectors property
>>  - read GIC base from CM if no reg property present
>> Changes from v2:
>>  - rebased on GIC irqchip cleanups
>>  - updated for change in bindings
>>  - only parse first CPU vector
>>  - allow platforms to use EIC mode
>> Changes from v1:
>>  - updated for change in bindings
>>  - set base address and enable bit in GCR_GIC_BASE
>> ---
>>  drivers/irqchip/irq-mips-gic.c | 92 +++++++++++++++++++++++++++++++++++++++---
>>  1 file changed, 87 insertions(+), 5 deletions(-)
>
> I assume this is going though the mips tree...
>
> Acked-by: Jason Cooper <jason@lakedaemon.net>

Yup, that's the plan.

Thanks,
Andrew

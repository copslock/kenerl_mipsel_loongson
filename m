Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Apr 2017 15:26:14 +0200 (CEST)
Received: from mail-io0-x236.google.com ([IPv6:2607:f8b0:4001:c06::236]:36521
        "EHLO mail-io0-x236.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990600AbdDFN0FVJ4Ux (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 6 Apr 2017 15:26:05 +0200
Received: by mail-io0-x236.google.com with SMTP id l7so29233575ioe.3
        for <linux-mips@linux-mips.org>; Thu, 06 Apr 2017 06:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=F/QPvZtJTs+496cf69ZrYIqvX5gvcUoZrOf+mywckk8=;
        b=MJGlynKpru2bVWSJc7wVIaJdJACsHGUn556iGQfy3XH3T9PqK4Gr1w8JCsic3f6zhB
         aOtHvZKzlvRtkkzOD/uZjSFpHrm7zaJN3IvrvEullgB+vm6krNEPeFEvw6aERgneDRhs
         imWAOzy1klvJw9GlQtRbp8hmuU/eEfjDHf99s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=F/QPvZtJTs+496cf69ZrYIqvX5gvcUoZrOf+mywckk8=;
        b=cRQ+REf3tX5sOk1zY3d4nDcEY8by3ZqSCmgz58yGqrzRkqJX3B965Yop1Hti9lr1Rq
         S8K7VKSGBG1x5Z1UCppsnyc1QE3SqhswDfztifUQOs9H1pF1MMyUZFUYm+AZKwiPlz/O
         rNxbfH9S0Rkgr8VsNm5LdkqPP2xgT3HnhZuCVKTKHX2xti86jAvwv6T6nXvKuX9l7Jrd
         Zah51oz10/4OXVz4DNp4jVN9S/SxSIA1FpCT/gjSjis81Ol2Abq/8RnmMygReQZ7qrdZ
         9nWTS5M7s/IjwWYhQcr8hYNE93sUrJQkwPWeoYtTO3PIZpK3o/tyPjGanQr7UB3YNPqi
         u4TA==
X-Gm-Message-State: AFeK/H26WI2RL0IByV+WoyGlM5DK/v29Sx0EVjsKRD5y/nDV7csNXbUW7w1qHktuqZ/QSK5d/tu3n7XtKm9DMgnR
X-Received: by 10.107.19.209 with SMTP id 78mr32269740iot.2.1491485158570;
 Thu, 06 Apr 2017 06:25:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.36.102.69 with HTTP; Thu, 6 Apr 2017 06:25:17 -0700 (PDT)
In-Reply-To: <20170406131900.GS31606@jhogan-linux.le.imgtec.org>
References: <1491482940-1163-1-git-send-email-amit.pundir@linaro.org>
 <1491482940-1163-8-git-send-email-amit.pundir@linaro.org> <20170406131900.GS31606@jhogan-linux.le.imgtec.org>
From:   Amit Pundir <amit.pundir@linaro.org>
Date:   Thu, 6 Apr 2017 18:55:17 +0530
Message-ID: <CAMi1Hd1b+CAzR==WvgPRAdFWfpMzTFrZtrcioTbOveBXNWa6ow@mail.gmail.com>
Subject: Re: [PATCH for-4.4 7/7] MIPS: Lantiq: Fix cascaded IRQ setup
To:     James Hogan <james.hogan@imgtec.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Felix Fietkau <nbd@nbd.name>,
        linux-mips@linux-mips.org
Content-Type: text/plain; charset=UTF-8
Return-Path: <amit.pundir@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57600
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: amit.pundir@linaro.org
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

Hi,

On 6 April 2017 at 18:49, James Hogan <james.hogan@imgtec.com> wrote:
> Hi Amit,
>
> On Thu, Apr 06, 2017 at 06:19:00PM +0530, Amit Pundir wrote:
>> From: Felix Fietkau <nbd@nbd.name>
>>
>> With the IRQ stack changes integrated, the XRX200 devices started
>> emitting a constant stream of kernel messages like this:
>>
>> [  565.415310] Spurious IRQ: CAUSE=0x1100c300
>>
>> This is caused by IP0 getting handled by plat_irq_dispatch() rather than
>> its vectored interrupt handler, which is fixed by commit de856416e714
>> ("MIPS: IRQ Stack: Fix erroneous jal to plat_irq_dispatch").
>>
>> Fix plat_irq_dispatch() to handle non-vectored IPI interrupts correctly
>> by setting up IP2-6 as proper chained IRQ handlers and calling do_IRQ
>> for all MIPS CPU interrupts.
>>
>> Signed-off-by: Felix Fietkau <nbd@nbd.name>
>> Acked-by: John Crispin <john@phrozen.org>
>> Cc: linux-mips@linux-mips.org
>> Patchwork: https://patchwork.linux-mips.org/patch/15077/
>> [james.hogan@imgtec.com: tweaked commit message]
>> Signed-off-by: James Hogan <james.hogan@imgtec.com>
>>
>> (cherry picked from commit 6c356eda225e3ee134ed4176b9ae3a76f793f4dd)
>> Signed-off-by: Amit Pundir <amit.pundir@linaro.org>
>
> Weren't you going to drop this one?

I thought you wanted me to drop this one because the
dependent/relevant patches were not pushed to stable at that time. But
I re-read your email and I missed one important part that this
particular patch is valid for a separate bug introduced in IRQ stack
stuff in 4.11. I missed that important part. My apologies for that.
Again.

Greg please drop this one for both 4.4 and 4.9.

Regards,
Amit Pundir

>
> Cheers
> James

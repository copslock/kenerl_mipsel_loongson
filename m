Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 Feb 2016 23:54:23 +0100 (CET)
Received: from mail-ob0-f179.google.com ([209.85.214.179]:35388 "EHLO
        mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012795AbcBEWyVmbIBk (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 5 Feb 2016 23:54:21 +0100
Received: by mail-ob0-f179.google.com with SMTP id xk3so101620394obc.2
        for <linux-mips@linux-mips.org>; Fri, 05 Feb 2016 14:54:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=yQwIj6czahhhLf+T30eS67Lk9YqJFjmtuJhbg81QKgk=;
        b=N34umwQJEGd3aSCCNWmzYUjRRSICY13uF+qAaKvIqaHEGTscXY/+LbeioKV5km5fGb
         EIatrHIHYuTTFwmnFsNjzreBU48whfRoxrUJmqm3lcnVH/rbc1WogOGMGG+woTst/NL5
         GvGK2cz/QXC8wCfJBemnvDo7OsMbDWFfFG1Yc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=yQwIj6czahhhLf+T30eS67Lk9YqJFjmtuJhbg81QKgk=;
        b=LtU3kOMw3IGJ110rkTtq8kh/2Kr/CtM2KZWjotppLzfybRUIuhP3KEn5f5ZGl0EE47
         pUeWb1v5IqosRnkBlVN+AxFidl+p54PbQRsMed/iEZD6rE/CW1CSp2mON2SOUQlX+wqp
         yHMOWUHETr0QJaFPpwJ6LcX5WNbRFT3HJzCmiwcdHKy0/nENAmyLJHaMOgtOTSy7Jdgs
         pmCZyseYrZ1IxwIs0+tLpwsCjEF5BZPr1r4+N1bQQ0FZu5cwZtO7tdznHx/gJjKNCYRB
         RuZAJXQs9aOqf5MDXEadLPMrTAlnnkpuvamQhTl7Mczkx6Ow6oFoHL0Gw8rNfrP6ZcoG
         W9ng==
X-Gm-Message-State: AG10YOTPn5PIRPApmCBwMIHQiKJPCuWljPt+TM+0iWQCz+AhvhqiC/ix4xq5YKGci1w2bLK0DdyraiXfMMgLCWOO
MIME-Version: 1.0
X-Received: by 10.60.147.137 with SMTP id tk9mr14848403oeb.45.1454712855210;
 Fri, 05 Feb 2016 14:54:15 -0800 (PST)
Received: by 10.182.55.105 with HTTP; Fri, 5 Feb 2016 14:54:15 -0800 (PST)
In-Reply-To: <1454366916-10925-1-git-send-email-joshua.henderson@microchip.com>
References: <1454366916-10925-1-git-send-email-joshua.henderson@microchip.com>
Date:   Fri, 5 Feb 2016 23:54:15 +0100
Message-ID: <CACRpkdZNar=OJq2+yFa7m8eEttSvmTdn4NBGsB=-yw0ztxR5Hw@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] dt/bindings: Add bindings for PIC32 pin control
 and GPIO
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Joshua Henderson <joshua.henderson@microchip.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux MIPS <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <linus.walleij@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51812
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

On Mon, Feb 1, 2016 at 11:48 PM, Joshua Henderson
<joshua.henderson@microchip.com> wrote:

> Document the devicetree bindings for PINCTRL and GPIO found on Microchip
> PIC32 class devices.
>
> Signed-off-by: Joshua Henderson <joshua.henderson@microchip.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Acked-by: Rob Herring <robh@kernel.org>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> ---
> Changes since v5: None

Patch applied.

Yours,
Linus Walleij

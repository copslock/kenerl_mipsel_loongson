Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 29 Jul 2017 03:51:42 +0200 (CEST)
Received: from mail-wr0-x244.google.com ([IPv6:2a00:1450:400c:c0c::244]:38601
        "EHLO mail-wr0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993975AbdG2BveP4ynf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 29 Jul 2017 03:51:34 +0200
Received: by mail-wr0-x244.google.com with SMTP id g32so10349383wrd.5
        for <linux-mips@linux-mips.org>; Fri, 28 Jul 2017 18:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=0f7Y5i2Eq9hlvBrl4gLm3j3ZRUPf+uA3fNQ3Y40wsOA=;
        b=rXZMutVSxFhg+lNXukbepwYVSjIEPhv/d7pjXT/iUZ/Oh+fLXxeDMGjrB9Dt6qnQNa
         wz3qdbMV2sky10N5FP3ZNfMppygTTHPtPr1/Asw39vMQfkE1FsPWbai6GfRFhPIVOFSo
         JuJZ+29apxf9jW/aiPaESDqEv3rJYtUl5Bd3kc6It7oDDfk6T8p7HVJGG7/y1KVnqGMW
         z0DDepBShfcKuXvE1SgpxDFHl8f118MrglIA9Rk0Cqo+YMGnJNv1fViWQaKyL+KKWzmE
         /GH/zB92mhQ4IeK4Fg6881wPj44zaWlwW62kuXTIL89oWhcXm4aX4LFGi4G9HZFHtZLi
         IT0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=0f7Y5i2Eq9hlvBrl4gLm3j3ZRUPf+uA3fNQ3Y40wsOA=;
        b=hu+NSWUTiBfN3l4alqhEW4cg9+54cxRClDxYR6US5hQsazRYs02N+08bXjczKDkT/w
         nfpoSDatVUwkpWkhqTGWKLFwA1DFGypwYIDM0ZtGaGFphkkCL8VXCP1bJCMfdEI9SC0Y
         BLtG/Uv3tHSnPBzhkZf+FtZwjaFw+f+BEwRanyUsFsNoDSiHwYiHH32+2guwYfaaVfs1
         gnK16ZwSaGQcgDozyl2WiXC7AEqECkNKM3BrATXnOeX/VBjvxouIjDlAMDkooqNFP+Go
         eVh//QrY7cVCMi4pmywNUr0XjJXRHxTmDF/WuthQ0WHwcq9MCCAS7kws5lp5dJkqqfTz
         b3Rg==
X-Gm-Message-State: AIVw110T9Azhi4RsAGRM0uU+ytodvI9gMRlmDVXPqYFyGjtIjd8S9NBF
        6bEI/rm29qXDh35Uysk83T0WRf3wZw==
X-Received: by 10.223.160.139 with SMTP id m11mr7020854wrm.142.1501293088838;
 Fri, 28 Jul 2017 18:51:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.28.18.199 with HTTP; Fri, 28 Jul 2017 18:50:58 -0700 (PDT)
In-Reply-To: <20170727223817.7494-1-f.fainelli@gmail.com>
References: <20170727223817.7494-1-f.fainelli@gmail.com>
From:   Gregory Fong <gregory.0xf0@gmail.com>
Date:   Fri, 28 Jul 2017 18:50:58 -0700
Message-ID: <CADtm3G4Rnm1276qYWe_MSnoZ2_Lxc1QFCUx1ZVfWtb5n4M2T2w@mail.gmail.com>
Subject: Re: [PATCH] irqchip: brcmstb-l2: Define an irq_pm_shutdown function
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Doug Berger <opendmb@gmail.com>,
        Kevin Cernekee <cernekee@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Brian Norris <computersforpeace@gmail.com>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        "open list:BROADCOM BMIPS MIPS ARCHITECTURE" 
        <linux-mips@linux-mips.org>,
        "open list:IRQCHIP DRIVERS" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <gregory.0xf0@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59304
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregory.0xf0@gmail.com
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

On Thu, Jul 27, 2017 at 3:38 PM, Florian Fainelli <f.fainelli@gmail.com> wrote:
> The Broadcom STB platforms support S5 and we allow specific hardware
> wake-up events to take us out of this state. Because we were not
> defining an irq_pm_shutdown() function pointer, we would not be
> correctly masking non-wakeup events, which would result in spurious
> wake-ups from sources that were not explicitly configured for wake-up.
>
> Fixes: 7f646e92766e ("irqchip: brcmstb-l2: Add Broadcom Set Top Box Level-2 interrupt controller")
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Acked-by: Gregory Fong <gregory.0xf0@gmail.com>

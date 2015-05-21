Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 May 2015 01:41:15 +0200 (CEST)
Received: from mail-qg0-f51.google.com ([209.85.192.51]:33178 "EHLO
        mail-qg0-f51.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006702AbbEUXlODcEhY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 22 May 2015 01:41:14 +0200
Received: by qgfa63 with SMTP id a63so1319451qgf.0
        for <linux-mips@linux-mips.org>; Thu, 21 May 2015 16:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=D16nIlDzs6bFzCBHpAF0Sw3tfFiMnWZEtEDuEnc19l0=;
        b=IZBvzUmKcCeD7BsqWH1HqgvaVBL2URf6DNI4GkTRaaz2w395pP/WwY5Qf9OluBKJK8
         PuMyTpcyi1/YwRIyW4iePKmvuXU47HxSxHZCby/NuTtZVlNatVLUb5r4lmBDCTziG3Xb
         3HURIsfQNhkseeKBPqg7X2+aJsy0XaKswMoPs/oRK2uyr+mye4T0WlsCN8PIEMGXGGWs
         OW58RBa7AvkSCDJ4QTY5kT/QqVqgPodTjVLgMNTV6DaRFdx2GkILA6kyRZ12u9xWBeoK
         JP4ev909+F1NMydslWAd7XSZmJa8iye6FmuyjZvMWh7+JBmyeJYeSje+Ma8hERUM97ZL
         xnZA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=D16nIlDzs6bFzCBHpAF0Sw3tfFiMnWZEtEDuEnc19l0=;
        b=Nrcxm7LAGWo74npIOGocxdwoylXs95rZGgN2vm5vzYpz5ZZCVRFP3XFx8O1Ko7S0gr
         kmGBxA76Z3bQ5bxfEqgso2ZcDEMzXYzDwiAx+SJlkftYDe3R8MvL2yHkIR89/irmgPK5
         PWblD+BxQp44sujsP8sv2FJf7Sl3ZcvrRxTTI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=D16nIlDzs6bFzCBHpAF0Sw3tfFiMnWZEtEDuEnc19l0=;
        b=FhjpeuaFIiv87iNz0VvXuhP59mNnoo9Db0nM37m41Z33IdTM7FPRHmrDJX5L25iwQV
         UxDWGCkFRFyZ056ggZQosy3NzBJhaaQJbvOIxlYL468SOoC3+IA8a+GeqO4aeachhcaS
         /Z5OQUdR/5CQcdOfefWmx00ooJn3V3oVWBh3Nfl3JLtmCNYv5XVc2uf5D9tKnZUPM27q
         wyoEj25KYNXD7MqCE1d9F+Eh/BFDHm8HgKGdMFN9d8TyOGrHUFcXBZRqF3q3amSgYvF/
         43AjXEMwIbFxFE1dtvmCAmehOu5n0aactv8W/XBY6om0Fm3b7+igJdsrGVF7mV27zfOV
         SgMg==
X-Gm-Message-State: ALoCoQkYaquKHkxJ7oIZQY1f4BBP4qS8HjV03CXeAVd0k1D7ax68Pq22cAcPcl61vbMXzV8hVrOM
MIME-Version: 1.0
X-Received: by 10.140.100.164 with SMTP id s33mr7293121qge.36.1432251670726;
 Thu, 21 May 2015 16:41:10 -0700 (PDT)
Received: by 10.140.23.72 with HTTP; Thu, 21 May 2015 16:41:10 -0700 (PDT)
In-Reply-To: <1432244465-15313-1-git-send-email-ezequiel.garcia@imgtec.com>
References: <1432244260-14908-1-git-send-email-ezequiel.garcia@imgtec.com>
        <1432244465-15313-1-git-send-email-ezequiel.garcia@imgtec.com>
Date:   Thu, 21 May 2015 16:41:10 -0700
X-Google-Sender-Auth: CdVy9ypy9HRP_gB5yLgvmQ7Dxd0
Message-ID: <CAL1qeaGo60o=XM4fdGUU_9afvGCZRzsbJR=DZB3JuKZdkk=tTQ@mail.gmail.com>
Subject: Re: [PATCH 5/7] clocksource: Add Pistachio SoC general purpose timer
 binding document
From:   Andrew Bresticker <abrestic@chromium.org>
To:     Ezequiel Garcia <ezequiel.garcia@imgtec.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        James Hartley <james.hartley@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Damien Horsley <Damien.Horsley@imgtec.com>,
        Govindraj Raja <Govindraj.Raja@imgtec.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47536
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

On Thu, May 21, 2015 at 2:41 PM, Ezequiel Garcia
<ezequiel.garcia@imgtec.com> wrote:
> Add a device-tree binding document for the clocksource driver provided
> by Pistachio SoC general purpose timers.
>
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@imgtec.com>

Reviewed-by: Andrew Bresticker <abrestic@chromium.org>

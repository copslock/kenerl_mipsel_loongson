Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 May 2015 20:07:27 +0200 (CEST)
Received: from mail-qk0-f176.google.com ([209.85.220.176]:33158 "EHLO
        mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006684AbbEVSHZYlL4i (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 22 May 2015 20:07:25 +0200
Received: by qkgv12 with SMTP id v12so17979263qkg.0
        for <linux-mips@linux-mips.org>; Fri, 22 May 2015 11:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=r8zjWk+CAyLv7TdQ+3U0HhpCExnqOmpQXKUFl1MUhv8=;
        b=IJrcIf7woiBZFa2bFyLnNvmprNJLR5hnhBbBlnUIq+vKmcVdQwMJlnE0ZbqmUbXbFp
         5dV+XIa+y5BGlNecC/6gIP17U7iV9dpFkQgnzfntmPTnNOnuSBsmiHRaOpHlXRDcL/P0
         oYIfP2frjLI6CD1yhyXlAhxb1v3oIVbJ90vZB43OoPQXFYpLI9LWejv9CVSFaWQ+II5m
         Axy5Dd+vQJ/JQmJLcAe/DKteRBHrLkhE2vXuQYLaFwcc2iGUmVsi3UThBQp/duCLa/1o
         tSMyPyhpQTIm6TZJzWdT5+gu0DBzVumqN9XBN0Cb1t80wfShA2k0pSbOhq4Fu9rZm+jO
         Aj9A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=r8zjWk+CAyLv7TdQ+3U0HhpCExnqOmpQXKUFl1MUhv8=;
        b=QTCSEnoS3Y8StxF7iFTIzOKDzeQk8QjCgZ8OXsarp3479eHIZYX3/yd2nLWTTXXRWY
         dizkGw5TyL56lGeccyFWyHBEJwIHV85JF2B5uakQCKMiwKEPJHJDH3puQTllGbVRz+j3
         Fx84+2TWR3B8gu99+vmUlQj1NJ+yZkNYXDb4I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=r8zjWk+CAyLv7TdQ+3U0HhpCExnqOmpQXKUFl1MUhv8=;
        b=F9eJaXWorkCqA3eFF+9VZJYJppwI6Y6q66LKiTPslWcnnkQFCpiPaAQRkQRoBtzxGD
         9YaAlaGf3VKYQd5Aukt9NtO+QaqpDC3fMvCE6gIapnsYfBFtceaUwCNPM4PHX8Jnycp/
         eOxBHlJRxk8ELmqiN0JrdZU5qQ89CinkmgyNnwibXRwbYJa26sVf1hT/XjXqlm0CNhZr
         dMfL7ydthndMLdXD8kZcZalbduTYkpWdhxkJnLEvN2rmg9pZwEa58jJIZ5e22E7FdFAi
         DPsK+HKHxOCcfKgqhJkiN9QT9euvC/1MYEAjNN0ez4vbN1Kby9t+zaeY2zV2URBg0OP8
         iN9w==
X-Gm-Message-State: ALoCoQk60O3mulFt836eydRxOEXDSJ9m1g2s6o26qNVLgMOYl14oZY6SgYyYhfHEtfDN5Z2s7kRS
MIME-Version: 1.0
X-Received: by 10.229.84.198 with SMTP id k6mr13181063qcl.16.1432318042341;
 Fri, 22 May 2015 11:07:22 -0700 (PDT)
Received: by 10.140.23.72 with HTTP; Fri, 22 May 2015 11:07:22 -0700 (PDT)
In-Reply-To: <555F6CE8.1070303@imgtec.com>
References: <1432252663-31318-1-git-send-email-ezequiel.garcia@imgtec.com>
        <1432252663-31318-7-git-send-email-ezequiel.garcia@imgtec.com>
        <CAL1qeaEKeNXWWgcu=sX_Ly=6mSsNm4i6OuN0561=_z55MaE6DA@mail.gmail.com>
        <555F6CE8.1070303@imgtec.com>
Date:   Fri, 22 May 2015 11:07:22 -0700
X-Google-Sender-Auth: 1Hy9stofcu8Fm0FEwnVOi1ulR7M
Message-ID: <CAL1qeaGa7b5CEtCYx=8-wSotFGUD-YgBRNQUY455mMo+3E7Drw@mail.gmail.com>
Subject: Re: [PATCH 6/9] clk: pistachio: Propagate rate changes in the MIPS
 PLL clock sub-tree
From:   Andrew Bresticker <abrestic@chromium.org>
To:     Ezequiel Garcia <ezequiel.garcia@imgtec.com>
Cc:     Linux-MIPS <linux-mips@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mike Turquette <mturquette@linaro.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        James Hartley <james.hartley@imgtec.com>,
        Govindraj Raja <Govindraj.Raja@imgtec.com>,
        Damien Horsley <Damien.Horsley@imgtec.com>,
        Kevin Cernekee <cernekee@chromium.org>,
        James Hogan <james.hogan@imgtec.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47587
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

On Fri, May 22, 2015 at 10:52 AM, Ezequiel Garcia
<ezequiel.garcia@imgtec.com> wrote:
>
>
> On 05/22/2015 02:42 PM, Andrew Bresticker wrote:
>> On Thu, May 21, 2015 at 4:57 PM, Ezequiel Garcia
>> <ezequiel.garcia@imgtec.com> wrote:
>>> This commit passes CLK_SET_RATE_PARENT to the "mips_div",
>>> "mips_internal_div", and "mips_pll_mux" clocks. This flag is needed for the
>>> "mips" clock to propagate rate changes up to the "mips_pll" root clock.
>>>
>>> Signed-off-by: Govindraj Raja <Govindraj.Raja@imgtec.com>
>>> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@imgtec.com>
>>
>> IIRC the clk core will prefer changing a downstream divider over
>> propagating the rate change up another level.  So, for example, if
>> MIPS_PLL is initially 400Mhz and we request a MIPS rate of 200Mhz,
>> we'll change the first intermediate divider to /2 rather than
>> propagate the rate change up to MIPS_PLL.  Wouldn't it be more
>> power-efficient to set the MIPS_PLL directly to the requested rate
>> rather than using external dividers to divide it down?
>>
>
> Indeed.
>
> Do you think we still want to be able to change the MIPS clk rate and
> propagate the change up to the PLL? Otherwise, I'll drop this patch and
> I'll drop the DIV_F and MUX_F macro patches.

Well I do think we want to propagate changes from MIPS up to MIPS_PLL,
but we need to work around the behavior of CLK_SET_RATE_PARENT when
applied to divider clocks.  Since there's no reason to ever set the
dividers between MIPS and MIPS_PLL to something besides /1
(James/Govindraj/Damien, correct me if I'm wrong here), then I think
we could just set CLK_DIVIDER_READ_ONLY on those dividers.  It's a bit
of a hack, but it's certainly simpler than writing a separate CPU
clock driver.

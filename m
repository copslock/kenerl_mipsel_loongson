Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Aug 2016 16:56:55 +0200 (CEST)
Received: from mail-ua0-f174.google.com ([209.85.217.174]:34236 "EHLO
        mail-ua0-f174.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991970AbcHWO4sVLUzx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 23 Aug 2016 16:56:48 +0200
Received: by mail-ua0-f174.google.com with SMTP id k90so248852388uak.1
        for <linux-mips@linux-mips.org>; Tue, 23 Aug 2016 07:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=TaGMn2tEiqGVvFz43gBZCXwD6q5eY3+1IzBJ7xxeen8=;
        b=EpDuyYK51V4yU/3EZrxiFtv30OvkiC5/PapLvXxPQyqkFDOY9Dx55/mkfHmdWwuIoX
         8tM4ROqHaRvrwou/21v8BudD9CoiHM6FiNwl9CWBjPMZf7EV1iGzFwua3/PXe5sAAKUS
         wD/fYra5oKeNXbLioEPcNAjNPSIkvaoF1hBBw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=TaGMn2tEiqGVvFz43gBZCXwD6q5eY3+1IzBJ7xxeen8=;
        b=WM+ZFyqbFPF+QPNHdNbJN7MxPbxOQMb/0yhCSiXsRZ9dnYvjQroGWIQwSMNVXbNWE5
         o0zznFdS/3Iyp1eeEoksw3G6qBsh0uSJ0zExUotc86leay7u+qzAv12I08y14O0NhlbL
         m5lMdkEoZJODeBUFAyUhcL/nPbOh7bQVBfTDmAy5Mdktf8OXpzwc1dXuEVZQzVezcYNb
         MHXiCAzNSwbnfthkN/kpfEyBZOABr52kQHj1emmfzZn4PqyMFwyecj/EttHPrCJlsVOw
         VSu5F8jphcegZwd3R+L1FSXaCRBf4nmolIPno2Ow5FzwvrU68le34lU7RHyI65KxpZ1o
         q24w==
X-Gm-Message-State: AEkoous94hbXuwTEMdajcERhEn40UhECADsiaqonPhCAFsIj7htvz58TCMDa9H/hwf9DOqnYFPSgMSpdyhgAHBDN
X-Received: by 10.31.170.9 with SMTP id t9mr14792335vke.131.1471964202736;
 Tue, 23 Aug 2016 07:56:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.31.134.74 with HTTP; Tue, 23 Aug 2016 07:56:42 -0700 (PDT)
In-Reply-To: <20160721134603.GA25689@linux-mips.org>
References: <57853474.9050108@cavium.com> <578E71E6.2020700@caviumnetworks.com>
 <CAPDyKFqb-7LLM0XPtVWj1qHib991E2dHt+6W0UPgbXnukGkmXA@mail.gmail.com> <20160721134603.GA25689@linux-mips.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 23 Aug 2016 16:56:42 +0200
Message-ID: <CAPDyKFq5N9HGVhhDEhi+YvshcgHZO7NB+hwa1LzOKYMhL2B02A@mail.gmail.com>
Subject: Re: [PATCH V8 2/2] mmc: OCTEON: Add host driver for OCTEON MMC controller.
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     "Steven J. Hill" <Steven.Hill@caviumnetworks.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        linux-mips@linux-mips.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <ulf.hansson@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54731
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ulf.hansson@linaro.org
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

On 21 July 2016 at 15:46, Ralf Baechle <ralf@linux-mips.org> wrote:
> On Tue, Jul 19, 2016 at 11:19:43PM +0200, Ulf Hansson wrote:
>
>> > Has anyone reviewed the driver or have any comments? Thanks.
>>
>> Sorry I need more time, been partly out of office lately.
>> I intend to review this prior rc1 is out, but no promises.
>>
>> Kind regards
>> Uffe
>
> Ulf,
>
> if you decide to accept this patch, could you also push the bindings
> patch ("[V8,1/2] mmc: OCTEON: Add DT bindings for OCTEON MMC controller.")
> upstream?  I think they should be merged together.

Ralf, sorry for the delay.

No worries, I will pick the bindings as once I am happy with the
driver (patch 2/2).

Kind regards
Uffe

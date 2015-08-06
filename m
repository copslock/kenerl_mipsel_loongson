Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Aug 2015 18:35:38 +0200 (CEST)
Received: from mail-ig0-f170.google.com ([209.85.213.170]:38478 "EHLO
        mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012684AbbHFQfgUMsPY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 6 Aug 2015 18:35:36 +0200
Received: by iggf3 with SMTP id f3so15156800igg.1
        for <linux-mips@linux-mips.org>; Thu, 06 Aug 2015 09:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=xXK7qddqEulsui7HmRcna0irGjW0+Rh83M7SHjXmerM=;
        b=P9/lHbiNpy2XZgad2nRCBKC6WYUcwF1SMK+s+vtP4ft8cN36Tw2b9mMWHRbrp9bS7t
         PkPn28vPWL74af76xjPtdKAa/AnSzzblcs978UCVkzJu6LTv+Ucw46kgcH11i2kmeRhX
         KnyAFiDjI4Gyb3EL2ACkADP3KUy7bZf0Npf2o3eautA+PNDK6d14MeEfH4livQd2lUou
         WZ/HSoMgQuHHydY3nYxGdogiLBiCyWgPi+G/ghNCp/VdYxC7LSni/PywIKVM3Cc7f5Kz
         RedCBHcr/NPXJiCG9TSZ5aYHhooNGIAuhcul1fKrU39TwfFdLABU+et9gbg2KaNxLV+r
         eS9w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=xXK7qddqEulsui7HmRcna0irGjW0+Rh83M7SHjXmerM=;
        b=NUrPJqUJ9mpU2JFst9lDFesb517+z3EzLS9XdniIbd6SnejrCVJOk7BTynroeCo74U
         sUMd8zmw/8J3elUzxH7nm4APQ9yfWEVGTVhJx5S+s8GgYwWgMFMH8MdYF6pdm7sJPakM
         OfJwGIe/8R2syjtX/s8Sre+TUrOA1PAfWLwUU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=xXK7qddqEulsui7HmRcna0irGjW0+Rh83M7SHjXmerM=;
        b=X3XN6R24A+FMhYscz1lGgVgHk4IrRbqBiyG9AQp/7L4OR+4mJM6iHubEXSjK+OBhTa
         /o3CoVATtyVPYo6+mYU80lcUQg1XNNnQvy7q+v/0JBuODS7PhLsRylOQb1zrQxnjfryA
         wacgP/spKtjYk3eHTjm43mi2aZR8uIVnagEQfztwF1+HcK726zS93doUxFRydUywTVPr
         J0mH271HkT1TDGyL6kqUr1m2LxutUddCOnTPcvFYYYmVgi9kiM40ezfJXtJ1zHMEHSoD
         2kXdj8SLfYP9RfWIIDNkKHQzo3Ezn4IYDW7HdEF9E7uDb2f1kbeIR43io93y6IsrziOh
         0KDQ==
X-Gm-Message-State: ALoCoQlWb1CXs3GtiI01t3rXALGtvpvzXR4OgMYfEraJ4rLTmLiBOGNN16FtkHBs2DB6BxW3HQdb
MIME-Version: 1.0
X-Received: by 10.50.138.73 with SMTP id qo9mr4967527igb.64.1438878930629;
 Thu, 06 Aug 2015 09:35:30 -0700 (PDT)
Received: by 10.64.236.98 with HTTP; Thu, 6 Aug 2015 09:35:30 -0700 (PDT)
In-Reply-To: <1438868614-7672-5-git-send-email-govindraj.raja@imgtec.com>
References: <1438868614-7672-1-git-send-email-govindraj.raja@imgtec.com>
        <1438868614-7672-5-git-send-email-govindraj.raja@imgtec.com>
Date:   Thu, 6 Aug 2015 09:35:30 -0700
X-Google-Sender-Auth: xqq8TuKOFwNxSXdbBW8gz4Z5rR0
Message-ID: <CAL1qeaG8bP4EKEHONAEpd+8CeNBDs=NPTrPzp8nfAAiV=gGzzA@mail.gmail.com>
Subject: Re: [PATCH 4/6] clk: pistachio: Set operating mode in .set_rate
From:   Andrew Bresticker <abrestic@chromium.org>
To:     Govindraj Raja <govindraj.raja@imgtec.com>
Cc:     Linux-MIPS <linux-mips@linux-mips.org>, linux-clk@vger.kernel.org,
        Mike Turquette <mturquette@linaro.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Zdenko Pulitika <zdenko.pulitika@imgtec.com>,
        Kevin Cernekee <cernekee@chromium.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hartley <James.Hartley@imgtec.com>,
        Damien Horsley <Damien.Horsley@imgtec.com>,
        James Hogan <James.Hogan@imgtec.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Content-Type: text/plain; charset=UTF-8
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48692
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

Govindraj,

On Thu, Aug 6, 2015 at 6:43 AM, Govindraj Raja
<govindraj.raja@imgtec.com> wrote:
> From: Zdenko Pulitika <zdenko.pulitika@imgtec.com>
>
> This commit sets operating mode of fractional pll based on
> the value of the fractional divider. Currently it assumes that
> the pll will always be configured in fractional mode which may not be
> the case. This may result in the wrong output frequency.
>
> Signed-off-by: Zdenko Pulitika <zdenko.pulitika@imgtec.com>
> Signed-off-by: Govindraj Raja <govindraj.raja@imgtec.com>

This seems like it should also be squashed with patch 3/6 (i.e. there
need only be a single patch to add integer-mode support to fractional
PLLs).

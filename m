Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 May 2015 00:17:18 +0200 (CEST)
Received: from mail-qk0-f177.google.com ([209.85.220.177]:35891 "EHLO
        mail-qk0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012557AbbEUWRPu9R5o (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 22 May 2015 00:17:15 +0200
Received: by qkx62 with SMTP id 62so823292qkx.3
        for <linux-mips@linux-mips.org>; Thu, 21 May 2015 15:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=S2cNuLt9eM3E265GY9yQYeQ3HLBChsBCShBkgsHgRnI=;
        b=omvsthX4naNWmbKVz4/AZXRGpIZZKmQmQ6K7Ba4kwqeKLuoPLoPmTPwBLYObQMcuId
         F8TvDkCpdeXZarQ/2oAbGY5rtfVmdhy1I7YL4mLSe1dCKArv81gTMVPccXytdBoEXAAK
         ccVnd89yKVc6hMFsEs4wvnDzswCXm7XmhWdD/Ps4ltBLLm2VOJ7u/q+q7IQP0YsgxC9i
         +JykkyqiQ4FAahRmTuWUSF3V5RcJzIig6XxHdxZyD5alFGpeBtVGQ0848wwvfgzLK0T5
         ZwnsFHuUbpngJZ/XNF7Q+ksCqDcwkC8Y5jTmYBHXF52nHOUA5b/NJNnNW21TAiVa4PPq
         wMPA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=S2cNuLt9eM3E265GY9yQYeQ3HLBChsBCShBkgsHgRnI=;
        b=b5Wo4Eobd/gSnKvBAN71K/Mha7JfC5gzPQac+L/6b1a5fl9U7xsqj/mGrUX0XC+nzq
         5R7yCLt98FBlyNiShInHY1LZS5hgf3tf5uKlCM3qDrdKJBfnUH700O8GlTyUd8l5VJBA
         5ZnPZ1oHJ5+u5mryAHzkBWdwEBKw5m/865VWA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=S2cNuLt9eM3E265GY9yQYeQ3HLBChsBCShBkgsHgRnI=;
        b=jhAFfQ/A2DDHx4VOfd8kUF1yYbDFpiuGtc7viITJMOMwBSNPTVIhTauCbq0j8zRWHV
         K7GPmHfaGi9sj3U7o6Riy9vQOdpj6d/63vzSxkk7s7dKkYuR3S3T2q738WCtBv9BrA+B
         7wJ0SAA4tg49hnLAbfYF8gG8D0HlSdyqlrnClstsgQijLbLZlncwMxWBnUCcqdWbr2Py
         IgLsFExcHOUGZO4s+Bi5sYYjEqJy0JluCnoVw82Ro4WCfm8IJEcS7reKwK6m5DSjs5Th
         Y12XCmep2whWwXWhiGOzaZEOhG3Pxp/xbPAnrSdL+rWQgtisfN2/4iIodpQJmNzDyJOd
         FigQ==
X-Gm-Message-State: ALoCoQnHCxN3vFsnhQyuYkzBoF8jprblX4+Vw3WVcbdT0sFv/xqz3wg5qCG/b17Hl6hCnXW7ctSK
MIME-Version: 1.0
X-Received: by 10.140.100.164 with SMTP id s33mr6940952qge.36.1432246632592;
 Thu, 21 May 2015 15:17:12 -0700 (PDT)
Received: by 10.140.23.72 with HTTP; Thu, 21 May 2015 15:17:12 -0700 (PDT)
In-Reply-To: <1432244260-14908-2-git-send-email-ezequiel.garcia@imgtec.com>
References: <1432244260-14908-1-git-send-email-ezequiel.garcia@imgtec.com>
        <1432244260-14908-2-git-send-email-ezequiel.garcia@imgtec.com>
Date:   Thu, 21 May 2015 15:17:12 -0700
X-Google-Sender-Auth: gKWccoHwoq3ILABzOQVwNMRoJE4
Message-ID: <CAL1qeaF-SARu1BzsJLZyhdiLvZn4KMxC9pLmZ7VuT2fTW5Y=AA@mail.gmail.com>
Subject: Re: [PATCH 1/7] clocksource: mips-gic: Enable the clock before using it
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
X-archive-position: 47530
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

On Thu, May 21, 2015 at 2:37 PM, Ezequiel Garcia
<ezequiel.garcia@imgtec.com> wrote:
> For the clock to be used (e.g. get its rate through clk_get_rate)
> it should be prepared and enabled first.
>
> Also, while the clock is enabled the driver must hold a reference to it,
> so let's remove the call to clk_put.
>
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@imgtec.com>

Reviewed-by: Andrew Bresticker <abrestic@chromium.org>

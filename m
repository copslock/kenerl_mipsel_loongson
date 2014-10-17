Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Oct 2014 10:17:52 +0200 (CEST)
Received: from mail-oi0-f46.google.com ([209.85.218.46]:38584 "EHLO
        mail-oi0-f46.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010871AbaJQIRqxi0bg (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 17 Oct 2014 10:17:46 +0200
Received: by mail-oi0-f46.google.com with SMTP id h136so218400oig.33
        for <linux-mips@linux-mips.org>; Fri, 17 Oct 2014 01:17:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=yIOjse0fv1Bx2LYjiLT0jZphQeGKl+u03bZy0MyBxsY=;
        b=R12x66+EXXqrevu94zzzPW+9tr8zvwaMWyB493jsB0nAzNMwkatTGqQS4OPPPXIokv
         NLIv8PW3yrWqu0IhXlWPDggQatex54fm2WI/sXjdLV/cZw2dUmgx3TbCKFZBb+a6lu3b
         /YNZuAgbIPdwWnHJUHVvA8YccVqoATeFPEgMV2/gE6t86gFsXiV0+GRQCK5QkWYJSlW9
         TwLHOtXkl1iLosBX3vJl7kRWGVx6FqqQaRLPMW/YaX4hEWshqpxQ04z/DRqMqaU+i/sS
         VmbjHMeJmNcZqQkvQXHigbXfu4UCzbRMOv+i8JKj0X8kMWJ4ZxByubBLvp4Rj4166r1B
         M7MA==
X-Gm-Message-State: ALoCoQk3pqMdJhwbCvl1LjVVypA+fZYOe17yB9WLXc73z1ISU+I8rYEjj1n7ZbtVZy8SOzn6HOhd
MIME-Version: 1.0
X-Received: by 10.60.178.229 with SMTP id db5mr5745018oec.28.1413533860556;
 Fri, 17 Oct 2014 01:17:40 -0700 (PDT)
Received: by 10.182.233.170 with HTTP; Fri, 17 Oct 2014 01:17:40 -0700 (PDT)
In-Reply-To: <1413527826-22906-1-git-send-email-keguang.zhang@gmail.com>
References: <1413527826-22906-1-git-send-email-keguang.zhang@gmail.com>
Date:   Fri, 17 Oct 2014 13:47:40 +0530
Message-ID: <CAKohpo=iRubshWkv0xj6DDomeR-wdYs3y2QebCgW5u-dvu0J3g@mail.gmail.com>
Subject: Re: [PATCH V2 6/6] cpufreq: Loongson1: Add cpufreq driver for Loongson1B
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Kelvin Cheung <keguang.zhang@gmail.com>
Cc:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-mips@linux-mips.org,
        Ralf Baechle <ralf@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <viresh.kumar@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43324
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: viresh.kumar@linaro.org
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

On 17 October 2014 12:07, Kelvin Cheung <keguang.zhang@gmail.com> wrote:
> V2:
>    Use devm_clk_get() instead of clk_get().

Search for a few drivers which have used this API and understand how
to use it.

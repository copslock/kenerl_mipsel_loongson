Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Oct 2014 06:46:19 +0200 (CEST)
Received: from mail-ob0-f175.google.com ([209.85.214.175]:57896 "EHLO
        mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010684AbaJQEqRl7iwr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 17 Oct 2014 06:46:17 +0200
Received: by mail-ob0-f175.google.com with SMTP id wn1so47922obc.20
        for <linux-mips@linux-mips.org>; Thu, 16 Oct 2014 21:46:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=7FJm33x1Mhk9Gt+eLhWHwuhTOmMUJwWN/dlB1U5jfec=;
        b=GrYOH3Aw3zms49pjc+ucBRJtQZn3kig4Ja0zD7C40fFah25zUB10mOn8zJqwqsi0MP
         Mpc+fhJBJsCHwYJ9nS/4IeGk6EvOLay4fRorIc8rOWW8tyM0Zc7ssI//zZzZY2qy5NnI
         RQG4QM8cAoq8ITZAcoC+Un4DRCyOY/VAS/h9rLXhB3L92/TzUuZFW8mSZyYodoo8z5bZ
         dlAwBbVnCi6lfZTf6LL56WUE1mMdnOnjKd2aM5cLJocQlRFdNVXlGWsDLu0d6A3n4FJD
         pnO2FQcO96iFeDJmjyFHcJV1t4NgJm7t5kW/MF1xFG1DLkH0pxPR7sogs9LIvRhF0CVA
         EmYA==
X-Gm-Message-State: ALoCoQkIZph8RXt1PmoRPbGeGjoYT6z2vdC4gBHhnkeg9iVpm+LeY8AmIYCiMph9hm6Hw/LwnCXf
MIME-Version: 1.0
X-Received: by 10.202.211.133 with SMTP id k127mr4515742oig.53.1413521171315;
 Thu, 16 Oct 2014 21:46:11 -0700 (PDT)
Received: by 10.182.233.170 with HTTP; Thu, 16 Oct 2014 21:46:11 -0700 (PDT)
In-Reply-To: <20141016180355.GA14194@drone.musicnaut.iki.fi>
References: <1413357812-16895-1-git-send-email-keguang.zhang@gmail.com>
        <20141016180355.GA14194@drone.musicnaut.iki.fi>
Date:   Fri, 17 Oct 2014 10:16:11 +0530
Message-ID: <CAKohpomjWt8fKU9=bT5fva+Qr_vJBg0cMWH1WcDFp_1NneV+qQ@mail.gmail.com>
Subject: Re: [PATCH 6/6] cpufreq: Loongson1: Add cpufreq driver for Loongson1B (UPDATED)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Aaro Koskinen <aaro.koskinen@iki.fi>
Cc:     Kelvin Cheung <keguang.zhang@gmail.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-mips@linux-mips.org,
        Ralf Baechle <ralf@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <viresh.kumar@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43317
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

On 16 October 2014 23:33, Aaro Koskinen <aaro.koskinen@iki.fi> wrote:
> Why it's called "ls1x-cpufreq" instead of "loongson1_cpufreq"?

This is what Kelvin told me when I asked him the same query:

Other drivers of loongson1 are already named *ls1x*, such as
clk-ls1x.c and rtc-ls1x.c.
So I just keep pace with them.

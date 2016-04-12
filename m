Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 Apr 2016 07:18:20 +0200 (CEST)
Received: from mail-pf0-f180.google.com ([209.85.192.180]:34261 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27014228AbcDLFSRnrgL2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 12 Apr 2016 07:18:17 +0200
Received: by mail-pf0-f180.google.com with SMTP id c20so6671770pfc.1
        for <linux-mips@linux-mips.org>; Mon, 11 Apr 2016 22:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3MJrxH3V9Gwy+ZXkvDnqYvzFmaMX6QKp86B0oU1InCY=;
        b=O0vqa7zVsd7lYOQAY7xPVWJ4acm5QGjTfRXUIbFwjMf1rckcYm55HanEFmh4UfK18P
         61BJfXwNqlGgEwQD2EuqgQiBZaQN+lKVDLueeSP2E088Mg1PiVAHaW8Y5Lf83XbL+LCn
         MK4BLhsnod4IiBb8yeiqa8QUSrfpC0k/BPnTo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3MJrxH3V9Gwy+ZXkvDnqYvzFmaMX6QKp86B0oU1InCY=;
        b=br7abDqnjCfhMVH5V/QcoDAkqhFlHd1c3bTm4aTXyBarLwNgcb/Qqpo5ViZjCb9x10
         /C8OyN2iykbW7f7Qm8G11uRXdBPHEEi0BZR3+l9t8VjPZkLJgNk1ibNMcJq6blGJc/VN
         ekKIuMG7EYBL0qBRQ64+iGcUndC41sPoSKDJobOn1mUHHi/Pvmh0hXA7EtXEQnqxQ15X
         yRP3BMpgQVx4Hlxla4v4vdljUEw5FhKXqXmAiC722zdo8mIRHsSfAuVwhCIfrofnXtwH
         vEDaxSwSuSqUClCLMq/nU3lg0S56pvwifaaBpaTI3yprKcB4HLbsZSyndiIM7CvC+0J5
         5b+Q==
X-Gm-Message-State: AOPr4FVmMbfG2oWOOgRYOp3cl1XSrfxJVEz9OVTMFxtwRcHke/HlSEzR37ukjKugewrEJTLQ
X-Received: by 10.98.1.197 with SMTP id 188mr1963956pfb.8.1460438292036;
        Mon, 11 Apr 2016 22:18:12 -0700 (PDT)
Received: from localhost ([122.172.42.224])
        by smtp.gmail.com with ESMTPSA id fn3sm39970509pab.20.2016.04.11.22.18.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Apr 2016 22:18:11 -0700 (PDT)
Date:   Tue, 12 Apr 2016 10:48:09 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Keguang Zhang <keguang.zhang@gmail.com>
Cc:     linux-pm@vger.kernel.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 2/5] cpufreq: Loongson1: Replace kzalloc() with kcalloc()
Message-ID: <20160412051809.GP16238@vireshk-i7>
References: <1460375759-20705-1-git-send-email-keguang.zhang@gmail.com>
 <1460375759-20705-2-git-send-email-keguang.zhang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1460375759-20705-2-git-send-email-keguang.zhang@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Return-Path: <viresh.kumar@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52955
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

On 11-04-16, 19:55, Keguang Zhang wrote:
> From: Kelvin Cheung <keguang.zhang@gmail.com>
> 
> This patch replaces kzalloc() with kcalloc() when allocating
> frequency table, and remove unnecessary 'out of memory' message.
> 
> Signed-off-by: Kelvin Cheung <keguang.zhang@gmail.com>
> ---
>  drivers/cpufreq/loongson1-cpufreq.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

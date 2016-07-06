Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Jul 2016 16:14:57 +0200 (CEST)
Received: from mail-pa0-f47.google.com ([209.85.220.47]:33827 "EHLO
        mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992178AbcGFOOszI5eQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 6 Jul 2016 16:14:48 +0200
Received: by mail-pa0-f47.google.com with SMTP id bz2so76996426pad.1
        for <linux-mips@linux-mips.org>; Wed, 06 Jul 2016 07:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ThuNqPkmY3DCjljVZcTvQdZlDxeWi/ffFfvgNj7Kz6c=;
        b=b/G+uXarbFKV8SlvhdDSUGeFDayoh9ZbCgdybVU6W7eFnf351N5QVMt9Au4yHErK3U
         vm4swWfd1IWXKTohc9zWQPM6MMP8K03FGjTLKBF2cm3HpnfI/5+oXCAlhoeZWjtH4bmf
         U9Jl0bXCMaCE1CA8cJgn4wGjuJFl/nmTBvS3M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ThuNqPkmY3DCjljVZcTvQdZlDxeWi/ffFfvgNj7Kz6c=;
        b=nBS10smvZ7pmMnW/MAeqeaPRBQrTyzTTnXDC8PgIGyvqHWwljwON0a8g2sHgaeC19R
         05VBYk8KejzV1GXOmCjuxN+hTR0fvqbqBdeRY4XXNlG6ofyaQpZpWAUU607J/6JR3cnb
         X3isNfcNEbd563+aZ/zRRkvw9u7UIB1/uDvGVUZCPtNf6gJWwhwsGJQ5+VWsmG4HoXxs
         er91eqKfijXsyum4XI4iIemJRNcUquXpZJuVH8Ssom5UevQ/Aw2Hp2I4c7eR7N++Yynv
         sany7HDMvtrtsUYf5iBt+q9k5T+6TlDiHuB96Mp/uGPNZFUjcOobo5gG5IAkbiGyhT9A
         If1Q==
X-Gm-Message-State: ALyK8tIv7ep847tcA+tkJZVF6l/cmc8i5euoyKb7dHoyW0qHdqrefR2CUHosKqZB5QaU5dek
X-Received: by 10.66.175.45 with SMTP id bx13mr39337923pac.23.1467814482962;
        Wed, 06 Jul 2016 07:14:42 -0700 (PDT)
Received: from localhost ([12.201.7.201])
        by smtp.gmail.com with ESMTPSA id x67sm4309092pff.47.2016.07.06.07.14.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Jul 2016 07:14:42 -0700 (PDT)
Date:   Wed, 6 Jul 2016 07:14:41 -0700
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     weiyj_lk@163.com
Cc:     Keguang Zhang <keguang.zhang@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Wei Yongjun <yongjun_wei@trendmicro.com.cn>,
        linux-mips@linux-mips.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH -next] CPUFREQ: Loongson1: Fix return value check in
 ls1x_cpufreq_probe()
Message-ID: <20160706141441.GJ2671@ubuntu>
References: <1467807655-31952-1-git-send-email-weiyj_lk@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1467807655-31952-1-git-send-email-weiyj_lk@163.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Return-Path: <viresh.kumar@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54231
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

On 06-07-16, 12:20, weiyj_lk@163.com wrote:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> 
> In case of error, the function clk_get_parent() returns NULL pointer
> not ERR_PTR(). The IS_ERR() test in the return value check should be
> replaced with NULL test.

NULL is a valid clock as per the clk-API and so this patch is wrong.

You need to investigate why you are getting NULL here for your
platform.

-- 
viresh

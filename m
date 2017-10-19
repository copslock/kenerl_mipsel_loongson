Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Oct 2017 15:31:53 +0200 (CEST)
Received: from mail-wr0-x242.google.com ([IPv6:2a00:1450:400c:c0c::242]:49606
        "EHLO mail-wr0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992540AbdJSNbp4FyjJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 19 Oct 2017 15:31:45 +0200
Received: by mail-wr0-x242.google.com with SMTP id g90so8342947wrd.6
        for <linux-mips@linux-mips.org>; Thu, 19 Oct 2017 06:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nuCflSJe96O+PZXYTM7dAysyMlzuH1JeC+RAVMd2k/U=;
        b=DSzKuLbIGVBWbRz+EE9Sv3gVQMFyAxkPgvaOF4avCM2mmKQ2FWQG2mikszXrMiAwLd
         ub2BfpK+Psz+XzaWdEoZRLGwTG1YMhGAqEQIXQGjcCAjtxTtpeQ4p9Ohv3LOSK9wCSGd
         Zp85hPrp3zj2KhekFwVgZr1HUKafpZs88iuq8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nuCflSJe96O+PZXYTM7dAysyMlzuH1JeC+RAVMd2k/U=;
        b=LTGlEJuHOHn5fZsCBVQfhStkJwn5/2TGHzvc/J/OaJH9f/kwNSQ5lBqPvH/PO31jOZ
         bAqHQSDdaID5kSde8f+/K0l23CrTjGMHv3pipSc24YOBbHQew3vBHkJZkPFOA7GlYTd7
         mTvd0cmBjebFsBskOLOnQtini4nsVd3mPWhFjXXcnB+0JxaIJgmrOad6s/gaspFvS/TP
         CLOn/VUTcv6/m2Pc9cIp07IyK7d8EVmloobaT9SowkI+Yqqcmc75Pw/L12bO9IcClHyx
         1745ZzreREble4IcoTAtr+BHqCnLPLe44sqCbYQjMR1xzP3VsxV0ZWQRXL7xRM/8S51I
         Wrvg==
X-Gm-Message-State: AMCzsaU3WQCRCdnjSZda7dPAsghwlpwMGT7KXVN26GUgSiZ+D1+jLwDS
        8HvhUgsbNx8dLxVhytwmOgstpw==
X-Google-Smtp-Source: ABhQp+Rzu2iS23yQgZ5oXDeCPb6m6QfQmVMJWIq5uPFB/Z6GAqVNX77wFdvL9qs3UerdHociZCol7Q==
X-Received: by 10.223.198.82 with SMTP id u18mr1734285wrg.5.1508419900519;
        Thu, 19 Oct 2017 06:31:40 -0700 (PDT)
Received: from ?IPv6:2a01:e35:879a:6cd0:3e97:eff:fe5b:1402? ([2a01:e35:879a:6cd0:3e97:eff:fe5b:1402])
        by smtp.googlemail.com with ESMTPSA id 200sm2340648wmu.44.2017.10.19.06.31.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Oct 2017 06:31:40 -0700 (PDT)
Subject: Re: [PATCH V2 3/3] clocksource: mips-gic-timer: Add fastpath for
 local timer updates
To:     Matt Redfearn <matt.redfearn@mips.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     James Hogan <james.hogan@mips.com>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
References: <1508414135-29123-1-git-send-email-matt.redfearn@mips.com>
 <1508414135-29123-3-git-send-email-matt.redfearn@mips.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <6bc1684a-a964-ad52-b107-44b1a44e7251@linaro.org>
Date:   Thu, 19 Oct 2017 15:31:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <1508414135-29123-3-git-send-email-matt.redfearn@mips.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Return-Path: <daniel.lezcano@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60470
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: daniel.lezcano@linaro.org
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

On 19/10/2017 13:55, Matt Redfearn wrote:
> Always accessing the compare register via the CM redirect region is
> (relatively) slow. If the timer being updated is the current CPUs
> then this can be shortcutted by writing to the CM VP local region.
> 
> Signed-off-by: Matt Redfearn <matt.redfearn@mips.com>
> ---

Applied this one for 4.15 also.

Thanks.

  -- Daniel


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

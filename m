Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 May 2018 14:49:45 +0200 (CEST)
Received: from mail-wm0-x241.google.com ([IPv6:2a00:1450:400c:c09::241]:40381
        "EHLO mail-wm0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992604AbeENMthRiRM5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 14 May 2018 14:49:37 +0200
Received: by mail-wm0-x241.google.com with SMTP id j5-v6so14984260wme.5
        for <linux-mips@linux-mips.org>; Mon, 14 May 2018 05:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=psJoXSxQlxnT27PiR/P8+dANre+mkQyv7iV1A4jGqaQ=;
        b=Bdp8peGOKehtkTER19FpkV86hRfgzCroO28xLiUetrTNSuPpCsjtz872O1ah9XJwOO
         Vg2SYrgwwXq/4M6o1SvFdb77YAX/fnWLN3MHl2taadrP/mtjdjXT8iEotrOxUvilBsGU
         Dn+9+OBaBhi9TRfPZl9fOOwnuCDONyujl9cb4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=psJoXSxQlxnT27PiR/P8+dANre+mkQyv7iV1A4jGqaQ=;
        b=XUbnRzVD3ukUxq0KxmHMCop/9PX/MI5WK/BbabJ2okdmZoqd+yN+ioH3RTFLyZ6gTv
         ekzwBoI8/wM5gm0qnFSCeUk28zIu6p/hdB4sAPQ2HyePq2rX0QGsfNr5RRIZmLaYo2ic
         OlR7t9lUZH86KRFtSGgy8iFWWrv5LeBhy/ioPxekwLuKGNeuiQkjoV56BnZOsgewNnqp
         VhtgdvpVWoQLvFVxoocCO1IT7m22FnSDnYQkwwc1TlVrOX2jBrPtIldDriEsvr3i9D2E
         hujJX+zUP0i7DdRkDOzDZh5JlERLT0d2KZzTslCi8Evp6VnW1ugJQCP/IvOKRi5fBcAA
         X3MA==
X-Gm-Message-State: ALKqPwf4vsEmYdff9DgcHn/Dwv61Kov3n5t37uaG/mgNTJMoC+2j/t0x
        uTa+Z4j2W7XaUw7I9Yr4l5Wt0A==
X-Google-Smtp-Source: AB8JxZrJq8In87Jkej02APHbR5/qtTv6YQR+Nogx5iNajnJDxG1IajDh3fuIQ4m7Tg09+gmlALRuog==
X-Received: by 2002:a1c:8583:: with SMTP id h125-v6mr4874220wmd.98.1526302171786;
        Mon, 14 May 2018 05:49:31 -0700 (PDT)
Received: from mai (lft31-1-88-121-166-205.fbx.proxad.net. [88.121.166.205])
        by smtp.gmail.com with ESMTPSA id 141-v6sm9431493wmf.35.2018.05.14.05.49.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 May 2018 05:49:31 -0700 (PDT)
Date:   Mon, 14 May 2018 14:49:28 +0200
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     Matt Redfearn <matt.redfearn@mips.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] clocksource/drivers/mips-gic-timer: Add pr_fmt and
 reword pr_* messages
Message-ID: <20180514124928.GF29062@mai>
References: <1513781406-27292-1-git-send-email-matt.redfearn@mips.com>
 <1522316943-2542-1-git-send-email-matt.redfearn@mips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1522316943-2542-1-git-send-email-matt.redfearn@mips.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Return-Path: <daniel.lezcano@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63931
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

On Thu, Mar 29, 2018 at 10:49:03AM +0100, Matt Redfearn wrote:
> Several messages from the MIPS GIC driver include the text "GIC", "GIC
> timer", etc, but the format is not standard. Add a pr_fmt of
> "mips-gic-timer: " and reword the messages now that they will be
> prefixed with the driver name.
> 
> Signed-off-by: Matt Redfearn <matt.redfearn@mips.com>
> ---

Applied, thanks for the head up.

  -- Daniel

-- 

 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

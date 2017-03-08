Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Mar 2017 10:42:18 +0100 (CET)
Received: from mail-wm0-x242.google.com ([IPv6:2a00:1450:400c:c09::242]:36118
        "EHLO mail-wm0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991960AbdCHJmLekN3b (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 8 Mar 2017 10:42:11 +0100
Received: by mail-wm0-x242.google.com with SMTP id v190so5048025wme.3
        for <linux-mips@linux-mips.org>; Wed, 08 Mar 2017 01:42:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=5G2SCUIj7Lw1uzgZCeNBYUWaQ1h5F+hDHBRhWrIS/gY=;
        b=BjfYZEb22bEo/zFYn3F9v2G1zgShcY81E28fhqagBApJ3bqg5RfeiJdPGrsoi+UwID
         sfOb1QjGKy9CcXX5K+M8UZXJ/Ij1a8P5rLJDe3fJRCrmvwszTLzNiYCW9Ci+8P2Z0mCx
         acyf1y0YylgoYeeIr2OfkYMbRhrg9Tb5BWO/jHQO0usW4pqesVWn/BqguLZKPEHfaXEb
         xcvdu6ZcWiUdyVi9XbnOJMzu9j1VV517Q1qZEQgFIOlWt+ND5BUKPsMHO3uX4JLYGydb
         ywAtRE2Dl8Cn4YgEsJCJD8ASPE5UqNOIh1ixldgCT/OspW50CA5TFaGUUlgDNG+737Od
         jKWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=5G2SCUIj7Lw1uzgZCeNBYUWaQ1h5F+hDHBRhWrIS/gY=;
        b=bV8pPcQUWGxGfd6vxCO702Q0HOplVWBK5JJIccNVxppF6fGcZN2ymWOaNvoBC811Yr
         b8zkbqnlaBdVXf8ixOEWgdyxb+wyKlKzO1pRwwzwNDcGK30PVi1vRsF3SU2IFJ6Ns+yB
         TRQiCrDQJ93V7z0Y3qwSeTi7hJTuz5oijSJu02UxYnByZYTfEmzeur4d0JA94wPpsEeP
         vWtNsOk1J3R3VjnYhQj0XBxbKzZg36dxv4eTeVIOP5f22ePrRECEt5/HlZKeJsWlz9c3
         TLV+gjV5ZAZg0QSkAe+1rLX0+ZdaTjJ169Tvr5RvXSLYCxZo8juNkNYVissPYqacc+Ro
         B4LQ==
X-Gm-Message-State: AMke39nq9fFhp+BJVJHOiFpHvENAV5z5U+NiIvBy7MHV2C+7s/haaVHqev0t+MJhc6uT9Q==
X-Received: by 10.28.214.146 with SMTP id n140mr4598468wmg.58.1488966126299;
        Wed, 08 Mar 2017 01:42:06 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id m29sm3406157wrm.38.2017.03.08.01.42.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Mar 2017 01:42:05 -0800 (PST)
Date:   Wed, 8 Mar 2017 10:42:03 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     "kernelci.org bot" <bot@kernelci.org>,
        kernel-build-reports@lists.linaro.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        gregkh <gregkh@linuxfoundation.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-mips@linux-mips.org, Ingo Molnar <mingo@redhat.com>
Subject: Re: next build: 208 builds: 21 failed, 187 passed, 53 errors, 406
 warnings (next-20170308)
Message-ID: <20170308094203.GA1523@gmail.com>
References: <58bf7d43.8173190a.8d21e.1fde@mx.google.com>
 <CAK8P3a16cpvK3_a0Rxx+XqRw_d97LtVgpzcpvpzmH6U4Ty-fXQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK8P3a16cpvK3_a0Rxx+XqRw_d97LtVgpzcpvpzmH6U4Ty-fXQ@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Return-Path: <mingo.kernel.org@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57084
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mingo@kernel.org
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


* Arnd Bergmann <arnd@arndb.de> wrote:

> > bmips_be_defconfig (mips) — FAIL, 1 error, 1 warning, 0 section mismatches
> >
> > Errors:
> > arch/mips/kernel/smp-bmips.c:183:38: error: implicit declaration of function
> > 'task_stack_page' [-Werror=implicit-function-declaration]
> 
> A new regression from the end of the merge window, also present in mainline.
> I sent a fix yesterday, addressing various mips build failures.

Haven't heard from Ralf yet, so I've applied your patch to tip:core/urgent and 
will get it to Linus ASAP (i.e. later today), to minimize the size of the 
build-breakage window.

Thanks,

	Ingo

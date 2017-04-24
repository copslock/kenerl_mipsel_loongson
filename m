Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 Apr 2017 15:08:32 +0200 (CEST)
Received: from mail-pf0-x242.google.com ([IPv6:2607:f8b0:400e:c00::242]:35454
        "EHLO mail-pf0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993543AbdDXNIXLs-Rm (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 24 Apr 2017 15:08:23 +0200
Received: by mail-pf0-x242.google.com with SMTP id a188so3793816pfa.2
        for <linux-mips@linux-mips.org>; Mon, 24 Apr 2017 06:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+iNST1/QWpzWac09rL44mJ/SBqS6eCGENNJeEFEX/eU=;
        b=sxOUpGPGogUvkJi+xJF6dUA5R4OvxjtxhPkibq/j6iuGixM5WllhRsKgy3P3GlJ+mc
         39FQcYgynPXUUXNm09E9SVaLDhNeOXl6cDV3mtMibbEUzhkSwnHHnokoV3+3KCjGVny6
         /yyLDhN/FNsk1kpwZt3ZMOhfprhX6nFUrguBPte9sRLqjBYbpu4jumSYAVRNv87YnWUU
         7fk0abHkR8oi3XWhOsH+w77MIIEI1kYSqqVhR3TcckUrLuxDv/aP6HP/+B+Rm7mo26LE
         8EuV9QLysBZbvdKTWXEF1M3HWTF24gxCrD6FsRXhxF0zbBBN5x8uWtgQUZEJWSGoTPdt
         XRvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+iNST1/QWpzWac09rL44mJ/SBqS6eCGENNJeEFEX/eU=;
        b=hbMHNZUKY3ukIBZcr5TkR+8bR8YK0EQ+YbItynKx9lzB8B89GaIEADNcIwCs6ETSKm
         OW1Ku+rKfWJHIWbxP+OfCTWWZpNojZwdXn5uAwxNre2Mo/WatDFfsdklLH1oNL5HzF0u
         BfzAqbEdvv+0sFIkcHYspEMGkcuqGeBii3mF6w0RqvTsIi3VbFE41aVNMzinmJlvMpMG
         HipfHNnXoLGHHQiKodwJeLkhkT1Ba0BNtPv4LLxY7Hxo7F5qt56nfXQ2P3n/Y9JUUlge
         xQGTnHNgjNBDNDZRKmrblOlpLek1OfrTln5Ybjdm9jPZgHDCymcXCsS/y0Gj2SD60D05
         0/Fw==
X-Gm-Message-State: AN3rC/6RmTCUedS1ARwZjgGFwnwjDgzZpCJuC2E63O0JmiBdvI5BxZ7G
        tHAjzZ13JHPRPg==
X-Received: by 10.99.104.6 with SMTP id d6mr15394869pgc.185.1493039297309;
        Mon, 24 Apr 2017 06:08:17 -0700 (PDT)
Received: from mint-host ([180.102.125.8])
        by smtp.gmail.com with ESMTPSA id q85sm31040656pfj.112.2017.04.24.06.08.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Apr 2017 06:08:16 -0700 (PDT)
From:   Yang Ling <gnaygnil@gmail.com>
X-Google-Original-From: Yang Ling <gnaygnail@gmail.com>
Date:   Mon, 24 Apr 2017 21:08:09 +0800
To:     Marcin Nowakowski <marcin.nowakowski@imgtec.com>
Cc:     Yang Ling <gnaygnil@gmail.com>, thierry.reding@gmail.com,
        keguang.zhang@gmail.com, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH 1/2] pwm: loongson1: Add PWM driver for Loongson1 SoC
Message-ID: <20170424130809.GA3998@mint-host>
References: <20170213152801.GA32019@ubuntu>
 <f27d34d4-b0ac-2fd6-bc75-89a6c913ba3c@imgtec.com>
 <20170215130902.GA32795@ubuntu>
 <0d0c43f5-1016-4cb5-01f8-9ca82860b8ad@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0d0c43f5-1016-4cb5-01f8-9ca82860b8ad@imgtec.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Return-Path: <gnaygnil@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57769
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gnaygnil@gmail.com
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

Hi, Marcin,

I am sorry for the late reply.

On Thu, Feb 16, 2017 at 10:27:15AM +0100, Marcin Nowakowski wrote:
> Hi Yang,
> 
> On 15.02.2017 14:09, Yang Ling wrote:
> 
> >>>+	tmp = (unsigned long long)clk_get_rate(pc->clk) * period_ns;
> >>>+	do_div(tmp, 1000000000);
> 
> NSEC_PER_SEC ?
> 
Indeed, NSEC_PER_SEC should be used.

> >>>+	period = tmp;
> >>>+
> >>>+	tmp = (unsigned long long)period * duty_ns;
> >>>+	do_div(tmp, period_ns);
> >>>+	duty = period - tmp;
> >>>+
> >>>+	if (duty >= period)
> >>>+		duty = period - 1;
> >>>+
> >>>+	if (duty >> 24 || period >> 24)
> >>>+		return -EINVAL;
> >>>+
> >>>+	chan->period_ns = period_ns;
> >>>+	chan->duty_ns = duty_ns;
> >>>+
> >>>+	writel(duty, pc->base + PWM_HRC(pwm->hwpwm));
> >>>+	writel(period, pc->base + PWM_LRC(pwm->hwpwm));
> >>>+	writel(0x00, pc->base + PWM_CNT(pwm->hwpwm));
> >>>+
> >>
> >>PWM_HRC and PWM_LRC names suggest that you're using high/low state
> >>counters here rather than duty/period - but with no documentation
> >>I'm just guessing here.
> >
> >Indeed, the high/low state counters is used here.
> >Change the name to duty_cnt/period_cnt.
> >
> >
> 
> What I was referring to here is that if you have a high/low value counters
> that you enter then these are not the same as duty/period, in simple terms:
> high_cnt = duty_cnt
> low_cnt = period_cnt - duty_cnt
> 
> so please double check that this is what you want to be doing? As the names
> used suggest that this code may be wrong. Or maybe what you're doing is
> correct but the register access macros have misleading names?
>
The macro definition of the register here is misleading.
I will fix these problems afterwards.

Thanks for your friendly reminder.

Yang

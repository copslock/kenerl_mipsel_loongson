Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 31 Mar 2013 06:01:15 +0200 (CEST)
Received: from mail-ob0-f182.google.com ([209.85.214.182]:43166 "EHLO
        mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6817030Ab3CaEBNkmQYn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 31 Mar 2013 06:01:13 +0200
Received: by mail-ob0-f182.google.com with SMTP id ef5so1171215obb.41
        for <linux-mips@linux-mips.org>; Sat, 30 Mar 2013 21:01:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:x-gm-message-state;
        bh=Ct/iCRcHDKH7mkZKyGehpLL3i+6r6VIc9+BJjWoFeVI=;
        b=MkGTHI9M6yc8zER7Y/fHxSwUz5BatEZd/PwHuUSfqkwVhKLPVXVXDSN/sekwOmuyDb
         +fLX4rhqttpd/1wvyJyqSWXFUkZDqb5fqb3jJEXGUqgrqKn8LiKr+LPQQPpD7Iyo3CPC
         4KnDjloC3V7TCqkmAoHcY8akpi+Sg/NdWQBrBdx8jlwbVqfdDGDY4RXQd5EtbL7GAiM2
         pmmeBaNgAXZH2dbkfZ9trN4FMXNOXTUXjCbuV94d87Eisk9fxJ9u71m43vWJV3yAfGX2
         18rKPdWNQb2bQMJ2rwW6T30jhQVHG+sJh+hxMODbe6al0kYADs53zNVQdqkCz7NJaCQO
         DSPw==
MIME-Version: 1.0
X-Received: by 10.182.164.73 with SMTP id yo9mr2603395obb.28.1364702467175;
 Sat, 30 Mar 2013 21:01:07 -0700 (PDT)
Received: by 10.182.52.198 with HTTP; Sat, 30 Mar 2013 21:01:07 -0700 (PDT)
In-Reply-To: <199e0d0a282290544ff562b904a0028a104aad45.1364229828.git.viresh.kumar@linaro.org>
References: <cover.1364229828.git.viresh.kumar@linaro.org>
        <199e0d0a282290544ff562b904a0028a104aad45.1364229828.git.viresh.kumar@linaro.org>
Date:   Sun, 31 Mar 2013 09:31:07 +0530
Message-ID: <CAKohpom4sckvmB12=KRX4aMJDJjpT=nN++_xyL=p_0ZY7v6oMQ@mail.gmail.com>
Subject: Re: [PATCH 5/9] mips: cpufreq: move cpufreq driver to drivers/cpufreq
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Cc:     arvind.chauhan@arm.com, robin.randhawa@arm.com,
        Steve.Bannister@arm.com, Liviu.Dudau@arm.com,
        charles.garcia-tobin@arm.com, cpufreq@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linaro-kernel@lists.linaro.org, arnd.bergmann@linaro.org,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J. Wysocki" <rjw@sisk.pl>
Content-Type: text/plain; charset=ISO-8859-1
X-Gm-Message-State: ALoCoQnzjwbQ0xKr9cuLis6Ua+hERLnxqAsL/UCTOU9mU7uGCZKYCYE2eRX0V8FnSx32FgXE3MBk
X-archive-position: 35998
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On 25 March 2013 22:24, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> This patch moves cpufreq driver of MIPS architecture to drivers/cpufreq.
>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: linux-mips@linux-mips.org
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  arch/mips/Kconfig                                  |  9 ++++-
>  arch/mips/kernel/Makefile                          |  2 --
>  arch/mips/kernel/cpufreq/Kconfig                   | 41 ----------------------
>  arch/mips/kernel/cpufreq/Makefile                  |  5 ---
>  drivers/cpufreq/Kconfig                            | 18 ++++++++++
>  drivers/cpufreq/Makefile                           |  1 +
>  .../kernel => drivers}/cpufreq/loongson2_cpufreq.c |  0
>  7 files changed, 27 insertions(+), 49 deletions(-)
>  delete mode 100644 arch/mips/kernel/cpufreq/Kconfig
>  delete mode 100644 arch/mips/kernel/cpufreq/Makefile
>  rename {arch/mips/kernel => drivers}/cpufreq/loongson2_cpufreq.c (100%)

Ralf or any other mips guy,

Can i have your ack or comments for this patch?

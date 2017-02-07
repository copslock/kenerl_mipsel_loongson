Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Feb 2017 13:42:39 +0100 (CET)
Received: from mail-ot0-x243.google.com ([IPv6:2607:f8b0:4003:c0f::243]:34979
        "EHLO mail-ot0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992127AbdBGMmbsy5-B (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 7 Feb 2017 13:42:31 +0100
Received: by mail-ot0-x243.google.com with SMTP id 65so13981515otq.2;
        Tue, 07 Feb 2017 04:42:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=iafsU0kDCanncU6cjXcEqVzu20Xus7LJ3cxPmuXIibc=;
        b=o64nvMVNJHzCRmRykt1Wd8cvEGLFg9+dL3QietxIJYuraOxDV6H1pcRrBJ8ewUef8d
         To+E+lGft6bUJUK1BmnRlguCXcxABl9qG9uKZGoyOZFX5I4o9W/UIo6r0bpPwXtY57c0
         flYMbkXObI+XX5P5cve1XdYS1VLVDg+0PJELLmH/R5W1v9RY7JFiByx06kMlL05W0qgR
         Qyhdwo+m8NB7tTfFCR7K6WON69sN20iQ80JotyqlajedauNKaIp/I5g0eNCunenqBecu
         uErHrFBTzU9Ife6PAg6aNZrQrmdbnmR/sAK0Vf8gBG5NnNJcAybHjDkuuFASRrt0I+0I
         nCJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=iafsU0kDCanncU6cjXcEqVzu20Xus7LJ3cxPmuXIibc=;
        b=psO/CBXSFdtjFQD1igpk8N+9z6CBT5+53LOG/1e+VKArJLtQmbNrhOiGGaAzuA33Kn
         H7Sw3TMBMtRFZoHTZ0LVF4Ps3+90tewBIgVK/WiRYlaaF+GxrHIDQSP9saBd/byz3qwq
         TjvtC3MZKqDhmbGIzI3mdQAEPWEg04RjopzYdHeQRn2l42yti9YGiNyBcAzM1cQX7Raj
         yWqV8oVivaeNRHXzJiiIw9ClAG7+mxATTIgwV1rzjrw0AXR6224ISnRHb4WAFFcHeuTl
         0wKQxqK/AQuKkAbd/HSo5xbblA5m1Y4mDaYbj9Nlssw0niQzK6NiA/7pqcBSf6ri/k3P
         ocCg==
X-Gm-Message-State: AMke39nfjjANhdas7yBxPwEbvC7uou90Pquck+6Sl1mqHCDI769f1L1ihDTdKmnvCrO8gGfBFSukxx7V0JrBkw==
X-Received: by 10.157.62.29 with SMTP id a29mr8618524otd.48.1486471346033;
 Tue, 07 Feb 2017 04:42:26 -0800 (PST)
MIME-Version: 1.0
Received: by 10.157.12.152 with HTTP; Tue, 7 Feb 2017 04:42:25 -0800 (PST)
In-Reply-To: <20170206215119.87099-3-code@mmayer.net>
References: <20170206215119.87099-1-code@mmayer.net> <20170206215119.87099-3-code@mmayer.net>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 7 Feb 2017 13:42:25 +0100
X-Google-Sender-Auth: aHnPwMJGuTk0uTyi30qHs_1xGwY
Message-ID: <CAJZ5v0j2qcQyZctjq4xEpM2QTjpw_DnH8+Knt2o0PpsqgZUL7g@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] BMIPS: Enable prerequisites for CPUfreq in MIPS Kconfig.
To:     Markus Mayer <code@mmayer.net>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Markus Mayer <mmayer@broadcom.com>,
        MIPS Linux Kernel List <linux-mips@linux-mips.org>,
        Power Management List <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <rjwysocki@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56697
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rafael@kernel.org
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

On Mon, Feb 6, 2017 at 10:51 PM, Markus Mayer <code@mmayer.net> wrote:
> From: Markus Mayer <mmayer@broadcom.com>
>
> Turn on CPU_SUPPORTS_CPUFREQ and MIPS_EXTERNAL_TIMER for BMIPS.
>
> Signed-off-by: Markus Mayer <mmayer@broadcom.com>

An ACK from the MIPS maintainers is requisite here.

> ---
>  arch/mips/Kconfig | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index b3c5bde..e137eed 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -1703,6 +1703,8 @@ config CPU_BMIPS
>         select WEAK_ORDERING
>         select CPU_SUPPORTS_HIGHMEM
>         select CPU_HAS_PREFETCH
> +       select CPU_SUPPORTS_CPUFREQ
> +       select MIPS_EXTERNAL_TIMER
>         help
>           Support for BMIPS32/3300/4350/4380 and BMIPS5000 processors.
>
> --

Thanks,
Rafael

Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Feb 2017 05:19:47 +0100 (CET)
Received: from mail-pf0-x22c.google.com ([IPv6:2607:f8b0:400e:c00::22c]:35042
        "EHLO mail-pf0-x22c.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992036AbdBGETklHR1J (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 7 Feb 2017 05:19:40 +0100
Received: by mail-pf0-x22c.google.com with SMTP id f144so29508548pfa.2
        for <linux-mips@linux-mips.org>; Mon, 06 Feb 2017 20:19:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LBeGkd4yxWA+5znfziEDZk4GnNBDI0eool+qm+cp898=;
        b=Wg6xfklsdzpnNN5StrskvoW99kz1s1hKe2b+BjY97CKwOkOWpsgrOQ85z0fRrYkBRA
         gwyBYtaJ2h5TXpmsmfHQ6+vZ7Ua+cX4lDD9OCJ1aSUIBgiKQMjRPL7QBnClgC1LiV8+Y
         ciM3sQZvWE30P5Dr30/TbCPCPH//LtqWwJG3Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LBeGkd4yxWA+5znfziEDZk4GnNBDI0eool+qm+cp898=;
        b=VBttu2hddHQDnZ56N5AsygEjXyqyz0DisleQpUkyuPh6ZH0gUIRZId81rXh5utluhs
         /hUuOqgg2MiDwkPH6O/vZ/ITS7o9DPzaOJUX6wfzvN0WTJtZYQblJO/XmRxA8PoHYf9c
         yYTRTR+PCs8IREXzZDu/n3Dy6i/V6QDnrwgDHzAVg5pLP2rZD73QwUrSGlbGNWLEdU6r
         ZFmIdkt0GvLiIjwJVx8CasjYmcp1T5cgRHoE2IudHg7IzHtGy2J4cjBzPLmVmmVVwzLD
         EAwTaRsUPjfyPe7v5gnu5L5gysCJjuv71QWllytSXlm6/D1XiqitdoepQg01pf0bthKs
         1ryQ==
X-Gm-Message-State: AIkVDXKvnSuYzoWG8QJ6Df++vEwlTDJNAk6XUuWXVC6Aujst/SIiiVUmj46M1OuREgRVyaVL
X-Received: by 10.99.178.21 with SMTP id x21mr17700068pge.48.1486441174877;
        Mon, 06 Feb 2017 20:19:34 -0800 (PST)
Received: from localhost ([122.172.165.189])
        by smtp.gmail.com with ESMTPSA id p26sm6255080pgn.39.2017.02.06.20.19.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Feb 2017 20:19:34 -0800 (PST)
Date:   Tue, 7 Feb 2017 09:49:32 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Markus Mayer <code@mmayer.net>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Markus Mayer <mmayer@broadcom.com>,
        MIPS Linux Kernel List <linux-mips@linux-mips.org>,
        Power Management List <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/4] cpufreq: bmips-cpufreq: CPUfreq driver for
 Broadcom's BMIPS SoCs
Message-ID: <20170207041932.GO3131@vireshk-i7>
References: <20170206215119.87099-1-code@mmayer.net>
 <20170206215119.87099-4-code@mmayer.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170206215119.87099-4-code@mmayer.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Return-Path: <viresh.kumar@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56668
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

On 06-02-17, 13:51, Markus Mayer wrote:
> From: Markus Mayer <mmayer@broadcom.com>
> 
> Add the MIPS CPUfreq driver. This driver currently supports CPUfreq on
> BMIPS5xxx-based SoCs.
> 
> Signed-off-by: Markus Mayer <mmayer@broadcom.com>
> ---
>  drivers/cpufreq/Kconfig         |  10 +++
>  drivers/cpufreq/Makefile        |   1 +
>  drivers/cpufreq/bmips-cpufreq.c | 195 ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 206 insertions(+)
>  create mode 100644 drivers/cpufreq/bmips-cpufreq.c

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

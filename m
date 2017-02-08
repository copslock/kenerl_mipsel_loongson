Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Feb 2017 03:07:17 +0100 (CET)
Received: from mail-qt0-x241.google.com ([IPv6:2607:f8b0:400d:c0d::241]:35510
        "EHLO mail-qt0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992160AbdBHCHKDL702 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 8 Feb 2017 03:07:10 +0100
Received: by mail-qt0-x241.google.com with SMTP id s58so21531531qtc.2;
        Tue, 07 Feb 2017 18:07:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=NRAw4YTi4KAnU7J88YIhR2QBTPo9FHmI1B+gBrz2XTU=;
        b=sZW16EmLM1CgD977dRUKAawlHKzEaCuXIzcVhl84oPNvvkMqYUkSBm1meeihkxM0I6
         QuF5ZDtGjHRs4uTN63P9z7tV245b7Nbmvw9ZLYWWMN5Xa65Jm5p2X6dn9kX3evWz6c7V
         y+dA/a8s+i9LiO1jSIDR6TQeBwrnGI8D2nfvix0qtTwJBbAkgCW6A3sbj/xQg1fTsRH8
         CcuEfV6XiypYfIu1mBz7z2lQrVFXegIS9WpRGn09kQ5o+wbqkLRv5sw3K8JFv6BKTf5g
         0zX9wEhkX9QCyY2f5RWoVf9vAnI4ScJKgFnpPXKU0Ra4HiOTzgbK+3a8U1JBbjSPwPlh
         PjEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=NRAw4YTi4KAnU7J88YIhR2QBTPo9FHmI1B+gBrz2XTU=;
        b=gYdpOSLJEgE8CbrAIWYrsbO+jCimUp+JKC8tVmJu8zEPpjEleRzq1vqdUloMUp8sOh
         8daKnP6on5iIEr+k77qeAHJPhUW0XibtGvA/N5ufcdn2UrRLh6VVI+tay4ruNrsfBNr1
         gYcEbSAau8Y8dspxdXTl8JA07BhV21834ItB7/C86fjc/aFS2Lph3w5bSSbhmyHaxJnV
         sTiykOkK/rdt3AHHxyfTwTuCbq1JpzxKQOQU84W2f8tm06+xQpfxBEtKZ5o68tq0obU5
         6SD3hz2HxUp2GA8F4S48HcTvuw2iEa/sp0LyWCmFPILlDwP5DUcTHZVuuoXB7q5IQNP5
         pBeQ==
X-Gm-Message-State: AMke39m+JJGf9VnCbaH7P7nvfhoknE1p409rL5S/Eg35ZSMX/9IOWy6Pm9wi2L1YLyPH0Q==
X-Received: by 10.237.50.193 with SMTP id z59mr19075768qtd.102.1486519624143;
        Tue, 07 Feb 2017 18:07:04 -0800 (PST)
Received: from [10.112.156.244] ([192.19.255.250])
        by smtp.googlemail.com with ESMTPSA id r57sm4975416qtr.27.2017.02.07.18.07.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Feb 2017 18:07:03 -0800 (PST)
Subject: Re: [PATCH v3 2/4] BMIPS: Enable prerequisites for CPUfreq in MIPS
 Kconfig.
To:     Markus Mayer <code@mmayer.net>, Ralf Baechle <ralf@linux-mips.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
References: <20170207215856.8999-1-code@mmayer.net>
 <20170207215856.8999-3-code@mmayer.net>
Cc:     Markus Mayer <mmayer@broadcom.com>,
        MIPS Linux Kernel List <linux-mips@linux-mips.org>,
        Power Management List <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <185c2261-069f-1ce4-5c81-7ba2fed7ebcf@gmail.com>
Date:   Tue, 7 Feb 2017 18:07:00 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <20170207215856.8999-3-code@mmayer.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56727
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: f.fainelli@gmail.com
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

On 02/07/2017 01:58 PM, Markus Mayer wrote:
> From: Markus Mayer <mmayer@broadcom.com>
> 
> Turn on CPU_SUPPORTS_CPUFREQ and MIPS_EXTERNAL_TIMER for BMIPS.
> 
> Signed-off-by: Markus Mayer <mmayer@broadcom.com>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian

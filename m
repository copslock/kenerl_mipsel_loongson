Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Jan 2018 21:18:41 +0100 (CET)
Received: from mail-lf0-x243.google.com ([IPv6:2a00:1450:4010:c07::243]:44089
        "EHLO mail-lf0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990425AbeARUSeLSHWc (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 18 Jan 2018 21:18:34 +0100
Received: by mail-lf0-x243.google.com with SMTP id w23so28228880lfd.11;
        Thu, 18 Jan 2018 12:18:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=a6Ii2RpVgygl1aZz9Dwp3BUeB6wit8KEvFH6KpLe/6Y=;
        b=A07+oopnalhUDWqy9ISNZpiJmg2HKVTinMftasQkZIoxRuTwgjaqc857i1ieMgeEwO
         kIgs/62ydWlZ2rmNphiHgjseMVNstVEm+EKzzY70M2NGMsBEfsmdIeKLRi4ECLjzjjUC
         9FxofjccBKP8Hx7W8Oef5mCqU+ZgfWadw+GWqKzyrgDD3q0zL6pU74ijdi38EOWoPntQ
         atzu87999ANZldya7yhpn3y3FpHBjG1flQjNuxSpybvjDwNQ1hwz6WCTeiOYomFBwnIn
         1t67rQoc3ptRdRgsMdYft2KCyv6GVWWeVKpPyaKY9LYB6jy9ZvNafTf16PF08JMHzHfd
         IleA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=a6Ii2RpVgygl1aZz9Dwp3BUeB6wit8KEvFH6KpLe/6Y=;
        b=UlN1SZBl2WxauvfWJr/RXl3mZVzVFmewLtXbnaOXckIhOD8B8yfp5sUh6mDWruFohW
         DHYSElwb1qlBjEh/DYG/+OjrVXBZ17dhMKkWRw+AhhA6FXUJs3fX5YFu6IXpQXL4WDXx
         zswVH/owVzk0ILZK/4epaYKkzUxIJeGOIPOQu32DwmSaZtH3G+6XMQStK5eMZ3TmXSRZ
         VstYWMdmyakiA1RkiGym2SvI8N8ZGP16t5E2uw4jCqqdnuN2jT+r1xoW+ZoV3Ae7M4nG
         SH2q8xSnbqDo1YK8Sb645Bh1Fv+qeE63ZUBb2k+kHiCfp5UUp9v/Kf6w+viRO9syQ3fl
         7GyQ==
X-Gm-Message-State: AKwxytcu8+7NCoI/pOJi3vmw+W0ZUnzYlzCDpW3Qx7PVsoRRhs0SxBIY
        //wgcjBxG3lezNBHQ86zuB4=
X-Google-Smtp-Source: ACJfBosKEbgtlWPe7PqV9iziwhVfqtAPjt25KYflTFcLLKcFW2sOv6Nkil+94hlKAeuzuPPlPaYkbA==
X-Received: by 10.46.75.18 with SMTP id y18mr12101272lja.33.1516306708525;
        Thu, 18 Jan 2018 12:18:28 -0800 (PST)
Received: from mobilestation ([95.79.164.146])
        by smtp.gmail.com with ESMTPSA id i18sm1447562ljd.27.2018.01.18.12.18.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jan 2018 12:18:27 -0800 (PST)
Date:   Thu, 18 Jan 2018 23:18:56 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     ralf@linux-mips.org, miodrag.dinic@mips.com, jhogan@kernel.org,
        goran.ferenc@mips.com, david.daney@cavium.com,
        paul.gortmaker@windriver.com, paul.burton@mips.com,
        alex.belits@cavium.com, Steven.Hill@cavium.com,
        alexander.sverdlin@nokia.com, matt.redfearn@mips.com,
        kumba@gentoo.org, marcin.nowakowski@mips.com, James.hogan@mips.com,
        Peter.Wotton@mips.com, Sergey.Semin@t-platforms.ru,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/14] MIPS: memblock: Print out kernel virtual mem layout
Message-ID: <20180118201856.GA996@mobilestation>
References: <20180117222312.14763-1-fancer.lancer@gmail.com>
 <20180117222312.14763-12-fancer.lancer@gmail.com>
 <cce36f73-4381-f830-3422-1cef8ad9e622@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cce36f73-4381-f830-3422-1cef8ad9e622@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Return-Path: <fancer.lancer@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62241
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: fancer.lancer@gmail.com
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

On Thu, Jan 18, 2018 at 12:03:03PM -0800, Florian Fainelli <f.fainelli@gmail.com> wrote:
> On 01/17/2018 02:23 PM, Serge Semin wrote:
> > It is useful to have the kernel virtual memory layout printed
> > at boot time so to have the full information about the booted
> > kernel. In some cases it might be unsafe to have virtual
> > addresses freely visible in logs, so the %pK format is used if
> > one want to hide them.
> > 
> > Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
> 
> I personally like having that information because that helps debug and
> have a quick reference, but there appears to be a trend to remove this
> in the name of security:
> 
> https://patchwork.kernel.org/patch/10124007/
> 
> maybe hide this behind a configuration option?

Yeah, arm code was the place I picked the function up.) But in my case
I've used %pK so the pointers would disappear from logging when 
kptr_restrict sysctl is 1 or 2.
I agree, that we might need to make the printouts optional. If there is
any kernel config, which for instance increases the kernel security we
could also use it or anything else to discard the printouts at compile
time.

> -- 
> Florian

Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 30 Oct 2013 20:43:13 +0100 (CET)
Received: from mail-pd0-f173.google.com ([209.85.192.173]:48391 "EHLO
        mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6827336Ab3J3TnKjzrij convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 30 Oct 2013 20:43:10 +0100
Received: by mail-pd0-f173.google.com with SMTP id r10so1423088pdi.18
        for <linux-mips@linux-mips.org>; Wed, 30 Oct 2013 12:43:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:content-type:mime-version
         :content-transfer-encoding:to:from:in-reply-to:cc:references
         :message-id:user-agent:subject:date;
        bh=kjeAJ0t18LxYmWvkW2JfmMH5iKg2quXq4rzhR91F5Ak=;
        b=a1SmBhwVoernwCKoxjdGsRqwBg7IDotkpm7mihmqqHR35rG6kTstme0/McklJoH6l7
         rydu46DEy0B8coCs/WAj2kaXDl1iuRnTd/XOctxdHylsFAHAIO7M0Q7cqYbn1iNEyS6C
         FGuAKCBbPZMqI5m8Zn5bm4+qrBFOMK90KuScTVcnX/ifLFbDhq1Iju+PgGE539gTnZqJ
         mS2rJTEH3Q9vhcpvW7BC8cgdCE322mKBUlA/LY//Znho1BdwgKHmIamyjg3O/Aq2HFPT
         /xB5/2AGn7Ge2QN3cP3/pPTHoz1AXYaMUifNGTE7cL9MJ4Me7eMRUXlpDaZgnjzaGsh7
         x7rw==
X-Gm-Message-State: ALoCoQlbFsx4Jgcn69/TWEYD4FCd6ivI1xwQR7Dv5GPgColpAaPvBBBHGd1fVK7Q6rGKQTDKcvKd
X-Received: by 10.66.139.166 with SMTP id qz6mr167661pab.88.1383162183625;
        Wed, 30 Oct 2013 12:43:03 -0700 (PDT)
Received: from localhost ([2601:9:5b00:11d:ca60:ff:fe0a:8a36])
        by mx.google.com with ESMTPSA id yg3sm220178pab.16.2013.10.30.12.43.02
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 30 Oct 2013 12:43:02 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>,
        linux-arm-kernel@lists.infradead.org
From:   Mike Turquette <mturquette@linaro.org>
In-Reply-To: <1383076268-8984-1-git-send-email-s.nawrocki@samsung.com>
Cc:     linux@arm.linux.org.uk, jiada_wang@mentor.com,
        kyungmin.park@samsung.com, laurent.pinchart@ideasonboard.com,
        linux-kernel@vger.kernel.org,
        uclinux-dist-devel@blackfin.uclinux.org, linux-mips@linux-mips.org,
        linux-sh@vger.kernel.org,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
References: <1383076268-8984-1-git-send-email-s.nawrocki@samsung.com>
Message-ID: <20131030194252.11662.92657@quantum>
User-Agent: alot/0.3.4
Subject: Re: [PATCH v7 0/5] clk: clock deregistration support
Date:   Wed, 30 Oct 2013 12:42:52 -0700
Return-Path: <mturquette@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38415
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mturquette@linaro.org
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

Quoting Sylwester Nawrocki (2013-10-29 12:51:03)
> This patch series implements clock deregistration in the common clock
> framework. Detailed changes are listed at each patch. I have included
> an additional patch in this series for the omap3isp driver, required 
> to avoid regressions.

Taken into clk-next. Thanks for the fine rework!

Regards,
Mike

> 
> Changes since v5:
>  - fixed NULL clock handling in __clk_get(), __clk_put (patch 5/5).
> 
> Changes since v4:
>  - removed stray struct module forward declaration in patch 3/5.
> 
> Changes since v3:
>  - replaced WARN_ON() with WARN_ON_ONCE() in clk_nodrv_disable_unprepare()
>    callback.
> 
> Changes since v2:
>  - reordered the patches so the race condition is fixed before it can
>    actually cause any issues,
>  - fixed handling of NULL clock pointers in __clk_get(), __clk_put(),
>  - added patch adding actual asignment of clk->owner; more details are
>    discussed in that specific patch.
> 
> Changes since v1:
>  - moved of_clk_{lock, unlock}, __of_clk_get_from_provider() function
>    declaractions to a local header,
>  - renamed clk_dummy_* to clk_nodrv_*.
> 
> Sylwester Nawrocki (5):
>   omap3isp: Modify clocks registration to avoid circular references
>   clk: Provide not locked variant of of_clk_get_from_provider()
>   clkdev: Fix race condition in clock lookup from device tree
>   clk: Add common __clk_get(), __clk_put() implementations
>   clk: Implement clk_unregister()
> 
>  arch/arm/include/asm/clkdev.h         |    2 +
>  arch/blackfin/include/asm/clkdev.h    |    2 +
>  arch/mips/include/asm/clkdev.h        |    2 +
>  arch/sh/include/asm/clkdev.h          |    2 +
>  drivers/clk/clk.c                     |  185 +++++++++++++++++++++++++++++++--
>  drivers/clk/clk.h                     |   16 +++
>  drivers/clk/clkdev.c                  |   12 ++-
>  drivers/media/platform/omap3isp/isp.c |   22 ++--
>  drivers/media/platform/omap3isp/isp.h |    1 +
>  include/linux/clk-private.h           |    5 +
>  include/linux/clkdev.h                |    5 +
>  11 files changed, 235 insertions(+), 19 deletions(-)
>  create mode 100644 drivers/clk/clk.h
> 
> -- 
> 1.7.9.5

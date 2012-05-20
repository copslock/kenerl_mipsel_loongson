Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 20 May 2012 07:54:49 +0200 (CEST)
Received: from mail-pz0-f49.google.com ([209.85.210.49]:54604 "EHLO
        mail-pz0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903258Ab2ETFyo (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 20 May 2012 07:54:44 +0200
Received: by dadm1 with SMTP id m1so6292659dad.36
        for <linux-mips@linux-mips.org>; Sat, 19 May 2012 22:54:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=sender:from:subject:to:cc:in-reply-to:references:date:message-id
         :x-gm-message-state;
        bh=U08B4jc91p6CiEXOny3avi67Ic42u23ML4issa4YRjU=;
        b=TmmpkGfUIXMAEooxriaWWE9GIUtu1sBjZ3RJVKoJkaQvz49fDwFkTYvE+UpsUis2E3
         v5689ZXLcAiRwJNFh065Xf2xTXSozQAzdd9ijl4gA4O3xP5lBG+gJV+WMLsgFcArr4tb
         6IdgzcvfEGlIjS65BQX2li39vX4jKJBPEzvwkWUXjE0m+NDZHSpFDhMzxjGWzanUu5vI
         ygAK8HOPGGaozvqXZ49ZXcy94WKCwuzlS9JlGUtj70i0q8aS3IFw/3fucCiyJwrVgzad
         hW0gOQnA/V9ZwDlUMzpFqLDMcqBP53gbJ+V+5NUfe/6HjXg/rF1CvalQ21V8LVTc9Qao
         8VVQ==
Received: by 10.68.226.73 with SMTP id rq9mr2251553pbc.145.1337493278265;
        Sat, 19 May 2012 22:54:38 -0700 (PDT)
Received: from localhost (S0106d8b37715ee14.cg.shawcable.net. [68.146.14.168])
        by mx.google.com with ESMTPS id h10sm18554289pbh.69.2012.05.19.22.54.36
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 19 May 2012 22:54:37 -0700 (PDT)
Received: by localhost (Postfix, from userid 1000)
        id 13AF03E03B8; Sat, 19 May 2012 23:54:36 -0600 (MDT)
From:   Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 1/3] of: Add prefix parameter to of_modalias_node().
To:     David Daney <ddaney.cavm@gmail.com>,
        devicetree-discuss@lists.ozlabs.org,
        Rob Herring <rob.herring@calxeda.com>,
        spi-devel-general@lists.sourceforge.net
Cc:     linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        linux-doc@vger.kernel.org, David Daney <david.daney@cavium.com>,
        Liam Girdwood <lrg@ti.com>, Timur Tabi <timur@freescale.com>,
        Mark Brown <broonie@opensource.wolfsonmicro.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>,
        alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <1336773923-17866-2-git-send-email-ddaney.cavm@gmail.com>
References: <1336773923-17866-1-git-send-email-ddaney.cavm@gmail.com> <1336773923-17866-2-git-send-email-ddaney.cavm@gmail.com>
Date:   Sat, 19 May 2012 23:54:36 -0600
Message-Id: <20120520055436.13AF03E03B8@localhost>
X-Gm-Message-State: ALoCoQnDpZ+li1cDBttlT5Flbr2EoB/MTnBdEa7LskZhVqvljpFXPn+xGRFWXeKUz2bBrSxFXYQ+
X-archive-position: 33381
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: grant.likely@secretlab.ca
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On Fri, 11 May 2012 15:05:21 -0700, David Daney <ddaney.cavm@gmail.com> wrote:
> From: David Daney <david.daney@cavium.com>
> 
> When generating MODALIASes, it is convenient to add things like "spi:"
> or "i2c:" to the front of the strings.  This allows the standard
> modprobe to find the right driver when automatically populating bus
> children from the device tree structure.
> 
> Add a prefix parameter, and adjust callers.  For
> of_register_spi_devices() use the "spi:" prefix.
> 
> Signed-off-by: David Daney <david.daney@cavium.com>

Applied, thanks.  Some notes below...

> Cc: Liam Girdwood <lrg@ti.com>
> Cc: Timur Tabi <timur@freescale.com>
> Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
> Cc: Jaroslav Kysela <perex@perex.cz>
> Cc: Takashi Iwai <tiwai@suse.de>
> Cc: alsa-devel@alsa-project.org
> Cc: linuxppc-dev@lists.ozlabs.org
> ---
>  drivers/of/base.c            |   22 ++++++++++++++++------
>  drivers/of/of_i2c.c          |    2 +-
>  drivers/of/of_spi.c          |    2 +-
>  include/linux/of.h           |    3 ++-
>  sound/soc/fsl/mpc8610_hpcd.c |    2 +-
>  sound/soc/fsl/p1022_ds.c     |    2 +-
>  6 files changed, 22 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/of/base.c b/drivers/of/base.c
> index 5806449..f05a520 100644
> --- a/drivers/of/base.c
> +++ b/drivers/of/base.c
> @@ -575,26 +575,36 @@ EXPORT_SYMBOL(of_find_matching_node);
>  /**
>   * of_modalias_node - Lookup appropriate modalias for a device node
>   * @node:	pointer to a device tree node
> + * @prefix:	prefix to be added to the compatible property, may be NULL
>   * @modalias:	Pointer to buffer that modalias value will be copied into
>   * @len:	Length of modalias value
>   *
> - * Based on the value of the compatible property, this routine will attempt
> - * to choose an appropriate modalias value for a particular device tree node.
> - * It does this by stripping the manufacturer prefix (as delimited by a ',')
> - * from the first entry in the compatible list property.
> + * Based on the value of the compatible property, this routine will
> + * attempt to choose an appropriate modalias value for a particular
> + * device tree node.  It does this by stripping the manufacturer
> + * prefix (as delimited by a ',') from the first entry in the
> + * compatible list property, and appending it to the prefix.

Not sure why this text block was reformatted.  I've formatted it back
to the way it was so the diff shows specifically what has changed in
the content.

I don't want to discourage cleanups, but I need to be careful that
cleanups don't obscure important changes when looking at the diff.

g.

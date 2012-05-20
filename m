Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 20 May 2012 08:08:13 +0200 (CEST)
Received: from mail-pb0-f49.google.com ([209.85.160.49]:48895 "EHLO
        mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903258Ab2ETGIK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 20 May 2012 08:08:10 +0200
Received: by pbbrq13 with SMTP id rq13so6424168pbb.36
        for <linux-mips@linux-mips.org>; Sat, 19 May 2012 23:08:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=sender:from:subject:to:cc:in-reply-to:references:date:message-id
         :x-gm-message-state;
        bh=/h5uIm4kc5mZVZUNzpnVm9bFN5A9sojgcxUBOtYAbqg=;
        b=VR2tWA8AzdzDNHfWcz65oS9LcuTWuVb9XAPK1Olf2r89bI3uZVXx4zKeGUaLr8L11a
         qPqd9vG1Uz/I16bKNaVDRE6mysSVbdpGThU3XnVmj54rQocO6or5Mr+iwc/DN9UPUdPT
         6S79S3+3p5pDDHkSRTT9mCB8So4XsYsNqqqNmCeMiaGsjpFsi7nESq9avo462isHo1s5
         Gosga0sT/mPffI5dSc1qJI66j97ARYuCXs/F1DG02yQvoJcjIoSXH7wNng5o/fQkabiz
         Fz1+3iUuUDJP0GsMW/ydwQ9K4Tq+QJSc+PBuyMS0YMRwrjCuuTbRevadDRIYl5q7BU62
         BnQQ==
Received: by 10.68.200.193 with SMTP id ju1mr52235368pbc.90.1337494083721;
        Sat, 19 May 2012 23:08:03 -0700 (PDT)
Received: from localhost (S0106d8b37715ee14.cg.shawcable.net. [68.146.14.168])
        by mx.google.com with ESMTPS id rv8sm13214960pbc.64.2012.05.19.23.08.02
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 19 May 2012 23:08:03 -0700 (PDT)
Received: by localhost (Postfix, from userid 1000)
        id 03CE73E03B8; Sun, 20 May 2012 00:08:01 -0600 (MDT)
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
In-Reply-To: <20120520055436.13AF03E03B8@localhost>
References: <1336773923-17866-1-git-send-email-ddaney.cavm@gmail.com> <1336773923-17866-2-git-send-email-ddaney.cavm@gmail.com> <20120520055436.13AF03E03B8@localhost>
Date:   Sun, 20 May 2012 00:08:01 -0600
Message-Id: <20120520060802.03CE73E03B8@localhost>
X-Gm-Message-State: ALoCoQmG2F0AiZzerau5HDxVJSXz4fbAkJAE40tkSTaLyqHjBA+TjJulo5v8OyWeP8pOuT9uL5gD
X-archive-position: 33382
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: grant.likely@secretlab.ca
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On Sat, 19 May 2012 23:54:36 -0600, Grant Likely <grant.likely@secretlab.ca> wrote:
> On Fri, 11 May 2012 15:05:21 -0700, David Daney <ddaney.cavm@gmail.com> wrote:
> > From: David Daney <david.daney@cavium.com>
> > 
> > When generating MODALIASes, it is convenient to add things like "spi:"
> > or "i2c:" to the front of the strings.  This allows the standard
> > modprobe to find the right driver when automatically populating bus
> > children from the device tree structure.
> > 
> > Add a prefix parameter, and adjust callers.  For
> > of_register_spi_devices() use the "spi:" prefix.
> > 
> > Signed-off-by: David Daney <david.daney@cavium.com>
> 
> Applied, thanks.  Some notes below...

Wait... why is this necessary?  The module type prefix isn't stored in
the modalias value for any other bus type as far as I can see, and
with this series it appears that the "spi:" prefix may or may not be
present in the modalias.  That doesn't look right.

Why isn't prefixing spi: at uevent time sufficient?  IIUC, modprobe
depends on either UEVENT or the modalias attribute to know which
driver to probe.  It does look like the attribute is missing the spi:
prefix though.  Does the following change work instead of these two
patches?

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 3d8f662..da8aac7 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -51,7 +51,7 @@ modalias_show(struct device *dev, struct device_attribute *a, char *buf)
 {
        const struct spi_device *spi = to_spi_device(dev);
 
-       return sprintf(buf, "%s\n", spi->modalias);
+       return sprintf(buf, "%s%s\n", SPI_MODULE_PREFIX, spi->modalias);
 }

So, I've dropped this patch from my tree.  If the change above works
for you then I'll push it out.

g.

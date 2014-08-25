Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 25 Aug 2014 10:05:08 +0200 (CEST)
Received: from mout.kundenserver.de ([212.227.17.10]:49685 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27006657AbaHYIFHr8y0W (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 25 Aug 2014 10:05:07 +0200
Received: from wuerfel.localnet (HSI-KBW-134-3-133-35.hsi14.kabel-badenwuerttemberg.de [134.3.133.35])
        by mrelayeu.kundenserver.de (node=mreue101) with ESMTP (Nemesis)
        id 0MbQQe-1X5For40Ye-00IijF; Mon, 25 Aug 2014 10:04:34 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Hauke Mehrtens <hauke@hauke-m.de>, linux-wireless@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mips@linux-mips.org,
        zajec5@gmail.com
Subject: Re: [RFC 6/7] bcma: get sprom from devicetree
Date:   Mon, 25 Aug 2014 10:04:33 +0200
Message-ID: <4882662.VtlSfZ0rSN@wuerfel>
User-Agent: KMail/4.11.5 (Linux/3.11.0-26-generic; KDE/4.11.5; x86_64; ; )
In-Reply-To: <1408915485-8078-8-git-send-email-hauke@hauke-m.de>
References: <1408915485-8078-1-git-send-email-hauke@hauke-m.de> <1408915485-8078-8-git-send-email-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Provags-ID: V02:K0:aJLra1FBbKFjO+Xx+QkSF745yXMW5JSHTUERVtQ9hzk
 ro5h7Lpfd2ZqwUS7QFzg8iTorSZgZ0MQw/inXKgTBsuBGy8E5B
 Rmuo8d5c/7Sy3E+RWs3SRazJW/54DF2iGIesKQ48v1R2XIdAaq
 GsPS/sHcus7hUkyM0BhGEP7Xo/Q1pPfjVPusorlZs+ua00JEQQ
 /loFTrbgSZbx4RfgtKntP89eTgXQUuW8JtTIL7xyh9Y7qAGLUc
 fTUMaIhe5wBSKjB8/v1o2U404/61ArMH+G5G3o25XlbY0mRgVM
 f6MeF5UHsQSApHcePZqPnQLG+iULwcqbitqAUwS3e5JOgl+nZw
 9t6cQEMGbnmUtDD/VYPY=
X-UI-Out-Filterresults: notjunk:1;
Return-Path: <arnd@arndb.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42212
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: arnd@arndb.de
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

On Sunday 24 August 2014 23:24:44 Hauke Mehrtens wrote:
> +#ifdef CONFIG_OF
> +static int bcma_fill_sprom_with_dt(struct bcma_bus *bus,
> +                                  struct ssb_sprom *out)
> +{
> +       const __be32 *handle;
> +       struct device_node *sprom_node;
> +       struct platform_device *sprom_dev;
> +       struct ssb_sprom *sprom;
> +
> +       if (!bus->host_pdev || !bus->host_pdev->dev.of_node)
> +               return -ENOENT;

You can remove the #ifdef above if you change this into

	if (!IS_ENABLED(CONFIG_OF) || !bus->host_pdev ||
	    !bus->host_pdev->dev.of_node)
		return -ENOENT;

> +       handle = of_get_property(bus->host_pdev->dev.of_node, "sprom", NULL);
> +       if (!handle)
> +               return -ENOENT;
> +
> +       sprom_node = of_find_node_by_phandle(be32_to_cpup(handle));
> +       if (!sprom_node)
> +               return -ENOENT;
> +
> +       sprom_dev = of_find_device_by_node(sprom_node);
> +       if (!sprom_dev)
> +               return -ENOENT;
> +
> +       sprom = platform_get_drvdata(sprom_dev);
> +       if (!sprom)
> +               return -ENOENT;
> +
> +       memcpy(out, sprom, sizeof(*out));
> +
> +       return 0;
> +}

missing of_node_put().

	Arnd

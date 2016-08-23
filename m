Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Aug 2016 01:03:42 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.136]:56932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23991998AbcHWXDdFY0Me (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 24 Aug 2016 01:03:33 +0200
Received: from mail.kernel.org (localhost [127.0.0.1])
        by mail.kernel.org (Postfix) with ESMTP id AC17020383;
        Tue, 23 Aug 2016 23:03:29 +0000 (UTC)
Received: from mail-yw0-f170.google.com (mail-yw0-f170.google.com [209.85.161.170])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 97CBE20379;
        Tue, 23 Aug 2016 23:03:27 +0000 (UTC)
Received: by mail-yw0-f170.google.com with SMTP id r9so81874882ywg.0;
        Tue, 23 Aug 2016 16:03:27 -0700 (PDT)
X-Gm-Message-State: AEkoout6hmlkVCr75aU6sXmgGkP30fNKP7Qf/SvMBdTsTXNf3Hc9e2valqCWXBZ9xY5m/+vWx5bc1De91qbszg==
X-Received: by 10.129.39.200 with SMTP id n191mr25961966ywn.16.1471993406801;
 Tue, 23 Aug 2016 16:03:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.129.162.15 with HTTP; Tue, 23 Aug 2016 16:03:06 -0700 (PDT)
In-Reply-To: <20160823183943.20888-1-aaro.koskinen@iki.fi>
References: <20160823183943.20888-1-aaro.koskinen@iki.fi>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 23 Aug 2016 18:03:06 -0500
X-Gmail-Original-Message-ID: <CAL_JsqK-jLR9A80=Th1GW5-X1i+RSoJMaKeiU4=zPkcWVhZx1w@mail.gmail.com>
Message-ID: <CAL_JsqK-jLR9A80=Th1GW5-X1i+RSoJMaKeiU4=zPkcWVhZx1w@mail.gmail.com>
Subject: Re: [PATCH] MIPS: OCTEON: fix platform bus probing
To:     Aaro Koskinen <aaro.koskinen@iki.fi>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        David Daney <ddaney@caviumnetworks.com>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
X-Virus-Scanned: ClamAV using ClamSMTP
Return-Path: <robh@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54738
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: robh@kernel.org
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

On Tue, Aug 23, 2016 at 1:39 PM, Aaro Koskinen <aaro.koskinen@iki.fi> wrote:
> Commit 44a7185c2ae6 ("of/platform: Add common method to populate
> default bus") added new arch_initcall of_platform_default_populate_init()
> that will override device_initcall octeon_publish_devices(). This broke
> many OCTEON boards as important devices are not getting probed anymore
> (e.g. on EdgeRouter Lite the USB mass storage/rootfs is missing).

They are getting probed, but the order probably changed causing probe to fail.

> Fix by changing octeon_publish_devices() to arch_initcall.
>
> Fixes: 44a7185c2ae6 ("of/platform: Add common method to populate default bus")
> Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>

Acked-by: Rob Herring <robh@kernel.org>

> ---
>  arch/mips/cavium-octeon/octeon-platform.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/mips/cavium-octeon/octeon-platform.c b/arch/mips/cavium-octeon/octeon-platform.c
> index b31fbc9..37a932d 100644
> --- a/arch/mips/cavium-octeon/octeon-platform.c
> +++ b/arch/mips/cavium-octeon/octeon-platform.c
> @@ -1059,7 +1059,7 @@ static int __init octeon_publish_devices(void)
>  {
>         return of_platform_bus_probe(NULL, octeon_ids, NULL);
>  }
> -device_initcall(octeon_publish_devices);
> +arch_initcall(octeon_publish_devices);
>
>  MODULE_AUTHOR("David Daney <ddaney@caviumnetworks.com>");
>  MODULE_LICENSE("GPL");
> --
> 2.9.2
>

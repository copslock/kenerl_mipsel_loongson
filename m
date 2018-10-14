Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 14 Oct 2018 19:04:35 +0200 (CEST)
Received: from emh04.mail.saunalahti.fi ([62.142.5.110]:56472 "EHLO
        emh04.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990509AbeJNREdFl20c (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 14 Oct 2018 19:04:33 +0200
Received: from darkstar.musicnaut.iki.fi (85-76-84-102-nat.elisa-mobile.fi [85.76.84.102])
        by emh04.mail.saunalahti.fi (Postfix) with ESMTP id F0F3C3005B;
        Sun, 14 Oct 2018 20:04:31 +0300 (EEST)
Date:   Sun, 14 Oct 2018 20:04:31 +0300
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     linux-mips@linux-mips.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        Mathieu Malaterre <malat@debian.org>,
        Ezequiel Garcia <ezequiel@collabora.co.uk>
Subject: Bug report: MIPS CI20/jz4740-mmc DMA and PREEMPT_NONE
Message-ID: <20181014170431.GK3461@darkstar.musicnaut.iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66839
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aaro.koskinen@iki.fi
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

Hi,

There is something wrong with jz4740-mmc in current mainline kernel
(tested v4.18 and 4.19-rc, the MMC support for CI20 does not exist
prior those), as the DMA support does not work properly if I disable
kernel pre-emption. The console gets flooded with:

[   16.461094] jz4740-mmc 13450000.mmc: [jz4740_mmc_prepare_dma_data] invalid cookie: data->host_cookie 567 host->next_data.cookie 568
[   16.473120] jz4740-mmc 13450000.mmc: [jz4740_mmc_prepare_dma_data] invalid cookie: data->host_cookie 568 host->next_data.cookie 569
[   16.485144] jz4740-mmc 13450000.mmc: [jz4740_mmc_prepare_dma_data] invalid cookie: data->host_cookie 569 host->next_data.cookie 570
[   16.497170] jz4740-mmc 13450000.mmc: [jz4740_mmc_prepare_dma_data] invalid cookie: data->host_cookie 570 host->next_data.cookie 571
[   16.509194] jz4740-mmc 13450000.mmc: [jz4740_mmc_prepare_dma_data] invalid cookie: data->host_cookie 571 host->next_data.cookie 572
[   16.532421] jz4740-mmc 13450000.mmc: [jz4740_mmc_prepare_dma_data] invalid cookie: data->host_cookie 572 host->next_data.cookie 573
[   16.544594] jz4740-mmc 13450000.mmc: [jz4740_mmc_prepare_dma_data] invalid cookie: data->host_cookie 573 host->next_data.cookie 574
[   16.556621] jz4740-mmc 13450000.mmc: [jz4740_mmc_prepare_dma_data] invalid cookie: data->host_cookie 574 host->next_data.cookie 575
[   16.568638] jz4740-mmc 13450000.mmc: [jz4740_mmc_prepare_dma_data] invalid cookie: data->host_cookie 575 host->next_data.cookie 576
[   16.601092] jz4740-mmc 13450000.mmc: [jz4740_mmc_prepare_dma_data] invalid cookie: data->host_cookie 582 host->next_data.cookie 583

etc. ad inf.

This should be easily reproducible on CI20 board with ci20_defconfig
and setting CONFIG_PREEMPT_NONE=y.

A.

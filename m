Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Feb 2016 18:46:57 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.136]:58132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27012801AbcBDRqz2zOft (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 4 Feb 2016 18:46:55 +0100
Received: from mail.kernel.org (localhost [127.0.0.1])
        by mail.kernel.org (Postfix) with ESMTP id E9068203A0
        for <linux-mips@linux-mips.org>; Thu,  4 Feb 2016 17:46:50 +0000 (UTC)
Received: from mail-yw0-f169.google.com (mail-yw0-f169.google.com [209.85.161.169])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 48934203AC
        for <linux-mips@linux-mips.org>; Thu,  4 Feb 2016 17:46:48 +0000 (UTC)
Received: by mail-yw0-f169.google.com with SMTP id h129so31254895ywb.1
        for <linux-mips@linux-mips.org>; Thu, 04 Feb 2016 09:46:48 -0800 (PST)
X-Gm-Message-State: AG10YOTUJzd8o5YGc4p36q5kafBDjhXoMzu2IjjVWnErtzPQf4xJm/F6HIHRFe8S4yn7icR0+VDznNiRwjy/8A==
X-Received: by 10.129.35.6 with SMTP id j6mr4800858ywj.133.1454608007409; Thu,
 04 Feb 2016 09:46:47 -0800 (PST)
MIME-Version: 1.0
Received: by 10.129.153.19 with HTTP; Thu, 4 Feb 2016 09:46:28 -0800 (PST)
In-Reply-To: <1454602213-967-7-git-send-email-paul.burton@imgtec.com>
References: <1454602213-967-1-git-send-email-paul.burton@imgtec.com> <1454602213-967-7-git-send-email-paul.burton@imgtec.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 4 Feb 2016 11:46:28 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLRMiJ-0j_PrXSKqf6MrRfyqbDGaiaiEn4rAoFaCNgtKQ@mail.gmail.com>
Message-ID: <CAL_JsqLRMiJ-0j_PrXSKqf6MrRfyqbDGaiaiEn4rAoFaCNgtKQ@mail.gmail.com>
Subject: Re: [PATCH v3 6/6] PCI: xilinx: Allow build on MIPS platforms
To:     Paul Burton <paul.burton@imgtec.com>
Cc:     Linux-MIPS <linux-mips@linux-mips.org>,
        Bharat Kumar Gogada <bharatku@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Ravikiran Gummaluri <rgummal@xilinx.com>,
        Ley Foon Tan <lftan@altera.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Scott Branden <sbranden@broadcom.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Duc Dang <dhdang@apm.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Gabriele Paoloni <gabriele.paoloni@huawei.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Ray Jui <rjui@broadcom.com>, Hauke Mehrtens <hauke@hauke-m.de>
Content-Type: text/plain; charset=UTF-8
X-Virus-Scanned: ClamAV using ClamSMTP
Return-Path: <robh@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51789
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

On Thu, Feb 4, 2016 at 10:10 AM, Paul Burton <paul.burton@imgtec.com> wrote:
> Allow the xilinx-pcie driver to be built on MIPS platforms. This will be
> used on the MIPS Boston board.
>
> Signed-off-by: Paul Burton <paul.burton@imgtec.com>
>
> ---
>
> Changes in v3:
> - Split out from Boston patchset.
>
> Changes in v2: None
>
>  drivers/pci/host/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
> index 75a6054..0aee193 100644
> --- a/drivers/pci/host/Kconfig
> +++ b/drivers/pci/host/Kconfig
> @@ -81,7 +81,7 @@ config PCI_KEYSTONE
>
>  config PCIE_XILINX
>         bool "Xilinx AXI PCIe host bridge support"
> -       depends on ARCH_ZYNQ
> +       depends on ARCH_ZYNQ || MIPS

Why don't you just remove the dependency? Then it gets better build coverage.

Rob

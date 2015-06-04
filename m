Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Jun 2015 14:15:39 +0200 (CEST)
Received: from mail-yh0-f47.google.com ([209.85.213.47]:34323 "EHLO
        mail-yh0-f47.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008192AbbFDMPgaMQWV (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 4 Jun 2015 14:15:36 +0200
Received: by yhom41 with SMTP id m41so9308960yho.1;
        Thu, 04 Jun 2015 05:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=rL/gfuupOnU+ee7RF4+FCoI2OIUfb1lWzDrIGBAjRZ8=;
        b=LlClhtkhEe9EZ4t5OHcTXuiGXIPEwuyfok2o3DSkgbYay7XPel5MOPJdiXoUv7NYgy
         9lUj2nz5AkZUucNHoDxxI/k59EI+sMnH7Qzn7SAsr+o8uuFHPufDaVUALApfTc6TEZBn
         7Ylj/GwLdkL+v8AHGlIUGt057YuhFbD8WP09pO6XojjKVfZrC6l7R2KWM9oYNCjI3wJa
         RxFxPnPpmSqRtzeUTO5/RwFgJ0zw74qQ2LDBN89ytI35Rdv+zl/chlLYxGtBOsIpOw22
         bS5vH7PVbHtnVEg3hMWgGH8zqORfhy8/A9zHTOQRynTV+UjrJTqMDUd4SKhU+pynF0c9
         sBQA==
X-Received: by 10.236.43.180 with SMTP id l40mr25971250yhb.185.1433420130586;
 Thu, 04 Jun 2015 05:15:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.13.210.193 with HTTP; Thu, 4 Jun 2015 05:15:10 -0700 (PDT)
In-Reply-To: <1433391238-19471-4-git-send-email-jiang.liu@linux.intel.com>
References: <1433391238-19471-1-git-send-email-jiang.liu@linux.intel.com> <1433391238-19471-4-git-send-email-jiang.liu@linux.intel.com>
From:   Sergey Ryazanov <ryazanov.s.a@gmail.com>
Date:   Thu, 4 Jun 2015 15:15:10 +0300
Message-ID: <CAHNKnsQfxRrG_gzVUyCkxj5svRcS-znGZWLf+R14_guJH0MO1g@mail.gmail.com>
Subject: Re: [RFT v2 03/48] MIPS, irq: Use irq_desc_get_xxx() to avoid
 redundant lookup of irq_desc
To:     Jiang Liu <jiang.liu@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Yinghai Lu <yinghai@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Ralf Baechle <ralf@linux-mips.org>,
        Aleksey Makarov <aleksey.makarov@auriga.com>,
        David Daney <david.daney@cavium.com>,
        Christoph Lameter <cl@linux.com>,
        John Crispin <blogic@openwrt.org>,
        Andrew Bresticker <abrestic@chromium.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Tony Luck <tony.luck@intel.com>, x86@kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
        Linux MIPS <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <ryazanov.s.a@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47857
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ryazanov.s.a@gmail.com
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

2015-06-04 7:13 GMT+03:00 Jiang Liu <jiang.liu@linux.intel.com>:
> Use irq_desc_get_xxx() to avoid redundant lookup of irq_desc while we
> already have a pointer to corresponding irq_desc.
>
> Note: this patch has been queued by Ralf Baechle <ralf@linux-mips.org>.
>
> Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
> ---
>  arch/mips/ath25/ar2315.c             |    2 +-
>  arch/mips/ath25/ar5312.c             |    2 +-
>  arch/mips/cavium-octeon/octeon-irq.c |    4 +++-
>  arch/mips/pci/pci-ar2315.c           |    2 +-
>  arch/mips/pci/pci-ar71xx.c           |    2 +-
>  arch/mips/pci/pci-ar724x.c           |    2 +-
>  arch/mips/pci/pci-rt3883.c           |    2 +-
>  arch/mips/ralink/irq.c               |    2 +-
>  8 files changed, 10 insertions(+), 8 deletions(-)
>
For ath25 (AR231x/AR5312) changes

Acked-by: Sergey Ryazanov <ryazanov.s.a@gmail.com>

-- 
Sergey

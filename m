Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Jun 2015 14:21:57 +0200 (CEST)
Received: from mail-yk0-f170.google.com ([209.85.160.170]:36633 "EHLO
        mail-yk0-f170.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008192AbbFDMVzUa31V (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 4 Jun 2015 14:21:55 +0200
Received: by yked142 with SMTP id d142so13486686yke.3;
        Thu, 04 Jun 2015 05:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=BADF64CV/CzTU5siJikerFs9ecCnq7MC0Nxwj59hCWs=;
        b=YegEwJHpW8QtkuvpR1brWAyzgSsU5qY1O/vrW4WvATUdmjBNyLZ5gYS+vUqCaA5QiD
         zXGO6heyWky+fd27fIgRkaK60Pll8/uajVTp+VA0uWt2nRB2XqpsBX/cqQkBoysGXHGb
         MzlOD2Ijmb70LMqxfkb+TJRPkVyARiUuTRQ/M9fCv3FsgVYsgDMem2wk/DBaCVQJruYD
         3BLeICFxFgG1qujaKh/IddRJYhpDs3rh7RVctt48bRun59DDNIdV68cjL0p6+jV6x3XL
         KgWIXuWVBjGjwDJt6tnEGZuJlnk6x0kqEvsiX7eYVtrdRC6F1eavixYXW79s70VxcryV
         JokQ==
X-Received: by 10.236.43.168 with SMTP id l28mr39432265yhb.71.1433420509567;
 Thu, 04 Jun 2015 05:21:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.13.210.193 with HTTP; Thu, 4 Jun 2015 05:21:29 -0700 (PDT)
In-Reply-To: <1433391238-19471-40-git-send-email-jiang.liu@linux.intel.com>
References: <1433391238-19471-1-git-send-email-jiang.liu@linux.intel.com> <1433391238-19471-40-git-send-email-jiang.liu@linux.intel.com>
From:   Sergey Ryazanov <ryazanov.s.a@gmail.com>
Date:   Thu, 4 Jun 2015 15:21:29 +0300
Message-ID: <CAHNKnsQOWOR+WLM=rsbvGyaGPfJ8WrFCmEMKX53-yzsp1i-Hmg@mail.gmail.com>
Subject: Re: [RFT v2 39/48] genirq, mips: Kill the first parameter 'irq' of irq_flow_handler_t
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
        Manuel Lauss <manuel.lauss@gmail.com>,
        Aleksey Makarov <aleksey.makarov@auriga.com>,
        David Daney <david.daney@cavium.com>,
        Christoph Lameter <cl@linux.com>,
        Jayachandran C <jchandra@broadcom.com>,
        Tejun Heo <tj@kernel.org>, John Crispin <blogic@openwrt.org>,
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
X-archive-position: 47858
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
> Now most IRQ flow handlers make no use of the first parameter 'irq'.
> And for those who do make use of 'irq', we could easily get the irq
> number through irq_desc->irq_data->irq. So kill the first parameter
> 'irq' of irq_flow_handler_t.
>
> To ease review, I have split the changes into several parts, though
> they should be merge as one to support bisecting.
>
> Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
> Acked-by: Ralf Baechle <ralf@linux-mips.org>
> ---
>  arch/mips/alchemy/common/irq.c          |    4 ++--
>  arch/mips/alchemy/devboards/bcsr.c      |    2 +-
>  arch/mips/ath25/ar2315.c                |    2 +-
>  arch/mips/ath25/ar5312.c                |    2 +-
>  arch/mips/ath79/irq.c                   |    8 ++++----
>  arch/mips/cavium-octeon/octeon-irq.c    |    8 ++++----
>  arch/mips/include/asm/netlogic/common.h |    4 ++--
>  arch/mips/jz4740/gpio.c                 |    2 +-
>  arch/mips/netlogic/common/smp.c         |    4 ++--
>  arch/mips/pci/pci-ar2315.c              |    2 +-
>  arch/mips/pci/pci-ar71xx.c              |    2 +-
>  arch/mips/pci/pci-ar724x.c              |    2 +-
>  arch/mips/pci/pci-rt3883.c              |    2 +-
>  arch/mips/ralink/irq.c                  |    2 +-
>  14 files changed, 23 insertions(+), 23 deletions(-)
>

Acked-by: Sergey Ryazanov <ryazanov.s.a@gmail.com>

-- 
Sergey

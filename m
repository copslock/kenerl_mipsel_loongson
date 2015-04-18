Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 19 Apr 2015 00:29:06 +0200 (CEST)
Received: from arrakis.dune.hu ([78.24.191.176]:52950 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27010245AbbDRW3E7Upev (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 19 Apr 2015 00:29:04 +0200
Received: from localhost (localhost [127.0.0.1])
        by arrakis.dune.hu (Postfix) with ESMTP id 078F728BC2B;
        Sun, 19 Apr 2015 00:28:09 +0200 (CEST)
X-Virus-Scanned: at arrakis.dune.hu
Received: from mail-qg0-f42.google.com (mail-qg0-f42.google.com [209.85.192.42])
        by arrakis.dune.hu (Postfix) with ESMTPSA id EE22E280261;
        Sun, 19 Apr 2015 00:28:05 +0200 (CEST)
Received: by qgdy78 with SMTP id y78so37256571qgd.0;
        Sat, 18 Apr 2015 15:29:00 -0700 (PDT)
X-Received: by 10.140.20.99 with SMTP id 90mr10500288qgi.87.1429396140482;
 Sat, 18 Apr 2015 15:29:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.89.146 with HTTP; Sat, 18 Apr 2015 15:28:39 -0700 (PDT)
In-Reply-To: <1429274178-4337-5-git-send-email-albeu@free.fr>
References: <1429274178-4337-1-git-send-email-albeu@free.fr> <1429274178-4337-5-git-send-email-albeu@free.fr>
From:   Jonas Gorski <jogo@openwrt.org>
Date:   Sun, 19 Apr 2015 00:28:39 +0200
Message-ID: <CAOiHx=kJD4s4FZ61iKqReE1BkqeoHuo4pET1CFygE1izQZAW4w@mail.gmail.com>
Subject: Re: [PATCH 4/5] MIPS: ath79: Fix the PCI memory size and offset of
 window 7
To:     Alban Bedel <albeu@free.fr>
Cc:     MIPS Mailing List <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Andrew Bresticker <abrestic@chromium.org>,
        Qais Yousef <qais.yousef@imgtec.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Sergey Ryazanov <ryazanov.s.a@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <jogo@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46913
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jogo@openwrt.org
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

On Fri, Apr 17, 2015 at 2:36 PM, Alban Bedel <albeu@free.fr> wrote:
> The define AR71XX_PCI_MEM_SIZE miss one window, there is 7 windows,
> not 6. To make things clearer, and allow simpler code, derive
> AR71XX_PCI_MEM_SIZE from the newly introduced AR71XX_PCI_WIN_COUNT
> and AR71XX_PCI_WIN_SIZE.
>
> The define AR71XX_PCI_WIN7_OFFS also add a typo, fix it.

I think this will break PCI on ar71xx.

>
> Signed-off-by: Alban Bedel <albeu@free.fr>
> ---
>  arch/mips/include/asm/mach-ath79/ar71xx_regs.h | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/arch/mips/include/asm/mach-ath79/ar71xx_regs.h b/arch/mips/include/asm/mach-ath79/ar71xx_regs.h
> index aa3800c..e2669a8 100644
> --- a/arch/mips/include/asm/mach-ath79/ar71xx_regs.h
> +++ b/arch/mips/include/asm/mach-ath79/ar71xx_regs.h
> @@ -41,7 +41,9 @@
>  #define AR71XX_RESET_SIZE      0x100
>
>  #define AR71XX_PCI_MEM_BASE    0x10000000
> -#define AR71XX_PCI_MEM_SIZE    0x07000000
> +#define AR71XX_PCI_WIN_COUNT   8
> +#define AR71XX_PCI_WIN_SIZE    0x01000000
> +#define AR71XX_PCI_MEM_SIZE    (AR71XX_PCI_WIN_COUNT * AR71XX_PCI_WIN_SIZE)
>
>  #define AR71XX_PCI_WIN0_OFFS   0x10000000
>  #define AR71XX_PCI_WIN1_OFFS   0x11000000
> @@ -50,7 +52,7 @@
>  #define AR71XX_PCI_WIN4_OFFS   0x14000000
>  #define AR71XX_PCI_WIN5_OFFS   0x15000000
>  #define AR71XX_PCI_WIN6_OFFS   0x16000000
> -#define AR71XX_PCI_WIN7_OFFS   0x07000000
> +#define AR71XX_PCI_WIN7_OFFS   0x17000000

These values are used in exactly one place, for writing into the PCI
address space offset registers.
The 7th PCI window is a special one for accessing the configuration
space registers, which requires to be set to 0x07000000 for that
purpose. So by changing this value you likely break access to these
values.

>
>  #define AR71XX_PCI_CFG_BASE    \
>         (AR71XX_PCI_MEM_BASE + AR71XX_PCI_WIN7_OFFS + 0x10000)

Also this macro would now be wrong, and calculate a wrong address.


Regards
Jonas

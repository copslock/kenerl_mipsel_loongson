Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Mar 2017 14:38:52 +0100 (CET)
Received: from mail-wm0-x241.google.com ([IPv6:2a00:1450:400c:c09::241]:33960
        "EHLO mail-wm0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993892AbdCGNiohml7i convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 7 Mar 2017 14:38:44 +0100
Received: by mail-wm0-x241.google.com with SMTP id u132so1041615wmg.1;
        Tue, 07 Mar 2017 05:38:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=KFCIi7evIbTZs78sTZ4hg+w7r5KAyxCIQ1nbr4UXBkM=;
        b=VMpjfIsUg0pQ63BIvaRk2hvwS1XxDYPjJDOt0jy3pRe5Sf60elrCkC5NQULEEK+B1A
         371oVwQFiAvPdPKRMgHJ8dZ7HynbpbnIZUBHopmkENG2xbdkj20RWAvCG4E0G10OYB0Z
         IcJt7E75qXWlNzdSitMEbVdSyj7AVSgNU35uCkvIWnicDgiK3cWrHeypVfcfcR8ja997
         fSTlK+irTnq56MOktxn8S/XNRefXONA+9PC7dh+ZIfm7WHuKbve9DrBHuheEg1/kSv1H
         m+dZ2Eff/MRP7SiMT4jb/pl+alebVKpnwwzg+U5lg+6x5gRZKvWe7MRfzJOdAJKhQvlF
         KMqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=KFCIi7evIbTZs78sTZ4hg+w7r5KAyxCIQ1nbr4UXBkM=;
        b=LnKBiDMYhNdlkjnhfERB7uTwgd9GudyBQ38SZbiEFkROaeoTAl+Stz18fSXNiOeDmQ
         TQIH6foyMVAbvHrglzgCyT8cVktcx6S22OYIVvzDNeXqzTAq9/o4H7WBMIbDVf0IKPJ3
         INA/YibFP+/SlcYO8eeH9uUe/AcNCsDTT6t/gXIKDH1n2YeQPnju2IxuDMdQMSVX3Gc2
         Wczc/VBP2FWJfVashhfoO96vQ1ffDtlTSKuH01SF9s73igz1KdUABx9i5SLTuBwuLqIZ
         y/JBVoj42w2hLdtx+sD/V6a784z7xrdZnakXxWMYyAgJ761UZSfpyvJ3vpF7RFDdbrgl
         HSIw==
X-Gm-Message-State: AMke39lWihkgyBtrvt0gBWBs/wrNv9m8phoYtApt/jSiG8Ny9KUJZO0gzmB4OkVb4Fn7ku0NbKc/PT2BbP7iuQ==
X-Received: by 10.28.35.151 with SMTP id j145mr17991693wmj.50.1488893919367;
 Tue, 07 Mar 2017 05:38:39 -0800 (PST)
MIME-Version: 1.0
Received: by 10.80.151.214 with HTTP; Tue, 7 Mar 2017 05:38:39 -0800 (PST)
In-Reply-To: <1479093165-625-3-git-send-email-chenhc@lemote.com>
References: <1479093165-625-1-git-send-email-chenhc@lemote.com> <1479093165-625-3-git-send-email-chenhc@lemote.com>
From:   YunQiang Su <wzssyqa@gmail.com>
Date:   Tue, 7 Mar 2017 21:38:39 +0800
Message-ID: <CAKcpw6V18V3pr777sPjNHRyi7gO1DVAQdp7NzP5N2XNOpW0s6A@mail.gmail.com>
Subject: Re: [PATCH V2 2/7] MIPS: Loongson: Add NMI handler support
To:     Huacai Chen <chenhc@lemote.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <john@phrozen.org>,
        "Steven J . Hill" <Steven.Hill@imgtec.com>,
        linux-mips <linux-mips@linux-mips.org>,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-Path: <wzssyqa@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57073
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wzssyqa@gmail.com
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

With this patch, I met a problem on Loongson 3A 1000:

kernel: [1692。089996] NMI watchdog: BUG: soft lockup - CPU#0 stuck for
22s! [apt-get: 9687]

I will try to recomplie the kernel without this patch.

It seems that it works well on Loongson 3A 3000.

On Mon, Nov 14, 2016 at 11:12 AM, Huacai Chen <chenhc@lemote.com> wrote:
> Signed-off-by: Huacai Chen <chenhc@lemote.com>
> ---
>  arch/mips/loongson64/common/init.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/arch/mips/loongson64/common/init.c b/arch/mips/loongson64/common/init.c
> index 9b987fe..6ef1712 100644
> --- a/arch/mips/loongson64/common/init.c
> +++ b/arch/mips/loongson64/common/init.c
> @@ -10,13 +10,25 @@
>
>  #include <linux/bootmem.h>
>  #include <asm/bootinfo.h>
> +#include <asm/traps.h>
>  #include <asm/smp-ops.h>
> +#include <asm/cacheflush.h>
>
>  #include <loongson.h>
>
>  /* Loongson CPU address windows config space base address */
>  unsigned long __maybe_unused _loongson_addrwincfg_base;
>
> +static void __init mips_nmi_setup(void)
> +{
> +       void *base;
> +       extern char except_vec_nmi;
> +
> +       base = (void *)(CAC_BASE + 0x380);
> +       memcpy(base, &except_vec_nmi, 0x80);
> +       flush_icache_range((unsigned long)base, (unsigned long)base + 0x80);
> +}
> +
>  void __init prom_init(void)
>  {
>  #ifdef CONFIG_CPU_SUPPORTS_ADDRWINCFG
> @@ -40,6 +52,7 @@ void __init prom_init(void)
>         /*init the uart base address */
>         prom_init_uart_base();
>         register_smp_ops(&loongson3_smp_ops);
> +       board_nmi_handler_setup = mips_nmi_setup;
>  }
>
>  void __init prom_free_prom_memory(void)
> --
> 2.7.0
>
>
>
>



-- 
YunQiang Su

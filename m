Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 16 Jun 2012 14:46:55 +0200 (CEST)
Received: from mail-lb0-f177.google.com ([209.85.217.177]:49968 "EHLO
        mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903485Ab2FPMqs convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 16 Jun 2012 14:46:48 +0200
Received: by lbbgg6 with SMTP id gg6so3596393lbb.36
        for <multiple recipients>; Sat, 16 Jun 2012 05:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=Js9idjohECUeI1G5/uBjSO4aMML8NmD2C1eOombojUo=;
        b=N1Lk3ImkwG4/2ix/QSTDXv/rq4IMCQu953sAy0gEM6IiehRsZW2kK1GJ2aXtlP2hhR
         PEP2rs5cbWKfYA/LcKLyasqcq1I80WE9NkVwBrN2NALT6fuxvxysXZin6uo0Pgb23oXN
         +l70mNiuTdWMpTOfYOJszswyEHD0V/cQPXm/3VkJqH+0oOmsVqIlDPqwyD9mUQFS3BN6
         +x3BkIZzwRS+jvcCx2ubDIH4V7mm39nw5WY0jGPdNbcWpWbJiMoUkql7I5oYKNVOEB1d
         Eiy6XAXD61Qj1hUSbRgHpW+UYanOyTAES7LxZzHuiSd9UFG+Tf+9nfPkRHf1fDznEK9V
         eHyg==
MIME-Version: 1.0
Received: by 10.152.148.199 with SMTP id tu7mr8543686lab.43.1339850803035;
 Sat, 16 Jun 2012 05:46:43 -0700 (PDT)
Received: by 10.152.5.103 with HTTP; Sat, 16 Jun 2012 05:46:42 -0700 (PDT)
In-Reply-To: <20120615131023.GA14191@loongson.cn>
References: <1339747801-28691-1-git-send-email-chenhc@lemote.com>
        <20120615131023.GA14191@loongson.cn>
Date:   Sat, 16 Jun 2012 20:46:42 +0800
Message-ID: <CAAhV-H5EbonxPVrSC+tb-yusP74dbg8T70O4iNNqp1ts1uDtRQ@mail.gmail.com>
Subject: Re: [PATCH 00/14] MIPS: Add Loongson-3 based machines support.
From:   huacai chen <chenhuacai@gmail.com>
To:     LIU Qi <liuqi@loongson.cn>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>,
        Hongliang Tao <taohl@lemote.com>, Hua Yan <yanh@lemote.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-archive-position: 33674
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chenhuacai@gmail.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

Yes, the 4th patch is add UEFI-like interface and old interface is not
supported.

On Fri, Jun 15, 2012 at 9:10 PM, LIU Qi <liuqi82@gmail.com> wrote:
> On Fri, Jun 15, 2012 at 04:09:47PM +0800, Huacai Chen wrote:
>  > This patchset is for git repository git://git.linux-mips.org/pub/scm/
>  > ralf/linux. Loongson-3 is a multi-core MIPS family CPU, it is MIPS64R2
>  > compatible and has the same IMP field (0x6300) as Loongson-2. These
>  > patches make Linux kernel support Loongson-3 CPU and Loongson-3 based
>  > computers (including Laptop, Mini-ITX, All-In-One PC, etc.)
>  >
>  > Huacai Chen(14):
>  >  MIPS: Loongson: Add basic Loongson 3 CPU support.
>  >  MIPS: Loongson 3: Add Lemote-3A machtypes definition.
>  >  MIPS: Loongson: Make Loongson 3 to use BCD format for RTC.
>  >  MIPS: Loongson: Add UEFI-like firmware interface support.
>  >  MIPS: Loongson 3: Add HT-linked PCI support.
>  >  MIPS: Loongson 3: Add IRQ init and dispatch support.
>  >  MIPS: Loongson 3: Add serial port support.
>  >  MIPS: Loongson: Add swiotlb to support big memory (>4GB).
>  >  ata: Use 32bit DMA in AHCI for Loongson 3.
>  >  drm/radeon: Make radeon card usable for Loongson.
>  >  ALSA: Make hda sound card usable for Loongson.
>  >  MIPS: Loongson 3: Add Loongson-3 SMP support.
>  >  MIPS: Loongson 3: Add CPU Hotplug support.
>  >  MIPS: Loongson: Add a Loongson 3 default config file.
>  >
>  > Signed-off-by: Huacai Chen <chenhc@lemote.com>
>  > Signed-off-by: Hongliang Tao <taohl@lemote.com>
>  > Signed-off-by: Hua Yan <yanh@lemote.com>
>
> The compiled kernel with your patches just doesn't boot. I tested with
> the Loongson3 laptop and mini-itx. Do they need the newer PMON version
> with UEFI-like interface support to boot the system?
>
> LIU Qi

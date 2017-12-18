Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 Dec 2017 14:30:05 +0100 (CET)
Received: from mail-io0-x243.google.com ([IPv6:2607:f8b0:4001:c06::243]:35306
        "EHLO mail-io0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993195AbdLRN36E8uon (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 18 Dec 2017 14:29:58 +0100
Received: by mail-io0-x243.google.com with SMTP id 14so3295592iou.2;
        Mon, 18 Dec 2017 05:29:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=NKEDsI0b4IXuW7v/QYd3Cky/hS7NTL1LBLv0GXodNwg=;
        b=gMhbnk7i/+T1wNBl/KyjidKfOdZIIeP/p2pKYgY+oGEalrDUZ6y/xqcydqB4MxbIwV
         F3PdDPwsMNZ9t8p3c8Kvge7MuzyJKDG23bPn7i3f5kmG5gRYXSS2HkAI7bPJEy6GqHvu
         cvJ1/YkXLJ/ZqG8FNXpoYE+v/wtJOJckMhy1xO5YUFw3irSRAfFcos1Md3kuuKXQKeFO
         2HG8o9rofIuoXcHj89MR1bhI40jWYOFjwr8vq+BGdqVJtadBXZKpk8Jru0v9rp+vY5Bt
         OY/HGZH8zc8ZOUs5deqIIobDFfMHVzRHZ6Y1cfPkF1uMaGSOUvu9VyAY8FrFAj4Sikxl
         uRlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=NKEDsI0b4IXuW7v/QYd3Cky/hS7NTL1LBLv0GXodNwg=;
        b=iCJD1PqLFPELfh27Uc1ZigDL6XtpxAoXFej2lhJflF9JZ2sMkiPrFjPnRNv21+Vrtp
         LhQBdPwwAVqdUzBf//HCVkvN6QD3y4pY7VTqDKwTiWLaE4bzfIE9ABYlQ7vKd54C/I0X
         RoRRW+ZPO3hnoQnGojPVLgw6PpwZKI1gsOWtjM83JPaJHpeAX2AMUcOzJpd4CNqBzmRk
         WX4Uhu+psSPcPDtKxjWrmLBOs4yQb1Od7ko1xlMrJTCtEP/tS7/YLXkxF9FnbDRwc5Qq
         Ur3+MRDy8a8Xd8vNksDXMF1Sjs6E4S30m3LMWWNCn6nNzmQ7wmBB0maMhxlAZfZMP6AY
         kFNw==
X-Gm-Message-State: AKGB3mLIU312lpH8XB8X+cWLDKX+tcOeS2KMmcfuHfJtrmOANOuXq9Uc
        7d9RQLKsuxVbZldpoPoYh99hnD9oy99R82Ubs8w=
X-Google-Smtp-Source: ACJfBou+yOlu+elRE6pKclQZYjR8CIGu/8WVFX3lGyHXFOMWBEBZxu8sVZ3axS266HlnTlaA1eDwsLG6deuo/Df/rgA=
X-Received: by 10.107.141.78 with SMTP id p75mr25243579iod.165.1513603792186;
 Mon, 18 Dec 2017 05:29:52 -0800 (PST)
MIME-Version: 1.0
Received: by 10.2.169.20 with HTTP; Mon, 18 Dec 2017 05:29:51 -0800 (PST)
In-Reply-To: <20171208154618.20105-12-alexandre.belloni@free-electrons.com>
References: <20171208154618.20105-1-alexandre.belloni@free-electrons.com> <20171208154618.20105-12-alexandre.belloni@free-electrons.com>
From:   PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
Date:   Mon, 18 Dec 2017 18:59:51 +0530
Message-ID: <CANc+2y7KLu7CwKbgbiFoQ4LORAUQoi+OkwSg5C5X+5i8KN0GLg@mail.gmail.com>
Subject: Re: [PATCH v2 11/13] MIPS: mscc: add ocelot PCB123 device tree
To:     Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <prasannatsmkumar@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61513
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: prasannatsmkumar@gmail.com
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

On 8 December 2017 at 21:16, Alexandre Belloni
<alexandre.belloni@free-electrons.com> wrote:
> Add a device tree for the Microsemi Ocelot PCB123 evaluation board.
>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> ---
>  arch/mips/boot/dts/mscc/Makefile          |  2 ++
>  arch/mips/boot/dts/mscc/ocelot_pcb123.dts | 27 +++++++++++++++++++++++++++
>  2 files changed, 29 insertions(+)
>  create mode 100644 arch/mips/boot/dts/mscc/ocelot_pcb123.dts
>
> diff --git a/arch/mips/boot/dts/mscc/Makefile b/arch/mips/boot/dts/mscc/Makefile
> index f0a155a74e02..09a1c4b97de2 100644
> --- a/arch/mips/boot/dts/mscc/Makefile
> +++ b/arch/mips/boot/dts/mscc/Makefile
> @@ -1,3 +1,5 @@
> +dtb-$(CONFIG_MSCC_OCELOT)      += ocelot_pcb123.dtb
> +
>  obj-y                          += $(patsubst %.dtb, %.dtb.o, $(dtb-y))
>
>  # Force kbuild to make empty built-in.o if necessary
> diff --git a/arch/mips/boot/dts/mscc/ocelot_pcb123.dts b/arch/mips/boot/dts/mscc/ocelot_pcb123.dts
> new file mode 100644
> index 000000000000..42bd404471f6
> --- /dev/null
> +++ b/arch/mips/boot/dts/mscc/ocelot_pcb123.dts
> @@ -0,0 +1,27 @@
> +/* SPDX-License-Identifier: (GPL-2.0 OR MIT) */
> +/* Copyright (c) 2017 Microsemi Corporation */
> +
> +/dts-v1/;
> +
> +#include "ocelot.dtsi"
> +
> +/ {
> +       compatible = "mscc,ocelot-pcb123", "mscc,ocelot";
> +
> +       chosen {
> +               stdout-path = "serial0:115200n8";
> +       };
> +
> +       memory {
> +               device_type = "memory";
> +               reg = <0x0 0x0e000000>;
> +       };
> +};
> +
> +&uart0 {
> +       status = "okay";
> +};
> +
> +&uart2 {
> +       status = "okay";
> +};
> --
> 2.15.1
>
>

Looks good to me.
Reviewed-by: PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>

Regards,
PrasannaKumar

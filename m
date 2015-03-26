Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Mar 2015 14:53:58 +0100 (CET)
Received: from mail-wg0-f42.google.com ([74.125.82.42]:34651 "EHLO
        mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006155AbbCZNxzhJQhO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 26 Mar 2015 14:53:55 +0100
Received: by wgs2 with SMTP id 2so65255689wgs.1;
        Thu, 26 Mar 2015 06:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=i6Z9ENbi0EDiMYlYugvk7UB3AxTxXEJXVpyG/ICd1Bk=;
        b=Gm5l8GfE7z8PiAWtj5gD+9ylT2WwkZ5Sr07A/OPedz4D9MT3waitAROE/gkgZ+BBPy
         Iy79d8zIykJPwj5HEy2TXIjbysuiMYmHjb+I0+VpyJciR2w6HB+JhUlYx610r+dycrLL
         vh6pePG6pDhldf0kyV0CUuXbxjiJ0FjW4RHKNYuFo8PmET2uvMtv+14Lf7STT2e6+knF
         0XYhpGS0slhsadCv7so9TtGYCI5impZe8Pd8KQPXjR54BCiiEMhH4zT4vWHkFxQtVJjP
         frAqSU2/Ulo75C4qxnjauDayninFlZ3lGWITLRoE50X3ppAJ2qz21SZE6B4W0Dmt66si
         wqYQ==
MIME-Version: 1.0
X-Received: by 10.180.77.110 with SMTP id r14mr46891598wiw.89.1427378031268;
 Thu, 26 Mar 2015 06:53:51 -0700 (PDT)
Received: by 10.28.62.131 with HTTP; Thu, 26 Mar 2015 06:53:51 -0700 (PDT)
In-Reply-To: <20150326123654.GC9705@linux-mips.org>
References: <1426213706-28542-1-git-send-email-chenhc@lemote.com>
        <1426213706-28542-2-git-send-email-chenhc@lemote.com>
        <20150326123654.GC9705@linux-mips.org>
Date:   Thu, 26 Mar 2015 21:53:51 +0800
X-Google-Sender-Auth: UncwaBrJP0kZ2GMT7-tkYgzYgUI
Message-ID: <CAAhV-H53GRTGC86oYiUyfmEWtOm4LSGtR_VQ+ZMYi_ZN81_oKQ@mail.gmail.com>
Subject: Re: [PATCH V8 7/8] MIPS: Loongson-3: Add chipset ACPI platform driver
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     "Steven J. Hill" <Steven.Hill@imgtec.com>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46545
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chenhc@lemote.com
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

OK, I'll improve my code as soon as possible.
BTW, if these two patches are OK, please apply them. :)
http://patchwork.linux-mips.org/patch/8825/
http://patchwork.linux-mips.org/patch/8826/

On Thu, Mar 26, 2015 at 8:36 PM, Ralf Baechle <ralf@linux-mips.org> wrote:
> On Fri, Mar 13, 2015 at 10:28:26AM +0800, Huacai Chen wrote:
>
>> This add south-bridge (SB700/SB710/SB800 chipset) ACPI platform driver
>> for Loongson-3. This will be used by EC (Embedded Controller, used by
>> laptops) driver and STR (Suspend To RAM).
>
> No Kconfig options?  In commit 6/8 the Kconfig help text promises:
>
> +++ b/drivers/platform/mips/Kconfig
> @@ -0,0 +1,26 @@
> +#
> +# MIPS Platform Specific Drivers
> +#
> +
> +menuconfig MIPS_PLATFORM_DEVICES
> +       bool "MIPS Platform Specific Device Drivers"
> +       default y
> +       help
> +         Say Y here to get to see options for device drivers of various
> +         MIPS platforms, including vendor-specific netbook/laptop/desktop
> +         extension and hardware monitor drivers. This option itself does
> +         not add any kernel code.
>
> Then this patch adds  loongson-specific code that will be built for all
> MIPS platforms.  And it will fail to build for non-loongson platforms.
>
>   Ralf
>

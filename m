Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 May 2015 16:41:10 +0200 (CEST)
Received: from mail-qk0-f182.google.com ([209.85.220.182]:34289 "EHLO
        mail-qk0-f182.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27026558AbbEHOlIEe0zE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 8 May 2015 16:41:08 +0200
Received: by qkgx75 with SMTP id x75so49283249qkg.1;
        Fri, 08 May 2015 07:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=LFO9fEzSS1UDFpxSn/dljxm+vBX1j1TMFWZrtqLRb0g=;
        b=R1uaWl8MLgfk8ixKUmTcLPxoh/lsV8bCW+iL58IuQSLtACv5z5HhTnvnvepyGRveq7
         N1S8PvO1Jzm6lg5CItQI5A+2jgINR16BfVc4C48M27A0fvK+KYVP5dA0EkkeE/hwjhJg
         kM36aJb62RDhBWcSIeaWN2T13qKJmqjYCWxnq/AFVsNUA5LVIPG0Lr2ucXZrVQtSaeDb
         M8m5Lqs+vuAJIczHCRxWfwsUjIf/z3g4DiEwyTF35UC0BrEB0DyQAn6Eh7vkg85jFlBl
         H2k1IAyx7NOLpB5JUQ6p/fDpf+DcH8FX6DnVGVnDiEYTqaw0ZSFNgdZ+uSYDiUAfUP+w
         yElQ==
X-Received: by 10.55.20.141 with SMTP id 13mr8984072qku.30.1431096064467; Fri,
 08 May 2015 07:41:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.94.117 with HTTP; Fri, 8 May 2015 07:40:44 -0700 (PDT)
In-Reply-To: <1431089958-2626-2-git-send-email-jaedon.shin@gmail.com>
References: <1431089958-2626-1-git-send-email-jaedon.shin@gmail.com> <1431089958-2626-2-git-send-email-jaedon.shin@gmail.com>
From:   Kevin Cernekee <cernekee@gmail.com>
Date:   Fri, 8 May 2015 07:40:44 -0700
Message-ID: <CAJiQ=7CQshXhGJ7ftWQSu_UxgKVaRprZPEPXWNP6ci_1bLrJrw@mail.gmail.com>
Subject: Re: [PATCH 1/2] MIPS: BMIPS: dts: remove unsupported entry for bcm7362
To:     Jaedon Shin <jaedon.shin@gmail.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47282
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cernekee@gmail.com
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

On Fri, May 8, 2015 at 5:59 AM, Jaedon Shin <jaedon.shin@gmail.com> wrote:
> Remove unsupported memory entry for the bcm7362 platform. The BMIPS4380
> processor only supports ZONE_NORMAL is not available for HIGHMEM.
>
> Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>
> ---
>  arch/mips/boot/dts/brcm/bcm97362svmb.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/mips/boot/dts/brcm/bcm97362svmb.dts b/arch/mips/boot/dts/brcm/bcm97362svmb.dts
> index b7b88e5dc9e7..ab8b01fa7dcf 100644
> --- a/arch/mips/boot/dts/brcm/bcm97362svmb.dts
> +++ b/arch/mips/boot/dts/brcm/bcm97362svmb.dts
> @@ -8,7 +8,7 @@
>
>         memory@0 {
>                 device_type = "memory";
> -               reg = <0x00000000 0x10000000>, <0x20000000 0x30000000>;
> +               reg = <0x00000000 0x10000000>;

Hmm, this is more of a kernel limitation than a hardware limitation,
though.  The board physically has 1GB of memory, right?  It is best if
the DT entry reflects the actual hardware configuration.

The Broadcom kernels enable the CPU's special "XKS01" feature to put
1GB of memory in ZONE_NORMAL:

https://github.com/Broadcom/stblinux-3.3/tree/master/linux

Maybe this would be worth adding to mainline.

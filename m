Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 May 2015 16:33:06 +0200 (CEST)
Received: from mail-ig0-f178.google.com ([209.85.213.178]:34409 "EHLO
        mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013017AbbETOdFVcUHn convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 20 May 2015 16:33:05 +0200
Received: by igbhj9 with SMTP id hj9so62824594igb.1
        for <linux-mips@linux-mips.org>; Wed, 20 May 2015 07:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=7BWc7aUNz3cEKpsz2sJ76I15a5LkFBUXqVIJEhvP+fI=;
        b=zV0x4Y/+riK+9AYQLqroCPKR/bGhWaOy+yP8Kxpc3nY+4GW85BoBHUhqSyFhyHQrJP
         qCcufdOPDUbgU2QN2wxxfTyLwM2Gn+66mqHwvjJGPfZhDPsYJ6ndPZGoIBAGqgHd9vXn
         JLnKMR6+VV/CkG8xFEcLEZAQ90bLGj4Tjlmpp8R7vN+m61OoZRDMyDK3hEPYGHcD58RG
         XIPy04JyYANW6c4+Eztb9jz38ZVm+rMPz1sepd+z9uKk8mwh+DwHGXPhvh46QTiNm50D
         Ukhv5p4FsxOmc8r38RT/5J/OXZb50fQTBAy7zDph+0kb2TXt24NICV70d5DP9ATSN1cI
         ngcw==
MIME-Version: 1.0
X-Received: by 10.107.158.15 with SMTP id h15mr41176833ioe.14.1432132381952;
 Wed, 20 May 2015 07:33:01 -0700 (PDT)
Received: by 10.107.36.73 with HTTP; Wed, 20 May 2015 07:33:01 -0700 (PDT)
In-Reply-To: <1432123792-4155-7-git-send-email-arend@broadcom.com>
References: <1432123792-4155-1-git-send-email-arend@broadcom.com>
        <1432123792-4155-7-git-send-email-arend@broadcom.com>
Date:   Wed, 20 May 2015 16:33:01 +0200
Message-ID: <CACna6ryt5uNkBXAk8chFyMEQVJLdHELLdA_V5TrLcaAikrTZeg@mail.gmail.com>
Subject: Re: [PATCH 6/6] brcmfmac: Add support for host platform NVRAM loading.
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
To:     Arend van Spriel <arend@broadcom.com>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Hante Meuleman <meuleman@broadcom.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Hauke Mehrtens <hauke@hauke-m.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-Path: <zajec5@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47497
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zajec5@gmail.com
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

On 20 May 2015 at 14:09, Arend van Spriel <arend@broadcom.com> wrote:
> From: Hante Meuleman <meuleman@broadcom.com>
>
> Host platforms such as routers supported by OpenWRT can
> support NVRAM reading directly from internal NVRAM store.
> With this patch the nvram load routines will fall back to
> this method when there is no nvram file and support is
> available in the kernel.

FWIW it's OpenWrt :)


> This patch relies on a change which has been submitted to the
> linux-mips maintainer [1]. However, the brcmfmac code that relies on
> it is under CONFIG_BCM47XX flag. Still need to know whether that
> patch will be accepted or not before applying this one.

Yeah, lets give this patch a few days at least, so we can be sure
it'll be properly synced with MIPS work.
I'm OK with brcmfmac internal changes (you may send them now as
separated patch if you want to), but lets be careful with
bcm47xx_nvram.h part.


> @@ -19,6 +19,9 @@
>  #include <linux/device.h>
>  #include <linux/firmware.h>
>  #include <linux/module.h>
> +#if IS_ENABLED(CONFIG_BCM47XX)
> +#include <linux/bcm47xx_nvram.h>
> +#endif

This header is safe to include on any arch, as well as all functions
are. Drop the #if please.


> @@ -66,6 +71,27 @@ struct nvram_parser {
>         bool multi_dev_v2;
>  };
>
> +#if IS_ENABLED(CONFIG_BCM47XX)
> +static char *brcmf_nvram_get_contents(size_t *nvram_size)
> +{
> +       return bcm47xx_nvram_get_contents(nvram_size);
> +}
> +
> +static void brcmf_nvram_release_contents(char *nvram)
> +{
> +       bcm47xx_nvram_release_contents(nvram);
> +}
> +#else
> +static char *brcmf_nvram_get_contents(size_t *nvram_size)
> +{
> +       return NULL;
> +}
> +
> +static void brcmf_nvram_release_contents(char *nvram)
> +{
> +}
> +#endif

Everything you put in #else simply re-implements what you sent for
MIPS tree. We don't want to duplicate that code.
Also applying above code will break building wireless-drivers-next on
MIPS, we can't push this patch.

I can understand you are looking for a way to get this patch into
current -next and to somehow sync work across trees. I'm against
anything like merging MIPS tree to wireless-driver-next, but I may
have some idea.
I think the best way for achieving this is to rework your patch to
modify include/linux/bcm47xx_nvram.h. You could modify it the same way
you did in your patch for MIPS tree, except for
bcm47xx_nvram_get_contents. Don't implement this function for real (in
.c file), but instead make in dummy inline in a bcm47xx_nvram.h like:
static inline char *bcm47xx_nvram_get_contents(size_t *val_len)
{
        /* TODO: Implement in .c file */
        return NULL;
}

-- 
Rafał

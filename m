Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Jun 2011 15:04:57 +0200 (CEST)
Received: from mail-yw0-f49.google.com ([209.85.213.49]:59942 "EHLO
        mail-yw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491846Ab1FBNEs (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 2 Jun 2011 15:04:48 +0200
Received: by ywf9 with SMTP id 9so404219ywf.36
        for <linux-mips@linux-mips.org>; Thu, 02 Jun 2011 06:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=LnKJjkzKTGiNilNhKtwT4UXNsPOZ+8rD3NSmRM+Y+vo=;
        b=m47RZoEcLm4vITPbIooHc+1b4R233g4kH3XTkZY+iwOHjCCaFoH0qNN09wT6yJuLiA
         6WDbbHFzcc2OgowN+nMc+IoSBNLX/KyKN+C6zQYtoa/1Vhy6G6YhAe95JH66tg7ALO7K
         BN33Mk356IovFkKVL0Qnl0y8rKwcnS9XuDnDo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=REtECPT/NDzZa9xyk35eEPVa+B2WFYsPYqfVTWVZooVW9LqBrniEnqibS6IzU5aI3T
         EsbPL5Er/8BNzOc/hxHXdWlgIhwh0El/IQb2thzgecCgMDJLxYsOtx+WYTz5WZEorW2B
         +fqb3uT3sUaV1fNN4CAwkQDglJfq5jG3maEC0=
MIME-Version: 1.0
Received: by 10.236.185.74 with SMTP id t50mr904167yhm.243.1307019882580; Thu,
 02 Jun 2011 06:04:42 -0700 (PDT)
Received: by 10.236.102.163 with HTTP; Thu, 2 Jun 2011 06:04:42 -0700 (PDT)
In-Reply-To: <201106021454.17652.florian@openwrt.org>
References: <201106021454.17652.florian@openwrt.org>
Date:   Thu, 2 Jun 2011 15:04:42 +0200
Message-ID: <BANLkTi=e=ZVdY7ki8AjM8Wg47iyfCNAu5A@mail.gmail.com>
Subject: Re: [PATCH 1/3] WATCHDOG: mtx1-wdt: use dev_{err,info} instead of printk()
From:   Manuel Lauss <manuel.lauss@googlemail.com>
To:     Florian Fainelli <florian@openwrt.org>
Cc:     Wim Van Sebroeck <wim@iguana.be>, linux-mips@linux-mips.org,
        linux-watchdog@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
X-archive-position: 30194
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 1747

Hi Florian,

On Thu, Jun 2, 2011 at 2:54 PM, Florian Fainelli <florian@openwrt.org> wrote:
>
> Signed-off-by: Florian Fainelli <florian@openwrt.org>
> ---
> diff --git a/drivers/watchdog/mtx-1_wdt.c b/drivers/watchdog/mtx-1_wdt.c

While you're at it, please change line 246 from

static struct platform_driver mtx1_wdt = {
to
static struct platform_driver mtx1_wdt_driver = {

to get rid of a really annoying section mismatch warning.

Thanks!
      Manuel Lauss

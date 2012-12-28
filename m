Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 Dec 2012 01:01:34 +0100 (CET)
Received: from mail-wg0-f47.google.com ([74.125.82.47]:37208 "EHLO
        mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6822190Ab2L1ABdnPLWs convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 28 Dec 2012 01:01:33 +0100
Received: by mail-wg0-f47.google.com with SMTP id dq11so4447300wgb.26
        for <multiple recipients>; Thu, 27 Dec 2012 16:01:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=DayZ8rJvbHwOnJoNDuAHwd0l8jzTWtjfKSKikJkKPEE=;
        b=dn8LMxJSDLYstp/1a44QOlN4Z0mVwMGgi69Lm463cGMb2nT3h7Psh6cfGTLyOwDH0e
         w6nDJx1owqoq9YsXfw0QJceC6yqBcKsLGnVIXnY+Fn9tosp6fgN8V/wbsalEiAlZJTYa
         FLpI+L5b9VouzBMbRGRYTHIBaTarp0v6nLsTjFfw9IBh1Q5FDaeq76rCFfUSo6EcQI2S
         XNVpMM5w52aVhoSoMCjKSzxhYsMv9waklsCM9zGAlMzAi6hauPcA+q1QpstcZBHwwGYc
         nqLp9CW0Iqh88FsPf0qCAatmjth34X769Yk8DCsQUq1wxc4q+Xc1mRAl31JZ5WFy7Zbm
         /sGw==
MIME-Version: 1.0
Received: by 10.180.87.73 with SMTP id v9mr41773824wiz.26.1356652888356; Thu,
 27 Dec 2012 16:01:28 -0800 (PST)
Received: by 10.216.21.8 with HTTP; Thu, 27 Dec 2012 16:01:28 -0800 (PST)
In-Reply-To: <1356555074-1230-1-git-send-email-hauke@hauke-m.de>
References: <1356555074-1230-1-git-send-email-hauke@hauke-m.de>
Date:   Fri, 28 Dec 2012 01:01:28 +0100
Message-ID: <CACna6ry=dLLz4dzhSLYFP-_-CDb1NcbUphJYRHv3xMi-4ufa0g@mail.gmail.com>
Subject: Re: [PATCH 0/6] MIPS: BCM47XX: nvram read enhancements
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
To:     Hauke Mehrtens <hauke@hauke-m.de>
Cc:     john@phrozen.org, ralf@linux-mips.org, linux-mips@linux-mips.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-archive-position: 35342
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
Return-Path: <linux-mips-bounce@linux-mips.org>

2012/12/26 Hauke Mehrtens <hauke@hauke-m.de>:
> Clean up the nvram reading code and add support for different nvram
> sizes.
>
> This depends on patch "MIPS: bcm47xx: separate functions finding flash
> window addr" by Rafał Miłeck, Patchwork:  https://patchwork.linux-mips.org/patch/4738/
>
> Hauke Mehrtens (6):
>   MIPS: BCM47XX: use common error codes in nvram reads
>   MIPS: BCM47XX: return error when init of nvram failed
>   MIPS: BCM47XX: nvram add nand flash support
>   MIPS: BCM47XX: rename early_nvram_init to nvram_init
>   MIPS: BCM47XX: handle different nvram sizes
>   MIPS: BCM47XX: add bcm47xx prefix in front of nvram function names

Tested-by: Rafał Miłecki <zajec5@gmail.com>

I wonder if it would be easier to write nvram.c from the scratch ;)

-- 
Rafał

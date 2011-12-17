Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 17 Dec 2011 14:14:14 +0100 (CET)
Received: from mail-vx0-f177.google.com ([209.85.220.177]:36592 "EHLO
        mail-vx0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903684Ab1LQNOL convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 17 Dec 2011 14:14:11 +0100
Received: by vcbf11 with SMTP id f11so3031260vcb.36
        for <linux-mips@linux-mips.org>; Sat, 17 Dec 2011 05:14:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=WDDG5p9R9FxgFCBKVpGvyNN0fjOR3NnzIW1fCyTnPdM=;
        b=VGsX7Wmz0oXCJbkwBujLJX4M//x5tcQQnETm4DqW7yCa8ojW7X6KpzYclvQonSdClv
         eQRXMaiVJieo2HDspeRFAFMeHL3V+QoXNg+xuoMk+S8CWbno9aXl+xktOzpyu64lq84e
         8wx/anhVluTpofM0YEbUBgB371RlELfFVQ/o8=
Received: by 10.220.149.200 with SMTP id u8mr6013515vcv.35.1324127643416; Sat,
 17 Dec 2011 05:14:03 -0800 (PST)
MIME-Version: 1.0
Received: by 10.52.182.98 with HTTP; Sat, 17 Dec 2011 05:13:42 -0800 (PST)
In-Reply-To: <1324126698-9919-3-git-send-email-jonas.gorski@gmail.com>
References: <1324126698-9919-1-git-send-email-jonas.gorski@gmail.com> <1324126698-9919-3-git-send-email-jonas.gorski@gmail.com>
From:   Guillaume LECERF <glecerf@gmail.com>
Date:   Sat, 17 Dec 2011 14:13:42 +0100
X-Google-Sender-Auth: wh68Xh41lObrt1Pmx4OEOqH7Ago
Message-ID: <CAJpamw5qTXwMC_HQXN+ehjxDDQ6GXT_-Kcfu8E7P5F2CnLqsZA@mail.gmail.com>
Subject: Re: [PATCH 2/5] MTD: bcm63xxpart: make sure CFE and NVRAM partitions
 are at least 64K
To:     Jonas Gorski <jonas.gorski@gmail.com>
Cc:     linux-mtd@lists.infradead.org, linux-mips@linux-mips.org,
        Artem Bityutskiy <Artem.Bityutskiy@intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Florian Fainelli <florian@openwrt.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-archive-position: 32121
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: glecerf@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 14091

Hi Jonas,

2011/12/17 Jonas Gorski <jonas.gorski@gmail.com>:
> -       spareaddr = roundup(totallen, master->erasesize) + master->erasesize;
> -       sparelen = master->size - spareaddr - master->erasesize;
> +       spareaddr = roundup(totallen, master->erasesize) + cfelen;

spareaddr = roundup(totallen, cfelen) + cfelen ?

-- 
Guillaume LECERF
OpenBricks developer - www.openbricks.org

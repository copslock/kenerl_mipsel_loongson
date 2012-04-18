Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Apr 2012 22:44:43 +0200 (CEST)
Received: from mail-pb0-f49.google.com ([209.85.160.49]:40425 "EHLO
        mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903725Ab2DRUog (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 18 Apr 2012 22:44:36 +0200
Received: by pbcun4 with SMTP id un4so10201718pbc.36
        for <linux-mips@linux-mips.org>; Wed, 18 Apr 2012 13:44:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent
         :x-gm-message-state;
        bh=7vDKk1/4N4Zzdoz1N88oMZCPFE8Wjon6BVqgwrLf21U=;
        b=n6vNsT1VsVDaIunfW8ni0j/V6B+Em74yW/xhFuluGphV1xJHkm+ai1xj/36fletwC7
         3yp2VVI1bd8uusmUTLJ4jaYoVs27RhNUIn6PIbnL/r5kXhZ6pTigK4zb5CfNuc771ZQe
         stUwNeYb6W7sQFWvGVAc21OhCHQWKwE0LyrTo+s69Yy7BQ8vEKG8DpgDn7RYynK63bhz
         IkvLJAWfwGXP3T9Xyw/NqI0uZ6l/F+DMtzwE4gVh5qr5IMRIwhPPDcY8v+4CxAta9YYR
         9jxGkjPF9ZSXN8ka61nEEpsd/qdChLP0vwU6yaQZMiXqceykEuycSqrzZuXMDT/lPeUn
         oerw==
Received: by 10.68.196.231 with SMTP id ip7mr9232236pbc.29.1334781869366;
        Wed, 18 Apr 2012 13:44:29 -0700 (PDT)
Received: from localhost (c-67-168-183-230.hsd1.wa.comcast.net. [67.168.183.230])
        by mx.google.com with ESMTPS id sx2sm127605pbc.26.2012.04.18.13.44.25
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 18 Apr 2012 13:44:27 -0700 (PDT)
Date:   Wed, 18 Apr 2012 13:44:24 -0700
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Hauke Mehrtens <hauke@hauke-m.de>
Cc:     stern@rowland.harvard.edu, linux-mips@linux-mips.org,
        ralf@linux-mips.org, m@bues.ch, linux-usb@vger.kernel.org,
        linux-wireless@vger.kernel.org, zajec5@gmail.com
Subject: Re: [PATCH v5 0/4] USB: OHCI/EHCI: generic platform driver
Message-ID: <20120418204424.GA20171@kroah.com>
References: <1331851799-5968-1-git-send-email-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1331851799-5968-1-git-send-email-hauke@hauke-m.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Gm-Message-State: ALoCoQkAUrFMJsw2JZ3H7KqSkwSyMlL/wXmyzRN+7yUatKfX/OODE8kDZMOKxIg6A12FLcEJ1ZX3
X-archive-position: 32965
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@linuxfoundation.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On Thu, Mar 15, 2012 at 11:49:55PM +0100, Hauke Mehrtens wrote:
> This EHCI/OHCI platform driver should replace the simple EHCI and OHCI 
> platform drivers. It was developed to be used for the USB core of the 
> Broadcom SoCs supported by ssb and bcma, but it should also work for 
> other devices.
> 
> Drivers like ehci-ath79.c, ehci-xls.c and ehci-ixp4xx.c should be 
> relative easy be ported to this EHCI driver.
> And drivers like ohci-ath79.c, ohci-ppc-soc.c, ohci-sh.c and ohci-xls.c 
> should be easy be ported to the this OHCI driver.
> 
> I am unable to test the suspend and resume part, as my SoC does not 
> support this, but most of the platform driver do not support 
> suspend/resume too. The code here should work, but was never runtime 
> tested.
> 
> This also contains patches adding USB support for the SoCs based on ssb 
> and bcma and converts the ath79 code to use the generic usb driver.
> 
> This patch series is based on the usb tree and should go through it to Linus.

All now applied, thanks.

greg k-h

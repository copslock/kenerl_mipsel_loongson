Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Mar 2012 20:47:21 +0100 (CET)
Received: from mail-pz0-f49.google.com ([209.85.210.49]:52178 "EHLO
        mail-pz0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903659Ab2COTrR (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 15 Mar 2012 20:47:17 +0100
Received: by dakp5 with SMTP id p5so4615012dak.36
        for <linux-mips@linux-mips.org>; Thu, 15 Mar 2012 12:47:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent
         :x-gm-message-state;
        bh=k5Ku08/UcrAQCCnU8BkIWMfq9Fz+harLQ4xERaBlm7c=;
        b=SQtYguOEe6SsQbheEksAQH00whb1mD6nXJpHETaeuZZsu3Dbz3Zr0VYhaKbPZz6gWl
         uzScx3JXWf8x2KRsSd3cP6Wk4UvAE+O5K6QFmQquCcWHa65U/cw0vQ1L4Kklxn7SAkI6
         RynY9zbJSwXg5a1rwVV3OvWATOuGw0pudWkdWOEBe7kO0M+irMzvJgVsUBfj59scw24n
         /pzp12oRMnzhigm7L4AkxiGxE5vFU8a65y8wb+JSerm08xWWKbQIdzkgYCAzQEtIhB+l
         /5XqVaC512KVvM4mZI/GtuGDeZgG252c6jSX0sd9eSxYMJ/vFUM595U+lmSN2spTCvVL
         4NsA==
Received: by 10.68.234.131 with SMTP id ue3mr7550806pbc.5.1331840831521;
        Thu, 15 Mar 2012 12:47:11 -0700 (PDT)
Received: from localhost (c-76-121-69-168.hsd1.wa.comcast.net. [76.121.69.168])
        by mx.google.com with ESMTPS id s10sm2531613pbp.14.2012.03.15.12.47.08
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 15 Mar 2012 12:47:09 -0700 (PDT)
Date:   Thu, 15 Mar 2012 12:47:07 -0700
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Hauke Mehrtens <hauke@hauke-m.de>
Cc:     stern@rowland.harvard.edu, linux-mips@linux-mips.org,
        ralf@linux-mips.org, m@bues.ch, linux-usb@vger.kernel.org,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH v4 0/7] USB: OHCI/EHCI: generic platform driver
Message-ID: <20120315194707.GA8079@kroah.com>
References: <1331597093-425-1-git-send-email-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1331597093-425-1-git-send-email-hauke@hauke-m.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Gm-Message-State: ALoCoQkOF++YNaTFRWa4ajhIuHEiWdK+AIxQfiCMTN2wyzzrlUUNZpKVuXyMCjZAVAzJZOrx0/6i
X-archive-position: 32714
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@linuxfoundation.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On Tue, Mar 13, 2012 at 01:04:46AM +0100, Hauke Mehrtens wrote:
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

I've applied patches 1, 2, and 7 of this series.  3 and 4 I've commented
on, and I'm guessing 5 and 6 depend on 3 and 4.

Care to refresh the remaining ones and get the BCMA developers ack so
that I can take them?

thanks,

greg k-h

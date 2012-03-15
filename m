Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Mar 2012 20:44:42 +0100 (CET)
Received: from mail-pz0-f49.google.com ([209.85.210.49]:51856 "EHLO
        mail-pz0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903659Ab2COToh (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 15 Mar 2012 20:44:37 +0100
Received: by dakp5 with SMTP id p5so4611534dak.36
        for <linux-mips@linux-mips.org>; Thu, 15 Mar 2012 12:44:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent
         :x-gm-message-state;
        bh=n40gh3vva+zRGHFg+rfRyUBoUPFk30ur54yCeuNxKT0=;
        b=mFxeKX6K4IynK3qIDkDvDsdjVTpWh4Q1T40rnOjSQkt+JkQ/Y+lE2Om1r8MXylsM0r
         iYJMcEbvmw+ZPS5u0v90OWcdm5WPTHohPyR36I/5aO20IOt+TjNzWTsWSGkOxTX1r5V/
         45yOjmHPAKnWpuobWKBXeQlSpAhGKQ9htDoWBuEdH4xsjesH8S0Q00JG/P+pnEQQyfkE
         gAWc7Mq0IOcbAWMCNkv41CYPxXMDcG3V8R/CDO4hM5ogCQs8Dnkya2DZ+K4WLSyJKWeQ
         G1rVWUFs6Kv3p/y2sjPxZFcgRyVgXVPZzYCfGUzPGS3E9sIInSUvpAwn24Aa8Exhos3D
         83zg==
Received: by 10.68.226.225 with SMTP id rv1mr7475690pbc.44.1331840670519;
        Thu, 15 Mar 2012 12:44:30 -0700 (PDT)
Received: from localhost (c-76-121-69-168.hsd1.wa.comcast.net. [76.121.69.168])
        by mx.google.com with ESMTPS id d10sm2511320pbr.59.2012.03.15.12.44.27
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 15 Mar 2012 12:44:28 -0700 (PDT)
Date:   Thu, 15 Mar 2012 12:44:26 -0700
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Hauke Mehrtens <hauke@hauke-m.de>
Cc:     stern@rowland.harvard.edu, linux-mips@linux-mips.org,
        ralf@linux-mips.org, m@bues.ch, linux-usb@vger.kernel.org,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH v4 4/7] USB: Add driver for the bcma bus
Message-ID: <20120315194426.GA30682@kroah.com>
References: <1331597093-425-1-git-send-email-hauke@hauke-m.de>
 <1331597093-425-5-git-send-email-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1331597093-425-5-git-send-email-hauke@hauke-m.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Gm-Message-State: ALoCoQnXhA51SW5lEZTUn6EI7UqDvFw6TAZSl1RHe3NEyai9i1GEgoF9gD8GWimEPMb6TxWqyu0q
X-archive-position: 32712
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@linuxfoundation.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On Tue, Mar 13, 2012 at 01:04:50AM +0100, Hauke Mehrtens wrote:
> This adds a USB driver using the generic platform device driver for the
> USB controller found on the Broadcom bcma bus. The bcma bus just
> exposes one device which serves the OHCI and the EHCI controller at the
> same time. This driver probes for this USB controller and creates and
> registers two new platform devices which will be probed by the new
> generic platform device driver. This makes it possible to use the EHCI
> and the OCHI controller on the bcma bus at the same time.
> 
> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
> ---
>  drivers/usb/host/Kconfig    |   12 ++

This patch fails to apply here, and I can't seem to figure out what tree
you made this against to fix it up by hand on my end.

Any thoughts?

greg k-h

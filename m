Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Mar 2012 20:45:08 +0100 (CET)
Received: from mail-yx0-f177.google.com ([209.85.213.177]:45511 "EHLO
        mail-yx0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903663Ab2COTpE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 15 Mar 2012 20:45:04 +0100
Received: by yenm10 with SMTP id m10so3917342yen.36
        for <linux-mips@linux-mips.org>; Thu, 15 Mar 2012 12:44:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent:x-gm-message-state;
        bh=GW2eMifo69Tj7HQy6g74Zd/2DYYNUPCmu0WKBZFO2hQ=;
        b=CDmTbWkJykuqnrcV1lr7SuDlkNfZCq2m/yVuPlgO5xrMzyb9jqjRniDwxvBMXLfB1t
         QyYBqXlVXsYlgxx+caCRg1XNzXmBQpp+eXuUMS6noqSO/fG6Y1pAUKrqZbWfeTXi8O2y
         vdd17cwdhmr6BcLv5Q2YewLThy+PC9Bmd0CzxsMHnvTvkFhJE474JqCvXbqCTB/ugsHS
         027MBC9EJaE5RUdShUaM3AZzan7cVcWbBgPpgIqtf+71Ar7e8iHQ2bdset5VnQX/PgI3
         ivAdys1vfRnUXVSJUGhVX3QDkLlC/nsWCp8n8pzCrpZCanW2N0es/sRyil9gI7Q+ltQ8
         1yrg==
Received: by 10.68.131.104 with SMTP id ol8mr6011721pbb.112.1331840697952;
        Thu, 15 Mar 2012 12:44:57 -0700 (PDT)
Received: from localhost (c-76-121-69-168.hsd1.wa.comcast.net. [76.121.69.168])
        by mx.google.com with ESMTPS id k2sm2523431pba.28.2012.03.15.12.44.55
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 15 Mar 2012 12:44:56 -0700 (PDT)
Date:   Thu, 15 Mar 2012 12:44:53 -0700
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Hauke Mehrtens <hauke@hauke-m.de>
Cc:     stern@rowland.harvard.edu, linux-mips@linux-mips.org,
        ralf@linux-mips.org, m@bues.ch, linux-usb@vger.kernel.org,
        linux-wireless@vger.kernel.org,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Subject: Re: [PATCH v4 3/7] bcma: scan for extra address space
Message-ID: <20120315194453.GB30682@kroah.com>
References: <1331597093-425-1-git-send-email-hauke@hauke-m.de>
 <1331597093-425-4-git-send-email-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1331597093-425-4-git-send-email-hauke@hauke-m.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Gm-Message-State: ALoCoQnUfIyIF8fyZvqCqdwJ6SMxWqceyaQQB1N5eIMjGbcL9ZA4U3xgGV+0a/WtU7UtuekrqdLj
X-archive-position: 32713
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@linuxfoundation.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On Tue, Mar 13, 2012 at 01:04:49AM +0100, Hauke Mehrtens wrote:
> Some cores like the USB core have two address spaces. In the USB host
> controller one address space is used for the OHCI and the other for the
> EHCI controller interface. The USB controller is the only core I found
> with two address spaces. This code is based on the AI scan function
> ai_scan() in shared/aiutils.c in the Broadcom SDK.
> 
> CC: Rafał Miłecki <zajec5@gmail.com>
> CC: linux-wireless@vger.kernel.org
> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
> ---
>  drivers/bcma/scan.c       |   19 ++++++++++++++++++-
>  include/linux/bcma/bcma.h |    1 +
>  2 files changed, 19 insertions(+), 1 deletions(-)

Is this required for the 4/7 patch?

If so, can I get an ack from the BCMA developers so that I can take this
through the USB tree?

thanks,

greg k-h

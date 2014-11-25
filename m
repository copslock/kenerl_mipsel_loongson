Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 Nov 2014 18:20:06 +0100 (CET)
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:51174 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006676AbaKYRT7n3ktb (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 25 Nov 2014 18:19:59 +0100
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id 173E720F52
        for <linux-mips@linux-mips.org>; Tue, 25 Nov 2014 12:19:59 -0500 (EST)
Received: from frontend2 ([10.202.2.161])
  by compute2.internal (MEProxy); Tue, 25 Nov 2014 12:19:59 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
        messagingengine.com; h=x-sasl-enc:date:from:to:cc:subject
        :message-id:references:mime-version:content-type:in-reply-to; s=
        smtpout; bh=pQ0KieUZO1s9qcXgYw7WEe1OTCM=; b=Ykz//8xWb0wFiJkFOZaj
        ee0FEt0BD3MfJ6rmu7sfUIzkHyFB2CRVAyNOT7q8OHTFtJIkPtD+WUtSTFkgzD8s
        50+llUe9EXCDD0cc+xapi9CWAEDkU2BcRYPoidVUar9lgCOLZAs12yreth9JacLA
        0TABrVCl9SZJJ0zUNgYo3E8=
X-Sasl-enc: 1Ws0DR0JiNkrUUlYp099CO3aeIOvgliBSvZr2KWEf24U 1416935998
Received: from localhost (unknown [24.22.230.10])
        by mail.messagingengine.com (Postfix) with ESMTPA id A71D96800CD;
        Tue, 25 Nov 2014 12:19:58 -0500 (EST)
Date:   Tue, 25 Nov 2014 09:19:57 -0800
From:   Greg KH <greg@kroah.com>
To:     Andreas Herrmann <andreas.herrmann@caviumnetworks.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        David Daney <david.daney@cavium.com>,
        Alex Smith <alex.smith@imgtec.com>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        linux-usb <linux-usb@vger.kernel.org>
Subject: Re: [PATCH 1/3 v2] USB: host: Remove ehci-octeon and ohci-octeon
 drivers
Message-ID: <20141125171957.GA15925@kroah.com>
References: <1415914590-31647-1-git-send-email-andreas.herrmann@caviumnetworks.com>
 <1415914590-31647-2-git-send-email-andreas.herrmann@caviumnetworks.com>
 <20141125012134.GA5579@kroah.com>
 <20141125102336.GA15630@alberich>
 <20141125112846.GB15630@alberich>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20141125112846.GB15630@alberich>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <greg@kroah.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44444
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: greg@kroah.com
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

On Tue, Nov 25, 2014 at 12:28:46PM +0100, Andreas Herrmann wrote:
> From: Alan Stern <stern@rowland.harvard.edu>
> 
> Remove special-purpose octeon drivers and instead use ehci-platform
> and ohci-platform as suggested with
> http://marc.info/?l=linux-mips&m=140139694721623&w=2
> 
> [andreas.herrmann:
>     fixed compile error]
> 
> Cc: David Daney <david.daney@cavium.com>
> Cc: Alex Smith <alex.smith@imgtec.com>
> Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
> Signed-off-by: Andreas Herrmann <andreas.herrmann@caviumnetworks.com>
> Acked-by: Ralf Baechle <ralf@linux-mips.org>
> Tested-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> ---
>  arch/mips/cavium-octeon/octeon-platform.c |  274 ++++++++++++++++++++++++++++-
>  arch/mips/configs/cavium_octeon_defconfig |    3 +
>  drivers/usb/host/Kconfig                  |   18 +-
>  drivers/usb/host/Makefile                 |    1 -
>  drivers/usb/host/ehci-hcd.c               |    5 -
>  drivers/usb/host/ehci-octeon.c            |  182 -------------------
>  drivers/usb/host/octeon2-common.c         |  200 ---------------------
>  drivers/usb/host/ohci-hcd.c               |    5 -
>  drivers/usb/host/ohci-octeon.c            |  196 ---------------------
>  9 files changed, 285 insertions(+), 599 deletions(-)
>  delete mode 100644 drivers/usb/host/ehci-octeon.c
>  delete mode 100644 drivers/usb/host/octeon2-common.c
>  delete mode 100644 drivers/usb/host/ohci-octeon.c
> 
> 
> There was a conflict with commits
> 073153bf22764 (host: ehci-octeon: remove duplicate check on resource)
> c6d413cebd82c (host: ohci-octeon: remove duplicate check on resource)
> 
> I rebased the patch to your usb-next branch as of
> v3.18-rc4-66-g69b7290.
> 
> Patch 2 and 3 of the series should apply w/o issues.

They are long-gone from my queue, please resend.

thanks,

greg k-h

Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Mar 2012 00:35:47 +0100 (CET)
Received: from mail-pz0-f49.google.com ([209.85.210.49]:56394 "EHLO
        mail-pz0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903667Ab2COXfl (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 16 Mar 2012 00:35:41 +0100
Received: by dakp5 with SMTP id p5so4896429dak.36
        for <linux-mips@linux-mips.org>; Thu, 15 Mar 2012 16:35:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent
         :x-gm-message-state;
        bh=12AILZrReOcmh46TXwULypFnX1IKk5Ag8SU68hJ67Fs=;
        b=pLuMcdYWCPgcU0v7TDTfrIj9unqaDfMhZBDZ4U6At1E7a2ax670VHsi7KfJHIadYex
         aRfgADtDaVZ2+0kcYNdFRUNzmzUHRGNcsQQojDUooqIOVyjPjkaA/iSebSfJVD6yYfzH
         JnUz2wAy61/5+jOR2ahD4paFGHANRgugemAjnwtLCjCRiBU8vpRe9ao6jwQbhJFH7B2A
         0G6+nLBl8hlQRlE5/MqW/Ftgd+BMYn6/cxod4DLH5kqFi4LBMS63ys76kYcmMkD+BMCe
         KKUGwyVoHGCQtdssNllqQIB5eWaH08/IfFPASt8NTjPuEJUbI3yjOq4SseVkX8L00LY1
         kdDg==
Received: by 10.68.130.103 with SMTP id od7mr8237348pbb.66.1331854534450;
        Thu, 15 Mar 2012 16:35:34 -0700 (PDT)
Received: from localhost (c-76-121-69-168.hsd1.wa.comcast.net. [76.121.69.168])
        by mx.google.com with ESMTPS id d10sm2854922pbr.59.2012.03.15.16.35.32
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 15 Mar 2012 16:35:33 -0700 (PDT)
Date:   Thu, 15 Mar 2012 16:35:31 -0700
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Hauke Mehrtens <hauke@hauke-m.de>
Cc:     stern@rowland.harvard.edu, linux-mips@linux-mips.org,
        ralf@linux-mips.org, m@bues.ch, linux-usb@vger.kernel.org,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH v4 4/7] USB: Add driver for the bcma bus
Message-ID: <20120315233531.GA2052@kroah.com>
References: <1331597093-425-1-git-send-email-hauke@hauke-m.de>
 <1331597093-425-5-git-send-email-hauke@hauke-m.de>
 <20120315194426.GA30682@kroah.com>
 <4F626FCB.6010103@hauke-m.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4F626FCB.6010103@hauke-m.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Gm-Message-State: ALoCoQlHE0dGzS11y8r20MKNBaNu0APSj6Bep1SMidddg6dmYyUoGLx9gsVY5YwwPV4qI4oCOgIu
X-archive-position: 32723
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@linuxfoundation.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On Thu, Mar 15, 2012 at 11:40:11PM +0100, Hauke Mehrtens wrote:
> On 03/15/2012 08:44 PM, Greg KH wrote:
> > On Tue, Mar 13, 2012 at 01:04:50AM +0100, Hauke Mehrtens wrote:
> >> This adds a USB driver using the generic platform device driver for the
> >> USB controller found on the Broadcom bcma bus. The bcma bus just
> >> exposes one device which serves the OHCI and the EHCI controller at the
> >> same time. This driver probes for this USB controller and creates and
> >> registers two new platform devices which will be probed by the new
> >> generic platform device driver. This makes it possible to use the EHCI
> >> and the OCHI controller on the bcma bus at the same time.
> >>
> >> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
> >> ---
> >>  drivers/usb/host/Kconfig    |   12 ++
> > 
> > This patch fails to apply here, and I can't seem to figure out what tree
> > you made this against to fix it up by hand on my end.
> > 
> > Any thoughts?
> > 
> > greg k-h
> 
> This patch was against
> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git#master, but
> I will rebase it onto usb/usb-next and send a new version of the patches
> you have not applied.

Thanks, master tracks Linus's tree, which is not good to send patches
against :)

greg k-h

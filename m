Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Nov 2014 12:47:32 +0100 (CET)
Received: from mail-wi0-f181.google.com ([209.85.212.181]:48903 "EHLO
        mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012648AbaKNLrYnu35S (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 14 Nov 2014 12:47:24 +0100
Received: by mail-wi0-f181.google.com with SMTP id n3so2379311wiv.14
        for <linux-mips@linux-mips.org>; Fri, 14 Nov 2014 03:47:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=xIcOU5IFiXNBeZk0UStHF0FbCv6fC7KRsPe3d0Isp1s=;
        b=LGdr1HJRgCebdAJYtyLhjdL7RlCTyIbG+DVkQQWT+2aYaYD8vpxFgg+hASIGzzcqvC
         Q3suDF4TlfuQwaGg/icCCKqtsUNIgQqeZ2fINH1XQARK8j/M62QMcArOmCJLAedaLdsL
         xl/UgaZuYPOFcB7/wR0jnPzmLK6L3krz2LtMz847DTsF1PtWnncHb0xjUNxkCiAJUeHx
         ldNCuZeEJcwNdkRqIqyczbGFqOF8NjKDqaOVIblC6Wlt8ucJRoiC8tcTLVIDWTweg6pg
         sfM3s/Sb/ZXghE78egP0F1vshnm9HCdMB2JRv1OY7gyJ5qdVQSflx3gawMUk9sC4nKCd
         1mbg==
X-Received: by 10.194.110.4 with SMTP id hw4mr13292574wjb.102.1415965639478;
        Fri, 14 Nov 2014 03:47:19 -0800 (PST)
Received: from alberich ([2.165.41.20])
        by mx.google.com with ESMTPSA id ci9sm3098318wid.24.2014.11.14.03.47.18
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 14 Nov 2014 03:47:18 -0800 (PST)
Date:   Fri, 14 Nov 2014 12:47:14 +0100
From:   Andreas Herrmann <herrmann.der.user@googlemail.com>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Andreas Herrmann <andreas.herrmann@caviumnetworks.com>,
        David Daney <david.daney@cavium.com>,
        Alex Smith <alex.smith@imgtec.com>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        linux-usb <linux-usb@vger.kernel.org>
Subject: Re: [PATCH 0/3] USB: host: Misc patches to remove hard-coded octeon
 platform information
Message-ID: <20141114114714.GA16123@alberich>
References: <1415914590-31647-1-git-send-email-andreas.herrmann@caviumnetworks.com>
 <Pine.LNX.4.44L0.1411131712201.4266-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1411131712201.4266-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <herrmann.der.user@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44158
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: herrmann.der.user@googlemail.com
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

On Thu, Nov 13, 2014 at 05:13:36PM -0500, Alan Stern wrote:
> On Thu, 13 Nov 2014, Andreas Herrmann wrote:
> 
> > Hi Alan,
> > 
> > With following patches I want to base octeon ehci/ohci device
> > configuration on device tree information.
> > 
> > I picked up patches that were submitted in May. See
> > http://marc.info/?l=linux-usb&m=140135823325811&w=2
> > and http://marc.info/?l=linux-mips&m=140139694721623&w=2
> > 
> > Patch #1 is your "untested preliminary pass" to remove
> >  [oe]hci-octeon drivers.
> > Patch #2 is the removal of hard-coded platform information (but now
> >  rebased on your patch)
> > Patch #3 adapts dma_mask for ehci (as used in ehci-octeon)
> > 
> > Overall diffstat is
> > 
> >  arch/mips/cavium-octeon/octeon-platform.c |  380 +++++++++++++++++++++++------
> >  arch/mips/configs/cavium_octeon_defconfig |    3 +
> >  drivers/usb/host/Kconfig                  |   18 +-
> >  drivers/usb/host/Makefile                 |    1 -
> >  drivers/usb/host/ehci-hcd.c               |    5 -
> >  drivers/usb/host/ehci-octeon.c            |  188 --------------
> >  drivers/usb/host/ehci-platform.c          |    4 +-
> >  drivers/usb/host/octeon2-common.c         |  200 ---------------
> >  drivers/usb/host/ohci-hcd.c               |    5 -
> >  drivers/usb/host/ohci-octeon.c            |  202 ---------------
> >  drivers/usb/host/ohci-platform.c          |    1 +
> >  include/linux/usb/ehci_pdriver.h          |    1 +
> >  12 files changed, 330 insertions(+), 678 deletions(-)
> > 
> > Patches are based on v3.18-rc4-65-g2c54396
> > 
> > Comments welcome.
> 
> At a very quick first glance, it looks great.  Have you tested it 
> thoroughly?

 [sorry have to use another mail account, so far your mail didn't show
  up at my caviumnetworks account]

I've tested it only on an EdgeRouterPro (Octeon II system, which I
have on-site).

octeon_ehci_device_init and octeon_ohci_device_init run way before
ehci-platform and ohci-platform probe for devices. So everything
should be initialized orderly.

With current mainline (w/o these patches) USB doesn't work on my
EdgeRouterPro due to an (inappropriate) OCTEON_IS_MODEL check.

I'd say having the patches in linux-next for awhile wouldn't hurt.


Andreas

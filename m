Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Nov 2011 22:14:17 +0100 (CET)
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:41187 "EHLO
        out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903965Ab1KBVOK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 2 Nov 2011 22:14:10 +0100
Received: from compute4.internal (compute4.nyi.mail.srv.osa [10.202.2.44])
        by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id A606C20F6D;
        Wed,  2 Nov 2011 17:14:08 -0400 (EDT)
Received: from frontend1.nyi.mail.srv.osa ([10.202.2.160])
  by compute4.internal (MEProxy); Wed, 02 Nov 2011 17:14:08 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
        messagingengine.com; h=date:from:to:cc:subject:message-id
        :references:mime-version:content-type:in-reply-to; s=smtpout;
         bh=gECfRHLPzcQw2IP3dTr6wl6LmNw=; b=BYcbEdUy6LBMqBwuBgt1yWFONAf3
        2ugipOiYRmbXMpEQ0KSbbeW5xZAAmyVGOsLYOyItB9EjVfKBBo0x54TAUnZYdwVH
        V9k188KdhCIbLO6IrYPYY4Y2P7/8UXhk50enHs9/vowAqoaEMdiev0NHhgDP65q5
        RvhddBWwRRJF1bY=
X-Sasl-enc: tYRpYk0gWb7zT5sxeZCYBVpEt+U/c5kdYTNv9AfXjFfY 1320268448
Received: from localhost (c-76-121-69-168.hsd1.wa.comcast.net [76.121.69.168])
        by mail.messagingengine.com (Postfix) with ESMTPSA id 37EED8E1007;
        Wed,  2 Nov 2011 17:14:08 -0400 (EDT)
Date:   Wed, 2 Nov 2011 14:08:54 -0700
From:   Greg KH <greg@kroah.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Florian Fainelli <florian@openwrt.org>, linux-mips@linux-mips.org,
        Greg KH <gregkh@suse.de>
Subject: Re: [PATCH] Revert "MIPS: MTX-1: Make au1000_eth probe all PHY
Message-ID: <20111102210854.GD9949@kroah.com>
References: <201110171943.06143.florian@openwrt.org>
 <20111021122549.GA12686@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20111021122549.GA12686@linux-mips.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 31366
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: greg@kroah.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 1827

On Fri, Oct 21, 2011 at 01:25:49PM +0100, Ralf Baechle wrote:
> On Mon, Oct 17, 2011 at 07:43:06PM +0200, Florian Fainelli wrote:
> 
> > Commit ec3eb823 was not applicable in 2.6.32 and introduces a build breakage.
> > Revert that commit since it is irrelevant for this kernel version.
> > 
> > CC: stable@kernel.org
> > Signed-off-by: Florian Fainelli <florian@openwrt.org>
> > ---
> > Greg, this is applicable from 2.6.32+ to 2.6.33+ included.
> 
> On 2.6.33-stable the commit ID to be reverted is 34dce55d.
> 
> Acked-by: Ralf Baechle <ralf@linux-mips.org>
> 
> (Or should it be Un-Acked-by: for reverting a patch?  ;-)

Heh.

Thanks, I've applied this revert now.

greg k-h

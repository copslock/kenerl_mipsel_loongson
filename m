Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 27 Nov 2011 10:52:57 +0100 (CET)
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:48377 "EHLO
        out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903597Ab1K0Jwu (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 27 Nov 2011 10:52:50 +0100
Received: from compute4.internal (compute4.nyi.mail.srv.osa [10.202.2.44])
        by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id A692A209A5
        for <linux-mips@linux-mips.org>; Sun, 27 Nov 2011 04:52:48 -0500 (EST)
Received: from frontend2.nyi.mail.srv.osa ([10.202.2.161])
  by compute4.internal (MEProxy); Sun, 27 Nov 2011 04:52:48 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
        messagingengine.com; h=date:from:to:cc:subject:message-id
        :references:mime-version:content-type:in-reply-to; s=smtpout;
         bh=NmwGj0fj9kvkJ6Yuvsa7ZNGpLBY=; b=OZUalmNQB0Kx4u/6GZF89wOQTztR
        Z/9mG3TSjj/w6ZPMlCEqDipw0+kx0H9ZCBWGpoamRhUPIu3D+qaBFGhcZjutv82m
        LYvYX++rU0BJVKPyFxkrZieGrN4Nr7lwnjYjXZ6CDyRulFuW1MEOuySNm7tzYAjd
        7bHgm9PO5Ds9q7s=
X-Sasl-enc: 0VxubcDldYorrSuPzTu5ZOpTavXnk8DurJlssSEWFnzP 1322387566
Received: from localhost (mobile-166-193-127-078.mycingular.net [166.193.127.78])
        by mail.messagingengine.com (Postfix) with ESMTPSA id 736FA4824AF;
        Sun, 27 Nov 2011 04:52:46 -0500 (EST)
Date:   Sat, 26 Nov 2011 18:04:44 -0800
From:   Greg KH <greg@kroah.com>
To:     ddaney.cavm@gmail.com
Cc:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        devicetree-discuss@lists.ozlabs.org, grant.likely@secretlab.ca,
        linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@suse.de>, devel@driverdev.osuosl.org
Subject: Re: [PATCH 8/8] staging: octeon_ethernet: Convert to use device tree.
Message-ID: <20111127020444.GA32071@kroah.com>
References: <1320978124-13042-1-git-send-email-ddaney.cavm@gmail.com>
 <1320978124-13042-9-git-send-email-ddaney.cavm@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1320978124-13042-9-git-send-email-ddaney.cavm@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 32004
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: greg@kroah.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 22166

On Thu, Nov 10, 2011 at 06:22:04PM -0800, ddaney.cavm@gmail.com wrote:
> From: David Daney <david.daney@cavium.com>
> 
> Get MAC address and PHY connection from the device tree.
> 
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: netdev@vger.kernel.org
> Cc: Greg Kroah-Hartman <gregkh@suse.de>

Acked-by: Greg Kroah-Hartman <gregkh@suse.de>

This usually goes through the MIPS tree, so I'll let Ralf take it.

thanks,

greg k-h

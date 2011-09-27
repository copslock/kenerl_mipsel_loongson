Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Sep 2011 02:53:13 +0200 (CEST)
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:52566 "EHLO
        out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492055Ab1I0AxF (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 27 Sep 2011 02:53:05 +0200
Received: from compute6.internal (compute6.nyi.mail.srv.osa [10.202.2.46])
        by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 5581C2A9FD;
        Mon, 26 Sep 2011 20:53:04 -0400 (EDT)
Received: from frontend1.nyi.mail.srv.osa ([10.202.2.160])
  by compute6.internal (MEProxy); Mon, 26 Sep 2011 20:53:04 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
        messagingengine.com; h=date:from:to:cc:subject:message-id
        :references:mime-version:content-type:in-reply-to; s=smtpout;
         bh=yH9gJEw+pngUpI7hHDojGaXrWBA=; b=aZhb/rxwU1VMdLvHNlLfxJ1CoH/B
        lZX1aMSj6cdU24/cb+rc+t2r0mb/dsWob8rXqRfsXG+CZ/wyZ/f9yLbGD4MSEP7r
        pYmHGM4N7jw2T9Ra4WPaz98SGD3IdPqrxVAeU2dD/cR8wGNdQPh1bb4aXFifeU3u
        KJa3jS8f/BGkbbM=
X-Sasl-enc: MZXT4gGfl5FddRGqol2Hq50u1HgI7kbHS9bpIW06eOX/ 1317084783
Received: from localhost (c-76-121-69-168.hsd1.wa.comcast.net [76.121.69.168])
        by mail.messagingengine.com (Postfix) with ESMTPSA id DB499540D8D;
        Mon, 26 Sep 2011 20:53:03 -0400 (EDT)
Date:   Mon, 26 Sep 2011 17:51:27 -0700
From:   Greg KH <greg@kroah.com>
To:     David Daney <david.daney@cavium.com>
Cc:     rongqing.li@windriver.com, netdev@vger.kernel.org,
        ralf@linux-mips.org, David Miller <davem@davemloft.net>,
        linux-mips@linux-mips.org
Subject: Re: [PATCH] staging/octeon: Software should check the checksum of no
 tcp/udp packets
Message-ID: <20110927005127.GB10447@kroah.com>
References: <1316999280-11999-1-git-send-email-rongqing.li@windriver.com>
 <4E80D794.3040701@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4E80D794.3040701@cavium.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 31169
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: greg@kroah.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 15092

On Mon, Sep 26, 2011 at 12:50:44PM -0700, David Daney wrote:
> On 09/25/2011 06:08 PM, rongqing.li@windriver.com wrote:
> >From: Roy.Li<rongqing.li@windriver.com>
> >
> >Icmp packets with wrong checksum are never dropped since
> >skb->ip_summed is set to CHECKSUM_UNNECESSARY.
> >
> >When icmp packets with wrong checksum pass through the octeon
> >net driver, the not_IP, IP_exc, L4_error hardware indicators
> >show no error. so the driver sets CHECKSUM_UNNECESSARY on
> >skb->ip_summed.
> >
> >L4_error only works for TCP/UDP, not for ICMP.
> >
> >Signed-off-by: Roy.Li<rongqing.li@windriver.com>
> 
> We found the same problem, but have not yet sent the patch to fix it.
> 
> This looks fine to me,
> 
> Acked-by: David Daney <david.daney@cavium.com>
> 
> I would let davem, Ralf and Greg KH fight over who gets to merge it.

I'll let Ralf take it, unless he wants me to.

Ralf?
